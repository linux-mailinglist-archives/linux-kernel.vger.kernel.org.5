Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B597D6D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344772AbjJYNbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344643AbjJYNbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:31:07 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C9E1BC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:31:02 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231025133101euoutp025b7ac4b68a09181a6f3272fb25999d76~RXOI9ViAg1064010640euoutp02L
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:31:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231025133101euoutp025b7ac4b68a09181a6f3272fb25999d76~RXOI9ViAg1064010640euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698240661;
        bh=8Q8COwCQ4Q59tC09KlZwlNLVcpTGQ+H4Qu1qwU38McY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLhhQ6VaydvVWBxmfzvThAHoQt0Zma/61iNWvZ51Wz0L14Jty5CzD5PRFpGp1OuPC
         g90ITIroFc1emSarRzjRcnwX/w+btS7qr2PerCTGxDc6CGitLbkk/nTRA+P7WfEsFY
         ZxGOTtUd9e/7jXDTSPvS6MikmozJj5vn+2EMXV7Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231025133100eucas1p112adedd678f2b2820a9295a1dfbdd609~RXOIcX3g81621516215eucas1p1n;
        Wed, 25 Oct 2023 13:31:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 78.F7.42423.49819356; Wed, 25
        Oct 2023 14:31:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231025133100eucas1p14e6de58e52560d165bdb8b809e406278~RXOH1uBW81623816238eucas1p1c;
        Wed, 25 Oct 2023 13:31:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231025133100eusmtrp2ef98d90ccef4e1c7c016449015edc309~RXOH0-EVS1214112141eusmtrp2W;
        Wed, 25 Oct 2023 13:31:00 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-26-65391894f8a1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C1.36.25043.39819356; Wed, 25
        Oct 2023 14:30:59 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231025133059eusmtip29ba736219f8220756bff4c65186c867c~RXOG8mSFY1587515875eusmtip2F;
        Wed, 25 Oct 2023 13:30:59 +0000 (GMT)
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
Subject: [PATCH v4 8/8] thermal: exynos: use set_trips
Date:   Wed, 25 Oct 2023 15:30:27 +0200
Message-ID: <20231025133027.524152-9-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025133027.524152-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djP87pTJCxTDfZPV7Z4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYLm1rYLSYe
        m8xssfbIXXaLuV+mMls8edjH5iDgsWbeGkaPnbPusnss3vOSyWPTqk42jzvX9rB5bF5S79G3
        ZRWjx+dNcgEcUVw2Kak5mWWpRfp2CVwZDzr/MRY0rmGsOHSplbmBcUYvYxcjJ4eEgInEij27
        2UBsIYEVjBIL36d1MXIB2V8YJV4+62CFcD4zSix4v5YJpuP9oZcsEInljBIHdyyGclqZJJp2
        rQWbyyZgIPHgzTJ2EFtEoJVRYmaTOkgRs8BXZomrr+czgySEBcwkmpd9YAGxWQRUJR4+ewMW
        5xWwlfj/5SMrxDp5iT2LvoOt5hSwk+g9fp0NokZQ4uTMJ2C9zEA1zVtnM0PU93NKHN5YCWG7
        SExfdxsqLizx6vgWdghbRuL/zvlQ7+RLzNj8HmgOB5BdIXH3oBeEaS3x8QwziMksoCmxfpc+
        RLGjxIZJ/awQFXwSN94KQuznk5i0bTozRJhXoqNNCKJaVeL4nklQ66UlnrTchlrpIfFsSi/b
        BEbFWUg+mYXkk1kIexcwMq9iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITG2n/x3/tINx
        7quPeocYmTgYDzFKcDArifBG+likCvGmJFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJITyxJ
        zU5NLUgtgskycXBKNTD5zWyYzL1w/U+fpfXTzLQuda/t2nVqImOYbEPIlwv/7k8KEsj2ranO
        uHznVmeaSqRkyLZHP6XvLfkXfz9iy0b9ficDppspRz4/9hX96/anRvdBxb2ZlrtTRFc1Odbc
        Peb68MsH1z/v357Zdtxg2r/jHN+nBsZKfGaRvq9f6VOn9mqm+60O/lzf3SfLT/yVbchqbsr+
        NH9zobAz6yaXctdPO/L2LiuYqWKi+3KFDn/f4TZG3tdrkmp5RVTfLO+NWrj9mNCBmsCPwizu
        pRNvua/aM4tJ8RzX3rrItWKx1/auc+AUXMh4a/phgc3XFwiKeK68vKTyjmiI5vo988J0lBfd
        ucc2XzL6lWbIzYNtLs7rlViKMxINtZiLihMBgm9vRtwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7qTJSxTDaadsbR4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYLm1rYLSYe
        m8xssfbIXXaLuV+mMls8edjH5iDgsWbeGkaPnbPusnss3vOSyWPTqk42jzvX9rB5bF5S79G3
        ZRWjx+dNcgEcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWp
        Rfp2CXoZDzr/MRY0rmGsOHSplbmBcUYvYxcjJ4eEgInE+0MvWboYuTiEBJYySpztOMkOkZCW
        OPxlCpQtLPHnWhcbRFEzk8TM9ltMIAk2AQOJB2+WsYMkRAQ6GSW6Np8DSzAL/GeW+DpTAcQW
        FjCTaF72gQXEZhFQlXj47A0ziM0rYCvx/8tHVogN8hJ7Fn0H6+UUsJPoPX6dDcQWAqqZ0PGQ
        HaJeUOLkzCcsEPPlJZq3zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmb
        GIHRuO3Yzy07GFe++qh3iJGJg/EQowQHs5IIb6SPRaoQb0piZVVqUX58UWlOavEhRlOguycy
        S4km5wPTQV5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA1Oq+eqc
        U9FfojNyTH0nf29hmWahZpcnosh6mfVN54KgvL4LFltv3qzcIHjR++atPHe//VckxdzY/GIX
        vPv8kPOGkniRJs/vnXwKSVIhgtf5j8c7npNqSpqre1/3xw75ozfcW5X3R/Ys8uuc2DpZm/dL
        2d1umWn8Jm2REb82XZbYziyf7H/dSqqt6t29P9Xndh+O3R2SYLK5KuC+/lqdYJvzK8KWbjgU
        afJfRGpK08x9rX4NaTlz0j6pZbL9WsaeqXq674tY/P7+xTYcAtITmx8w75FneRx3InG3pHap
        lnHUhCVrK38uXFvluPrzdsfVGbozw6y03+ioXUhzNbI20FGoCzD78O21QfTan9fXKrEUZyQa
        ajEXFScCAI2og3JPAwAA
