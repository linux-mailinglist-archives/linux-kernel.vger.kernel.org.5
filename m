Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BA3783F24
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjHVLdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjHVLdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4489CCE5;
        Tue, 22 Aug 2023 04:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC3D3652B0;
        Tue, 22 Aug 2023 11:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BF2C433CD;
        Tue, 22 Aug 2023 11:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692703926;
        bh=cQQP93pCqfIpCatT+nrXX0wWji5PDwUEE+2OWYZLudg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eFZ9GUpBMxN+mSfoWwtMtcCGQvl1er6qT9rRtS+iA3M+3BMlVQNENxl56G3Fa6MaL
         ERjymyltbagg/2xY6Aj6i7J36gLXOyiw7DO1PiKsATodEVhqS+mBALm6mnKeXe0u+H
         pNsFuVA6Fk0rIfJYWYz0QGUcS1EdAGQeMcCS2hUa9r7uL94iInxNzLDWb9eDmTNuuc
         izqopVYJk8vHnGn4KBsL5x59pCXzYzI9apg3EBJ+V0QdyE5xtsHHvb2xmwxS+GQXzY
         X9eavC9Aku8ninMsE7IAplDdAPGFwdPVtZpdPgdNUaa5DqJ/lcttTrxrF/085568hO
         mcK5N/rv/Wp0w==
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
Subject: [PATCH AUTOSEL 5.15 4/4] wifi: brcmfmac: Fix field-spanning write in brcmf_scan_params_v2_to_v1()
Date:   Tue, 22 Aug 2023 07:31:55 -0400
Message-Id: <20230822113155.3550176-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113155.3550176-1-sashal@kernel.org>
References: <20230822113155.3550176-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.127
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
index ff2ef557f0ead..2a1590cc73ab2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -383,7 +383,12 @@ struct brcmf_scan_params_le {
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
 
 struct brcmf_scan_results {
-- 
2.40.1

