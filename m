Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEF47F1650
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjKTOw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjKTOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:51:58 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5655171D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:51:08 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231120145107euoutp025a341e8201fa8bcc95c63408939c7f30~ZXFgImEA72423324233euoutp02c
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:51:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231120145107euoutp025a341e8201fa8bcc95c63408939c7f30~ZXFgImEA72423324233euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700491867;
        bh=HFjJa1RguNICip8Nann+GThTo5GBNLI3URdePUvmffE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJROzEWzw/z52hXiYkUqtHSJy1qUZmagNu441oM1lCR0PAkDjIPfvzGJMw8LeExcf
         +UIfz6npQX6ZmbqLO67shH1rbHaVrBcWc+8NGowkPxxHwsz4sXNMUwVfHhOiHTqj8L
         JAr7xC4ep1zmK26cWtBGqBGZBhq49zZvtty1e8nE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231120145107eucas1p257acb28f624092f513f92bdf4e3402ef~ZXFf0tf1y0521605216eucas1p2z;
        Mon, 20 Nov 2023 14:51:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A8.A8.09552.A527B556; Mon, 20
        Nov 2023 14:51:07 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231120145106eucas1p1964c7fdc0297d538faa0aeb20190d178~ZXFfYQS382504625046eucas1p17;
        Mon, 20 Nov 2023 14:51:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231120145106eusmtrp20de9c8945620aecf4b00892a3f597c11~ZXFfXl5eb0691806918eusmtrp2P;
        Mon, 20 Nov 2023 14:51:06 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-8f-655b725a9c69
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1B.C3.09146.A527B556; Mon, 20
        Nov 2023 14:51:06 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231120145105eusmtip270942d3c46daa8e61451e3142463bd41~ZXFegph5a1340013400eusmtip2C;
        Mon, 20 Nov 2023 14:51:05 +0000 (GMT)
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
Subject: [PATCH v5 7/9] thermal: exynos: split initialization of TMU and the
 thermal zone
