Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1947B7D6D48
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbjJYNbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344603AbjJYNbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:31:02 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B94191
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:30:57 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231025133056euoutp02ea534a1164ce006b6eb8c07f40649c5c~RXOEvB2J-1410214102euoutp02C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:30:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231025133056euoutp02ea534a1164ce006b6eb8c07f40649c5c~RXOEvB2J-1410214102euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698240656;
        bh=dXf9wUUf5w5y7OBV4KeN+1ChCSvq94K/h1PmwKd1DP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1xZYTZLCJE9PX4xThAgbQjNA4E4u5wbvXzcojQ+zPPDgRAcDh5vHAvQ9aIjDkf9u
         DmQny275+1MaGNyTRpeWT6P1g8j8GHtBoi4Mh4NhHHkYsR9Ct+34CucxDT13PTHtdM
         mRRFsK26CRBf0fL0di+1qBWqgcSuDnzmJ74xXtWI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231025133056eucas1p1a2adf2d26aadcbaf08cef52eeb4cec47~RXOEKnNpU1622416224eucas1p1c;
        Wed, 25 Oct 2023 13:30:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BE.0B.37758.F8819356; Wed, 25
        Oct 2023 14:30:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231025133055eucas1p13779e9c86720bf460c12b28c6d830f2a~RXODnVXLp1383513835eucas1p1n;
        Wed, 25 Oct 2023 13:30:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231025133055eusmtrp118dc2d78f39781360c357af53597bfe6~RXODmrwpP0869708697eusmtrp1_;
        Wed, 25 Oct 2023 13:30:55 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-68-6539188f47c1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 35.A8.10549.F8819356; Wed, 25
        Oct 2023 14:30:55 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231025133054eusmtip20ca3122846fae9c23e3274de6df353cb~RXOCxF0RM1587515875eusmtip2C;
        Wed, 25 Oct 2023 13:30:54 +0000 (GMT)
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
Subject: [PATCH v4 6/8] thermal: exynos: stop using the threshold mechanism
 on Exynos 4210
Date:   Wed, 25 Oct 2023 15:30:25 +0200
Message-ID: <20231025133027.524152-7-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025133027.524152-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djPc7oTJCxTDV4tYbR4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYLm1rYLSYe
        m8xssfbIXXaLuV+mMls8edjH5iDgsWbeGkaPnbPusnss3vOSyWPTqk42jzvX9rB5bF5S79G3
        ZRWjx+dNcgEcUVw2Kak5mWWpRfp2CVwZf858YytYyV8x8eVktgbGdzxdjJwcEgImEofnv2Lu
        YuTiEBJYwShx88pTNgjnC6PEtYn7GCGcz4wSf1+/ZYJpufL7JTtEYjmjxMt1u6FaWpkkVq5s
        ZASpYhMwkHjwZhk7iC0i0MooMbNJHaSIWeArs8TV1/OZQRLCAjES5+/NB2tgEVCV2NmxFKyB
        V8BWYv6ppVDr5CX2LPoOZnMK2En0Hr/OBlEjKHFy5hMWEJsZqKZ562ywLyQEujklljesZYVo
        dpE4e/Y2C4QtLPHq+BZ2CFtG4vTkHqh4vsSMze+BbA4gu0Li7kEvCNNa4uMZZhCTWUBTYv0u
        fYhiR4nHn5qgivkkbrwVhDiAT2LStunMEGFeiY42IYhqVYnjeyYxQ9jSEk9abjNBlHhIPGxl
        ncCoOAvJJ7OQfDILYe0CRuZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgYnt9L/jX3cw
        rnj1Ue8QIxMH4yFGCQ5mJRHeSB+LVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC6Ykl
        qdmpqQWpRTBZJg5OqQamdZfVdfx9m/5rftqz1ZTzyJStmhGzfk8LaPK0iMq4djG+Rn/51Ase
        9bPP1CrmdalFJ5rKt3IWCmZkMCxu0as0djp5gs1advafut7wTtV14p9t/wcKvGjaISV+9lBw
        d8UmxXeeiV8duVdytTm8avq0+8h7XQuLfx9jniwO6rnF/KRg3+ULOsctPgard//c+Wf3GZ/W
        uKYElZ4ti2wD1AMjzmxKW8f97UXt0oX/ozRFZZi51Pn/rDZfsOKUTOertlOPD4p3uEo6nvsk
        08f078jEcA5bsYAPvBFTDO3rytbw/z6sYFA4f5tl2crf648d/+K8ueeK6x53Yfe+2TXmD2Va
        py2fqzR7mV7IJbVJ07mUWIozEg21mIuKEwF5bhfi2wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7r9EpapBndapC0ezNvGZnF4foXF
        1IdP2Cy+b7nOZDHvs6zF3tdb2S2+Xelgstj0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i4nH
        JjNbrD1yl91i7pepzBZPHvaxOQh4rJm3htFj56y77B6L97xk8ti0qpPN4861PWwem5fUe/Rt
        WcXo8XmTXABHlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllq
        kb5dgl7GnzPf2ApW8ldMfDmZrYHxHU8XIyeHhICJxJXfL9m7GLk4hASWMkoseTKRCSIhLXH4
        yxR2CFtY4s+1LjaIomYmiYuvehhBEmwCBhIP3iwD6xYR6GSU6Np8DqybWeA/s8TXmQpdjBwc
        wgJREqsnKoCEWQRUJXZ2LAUbyitgKzH/1FKoZfISexZ9B7M5Bewkeo9fZwOxhYBqJnQ8hKoX
        lDg58wkLxHh5ieats5knMArMQpKahSS1gJFpFaNIamlxbnpusaFecWJucWleul5yfu4mRmAc
        bjv2c/MOxnmvPuodYmTiYDzEKMHBrCTCG+ljkSrEm5JYWZValB9fVJqTWnyI0RTo7onMUqLJ
        +cBEkFcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwFT/6cfkxifr
        Nq5nXFjw5bKlUYmUUYTcN6uupoW27P15JxbuW/dP/PzqeKUFYpMUri3Za/3puxt/6k2TZQ+D
        1kSluTy3PdHkbNPh+1/8Wt/cCbMfNaX2/PpTelRKeIqhh+Vxnz095TtePfxXnhnXZn8o9eGb
        X4IXyos3izw2EYqeoR0qIRnmO+dPvUFUzxRzt7BnP/6tq9JimVZwuP9acfmcTVNZjh33fi1m
        WTmvIYMx+fajrgI5iUzr7MWJzBmP2tn/Bt6QyF7veb/b1cxDS+vjAdVrC9/F3C6qyijw27N6
        bWie9/Kd98rFQrexN+ydaPVu8tpvbpIzKsV8i2cqau3UkwibUzLv2VHLJ8WRd5VYijMSDbWY
        i4oTAdmYmvpMAwAA
X-CMS-MailID: 20231025133055eucas1p13779e9c86720bf460c12b28c6d830f2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231025133055eucas1p13779e9c86720bf460c12b28c6d830f2a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231025133055eucas1p13779e9c86720bf460c12b28c6d830f2a
References: <20231025133027.524152-1-m.majewski2@samsung.com>
        <CGME20231025133055eucas1p13779e9c86720bf460c12b28c6d830f2a@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

