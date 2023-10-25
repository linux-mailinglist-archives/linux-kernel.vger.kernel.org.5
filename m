Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6C07D6D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344670AbjJYNbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344553AbjJYNaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:30:55 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729AEB4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:30:53 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231025133052euoutp02d64c7a8d8d246dad309def44bbcae2c1~RXOAnOhLV1109011090euoutp021
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:30:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231025133052euoutp02d64c7a8d8d246dad309def44bbcae2c1~RXOAnOhLV1109011090euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698240652;
        bh=z+drqHSTXutvqyghqqSngnAvaJMAvU0O0c1Ke0HntPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sdoefb5rzBYfu4joDNDMvr+PxZzL2AfdlPG4l4lpjYuUwXOhfGRAdnbJYpW163kG5
         4MVlRu4XLcVsOhoaTsIKWNF9+1Ce/hT5Ref9pfJCatBMfaPjHOHyPa4Q/ulw8RQkUL
         7Mvq1qoH5Yc5VhIn/yyci0oS+Ben0XxhpAPPb2n4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231025133051eucas1p15e5c88bdda3a341b45c84fc259234b93~RXOAOQyhN1623816238eucas1p1N;
        Wed, 25 Oct 2023 13:30:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 99.0B.37758.B8819356; Wed, 25
        Oct 2023 14:30:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231025133051eucas1p1e9ed4202abb45c5d2f738fdd213503ee~RXN-j3CTt1436614366eucas1p1p;
        Wed, 25 Oct 2023 13:30:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231025133051eusmtrp1659aa83e9230f2e56552a8b5f9d22858~RXN-jKaTf0869708697eusmtrp1w;
        Wed, 25 Oct 2023 13:30:51 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-54-6539188b968a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 00.A8.10549.B8819356; Wed, 25
        Oct 2023 14:30:51 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231025133050eusmtip2c8c8b9f20b0952930e64108434998a21~RXN_uTT0j1260512605eusmtip26;
        Wed, 25 Oct 2023 13:30:50 +0000 (GMT)
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
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v4 3/8] thermal: exynos: switch from workqueue-driven
 interrupt handling to threaded interrupts
Date:   Wed, 25 Oct 2023 15:30:22 +0200
Message-ID: <20231025133027.524152-4-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025133027.524152-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djP87rdEpapBlMOGVg8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKC6blNSczLLUIn27BK6MT5OOMxXskayY/OwJWwPjJNEuRg4OCQETiW+bArsY
        OTmEBFYwSqw6WtDFyAVkf2GUOHpzPxNE4jOjRPcJHRAbpH76tj52iKLljBIbD7cyQjitTBIn
        Wt6wg1SxCRhIPHizDMwWEWhllJjZpA5SxCzwlVni6uv5zCCrhQUKJWZuqwepYRFQlZj9sZcV
        xOYVsJU48+4QO8Q2eYk9i76DXcEpYCfRe/w6G0SNoMTJmU9YQGxmoJrmrbOZQeZLCHRzSlx6
        94YZotlF4teENywQtrDEq+NboIbKSJye3AMVz5eYsfk9CyQoKiTuHvSCMK0lPp4Bu5JZQFNi
        /S59iGJHiZ6u08wQFXwSN94KQhzAJzFp23SoMK9ER5sQRLWqxPE9k6BOkZZ40nKbCcL2kHj+
        +gnbBEbFWUhemYXklVkIexcwMq9iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITGmn/x3/
        uoNxxauPeocYmTgYDzFKcDArifBG+likCvGmJFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJI
        TyxJzU5NLUgtgskycXBKNTDNennCWbSr/LaBX/h/to5/91ojd669luzm2HZU6YBmhWZlRvXN
        nu/Pb/Otfh59uipjb6rn3NpDXzaYHnVhaTO7nGVmZcu68eWLJRyfrOdJ+XiLsUv4TX6/RsS9
        pibfUvXXmmtP5i5QLWrKWZ/iqpdwY6bXmQgdy3Ui/9rO2FRwP5o1ZbHooSnKm5TP3vypd2l3
        pU703PdPMhkqtux+ecL4/PKr22cttrnpmcb/SunN2ZdXljbkznydeXSrt9bNua5345OCXjUu
        PLE4fnme59OXfV/erXyduoFXZH/apOW9p2XcKk5YHJ1p6pwjxjdDxueHbYvR2gffbwvecLxU
        etS56/jW0KNZXfnxF3zkl6xXVWIpzkg01GIuKk4EAKUkfhvYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7rdEpapBi0L2CwezNvGZnF4foXF
        1IdP2Cy+b7nOZDHvs6zF3tdb2S2+Xelgstj0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i4nH
        JjNbrD1yl91i7pepzBZPHvaxOQh4rJm3htFj56y77B6L97xk8ti0qpPN4861PWwem5fUe/Rt
        WcXo8XmTXABHlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllq
        kb5dgl7Gp0nHmQr2SFZMfvaErYFxkmgXIyeHhICJxPRtfexdjFwcQgJLGSXe/tzKBJGQljj8
        ZQo7hC0s8edaFxtEUTOTxOYn/WwgCTYBA4kHb5aBdYsIdDJKdG0+B9bNLPCfWeLrTAUQW1gg
        X2L+xlPMIDaLgKrE7I+9rCA2r4CtxJl3h6A2yEvsWfQdrJdTwE6i9/h1sAVCQDUTOh6yQ9QL
        Spyc+YQFYr68RPPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzAS
        tx37uXkH47xXH/UOMTJxMB5ilOBgVhLhjfSxSBXiTUmsrEotyo8vKs1JLT7EaAp090RmKdHk
        fGAqyCuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYErKZtAWLvP4
        ovNRqXCduew0tib9C4EnNsdW+NU3NeiznGVey9SW4ZgzWWJr26ZeLgYOq8XnqydGsNjxBuzN
        u/rg+9+6zq9TpO7M8vmTwf6kbM+RIM7jlRuWpD3NVt8+SfmUqOCdLr7pjmZ/s5aLcksvnq86
        TyKwJyU0PaNUYKWV3TPPwkyOl5+SrtpmOskxz9StevzS9nRex8a5YTq/8+X3ZZt17JOVK7vG
        +2Z99oakEzaPV1t4Ruap9m+x3lNx+ANj5FbuBTYncgUMPEK+PO3+svhOvmnljCsP1hbVVmj3
        COb1b6n8HSUyLfnT2kfMaxvFPHkF1xkdSXyySkmvYbbpYmflxb332bgXT0xXYinOSDTUYi4q
        TgQAvCnIt00DAAA=
X-CMS-MailID: 20231025133051eucas1p1e9ed4202abb45c5d2f738fdd213503ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231025133051eucas1p1e9ed4202abb45c5d2f738fdd213503ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231025133051eucas1p1e9ed4202abb45c5d2f738fdd213503ee
References: <20231025133027.524152-1-m.majewski2@samsung.com>
        <CGME20231025133051eucas1p1e9ed4202abb45c5d2f738fdd213503ee@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

