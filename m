Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0998007A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378143AbjLAJ4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378093AbjLAJ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:56:39 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8ED170F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:56:45 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231201095643euoutp023368351c7743ec931a27dd1f16061e0b~crKmsq2f80607506075euoutp028
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:56:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231201095643euoutp023368351c7743ec931a27dd1f16061e0b~crKmsq2f80607506075euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701424604;
        bh=z+drqHSTXutvqyghqqSngnAvaJMAvU0O0c1Ke0HntPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3HjacCitpbsvAAArshg5c4PSE7wFI7byH4NgQMIp/wHpp3stCE6RPypJpEqe0JiW
         vXixjGjf3o/v9S5+LtskZXXaEGm+u8NfBzfxDxYwRBbDhw135lOWZ8h/mtmlphNb/R
         RAxgi6IxMobMRSpfabJiSxHN+0EhYTiGnImaHy/Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231201095643eucas1p248111e49847cdb4b7ffd5e7933f55425~crKmTenTx2503225032eucas1p2K;
        Fri,  1 Dec 2023 09:56:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C4.FF.09552.BDDA9656; Fri,  1
        Dec 2023 09:56:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231201095642eucas1p13b5699805523f9afcf6d4034e1b838b2~crKlwCaxA0245502455eucas1p1G;
        Fri,  1 Dec 2023 09:56:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231201095642eusmtrp1f90b9537441ea0e19c34183c6f809ffa~crKlvZNCU0736407364eusmtrp15;
        Fri,  1 Dec 2023 09:56:42 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-83-6569addba546
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 66.20.09146.ADDA9656; Fri,  1
        Dec 2023 09:56:42 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231201095641eusmtip2eb358f372ab5769c2c5640d3ac5e896a~crKk2NVYP1302313023eusmtip2T;
        Fri,  1 Dec 2023 09:56:41 +0000 (GMT)
From:   Mateusz Majewski <m.majewski2@samsung.com>
To:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Majewski <m.majewski2@samsung.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v6 3/9] thermal: exynos: switch from workqueue-driven
 interrupt handling to threaded interrupts
Date:   Fri,  1 Dec 2023 10:56:19 +0100
Message-ID: <20231201095625.301884-4-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201095625.301884-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djPc7q312amGvzaJWXxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4Mr4NOk4U8EeyYrJz56wNTBOEu1i5OSQEDCR
        2NP4namLkYtDSGAFo8TEK21QzhdGiY2NT1kgnM+MEjN39THDtEz9OQuqajmjRPv+8+wQTiuT
        RMPch4wgVWwCBhIP3ixjB7FFBFqB2pvUQWxmgYUsEi3/ckFsYYFCiffvl4JNZRFQlejrmcwC
        YvMK2EpM/HaIFWKbvMSeRSAHcnJwCthJzD/UClUjKHFy5hMWiJnyEs1bZzODHCEhMJ1T4u+0
        1WwQzS4SJ28cZ4SwhSVeHd/CDmHLSJye3MMCYedLzNj8HsjmALIrJO4e9IIwrSU+nmEGMZkF
        NCXW79KHKHaUmHinhwmigk/ixltBiAP4JCZtm84MEeaV6GgTgqhWlTi+ZxI01KQlnrTcZoKw
        PSSmrTjHMoFRcRaSV2YheWUWwt4FjMyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAlPc
        6X/Hv+5gXPHqo94hRiYOxkOMEhzMSiK815+mpwrxpiRWVqUW5ccXleakFh9ilOZgURLnVU2R
        TxUSSE8sSc1OTS1ILYLJMnFwSjUwmU1IdFua+lWi57/lvPtKPyU5dG5kXPb8UevhEZTArjnh
        7zyxWuEn6R93bJ8wNWTipEMJhx6wzJ82a1aThI2nk+HL2ewlrR07F076Fs1d8Lvyz7IkrRM9
        aQlWqvlfr+YwybPc9WAxy0vzvN/HOHm+546TJQ9u7IsIrmA9sONKdHvvrtAvh+bP2mbulBB1
        ZaKMuWqdVslieX97Efdtxp7mrzPm/P+nlCZj4DpFevv3/tf+ry55X2S2Ocisoa0+JcrqI9+z
        /+rrtkkK7vjqPEUxN49Z/j+/1JaugzN/X7d/G62gE7/+fuesBzqqsmr88qlMPRfci++Izqy8
        p7mlrsPw8es5upPOXnL1yzw1i+u1EktxRqKhFnNRcSIALBCMB+ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xe7q31mamGkxfZWbxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0Mv4NOk4U8EeyYrJz56wNTBOEu1i5OSQEDCRmPpzFlMXIxeHkMBSRonFZ/ey
        QCSkJQ5/mcIOYQtL/LnWxQZR1MwkMWHhUbAEm4CBxIM3y9hBEiICnYwSXZvPgY1iFljNInFs
        33cmkCphgXyJO1va2UBsFgFVib6eyWAreAVsJSZ+O8QKsUJeYs8iiHpOATuJ+YdawWqEgGq6
        tvxnhKgXlDg58wlYnBmovnnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55bbKhXnJhbXJqXrpec
        n7uJERiV24793LyDcd6rj3qHGJk4GA8xSnAwK4nwXn+anirEm5JYWZValB9fVJqTWnyI0RTo
        7onMUqLJ+cC0kFcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwFRg
        4Sf8/3H7o0o5xaaDoYUV9xdIv9yb+cf+27srx2o/frl1dUb8/rv7Kz8/PVOZVvT2tG9T+HoB
        YZWjejPKJ/ExiL6VqPY/vDZ1d0jv28fSu7WjZJp+5r5l2l4XtjhzEZsr8/XOvVt8IljfbJTP
        WFqj3fPs1KsPxo1f1NW43QXCal/+mPHigYXx7mWFD8z/WUycemulWd32KXdDOmS3zBd0aprB
        8X59xaGj1bK7OFi23NJ2fpt8ct6ZAxu/W346+m+1TrjUhWwr+4Cqzg3LjvyeVnnvUfjCk4I5
        rIe/3pzMp71SoWtWbEn7uvYClnXiB/kKojgeKa3I5HTi+CHBqHMmLVXL/s+F5A1qU7aHLzFS
        YinOSDTUYi4qTgQAK7MZXlMDAAA=
