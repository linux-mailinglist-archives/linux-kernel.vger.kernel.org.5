Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E9280BC70
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 18:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjLJRsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 12:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJRsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 12:48:18 -0500
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29286FC
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 09:48:24 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id CNudrI7QgoJwrCNudrE128; Sun, 10 Dec 2023 18:48:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702230502;
        bh=lBPdDjemhVHEdTvges9UmlJ1LQEDyrXReCC0qW2qybY=;
        h=From:To:Cc:Subject:Date;
        b=mFSnB5pAeg6rY7xHcKVfo6rQQienz7/0t99YSnk1T24Rxu1Mw4XoHgC8qg/Cct1XM
         EHjZ5X1GahrP32evCuHkKA9dXUBkaNdeZ0Y1/gksOdZ7YYS+sGWCg4GGszn3WHtuNS
         eg1r7SxuEzS7I+auiD0fp/imJyUL8h8MUJP2NlX4fyjyosQFVehOY3yLlIdj36iLSz
         0wXoOvr8P7NmIvZU8bfMWKqxkje1GOjlbD4bTJ97JuN6qCLpOYmBIEi6LfPE2cUMkQ
         cF1A1w73kvWvcy5pqNIuUUbOLBCdUWEdgTquZT5ycAw60uZHm/UyC/84ZXU0HKm9D9
         fKo20h/TJaBPA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Dec 2023 18:48:22 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] drivers/perf: Remove usage of the deprecated ida_simple_xx() API
Date:   Sun, 10 Dec 2023 18:48:18 +0100
Message-Id: <85b0b73a1b2f743dd5db15d4765c7685100de27f.1702230488.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/perf/fsl_imx9_ddr_perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 5cf770a1bc31..9685645bfe04 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -617,7 +617,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pmu);
 
-	pmu->id = ida_simple_get(&ddr_ida, 0, 0, GFP_KERNEL);
+	pmu->id = ida_alloc(&ddr_ida, GFP_KERNEL);
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME "%d", pmu->id);
 	if (!name) {
 		ret = -ENOMEM;
@@ -674,7 +674,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	cpuhp_remove_multi_state(pmu->cpuhp_state);
 cpuhp_state_err:
 format_string_err:
-	ida_simple_remove(&ddr_ida, pmu->id);
+	ida_free(&ddr_ida, pmu->id);
 	dev_warn(&pdev->dev, "i.MX9 DDR Perf PMU failed (%d), disabled\n", ret);
 	return ret;
 }
@@ -688,7 +688,7 @@ static int ddr_perf_remove(struct platform_device *pdev)
 
 	perf_pmu_unregister(&pmu->pmu);
 
-	ida_simple_remove(&ddr_ida, pmu->id);
+	ida_free(&ddr_ida, pmu->id);
 
 	return 0;
 }
-- 
2.34.1

