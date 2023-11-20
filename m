Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B587F1658
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjKTOwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjKTOwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:52:00 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ADA1712
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:51:08 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231120145104euoutp0103de687cdc3ae448db1ef8a59a1248b4~ZXFdJ57VR2535125351euoutp01K
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:51:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231120145104euoutp0103de687cdc3ae448db1ef8a59a1248b4~ZXFdJ57VR2535125351euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700491864;
        bh=u+wG+TE9TCSLBpYrR24io87ZkJPG2GggSUyjgW3CH9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gS3qEzMKwSdM1Qp01ulOJXVeVh0kRNqwyaxlarGE+KLpeqfGEt9oFWiiSfbblWaS0
         XV2Ofizommu8fb5MDPfhi4Z03p9j4yhsdAL65jHWyWiqWM6Aj0hMgIkT1iuCkK/lqp
         AFoJln6rZLrgsVaNP9gZp0zvy4pERAgHloXxIRAE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231120145103eucas1p1427585615e9e6ede588a86181de6f9e4~ZXFcpRLaU0299402994eucas1p1f;
        Mon, 20 Nov 2023 14:51:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 36.AB.09814.7527B556; Mon, 20
        Nov 2023 14:51:03 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231120145103eucas1p242fd14a2c778c6a47092d5cfdd7f26bf~ZXFcHQbYL0521605216eucas1p2x;
        Mon, 20 Nov 2023 14:51:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231120145103eusmtrp2d1b2f4ee91402f9dce090eb8adb6ecbd~ZXFcGQ1tk0700707007eusmtrp2k;
        Mon, 20 Nov 2023 14:51:03 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-33-655b725789f5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 46.C3.09146.6527B556; Mon, 20
        Nov 2023 14:51:03 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231120145102eusmtip26b9318118cd499c4cbad186c721576f8~ZXFbNc7Xj1014210142eusmtip2c;
        Mon, 20 Nov 2023 14:51:02 +0000 (GMT)
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
Subject: [PATCH v5 4/9] thermal: exynos: handle devm_regulator_get_optional
 return value correctly
Date:   Mon, 20 Nov 2023 15:50:44 +0100
Message-ID: <20231120145049.310509-5-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120145049.310509-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87rhRdGpBk+/alg8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKC6blNSczLLUIn27BK6MmRuqCpZwVRy8PYOxgXE3RxcjJ4eEgInE2W8fmboY
        uTiEBFYwSsx6PZERwvnCKDHpzkIWCOczo8SUc59ZYFrmztzHBpFYzihxb/MZZpCEkEArk8TW
        PUYgNpuAgcSDN8vYQWwRgVZGiZlN6iANzAJfmSWuvp4P1iAskCLx6PJtVhCbRUBV4svvFrAN
        vAK2ElP6mtghtslL7Fn0nQnE5hSwk2g78pwNokZQ4uTMJ2D1zEA1zVtnM4MskBDo55S4vHo7
        M0Szi8TOa51Qg4QlXh3fAmXLSPzfOZ8Jws6XmLH5PdAgDiC7QuLuQS8I01riI8hfHEDjNSXW
        79KHKHaUeLvrNlQxn8SNt4IQB/BJTNo2nRkizCvR0SYEUa0qcXzPJKhTpCWetNyGWukh8fbW
        HJYJjIqzkLwyC8krsxD2LmBkXsUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY1k7/O/5l
        B+PyVx/1DjEycTAeYpTgYFYS4f0mFJEqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc1RT5VSCA9
        sSQ1OzW1ILUIJsvEwSnVwCT+rJg3PXziy72c1gXepRLXfT2dlpqtTz6/NdrsV8PKxMpX7/5p
        bzfxbkoLCzkcVn2u/Gxi0VI//aM9t13kVqizKxyrWHqOMeqZfKJNXknnT3M2i+37vlj0ZjQn
        ZTVOiLk+/+PONqXUZ7+CzJMzWB7FF970OqtmIJV9d1vCCd1JZjMuLTMSmlB82URDL6ZOcxdr
        PfNefrGZBueecaWf2+cY7TPtz1Sh5hsmhmHp9+XZXPSfsZpdCfs3dW/WuUZ91RnPa84yrov2
        S9pTUy/r8UTedV3R4gMBvrGn479deq5w4MmkAOe8qafnzNm198nkxrBLv8/uLLC1nvdpb27o
        f6Hd5kYaJzYnXCmK3pm8QYmlOCPRUIu5qDgRAHnAXHvaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xe7rhRdGpBuf2MVo8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2MmRuqCpZwVRy8PYOxgXE3RxcjJ4eEgInE3Jn72LoYuTiEBJYySnyZ3sYMkZCWOPxl
        CjuELSzx51oXVFEzk8TJ7XPAitgEDCQevFnGDpIQEehklOjafI4JJMEs8J9Z4utMBRBbWCBJ
        4vH6/2ANLAKqEl9+t7CA2LwCthJT+pqgNshL7Fn0HayXU8BOou3Ic6BtHEDbbCU67mpAlAtK
        nJz5hAVivLxE89bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMAq3
        Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuH9JhSRKsSbklhZlVqUH19UmpNafIjRFOjsicxSosn5
        wDSQVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAtM9mibPCot1i
        Dr2W856qTZlyP6vJNnJmgUrLTYlnQTGnLNadf8Avqln/jjkzhPvMP6tAwc6zrl3zj3zpnOP0
        ObGtomj+fPs1oXqJAlV9JV/3rDvdY860ccrdMEEx59uXf93zU9JY5XDL3vVIwN5GTplJTw4H
        ZDZvmKy28I/ErLoA6Vn/G9gkHy/aaKoqumrVuXevtj0JfBQp94x5paYdX5zu69qj+U/2PdiW
        LzTldKpFz4Vz2aLMnAtMdxU+X3f2h+f+4LWaYWZLVvlXFx680v95ScGaWzUf987Y7vfa7sO3
        E6xxT5bc4N9ddvf6PYuMxRzub+7/VJlWcdy80yk087BDTtWCNxvCVwo23gl2SVBiKc5INNRi
        LipOBADKIE1RSwMAAA==
X-CMS-MailID: 20231120145103eucas1p242fd14a2c778c6a47092d5cfdd7f26bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231120145103eucas1p242fd14a2c778c6a47092d5cfdd7f26bf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231120145103eucas1p242fd14a2c778c6a47092d5cfdd7f26bf
References: <20231120145049.310509-1-m.majewski2@samsung.com>
        <CGME20231120145103eucas1p242fd14a2c778c6a47092d5cfdd7f26bf@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