X-CMS-MailID: 20231025133100eucas1p14e6de58e52560d165bdb8b809e406278
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231025133100eucas1p14e6de58e52560d165bdb8b809e406278
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231025133100eucas1p14e6de58e52560d165bdb8b809e406278
References: <20231025133027.524152-1-m.majewski2@samsung.com>
        <CGME20231025133100eucas1p14e6de58e52560d165bdb8b809e406278@eucas1p1.samsung.com>
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

Currently, each trip point defined in the device tree corresponds to a
single hardware interrupt. This commit instead switches to using two
hardware interrupts, whose values are set dynamically using the
set_trips callback. Additionally, the critical temperature threshold is
handled specifically.

Setting interrupts in this way also fixes a long-standing lockdep
warning, which was caused by calling thermal_zone_get_trips with our
lock being held. Do note that this requires TMU initialization to be
split into two parts, as done by the parent commit: parts of the
initialization call into the thermal_zone_device structure and so must
be done after its registration, but the initialization is also
responsible for setting up calibration, which must be done before
thermal_zone_device registration, which will call set_trips for the
first time; if the calibration is not done in time, the interrupt values
will be silently wrong!

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v2 -> v3: Fixed formatting of some comments.
v1 -> v2: We take clocks into account; anything that sets temperature
  thresholds needs clk.

 drivers/thermal/samsung/exynos_tmu.c | 400 +++++++++++++++------------
 1 file changed, 226 insertions(+), 174 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 6b3a7dd05c68..6d19e72a490d 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -158,10 +158,12 @@ enum soc_type {
  *	in the positive-TC generator block
  *	0 < reference_voltage <= 31
  * @tzd: pointer to thermal_zone_device structure
- * @ntrip: number of supported trip points.
  * @enabled: current status of TMU device
- * @tmu_set_trip_temp: SoC specific method to set trip (rising threshold)
- * @tmu_set_trip_hyst: SoC specific to set hysteresis (falling threshold)
+ * @tmu_set_low_temp: SoC specific method to set trip (falling threshold)
+ * @tmu_set_high_temp: SoC specific method to set trip (rising threshold)
+ * @tmu_set_crit_temp: SoC specific method to set critical temperature
+ * @tmu_disable_low: SoC specific method to disable an interrupt (falling threshold)
+ * @tmu_disable_high: SoC specific method to disable an interrupt (rising threshold)
  * @tmu_initialize: SoC specific TMU initialization method
  * @tmu_control: SoC specific TMU control method
  * @tmu_read: SoC specific TMU temperature read method
@@ -183,13 +185,13 @@ struct exynos_tmu_data {
 	u8 gain;
 	u8 reference_voltage;
 	struct thermal_zone_device *tzd;
-	unsigned int ntrip;
 	bool enabled;
 
-	void (*tmu_set_trip_temp)(struct exynos_tmu_data *data, int trip,
-				 u8 temp);
-	void (*tmu_set_trip_hyst)(struct exynos_tmu_data *data, int trip,
-				 u8 temp, u8 hyst);
+	void (*tmu_set_low_temp)(struct exynos_tmu_data *data, u8 temp);
+	void (*tmu_set_high_temp)(struct exynos_tmu_data *data, u8 temp);
+	void (*tmu_set_crit_temp)(struct exynos_tmu_data *data, u8 temp);
+	void (*tmu_disable_low)(struct exynos_tmu_data *data);
+	void (*tmu_disable_high)(struct exynos_tmu_data *data);
 	void (*tmu_initialize)(struct platform_device *pdev);
 	void (*tmu_control)(struct platform_device *pdev, bool on);
 	int (*tmu_read)(struct exynos_tmu_data *data);
@@ -279,49 +281,28 @@ static int exynos_thermal_zone_configure(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tzd = data->tzd;
-	int i, num_trips = thermal_zone_get_num_trips(tzd);
-	int ret = 0, temp;
+	int ret, temp;
 
 	ret = thermal_zone_get_crit_temp(tzd, &temp);
+	if (ret) {
+		/* FIXME: Remove this special case */
+		if (data->soc == SOC_ARCH_EXYNOS5433)
+			return 0;
 
-	if (ret && data->soc != SOC_ARCH_EXYNOS5433) { /* FIXME */
 		dev_err(&pdev->dev,
 			"No CRITICAL trip point defined in device tree!\n");
-		goto out;
+		return ret;
 	}
 
 	mutex_lock(&data->lock);
-
-	if (num_trips > data->ntrip) {
-		dev_info(&pdev->dev,
-			 "More trip points than supported by this TMU.\n");
-		dev_info(&pdev->dev,
-			 "%d trip points should be configured in polling mode.\n",
-			 num_trips - data->ntrip);
-	}
-
 	clk_enable(data->clk);
 
-	num_trips = min_t(int, num_trips, data->ntrip);
+	data->tmu_set_crit_temp(data, temp / MCELSIUS);
 
-	/* Write temperature code for rising and falling threshold */
-	for (i = 0; i < num_trips; i++) {
-		struct thermal_trip trip;
-
-		ret = thermal_zone_get_trip(tzd, i, &trip);
-		if (ret)
-			goto err;
-
-		data->tmu_set_trip_temp(data, i, trip.temperature / MCELSIUS);
-		data->tmu_set_trip_hyst(data, i, trip.temperature / MCELSIUS,
-					trip.hysteresis / MCELSIUS);
-	}
-
-err:
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
-out:
-	return ret;
+
+	return 0;
 }
 
 static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
@@ -354,17 +335,58 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 	mutex_unlock(&data->lock);
 }
 
-static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
-					 int trip_id, u8 temp)
+static void exynos_tmu_update_bit(struct exynos_tmu_data *data, int reg_off,
+				  int bit_off, bool enable)
 {
-	temp = temp_to_code(data, temp);
-	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip_id * 4);
+	u32 interrupt_en;
+
+	interrupt_en = readl(data->base + reg_off);
+	if (enable)
+		interrupt_en |= 1 << bit_off;
+	else
+		interrupt_en &= ~(1 << bit_off);
+	writel(interrupt_en, data->base + reg_off);
 }
 
