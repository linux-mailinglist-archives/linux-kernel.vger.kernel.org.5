Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDAA7F1654
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjKTOwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjKTOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:52:01 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EF21713
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:51:08 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231120145106euoutp0204d06d681f454d8ca62f68dbbb0b8385~ZXFfFO-X22495724957euoutp02V
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:51:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231120145106euoutp0204d06d681f454d8ca62f68dbbb0b8385~ZXFfFO-X22495724957euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700491866;
        bh=dXf9wUUf5w5y7OBV4KeN+1ChCSvq94K/h1PmwKd1DP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sg1ctm0TcDobA3Deail7KDDXaBKJsVxrbQ26TqUFptfYTLdh5YLMhO+0kXmqD4gtB
         AFJ12yitWvdNe0naMBVZgCoawA2X8z8eK5fcqx7grJGPGFgo5eufLyl6CbQL3jrJtg
         ZMvy85VxwkBHkHC+uqa7KHUuW9lk2ho1MjKID3fU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231120145105eucas1p218e1b31a4ae803118eaff8055d5e51b6~ZXFep0Se22568025680eucas1p2o;
        Mon, 20 Nov 2023 14:51:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 57.A8.09552.9527B556; Mon, 20
        Nov 2023 14:51:05 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231120145105eucas1p11844e768db69eefb84934ec307ec528d~ZXFeURYml1856818568eucas1p1U;
        Mon, 20 Nov 2023 14:51:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231120145105eusmtrp228fa7a6f822ba82d3365738906a96dd3~ZXFeTmJ4j0691806918eusmtrp2N;
        Mon, 20 Nov 2023 14:51:05 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-8b-655b7259b032
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8E.64.09274.9527B556; Mon, 20
        Nov 2023 14:51:05 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231120145104eusmtip2f3c189249c7d49f9c63a1640b08ffbcc~ZXFdfd68j0740707407eusmtip2a;
        Mon, 20 Nov 2023 14:51:04 +0000 (GMT)
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
Subject: [PATCH v5 6/9] thermal: exynos: stop using the threshold mechanism
 on Exynos 4210
Date:   Mon, 20 Nov 2023 15:50:46 +0100
Message-ID: <20231120145049.310509-7-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120145049.310509-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djP87qRRdGpBldfGVk8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKC6blNSczLLUIn27BK6MP2e+sRWs5K+Y+HIyWwPjO54uRk4OCQETiZd7Wlm7
        GLk4hARWMErcn/aSHcL5wijx4+V+dpAqIYHPjBK/PsvBdDzs2soGUbScUeJBy1OojlYmiVkr
        F7CBVLEJGEg8eLMMrFtEoJVRYmaTOkgRs8BXZomrr+czgySEBWIkGg8vZAGxWQRUJR5/XMgI
        YvMK2EpM7XvFDLFOXmLPou9MIDangJ1E25HnbBA1ghInZz4B62UGqmneOpsZZIGEQD+nxKMJ
        D9ghml0kDv3fwAhhC0u8Or4FKi4j8X/nfCYIO19ixub3QIM4gOwKibsHvSBMa4mPZ5hBTGYB
        TYn1u/Qhih0l/t6czgRRwSdx460gxAF8EpO2TWeGCPNKdLQJQVSrShzfMwnqD2mJJy23oVZ6
        SGzd8IdtAqPiLCSvzELyyiyEvQsYmVcxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEJrbT
        /45/3cG44tVHvUOMTByMhxglOJiVRHi/CUWkCvGmJFZWpRblxxeV5qQWH2KU5mBREudVTZFP
        FRJITyxJzU5NLUgtgskycXBKNTCZt7s6BLyYzyrwOHvu7euXpFZ9u6WTGLh5b2bes6UNz/bH
        y4hMOm5/c/OtZ0mmmqaHt5b2C4X08jvsFfbRZphirL/LfXqe2fJffqvsdzS6hk6WmnnWOWLV
        sVWL8rep5jDV7F7kwvvnp9ayky9Xb1es4jXd4LIrMDnpzQyvm5/ehnabWB5xknl5ScbY8NZ2
        1V12C+7dr75p5TpZhXvLmezkTWkdmWyZMw3uikmzOrd//VvnOelIlJ2U5MRi2SU1Qb/ehd5s
        uv9ppkPx6UN8z6wL53Z9bLff9G/GudgDaSt3vF3leymf0WfOQ/dXt9Z7yWvJnDz7ckeVoLD/
        Ra01J5g9lH91b9yb+TyO+eBluV0TlViKMxINtZiLihMBYJEhwtsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xe7qRRdGpBnMXyVg8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2MP2e+sRWs5K+Y+HIyWwPjO54uRk4OCQETiYddW9lAbCGBpYwSmz75QsSlJQ5/mcIO
        YQtL/LnWBVTDBVTTzCTRP2U2WIJNwEDiwZtl7CAJEYFORomuzeeYQBLMAv+ZJb7OVOhi5OAQ
        FoiSmL9BCCTMIqAq8fjjQkYQm1fAVmJq3ytmiAXyEnsWfQdr5RSwk2g78pwNpFUIqKbjrgZE
        uaDEyZlPWCCmy0s0b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC
        Y3DbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEd5vQhGpQrwpiZVVqUX58UWlOanFhxhNgc6eyCwl
        mpwPTAJ5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1Mze9O5gUY
        lSXxmTzgyd99/EhGr/25/ZOXvPlwpCeCa/pUfl7L1mPb3oZNZmx2CtnHe2NKdJr4Y+/QC62P
        t1t1xH556PLg5RKLqEUmxsrbTBi4Zy2QWSd3xf/pPMOVk131Xs9vFpr0ddfmumIDZ+PzWdx7
        P8akm/n/aQ2Nr19ptFcipGla8sqlFr5u5+OO11V/CFfgXiPgKNBu7NBxUubNuhQtc5u79sfr
        N7NcOHCh4Ps8oZLw5G9Hbl3rtIjhTt+alGxleKTya/Qv0Zm7rZZJ/u9nsF47O/59/y3vD+6t
        jyfZKZinxbXe0ZtUalzpe+Ipn1/T/debch/tPOn4jf3eI76T8+UkTrb5LTRV/HRciaU4I9FQ
        i7moOBEArFDd30oDAAA=
X-CMS-MailID: 20231120145105eucas1p11844e768db69eefb84934ec307ec528d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231120145105eucas1p11844e768db69eefb84934ec307ec528d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231120145105eucas1p11844e768db69eefb84934ec307ec528d
References: <20231120145049.310509-1-m.majewski2@samsung.com>
        <CGME20231120145105eucas1p11844e768db69eefb84934ec307ec528d@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 3bdcbab7466f..d918bf6d5359 100644
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
2.42.0