Date:   Mon, 20 Nov 2023 15:50:47 +0100
Message-ID: <20231120145049.310509-8-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120145049.310509-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7rRRdGpBl+7GC0ezNvGZnF4foXF
        1IdP2Cy+b7nOZDHvs6zF3tdb2S2+Xelgstj0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i4nH
        JjNbrD1yl91i7pepzBZPHvaxOQh4rJm3htFj56y77B6L97xk8ti0qpPN4861PWwem5fUe/Rt
        WcXo8XmTXABHFJdNSmpOZllqkb5dAlfG+tcNjAV31Cs63ts0MC5T6GLk4JAQMJGYd1Kri5GL
        Q0hgBaPExF0LWSCcL4wSr5qbWCGcz4wS3w9eY+pi5ATruHroIxNEYjmjxOeOPcwQTiuTxL3f
        99lAqtgEDCQevFnGDmKLCLQySsxsUgcpYhb4yixx9fV8ZpCEsEC0xJpX/SwgNouAqsThZdPA
        bF4BW4kzh7eyQKyTl9iz6DvYak4BO4m2I8/ZIGoEJU7OfAJWwwxU07x1NtgVEgL9nBKP7y5n
        hmh2kdiy/C/U3cISr45vYYewZST+75wPFc+XmLH5PQskNCok7h70gjCtJT6eYQYxmQU0Jdbv
        0ocodpT4MPcbK0QFn8SNt4IQB/BJTNo2nRkizCvR0SYEUa0qcXzPJKhTpCWetNxmgijxkNh5
        P38Co+IsJJ/MQvLJLIS1CxiZVzGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgQmtdP/jn/d
        wbji1Ue9Q4xMHIyHGCU4mJVEeL8JRaQK8aYkVlalFuXHF5XmpBYfYpTmYFES51VNkU8VEkhP
        LEnNTk0tSC2CyTJxcEo1MCkLLViYJ/145oynJrPsfinIRYXoB6xdvyZ82a6sHvviG7dqb+2d
        aT3l86d59Uc+2zYsLmHm23nld1bcopP/LOJfT9p1ZmNroYsP46zetWdqp1vu2vS408v7+lHr
        G9vXPJXz9Xb5niXa1pahLXHd4LHOhAsbj53yO/ZCLfd+p786y4WpO9q2HzpntO59yGnF4z+u
        1Tvd9V/45MGkKwde91tPjn7SYN8S1VW3nnnSwvy4B2oV18+kcv/068x4X6s+T3TpxtpZB6V8
        wssvJ7R/cZdS/RqgksRZ3v9soeaX8uoK16mO5Q9FNSN/94ScLutjFF2+x+5vj6u8CmPqYQ+X
        5EizDV5MOUtzLx+wzagQllFiKc5INNRiLipOBADxwxt32QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xe7pRRdGpBnc3Klk8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2M9a8bGAvuqFd0vLdpYFym0MXIySEhYCJx9dBHpi5GLg4hgaWMElvW3WSGSEhLHP4y
        hR3CFpb4c62LDaKomUniwqdWsASbgIHEgzfL2EESIgKdjBJdm88xgSSYBf4zS3ydCbZCWCBS
        out6PyOIzSKgKnF42TQWEJtXwFbizOGtLBAb5CX2LPoO1sspYCfRduQ50DYOoG22Eh13NSDK
        BSVOznzCAjFeXqJ562zmCYwCs5CkZiFJLWBkWsUoklpanJueW2yoV5yYW1yal66XnJ+7iREY
        hduO/dy8g3Heq496hxiZOBgPMUpwMCuJ8H4TikgV4k1JrKxKLcqPLyrNSS0+xGgKdPZEZinR
        5HxgGsgriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamCarMR+/d+D
        VT+mBU7awyW46T6PVYvgt6qtn7l0erjzVy8pnc1++cDv/VPXpks4+mkbnpn2/K3yX9lr0x7b
        HFG7GOn4zU+ewVRpW7PfKZ6aiLlGrnyMKgkSM3geds5iqr62Ret+EKeypHTg5YyqaRMu/VY6
        eqs6su51e9e10yt+bW+WO+fV43b01/36X8pTfi7uXjk/ry2UocRTZ+tG/RtVyk94NxQLLnxo
        JcxSXrtl9aYnz38ws7ofaMh64fz+v2E/46m1Z5XW3WhXy4uO4pPSPsTG6K9yx5olaeK9rD4W
        HauQP1rPJNdaSep9lvrw537E7g/BD/9oRl07Uf0sVsElyrJBP6Wk6Zj6zvuyzbOUWIozEg21
        mIuKEwHgfQqfSwMAAA==
X-CMS-MailID: 20231120145106eucas1p1964c7fdc0297d538faa0aeb20190d178
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231120145106eucas1p1964c7fdc0297d538faa0aeb20190d178
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231120145106eucas1p1964c7fdc0297d538faa0aeb20190d178
References: <20231120145049.310509-1-m.majewski2@samsung.com>
        <CGME20231120145106eucas1p1964c7fdc0297d538faa0aeb20190d178@eucas1p1.samsung.com>
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

This will be needed in the future, as the thermal zone subsystem might
call our callbacks right after devm_thermal_of_zone_register. Currently
we just make get_temp return EAGAIN in such case, but this will not be
possible with state-modifying callbacks, for instance set_trips.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v3 -> v4: Reordered calls done while leaving exynos_tmu_initialize so
  that they mirror the calls done while entering this function.
v1 -> v2: We take clocks into account; exynos_tmu_initialize needs both
  clocks, as tmu_initialize might use the base_second registers. However,
  exynos_thermal_zone_configure only needs clk.

 drivers/thermal/samsung/exynos_tmu.c | 104 +++++++++++++++------------
 1 file changed, 60 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index d918bf6d5359..6b3a7dd05c68 100644
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

