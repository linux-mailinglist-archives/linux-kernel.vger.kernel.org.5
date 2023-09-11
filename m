Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BD179B1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbjIKWeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238077AbjIKNgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:36:23 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C419F1A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:36:18 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230911133617euoutp0129c9302d7f93edbd91795f742497eed7~D26LvtL-x2490624906euoutp01M
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:36:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230911133617euoutp0129c9302d7f93edbd91795f742497eed7~D26LvtL-x2490624906euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694439377;
        bh=XK7PxtizlL9SCG8mpzlPzuWhrWWnEfkUq3uRXLUzkvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JhzOz5pi0iGal+9x88x/9a/faJyiiRDNUpkdAoaaE4KZbaSlXbSQ4GEXDLUj9TSBF
         HES1YrZO5P+uBmabW+AjMOwZIt5IBisORpoTBWgXYRyabWUcIS7ARXPzIEnKOMlF0Y
         tSsmov2rKJkNNPt4943Szhd4BOv2GojIE15XL3xo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230911133617eucas1p2852362073e5b3efcfe5a588de775a982~D26LdnZAl1712617126eucas1p2m;
        Mon, 11 Sep 2023 13:36:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5F.03.37758.1D71FF46; Mon, 11
        Sep 2023 14:36:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230911133616eucas1p10c5eeb0f0240dde975ccc5935cb5c311~D26LG-1cl1320013200eucas1p1r;
        Mon, 11 Sep 2023 13:36:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230911133616eusmtrp263c0d6531ca98ddf4e69411c98dadc0a~D26LGV6d60864008640eusmtrp2f;
        Mon, 11 Sep 2023 13:36:16 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-68-64ff17d13616
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A1.8A.14344.0D71FF46; Mon, 11
        Sep 2023 14:36:16 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230911133615eusmtip2d8a0d394a91b865243032bb81b27e6ea~D26KEkLPs3194931949eusmtip2U;
        Mon, 11 Sep 2023 13:36:15 +0000 (GMT)
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
Subject: [PATCH v2 4/7] thermal: exynos: simplify regulator
 (de)initialization
