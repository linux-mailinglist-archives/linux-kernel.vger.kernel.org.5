Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95257F1659
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjKTOwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjKTOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:52:01 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346351716
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:51:08 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231120145105euoutp02fe3dafa199b6cd115723c661c0a90830~ZXFeGTCe12495724957euoutp02U
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:51:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231120145105euoutp02fe3dafa199b6cd115723c661c0a90830~ZXFeGTCe12495724957euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700491865;
        bh=SZ2xtU4liTdPRXyiaem1RPsDZRIMzUg5tNmbRIlLQxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRkMYLgECGbDZuAC16i7Z074sz03zc/RS5f2Hw8GceDNDV+vlQL3f6Hz6B8dZLFXg
         dfoFQE2ehoktZUrvfmHDgeoqbYwA8/yNkVQ/mae6RfjuVu61l1X5XzSACBiIhs6E9x
         Fbx5M0f4jWAylM8bNH40D+mGJz4m9lQ/O1RkrF/I=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231120145104eucas1p20f74dc6a127503ebc00e387d9a634902~ZXFdrO2ae2766127661eucas1p2J;
        Mon, 20 Nov 2023 14:51:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 26.A8.09552.8527B556; Mon, 20
        Nov 2023 14:51:04 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231120145104eucas1p122668d13b89b1f65356ab7cb717e9a5e~ZXFdOx-sO2333923339eucas1p13;
        Mon, 20 Nov 2023 14:51:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231120145104eusmtrp25207acc34ecc76f70f09d81a87362d22~ZXFdOCmlr0700707007eusmtrp2p;
        Mon, 20 Nov 2023 14:51:04 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-88-655b72587fd2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 28.C3.09146.8527B556; Mon, 20
        Nov 2023 14:51:04 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231120145103eusmtip2b3b3275f2c9b17d5489c7bc9310ab4d1~ZXFcYf-wn1340113401eusmtip2D;
        Mon, 20 Nov 2023 14:51:03 +0000 (GMT)
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
Subject: [PATCH v5 5/9] thermal: exynos: simplify regulator
 (de)initialization
Date:   Mon, 20 Nov 2023 15:50:45 +0100
Message-ID: <20231120145049.310509-6-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120145049.310509-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87oRRdGpBkf+a1s8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKC6blNSczLLUIn27BK6M7xc2shSskKuYPHkVYwPjbokuRk4OCQETiXNX77GA
        2EICKxglGl8A2VxA9hdGiYMN7xghnM+MEpNnvWGH6diydz8rRGI5o8TzC0eZIZxWJolty6+C
        zWITMJB48GYZWIeIQCujxMwmdZAiZoGvzBJXX89nBkkICwRITP17E6yBRUBV4uSzhWwgNq+A
        rUT/g8dMEOvkJfYs+g5mcwrYSbQdeQ5VIyhxcuYTsF5moJrmrbPBrpAQ6OeU6Pp6BqrZRWL7
        44dQtrDEq+NboH6Qkfi/cz5UPF9ixub3QIM4gOwKibsHvSBMa4mPZ5hBTGYBTYn1u/Qhoo4S
        Z8/XQJh8EjfeCkLs55OYtG06M0SYV6KjTQhisqrE8T2TmCFsaYknLbehNnpI/H+/lmkCo+Is
        JJ/MQvLJLIS1CxiZVzGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgSmtdP/jn/dwbji1Ue9
        Q4xMHIyHGCU4mJVEeL8JRaQK8aYkVlalFuXHF5XmpBYfYpTmYFES51VNkU8VEkhPLEnNTk0t
        SC2CyTJxcEo1MK29bJUyZ9sVIxVdpjWnJ3RcMt/pwW/p1ORuZeD5a0bMg9CZj9I4VTJ/qvcI
        eqlNzpWU/1Oy7rbN/6Pny0LvXzuZvWAj++qtNur8pgGTDDnXn6m4mpu7MezqjVvrBTyldwf8
        arj1juGw6AW91kkvjj+d0BPFFbHoWcP+qTJzOaf/+n3x88+lr3fwF7i9/fhUpenKUyZ2g5cV
        7aaa3yRK/y602XA/51j8jPyrPFEK8t0Ma+6c+7q44suath0dlceCbU1+Gx06LCJ54c2nx46R
        XfoVPemry3N0Ns36ce6KydaC798DIh6Z+/BesdG/teDmAWv5A937mQ6aLmHqys6UVmc9qhmy
        bRub3q6qKi0hyzolluKMREMt5qLiRAD40r6s2gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7oRRdGpBi9PClo8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2M7xc2shSskKuYPHkVYwPjbokuRk4OCQETiS1797N2MXJxCAksZZR48GMRC0RCWuLw
        lynsELawxJ9rXWwQRc1MEt9uXAcrYhMwkHjwZhk7SEJEoJNRomvzOSaQBLPAf2aJrzMVQGxh
        AT+Jy4d/MYLYLAKqEiefLWQDsXkFbCX6HzxmgtggL7Fn0Xcwm1PATqLtyHOgGg6gbbYSHXc1
        IMoFJU7OfMICMV5eonnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJ
        ERiH24793LyDcd6rj3qHGJk4GA8xSnAwK4nwfhOKSBXiTUmsrEotyo8vKs1JLT7EaAp09kRm
        KdHkfGAiyCuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYFomfiSu
        J/b5u26hB9wTbVm0KztKJsdl2R8zXzpP769w9O7kDQ0TLkTn5GjrMbxs8PPjkfgUEnTrw7NI
        8z3pf2VTeif7KOnZxS9YacJV13L6ayBTuP/3MPWA86ZpCeHa3csqbQqmG20INr4w+QbTNf5l
        SYxbquX1Tj1KUJGqOahW8EXG8g6bnPyaH/9VRTbJf75pbX4uuKam0tD6usilyQ+Ts8Kva7JE
        GX4tEZh9u7Zq35qrwtHHG+3Yr96/0enY9u/toefrvs/PaEld6Hll0pWIgz753qV/gnQXnZMy
        2f1KJO+CFMulbaGlTLtOXdbmdLE51tpb+G6z7bNb5rx8L73PZ/+9F3fxSPHVGvFNSizFGYmG
        WsxFxYkASoVY4kwDAAA=
X-CMS-MailID: 20231120145104eucas1p122668d13b89b1f65356ab7cb717e9a5e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231120145104eucas1p122668d13b89b1f65356ab7cb717e9a5e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231120145104eucas1p122668d13b89b1f65356ab7cb717e9a5e
References: <20231120145049.310509-1-m.majewski2@samsung.com>
        <CGME20231120145104eucas1p122668d13b89b1f65356ab7cb717e9a5e@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

