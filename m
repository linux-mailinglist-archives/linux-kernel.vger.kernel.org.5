Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D8F783EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjHVLb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjHVLb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:31:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCD8E58;
        Tue, 22 Aug 2023 04:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EDC26526E;
        Tue, 22 Aug 2023 11:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23605C4339A;
        Tue, 22 Aug 2023 11:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692703884;
        bh=XlJfA9ySG52e4Ctt0JGVhhaPUI4zJcZCI8VS+UElmJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rlo/JbQ7/L7HPoa5812KUTTLr8WuRJtS4benojgMofSmW7wiQZGU5Kpr2qFa8P64L
         mRdZe9NR9QeU5POrcWpS3orzbL3snn/8X6IGyKhbXApIERB2LhcASKsuyvumCK4rH/
         DCn1GwpWK5To1OM7+nNKL9WBKQbV/l+bnkClA33aEhJBJGHZcgHb3L7/XdL7LA3RDB
         LgKS4bveg9sIh5YTYsiE3wainfVkn3EmIwajCOVVZKrSqJnLG1WqQdGcn8fr3upF/1
         5ic4zUmo4dv+2g6jub9lthlqpfhRNX0On2MPg01fKid//Yjo8huk8XKt3aqPB5UPNX
         WQjgR4tLB63JA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        aspriel@gmail.com, hante.meuleman@broadcom.com,
        linus.walleij@linaro.org, marcan@marcan.st, gustavoars@kernel.org,
        ryohei.kondo@cypress.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH AUTOSEL 6.4 08/10] wifi: brcmfmac: Fix field-spanning write in brcmf_scan_params_v2_to_v1()
Date:   Tue, 22 Aug 2023 07:30:58 -0400
Message-Id: <20230822113101.3549915-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113101.3549915-1-sashal@kernel.org>
References: <20230822113101.3549915-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 16e455a465fca91907af0108f3d013150386df30 ]

Using brcmfmac with 6.5-rc3 on a brcmfmac43241b4-sdio triggers
a backtrace caused by the following field-spanning warning:

memcpy: detected field-spanning write (size 120) of single field
  "&params_le->channel_list[0]" at
  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1072 (size 2)

The driver still works after this warning. The warning was introduced by the
new field-spanning write checks which were enabled recently.

Fix this by replacing the channel_list[1] declaration at the end of
the struct with a flexible array declaration.

Most users of struct brcmf_scan_params_le calculate the size to alloc
using the size of the non flex-array part of the struct + needed extra
space, so they do not care about sizeof(struct brcmf_scan_params_le).

brcmf_notify_escan_complete() however uses the struct on the stack,
expecting there to be room for at least 1 entry in the channel-list
to store the special -1 abort channel-id.

To make this work use an anonymous union with a padding member
added + the actual channel_list flexible array.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230729140500.27892-1-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h  | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index 792adaf880b44..bece26741d3a3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -398,7 +398,12 @@ struct brcmf_scan_params_le {
 				 * fixed parameter portion is assumed, otherwise
 				 * ssid in the fixed portion is ignored
 				 */
-	__le16 channel_list[1];	/* list of chanspecs */
+	union {
+		__le16 padding;	/* Reserve space for at least 1 entry for abort
+				 * which uses an on stack brcmf_scan_params_le
+				 */
+		DECLARE_FLEX_ARRAY(__le16, channel_list);	/* chanspecs */
+	};
 };
 
 struct brcmf_scan_params_v2_le {
-- 
2.40.1

