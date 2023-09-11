Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA78E79B21E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbjIKVUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbjIKNgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:36:25 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108971A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:36:21 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230911133619euoutp0207ed62a7a7da049c34cf022575630dbd~D26N1vsdi1631916319euoutp02S
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:36:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230911133619euoutp0207ed62a7a7da049c34cf022575630dbd~D26N1vsdi1631916319euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694439379;
        bh=AAP3lLPpv5qsQMoGVy1YUvE2PsB1a2G8WmcojJFngHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HtBGZ2S811lW7DksCnRHuiskKatvLOtRnzlmEhilIVAEq7Jw5gcrkSiQPFqZFvtDE
         vGHeT5KIg1DN9/5wvhwJBoOa0BD+y0CTawBKK2WkYfrL5wTS0rA+YVo4eikGIy0CS+
         TxtERhwVFQy3jjOZZ9kvE3mSLXoYWtw2KaXK7lI8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230911133619eucas1p26167a4c2db92fefc14bdf12855d54026~D26NXQxeB1560815608eucas1p2V;
        Mon, 11 Sep 2023 13:36:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5B.B1.42423.3D71FF46; Mon, 11
        Sep 2023 14:36:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230911133618eucas1p2d40b075ee6baebbec9f991eb01f21d89~D26M5xJ5x2314623146eucas1p2d;
        Mon, 11 Sep 2023 13:36:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230911133618eusmtrp22a0face45ce4adcde68bbd79a49352ed~D26M5AlLS0862108621eusmtrp2u;
        Mon, 11 Sep 2023 13:36:18 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-6b-64ff17d3cd0b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C3.8A.14344.2D71FF46; Mon, 11
        Sep 2023 14:36:18 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230911133617eusmtip25e8141ecc53adabce50419a6af992bef~D26L0r9QR0735907359eusmtip22;
        Mon, 11 Sep 2023 13:36:17 +0000 (GMT)
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
Subject: [PATCH v2 5/7] thermal: exynos: stop using the threshold mechanism
 on Exynos 4210
