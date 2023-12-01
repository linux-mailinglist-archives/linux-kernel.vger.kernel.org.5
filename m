Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154FE8007BD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378209AbjLAJ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378117AbjLAJ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:56:43 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CD2171F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:56:48 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231201095647euoutp02ae58fda53e8949e00191c3f13eca3ffe~crKqOK2kN0691406914euoutp02w
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:56:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231201095647euoutp02ae58fda53e8949e00191c3f13eca3ffe~crKqOK2kN0691406914euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701424607;
        bh=Xj8+Q25ZnIYTM/2MffV/7fbm1IqivwOa9KW5RmZAxqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GnRCa5pRZHq5UxyrqSt5xXE+0RnbrvKCeq0i7ZxPfX7Dpj+KNU1nnXkHO7LPwaWga
         +m+wawyY2v/rW2xG6dprKaAkeX9rrfl8Fa9Iw5haNdQe0WCmAxPG2r2akV59L0ywJy
         EfeRxU1fYfH2GeOwFNxRvomPcyJfT5REiZ//x2Ks=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231201095647eucas1p197e1b548a60217fa885bd7109d4656d9~crKprwzQB1009210092eucas1p1L;
        Fri,  1 Dec 2023 09:56:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 80.54.09539.FDDA9656; Fri,  1
        Dec 2023 09:56:47 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231201095646eucas1p19ea1a0355b799a4f47dd9e55d90ccb68~crKpN_If32916929169eucas1p1-;
        Fri,  1 Dec 2023 09:56:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231201095646eusmtrp16df7a61a1337af4249526e1964b7e497~crKpIaCnS0736407364eusmtrp1H;
        Fri,  1 Dec 2023 09:56:46 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-cc-6569addf8e23
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9F.20.09146.EDDA9656; Fri,  1
        Dec 2023 09:56:46 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231201095645eusmtip25ccfe1ee336110cf86c1cea441889924~crKoPqiJ-0964909649eusmtip2e;
        Fri,  1 Dec 2023 09:56:45 +0000 (GMT)
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
Subject: [PATCH v6 7/9] thermal: exynos: split initialization of TMU and the
 thermal zone
