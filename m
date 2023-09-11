Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8240379B4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357771AbjIKWGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbjIKNgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:36:22 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C75125
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:36:17 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230911133616euoutp01ca661312202105edf82c995ae08d4f11~D26Ko4pMd2490624906euoutp01K
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:36:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230911133616euoutp01ca661312202105edf82c995ae08d4f11~D26Ko4pMd2490624906euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694439376;
        bh=pq/kPzrdSjU01Z636IhckK77P9sciHZtEKXMXxtJZQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYVL03MGhD1VtRR0P07h1qlUGoMRDpN0AKO3SwveQZhIGE9DjkPZYLlq69U5lXfrq
         BALQHY5tEr4HGFqsFgDpIsV3dqXtUTkqO8khHhyRAhecueuwREh5+yjyAMe/u+wVVI
         fhgfJRF1BUgh+HkbZP1opT/QgDEkZnUMhw1F1O58=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230911133616eucas1p2697a9b235b9a5b8c8e178c54b5c0f4cd~D26KMUhoE1710917109eucas1p20;
        Mon, 11 Sep 2023 13:36:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 78.B1.42423.FC71FF46; Mon, 11
        Sep 2023 14:36:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230911133615eucas1p123b3bed5bfa998bda65196d425f9b49d~D26J0kcQK1222512225eucas1p1u;
        Mon, 11 Sep 2023 13:36:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230911133615eusmtrp2ed989fffc1414750f73187076b5a049c~D26Jz3JM70862108621eusmtrp2k;
        Mon, 11 Sep 2023 13:36:15 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-60-64ff17cf1211
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B9.BB.10549.FC71FF46; Mon, 11
        Sep 2023 14:36:15 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230911133614eusmtip2b7efd7b129eb7cc246b92048d8b56b38~D26IXahex0323103231eusmtip2O;
        Mon, 11 Sep 2023 13:36:13 +0000 (GMT)
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
Subject: [PATCH v2 3/7] thermal: exynos: switch from workqueue-driven
 interrupt handling to threaded interrupts
Date:   Mon, 11 Sep 2023 15:34:27 +0200
Message-ID: <20230911133435.14061-4-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911133435.14061-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87rnxf+nGOycZW7xYN42NovD8yss
        pj58wmbxfct1Jot5n2Ut9r7eym7x7UoHk8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCwmHpvMbLH2
        yF12i7lfpjJbPHnYx+bA77Fz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9+rasYvT4vEkugD2K
        yyYlNSezLLVI3y6BK2PigwfMBT8lKna9im5gvCLSxcjJISFgIvGkq4+ti5GLQ0hgBaPEzlVd
        TBDOF0aJd5duMEI4nxklFjb9ZYVpufr1BFRiOaPElwk3WCCcViaJV0cnsoBUsQkYSDx4s4wd
        xBYRaGWUmNmkDlLELHCJWeLuzbVARRwcwgKFEttm6YPUsAioSryaOBdsA6+AjcT0k+dYILbJ
        Szy/dQdsDqeArcTZtdPZIWoEJU7OfAJWwwxU07x1NjPIfAmB/xwSX+fNZ4dodpFYu+so1CBh
        iVfHt0DFZST+75zPBGHnS8zY/B7sHgmBCom7B70gTGuJj2eYQUxmAU2J9bv0IYodJSY8O8YG
        UcEnceOtIMQBfBKTtk1nhgjzSnS0CUFUq0oc3zOJGcKWlnjSchtqpYfE0c/vWSYwKs5C8sos
        JK/MQti7gJF5FaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmAKO/3v+KcdjHNffdQ7xMjE
        wXiIUYKDWUmEt+TQ3xQh3pTEyqrUovz4otKc1OJDjNIcLErivNq2J5OFBNITS1KzU1MLUotg
        skwcnFINTJOWSUs39vlEVduk7H4at93SUXHa63lVLCnbsl7GyTTcdn5TviDCI92+80BSspIJ
        e6PBMmWj17l9Xh7+MtWKm+YvnNjhe5Bz7e7bx5nXbUi+sORw8sqD0elCXFLfpYxepTsc3/b1
        lZUwi8k0qXtnFDcoJ/76q7RATdbrczBL65HnOpOnv579PueH+S6f/4e6nhycMpfDT3BDh8OE
        2dpvTppMZOPn5lbxefuHreqqWJHqnOibFSdLeoSitfJdFlw60pw1/SKfbS93MNsa41z2Pn2T
        Xb0zcrJfP5t6uNjjmsSjl401Eoeub99y16Iv7ljR1I7/tnLbpNZc3GV2VVO4PNcqR7b08pfe
        2RbmZ7wLlViKMxINtZiLihMBBWrbAtADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xe7rnxf+nGHx9qWDxYN42NovD8yss
        pj58wmbxfct1Jot5n2Ut9r7eym7x7UoHk8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCwmHpvMbLH2
        yF12i7lfpjJbPHnYx+bA77Fz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9+rasYvT4vEkugD1K
        z6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PigwfM
        BT8lKna9im5gvCLSxcjJISFgInH16wnGLkYuDiGBpYwSszcsZ4FISEsc/jKFHcIWlvhzrYsN
        oqiZSWLKlRtgRWwCBhIP3ixjB0mICHQySnRtPscEkmAWuMUscf+1FogtLJAv8XnnE1YQm0VA
        VeLVxLlgNq+AjcT0k+egtslLPL91B2wbp4CtxNm104FsDqBtNhL9Z3QgygUlTs58wgIxXl6i
        eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGHHbjv3cvINx3quP
        eocYmTgYDzFKcDArifCWHPqbIsSbklhZlVqUH19UmpNafIjRFOjsicxSosn5wJjPK4k3NDMw
        NTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgip9dvP6kUs9s9vdOAoGRFhvi
        ltxQu6x9MnEG43f3g1VatR8muNatq3ed6Z0nz+UmJTbx2cXQyWWrXT7tEjohtO+F6rXJ9x7r
        FUUEL+1+GNBaVzyfd+K7o0EHoiwS/uf5SW/cfdEjq/PF49WpmwwO/5tkIj57N69ZnOeag6tN
        qs/ubXGYMONuxHOb6QV9C4Wn6Lqt05zOsufGRW2uMo4Udk4eKz7xY6vnnda4JHVnNd+67Zyc
        5syR8hvb4pxzNzq1VdnM9i3+F67Rv9Vc9sKMLX28f6QKPt9nqNh661NHl3dwlmOc05VT83xt
        hA8ulRJcWDf/tdU8OfUYSZY+Ce5nU9xa4xjj/6kmPnRKPi+rxFKckWioxVxUnAgA7Lfc0EED
        AAA=
X-CMS-MailID: 20230911133615eucas1p123b3bed5bfa998bda65196d425f9b49d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230911133615eucas1p123b3bed5bfa998bda65196d425f9b49d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230911133615eucas1p123b3bed5bfa998bda65196d425f9b49d
References: <20230911133435.14061-1-m.majewski2@samsung.com>
        <CGME20230911133615eucas1p123b3bed5bfa998bda65196d425f9b49d@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue boilerplate is mostly one-to-one what the threaded
interrupts do.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v1 -> v2: devm_request_threaded_irq call formatting change.

 drivers/thermal/samsung/exynos_tmu.c | 29 +++++++++-------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 90c33e8017af..ba9414b419ef 100644
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
2.41.0

