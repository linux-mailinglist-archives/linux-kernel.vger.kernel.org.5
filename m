Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818EA7B67AD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbjJCLRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239917AbjJCLRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:17:19 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9705B4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:17:16 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231003111715euoutp02af9722a50f25a6220433be061b263fb9~KlNEh14aQ1157211572euoutp02h
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:17:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231003111715euoutp02af9722a50f25a6220433be061b263fb9~KlNEh14aQ1157211572euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696331835;
        bh=KJozKF3tDwxVWSXlQ/ef+TTDcYyB/rkSZst7Qpw6Axc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lsRLzs8ubE9rRu4UegkLic+WqWUd/t5uC36VuDjypDdtCEAadfFrxSyYAsMETyYHC
         4wECbnnod1oPyzNfxsFWZEhughdNeSYVTrnNgBIej3BN0+u6v/WmvPE5L3UTa9M9fI
         hH5ppIID2uTHCbNVjLwwbEdnomzUJ2zRg2Ija3Rk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231003111714eucas1p29e6ebbdefd687adbd93ea166433e7ed9~KlNDLbY_v2468224682eucas1p2A;
        Tue,  3 Oct 2023 11:17:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8A.14.11320.A38FB156; Tue,  3
        Oct 2023 12:17:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111713eucas1p27fcc64df0091b6097461f28b05bf772a~KlNCtkiRc2872628726eucas1p2a;
        Tue,  3 Oct 2023 11:17:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231003111713eusmtrp167ee5936eac0aed120e54207fe9c946c~KlNCqkHN42246422464eusmtrp1o;
        Tue,  3 Oct 2023 11:17:13 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-4c-651bf83a4dc0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 20.E1.10549.938FB156; Tue,  3
        Oct 2023 12:17:13 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111712eusmtip272573f24002e37035f6c8fd926410db5~KlNB1KmUM2844228442eusmtip2F;
        Tue,  3 Oct 2023 11:17:12 +0000 (GMT)
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
Subject: [PATCH v3 7/8] thermal: exynos: split initialization of TMU and the
 thermal zone
