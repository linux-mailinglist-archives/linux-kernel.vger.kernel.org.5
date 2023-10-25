Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3DE7D6D24
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbjJYNbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344572AbjJYNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:30:57 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ECA19D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:30:54 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231025133053euoutp0164ae808d4ecb26321895647b6a79e941~RXOBu3RSW3146731467euoutp01r
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:30:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231025133053euoutp0164ae808d4ecb26321895647b6a79e941~RXOBu3RSW3146731467euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698240653;
        bh=u+wG+TE9TCSLBpYrR24io87ZkJPG2GggSUyjgW3CH9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/DepxjHH+IjhkvkPHbLUswuGcb8KNPKNw5x2ow/ffS4oUDP6Ot4Kl0Yy5KN7Q7JU
         wipN0Fk6SBShAnpVCj8hL4G2YRAyAprM1OpQCbXMxbqc/Sf5ZnKYz4FeMxRUFxuND7
         I6k6asIj5jGoI3Kd9rK9Xg2f7KodZ3Yl07TAe4iI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231025133053eucas1p179baa1a44f15f85dc545ca7baf99ee87~RXOBWM70G1384813848eucas1p1k;
        Wed, 25 Oct 2023 13:30:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BD.E7.42423.C8819356; Wed, 25
        Oct 2023 14:30:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231025133052eucas1p2278dc2030aa8fd20868cd4f3605a8a2f~RXOA82tyC2480624806eucas1p2y;
        Wed, 25 Oct 2023 13:30:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231025133052eusmtrp2688ee67cfbfc501af1ab89e01d71a863~RXOA8AW6i1214112141eusmtrp2F;
        Wed, 25 Oct 2023 13:30:52 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-07-6539188c2890
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EA.26.25043.C8819356; Wed, 25
        Oct 2023 14:30:52 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231025133051eusmtip2556b6720bd3d6eacf23c309e31d6ea86~RXOAF5dwe1204812048eusmtip2f;
        Wed, 25 Oct 2023 13:30:51 +0000 (GMT)
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
Subject: [PATCH v4 4/8] thermal: exynos: handle devm_regulator_get_optional
 return value correctly
Date:   Wed, 25 Oct 2023 15:30:23 +0200
Message-ID: <20231025133027.524152-5-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025133027.524152-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djP87q9EpapBjO9LR7M28ZmcXh+hcXU
        h0/YLL5vuc5kMe+zrMXe11vZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhxfh+TxcKmFnaLiccm
        M1usPXKX3WLul6nMFk8e9rE5CHismbeG0WPnrLvsHov3vGTy2LSqk83jzrU9bB6bl9R79G1Z
        xejxeZNcAEcUl01Kak5mWWqRvl0CV8bMDVUFS7gqDt6ewdjAuJuji5GTQ0LAROLajI1MXYxc
        HEICKxglpv88yQ7hfGGUONfSC5X5zCjR8XwbSxcjB1jL2cfmEPHljBL9E7ezQDitTBIvF7cw
        g8xlEzCQePBmGTuILSLQyigxs0kdpIhZ4CuzxNXX88GKhAVSJJY+a2QBsVkEVCX+9b5gBNnA
        K2Ar8XlNKMR98hJ7Fn1nArE5Bewkeo9fZwOxeQUEJU7OfALWygxU07x1NjNE/WROiflvXSEO
        dZH42+0GERaWeHV8CzuELSPxf+d8Jgg7X2LG5vdQf1VI3D3oBWFaS3w8wwxiMgtoSqzfpQ9R
        7Cjx5MMHVogKPokbbwUh1vNJTNo2nRkizCvR0SYEUa0qcXzPJKirpCWetNyGWukh0XBqLesE
        RsVZSB6ZheSRWQh7FzAyr2IUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMZ6f/Hf+0g3Hu
        q496hxiZOBgPMUpwMCuJ8Eb6WKQK8aYkVlalFuXHF5XmpBYfYpTmYFES51VNkU8VEkhPLEnN
        Tk0tSC2CyTJxcEo1MDXpds/Jr/3KF9bT2/XyqXTJU8dPX5hW6Iek20nu+VNe8fDsKo0bFWWp
        b+wXuq/5VCcryzDR+IPG8jTBuKA2w9VSaxnd2rboHey9eo7/LdvXRdveKFuqbXDY/W9rn7Hq
        2bdCV+Ufy2k2fpdx8+a86njXtX1ilt2MXys9p1hJcobxbS4+IXDvPt+/RkvNrcvWZyzdzdI0
        4dFT14e731RYbBX9cHJlsGiW0NXWIt9st8fh+2q9G7IerRU/1PGSNfN3envg0jsbqyZ5Sc1Y
        t6z3oYvDSwOtlwZxtqLbpt6eOcHpcs3+DDMn8RdTJX/riBxz/CZgI/E7qeHL5hub2n+4TPNh
        WKzyNOtI3esNVtIZEkosxRmJhlrMRcWJAL9jZCjWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xe7o9EpapBmdPKls8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2MmRuqCpZwVRy8PYOxgXE3RxcjB4eEgInE2cfmXYxcHEICSxkl9j++xtzFyAkUl5Y4
        /GUKO4QtLPHnWhcbRFEzk8SuD7fZQBJsAgYSD94sYwdJiAh0Mkp0bT7HBJJgFvjPLPF1pgKI
        LSyQJLF71jpWEJtFQFXiX+8LRpDNvAK2Ep/XhEIskJfYs+g7WCungJ1E7/HrYPOFgEomdDwE
        O4JXQFDi5MwnLBDj5SWat85mnsAoMAtJahaS1AJGplWMIqmlxbnpucVGesWJucWleel6yfm5
        mxiBMbjt2M8tOxhXvvqod4iRiYPxEKMEB7OSCG+kj0WqEG9KYmVValF+fFFpTmrxIUZToLMn
        MkuJJucDk0BeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVANTFZeU
        z/S/vdaLvU5fdtVVajb88ykrbeWMKCbdBTM3+zVkblJc/bHtqsiplUX/H/nq7ryxdKaCrEtT
        bhJPf+R0+9uBMyrO2C9gWOG93ajxzIx73CrxET83Tbggd0zBPqB5h5Fh78K1AoUuPp8mOW7w
        afPm+rVk+a5Vd+ULT2Qti1b4/V/8OdOsV7Idf0IDDn/4ya5x07JTee0T3qDEqxw2q35G/Prj
        dVAmJvLQZq8VHsdT1E99f6f5NDF9e7+vRbQU56tZPf1WPm9lG88bLu5e8NDi+pzDUQ9dErcs
        esS81uPJN7PD+6b/iZjn8b7SsJPn2vqkhnOhy7Wvimifcuvb/7jEQqjoUeLdIG3fLy+XKbEU
        ZyQaajEXFScCACrPyKRKAwAA
X-CMS-MailID: 20231025133052eucas1p2278dc2030aa8fd20868cd4f3605a8a2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231025133052eucas1p2278dc2030aa8fd20868cd4f3605a8a2f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231025133052eucas1p2278dc2030aa8fd20868cd4f3605a8a2f
References: <20231025133027.524152-1-m.majewski2@samsung.com>
        <CGME20231025133052eucas1p2278dc2030aa8fd20868cd4f3605a8a2f@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

