Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061B87F165A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjKTOwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjKTOwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:52:02 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7BF1732
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:51:11 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231120145110euoutp0204d1b0ab188f18ae6cb17b67ed00635f~ZXFisH4Ae2423324233euoutp02h
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:51:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231120145110euoutp0204d1b0ab188f18ae6cb17b67ed00635f~ZXFisH4Ae2423324233euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700491870;
        bh=EoYrIwhJXyjOPElzlj7cqPH8vY7jZHqbZAOLBODfW24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MoN8k2k3jIsVvRJhruuEmpiMQlHRCHrbA+QD5IfHFY/KpmKfMMriqah/8CLrFZyGw
         2y+i1Lepa1ed1gZnUbzjqv+FCbWvg1R0yUL2zgZcUbG2kQ1ovrOpeFr5E5QubjSpjq
         Wl+kprqtDc2n0PNHtEIJop89KTCP49x1vwQFHKG4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231120145109eucas1p1f3211e52473b8cd26b84053a21cbe968~ZXFiKUtcx2470724707eucas1p1A;
        Mon, 20 Nov 2023 14:51:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B6.47.09539.D527B556; Mon, 20
        Nov 2023 14:51:09 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231120145109eucas1p16cb513a27831e7855cdd076c49b482c5~ZXFhtqW3w2546325463eucas1p1w;
        Mon, 20 Nov 2023 14:51:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231120145109eusmtrp21e46d8e50573e169a7b6e22d78377188~ZXFhs5LCJ0700707007eusmtrp22;
        Mon, 20 Nov 2023 14:51:09 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-71-655b725d69a6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1F.C3.09146.D527B556; Mon, 20
        Nov 2023 14:51:09 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231120145108eusmtip27d5a2599e851c42fe057f3a99319a694~ZXFg040bU1340013400eusmtip2E;
        Mon, 20 Nov 2023 14:51:08 +0000 (GMT)
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
Subject: [PATCH v5 9/9] thermal: exynos: use set_trips
Date:   Mon, 20 Nov 2023 15:50:49 +0100
Message-ID: <20231120145049.310509-10-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120145049.310509-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djP87qxRdGpBs+vKFo8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKC6blNSczLLUIn27BK6MQ6camAsWrGWsOPhyKXsD46J+xi5GTg4JAROJN5tO
        M3cxcnEICaxglFg75T47hPOFUeLpgy42COczo8Sxk0/ZYVomHd4M1bKcUeL1uX9QVa1MElc/
        v2ECqWITMJB48GYZWIeIQCujxMwmdZAiZoGvzBJXX89nBkkIC5hJ/Pi6FsxmEVCVmHXvApjN
        K2An8XXbLqgL5SX2LPoONpQTKN525DkbRI2gxMmZT1hAbGagmuats8FOkhDo55TYvaadBaLZ
        RaLnQDMThC0s8er4FqgfZCT+75wPFc+XmLH5PVA9B5BdIXH3oBeEaS3x8QwziMksoCmxfpc+
        RLGjxOMJd5kgKvgkbrwVhDiAT2LStunMEGFeiY42IYhqVYnjeyYxQ9jSEk9abkOt9JCYtmMR
        6wRGxVlIXpmF5JVZCHsXMDKvYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECExvp/8d/7SD
        ce6rj3qHGJk4GA8xSnAwK4nwfhOKSBXiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5oinyokkJ5Y
        kpqdmlqQWgSTZeLglGpg8nArNj4br3n4yj/bTc8UzhjLbjlbk3M3yptNf9r7bGO7sjof+cX6
        pr7pcw+UbeG9GKvi/dPn96VYiWeKSxprd3LaBt1dc+abU9y3U9nqv/8w7N75ysh2w5JTd1I0
        d/vGuSzh3vTlcH229edFVyzTtZVuL/l0qf30VLerj2/X/j/Iv3PeBEle1/fH3k8P968VyQmY
        srZles+6yOaZdx14u3V+GWikf+Z2vJy87lCiU99k46zWBV83+ikkfzlqlrRasmF3+4uFve+4
        s9I2Cm2+Na1vUoxlIut3L4FrX7SzfNSfRRo33Oc6KZa16IrOyyVnI3VXfKk6wp7/Yq+zv9Ha
        wzLbZHqVd72fHmLflrr3phJLcUaioRZzUXEiAEtvsH3eAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7qxRdGpBodnsVk8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2MQ6camAsWrGWsOPhyKXsD46J+xi5GTg4JAROJSYc3M3cxcnEICSxllJj1sJUdIiEt
        cfjLFChbWOLPtS42iKJmJoldV1+wgiTYBAwkHrxZxg6SEBHoZJTo2nyOCSTBLPCfWeLrTAUQ
        W1jATOLH17XMIDaLgKrErHsXwGxeATuJr9t2QZ0hL7Fn0XewXk6geNuR50DbOIC22Up03NWA
        KBeUODnzCQvEeHmJ5q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZG
        YCxuO/Zz8w7Gea8+6h1iZOJgPMQowcGsJML7TSgiVYg3JbGyKrUoP76oNCe1+BCjKdDZE5ml
        RJPzgckgryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBie1dc9Yq
        XuXyjHd/DK+IsG+3tmOuvLui5KLrje3aJy30js47sElBh8Ht6Tl+rftOz4+1r1mdvvOYjN19
        T17GaQotb00ZN30K44oJO6l92CawRFniYOeHrZJns1oY+x76RSV1CH9ifGJuNKerw5LnXqJ5
        zMEHXZd9m6wfO2/7/3Rvf1Ex53Rl6+3OpfUbZOpcNe9cWdlVIhwv7lAYsoTr2aLtHB3FMXM3
        RzZqOM121frLENflvlFJ8KOFtPtmt6WnjKdOSDWwf7A8ZdfRVv7PO+rbbyT536h1Wf/s58ZM
        2/Nfas12vVyQF+4Wtp7zZsyuqwruCYeZW1ZySv098T+Np/BG5QHWu5v7XP9G3l6oxFKckWio
        xVxUnAgAFglE8E4DAAA=
