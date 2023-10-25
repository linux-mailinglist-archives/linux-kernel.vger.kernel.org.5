Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0367D6D26
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344718AbjJYNbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344597AbjJYNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:31:01 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D94C189
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:30:57 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231025133056euoutp019075cfceb328b3921139b42441dcbef2~RXOEd4QAN2920529205euoutp01f
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:30:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231025133056euoutp019075cfceb328b3921139b42441dcbef2~RXOEd4QAN2920529205euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698240656;
        bh=SZ2xtU4liTdPRXyiaem1RPsDZRIMzUg5tNmbRIlLQxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LK+/8XrtshrtjVA0E1AN79caM7yN0+Rlqg9KjW6LQKEB1mUiJEElNb3omF+JLxUwf
         wTD7qahYcedyTWvGSSUomPbZgNtcohL7o64hMBsYV39hEFDaQhJcmFOMJNENP61Nux
         /NgJ+xJi7FzvZeDkNkWAlY8tzI6UnA/uyw5Usp8A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231025133054eucas1p127c5cb897bb40dcf748e7bab9b7faa29~RXOCyci2M1623116231eucas1p1J;
        Wed, 25 Oct 2023 13:30:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 32.F7.42423.E8819356; Wed, 25
        Oct 2023 14:30:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231025133054eucas1p23c3ad3e8a8f96608f5574a3b7910589d~RXOCVOe6a2546925469eucas1p2r;
        Wed, 25 Oct 2023 13:30:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231025133054eusmtrp1c83fbd185478dbc629ba3833705764e0~RXOCUfUts0869708697eusmtrp16;
        Wed, 25 Oct 2023 13:30:54 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-0f-6539188ee5ce
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.A8.10549.D8819356; Wed, 25
        Oct 2023 14:30:54 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231025133053eusmtip2e92e61bda4d306cbc6ba5344d82e7d40~RXOBcVMwi1260512605eusmtip28;
        Wed, 25 Oct 2023 13:30:53 +0000 (GMT)
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
Subject: [PATCH v4 5/8] thermal: exynos: simplify regulator
 (de)initialization
Date:   Wed, 25 Oct 2023 15:30:24 +0200
Message-ID: <20231025133027.524152-6-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025133027.524152-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djP87p9EpapBjOWyFk8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKC6blNSczLLUIn27BK6M7xc2shSskKuYPHkVYwPjbokuRk4OCQETibmbzjN2
        MXJxCAmsYJQ4MWk9lPOFUeJL/24WCOczo8Tyjd1sMC3nT61nhkgsZ5Q4+/kBVFUrk8TZfy8Y
        QarYBAwkHrxZxg5iiwi0MkrMbFIHKWIW+MoscfX1fGaQhLBAgETX+Q5WEJtFQFViw791YHFe
        AVuJy/ueskKsk5fYs+g7E4jNKWAn0Xv8OhtEjaDEyZlPWEBsZqCa5q2zwU6SEOjnlDjW/ZYd
        otlFYtv5PcwQtrDEq+NboOIyEqcn97BA2PkSMza/B7I5gOwKibsHvSBMa4mPZ5hBTGYBTYn1
        u/Qhih0lpjVugirmk7jxVhDiAD6JSdumM0OEeSU62oQgqlUlju+ZBLVeWuJJy20mCNtDoq/5
        AeMERsVZSF6ZheSVWQh7FzAyr2IUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMbaf/Hf+0
        g3Huq496hxiZOBgPMUpwMCuJ8Eb6WKQK8aYkVlalFuXHF5XmpBYfYpTmYFES51VNkU8VEkhP
        LEnNTk0tSC2CyTJxcEo1MIU379Tk+GwYKCKhWtG0SOBmxcEjHltc0i7NdteZpd1143XThTfr
        j3vEZnOKxn78a2K+31vr9DHzc9V1Z9uWS07bcu79KSGrt81CbKe00g5x/f24znc6d4NU+Yf7
        TrtPyD7gVRf8Jyk9gbGdf6XAruLfccsVH912k1vYneeoZitbtXCx1fRVroEpCmyqKZd7Ivlj
        d8+t+luxcNMiJ+6s3zabV4oWzHlf+oYjXdJmzrtn3Deu8F9Z0Kmho8hTnvb68p//09LFUip7
        WOQ9XAqtV9abViWY6Tgbin9K0A7ep8L5pbMoXNFc7Abv3D/yvk+/3/ocdlElaKXRj3+y8kyf
        5gffnT8hRvBCUWM3B3u3EktxRqKhFnNRcSIAhgsCjdwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7p9EpapBltWM1k8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2M7xc2shSskKuYPHkVYwPjbokuRk4OCQETifOn1jN3MXJxCAksZZT4cmc9I0RCWuLw
        lynsELawxJ9rXWwQRc1MEuc+/GADSbAJGEg8eLOMHSQhItDJKNG1+RwTSIJZ4D+zxNeZCiC2
        sICfxKT5N1hBbBYBVYkN/9Yxg9i8ArYSl/c9ZYXYIC+xZ9F3sF5OATuJ3uPXwRYIAdVM6HjI
        DlEvKHFy5hMWiPnyEs1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxN
        jMBI3Hbs5+YdjPNefdQ7xMjEwXiIUYKDWUmEN9LHIlWINyWxsiq1KD++qDQntfgQoynQ3ROZ
        pUST84GpIK8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgWnD++Yl
        2/2s1k90FLbwC2dasJ5FaOby3Y2GCz69dVtbUd6zwLVy1461j43Lo9ZVXf6Xmb3Pv676y9Tv
        Wn+CX1qdjVEXnxjrp5jMP89R7PVptxesy38qxb/Kdo+ruZy9w0lmJ+sh34n8vo/Lky/sXD+L
        Y6moYalpX3Ov1mnNSLWvj56s2Po0JlntfZDT56tS3pdNy25esvifyNH1z0/8hoWvyontC++I
        la07kWoVNvmZBy/7moZVBxSeb+Z9adTk5WQdZM9w2FhZ70ZoAZtJLrOjucvdhVmLbVbe6rpt
        lHfbc+5V1t3c+gm33f0j3gUe51BsuMN9prLMbuYiP3t5gYxLzRx53LJC1wWfhXNmKLEUZyQa
        ajEXFScCADXW5UFNAwAA
X-CMS-MailID: 20231025133054eucas1p23c3ad3e8a8f96608f5574a3b7910589d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231025133054eucas1p23c3ad3e8a8f96608f5574a3b7910589d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231025133054eucas1p23c3ad3e8a8f96608f5574a3b7910589d
References: <20231025133027.524152-1-m.majewski2@samsung.com>
        <CGME20231025133054eucas1p23c3ad3e8a8f96608f5574a3b7910589d@eucas1p2.samsung.com>
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

