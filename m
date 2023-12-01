Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEE58007C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378229AbjLAJ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378147AbjLAJ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:56:46 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767711725
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:56:50 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231201095649euoutp02d687b59ca20be7dac3a280c716bc4189~crKrrgoU90720007200euoutp02u
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:56:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231201095649euoutp02d687b59ca20be7dac3a280c716bc4189~crKrrgoU90720007200euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701424609;
        bh=cSAYLuBffpDa4AEHSE3pAa+hvuXwxT2jqNHC5mmW+GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lnb1MpXAkgJMUAHq9seJz9QOxaMy9BLojNC+q1w5eRIpNwFmqxtTdU8hOZ/TbH+3J
         dvtG/KPp9jVS895vZa9Nx82kO33Ni3t+/LMR/QcHob95pa6glOI3Zaun6zXNSkZO7/
         8XKGDxcugM2KvgEG7HPiiUgiZox7k1B8cepmZRkc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231201095648eucas1p2da7b41b0dcb58051ab2c9f349b502f26~crKrS1yJn1610416104eucas1p2N;
        Fri,  1 Dec 2023 09:56:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9C.42.09814.0EDA9656; Fri,  1
        Dec 2023 09:56:48 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231201095648eucas1p163db6b9b4d0e6fa7b1de40f3649e72a3~crKq0w5h01393613936eucas1p1P;
        Fri,  1 Dec 2023 09:56:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231201095648eusmtrp2d4c9d8b23c4175d2493848e590249ada~crKqz0G_C2087420874eusmtrp2x;
        Fri,  1 Dec 2023 09:56:48 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-01-6569ade02a5f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 43.22.09274.0EDA9656; Fri,  1
        Dec 2023 09:56:48 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231201095647eusmtip2d973b57abdb74555d17afdae71007da8~crKp6Y2av1190911909eusmtip28;
        Fri,  1 Dec 2023 09:56:47 +0000 (GMT)
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
Subject: [PATCH v6 9/9] thermal: exynos: use set_trips
Date:   Fri,  1 Dec 2023 10:56:25 +0100
Message-ID: <20231201095625.301884-10-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201095625.301884-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djPc7oP1mamGuzZZWjxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4Mro/CVecGEtY8XTP4dZGxjP9jN2MXJySAiY
        SOzqfsjWxcjFISSwglHi5/cD7BDOF0aJ6Zcng1UJCXxmlJizgQmmo2/DZ6ii5YwSm6+cYoVw
        Wpkkfv/fwA5SxSZgIPHgzTIwW0SglVFiZpM6iM0ssJBFouVfLogtLGAm8fLpWlYQm0VAVWLC
        lqcsIDavgJ3EpplfobbJS+xZ9B3M5gSKzz/UClUjKHFy5hMWiJnyEs1bZzND1E/nlJgzTxnC
        dpE4OO8LK4QtLPHq+BZ2CFtG4v/O+VDz8yVmbH4PNIcDyK6QuHvQC8K0lvh4hhnEZBbQlFi/
        Sx+i2FGioeExVDGfxI23ghD7+SQmbZvODBHmlehoE4KoVpU4vmcS1FnSEk9abkOt9JBYt/QC
        4wRGxVlIPpmF5JNZCHsXMDKvYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECExwp/8d/7KD
        cfmrj3qHGJk4GA8xSnAwK4nwXn+anirEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2x
        JDU7NbUgtQgmy8TBKdXAZMpvWnLh1DJpRmtxr0V3pVifCvk/v79mvyGnS+cV3gIvs8PhehEu
        qxVXxvzujnmiGsGwOtlhulbLSgX1+/szRZKFeSUZ/ia6JGQduFh8bHm/1OldzcpJnyIbGVcE
        yzxpfsomZ6N7qThPjyVu9zV1k2O5/775MMQ/+7Np/xFTFvVXbj6bkst/fbmkxM1qfqUoyeyu
        oaq6bShDnurnNcJzZp55tPZOVHVzoezU24mrWL/bZr3aNa9d7ufG6YwTjLZ/fB7S7/OkwiBR
        TzZ/ye0e+0tcl44JR+S/OH/Op/ueSuhdttDWWHeH9AizGeEzW45ey3vCdSMzVaFr66LK1j+l
        qp/Och/zn3/3yJanBzYrsRRnJBpqMRcVJwIAq8x1/98DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7oP1mamGuz4JWTxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0Mvo/CVecGEtY8XTP4dZGxjP9jN2MXJySAiYSPRt+MzexcjFISSwlFHi/Yc5
        UAlpicNfprBD2MISf651sUEUNTNJLHy3mgkkwSZgIPHgzTKwbhGBTkaJrs3nmEAcZoHVLBLH
        9n0HqxIWMJN4+XQtK4jNIqAqMWHLUxYQm1fATmLTzK9MECvkJfYsgqjnBIrPP9QKViMkYCvR
        teU/I0S9oMTJmU/A4sxA9c1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi3PTcYiO94sTc4tK8dL3k
        /NxNjMC43Hbs55YdjCtffdQ7xMjEwXiIUYKDWUmE9/rT9FQh3pTEyqrUovz4otKc1OJDjKZA
        d09klhJNzgcmhrySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqaZ
        Av+W7U41lBe/pfVI4mVansiT3hi7ieHiL3Obzv2ds8OQ9/TGKYfbGP8ev71i9/Q5scGsntnp
        Kt8KHjpMvuOz+7bG9b3rP977/7R2p4XNAmamnJifP7Qe5O6c/r1zsqr04UX7Zqp61DeWy+2r
        fO7u3m/Be2F2FTvf5H1PFctlT2iVSXOdn/RsIoMYz1QX5Qn2mtOdZ4VHB7e+TG+LTNLjF5Up
        +qsX8ehK2qe0L8piMpzTmo/Kq/+2WP9C8/lyj+NHWe4/TtD8vrpgodHNw9Inbl/3Fd3IW7/7
        81HL/TXxqaVZ+aGvuCIaZtp/WZt+d+nCWSJ/tTKl+7ouHlo9f2eVVS1fvEHkv+UNnGcmtR9R
        YinOSDTUYi4qTgQA9FbjM1QDAAA=
X-CMS-MailID: 20231201095648eucas1p163db6b9b4d0e6fa7b1de40f3649e72a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231201095648eucas1p163db6b9b4d0e6fa7b1de40f3649e72a3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231201095648eucas1p163db6b9b4d0e6fa7b1de40f3649e72a3
References: <20231201095625.301884-1-m.majewski2@samsung.com>
        <CGME20231201095648eucas1p163db6b9b4d0e6fa7b1de40f3649e72a3@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
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
index ca1b1cec0300..6482513bfe66 100644
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