Date:   Mon, 11 Sep 2023 15:34:29 +0200
Message-ID: <20230911133435.14061-6-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911133435.14061-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djP87qXxf+nGPSuErV4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB7F
        ZZOSmpNZllqkb5fAlXH9xRbGgpX8FYdaP7E0ML7j6WLk5JAQMJG4umACYxcjF4eQwApGiWkf
        n7FAOF8YJX5t/8IM4XxmlLi78QsrTMvDX0ehqpYzSjTe38YO4bQySez+cIIFpIpNwEDiwZtl
        7CC2iEAro8TMJnWQImaBS8wSd2+uBSsSFoiRODbtO5jNIqAqsfP+UbAVvAI2EpcXvmeGWCcv
        8fzWHbBBnAK2EmfXTmeHqBGUODnzCVgvM1BN89bZYLdKCDRzSnxrbIK61UXi7KpNjBC2sMSr
        41vYIWwZif875zNB2PkSMza/BxrEAWRXSNw96AVhWkt8PMMMYjILaEqs36UPUewocXbXMkaI
        Cj6JG28FIQ7gk5i0bTozRJhXoqNNCKJaVeL4nklQf0hLPGm5DbXSQ+LH5x9MExgVZyF5ZRaS
        V2Yh7F3AyLyKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMI2d/nf80w7Gua8+6h1iZOJg
        PMQowcGsJMJbcuhvihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFebduTyUIC6YklqdmpqQWpRTBZ
        Jg5OqQamjEVNKZ8qRA5fWyrhb//t0Rcx32/HF3zMsD7bbnJZvCE/4e+rs/cXGMf9nHRO5nLd
        HYf5PRNu5KlwPC+dnCwjYcnsxul6a+ffA5UR3RPEQ39ULL10/8vy9L9rXwbervcI+HrB9ZTd
        pGcPE3+Ivp+wyNZogplcj7XEwfqyAqc9vp1zU1ee4fC1CJmhnLBy7c+Naj+ESqJCRX+1x+QK
        rEqb9NTs2gE5gVXXTfLCs5mfmek9nXxikezrRYf3lfbrHuj5ViElWVDP47KvSfvS0tt7vSb5
        l+Yl7v2owaAXWWy80VD3zopPF8I+5Ku3+e70Xej8Q2nhoaXKcy97/Ipj4pc8K1rtX+yVrSLC
        rRu39JO2EktxRqKhFnNRcSIAubsW1dIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xe7qXxP+nGHR1m1g8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouJxyYzW6w9
        cpfdYu6XqcwWTx72sTnwe+ycdZfdY/Gel0wem1Z1snncubaHzWPzknqPvi2rGD0+b5ILYI/S
        synKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7j+Ygtj
        wUr+ikOtn1gaGN/xdDFyckgImEg8/HWUBcQWEljKKDGpSREiLi1x+MsUdghbWOLPtS62LkYu
        oJpmJok9T7+BJdgEDCQevFnGDpIQEehklOjafI4JJMEscItZ4v5rLRBbWCBK4uqrV4wgNouA
        qsTO+0dZQWxeARuJywvfM0NskJd4fusO2FBOAVuJs2unA9kcQNtsJPrP6ECUC0qcnPmEBWK8
        vETz1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMw4rYd+7llB+PK
        Vx/1DjEycTAeYpTgYFYS4S059DdFiDclsbIqtSg/vqg0J7X4EKMp0NkTmaVEk/OBMZ9XEm9o
        ZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cC05lnwZP3FL3Vzj0SIdU3a
        FWSTHu50+btF4M8ANi+FazyBR17/XnX1Cc+boAlvdU4L2k7jDJBsriw4e/r05SOMoSvuWs9/
        ey/XIbVi49poL4tYNt/cqFp+K9t9hzbuWbD67tRpi79veRb2J11+17evL14nNn0VV3A6v6ml
        mu37IcdpkRHWe+02uq+yT5pkH9vpX/Nu/422L3wZQVtqXWwMDn14/njvX1f7UwwrO4KOa919
        demj/sRs8/IJa/xXHZVWKjr7/oQt8ySjILuqinPfuTl1xF+UbLVUmNARLJ7Y/2He3ZcbZr/q
        mvb40/TF+UuZvJObOLavavXbMiF4TmJfnPuCD8KMf8qshDTnF6+qUWIpzkg01GIuKk4EADSU
        f/RBAwAA
X-CMS-MailID: 20230911133618eucas1p2d40b075ee6baebbec9f991eb01f21d89
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230911133618eucas1p2d40b075ee6baebbec9f991eb01f21d89
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230911133618eucas1p2d40b075ee6baebbec9f991eb01f21d89
References: <20230911133435.14061-1-m.majewski2@samsung.com>
        <CGME20230911133618eucas1p2d40b075ee6baebbec9f991eb01f21d89@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos 4210 supports setting a base threshold value, which is added to
all trip points. This might be useful, but is not really necessary in
our usecase, so we always set it to 0 to simplify the code a bit.

Additionally, this change makes it so that we convert the value to the
calibrated one in a slightly different place. This is more correct
morally, though it does not make any change when single-point
calibration is being used (which is the case currently).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 8451deb65f43..77afbf9f2db0 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -343,20 +343,7 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
 					 int trip_id, u8 temp)
 {
-	struct thermal_trip trip;
-	u8 ref, th_code;
-
-	if (thermal_zone_get_trip(data->tzd, 0, &trip))
-		return;
-
-	ref = trip.temperature / MCELSIUS;
-
-	if (trip_id == 0) {
-		th_code = temp_to_code(data, ref);
-		writeb(th_code, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
-	}
-
-	temp -= ref;
+	temp = temp_to_code(data, temp);
 	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip_id * 4);
 }
 
@@ -371,6 +358,8 @@ static void exynos4210_tmu_initialize(struct platform_device *pdev)
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 
 	sanitize_temp_error(data, readl(data->base + EXYNOS_TMU_REG_TRIMINFO));
+
+	writeb(0, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
 }
 
 static void exynos4412_tmu_set_trip_temp(struct exynos_tmu_data *data,
-- 
2.41.0

