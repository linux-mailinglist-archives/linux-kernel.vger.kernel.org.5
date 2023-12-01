Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32A68007C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378221AbjLAJ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378131AbjLAJ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:56:43 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A575B10F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:56:49 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231201095648euoutp01c886c157387dd413f1a51981ca174718~crKq7fOGq0037200372euoutp012
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:56:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231201095648euoutp01c886c157387dd413f1a51981ca174718~crKq7fOGq0037200372euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701424608;
        bh=qcDWdYyFz+aTs42Xky3P8FBnBFXfbsLTVwl0UxX68ME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPNaCsDYkWxkLvjrKP3KCoqWuphcGv3MALiDB+tfGdg2j0QSjag6hMZ99vxuW8LUA
         4Ugc405/Q++h4SkhCiOSYHgR3BZogQ4mVmood9p7zIP8JiBAA2fCjQS2C6/RIRvaAg
         ZliIur0AXUwUtFw1G+zN3s+rLN+yj48S3vosepRQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231201095647eucas1p29930c7c10aa5b4a957f9035af650d3b5~crKqZDZ2S1612516125eucas1p2m;
        Fri,  1 Dec 2023 09:56:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4B.42.09814.FDDA9656; Fri,  1
        Dec 2023 09:56:47 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231201095647eucas1p25f6068381aa2b5f00ed7a8c093fe7a7b~crKp-CGz51612616126eucas1p2n;
        Fri,  1 Dec 2023 09:56:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231201095647eusmtrp1333961b5c91481da07f8a5a9ca494a28~crKp_QkLI0759907599eusmtrp1E;
        Fri,  1 Dec 2023 09:56:47 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-fe-6569addf66d8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 51.30.09146.FDDA9656; Fri,  1
        Dec 2023 09:56:47 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231201095646eusmtip257beac659cec1845189c7e85b2a3ec17~crKpEpHYz0964909649eusmtip2f;
        Fri,  1 Dec 2023 09:56:46 +0000 (GMT)
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
Subject: [PATCH v6 8/9] thermal: exynos: use BIT wherever possible
Date:   Fri,  1 Dec 2023 10:56:24 +0100
Message-ID: <20231201095625.301884-9-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201095625.301884-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87r312amGlz6Y2LxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4MqY9te24J9oxcMrl5kbGJ8LdjFyckgImEgc
        6J/I0sXIxSEksIJRYs+a90wQzhdGiZvXb0E5nxklzt1vZYRpWXZ3GyNEYjmjxNb1W6CqWpkk
        Vq/uZgKpYhMwkHjwZhk7iC0i0MooMbNJHcRmFljIItHyLxfEFhZwkri38CPYVBYBVYmDL26w
        gNi8ArYSX071s0Jsk5fYs+g72ExOATuJ+YdaoWoEJU7OfMICMVNeonnrbGaQIyQEpnNK/Fmw
        hhmi2UXi66aXUGcLS7w6voUdwpaROD25hwXCzpeYsfk9kM0BZFdI3D3oBWFaS3w8wwxiMgto
        SqzfpQ9R7CixZtIeZogKPokbbwUhDuCTmLRtOlSYV6KjTQiiWlXi+J5JUKdISzxpuc0EYXtI
        dO5vY5/AqDgLySuzkLwyC2HvAkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIEJ7vS/
        4192MC5/9VHvECMTB+MhRgkOZiUR3utP01OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ86qmyKcK
        CaQnlqRmp6YWpBbBZJk4OKUamCK67+5xj/gw8WTQzj32l/743qn+fOrmlk8rC9vnLIp4FHL2
        Renmvmcazq6sar2Mxy96Zh1bsmxpuXSJzCdGvu9Hnmj+zEtlOrDdeabPZhfFQ1nH57ndmWGi
        8TT/widTjdOLUm2K536fFurMfu7twcAzK/+1/L7eOfVq5WkTo6K19/e7GzdanM9vLTnpWvD8
        2+atAjE8VQadG77NEZ6oLh8oXa9z0F7Wz4Qn513LUoFHwfq57BOcpD31vzytPBSt1mXzZ7ZE
        v+ls0T7tiOWsf2+yzDVd8d2Zc9v5DSv3T/uuW/lRdumkJ7Ediwof/vnJ1eW2/ncs/7KN1q8n
        XNqjLL5xjrRObMJc/aggp6pHmvuVWIozEg21mIuKEwEOdvBp3wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7r312amGvzfImHxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0MuY9te24J9oxcMrl5kbGJ8LdjFyckgImEgsu7uNsYuRi0NIYCmjxJ4zj5gh
        EtISh79MYYewhSX+XOtigyhqZpLYM/8oI0iCTcBA4sGbZewgCRGBTkaJrs3nmEAcZoHVLBLH
        9n1nAqkSFnCSuLfwI1gHi4CqxMEXN1hAbF4BW4kvp/pZIVbIS+xZBFHPKWAnMf9QK1iNEFBN
        15b/jBD1ghInZz4BizMD1Tdvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nziw31ihNzi0vz0vWS
        83M3MQJjctuxn5t3MM579VHvECMTB+MhRgkOZiUR3utP01OFeFMSK6tSi/Lji0pzUosPMZoC
        3T2RWUo0OR+YFPJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpiy
        /PMWRG9qPFF6uOb7jcCM703z1F70d/C/lTFI4IkvPHQ9rHVyTa6Ij0mS54VNc/8GfuXftPGD
        p8r9lhKX201XEy49cpGYdO6wQnXp6aaY9Znsz8N3uF1ceOKZrLHfjIgbOTpHzzy8W5NhviGH
        t1SAI0/iX8+9DbWf77+WmPzoc1XotMzDbTFOp88qcbJuMP7sI7y3Y1rYnNyAucpJZ87NXzrp
        3K2FVwNST9X4ywU5/j1/b135lRvKCU3vdQO3zmve+3ZjgSnTnS9vO87ysxbLaIkfsS4w/sPy
        fdaeVeWmwq09H0UsTCyFXgfUzQq52bd80Zcf3F/qopXvlZgs/5x330rWSmxP+hS/+1Oqk5OU
        WIozEg21mIuKEwEBwmmOUgMAAA==
