Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BCA7B67AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240029AbjJCLR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJCLRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:17:17 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C300FC6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:17:13 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231003111712euoutp019bf2c673b69e825a2c1ca8fa533335bc~KlNBSnfFx1220212202euoutp01i
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:17:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231003111712euoutp019bf2c673b69e825a2c1ca8fa533335bc~KlNBSnfFx1220212202euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696331832;
        bh=V2/Mzb3I7DEQaqQIC0PslVbUjHF4j1Sq8nv+9t2b3y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ID8Z0dMgZk+xiF2qNL2+N6JaBTVz382TOqb5TM/xLHmD7qDMPhtEm3fGceNm90zfS
         FsVx34UX8I+7D5i4c5fN5mnl4p1i7Ee5PHyqX4RcgCx/HCuhKK3rNo5qOdPzPa2vLg
         H9QUV2HqJNoIEujnW73FVqm8EsS9Jbpj/nW4m80o=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231003111711eucas1p1628e726b548802c3befcd088761ae329~KlNA48lQA2460224602eucas1p1x;
        Tue,  3 Oct 2023 11:17:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D4.2F.37758.738FB156; Tue,  3
        Oct 2023 12:17:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111711eucas1p2646dcfd2d7d473b78b012153bca06cc7~KlNASNH_30433204332eucas1p2N;
        Tue,  3 Oct 2023 11:17:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231003111711eusmtrp1323c66d180ae07f5752a597299e8ac54~KlNARkQSH2239722397eusmtrp1B;
        Tue,  3 Oct 2023 11:17:11 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-e5-651bf837e354
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 80.DE.25043.638FB156; Tue,  3
        Oct 2023 12:17:10 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111710eusmtip2f6c814e4b6d39c4deec3ca73aa73b069~KlM-ax1nA2844228442eusmtip2E;
        Tue,  3 Oct 2023 11:17:10 +0000 (GMT)
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
Subject: [PATCH v3 5/8] thermal: exynos: simplify regulator
 (de)initialization
Date:   Tue,  3 Oct 2023 13:16:31 +0200
Message-ID: <20231003111638.241542-6-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003111638.241542-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87rmP6RTDT5sULZ4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB7F
        ZZOSmpNZllqkb5fAlXH3xTGWgu2yFUvX32JvYLwk3sXIwSEhYCKxY1VuFyMXh5DACkaJ768X
        MEM4Xxgl5k14zQjhfGaUmLZxIZDDCdYxq68Jqmo5o8SZZb+hnFYmiY/fF7CBVLEJGEg8eLOM
        HcQWEWhllJjZpA5SxCxwiVni7s21LCAJYYEAic43DWBjWQRUJT7+/QPWzCtgK/Fu6XZ2iHXy
        EnsWfWcCsTkF7CRW/lzOBFEjKHFy5hOwOcxANc1bZ4NdISHQzCnx9OEeJohmF4m9/25CDRKW
        eHV8C5QtI3F6cg8LhJ0vMWPzexZIaFRI3D3oBWFaS3w8wwxiMgtoSqzfpQ9R7Cix5P8rdogK
        PokbbwUhDuCTmLRtOjNEmFeio00IolpV4vieScwQtrTEk5bbTBAlHhKntmhOYFScheSTWUg+
        mYWwdgEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzAFHb63/GvOxhXvPqod4iRiYPx
        EKMEB7OSCG/YUalUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzatieThQTSE0tSs1NTC1KLYLJM
        HJxSDUzLxQ5OUL+4a+XnhZEP9Wv/Sj8oEogq9dJLSnmlbHfL78XZFQoZJ7bvyLx/cXHky8f2
        3c2ufpdScnoMr09jE/28tHr/yuXxLGcWSWn8dxaIv1OaoGAnKCLv0lao1bVm05v2ZyEdgQHr
        Td8EuRx7oXk+ODd18cKTwdZhry6Fhu97/CvHUfWN0QVjBzdt/65/f1YuZTv961Mox0ef9LdC
        EjPTdpuncLNumSw5z2DPrten1p+bJentdiz5XsJTacMag4CbGoLf+F6WTWgWXzHtXKT3C6UA
        u0uaIneCr9Z9+vDqlZ6ZrI3aw0g1q9BPUyRNxEXO536an3F1Z92Zm3HcZ5n6Zh+f0ZFtuVL9
        6RVFyUIlluKMREMt5qLiRAB5rQx20AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7pmP6RTDU7sM7N4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB6l
        Z1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3H3xTGW
        gu2yFUvX32JvYLwk3sXIySEhYCIxq6+JGcQWEljKKLG5Kw0iLi1x+MsUdghbWOLPtS62LkYu
        oJpmJombLzoYQRJsAgYSD94sYwdJiAh0Mkp0bT7HBJJgFrjFLHH/tRaILSzgJ3FiwnRWEJtF
        QFXi498/bCA2r4CtxLul26E2yEvsWfQdrJdTwE5i5c/lTBAX2UrcWr6PBaJeUOLkzCcsEPPl
        JZq3zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIExt+3Yzy07GFe+
        +qh3iJGJg/EQowQHs5IIb9hRqVQh3pTEyqrUovz4otKc1OJDjKZAd09klhJNzgdGfV5JvKGZ
        gamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA1NBnW/gW1bl+E6XnT+rq7bv
        WFyZI2sc8lKDdd7p+w78wb9vCHjLH8h5WLTEpT3jh1vucc0z0zRDn+k72fdJMm53Pbr/1nmL
        j8e+6Fxpmc75obiZN2it0dNlZ9TaVZfkWm8oMPkbdsLVJfVsTOXvjUfS1CeWVx4rurbg8r2l
        s468NmjbuNlsfaPJc6He1zx56qLdVTXeiY+Up13hfb5CfcKK+6bfj6t+L/+TlL/Zm3vl41Wx
        7ItOiswRWxC40OPiis8N/xfMn5Cuq3u25urlG40rEm9HKnpJp531OHZijlZK+vsfX790zDpZ
        Zvj33PF+o1Tj+/Y1Dfo5vL61K3dKLlJmdQhNOrvKaVXqbavAvE9KLMUZiYZazEXFiQCZM+zK
        QgMAAA==
