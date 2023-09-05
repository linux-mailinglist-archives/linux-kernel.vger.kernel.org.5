Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB52792C12
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353595AbjIERGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354759AbjIEOHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:07:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40371A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:07:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500c63c9625so4308613e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1693922858; x=1694527658; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iAbMWGT5YKvgyZeI9ML3fVvXmxnZ59xnof4HH5lFrT0=;
        b=vhhKTUlYBEf8KXEgw3lk1GqSZIG4hXpHJvifJMRtcMeWYPMnP/hWfB0zhVVaZRV70N
         V4gMzhHfo17bE2MQa7Wk9jF7ZM77YmAdu2k91UKDycS63tv+0phTNXn72t4iJ8+o4b+6
         yBtV5ulBY7vazVNHxVTea0SA9Qn5iy1mKVGbA8leT8VI2MprHuzJMdtX8yYZqK79wvYt
         PsWM5Xm71oaFSttFLK+BSoh0Eg7qITlLtFAVw5v6CzUNpBiSAVQ2B0LaNWhnZfE1ngfP
         8wVr3QXKPFlEq0jjzwVz9aJag8crdkKyH+D5xbcMGmWQv8RK35nIxQa/Xg5S7eoG5PWt
         +/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693922858; x=1694527658;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAbMWGT5YKvgyZeI9ML3fVvXmxnZ59xnof4HH5lFrT0=;
        b=A1PhryN1GLJHKVvhaGVnfRKZ6TWcFIM8rMntZ/4Y5RlDaauUXCPryPoyPTiZeA0mMP
         jN5OzGJI/U52L7NyquTcvh31nlhLRhzIBOZMuNeR6fkk/lG2EhOJDJDBPlj37SM2TdFH
         3XS09uV31NtPXM2KNgqSIAblv24oHs3Q2R5B/ziYnO7mh59qryUjnHZck91co58U09l0
         L95pH7CFwz/V/TACLp/AeZoGbYulBTOAEEccY1BIIK+gLrGiTsvaf7CP2ZqGmkN2ZuCt
         tQNtj+2YPL2o7xLmA7JY8YS3jQeLHTh+lV8x0BfRwZMPbnbo5IiBteTVGwoo+0NYtEJm
         o8wg==
X-Gm-Message-State: AOJu0Yxd0szXrH7/4FemgyYDs4GdwfJ5pvOtOAkuyPmABSZ1xAahbv5j
        FLrFQQ91AvrGaiaVDTnPeSaHyw==
X-Google-Smtp-Source: AGHT+IFSVjTm7ZrO3NeGlfqLpx3B9hLTXvmgWHioUcoPOtejX8IkvEA1LRIWSqy+3uvaYrrwEwWJEw==
X-Received: by 2002:a05:6512:4005:b0:500:bffa:5b86 with SMTP id br5-20020a056512400500b00500bffa5b86mr10652186lfb.6.1693922857788;
        Tue, 05 Sep 2023 07:07:37 -0700 (PDT)
Received: from [127.0.1.1] ([85.68.201.192])
        by smtp.gmail.com with ESMTPSA id a2-20020adff7c2000000b003177074f830sm17617239wrq.59.2023.09.05.07.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 07:07:37 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
Date:   Tue, 05 Sep 2023 16:07:34 +0200
Subject: [PATCH] regulator: tps6594-regulator: Fix random kernel crash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-tps6594_random_boot_crash_fix-v1-1-f29cbf9ddb37@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACY292QC/x2OUQrCMBAFr1LybTCm1dReRSRsmo1dsEnZLSKU3
 t3Uz4F5w9uUIBOKGppNMX5IqOQKl1OjxgnyCzXFysoa25re9npd5Ha9d54hxzL7UMrqRwaZfKK
 vTq4DkyK61hlVGwEEdajuOB2VGSi/KeN5BlmRD2NhrMP/g8dz33/u9MltkQAAAA==
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Esteban Blanc <eblanc@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, u-kumar1@ti.com, jpanis@baylibre.com,
        khilman@baylibre.com, s.sharma@ti.com, aseketeli@baylibre.com,
        Jerome Neanne <jneanne@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693922857; l=3254;
 i=jneanne@baylibre.com; s=20230511; h=from:subject:message-id;
 bh=CHIa+Z8rM52FfhpakBheBiw1hnuHCRMmo3h835NJgHg=;
 b=LsSWC8HcosT0dzJLPdifSuV6XggNoku+YfhsWvQXzGQJ6A2M4yrChwgvrts99byziKIr0cD2h
 DaAAhN9tZfTB5nYWRukslpr8yF5pjHAIIq6h99LboNwgT5JYPKcIs2G