X-CMS-MailID: 20231120145109eucas1p16cb513a27831e7855cdd076c49b482c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231120145109eucas1p16cb513a27831e7855cdd076c49b482c5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231120145109eucas1p16cb513a27831e7855cdd076c49b482c5
References: <20231120145049.310509-1-m.majewski2@samsung.com>
        <CGME20231120145109eucas1p16cb513a27831e7855cdd076c49b482c5@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
v4 -> v5: Simplified Exynos 7 code, used the correct register offsets
  for Exynos 7 and refactored some common register-setting code.
v2 -> v3: Fixed formatting of some comments.
v1 -> v2: We take clocks into account; anything that sets temperature
  thresholds needs clk.

 drivers/thermal/samsung/exynos_tmu.c | 393 ++++++++++++++-------------
 1 file changed, 209 insertions(+), 184 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 40e250c815f8..e319fae0e7a1 100644
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
@@ -354,17 +335,74 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
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
+		interrupt_en |= BIT(bit_off);
+	else
+		interrupt_en &= ~BIT(bit_off);
+	writel(interrupt_en, data->base + reg_off);
 }
 
-/* failing thresholds are not supported on Exynos4210 */
-static void exynos4210_tmu_set_trip_hyst(struct exynos_tmu_data *data,
-					 int trip, u8 temp, u8 hyst)
+static void exynos_tmu_update_temp(struct exynos_tmu_data *data, int reg_off,
+				   int bit_off, u8 temp)
 {
+	u16 tmu_temp_mask;
+	u32 th;
+
+	tmu_temp_mask =
+		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MASK
+						: EXYNOS_TMU_TEMP_MASK;
+
+	th = readl(data->base + reg_off);
+	th &= ~(tmu_temp_mask << bit_off);
+	th |= temp_to_code(data, temp) << bit_off;
+	writel(th, data->base + reg_off);
+}
+
+static void exynos4210_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
+{
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
@@ -376,33 +414,31 @@ static void exynos4210_tmu_initialize(struct platform_device *pdev)
 	writeb(0, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
 }
 
-static void exynos4412_tmu_set_trip_temp(struct exynos_tmu_data *data,
-					 int trip, u8 temp)
+static void exynos4412_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
 {
-	u32 th, con;
-
-	th = readl(data->base + EXYNOS_THD_TEMP_RISE);
-	th &= ~(0xff << 8 * trip);
-	th |= temp_to_code(data, temp) << 8 * trip;
-	writel(th, data->base + EXYNOS_THD_TEMP_RISE);
-
-	if (trip == 3) {
-		con = readl(data->base + EXYNOS_TMU_REG_CONTROL);
-		con |= BIT(EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
-		writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
-	}
+	exynos_tmu_update_temp(data, EXYNOS_THD_TEMP_FALL, 0, temp);
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT, true);
 }
 
-static void exynos4412_tmu_set_trip_hyst(struct exynos_tmu_data *data,
-					 int trip, u8 temp, u8 hyst)
+static void exynos4412_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
 {
-	u32 th;
+	exynos_tmu_update_temp(data, EXYNOS_THD_TEMP_RISE, 8, temp);
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_RISE0_SHIFT + 4, true);
+}
 