X-CMS-MailID: 20231003111711eucas1p2646dcfd2d7d473b78b012153bca06cc7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231003111711eucas1p2646dcfd2d7d473b78b012153bca06cc7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231003111711eucas1p2646dcfd2d7d473b78b012153bca06cc7
References: <20231003111638.241542-1-m.majewski2@samsung.com>
        <CGME20231003111711eucas1p2646dcfd2d7d473b78b012153bca06cc7@eucas1p2.samsung.com>
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

We rewrite the initialization to enable the regulator as part of devm,
which allows us to not handle the struct instance manually. We also
remove the error message in case the regulator is unavailable, as this
is expected behaviour.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v2 -> v3: fixed error handling of devm_regulator_get_optional to handle
  the case in which the regulator is available, but enabling it fails.
  Also removed the error message, split into two commits and reworded
  the commit message.

 drivers/thermal/samsung/exynos_tmu.c | 49 +++++++++-------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 6070b03cff9d..a0a1f7e1e63f 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -157,7 +157,6 @@ enum soc_type {
  * @reference_voltage: reference voltage of amplifier
  *	in the positive-TC generator block
  *	0 < reference_voltage <= 31
- * @regulator: pointer to the TMU regulator structure.
  * @tzd: pointer to thermal_zone_device structure
  * @ntrip: number of supported trip points.
  * @enabled: current status of TMU device
@@ -183,7 +182,6 @@ struct exynos_tmu_data {
 	u16 temp_error1, temp_error2;
 	u8 gain;
 	u8 reference_voltage;
-	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
 	unsigned int ntrip;
 	bool enabled;
@@ -994,50 +992,40 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	 * TODO: Add regulator as an SOC feature, so that regulator enable
 	 * is a compulsory call.
 	 */
-	data->regulator = devm_regulator_get_optional(&pdev->dev, "vtmu");
-	if (!IS_ERR(data->regulator)) {
-		ret = regulator_enable(data->regulator);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to enable vtmu\n");
-			return ret;
-		}
-	} else {
-		ret = PTR_ERR(data->regulator);
-		switch (ret) {
-		case -ENODEV:
-			break;
-		case -EPROBE_DEFER:
-			return -EPROBE_DEFER;
-		default:
-			dev_err(&pdev->dev, "Failed to get regulator: %d\n",
-				ret);
-			return ret;
-		}
+	ret = devm_regulator_get_enable_optional(&pdev->dev, "vtmu");
+	switch (ret) {
+	case 0:
+	case -ENODEV:
+		break;
+	case -EPROBE_DEFER:
+		return -EPROBE_DEFER;
+	default:
+		dev_err(&pdev->dev, "Failed to get enabled regulator: %d\n",
+			ret);
+		return ret;
 	}
 
 	ret = exynos_map_dt_data(pdev);
 	if (ret)
-		goto err_sensor;
+		return ret;
 
 	data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
 	if (IS_ERR(data->clk)) {
 		dev_err(&pdev->dev, "Failed to get clock\n");
-		ret = PTR_ERR(data->clk);
-		goto err_sensor;
+		return PTR_ERR(data->clk);
 	}
 
 	data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
 	if (IS_ERR(data->clk_sec)) {
 		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
 			dev_err(&pdev->dev, "Failed to get triminfo clock\n");
-			ret = PTR_ERR(data->clk_sec);
-			goto err_sensor;
+			return PTR_ERR(data->clk_sec);
 		}
 	} else {
 		ret = clk_prepare(data->clk_sec);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to get clock\n");
-			goto err_sensor;
+			return ret;
 		}
 	}
 
@@ -1107,10 +1095,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 err_clk_sec:
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
-err_sensor:
-	if (!IS_ERR(data->regulator))
-		regulator_disable(data->regulator);
-
 	return ret;
 }
 
@@ -1125,9 +1109,6 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
 
-	if (!IS_ERR(data->regulator))
-		regulator_disable(data->regulator);
-
 	return 0;
 }
 
-- 
2.42.0

