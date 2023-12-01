Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043E78007B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378194AbjLAJ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378124AbjLAJ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:56:42 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC5E1700
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:56:47 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231201095645euoutp02c413ff9d4396ff9510cfbe6a593a8673~crKocxDQ70718307183euoutp02k
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:56:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231201095645euoutp02c413ff9d4396ff9510cfbe6a593a8673~crKocxDQ70718307183euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701424605;
        bh=SZ2xtU4liTdPRXyiaem1RPsDZRIMzUg5tNmbRIlLQxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPdqa/PA8VB5f9dzFdPqruddLjVrn9V9TtFFUU61fgVec6noMvfMMqZZF8eYVtm17
         0sMH9Q4hHPo5v/H930Whpx9foV6vfXWnvuX/HegKRoU/mm5e/6xlrrIKZNM7gfBZVQ
         8XXgDd1mbfhWYeocRLepma08OpCWUwE59IDuYdH8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231201095645eucas1p1540cfcf24aeb003fddd7fba1142877bb~crKn5IlAo2916929169eucas1p19;
        Fri,  1 Dec 2023 09:56:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D8.42.09814.DDDA9656; Fri,  1
        Dec 2023 09:56:45 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231201095644eucas1p1818772bfce0bbf2109ec5fbf928f603a~crKndfPZS0264702647eucas1p17;
        Fri,  1 Dec 2023 09:56:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231201095644eusmtrp1355d61e56b3522ef2f4d5966cf96dbbb~crKnbZVWJ0736407364eusmtrp1E;
        Fri,  1 Dec 2023 09:56:44 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-f6-6569adddb029
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9C.20.09146.CDDA9656; Fri,  1
        Dec 2023 09:56:44 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231201095643eusmtip2f56a985d7babd097d0d614b1d6d6d9e3~crKmjGzh21190911909eusmtip26;
        Fri,  1 Dec 2023 09:56:43 +0000 (GMT)
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
Subject: [PATCH v6 5/9] thermal: exynos: simplify regulator
 (de)initialization
Date:   Fri,  1 Dec 2023 10:56:21 +0100
Message-ID: <20231201095625.301884-6-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201095625.301884-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7djP87p312amGly5yGPxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4Mr4fmEjS8EKuYrJk1cxNjDuluhi5OSQEDCR
        OL5vBnsXIxeHkMAKRonP/5ZCOV8YJU4t28II4XwGyjz9yATTcvHdUSaIxHJGiUeH/jFDOK1M
        ElPevwerYhMwkHjwZhk7iC0i0MooMbNJHcRmFljIItHyLxfEFhYIkOh/0snSxcjBwSKgKtF3
        uxQkzCtgK3Hm/RRmiGXyEnsWfQcbySlgJzH/UCsLRI2gxMmZT1ggRspLNG+dDXaDhMBsTolJ
        U66xQDS7SExbt5cRwhaWeHV8CzuELSNxenIPVE2+xIzN78FukBCokLh70AvCtJb4eIYZxGQW
        0JRYv0sfIuoo8Xe3K4TJJ3HjrSDEfj6JSdumM0OEeSU62oQgJqtKHN8zCeoNaYknLbeZIEo8
        JL4vSp3AqDgLySOzkDwyC2HrAkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIHJ7fS/
        4192MC5/9VHvECMTB+MhRgkOZiUR3utP01OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ86qmyKcK
        CaQnlqRmp6YWpBbBZJk4OKUamHTkXRdeLE1wVClc7+zV2De54BpHptzPe5V/ZqVLpxp803su
        rXZoR3DHxwPhnYqfVAz6fDSO3DdMP1D8M9Jywhwzi+UuN3jXKP64tfnr9rnXHBRqVnN0Jl/V
        f7tpPfck9aVL+XVn7auYm/XCM3uj7xOtvwECgt3H60w2rXo/e0eb5FpN9TlunnFHtmtw1Bza
        ltXVvfPB6cwM5a+Z1vrxU3bNCnZkzDp+UkrJL6IyqNL5hNmLLRc2v9ba1PNVs+PrBlaZLJ2W
        xKTj6w8nXm9xcrX/WmhR13KHldvi7+8mp77irZ6NltEG82ymm9t0yE7deMmL/+WOig8zNCey
        9iiUmRss4k32b7A4U1izIPalEktxRqKhFnNRcSIA/qLQwd0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7p31mamGtxfr2XxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0Mv4fmEjS8EKuYrJk1cxNjDuluhi5OSQEDCRuPjuKBOILSSwlFFi8ToziLi0
        xOEvU9ghbGGJP9e62LoYuYBqmpkkbt7/wwqSYBMwkHjwZhk7SEJEoJNRomvzOSYQh1lgNYvE
        sX3fwcYKC/hJbF50nqWLkYODRUBVou92KUiYV8BW4sz7KcwQG+Ql9iyCKOcUsJOYf6iVBeIi
        W4muLf8ZIeoFJU7OfAIWZwaqb946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+oVJ+YWl+al
        6yXn525iBEbktmM/N+9gnPfqo94hRiYOxkOMEhzMSiK815+mpwrxpiRWVqUW5ccXleakFh9i
        NAU6eyKzlGhyPjAl5JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1
        MM06w7xE6672JIE92eoiEt9NQlZee/wv4eenQ66nrnhPlj4VN+eCH8MOEbGfEveO7OZjz76p
        dCD3wY2NmT+/rjY13bB0c1jCp6qufPaj8zZqPytew551pTzExCPX7mqE6V9xP9uAbQcVrX8K
        9MssfPPCv+CiUYm2Vln4g+sL5kgVSHSYvFDyzPnFtHpqZYTXug2fVaZ6v3HxnVR47fOW2/X3
        atI27MiYdG//wlDRi4tznQRmyX22mq2rEn1d3fFT3DbZ1xWb1/3sn8+0f1Z6zK9VkxSYFiq/
        t4rzEdWt3WKyZbLJ9JUNW5+5iwbnuS2bVvi392N0oPvp1eq3O/4al0/zOikSseCuVZTy/lcs
        ZhVKLMUZiYZazEXFiQCRuzSKUQMAAA==
X-CMS-MailID: 20231201095644eucas1p1818772bfce0bbf2109ec5fbf928f603a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231201095644eucas1p1818772bfce0bbf2109ec5fbf928f603a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231201095644eucas1p1818772bfce0bbf2109ec5fbf928f603a
References: <20231201095625.301884-1-m.majewski2@samsung.com>
        <CGME20231201095644eucas1p1818772bfce0bbf2109ec5fbf928f603a@eucas1p1.samsung.com>
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

We rewrite the initialization to enable the regulator as part of devm,
which allows us to not handle the struct instance manually.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v3 -> v4: Resolved merge conflict and moved info about not outputting
  error to the correct commit message.
v2 -> v3: Fixed error handling of devm_regulator_get_optional to handle
  the case in which the regulator is available, but enabling it fails.
  Also removed the error message, split into two commits and reworded
  the commit message.

 drivers/thermal/samsung/exynos_tmu.c | 49 +++++++++-------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 8bcad8a70dc5..3bdcbab7466f 100644
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
 
@@ -1124,9 +1108,6 @@ static void exynos_tmu_remove(struct platform_device *pdev)
 	clk_unprepare(data->clk);
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
-
-	if (!IS_ERR(data->regulator))
-		regulator_disable(data->regulator);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.42.0

