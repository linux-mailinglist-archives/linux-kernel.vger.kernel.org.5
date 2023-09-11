Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B949679BF48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355132AbjIKV4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbjIKNgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:36:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F70106
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:36:24 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230911133623euoutp0212ebfadf74ce3804a3899987e870758a~D26RdAKjv1422614226euoutp02S
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:36:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230911133623euoutp0212ebfadf74ce3804a3899987e870758a~D26RdAKjv1422614226euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694439383;
        bh=K1X4F1+qpvpsy7/LqvjjMKRf/OuSoXogge+V1JLoBIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgboJFSfvxcxnQsrGka36ELyD/8iH5nU4TCG9t/EglnexMTpJr+h9fedPXvWwXBKJ
         lyI2lcfStmPfz+HZBjxBEk9PxJTKGHToAGW2JpmwaUjMX2p/rZydDs8zo97PzjKYN+
         MR1Z5hsyYcqh9V0UFx2RrQGGw617VbRVb8Etrjxg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230911133622eucas1p2b8c930566154ddd02b1e0fd338e4d352~D26QoOtZf0333903339eucas1p2U;
        Mon, 11 Sep 2023 13:36:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A0.C1.42423.6D71FF46; Mon, 11
        Sep 2023 14:36:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230911133622eucas1p2d27118647d37fa2fe2973773f70359c4~D26QGurLd0331103311eucas1p2A;
        Mon, 11 Sep 2023 13:36:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230911133622eusmtrp2707164b800192825b48c11a15749bf3b~D26QF-msC0862108621eusmtrp2D;
        Mon, 11 Sep 2023 13:36:22 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-7c-64ff17d63e3c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 75.CB.10549.6D71FF46; Mon, 11
        Sep 2023 14:36:22 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230911133621eusmtip2c2d1ecc75aea807168a6b8a75a54a05f~D26O5dmwe0058100581eusmtip24;
        Mon, 11 Sep 2023 13:36:20 +0000 (GMT)
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
Subject: [PATCH v2 7/7] thermal: exynos: use set_trips
Date:   Mon, 11 Sep 2023 15:34:31 +0200
Message-ID: <20230911133435.14061-8-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911133435.14061-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djP87rXxP+nGOx+rmvxYN42NovD8yss
        pj58wmbxfct1Jot5n2Ut9r7eym7x7UoHk8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCwmHpvMbLH2
        yF12i7lfpjJbPHnYx+bA77Fz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9+rasYvT4vEkugD2K
        yyYlNSezLLVI3y6BK2PHxSbmgoOrGStWHZrE2sD4poexi5GTQ0LAROLq9wYmEFtIYAWjxOue
        iC5GLiD7C6PEtBntTBDOZ0aJz+fmMMF0bLj+F6pjOaPEqy4piKJWJok9f+eDJdgEDCQevFnG
        DmKLCLQySsxsUgcpYha4xCxx9+ZaFpCEsICZxIFPp1hBbBYBVYn5Mx+DNfAK2EhMP3mMHWKb
        vMTzW3fAbE4BW4mza6dD1QhKnJz5BGwOM1BN89bZzCALJASaOSVOvzgB1ewi8ehuKwuELSzx
        6vgWqLiMxP+d86HeyZeYsfk9UA0HkF0hcfegF4RpLfHxDDOIySygKbF+lz5EsaPExQO/WCEq
        +CRuvBWEOIBPYtK26cwQYV6JjjYhiGpVieN7JjFD2NIST1puQ630kJh29AH7BEbFWUhemYXk
        lVkIexcwMq9iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITGOn/x3/tINx7quPeocYmTgY
        DzFKcDArifCWHPqbIsSbklhZlVqUH19UmpNafIhRmoNFSZxX2/ZkspBAemJJanZqakFqEUyW
        iYNTqoEprsSzcmOjhOQWJ4PwnQtcTre6nqtaYXx6jjRn2RSNSN1m95ft/o53NmpKrvI1Zua+
        nZ8/afYtf+O52+TjfyqYXVi3lssgxOlIHv+E/4nBp7Xmrbrhlyb9au8/8cJXYo3fDLorJMR7
        NCvzfjnMyfa9riE8V5efYf2uApNZFyNW66vNULhdeDjohOivlZ9buj5mcZZ7WJo6Tz6i7qcv
        Xi+/f2lm3Ym/CV3RDxdPmzJJSvSv3yVnTuFGNtb4Bd6GSxevzWx9GnxfxW19V3uZ/wqNx4/P
        FvVM3y93h1f/tcT0kA0Ld32890s4VUz96PptIUc7f5nG3Tvl77Bk3c1XedIT3v/Tv/gsVEbm
        90/3/uNKLMUZiYZazEXFiQD2mkJB0gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xe7rXxP+nGCyax23xYN42NovD8yss
        pj58wmbxfct1Jot5n2Ut9r7eym7x7UoHk8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCwmHpvMbLH2
        yF12i7lfpjJbPHnYx+bA77Fz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9+rasYvT4vEkugD1K
        z6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PHxSbm
        goOrGStWHZrE2sD4poexi5GTQ0LARGLD9b9MXYxcHEICSxklVhxZyQKRkJY4/GUKO4QtLPHn
        WhcbRFEzk8T3rvVMIAk2AQOJB2+WsYMkRAQ6GSW6Np8DSzAL3GKWuP9aC8QWFjCTOPDpFCuI
        zSKgKjF/5mOwqbwCNhLTTx6D2iAv8fzWHTCbU8BW4uza6UA2B9A2G4n+MzoQ5YISJ2c+YYEY
        Ly/RvHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjLttx35u3sE4
        79VHvUOMTByMhxglOJiVRHhLDv1NEeJNSaysSi3Kjy8qzUktPsRoCnT2RGYp0eR8YOTnlcQb
        mhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwTXy5X+Vb5NOsnjXxbM+0
        6497hkr4ldcF5LQd7xSr+vdariJFRKC1n+Fhin2U+9SAGVF7fY78nL/7il7bR3Vm26fH6n2W
        bntu1aLL73TYuc9ZTyTg3rqWCPYPCds9E7sPyIU9834XwsUo/tnp8v6AHK7q8sC1SU8+Glva
        s7seO7a0tOiwS9z/zsMinx2SXBM6jizz+SK87mXd+yWNamY7d1n123OU7HRfskxchH3a66/9
        KbV7v20TX/BIbfIhUe/2bk9RjRKFVQ8ypwutY/XpldvNxvhE9btk9tYVP57deayRa/x7F7te
        qoS4XdIkxcOMJuKx7xUm2pv9vif49rU10xqryYe+qBzumHH84z0lluKMREMt5qLiRAA9/2t+
        RAMAAA==