Date:   Mon, 11 Sep 2023 15:34:28 +0200
Message-ID: <20230911133435.14061-5-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911133435.14061-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djP87oXxf+nGLz6IWTxYN42NovD8yss
        pj58wmbxfct1Jot5n2Ut9r7eym7x7UoHk8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCwmHpvMbLH2
        yF12i7lfpjJbPHnYx+bA77Fz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9+rasYvT4vEkugD2K
        yyYlNSezLLVI3y6BK+Pf3IMsBZ8kKm5/OcbYwDhDpIuRk0NCwETi8KMJrF2MXBxCAisYJS7c
        u88I4XxhlFi3aR47hPOZUeLEvt/sMC3HWicyQSSWM0rs7W6Aqmplkvg8fzITSBWbgIHEgzfL
        wDpEBFoZJWY2qYMUMQtcYpa4e3MtC0hCWCBA4v78I2wgNouAqsTTdx/A4rwCNhL/1u1hhlgn
        L/H81h2wQZwCthJn105nh6gRlDg58wlYPTNQTfPW2cwgCyQEmjklvm85zQLR7CLxsvc41CBh
        iVfHt0D9ICPxf+d8Jgg7X2LG5vdA9RxAdoXE3YNeEKa1xMczzCAms4CmxPpd+hDFjhIbNvxn
        h6jgk7jxVhDiAD6JSdumM0OEeSU62oQgqlUlju+ZBLVeWuJJy20miBIPiYffxCcwKs5C8sks
        JJ/MQli7gJF5FaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmASO/3v+NcdjCtefdQ7xMjE
        wXiIUYKDWUmEt+TQ3xQh3pTEyqrUovz4otKc1OJDjNIcLErivNq2J5OFBNITS1KzU1MLUotg
        skwcnFINTOzvT+yedzIzgVuZ96G9IPeK1ouzru9ebMKmOdF2Q6jI7G6l/KpzYTo6KovVF1gY
        6nW833VersUw88ROVqWZ0xuVIk+9mvcu7lpw+/Zfoh0l6hGhdSaKgTPurloYVi7Q+sxNRCtv
        f+5aPsczC9SC+mtnd+kmX/3SwTYng+2Ea6mi/fZdbA8DrvguYdh+b/uM8L1hy2/8vyIVOfFw
        6acwkW+FZRYur2Van6kvuWt3M7pCYGdDgo+SSqu+r9qFO9tv8NcsWTDv3p8WwW8nFswR/nb3
        ePdz7vflX0/o2V/ZxnJqqsel60Izpm5Ofrmpc+f08jkr76Xvea3wucv2QfnmzYtZ/KLE7kXV
        LAxSLLpulK3EUpyRaKjFXFScCAAQsjYT0QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xe7oXxP+nGNz6YGzxYN42NovD8yss
        pj58wmbxfct1Jot5n2Ut9r7eym7x7UoHk8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCwmHpvMbLH2
        yF12i7lfpjJbPHnYx+bA77Fz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9+rasYvT4vEkugD1K
        z6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+Pf3IMs
        BZ8kKm5/OcbYwDhDpIuRk0NCwETiWOtEJhBbSGApo8SzGQkQcWmJw1+msEPYwhJ/rnWxdTFy
        AdU0M0lM//GHGSTBJmAg8eDNMnaQhIhAJ6NE1+ZzYJOYBW4xS9x/rdXFyMEhLOAnMeETK0iY
        RUBV4um7DywgNq+AjcS/dXuYIRbISzy/dQdsGaeArcTZtdPZQVqFgGr6z+hAlAtKnJz5hAVi
        urxE89bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMN62Hfu5ZQfj
        ylcf9Q4xMnEwHmKU4GBWEuEtOfQ3RYg3JbGyKrUoP76oNCe1+BCjKdDZE5mlRJPzgRGfVxJv
        aGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXA1P/QzTnC3afI1HN27uaJ
        bW9aNJtCHxX0rft+4PRFzxD9hpvTn15do7F6y+Ja16+zdj/ZdCPVk0lXNncjo9etExv+dM8S
        ik3oFn6+8MPU46UOb6QTimsN3Z6uVvav337I78N5/l2qL1mNPGpmxEilZ/XPPLCrSOXDoVmT
        Oi+Uzmg63pd0SEjIWPhO9A9Hvtxf6Tp2h+K6XLbMMbqRq8K6oa/hgKXhsfWBx53F2idaHnS3
        7j9mvER84ZFT3puSJ0W8niw04cyi1WEdbb83r2xZsfjQp1cFYbv38nQcvuhkELPk0v3yEP/P
        p0INjP+aWga3f1/m3Pdxj07nSzUBrf06tckONfLP4+8sC/QI1dW9pcRSnJFoqMVcVJwIAP7Z
        hWlAAwAA
X-CMS-MailID: 20230911133616eucas1p10c5eeb0f0240dde975ccc5935cb5c311
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230911133616eucas1p10c5eeb0f0240dde975ccc5935cb5c311
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230911133616eucas1p10c5eeb0f0240dde975ccc5935cb5c311
References: <20230911133435.14061-1-m.majewski2@samsung.com>
        <CGME20230911133616eucas1p10c5eeb0f0240dde975ccc5935cb5c311@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This does reduce the error granularity a bit, but the code
simplification seems to be worth it.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 33 +++++++---------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ba9414b419ef..8451deb65f43 100644
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
@@ -994,42 +992,34 @@ static int exynos_tmu_probe(struct platform_device *pdev)
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
-		if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
+	ret = devm_regulator_get_enable_optional(&pdev->dev, "vtmu");
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
-		dev_info(&pdev->dev, "Regulator node (vtmu) not found\n");
+		dev_info(&pdev->dev, "Failed to get regulator node (vtmu)\n");
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
 
@@ -1099,10 +1089,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 err_clk_sec:
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
-err_sensor:
-	if (!IS_ERR(data->regulator))
-		regulator_disable(data->regulator);
-
 	return ret;
 }
 
@@ -1117,9 +1103,6 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
 
-	if (!IS_ERR(data->regulator))
-		regulator_disable(data->regulator);
-
 	return 0;
 }
 
-- 
2.41.0

