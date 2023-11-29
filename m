Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2287FD77D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjK2NFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjK2NFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:05:38 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83137C4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=IkbXYYCz2LSe8ie1tt
        L3ic9jKm3muYQjSXnx4yksqVs=; b=aPCPIVBQuPWZTWa3mwWVMBcM6Xna/LBH6F
        uRyQB+emE2kLoE6l4S0/Gng2O8S9b3VmNXkjJ3Ruxg8GD+YGFrR/OmnBloIKUoJE
        6I0IrT3I2vG0Hgfqy0D+CC0uI39wXNHw+uxuJq2DxTtRxY9OH2Q/ut6TKgmTmNf4
        RoiK9TCL8=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g3-3 (Coremail) with SMTP id _____wDXX30cN2dlg9EsCw--.45271S2;
        Wed, 29 Nov 2023 21:05:33 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [regulator] pwm-regulator: Add error handling
Date:   Wed, 29 Nov 2023 05:05:30 -0800
Message-Id: <20231129130530.33744-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDXX30cN2dlg9EsCw--.45271S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4xGw4ftF4UZF1fJr18Zrb_yoW8AFyDpF
        W5JFsIkr48tFWxZr1UuryxAa4Yvry8KFZ7KFWxG3ySvr45Z3ZrXrs8CF1YyFWxKrs7Aa1Y
        vay0qF10kF4DuFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piTKZDUUUUU=
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiZR43gl8ZaQ6+uwAAsq
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enhances the pwm_regulator_init_continuous function
in drivers/regulator/pwm-regulator.c by adding error handling
for of_property_read_u32_array and of_property_read_u32 calls.
Previously, the function did not properly handle failures from
these of_property_read functions, potentially leading to
incorrect behavior if the required DT properties were not found
or were malformed.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/regulator/pwm-regulator.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 2aff6db748e2..8eb142180ddb 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -296,11 +296,23 @@ static int pwm_regulator_init_continuous(struct platform_device *pdev,
 	drvdata->desc.ops = &pwm_regulator_voltage_continuous_ops;
 	drvdata->desc.continuous_voltage_range = true;
 
-	of_property_read_u32_array(pdev->dev.of_node,
-				   "pwm-dutycycle-range",
-				   dutycycle_range, 2);
-	of_property_read_u32(pdev->dev.of_node, "pwm-dutycycle-unit",
-			     &dutycycle_unit);
+	ret = of_property_read_u32_array(pdev->dev.of_node,
+					"pwm-dutycycle-range",
+					dutycycle_range, 2);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to read pwm-dutycycle-range: %d\n", ret);
+		return ret;
+	}
+
+	ret = of_property_read_u32(pdev->dev.of_node,
+					"pwm-dutycycle-unit",
+					&dutycycle_unit);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to read pwm-dutycycle-unit: %d\n", ret);
+		return ret;
+	}
 
 	if (dutycycle_range[0] > dutycycle_unit ||
 	    dutycycle_range[1] > dutycycle_unit)
-- 
2.17.1