-/* failing thresholds are not supported on Exynos4210 */
-static void exynos4210_tmu_set_trip_hyst(struct exynos_tmu_data *data,
-					 int trip, u8 temp, u8 hyst)
+static void exynos4210_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
 {
+	/*
+	 * Failing thresholds are not supported on Exynos 4210.
+	 * We use polling instead.
+	 */
+}
+
+static void exynos4210_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	temp = temp_to_code(data, temp);
+	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + 4);
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_RISE0_SHIFT + 4, true);
+}
+
+static void exynos4210_tmu_disable_low(struct exynos_tmu_data *data)
+{
+	/* Again, this is handled by polling. */
+}
+
+static void exynos4210_tmu_disable_high(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_RISE0_SHIFT + 4, false);
+}
+
+static void exynos4210_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	/*
+	 * Hardware critical temperature handling is not supported on Exynos 4210.
+	 * We still set the critical temperature threshold, but this is only to
+	 * make sure it is handled as soon as possible. It is just a normal interrupt.
+	 */
+
+	temp = temp_to_code(data, temp);
+	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + 12);
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_RISE0_SHIFT + 12, true);
 }
 
 static void exynos4210_tmu_initialize(struct platform_device *pdev)
@@ -376,33 +398,49 @@ static void exynos4210_tmu_initialize(struct platform_device *pdev)
 	writeb(0, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
 }
 
