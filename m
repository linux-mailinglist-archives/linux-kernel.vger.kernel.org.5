Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3743C7B67AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbjJCLR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240071AbjJCLRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:17:19 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9072BAC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:17:14 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231003111713euoutp02a845eddd9f1dc0154dd2ed034e38f5a4~KlNCV78FG1157311573euoutp02o
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:17:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231003111713euoutp02a845eddd9f1dc0154dd2ed034e38f5a4~KlNCV78FG1157311573euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696331833;
        bh=wYOgN+xChN8fb2aWq0gBrJakJtJYp/uVLT+nkSF3JUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eizkfNKFZ1o9eaG2fZd+H1o8TrkjU2rrdZBa/6kxrdjFvwdSI7KV3ud4qXbH2v0Zv
         XD+KY5OjT7YptY1X+wc956IAlKv0/FZCU4v04BeWVcET72pHiM3EX08iP7mYbB1XuB
         Wz0ElMWccw7Rpas9+BCb5GY5f90DK0vIcqLHpyPQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231003111712eucas1p142e0b9bb4ef708d18849c80a92cc2f73~KlNB5r8Jq2602126021eucas1p1l;
        Tue,  3 Oct 2023 11:17:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 36.2F.37758.838FB156; Tue,  3
        Oct 2023 12:17:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231003111712eucas1p1a089b3aa7e10ae84d8963f89b6bbecd6~KlNBZ5zjG2477724777eucas1p1l;
        Tue,  3 Oct 2023 11:17:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231003111712eusmtrp1ebfe6d9ab7bf019bb063466d7fa72045~KlNBZRO082246422464eusmtrp1k;
        Tue,  3 Oct 2023 11:17:12 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-e9-651bf838c8b5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 72.DE.25043.838FB156; Tue,  3
        Oct 2023 12:17:12 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111711eusmtip2641a272f6e51f817f80b17e7674ad965~KlNAnyci93045530455eusmtip2Y;
        Tue,  3 Oct 2023 11:17:11 +0000 (GMT)
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
Subject: [PATCH v3 6/8] thermal: exynos: stop using the threshold mechanism
 on Exynos 4210
Date:   Tue,  3 Oct 2023 13:16:32 +0200
Message-ID: <20231003111638.241542-7-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003111638.241542-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87oWP6RTDXbM0rR4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB7F
        ZZOSmpNZllqkb5fAlXFlaQdTwUr+irsnDjE2ML7j6WLk5JAQMJG42/matYuRi0NIYAWjxOvt
        T9kgnC+MEhMOL4fKfGaUmNW8hhWm5cqaJhaIxHJGiebdrcwQTiuTxMwdy1lAqtgEDCQevFnG
        DmKLCLQySsxsUgcpYha4xCxx9+ZasCJhgRiJLT+fA43l4GARUJVY+9cXJMwrYCsx4e8HJoht
        8hJ7Fn0HszkF7CRW/lzOBFEjKHFy5hOwMcxANc1bZzND1DdzSjx44gZhu0jc+dfOAmELS7w6
        voUdwpaROD25ByqeLzFj83sWkBMkBCok7h70gjCtJT6eYQYxmQU0Jdbv0ocodpToaPgNVcwn
        ceOtIMR+PolJ26YzQ4R5JTrahCCqVSWO75kEdZa0xJOW21AveUjMuruUfQKj4iwkn8xC8sks
        hL0LGJlXMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn525iBKaw0/+Of93BuOLVR71DjEwcjIcY
        JTiYlUR4w45KpQrxpiRWVqUW5ccXleakFh9ilOZgURLn1bY9mSwkkJ5YkpqdmlqQWgSTZeLg
        lGpgyt/1/veXb0k6ryTKPacEZT0IeLkgd0e2SNPk4wILm2125raqhpxNrrXR1FV+zyCnp2dm
        JrNUzCKzOn7x9v586yuO/rMKmJVtDPx1Q4qdWNQa5Zlm2jSsM/t96+XJF3Oa+ASL+L6+q9fc
        dVLo8xahxMoN7ctrRar3MtQWlVj6Ks4UfiFy9Qbfhp9LnrlKLHl0svHt9Zn79x2dspG9/cj7
        4OdZQh3Wa+5IR8+73XX02pK9vdpBE1xV5i98dsH55/xV341UFPlEX4qaiwbqdn2z/GEo3zHx
        yDztpAX2M1c9sln/5s3Cr7eVJFrMuRRa7P3yGs48/mL8dnuK1xqB2Ksd+lu+7ZLN7RCTEPky
        weC1EktxRqKhFnNRcSIAW+YxtNADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7oWP6RTDY494bR4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB6l
        Z1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3FlaQdT
        wUr+irsnDjE2ML7j6WLk5JAQMJG4sqaJpYuRi0NIYCmjRNOBVnaIhLTE4S9ToGxhiT/Xutgg
        ipqZJLoPrGYCSbAJGEg8eLOMHSQhItDJKNG1+RxYglngFrPE/ddaILawQJTEsd4VrF2MHBws
        AqoSa//6goR5BWwlJvz9wASxQF5iz6LvYDangJ3Eyp/LwWwhoJpby/exQNQLSpyc+YQFYry8
        RPPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzDmth37uWUH48pX
        H/UOMTJxMB5ilOBgVhLhDTsqlSrEm5JYWZValB9fVJqTWnyI0RTo7InMUqLJ+cCozyuJNzQz
        MDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYFp+VGjjSSONEoON2etVuP6w
        PekwjVt+Jl483G3FuTa5zimPs0/+sBNwuxh97M366Hu97o8Kep4Vedxtqc3brSO573yFh8z3
        tEWey2c8+CVS9PGDI+cH7sRvk5doLvf7+d+iYef9a8Kz193l3f2gNWuh7JrcD28Lk/eEVaV9
        Z/s0xT/g7J/olZ2nRD/XLfXIWtbOpeDItdDwRP/GYxNX+dY8qmdN/S28OLtS75Cp8jJ3bp+C
        lo2uh1p16ndn7OsK0Spe4Tcz/92qi3KlCQ/Mjy6Y8cpKYb1Ll7feKvm9EnLfm/5ncgdVrbc4
        Kzq33MGiqvrrgcTDS3ML7/qZLOF2cI+Y6G7YsnMXm+Ok3TuO7lJiKc5INNRiLipOBAAtPwL/
        QgMAAA==
X-CMS-MailID: 20231003111712eucas1p1a089b3aa7e10ae84d8963f89b6bbecd6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231003111712eucas1p1a089b3aa7e10ae84d8963f89b6bbecd6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231003111712eucas1p1a089b3aa7e10ae84d8963f89b6bbecd6
References: <20231003111638.241542-1-m.majewski2@samsung.com>
        <CGME20231003111712eucas1p1a089b3aa7e10ae84d8963f89b6bbecd6@eucas1p1.samsung.com>
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
index a0a1f7e1e63f..7138e001fa5a 100644
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