-	th = readl(data->base + EXYNOS_THD_TEMP_FALL);
-	th &= ~(0xff << 8 * trip);
-	if (hyst)
-		th |= temp_to_code(data, temp - hyst) << 8 * trip;
-	writel(th, data->base + EXYNOS_THD_TEMP_FALL);
+static void exynos4412_tmu_disable_low(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT, false);
+}
+
+static void exynos4412_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	exynos_tmu_update_temp(data, EXYNOS_THD_TEMP_RISE, 24, temp);
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_CONTROL,
+			      EXYNOS_TMU_THERM_TRIP_EN_SHIFT, true);
 }
 
 static void exynos4412_tmu_initialize(struct platform_device *pdev)
@@ -432,44 +468,39 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 	sanitize_temp_error(data, trim_info);
 }
 
-static void exynos5433_tmu_set_trip_temp(struct exynos_tmu_data *data,
-					 int trip, u8 temp)
+static void exynos5433_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
 {
-	unsigned int reg_off, j;
-	u32 th;
-
-	if (trip > 3) {
-		reg_off = EXYNOS5433_THD_TEMP_RISE7_4;
-		j = trip - 4;
-	} else {
-		reg_off = EXYNOS5433_THD_TEMP_RISE3_0;
-		j = trip;
-	}
-
-	th = readl(data->base + reg_off);
-	th &= ~(0xff << j * 8);
-	th |= (temp_to_code(data, temp) << j * 8);
-	writel(th, data->base + reg_off);
+	exynos_tmu_update_temp(data, EXYNOS5433_THD_TEMP_FALL3_0, 0, temp);
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT, true);
 }
 
-static void exynos5433_tmu_set_trip_hyst(struct exynos_tmu_data *data,
-					 int trip, u8 temp, u8 hyst)
+static void exynos5433_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
 {
-	unsigned int reg_off, j;
-	u32 th;
+	exynos_tmu_update_temp(data, EXYNOS5433_THD_TEMP_RISE3_0, 8, temp);
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 1, true);
+}
 
-	if (trip > 3) {
-		reg_off = EXYNOS5433_THD_TEMP_FALL7_4;
-		j = trip - 4;
-	} else {
-		reg_off = EXYNOS5433_THD_TEMP_FALL3_0;
-		j = trip;
-	}
+static void exynos5433_tmu_disable_low(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT, false);
+}
 
-	th = readl(data->base + reg_off);
-	th &= ~(0xff << j * 8);
-	th |= (temp_to_code(data, temp - hyst) << j * 8);
-	writel(th, data->base + reg_off);
+static void exynos5433_tmu_disable_high(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 1, false);
+}
+
+static void exynos5433_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	exynos_tmu_update_temp(data, EXYNOS5433_THD_TEMP_RISE7_4, 24, temp);
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_CONTROL,
+			      EXYNOS_TMU_THERM_TRIP_EN_SHIFT, true);
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 7, true);
 }
 
 static void exynos5433_tmu_initialize(struct platform_device *pdev)