-static void exynos4412_tmu_set_trip_temp(struct exynos_tmu_data *data,
-					 int trip, u8 temp)
-{
-	u32 th, con;
-
-	th = readl(data->base + EXYNOS_THD_TEMP_RISE);
-	th &= ~(0xff << 8 * trip);
-	th |= temp_to_code(data, temp) << 8 * trip;
-	writel(th, data->base + EXYNOS_THD_TEMP_RISE);
-
-	if (trip == 3) {
-		con = readl(data->base + EXYNOS_TMU_REG_CONTROL);
-		con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
-		writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
-	}
-}
-
-static void exynos4412_tmu_set_trip_hyst(struct exynos_tmu_data *data,
-					 int trip, u8 temp, u8 hyst)
+static void exynos4412_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
 {
 	u32 th;
 
 	th = readl(data->base + EXYNOS_THD_TEMP_FALL);
-	th &= ~(0xff << 8 * trip);
-	if (hyst)
-		th |= temp_to_code(data, temp - hyst) << 8 * trip;
+	th &= ~(0xff << 0);
+	th |= temp_to_code(data, temp) << 0;
 	writel(th, data->base + EXYNOS_THD_TEMP_FALL);
+
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT, true);
+}
+
+static void exynos4412_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	u32 th;
+
+	th = readl(data->base + EXYNOS_THD_TEMP_RISE);
+	th &= ~(0xff << 8);
+	th |= temp_to_code(data, temp) << 8;
+	writel(th, data->base + EXYNOS_THD_TEMP_RISE);
+
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_RISE0_SHIFT + 4, true);
+}
+
+static void exynos4412_tmu_disable_low(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT, false);
+}
+
+static void exynos4412_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	u32 th;
+
+	th = readl(data->base + EXYNOS_THD_TEMP_RISE);
+	th &= ~(0xff << 24);
+	th |= temp_to_code(data, temp) << 24;
+	writel(th, data->base + EXYNOS_THD_TEMP_RISE);
+
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_CONTROL,
+			      EXYNOS_TMU_THERM_TRIP_EN_SHIFT, true);
 }
 
 static void exynos4412_tmu_initialize(struct platform_device *pdev)
