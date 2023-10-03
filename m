Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130277B679C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbjJCLRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbjJCLRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:17:15 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0D3A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:17:11 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231003111709euoutp028606bb1ddf279448b5cea75a1ce3e3b3~KlM_k25OQ1082210822euoutp02s
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:17:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231003111709euoutp028606bb1ddf279448b5cea75a1ce3e3b3~KlM_k25OQ1082210822euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696331829;
        bh=CCUmjPvJE2taTRrp0O0mccb79s4/56wbyFNyGnHqHRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hdgk0t288TFpR1FJtTet88IP1k8jyy4ZmQZvIR0sdSwoOqvfVz9slUUpdymDO12bM
         3wANaMwqSF9btZm4RMG0rV2c3GOiqz8pbGLda7AO57/N0P5Omv3osJEymEfJJuu2na
         Q6WyQb7WIHGLl0/G4+IGSZeeafUHIy7LPwkfNrZY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231003111708eucas1p220d81655676ed79d728ea5a48ab2000a~KlM_I96U70665806658eucas1p2K;
        Tue,  3 Oct 2023 11:17:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 75.14.11320.438FB156; Tue,  3
        Oct 2023 12:17:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111708eucas1p29eebdad45a2eae16148c9a5dbbcd47eb~KlM9ueQt_2873428734eucas1p2J;
        Tue,  3 Oct 2023 11:17:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231003111708eusmtrp1557c1b9222630af8ae63b55e44a6e735~KlM9ttFgI2246422464eusmtrp1Z;
        Tue,  3 Oct 2023 11:17:08 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-37-651bf8347486
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3A.D1.10549.438FB156; Tue,  3
        Oct 2023 12:17:08 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111707eusmtip27cb19697124906ee428f70d4b9f2ccf5~KlM874NuU2773227732eusmtip2e;
        Tue,  3 Oct 2023 11:17:07 +0000 (GMT)
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
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 3/8] thermal: exynos: switch from workqueue-driven
 interrupt handling to threaded interrupts
Date:   Tue,  3 Oct 2023 13:16:29 +0200
Message-ID: <20231003111638.241542-4-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003111638.241542-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djPc7omP6RTDd5f1LB4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB7F
        ZZOSmpNZllqkb5fAlfHkXCNjwR7Jil1H29kbGCeJdjFyckgImEjMOtLA0sXIxSEksIJRYsuq
        dkYI5wujRHv/FmYI5zOjxJHOvWwwLbuO/mGDSCxnlHjc84cVwmllkvi3dh8rSBWbgIHEgzfL
        2EFsEYFWRomZTeogRcwCl5gl7t5cywKSEBYolJj8ZivYWBYBVYmWFRfBGngFbCXajnSxQqyT
        l9iz6DsTiM0pYCex8udyJogaQYmTM5+AzWEGqmneOhvsVgmB/xwSG77MgLrVRWLenoNMELaw
        xKvjW9ghbBmJ05N7WCDsfIkZm98D2RxAdoXE3YNeEKa1xMczzCAms4CmxPpd+hDFjhL/dx6G
        KuaTuPFWEOIAPolJ26YzQ4R5JTrahCCqVSWO75nEDGFLSzxpuc0EUeIh0bLYZQKj4iwkn8xC
        8skshLULGJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBCax0/+Of9nBuPzVR71DjEwc
        jIcYJTiYlUR4w45KpQrxpiRWVqUW5ccXleakFh9ilOZgURLn1bY9mSwkkJ5YkpqdmlqQWgST
        ZeLglGpgKpeYdTHkadGCP3qKKrs3hvmLnP2ycvF8jTc9f1QPb9547G+vC3va6dzPIXO+rW21
        6d8VUVf9agHv0VI7p822plKr7N2UhaKvt/5xX7JgV/mZO3XfOvaUTp4s8uaH8cWQgtv23RUH
        LUXFTske/abgc0p31qmdH89ppG6c3j05UKd/Dv/pmjUrM1IXP0isb2VSeBm5uGHRa7kV8wUn
        FrQZeAtoJ9Xe3LJSP5ixTsLlYrevNaPwGXaW3E5etriH128eEZwsyS7TpLk3c196qMiHY7PP
        XFgZXtu6hTG/b8Z2V8X6s5YVZf0nrm74JKr7IpVzQzq/1MnPZffWy8RNCvjldM/D6uepy+FX
        OD6fNJgfosRSnJFoqMVcVJwIAHJcxCjRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7omP6RTDf738Fg8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouJxyYzW6w9
        cpfdYu6XqcwWTx72sTnwe+ycdZfdY/Gel0wem1Z1snncubaHzWPzknqPvi2rGD0+b5ILYI/S
        synKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy3hyrpGx
        YI9kxa6j7ewNjJNEuxg5OSQETCR2Hf3D1sXIxSEksJRR4vT1b6wQCWmJw1+msEPYwhJ/rnVB
        FTUzSfT37mQCSbAJGEg8eLOMHSQhItDJKNG1+RxYglngFrPE/ddaXYwcHMIC+RL/LqmChFkE
        VCVaVlwEG8orYCvRdqQLapm8xJ5F38FaOQXsJFb+XA5mCwHV3Fq+jwWiXlDi5MwnLBDj5SWa
        t85mnsAoMAtJahaS1AJGplWMIqmlxbnpucWGesWJucWleel6yfm5mxiBMbft2M/NOxjnvfqo
        d4iRiYPxEKMEB7OSCG/YUalUId6UxMqq1KL8+KLSnNTiQ4ymQHdPZJYSTc4HRn1eSbyhmYGp
        oYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAPTVLed7NcCbkqWTphyKNlkuku3
        l+TM++8ESsRb8378VCxS/3rxzmyBtLRPU7e88lheksMqy237dtK7F8/N7t5q9/8aaFxe+enN
        Lv1bHKcLHm6e+XquVg7zrWLvmE0bb00WilvxZxFLm+OilwKXc9bnlGwOOFHzKUUl5eEnoTt7
        FVl7LP07V7b3VhnaL3v54FukxrqzzeXhx5JXca4QFDt2+GPN4/2BKx/39Gxdo5PNdqvU7c+7
        vlf/I+tqb/uqzchL0pRo/uhv7HvyyTXOjTn/jixvKNSc+HZVyeyK0//MuJr69P95rFwR9POn
        GpOPafj9kC37tnTm6WccuPr5TMl/D2HPyQWmqz4yFLXdTph9U4mlOCPRUIu5qDgRANVJxE5C
        AwAA
X-CMS-MailID: 20231003111708eucas1p29eebdad45a2eae16148c9a5dbbcd47eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231003111708eucas1p29eebdad45a2eae16148c9a5dbbcd47eb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231003111708eucas1p29eebdad45a2eae16148c9a5dbbcd47eb
References: <20231003111638.241542-1-m.majewski2@samsung.com>
        <CGME20231003111708eucas1p29eebdad45a2eae16148c9a5dbbcd47eb@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 90c33e8017af..0e970638193d 100644
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

