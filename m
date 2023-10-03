Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575FC7B67A3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbjJCLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239931AbjJCLRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:17:16 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D48AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:17:12 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231003111710euoutp025952191c9792d221d8134994f586485e~KlM-yjxWS1082210822euoutp02t
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:17:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231003111710euoutp025952191c9792d221d8134994f586485e~KlM-yjxWS1082210822euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696331830;
        bh=Vg9DFf70aoyV0Kmb3Cb2AWmwbCE2SJj9B9sBvA2HuYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5tlqEjBZmPORQTzCLzRx8C7titOhRX8qDeSxK+s75TC7O4X0m8x4n1GxwTeiKOW5
         IiBlFnY6+jHSs0cFHYN8JSFLwgX71YVRMc22yKAeoWfx6IYG85Ar28CIr40ZRtq30i
         s3McVxgfork35cUAEDHLmdUQneCWy/AXuvEFNuKs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231003111710eucas1p204e1d3274a5bbb029e30898acee06042~KlM-djcw23094430944eucas1p2t;
        Tue,  3 Oct 2023 11:17:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6B.F7.42423.638FB156; Tue,  3
        Oct 2023 12:17:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111709eucas1p21f2d28615faab2f4aa4d9a264cf7f54f~KlM-AFzO62873528735eucas1p2v;
        Tue,  3 Oct 2023 11:17:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231003111709eusmtrp14a69c0266cc53ac9a752ddb9f6a8a128~KlM_-KruD2246422464eusmtrp1c;
        Tue,  3 Oct 2023 11:17:09 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-c6-651bf835d994
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CC.CE.25043.538FB156; Tue,  3
        Oct 2023 12:17:09 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111708eusmtip29d07bb5541e22c576b800fd54121b136~KlM_LA_L-2772927729eusmtip2I;
        Tue,  3 Oct 2023 11:17:08 +0000 (GMT)
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
Subject: [PATCH v3 4/8] thermal: exynos: handle devm_regulator_get_optional
 return value correctly
Date:   Tue,  3 Oct 2023 13:16:30 +0200
Message-ID: <20231003111638.241542-5-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003111638.241542-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djPc7pmP6RTDV78YrJ4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB7F
        ZZOSmpNZllqkb5fAlbHw0kymgmMcFVda9rI1MLawdzFyckgImEgsnvqLrYuRi0NIYAWjxKNN
        XewQzhdGibVfvrNAOJ8ZJc7+Pc4K0/L4yjyoxHJGia7Hd1ghnFYmibmrlrKAVLEJGEg8eLMM
        bImIQCujxMwmdZAiZoFLzBJ3b64FKxIWSJF4vW4+WBGLgKrEtF+NjCA2r4CtxMPLL9gg1slL
        7Fn0nQnE5hSwk1j5czkTRI2gxMmZT8DmMAPVNG+dzQyyQELgP4dEy/l7UO+5SBz718wCYQtL
        vDq+BSouI3F6cg9UPF9ixub3QDYHkF0hcfegF4RpLfHxDDOIySygKbF+lz5EsaNE76JNjBAV
        fBI33gpCHMAnMWnbdGaIMK9ER5sQRLWqxPE9k5ghbGmJJy23mSBsD4k7D5pYJzAqzkLyyiwk
        r8xC2LuAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYBo7/e/4px2Mc1991DvEyMTB
        eIhRgoNZSYQ37KhUqhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFebduTyUIC6YklqdmpqQWpRTBZ
        Jg5OqQYms7hNWsfrpluoRS2/9k/Lv7NVQuNrVkGexe3EKbM/X+Q90qKm01N75c+s/ilXj0+x
        1pQ8L7m08tvkXVflY16cfFrBEHzjlbBVd+2Huz9Of9L+bdP50fmD5uQvXplbjcuMl3RYP3EM
        5hCe/Tgkk7336MI3T4V8jinbL+X59jpkjrPchfthlyr5zHPudfWx1s9weDbb9NS8iyKP9l1k
        Xvtl/9Q31w6uPulsuOmtALPIoaBtCRZvvoU3hDea/dg4Idl9u/HCTdvdO3Rze/aVTXBgWJS6
        ID5i84dPc8UMZnq0TQ6vdewsnlJ1q+dBvaZfQyvbr28LFIzCrBnW3WTdW6RWaXpySYq7Rd1Z
        TpGA3WvMlViKMxINtZiLihMByEu0/9IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xe7qmP6RTDb4dV7F4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB6l
        Z1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7Hw0kym
        gmMcFVda9rI1MLawdzFyckgImEg8vjKPpYuRi0NIYCmjxIpvO5ggEtISh79MgSoSlvhzrYsN
        oqiZSWLd9m1gRWwCBhIP3ixjB0mICHQySnRtPgeWYBa4xSxx/7UWiC0skCTxeeV9FhCbRUBV
        YtqvRkYQm1fAVuLh5RdsEBvkJfYs+g7WyylgJ7Hy53IwWwio5tbyfSwQ9YISJ2c+YYGYLy/R
        vHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy020itOzC0uzUvXS87P3cQIjLptx35u2cG48tVH
        vUOMTByMhxglOJiVRHjDjkqlCvGmJFZWpRblxxeV5qQWH2I0Bbp7IrOUaHI+MO7zSuINzQxM
        DU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqY7GSLtD6tSc/a9GjFxwCnU7y3
        Tz3VnpL831f+1olbpyS2zyncFiTrvo7/eFHuUbY3ITuumripVKmtuHt94oZHlj5WTzYGT320
        pXbmAvX58vf3bMxiDfLzYLn1QElp6WMBzzrpaK+qjXdWfRA2c9A9uFy4zON75TkB4aU1zUuW
        bLO9UROsKnxU1+jmYU7/5Ph1inE6jN0CXtkSz6yYmOxT2GTO866SuMxc6sX9bfPygPgZ5v43
        tIvWfOCYOyXmhaBZYqLiN4E/D9fKfua4uK7A32V2e1lh2QvzVLnafO+Wgz/7p5w9Efl23fKs
        +I7qVypML0Mbdmd6dq0WYeLm7xX9EXm497vq7tiNS6S2te9WYinOSDTUYi4qTgQAKeRGI0MD
        AAA=
X-CMS-MailID: 20231003111709eucas1p21f2d28615faab2f4aa4d9a264cf7f54f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231003111709eucas1p21f2d28615faab2f4aa4d9a264cf7f54f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231003111709eucas1p21f2d28615faab2f4aa4d9a264cf7f54f
References: <20231003111638.241542-1-m.majewski2@samsung.com>
        <CGME20231003111709eucas1p21f2d28615faab2f4aa4d9a264cf7f54f@eucas1p2.samsung.com>
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

Currently, if regulator is required in the SoC, but
devm_regulator_get_optional fails for whatever reason, the execution
will proceed without propagating the error.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 0e970638193d..6070b03cff9d 100644
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

