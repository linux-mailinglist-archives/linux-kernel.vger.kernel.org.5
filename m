Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD287F165B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjKTOwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjKTOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:51:58 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362C4171A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:51:08 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231120145102euoutp01ea39e5cddb386523626bbe6b54574473~ZXFb7S6SN2534925349euoutp01N
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:51:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231120145102euoutp01ea39e5cddb386523626bbe6b54574473~ZXFb7S6SN2534925349euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700491863;
        bh=z+drqHSTXutvqyghqqSngnAvaJMAvU0O0c1Ke0HntPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwZQvROpy8RL9K+EGs6KHsA0Mf9sO/JY5dnuz7xmgxq9dfTS6qwGqfNBcMr9rf3QG
         Rc+SFlLt1/YRkrs6NoA1zo2Kbl+BOFIWsRjtVvtEv/agLI/ArCNsKSPigN8xVRvA4Z
         YTJ+K/1pkXLYnIrL59q9RRIGWxtsUCUJnGhd657c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231120145102eucas1p1a44aa06fa354de95a8205ea742f5460a~ZXFbfJwLv1858518585eucas1p1Q;
        Mon, 20 Nov 2023 14:51:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CA.37.09539.6527B556; Mon, 20
        Nov 2023 14:51:02 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231120145101eucas1p2f5da2c4612cf10b0b8b2055863fbd7c2~ZXFa3T_6J1100611006eucas1p2u;
        Mon, 20 Nov 2023 14:51:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231120145101eusmtrp235997a8555478e4749b94eb8b26820f2~ZXFa1sjfI0691806918eusmtrp2B;
        Mon, 20 Nov 2023 14:51:01 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-52-655b7256120d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 24.C3.09146.5527B556; Mon, 20
        Nov 2023 14:51:01 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231120145100eusmtip271c74bbc8e56a76859f5bf666ad20f0f~ZXFZ-1b0v0740707407eusmtip2Y;
        Mon, 20 Nov 2023 14:51:00 +0000 (GMT)
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
Subject: [PATCH v5 3/9] thermal: exynos: switch from workqueue-driven
 interrupt handling to threaded interrupts
Date:   Mon, 20 Nov 2023 15:50:43 +0100
Message-ID: <20231120145049.310509-4-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120145049.310509-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87phRdGpBrOWS1k8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKC6blNSczLLUIn27BK6MT5OOMxXskayY/OwJWwPjJNEuRk4OCQETiUcbFzJ1
        MXJxCAmsYJQ4fXg7O0hCSOALo8T6fywQic+MEn9+n2aC6fh57yFUYjmjxKr5vVDtrUwS7SdP
        MoNUsQkYSDx4swxslIhAK6PEzCZ1kCJmga/MEldfzwcq4uAQFiiUODmlBqSGRUBVYvql7ywg
        Nq+ArcTpNztYIbbJS+xZ9B1sM6eAnUTbkedsEDWCEidnPgGrZwaqad46mxlkvoRAP6fEm/8L
        2SCaXSR+nLzFAmELS7w6voUdwpaR+L9zPtQ7+RIzNr9nAblHQqBC4u5BLwjTWuLjGbArmQU0
        Jdbv0ocodpTYc7+FHaKCT+LGW0GIA/gkJm2bzgwR5pXoaBOCqFaVOL5nEjOELS3xpOU21EoP
        ifeTTrJMYFScheSVWUhemYWwdwEj8ypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAtHb6
        3/FPOxjnvvqod4iRiYPxEKMEB7OSCO83oYhUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryqKfKp
        QgLpiSWp2ampBalFMFkmDk6pBiZe47uPzQ6135rWdJblP9uaHZ+6tbRM37lE891z3hr4emP0
        +8Mqa789iMgJf7Ar69gRpx1e/pPWentKhcY5LDdrPJ207KEWc1DjemVNr+hlv743fTjQeZzt
        9AoNrzn6demmzYJ+3dMPzew/8lEsfJ5dZd3PnL8WF0NSrOb43bihtvG0V/Kvcvbqhy95bqvY
        bpp6fb2+sPc7jw05F/YuuByzf1Lo99uSxne4NCees5v+4Nijqjd+r8r6wsOtH5Vrdy9YsS3n
        IHu83uuOL72zKp3uyTQ+FXToerxo3uekM67a8wo3Hvx28I/x1NgQxmMH4n84H3PO++Kd06Q6
        /1rk3Hn3ayyPS8uxi5dNepjl43hViaU4I9FQi7moOBEAPHihy9oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7qhRdGpBu1bdCwezNvGZnF4foXF
        1IdP2Cy+b7nOZDHvs6zF3tdb2S2+Xelgstj0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i4nH
        JjNbrD1yl91i7pepzBZPHvaxOQh4rJm3htFj56y77B6L97xk8ti0qpPN4861PWwem5fUe/Rt
        WcXo8XmTXABHlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllq
        kb5dgl7Gp0nHmQr2SFZMfvaErYFxkmgXIyeHhICJxM97D1m6GLk4hASWMko07D/FCpGQljj8
        ZQo7hC0s8edaFxtEUTOTxPG108CK2AQMJB68WcYOkhAR6GSU6Np8jgkkwSzwn1ni60wFEFtY
        IF/i5dl7YJNYBFQlpl/6zgJi8wrYSpx+swNqm7zEnkXfwXo5Bewk2o48B9rGAbTNVqLjrgZE
        uaDEyZlPWCDGy0s0b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzEC
        43DbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd5vQhGpQrwpiZVVqUX58UWlOanFhxhNgc6eyCwl
        mpwPTAR5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MU5c+Of/L
        54Iz24XFOzQ6VQ1kr0/TLYhuL7jTvWKNz7LjdhfyQreteT1X8bTlbg/bpWwqd7/3d78qObep
        W80s+dfJabsnsQd9uXc752yb/o6ad+2P3XTk3x2WvLSD9xajsEtjaLdb5oWVnWf0l23p7anm
        SBJ9fn+GVLr/4r08NaK/vzN2GL8MmtPRVCQW161xgUH+788nO3jTufmvb+XXuxGoF7F/9pRP
        uocy5sZ23U6vVRYrU2y4z8r8rtggY5nSHlf+IP7j61e+Yp6qkXm5X7e4ex2737v0xpct6VeC
        ayconlx/PenilylSxp2C6o+Oajj/DOTbqcO1v1oxV8p4w4Kka/aS7beWPgtvvr5XiaU4I9FQ
        i7moOBEA0YtMw0wDAAA=
X-CMS-MailID: 20231120145101eucas1p2f5da2c4612cf10b0b8b2055863fbd7c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231120145101eucas1p2f5da2c4612cf10b0b8b2055863fbd7c2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231120145101eucas1p2f5da2c4612cf10b0b8b2055863fbd7c2
References: <20231120145049.310509-1-m.majewski2@samsung.com>
        <CGME20231120145101eucas1p2f5da2c4612cf10b0b8b2055863fbd7c2@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
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