Date:   Tue,  3 Oct 2023 13:16:33 +0200
Message-ID: <20231003111638.241542-8-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003111638.241542-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87pWP6RTDRa2s1o8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouJxyYzW6w9
        cpfdYu6XqcwWTx72sTnwe+ycdZfdY/Gel0wem1Z1snncubaHzWPzknqPvi2rGD0+b5ILYI/i
        sklJzcksSy3St0vgyni1dytzwUS1ii8HrjI2MP6Q62Lk5JAQMJHY1XODsYuRi0NIYAWjxOZN
        E5lBEkICXxglrt/ygUh8ZpRYf2gdC0zH69MnWCESyxklFt06zwTR0cokseScNojNJmAg8eDN
        MnYQW0SglVFiZpM6SAOzwCVmibs314JNEhaIlvj5dh1YEYuAqsS+PefABvEK2ErM/P6dCWKb
        vMSeRRA2p4CdxMqfy6FqBCVOznwCNocZqKZ562xmkAUSAv85JF483c4G0ewiMXVdBzuELSzx
        6vgWKFtG4vTkHqh38iVmbH4PZHMA2RUSdw96QZjWEh/PMIOYzAKaEut36UMUO0qsOz2DCaKC
        T+LGW0GIA/gkJm2bzgwR5pXoaBOCqFaVOL5nEjOELS3xpOU21E8eEv+27WSZwKg4C8krs5C8
        Mgth7wJG5lWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiBKez0v+NfdjAuf/VR7xAjEwfj
        IUYJDmYlEd6wo1KpQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8mCwmkJ5akZqemFqQWwWSZ
        ODilGpjMMuxKY1bvm3xtsuSVNoni9Zflsk+w3/jyxLND6kCy46Gsi0bzzGPZG86zbmjRd/0/
        d2bCySNaUwvu+6UbNPc/yOG1rgsV/9HxRvljjnCB2Z1MpfmTLs8Tnx7i85DNRCkv7eqvsxLW
        xjbM5WpTNso9fBW+WT7GwKzJfMP/ySdPNys6KZ1ULHvw0V302naFLw8fOOjmL+HhTKp7o3fr
        isP2OVL3Jhe+nDJNdPFCXk/Fb/nHj3AUc+3qWhUolLkmlu/KT412rtT5ld1bmSuY46PZxDyW
        bVsx8YR0DMuq4y8qtgfOYlHbkl/+27P9/RHR2sPLuk5sOS9i8svMOGjZ0uvn2teejM+64Vvx
        Yf4uualKLMUZiYZazEXFiQDeEB+O0AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xe7qWP6RTDb5sULB4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB6l
        Z1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/Fq71bm
        golqFV8OXGVsYPwh18XIySEhYCLx+vQJ1i5GLg4hgaWMEpenzWCHSEhLHP4yBcoWlvhzrYsN
        oqiZSWLrhTVsIAk2AQOJB2+WsYMkRAQ6GSW6Np9jAkkwC9xilrj/WgvEFhaIlGicM4cRxGYR
        UJXYtweihlfAVmLm9+9MEBvkJfYsgrA5BewkVv5cDmYLAdXcWr6PBaJeUOLkzCcsEPPlJZq3
        zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIFRt+3Yz807GOe9+qh3
        iJGJg/EQowQHs5IIb9hRqVQh3pTEyqrUovz4otKc1OJDjKZAd09klhJNzgfGfV5JvKGZgamh
        iZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA5OBU+oJXa2dJrcY/HMtefLTX/rX
        FWobuM4uM054G7DSZLvc2j2P90dly7GFKfXtiL9wkr3TXji5hVti6l6f+GUhj1ufnlbiWp3v
        U/nVdELVhbkLSuem3zx/onSK5cpDmxddOTDpr++OolN7WWN/LD11eU565Und9cx/VWZrLJro
        bhR7QcuTt0DL0iRR+Evq7jvu9T0z3+5eYHjXYefnNFbd5Uuzrt5gmmxo9nrKict9MyxahCIs
        b7ZuzZ/TfLCueH5w5ETzqUJVfTuumX5JN+OZ8Hylr8Q3xglX9z3aZCjBVLvzccqH9+s5j5u7
        Pi/JyfkcpXj1dvJzRzPea2/Xna1qUt/z7K3LxF7p3eWxaz2VWIozEg21mIuKEwEWHvKgQwMA
        AA==
X-CMS-MailID: 20231003111713eucas1p27fcc64df0091b6097461f28b05bf772a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231003111713eucas1p27fcc64df0091b6097461f28b05bf772a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231003111713eucas1p27fcc64df0091b6097461f28b05bf772a
References: <20231003111638.241542-1-m.majewski2@samsung.com>
        <CGME20231003111713eucas1p27fcc64df0091b6097461f28b05bf772a@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be needed in the future, as the thermal zone subsystem might
call our callbacks right after devm_thermal_of_zone_register. Currently
we just make get_temp return EAGAIN in such case, but this will not be
possible with state-modifying callbacks, for instance set_trips.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v1 -> v2: We take clocks into account; exynos_tmu_initialize needs both
  clocks, as tmu_initialize might use the base_second registers. However,
  exynos_thermal_zone_configure only needs clk.

 drivers/thermal/samsung/exynos_tmu.c | 104 +++++++++++++++------------
 1 file changed, 60 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 7138e001fa5a..343e27c61528 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -251,25 +251,8 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 static int exynos_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tzd = data->tzd;
-	int num_trips = thermal_zone_get_num_trips(tzd);
 	unsigned int status;