X-Developer-Key: i=jneanne@baylibre.com; a=ed25519;
 pk=5rvbqNoG+28jQjC9/50ToY7TgKWf9rJukuCI8b6jkUo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Random kernel crash detected in TI CICD when regulator driver is added.
This is root caused to irq index increment being done twice causing
irq_data being allocated outside of the range.

- Rework tps6594_request_reg_irqs with correct index increment
- Adjust irq_data kmalloc size to the exact size needed for the device

This has been reported on TI mainline. No public bug report associated.

Reported-by: Udit Kumar <u-kumar1@ti.com>
Fixes: f17ccc5deb4d ("regulator: tps6594-regulator: Add driver for TI TPS6594 regulators")
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
Random kernel crash detected in TI CICD when regulator driver is added.
This is root caused to irq index increment being done twice causing
irq_data being allocated outside of the range.
---
 drivers/regulator/tps6594-regulator.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index d5a574ec6d12..47c3b7efe145 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -384,21 +384,19 @@ static int tps6594_request_reg_irqs(struct platform_device *pdev,
 		if (irq < 0)
 			return -EINVAL;
 
-		irq_data[*irq_idx + j].dev = tps->dev;
-		irq_data[*irq_idx + j].type = irq_type;
-		irq_data[*irq_idx + j].rdev = rdev;
+		irq_data[*irq_idx].dev = tps->dev;
+		irq_data[*irq_idx].type = irq_type;
+		irq_data[*irq_idx].rdev = rdev;
 
 		error = devm_request_threaded_irq(tps->dev, irq, NULL,
-						  tps6594_regulator_irq_handler,
-						  IRQF_ONESHOT,
-						  irq_type->irq_name,
-						  &irq_data[*irq_idx]);
-		(*irq_idx)++;
+						  tps6594_regulator_irq_handler, IRQF_ONESHOT,
+						  irq_type->irq_name, &irq_data[*irq_idx]);
 		if (error) {
 			dev_err(tps->dev, "tps6594 failed to request %s IRQ %d: %d\n",
 				irq_type->irq_name, irq, error);
 			return error;
 		}
+		(*irq_idx)++;
 	}
 	return 0;
 }
@@ -420,8 +418,8 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 	int error, i, irq, multi, delta;
 	int irq_idx = 0;
 	int buck_idx = 0;
-	int ext_reg_irq_nb = 2;
-
+	size_t ext_reg_irq_nb = 2;
+	size_t reg_irq_nb;
 	enum {
 		MULTI_BUCK12,
 		MULTI_BUCK123,
@@ -484,15 +482,16 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (tps->chip_id == LP8764)
+	if (tps->chip_id == LP8764) {
 		/* There is only 4 buck on LP8764 */
 		buck_configured[4] = 1;
+		reg_irq_nb = size_mul(REGS_INT_NB, (BUCK_NB - 1));
+	} else {
+		reg_irq_nb = size_mul(REGS_INT_NB, (size_add(BUCK_NB, LDO_NB)));
+	}
 
-	irq_data = devm_kmalloc_array(tps->dev,
-				REGS_INT_NB * sizeof(struct tps6594_regulator_irq_data),
-				ARRAY_SIZE(tps6594_bucks_irq_types) +
-				ARRAY_SIZE(tps6594_ldos_irq_types),
-				GFP_KERNEL);
+	irq_data = devm_kmalloc_array(tps->dev, reg_irq_nb,
+				      sizeof(struct tps6594_regulator_irq_data), GFP_KERNEL);
 	if (!irq_data)
 		return -ENOMEM;
 

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230828-tps6594_random_boot_crash_fix-f74a0fde7370

Best regards,
-- 
Jerome Neanne <jneanne@baylibre.com>

