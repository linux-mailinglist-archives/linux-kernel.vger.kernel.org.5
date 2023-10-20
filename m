Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AA57D1031
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377390AbjJTNCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377017AbjJTNCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:02:39 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BBF9F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:02:37 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 053FB1C0003;
        Fri, 20 Oct 2023 13:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697806955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aJ6lRyFte6SRxSGEWtH+fbG11URdig+4dlQW94H/x40=;
        b=DZFiaH9LfsR73LdWPiZxQehtQXehHaOPqtXb9iG+kDPTFhhm8/pS8En77JZZuo/UDf/haU
        4IAAk+ea9lRKa3CrSszt+/gEM+z1o12tnjyxDmvZH5VAZzBbsMmOcGPQL56aB1zYRMgHW+
        QUxdZBc2x3/R8LNakSRiqthHKWgzQzPtG86VqAmeDZLE0YMh9jmchi7vKeOwP0SOLkpYLZ
        p6mHh7nm9gcsomijwcbkeesbPfwOYZguFbSCJr/AM73QSe68tQ4iO4+g0QuRr8o/jT++NH
        xg86+j5lcjls9zHYdqMbtxntOkO34LD7llugO9MFemyBPkhJhb/5NhTQMi5ytg==
From:   thomas.perrot@bootlin.com
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clement.leger@bootlin.com,
        Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [PATCH] ARM: at91: pm: set soc_pm.data.mode in at91_pm_secure_init()
Date:   Fri, 20 Oct 2023 15:02:19 +0200
Message-ID: <20231020130219.1255937-1-thomas.perrot@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.perrot@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Perrot <thomas.perrot@bootlin.com>

In non secure mode, soc_pm.data.mode is set when entering pm in
at91_pm_begin(). This value is used (not only) to determine if the system
is going into slow clock mode (at91_suspend_entering_slow_clock()). This
function is called from various drivers to check this and act accordingly.
If not set, the driver might enter an incorrect suspend mode. When using
secure suspend mode, at91_pm_begin() is not called and thus
soc_pm.data.mode is not set. Since when using secure suspend, only one
suspend mode is supported, set this value directly in
at91_pm_secure_init().

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 arch/arm/mach-at91/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 1a26af0fabc7..345b91dc6627 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -1103,6 +1103,7 @@ static void __init at91_pm_secure_init(void)
 	if (res.a0 == 0) {
 		pr_info("AT91: Secure PM: suspend mode set to %s\n",
 			pm_modes[suspend_mode].pattern);
+		soc_pm.data.mode = suspend_mode;
 		return;
 	}
 
@@ -1112,6 +1113,7 @@ static void __init at91_pm_secure_init(void)
 	res = sam_smccc_call(SAMA5_SMC_SIP_GET_SUSPEND_MODE, 0, 0);
 	if (res.a0 == 0) {
 		pr_warn("AT91: Secure PM: failed to get default mode\n");
+		soc_pm.data.mode = -1;
 		return;
 	}
 
@@ -1119,6 +1121,7 @@ static void __init at91_pm_secure_init(void)
 		pm_modes[suspend_mode].pattern);
 
 	soc_pm.data.suspend_mode = res.a1;
+	soc_pm.data.mode = soc_pm.data.suspend_mode;
 }
 static const struct of_device_id atmel_shdwc_ids[] = {
 	{ .compatible = "atmel,sama5d2-shdwc" },
-- 
2.41.0