-	int ret = 0, temp;
-
-	ret = thermal_zone_get_crit_temp(tzd, &temp);
-	if (ret && data->soc != SOC_ARCH_EXYNOS5433) { /* FIXME */
-		dev_err(&pdev->dev,
-			"No CRITICAL trip point defined in device tree!\n");
-		goto out;
-	}
-
-	if (num_trips > data->ntrip) {
-		dev_info(&pdev->dev,
-			 "More trip points than supported by this TMU.\n");
-		dev_info(&pdev->dev,
-			 "%d trip points should be configured in polling mode.\n",
-			 num_trips - data->ntrip);
-	}
+	int ret = 0;
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
@@ -280,32 +263,63 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	if (!status) {
 		ret = -EBUSY;
 	} else {
-		int i, ntrips =
-			min_t(int, num_trips, data->ntrip);
-
 		data->tmu_initialize(pdev);
-
-		/* Write temperature code for rising and falling threshold */
-		for (i = 0; i < ntrips; i++) {
-
-			struct thermal_trip trip;
-
-			ret = thermal_zone_get_trip(tzd, i, &trip);
-			if (ret)
-				goto err;
-
-			data->tmu_set_trip_temp(data, i, trip.temperature / MCELSIUS);
-			data->tmu_set_trip_hyst(data, i, trip.temperature / MCELSIUS,
-						trip.hysteresis / MCELSIUS);
-		}
-
 		data->tmu_clear_irqs(data);
 	}
+
+	mutex_unlock(&data->lock);
+	clk_disable(data->clk);
+	if (!IS_ERR(data->clk_sec))
+		clk_disable(data->clk_sec);
+
+	return ret;
+}
+
+static int exynos_thermal_zone_configure(struct platform_device *pdev)
+{
+	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
+	struct thermal_zone_device *tzd = data->tzd;
+	int i, num_trips = thermal_zone_get_num_trips(tzd);
+	int ret = 0, temp;
+
+	ret = thermal_zone_get_crit_temp(tzd, &temp);
+
+	if (ret && data->soc != SOC_ARCH_EXYNOS5433) { /* FIXME */
+		dev_err(&pdev->dev,
+			"No CRITICAL trip point defined in device tree!\n");
+		goto out;
+	}
+
+	mutex_lock(&data->lock);
+
+	if (num_trips > data->ntrip) {
+		dev_info(&pdev->dev,
+			 "More trip points than supported by this TMU.\n");
+		dev_info(&pdev->dev,
+			 "%d trip points should be configured in polling mode.\n",
+			 num_trips - data->ntrip);
+	}
+
+	clk_enable(data->clk);
+
+	num_trips = min_t(int, num_trips, data->ntrip);
+
+	/* Write temperature code for rising and falling threshold */
+	for (i = 0; i < num_trips; i++) {
+		struct thermal_trip trip;
+
+		ret = thermal_zone_get_trip(tzd, i, &trip);
+		if (ret)
+			goto err;
+
+		data->tmu_set_trip_temp(data, i, trip.temperature / MCELSIUS);
+		data->tmu_set_trip_hyst(data, i, trip.temperature / MCELSIUS,
+					trip.hysteresis / MCELSIUS);
+	}
+
 err:
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
-	if (!IS_ERR(data->clk_sec))
-		clk_disable(data->clk_sec);
 out:
 	return ret;
 }
@@ -1044,10 +1058,12 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		break;
 	}
 
-	/*
-	 * data->tzd must be registered before calling exynos_tmu_initialize(),
-	 * requesting irq and calling exynos_tmu_control().
-	 */
+	ret = exynos_tmu_initialize(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize TMU\n");
+		return ret;
+	}
+
 	data->tzd = devm_thermal_of_zone_register(&pdev->dev, 0, data,
 						  &exynos_sensor_ops);
 	if (IS_ERR(data->tzd)) {
@@ -1058,9 +1074,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_sclk;
 	}
 
-	ret = exynos_tmu_initialize(pdev);
+	ret = exynos_thermal_zone_configure(pdev);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to initialize TMU\n");
+		dev_err(&pdev->dev, "Failed to configure the thermal zone\n");
 		goto err_sclk;
 	}
 
-- 
2.42.0

