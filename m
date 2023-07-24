Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F96B75E875
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjGXBlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjGXBko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:40:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828C046AC;
        Sun, 23 Jul 2023 18:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74C0360FD2;
        Mon, 24 Jul 2023 01:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D6AC433CA;
        Mon, 24 Jul 2023 01:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162375;
        bh=uGYXHYMmOR9x2PokzqhPPrYJHj9EyT3jcAB2LDclP98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hAE2Jt0ELynwtgkDPMqO3K0DEDzM/JCPHn4wzLvvdlzDvHyLBI7fXPjZmN27Q5Uel
         TXhvqpAn0wCa87dXrsovn/tiAtymxvMjrZx6sXJlFjQSejGJERFJx96F51ma1xexYc
         wNTKUcjB+1E0rXUtoFwhpIrMhAi1FgkqKJ3ZR99H6aShGEGrYDgGTd4AihL3UUHuHw
         utKU0Td1XwAyXzLO6METmwY663ZwriWFbprnk25VV6y7ACD1H43PZt8Ljkv8fCnZw3
         KLmfEKxhGLBR4NYEug+L+A2wyxmUi7HyJzkVpKuTamk9URfM7qc/qDPpOWbe9deFQh
         q4FMY8/yVMBnw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xu Yang <xu.yang_2@nxp.com>, Li Jun <jun.li@nxp.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, Peter.Chen@nxp.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/34] usb: chipidea: imx: add missing USB PHY DPDM wakeup setting
Date:   Sun, 23 Jul 2023 21:32:15 -0400
Message-Id: <20230724013238.2329166-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
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