X-CMS-MailID: 20230911133622eucas1p2d27118647d37fa2fe2973773f70359c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230911133622eucas1p2d27118647d37fa2fe2973773f70359c4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230911133622eucas1p2d27118647d37fa2fe2973773f70359c4
References: <20230911133435.14061-1-m.majewski2@samsung.com>
        <CGME20230911133622eucas1p2d27118647d37fa2fe2973773f70359c4@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
v1 -> v2: We take clocks into account; anything that sets temperature
  thresholds needs clk.

 drivers/thermal/samsung/exynos_tmu.c | 397 +++++++++++++++------------
 1 file changed, 223 insertions(+), 174 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 7b23ec73f93a..44ab9d9ae30d 100644
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
+		 /* FIXME: Remove this special case */
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
@@ -354,17 +335,56 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
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
+	/* Failing thresholds are not supported on Exynos 4210.
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
+	/* Hardware critical temperature handling is not supported on Exynos 4210.
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
@@ -376,33 +396,49 @@ static void exynos4210_tmu_initialize(struct platform_device *pdev)
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
@@ -432,44 +468,57 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
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
@@ -505,34 +554,47 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
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
+	/* Like Exynos 4210, Exynos 7 does not seem to support critical temperature
+	 * handling in hardware. Again, we still set a separate interrupt for it.
+	 */
+	exynos7_tmu_update_temp(data, temp, 7, true);
 }
 
 static void exynos7_tmu_initialize(struct platform_device *pdev)
@@ -547,87 +609,44 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
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
@@ -635,7 +654,6 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 		con &= ~(1 << EXYNOS7_PD_DET_EN_SHIFT);
 	}
 
-	writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
 
@@ -873,13 +891,15 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 
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
@@ -892,14 +912,16 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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
@@ -911,14 +933,16 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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
@@ -929,14 +953,16 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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
@@ -972,9 +998,32 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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
2.41.0

