Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038E58007B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378141AbjLAJ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378097AbjLAJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:56:40 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24488B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:56:47 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231201095644euoutp016b441e6b525dc8fd4e166c27fda876b5~crKnWzdDo0038400384euoutp010
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:56:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231201095644euoutp016b441e6b525dc8fd4e166c27fda876b5~crKnWzdDo0038400384euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701424604;
        bh=u+wG+TE9TCSLBpYrR24io87ZkJPG2GggSUyjgW3CH9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rb8RZODSuC1VswQaQCVvm4fXyfivxI5K8D0LNTFzNDvrLFH/ZCIkmEOt/c8fmJhtO
         hnZelBag1KudYTZsnVdSGj3QZG8OGN8ulF9vGfoQZB7BjieEHfxotvIpdtMJXcCuBg
         zqWlhv2plVt6f/dEWPMnyi3dzJ4/PT4U6uBIhQnI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231201095644eucas1p19042151520fcf5f56d352e10fcf2de01~crKnAdrQV2916929169eucas1p17;
        Fri,  1 Dec 2023 09:56:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9E.44.09539.CDDA9656; Fri,  1
        Dec 2023 09:56:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231201095643eucas1p214ee26937d373118d1e01ccbccbb97b2~crKmjQlNv1612616126eucas1p2h;
        Fri,  1 Dec 2023 09:56:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231201095643eusmtrp26355f89c8d5518185f8c219c5113c0d0~crKminGBK2064820648eusmtrp2H;
        Fri,  1 Dec 2023 09:56:43 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-c5-6569addc89d4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8E.12.09274.BDDA9656; Fri,  1
        Dec 2023 09:56:43 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231201095642eusmtip242cc1e6dbae9a5e71b9176901e6da0ac~crKlthK8m1357813578eusmtip2K;
        Fri,  1 Dec 2023 09:56:42 +0000 (GMT)
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
Subject: [PATCH v6 4/9] thermal: exynos: handle devm_regulator_get_optional
 return value correctly
Date:   Fri,  1 Dec 2023 10:56:20 +0100
Message-ID: <20231201095625.301884-5-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201095625.301884-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djPc7p31mamGvxbyGPxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4MqYuaGqYAlXxcHbMxgbGHdzdDFycEgImEjs
        mM3UxcjFISSwglHi+8oHrF2MnEDOF0aJJV95IRKfGSU29TxlA0mANJxdMYsNIrGcUeJP/wV2
        CKeVSWLVz63sIFVsAgYSD94sA7NFBFoZJWY2qYPYzAILWSRa/uWCrBYWSJH4ezQTJMwioCpx
        6tB2RhCbV8BWYuaHf1DL5CX2LPrOBGJzCthJzD/UygJRIyhxcuYTFoiR8hLNW2czQ9RP5pS4
        MikKwnaRuPWvhR3CFpZ4dXwLlC0j8X/nfCYIO19ixub3LJCQqJC4e9ALwrSW+HiGGcRkFtCU
        WL9LH6LYUeLI4qtQxXwSN94KQuznk5i0bTozRJhXoqNNCKJaVeL4nklQZ0lLPGm5DbXSQ+L5
        x4ksExgVZyH5ZBaST2Yh7F3AyLyKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMLGd/nf8
        0w7Gua8+6h1iZOJgPMQowcGsJMJ7/Wl6qhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe1RT5VCGB
        9MSS1OzU1ILUIpgsEwenVAPTfJUguRsrTNduD4t5Irztw/IbfnesMvczHbj2N9xpIW/gdxvt
        PfGxkz7/azZQim73+T5FXD2UWTSnQXjNl/VhT9av9+NvPGV2NU5jucYDtgvzl2ffObQ+4/6k
        81HsnwXruW2DJd5b7mtPn9Vcvn2NYIW0/5YTpXKRK2zjOJ1mqfqILeW64iuim6+RbLLSy3FV
        sVOqZme0pd75W3XbhQ+q9r5zPbamJTD2714Bn/QZjUc2nFTXN/VqOc3Q5u2yzdnZcHmh2beX
        90y/1d9++Dr2vvUE5cfW193+Xt4j9X3FBD+1ZT+l3/9+rV3rMc3n6e2qeu+6Nrnyu2IZLYk1
        a4y61lxfqhJ4lsli3n5TTgUlluKMREMt5qLiRABj4a062wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7q312amGky6pG/xYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0MuYuaGqYAlXxcHbMxgbGHdzdDFyckgImEicXTGLrYuRi0NIYCmjRNvCc2wQ
        CWmJw1+msEPYwhJ/rnVBFTUzSZzZ9JsVJMEmYCDx4M0ydpCEiEAno0TX5nNMIA6zwGoWiWP7
        vjOBVAkLJEks39PLDGKzCKhKnDq0nRHE5hWwlZj54R/UOnmJPYsg6jkF7CTmH2plAbGFgGq6
        tvyHqheUODnzCVicGai+eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltspFecmFtcmpeul5yf
        u4kRGJPbjv3csoNx5auPeocYmTgYDzFKcDArifBef5qeKsSbklhZlVqUH19UmpNafIjRFOju
        icxSosn5wKSQVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAVH+g
        wIQ5tHnD/9nr9rn8P1WeVc4q89X4j4LUxqkNG7cXnzV2UUmcveiy8227lMXqvtE81zSKa2pX
        LA4X1bC4cCstVreo2nhn8LSvIY92JUpebcuSOVa4zzR8YoblUgZfni/nHqx2Xfi8u/GpvMn8
        t+knw41meW75zfx4Ml+S4qvHJrOWbZzNuua/horY3Dmt7fxvX1WdkHNwerf4qMf+hmdcbt4f
        +p3dZB16OvXct+y+U/OyT7gh3vvtGbvnM9uNpnw9xBob9TWFkcfs3z/1Z3fL5yuEbeG//oKl
        S/175ZmTxtEqf6cJJRyTkrddFXlpjXbXCqPHRpYxs6oYp3aq651sUHr4oLLHg+vl50eBSizF
        GYmGWsxFxYkA3vsDtlIDAAA=
X-CMS-MailID: 20231201095643eucas1p214ee26937d373118d1e01ccbccbb97b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231201095643eucas1p214ee26937d373118d1e01ccbccbb97b2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231201095643eucas1p214ee26937d373118d1e01ccbccbb97b2
References: <20231201095625.301884-1-m.majewski2@samsung.com>
        <CGME20231201095643eucas1p214ee26937d373118d1e01ccbccbb97b2@eucas1p2.samsung.com>
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

Currently, if regulator is required in the SoC, but
devm_regulator_get_optional fails for whatever reason, the execution
will proceed without propagating the error. Meanwhile there is no reason
to output the error in case of -ENODEV.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v3 -> v4: Moved info about not outputting error to the correct commit
  message.

 drivers/thermal/samsung/exynos_tmu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index c144592d4584..8bcad8a70dc5 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1002,9 +1002,17 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 			return ret;
 		}
 	} else {
-		if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
+		ret = PTR_ERR(data->regulator);
+		switch (ret) {
+		case -ENODEV:
+			break;
+		case -EPROBE_DEFER:
 			return -EPROBE_DEFER;
-		dev_info(&pdev->dev, "Regulator node (vtmu) not found\n");
+		default:
+			dev_err(&pdev->dev, "Failed to get regulator: %d\n",
+				ret);
+			return ret;
+		}
 	}
 
 	ret = exynos_map_dt_data(pdev);
-- 
2.42.0