@@ -432,44 +470,57 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 	sanitize_temp_error(data, trim_info);
 }
 
-static void exynos5433_tmu_set_trip_temp(struct exynos_tmu_data *data,
-					 int trip, u8 temp)
+static void exynos5433_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
 {
-	unsigned int reg_off, j;
 	u32 th;
 
-	if (trip > 3) {
-		reg_off = EXYNOS5433_THD_TEMP_RISE7_4;
-		j = trip - 4;
-	} else {
-		reg_off = EXYNOS5433_THD_TEMP_RISE3_0;
-		j = trip;
-	}
+	th = readl(data->base + EXYNOS5433_THD_TEMP_FALL3_0);
+	th &= ~(0xff << 0);
+	th |= temp_to_code(data, temp) << 0;
+	writel(th, data->base + EXYNOS5433_THD_TEMP_FALL3_0);
 
-	th = readl(data->base + reg_off);
-	th &= ~(0xff << j * 8);
-	th |= (temp_to_code(data, temp) << j * 8);
-	writel(th, data->base + reg_off);
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT, true);
 }
 
-static void exynos5433_tmu_set_trip_hyst(struct exynos_tmu_data *data,
-					 int trip, u8 temp, u8 hyst)
+static void exynos5433_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
 {
-	unsigned int reg_off, j;
 	u32 th;
 
-	if (trip > 3) {
-		reg_off = EXYNOS5433_THD_TEMP_FALL7_4;
-		j = trip - 4;
-	} else {
-		reg_off = EXYNOS5433_THD_TEMP_FALL3_0;
-		j = trip;
-	}
+	th = readl(data->base + EXYNOS5433_THD_TEMP_RISE3_0);
+	th &= ~(0xff << 8);
+	th |= temp_to_code(data, temp) << 8;
+	writel(th, data->base + EXYNOS5433_THD_TEMP_RISE3_0);
 
-	th = readl(data->base + reg_off);
-	th &= ~(0xff << j * 8);
-	th |= (temp_to_code(data, temp - hyst) << j * 8);
-	writel(th, data->base + reg_off);
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 1, true);
+}
+
+static void exynos5433_tmu_disable_low(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT, false);
+}
+
+static void exynos5433_tmu_disable_high(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 1, false);
+}
+
+static void exynos5433_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	u32 th;
+
+	th = readl(data->base + EXYNOS5433_THD_TEMP_RISE7_4);
+	th &= ~(0xff << 24);
+	th |= temp_to_code(data, temp) << 24;
+	writel(th, data->base + EXYNOS5433_THD_TEMP_RISE7_4);
+
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_CONTROL,
+			      EXYNOS_TMU_THERM_TRIP_EN_SHIFT, true);
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 7, true);
 }
 
 static void exynos5433_tmu_initialize(struct platform_device *pdev)
@@ -505,34 +556,48 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
 			cal_type ?  2 : 1);
 }
 
-static void exynos7_tmu_set_trip_temp(struct exynos_tmu_data *data,
-				      int trip, u8 temp)
+static void exynos7_tmu_update_temp(struct exynos_tmu_data *data, u8 temp,
+				    int idx, bool rise)
 {
 	unsigned int reg_off, bit_off;
 	u32 th;
+	void __iomem *reg;
 
-	reg_off = ((7 - trip) / 2) * 4;
-	bit_off = ((8 - trip) % 2);
+	reg_off = ((7 - idx) / 2) * 4;
+	bit_off = ((8 - idx) % 2);
 
-	th = readl(data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
+	reg = data->base +
+	      (rise ? EXYNOS7_THD_TEMP_RISE7_6 : EXYNOS7_THD_TEMP_FALL7_6) +
+	      reg_off;
+	th = readl(reg);
 	th &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
 	th |= temp_to_code(data, temp) << (16 * bit_off);
-	writel(th, data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
+	writel(th, reg);
+
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      (rise ? EXYNOS7_TMU_INTEN_RISE0_SHIFT :
+				      EXYNOS_TMU_INTEN_FALL0_SHIFT) +
+				      idx,
+			      true);
 }
 
-static void exynos7_tmu_set_trip_hyst(struct exynos_tmu_data *data,
-				      int trip, u8 temp, u8 hyst)
+static void exynos7_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
 {
-	unsigned int reg_off, bit_off;
-	u32 th;
+	exynos7_tmu_update_temp(data, temp, 0, false);
+}
 
-	reg_off = ((7 - trip) / 2) * 4;
-	bit_off = ((8 - trip) % 2);
+static void exynos7_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	exynos7_tmu_update_temp(data, temp, 1, true);
+}
 