X-CMS-MailID: 20231201095647eucas1p25f6068381aa2b5f00ed7a8c093fe7a7b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231201095647eucas1p25f6068381aa2b5f00ed7a8c093fe7a7b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231201095647eucas1p25f6068381aa2b5f00ed7a8c093fe7a7b
References: <20231201095625.301884-1-m.majewski2@samsung.com>
        <CGME20231201095647eucas1p25f6068381aa2b5f00ed7a8c093fe7a7b@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original driver did not use that macro and it allows us to make our
intentions slightly clearer.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 970bada90f2f..ca1b1cec0300 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -388,7 +388,7 @@ static void exynos4412_tmu_set_trip_temp(struct exynos_tmu_data *data,
 
 	if (trip == 3) {
 		con = readl(data->base + EXYNOS_TMU_REG_CONTROL);
-		con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
+		con |= BIT(EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
 		writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 	}
 }
@@ -559,16 +559,16 @@ static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 				continue;
 
 			interrupt_en |=
-				(1 << (EXYNOS_TMU_INTEN_RISE0_SHIFT + i * 4));
+				BIT(EXYNOS_TMU_INTEN_RISE0_SHIFT + i * 4);
 		}
 
 		if (data->soc != SOC_ARCH_EXYNOS4210)
 			interrupt_en |=
 				interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
 
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
+		con |= BIT(EXYNOS_TMU_CORE_EN_SHIFT);
 	} else {
-		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
+		con &= ~BIT(EXYNOS_TMU_CORE_EN_SHIFT);
 	}
 
 	writel(interrupt_en, data->base + EXYNOS_TMU_REG_INTEN);
@@ -590,15 +590,15 @@ static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
 				continue;
 
 			interrupt_en |=
-				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
+				BIT(EXYNOS7_TMU_INTEN_RISE0_SHIFT + i);
 		}
 
 		interrupt_en |=
 			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
 
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
+		con |= BIT(EXYNOS_TMU_CORE_EN_SHIFT);
 	} else
-		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
+		con &= ~BIT(EXYNOS_TMU_CORE_EN_SHIFT);
 
 	pd_det_en = on ? EXYNOS5433_PD_DET_EN : 0;
 
@@ -622,17 +622,17 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 				continue;
 
 			interrupt_en |=
-				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
+				BIT(EXYNOS7_TMU_INTEN_RISE0_SHIFT + i);
 		}
 
 		interrupt_en |=
 			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
 
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		con |= (1 << EXYNOS7_PD_DET_EN_SHIFT);
+		con |= BIT(EXYNOS_TMU_CORE_EN_SHIFT);
+		con |= BIT(EXYNOS7_PD_DET_EN_SHIFT);
 	} else {
-		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		con &= ~(1 << EXYNOS7_PD_DET_EN_SHIFT);
+		con &= ~BIT(EXYNOS_TMU_CORE_EN_SHIFT);
+		con &= ~BIT(EXYNOS7_PD_DET_EN_SHIFT);
 	}
 
 	writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
-- 
2.42.0

