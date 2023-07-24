Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039C275E8E5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjGXBpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjGXBnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:43:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D72959C1;
        Sun, 23 Jul 2023 18:37:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61A9F61000;
        Mon, 24 Jul 2023 01:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF372C433C9;
        Mon, 24 Jul 2023 01:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162419;
        bh=uGYXHYMmOR9x2PokzqhPPrYJHj9EyT3jcAB2LDclP98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bc8P+UvAcEVbBlolEmjrH2ZskVhVUf6+C68vGteGajNVGXztAkXOe4DUh3KeII6QX
         aBA3KXf8uJLHFuMAccI37mzsI4rm2wZHRoa6TQ/XfPbzTWcrYc5x8SeE6eUDULDaEL
         TO3gwUSFR5146C8uttwBj9L6e28f6WXNxJ1FS9NOS9ORYrMu/6RUtfwJBXXsu6cnd0
         JsgcqNFqAAwTgDF9KurHEyXBPf21to2Ko6S+KAdaGYQoGytWyzDfrRh1zHoZSfCi1U
         uQdUmOwyor2v+cZg+XtkO2adJFqeZGhTXmMKDi5Nmq5K37rv9ORdQMwtk1Icn2SFTP
         xXWwEoBxE91xg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xu Yang <xu.yang_2@nxp.com>, Li Jun <jun.li@nxp.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, Peter.Chen@nxp.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 09/24] usb: chipidea: imx: add missing USB PHY DPDM wakeup setting
Date:   Sun, 23 Jul 2023 21:33:10 -0400
Message-Id: <20230724013325.2332084-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013325.2332084-1-sashal@kernel.org>
References: <20230724013325.2332084-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.121
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 53d061c19dc4cb68409df6dc11c40389c8c42a75 ]

USB PHY DPDM wakeup bit is enabled by default, when USB wakeup
is not required(/sys/.../wakeup is disabled), this bit should be
disabled, otherwise we will have unexpected wakeup if do USB device
connect/disconnect while system sleep.
This bit can be enabled for both host and device mode.

Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Message-ID: <20230517081907.3410465-3-xu.yang_2@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/usbmisc_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index bac0f5458cab9..2318c7906acdb 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -135,7 +135,7 @@
 #define TXVREFTUNE0_MASK		(0xf << 20)
 
 #define MX6_USB_OTG_WAKEUP_BITS (MX6_BM_WAKEUP_ENABLE | MX6_BM_VBUS_WAKEUP | \
-				 MX6_BM_ID_WAKEUP)
+				 MX6_BM_ID_WAKEUP | MX6SX_BM_DPDM_WAKEUP_EN)
 
 struct usbmisc_ops {
 	/* It's called once when probe a usb device */
-- 
2.39.2