-	th = readl(data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);
-	th &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
-	th |= temp_to_code(data, temp - hyst) << (16 * bit_off);
-	writel(th, data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);
+static void exynos7_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	/*
+	 * Like Exynos 4210, Exynos 7 does not seem to support critical temperature
+	 * handling in hardware. Again, we still set a separate interrupt for it.
+	 */
+	exynos7_tmu_update_temp(data, temp, 7, true);
 }
 
 static void exynos7_tmu_initialize(struct platform_device *pdev)
@@ -547,87 +612,44 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
 static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
-	struct thermal_trip trip;
-	unsigned int con, interrupt_en = 0, i;
+	unsigned int con;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
-	if (on) {
-		for (i = 0; i < data->ntrip; i++) {
-			if (thermal_zone_get_trip(tz, i, &trip))
-				continue;
-
-			interrupt_en |=
-				(1 << (EXYNOS_TMU_INTEN_RISE0_SHIFT + i * 4));
-		}
-
-		if (data->soc != SOC_ARCH_EXYNOS4210)
-			interrupt_en |=
-				interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
-
+	if (on)
 		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-	} else {
+	else
 		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
-	}
 
-	writel(interrupt_en, data->base + EXYNOS_TMU_REG_INTEN);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
 
 static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
-	struct thermal_trip trip;
-	unsigned int con, interrupt_en = 0, pd_det_en, i;
+	unsigned int con, pd_det_en;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
-	if (on) {
-		for (i = 0; i < data->ntrip; i++) {
-			if (thermal_zone_get_trip(tz, i, &trip))
-				continue;
-
-			interrupt_en |=
-				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
-		}
-
-		interrupt_en |=
-			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
-
+	if (on)
 		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-	} else
+	else
 		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
 
 	pd_det_en = on ? EXYNOS5433_PD_DET_EN : 0;
 
 	writel(pd_det_en, data->base + EXYNOS5433_TMU_PD_DET_EN);
-	writel(interrupt_en, data->base + EXYNOS5433_TMU_REG_INTEN);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
 
 static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
-	struct thermal_trip trip;
-	unsigned int con, interrupt_en = 0, i;
+	unsigned int con;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
 	if (on) {
-		for (i = 0; i < data->ntrip; i++) {
-			if (thermal_zone_get_trip(tz, i, &trip))
-				continue;
-
-			interrupt_en |=
-				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
-		}
-
-		interrupt_en |=
-			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
-
 		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
 		con |= (1 << EXYNOS7_PD_DET_EN_SHIFT);
 	} else {
@@ -635,7 +657,6 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 		con &= ~(1 << EXYNOS7_PD_DET_EN_SHIFT);
 	}
 
-	writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
 
