Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322B179B95D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbjIKVEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbjIKNg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:36:27 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CA61A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:36:22 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230911133621euoutp022b969e4d8e01d84aa6dd9d4e1a721a03~D26PMHTQN1421514215euoutp026
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:36:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230911133621euoutp022b969e4d8e01d84aa6dd9d4e1a721a03~D26PMHTQN1421514215euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694439381;
        bh=AHRUH7iv0+JjlcsKRA9WgTab92k33Ne0onjy9WkFjoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ls2WySLP+bdPSsdu80HvhvF/+o5fw744lkgNiBkT0ER247DILu1Cz8gOWgG0z/eRM
         BtnHSuGOZVj62ct4YN704VzelERJlS1zD2CvYNAufv8RH0DeU2HnfzF7QR00L1Eq+u
         uybfqTp7Mvmea1aIhw69Qz5GpO5nysCa7r5HWXvo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230911133621eucas1p22a8ec8768ab851d4e58c47518c002376~D26O2XA2e1712617126eucas1p2s;
        Mon, 11 Sep 2023 13:36:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A3.13.37758.4D71FF46; Mon, 11
        Sep 2023 14:36:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230911133620eucas1p27a0d0f480638c97fa59bf9c4f34a02cb~D26OeqwID0331103311eucas1p28;
        Mon, 11 Sep 2023 13:36:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230911133620eusmtrp267269e8199ae0082d7e133eb8ff20c7d~D26Od9wl60864008640eusmtrp2s;
        Mon, 11 Sep 2023 13:36:20 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-74-64ff17d4ac0b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B8.8A.14344.4D71FF46; Mon, 11
        Sep 2023 14:36:20 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230911133619eusmtip227c9f2ad6cd3f8dbcaf512ab8f14f89d~D26NNk7cJ0797807978eusmtip2f;
        Mon, 11 Sep 2023 13:36:19 +0000 (GMT)
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
Subject: [PATCH v2 6/7] thermal: exynos: split initialization of TMU and the
 thermal zone
Date:   Mon, 11 Sep 2023 15:34:30 +0200
Message-ID: <20230911133435.14061-7-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911133435.14061-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87pXxP+nGEw5aWnxYN42NovD8yss
        pj58wmbxfct1Jot5n2Ut9r7eym7x7UoHk8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCwmHpvMbLH2
        yF12i7lfpjJbPHnYx+bA77Fz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9+rasYvT4vEkugD2K
        yyYlNSezLLVI3y6BK2PTj/ksBRPVKvYenM7YwPhDrouRk0NCwETi25tWxi5GLg4hgRWMEqtu
        PGKDcL4wSnQ/mcYCUiUk8JlRYtb0cpiOJa86WSGKljNKHNl+iAnCaWWSeLlmPVgHm4CBxIM3
        y9hBbBGBVkaJmU3qIEXMApeYJe7eXAtUxMEhLBAt8WqCF0gNi4CqxIL3N5lAbF4BG4mLW5cx
        QmyTl3h+6w7YHE4BW4mza6ezQ9QISpyc+QRsFzNQTfPW2cwg8yUE/nNIXGzezgTR7CIxYfVz
        KFtY4tXxLewQtozE/53zoeL5EjM2vwe7R0KgQuLuQS8I01ri4xlmEJNZQFNi/S59iGJHiSmr
        NzNDVPBJ3HgrCHEAn8SkbdOhwrwSHW1CENWqEsf3TGKGsKUlnrTchlrpIdG14jbrBEbFWUhe
        mYXklVkIexcwMq9iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITGGn/x3/uoNxxauPeocY
        mTgYDzFKcDArifCWHPqbIsSbklhZlVqUH19UmpNafIhRmoNFSZxX2/ZkspBAemJJanZqakFq
        EUyWiYNTqoGpw//H62yuKtNdE//xmAofn1kqfrX1TIx7csvLx4ET9BrXNx+YEy751bV96+Vr
        HWvCfn3wq71z/M3JEjfVAx2PKiR2su86Mc0sPbUvpWVXQcSezJ8Boac5+mtbN9tJzG3kDF/Z
        8PiH6YUe+ag69zM1bV07UgwSbtnYlFg8OGey0jor6G7/99ml/kUK89mzHk3TbuswXDlx+rSE
        3V3f5Ty/XOvvZZimoR+at5xr6j4pi8rZDZ8d6natvHnrkc97d/G0zEiZE2v81mQ9n79ZbY7e
        sZ2zVkV1Gb5n/p7+pqt2sklw7GneW5cbTvBZMOw5aDG7cKY705kly0KUVhuHmr3iWPF1/yxd
        q2d8Mw/xu+9RYinOSDTUYi4qTgQADKCQk9ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xe7pXxP+nGMxpVrR4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB6l
        Z1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7Hpx3yW
        golqFXsPTmdsYPwh18XIySEhYCKx5FUnK4gtJLCUUeLJrniIuLTE4S9T2CFsYYk/17rYIGqa
        mSQ2fc8AsdkEDCQevFkGVMPFISLQySjRtfkcE0iCWeAWs8T911ogtrBApMTmP5vAmlkEVCUW
        vL8JVsMrYCNxcesyRogF8hLPb90BW8YpYCtxdu10IJsDaJmNRP8ZHYhyQYmTM5+wQIyXl2je
        Opt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG27ZjP7fsYFz56qPe
        IUYmDsZDjBIczEoivCWH/qYI8aYkVlalFuXHF5XmpBYfYjQFOnsis5Rocj4w4vNK4g3NDEwN
        TcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpj4j64Ksi1p32+99c987Z6Vv69v
        iHn/3ubmzYUnLxwXnPEkoXZWqMSX7VsONz1zXKA68cuFAyqHUt7ssfXQ8e+cdFc5benhL9uu
        3GkOuuhhGPo2TPTbwZxrTV2Lrh1UnlLE3vmB3WzJorUbMpK1Ol5tyBZcJHJ04sLux6YcnZGp
        j78o/3rLkX1GjFn0pk/s9BU8u9wf8238/dzqab7tRzVreadF198+aLGz23XX3e2CrGc/x9PS
        wqR8t+fWGqsi7HdVXrSJOzpp8SbuphlLlHdc3TNr7lQ1FqaLc6et+bfL2iBSyeHghVe28g+F
        qwPXOIt1pZ6qSylIWF8xoTeMdefisil7r2a/XN+5aZbp5NovukosxRmJhlrMRcWJAHfPoRdA
        AwAA
X-CMS-MailID: 20230911133620eucas1p27a0d0f480638c97fa59bf9c4f34a02cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230911133620eucas1p27a0d0f480638c97fa59bf9c4f34a02cb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230911133620eucas1p27a0d0f480638c97fa59bf9c4f34a02cb
References: <20230911133435.14061-1-m.majewski2@samsung.com>
        <CGME20230911133620eucas1p27a0d0f480638c97fa59bf9c4f34a02cb@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 77afbf9f2db0..7b23ec73f93a 100644
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
@@ -1038,10 +1052,12 @@ static int exynos_tmu_probe(struct platform_device *pdev)
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
@@ -1052,9 +1068,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
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
2.41.0