@@ -505,34 +536,41 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
 			cal_type ?  2 : 1);
 }
 
-static void exynos7_tmu_set_trip_temp(struct exynos_tmu_data *data,
-				      int trip, u8 temp)
+static void exynos7_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
 {
-	unsigned int reg_off, bit_off;
-	u32 th;
-
-	reg_off = ((7 - trip) / 2) * 4;
-	bit_off = ((8 - trip) % 2);
-
-	th = readl(data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
-	th &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
-	th |= temp_to_code(data, temp) << (16 * bit_off);
-	writel(th, data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
+	exynos_tmu_update_temp(data, EXYNOS7_THD_TEMP_FALL7_6 + 12, 0, temp);
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT + 0, true);
 }
 
-static void exynos7_tmu_set_trip_hyst(struct exynos_tmu_data *data,
-				      int trip, u8 temp, u8 hyst)
+static void exynos7_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
 {
-	unsigned int reg_off, bit_off;
-	u32 th;
+	exynos_tmu_update_temp(data, EXYNOS7_THD_TEMP_RISE7_6 + 12, 16, temp);
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 1, true);
+}
 
-	reg_off = ((7 - trip) / 2) * 4;
-	bit_off = ((8 - trip) % 2);
+static void exynos7_tmu_disable_low(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT + 0, false);
+}
 
-	th = readl(data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);
-	th &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
-	th |= temp_to_code(data, temp - hyst) << (16 * bit_off);
-	writel(th, data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);
+static void exynos7_tmu_disable_high(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 1, false);
+}
+
+static void exynos7_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	/*
+	 * Like Exynos 4210, Exynos 7 does not seem to support critical temperature
+	 * handling in hardware. Again, we still set a separate interrupt for it.
+	 */
+	exynos_tmu_update_temp(data, EXYNOS7_THD_TEMP_RISE7_6 + 0, 16, temp);
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 7, true);
 }
 
 static void exynos7_tmu_initialize(struct platform_device *pdev)
@@ -547,87 +585,44 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
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
-				BIT(EXYNOS_TMU_INTEN_RISE0_SHIFT + i * 4);
-		}
-
-		if (data->soc != SOC_ARCH_EXYNOS4210)
-			interrupt_en |=
-				interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
-
+	if (on)
 		con |= BIT(EXYNOS_TMU_CORE_EN_SHIFT);
-	} else {
+	else
 		con &= ~BIT(EXYNOS_TMU_CORE_EN_SHIFT);
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
-				BIT(EXYNOS7_TMU_INTEN_RISE0_SHIFT + i);
-		}
-
-		interrupt_en |=
-			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
-
+	if (on)
 		con |= BIT(EXYNOS_TMU_CORE_EN_SHIFT);
-	} else
+	else
 		con &= ~BIT(EXYNOS_TMU_CORE_EN_SHIFT);
 
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
-				BIT(EXYNOS7_TMU_INTEN_RISE0_SHIFT + i);
-		}
-
-		interrupt_en |=
-			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
-
 		con |= BIT(EXYNOS_TMU_CORE_EN_SHIFT);
 		con |= BIT(EXYNOS7_PD_DET_EN_SHIFT);
 	} else {
@@ -635,7 +630,6 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 		con &= ~BIT(EXYNOS7_PD_DET_EN_SHIFT);
 	}
 
-	writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
 
@@ -873,13 +867,15 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 
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
@@ -892,14 +888,16 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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
@@ -911,14 +909,16 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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
@@ -929,14 +929,16 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->max_efuse_value = 150;
 		break;
 	case SOC_ARCH_EXYNOS7:
-		data->tmu_set_trip_temp = exynos7_tmu_set_trip_temp;
-		data->tmu_set_trip_hyst = exynos7_tmu_set_trip_hyst;
+		data->tmu_set_low_temp = exynos7_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynos7_tmu_set_high_temp;
+		data->tmu_disable_low = exynos7_tmu_disable_low;
+		data->tmu_disable_high = exynos7_tmu_disable_high;
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
@@ -972,9 +974,32 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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