Date:   Fri,  1 Dec 2023 10:56:23 +0100
Message-ID: <20231201095625.301884-8-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201095625.301884-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djPc7r312amGmz8w2rxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4Mp4cWoHc8FcjYpPa74wNjDeVehi5OSQEDCR
        WPfkHksXIxeHkMAKRomNezaxQjhfGCXO3+pghnA+M0pc/dDA1MXIAdbS32ULEV/OKLG/pYMd
        wmllkjh+Zjo7yFw2AQOJB2+WgdkiAq2MEjOb1EFsZoGFLBIt/3JBbGGBaIntO58wg9gsAqoS
        H1obwep5BWwlLiyaxQhxn7zEnkXfmUBsTgE7ifmHWlkgagQlTs58wgIxU16ieetssEslBKZz
        Skw/u4YNotlFYmrjBxYIW1ji1fEt7BC2jMTpyT1Q8XyJGZvfs0B8ViFx96AXhGkt8fEMM4jJ
        LKApsX6XPkSxo8TL2f+hivkkbrwVhDiAT2LStunMEGFeiY42IYhqVYnjeyYxQ9jSEk9abjNB
        2B4SzW/+s09gVJyF5JVZSF6ZhbB3ASPzKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMAE
        d/rf8U87GOe++qh3iJGJg/EQowQHs5II7/Wn6alCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT
        5FOFBNITS1KzU1MLUotgskwcnFINTBrfF7y89ufjDt3TpjXWWxWFf11gOD93ibCu+Fez+Cc6
        l7M3s5nt1A9+1Krzm/+4zmKZ+lo5lngL7n3Tj185x99QVMD8fFbX1Em+QtlmPIdDd1T9blr1
        9UqViH9UYvUpdevuP7/aFkwt/6ancPSsSM38Ewn7jv1f+L5bku8bv495ZtT0deHqN7YZJuVn
        iDOdV3kZ5zM9yyamSTXaum/eg8lBsVerLiTYrm/tP+5Xlrv2olplfkK8akChz+Zqc9OF+d2T
        7zjHFPfGXc9MfM77na/2RODGhTdYGx+LxizKfarjfSXnkML5LZ9+u2dfkbA79VtTTf9Fbpba
        gcDSX5338ufUM22f/4tD+enbD585lViKMxINtZiLihMBtObrvd8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7r31mamGjzcJmfxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0Mt4cWoHc8FcjYpPa74wNjDeVehi5OCQEDCR6O+y7WLk4hASWMooMXfpQrYu
        Rk6guLTE4S9T2CFsYYk/17rYIIqamSTurXvLCpJgEzCQePBmGTtIQkSgk1Gia/M5JhCHWWA1
        i8Sxfd+ZQKqEBSIlvk/pBrNZBFQlPrQ2go3lFbCVuLBoFiPECnmJPYsg6jkF7CTmH2plAbGF
        gGq6tvxnhKgXlDg58wlYnBmovnnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55bbKhXnJhbXJqX
        rpecn7uJERiT24793LyDcd6rj3qHGJk4GA8xSnAwK4nwXn+anirEm5JYWZValB9fVJqTWnyI
        0RTo7onMUqLJ+cCkkFcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnV
        wLRh20p3NQlfbsaP5zYs1GLatqumwGK2dEufp9bHsJ1+bvk6u4JtZCwaGV4x3ZmhcffpBjGD
        o/53b+wODjqlN9NRveFdvUfTtO0zEgyuLZVc3qPizPCBP+GT7RZxFqPMnISfp858S9y92LX5
        1II9K41yy7rDvvsK/7z+xy7oD2PGrZpNvq19L0pcc+pm/o/bO1+GR3+RdLu8/2beAO4jZ5ge
        l6Uudv0jfuaa+O5EzjqJBd/UWifnpPGfX/apQPjZ8qrQa8t0F8aLbQmt/rDtdFTQbcYa3xNt
        3besQ3Yq/L/1yVZbJeLXImY16c5UGa0167TnxDZW6jkKfuzi8SwtlHKzlX21vtj28LsVqZt+
        KLEUZyQaajEXFScCAL39GY9SAwAA
X-CMS-MailID: 20231201095646eucas1p19ea1a0355b799a4f47dd9e55d90ccb68
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231201095646eucas1p19ea1a0355b799a4f47dd9e55d90ccb68
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231201095646eucas1p19ea1a0355b799a4f47dd9e55d90ccb68
References: <20231201095625.301884-1-m.majewski2@samsung.com>
        <CGME20231201095646eucas1p19ea1a0355b799a4f47dd9e55d90ccb68@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be needed in the future, as the thermal zone subsystem might
call our callbacks right after devm_thermal_of_zone_register. Currently
we just make get_temp return EAGAIN in such case, but this will not be
possible with state-modifying callbacks, for instance set_trips.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v5 -> v6: Fixed cleanup done if exynos_tmu_initialize fails.
v3 -> v4: Reordered calls done while leaving exynos_tmu_initialize so
  that they mirror the calls done while entering this function.
v1 -> v2: We take clocks into account; exynos_tmu_initialize needs both
  clocks, as tmu_initialize might use the base_second registers. However,
  exynos_thermal_zone_configure only needs clk.

 drivers/thermal/samsung/exynos_tmu.c | 104 +++++++++++++++------------
 1 file changed, 60 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index d918bf6d5359..970bada90f2f 100644
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
+	if (!IS_ERR(data->clk_sec))
+		clk_disable(data->clk_sec);
+	clk_disable(data->clk);
+	mutex_unlock(&data->lock);
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
+		goto err_sclk;
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