@@ -873,13 +894,15 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 
 	switch (data->soc) {
 	case SOC_ARCH_EXYNOS4210:
-		data->tmu_set_trip_temp = exynos4210_tmu_set_trip_temp;
-		data->tmu_set_trip_hyst = exynos4210_tmu_set_trip_hyst;
+		data->tmu_set_low_temp = exynos4210_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynos4210_tmu_set_high_temp;
+		data->tmu_disable_low = exynos4210_tmu_disable_low;
+		data->tmu_disable_high = exynos4210_tmu_disable_high;
+		data->tmu_set_crit_temp = exynos4210_tmu_set_crit_temp;
 		data->tmu_initialize = exynos4210_tmu_initialize;
 		data->tmu_control = exynos4210_tmu_control;
 		data->tmu_read = exynos4210_tmu_read;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
-		data->ntrip = 4;
 		data->gain = 15;
 		data->reference_voltage = 7;
 		data->efuse_value = 55;
@@ -892,14 +915,16 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	case SOC_ARCH_EXYNOS5260:
 	case SOC_ARCH_EXYNOS5420:
 	case SOC_ARCH_EXYNOS5420_TRIMINFO:
-		data->tmu_set_trip_temp = exynos4412_tmu_set_trip_temp;
-		data->tmu_set_trip_hyst = exynos4412_tmu_set_trip_hyst;
+		data->tmu_set_low_temp = exynos4412_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynos4412_tmu_set_high_temp;
+		data->tmu_disable_low = exynos4412_tmu_disable_low;
+		data->tmu_disable_high = exynos4210_tmu_disable_high;
+		data->tmu_set_crit_temp = exynos4412_tmu_set_crit_temp;
 		data->tmu_initialize = exynos4412_tmu_initialize;
 		data->tmu_control = exynos4210_tmu_control;
 		data->tmu_read = exynos4412_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
-		data->ntrip = 4;
 		data->gain = 8;
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
@@ -911,14 +936,16 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->max_efuse_value = 100;
 		break;
 	case SOC_ARCH_EXYNOS5433:
-		data->tmu_set_trip_temp = exynos5433_tmu_set_trip_temp;
-		data->tmu_set_trip_hyst = exynos5433_tmu_set_trip_hyst;
+		data->tmu_set_low_temp = exynos5433_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynos5433_tmu_set_high_temp;
+		data->tmu_disable_low = exynos5433_tmu_disable_low;
+		data->tmu_disable_high = exynos5433_tmu_disable_high;
+		data->tmu_set_crit_temp = exynos5433_tmu_set_crit_temp;
 		data->tmu_initialize = exynos5433_tmu_initialize;
 		data->tmu_control = exynos5433_tmu_control;
 		data->tmu_read = exynos4412_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
-		data->ntrip = 8;
 		data->gain = 8;
 		if (res.start == EXYNOS5433_G3D_BASE)
 			data->reference_voltage = 23;
@@ -929,14 +956,16 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->max_efuse_value = 150;
 		break;
 	case SOC_ARCH_EXYNOS7:
-		data->tmu_set_trip_temp = exynos7_tmu_set_trip_temp;
-		data->tmu_set_trip_hyst = exynos7_tmu_set_trip_hyst;
+		data->tmu_set_low_temp = exynos7_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynos7_tmu_set_high_temp;
+		data->tmu_disable_low = exynos5433_tmu_disable_low;
+		data->tmu_disable_high = exynos5433_tmu_disable_high;
+		data->tmu_set_crit_temp = exynos7_tmu_set_crit_temp;
 		data->tmu_initialize = exynos7_tmu_initialize;
 		data->tmu_control = exynos7_tmu_control;
 		data->tmu_read = exynos7_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
-		data->ntrip = 8;
 		data->gain = 9;
 		data->reference_voltage = 17;
 		data->efuse_value = 75;
@@ -972,9 +1001,32 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	return 0;
 }
 
+static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
+
+	mutex_lock(&data->lock);
+	clk_enable(data->clk);
+
+	if (low > INT_MIN)
+		data->tmu_set_low_temp(data, low / MCELSIUS);
+	else
+		data->tmu_disable_low(data);
+	if (high < INT_MAX)
+		data->tmu_set_high_temp(data, high / MCELSIUS);
+	else
+		data->tmu_disable_high(data);
+
+	clk_disable(data->clk);
+	mutex_unlock(&data->lock);
+
+	return 0;
+}
+
 static const struct thermal_zone_device_ops exynos_sensor_ops = {
 	.get_temp = exynos_get_temp,
 	.set_emul_temp = exynos_tmu_set_emulation,
+	.set_trips = exynos_set_trips,
 };
 
 static int exynos_tmu_probe(struct platform_device *pdev)
-- 
2.42.0