X-CMS-MailID: 20231201095642eucas1p13b5699805523f9afcf6d4034e1b838b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231201095642eucas1p13b5699805523f9afcf6d4034e1b838b2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231201095642eucas1p13b5699805523f9afcf6d4034e1b838b2
References: <20231201095625.301884-1-m.majewski2@samsung.com>
        <CGME20231201095642eucas1p13b5699805523f9afcf6d4034e1b838b2@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue boilerplate is mostly one-to-one what the threaded
interrupts do.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v1 -> v2: devm_request_threaded_irq call formatting change.

 drivers/thermal/samsung/exynos_tmu.c | 29 +++++++++-------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 4ff32245d2a9..c144592d4584 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -142,7 +142,6 @@ enum soc_type {
  * @base_second: base address of the common registers of the TMU controller.
  * @irq: irq number of the TMU controller.
  * @soc: id of the SOC type.
- * @irq_work: pointer to the irq work structure.
  * @lock: lock to implement synchronization.
  * @clk: pointer to the clock structure.
  * @clk_sec: pointer to the clock structure for accessing the base_second.
@@ -175,7 +174,6 @@ struct exynos_tmu_data {
 	void __iomem *base_second;
 	int irq;
 	enum soc_type soc;
-	struct work_struct irq_work;
 	struct mutex lock;
 	struct clk *clk, *clk_sec, *sclk;
 	u32 cal_type;
@@ -763,10 +761,9 @@ static int exynos7_tmu_read(struct exynos_tmu_data *data)
 		EXYNOS7_TMU_TEMP_MASK;
 }
 
-static void exynos_tmu_work(struct work_struct *work)
+static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 {
-	struct exynos_tmu_data *data = container_of(work,
-			struct exynos_tmu_data, irq_work);
+	struct exynos_tmu_data *data = id;
 
 	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
 
@@ -778,7 +775,8 @@ static void exynos_tmu_work(struct work_struct *work)
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
-	enable_irq(data->irq);
+
+	return IRQ_HANDLED;
 }
 
 static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
@@ -812,16 +810,6 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 	writel(val_irq, data->base + tmu_intclear);
 }
 
-static irqreturn_t exynos_tmu_irq(int irq, void *id)
-{
-	struct exynos_tmu_data *data = id;
-
-	disable_irq_nosync(irq);
-	schedule_work(&data->irq_work);
-
-	return IRQ_HANDLED;
-}
-
 static const struct of_device_id exynos_tmu_match[] = {
 	{
 		.compatible = "samsung,exynos3250-tmu",
@@ -1023,8 +1011,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_sensor;
 
-	INIT_WORK(&data->irq_work, exynos_tmu_work);
-
 	data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
 	if (IS_ERR(data->clk)) {
 		dev_err(&pdev->dev, "Failed to get clock\n");
@@ -1093,8 +1079,11 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_sclk;
 	}
 
-	ret = devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
-		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
+	ret = devm_request_threaded_irq(&pdev->dev, data->irq, NULL,
+					exynos_tmu_threaded_irq,
+					IRQF_TRIGGER_RISING
+						| IRQF_SHARED | IRQF_ONESHOT,
+					dev_name(&pdev->dev), data);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
 		goto err_sclk;
-- 
2.42.0

