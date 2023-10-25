Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ADA7D6D47
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344581AbjJYNbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344611AbjJYNbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:31:03 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDD31B1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:31:00 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231025133059euoutp02003706e74322b0d4edb7df7194d019ad~RXOHMtyiA1190011900euoutp02n
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:30:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231025133059euoutp02003706e74322b0d4edb7df7194d019ad~RXOHMtyiA1190011900euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698240659;
        bh=HFjJa1RguNICip8Nann+GThTo5GBNLI3URdePUvmffE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZnpX9HH0dxpg/Fb8UgwEWRPgmQ2/XFHTfdBBGsTgwk/IGA05MOVeX4anW/ntKrOS
         y5NL14fIFSkUIHFN1mhdFKpdoLQIt0e7FO5qogoVfAePkIHerm1z09VKAt6lKhS6Ug
         /BiPplyYdRRNeom3fvKbIFxZh3QF/iacHMqWqcFo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231025133058eucas1p2ae0d7e96fc3ee9387e28f79996425503~RXOGmIoDt2604026040eucas1p2z;
        Wed, 25 Oct 2023 13:30:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 01.1B.37758.29819356; Wed, 25
        Oct 2023 14:30:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231025133058eucas1p149f79722039a90e6e61172ae323b813a~RXOGQN_Qm1623116231eucas1p1O;
        Wed, 25 Oct 2023 13:30:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231025133058eusmtrp2bd86726330a5eef4a72f334cb7034e18~RXOGPR-CE1214112141eusmtrp2S;
        Wed, 25 Oct 2023 13:30:58 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-73-653918925873
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EF.26.25043.29819356; Wed, 25
        Oct 2023 14:30:58 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231025133057eusmtip2debfa402ef1f59ea66a6f1930eb75707~RXOFRU8VK1376613766eusmtip2l;
        Wed, 25 Oct 2023 13:30:57 +0000 (GMT)
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
Subject: [PATCH v4 7/8] thermal: exynos: split initialization of TMU and the
 thermal zone
Date:   Wed, 25 Oct 2023 15:30:26 +0200
Message-ID: <20231025133027.524152-8-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025133027.524152-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7qTJCxTDdp7NCwezNvGZnF4foXF
        1IdP2Cy+b7nOZDHvs6zF3tdb2S2+Xelgstj0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i4nH
        JjNbrD1yl91i7pepzBZPHvaxOQh4rJm3htFj56y77B6L97xk8ti0qpPN4861PWwem5fUe/Rt
        WcXo8XmTXABHFJdNSmpOZllqkb5dAlfG+tcNjAV31Cs63ts0MC5T6GLk5JAQMJG4vGErSxcj
        F4eQwApGiec3prJDOF8YJX482MEIUiUk8JlR4ubMWJiO18+2sEIULWeUuLHzNVR7K5PE3Xmf
        mUGq2AQMJB68WcYOYosItDJKzGxSByliFvjKLHH19XywImGBaImemQ/AVrAIqEps3zCbDcTm
        FbCVODLxOBvEOnmJPYu+M4HYnAJ2Er3Hr0PVCEqcnPmEBcRmBqpp3jqbGWSBhEA3p8TfDweB
        hnIAOS4S2z9JQMwRlnh1fAs7hC0j8X/nfCYIO19ixub3LBDlFRJ3D3pBmNYSH88wg5jMApoS
        63fpQxQ7Slz+vwWqmE/ixltBiP18EpO2TWeGCPNKdLQJQVSrShzfM4kZwpaWeNJyG2qlh8Sd
        zUvYJjAqzkLyySwkn8xC2LuAkXkVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYFI7/e/4
        1x2MK1591DvEyMTBeIhRgoNZSYQ30sciVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBA
        emJJanZqakFqEUyWiYNTqoGJu3bhfq5JP7XP1OsrGd8pWWTz4agRf0Nmwl2rJRPlC/UspDTP
        t8cv2Pz/Yq5HwZ47kwSnbBGM9u/Uvs1dxLT22r0z13Qt2dPlnGvONcmEHpmXtceyNLiw7G3m
        zXitv6U3Tm9LPbIgYjaT063uKyG9ahMSXWpX2qjbz1v6vfzHkcTGQwtaFB23SoZH7803OjF1
        YWblxFQJCcm1IXXxV2a8eG1vvfHhi7Qbho239QzkPVZ6OAZFJm73q7nywslS54JZsWVwn8OB
        i3J+/4LzVib8Ob8i8MjjLMcuCTHxqAtMWyckTpt2bLZP3qyFLrzsJZymi1f/6k2fz7FJm+Ov
        G+e7DQs27Xl+NW+t1yWO4mNKLMUZiYZazEXFiQBxZNdU2QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7qTJCxTDTrfcFg8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2M9a8bGAvuqFd0vLdpYFym0MXIySEhYCLx+tkW1i5GLg4hgaWMEhMeTWGHSEhLHP4C
        YwtL/LnWxQZR1MwkMXv2GhaQBJuAgcSDN8vYQRIiAp2MEl2bzzGBJJgF/jNLfJ0JtkJYIFLi
        wqyrjCA2i4CqxPYNs9lAbF4BW4kjE4+zQWyQl9iz6DtYL6eAnUTv8etgcSGgmgkdD9kh6gUl
        Ts58wgIxX16ieets5gmMArOQpGYhSS1gZFrFKJJaWpybnltspFecmFtcmpeul5yfu4kRGIfb
        jv3csoNx5auPeocYmTgYDzFKcDArifBG+likCvGmJFZWpRblxxeV5qQWH2I0Bbp7IrOUaHI+
        MBHklcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwLVP4tGe2ZvCf
        3W+8BWb/7zROvGjqrrOFPWrHlonVx/s/PZ71zf2cGJsK70X7S49ebi3k3O7P6zwlWzCg+1/9
        WXt+9p7+H0VcNbcZbPc9eLs+SmXKvPmnExKPvxbP5NM2FSp3OeYa98i5+l3h7OvmD2obrfju
        fNe977Wq8Ynd/BLx9sY9T4RXcy1ZXT//chNjXc8yd9cNL6wtfzGkP0thttea7dbDYvnc3+tT
        /PKJSZwNB7/GLi1tLXh77MPuL0cXrE89JRcWplCn/+NkWOnOEi7Oi63pNk9DDavvvW1meCjC
        cGiRd0TsA4buzWYnlaqXlznv+vHwocPKOzNnXlBf8+Ha9uq7+z7/OWBSsdbAUImlOCPRUIu5
        qDgRAGyks51MAwAA
X-CMS-MailID: 20231025133058eucas1p149f79722039a90e6e61172ae323b813a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231025133058eucas1p149f79722039a90e6e61172ae323b813a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231025133058eucas1p149f79722039a90e6e61172ae323b813a
References: <20231025133027.524152-1-m.majewski2@samsung.com>
        <CGME20231025133058eucas1p149f79722039a90e6e61172ae323b813a@eucas1p1.samsung.com>
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

