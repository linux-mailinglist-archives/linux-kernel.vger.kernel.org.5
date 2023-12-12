Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2FC80E601
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346209AbjLLIXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346062AbjLLIWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:22:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAC8F5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:22:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8611C2BCFE;
        Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702369325;
        bh=cItpiaed6CHjtfWMX5r54YQgAsVa3z6RG4hF/yvQPYs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=UMPBvyQJMLhyJ8VHFt2ODzBzOUeWN3LbLMJQ5PYgP7IndVopraetGRXGBuvwJCtOd
         AzguAXyxh24HOc0uZcPmuSYRATDF+6xHUkkn/VQ2B2YKOrC8M2Ufc4gCsretPrROoU
         aYFAXNXKfgUnifT7rFMfdWxfhHFddS3r/j4Fmppo2YojT3II6mbOK/oW088kgJuUo1
         lXczGdCecwoxNsX+9l1DXaQATtSRLHGUb/LIk2yi+JCeRQNTpitclk7FJEpElajHr9
         1QpSs8SzgUWtjx0LxZ74iBQzvQNE+WVwQLNefHA8evM+i202HsI1x9UcJKu8fB8wY/
         Pde8Dfn1bD9wg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id C83B8C4167D;
        Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Tue, 12 Dec 2023 11:20:43 +0300
Subject: [PATCH v6 26/40] wdt: ts72xx: add DT support for ts72xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-ep93xx-v6-26-c307b8ac9aa8@maquefel.me>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
In-Reply-To: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702369322; l=1074;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=qivA2YWGEli1TcieCOkZGWqUUq9ysPIVFCcdW9sMfp0=; =?utf-8?q?b=3DjR55+J56hZUC?=
 =?utf-8?q?HKMvY9Ahz66ui8eybOOk1MHTfYP17Klr7SImmZh8dlTG49XjO0eEc2gI5Hw6X5qJ?=
 xUkVnzi8DrouzAO5Pw/VmvBGblqaT+QPHuCQS9ytpXc4q8Zgnio9
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add OF ID match table.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/watchdog/ts72xx_wdt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 3d57670befe1..ac709dc31a65 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/watchdog.h>
 #include <linux/io.h>
@@ -160,10 +161,17 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ts72xx_wdt_of_ids[] = {
+	{ .compatible = "technologic,ts7200-wdt" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ts72xx_wdt_of_ids);
+
 static struct platform_driver ts72xx_wdt_driver = {
 	.probe		= ts72xx_wdt_probe,
 	.driver		= {
 		.name	= "ts72xx-wdt",
+		.of_match_table = ts72xx_wdt_of_ids,
 	},
 };
 

-- 
2.41.0

