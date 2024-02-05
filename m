Return-Path: <linux-kernel+bounces-52908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FB9849E26
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C811284805
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE6E2D638;
	Mon,  5 Feb 2024 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD12wkue"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3B2C6B6;
	Mon,  5 Feb 2024 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147054; cv=none; b=XKwPRmOYADB4wrvT1iSXYb34KWG9eBzxv9n1Ze3ni11GVM9NiO5TGlTYJRuLmfhWesFvrFA9KTm3h1VmyNFesBFn2Z6sBxrb2zRWpsBSuYEoS3PFKFOoxbQ3j78/YDRrv687RY/STGBKOGJa/x5u4qI4NXdI3dtuDzrlrz+1qcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147054; c=relaxed/simple;
	bh=COtCgMJEEl6AiyTiI1HRpmzpK/Ws8F+wOJJua60FQBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y5Y23I9S1ZxjzdjwDcxnbMgYgNncLxic4w8G/haq2vnqlI7Utgh+I59T0Uner2vuxH3orOCZ/cKWzsbWolam+aTFsT/9KQPzmdxahlXeGOIipjROSRJIdZU1VhJSqGPHv2yeMpw8NfbWoxhb05LddRZBbpE6IhaZwHBs1UzGjQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cD12wkue; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so41605175e9.3;
        Mon, 05 Feb 2024 07:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707147051; x=1707751851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMOpOFN4+Mt35RaaklYtQdrfdXDhaK2aDTSXwocamhw=;
        b=cD12wkueHTViQNu+Biqk96XMfuk8t+6wvZVfi6ISO/zEKQdkqyVdm46jR8WSWhOD1c
         SI6kgfbUhd/v16b7zfSsMmv+7bH5yXZCBfUpt7iTohhndQsbvSbn0npsm+bLw/lZoaA8
         5b15udp1Er9fR3Xc5XWBId/0/VYu+JEPM73iCCDm0HTBcSPM+q1T0gyIorHLGnDgI2k7
         ybbxp+C7z5CSojBbFLX0O2tr0ZMM5Nrmgb6geEo8TY1SZivFUuam9hnlHTSmWpUrWWRD
         4GvGRUcXOC41MDH9CljV+0qur5Sp5vTusWYINFXB+AGwKStvLPAmekPfp8d8VCzGv6EC
         BgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707147051; x=1707751851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMOpOFN4+Mt35RaaklYtQdrfdXDhaK2aDTSXwocamhw=;
        b=o6FzlAMnpH9uUsPgJXBz8Tl+ETStnW+HiKr2KydPr5Bdnb4FPGy1K4ztkphitRmhKl
         h/ZWgq1OcwDzF6w+LKEv8vIFtsd+U30xxCL78njAuf+IFzTpLPb9P+l/o6PGu/jABVEg
         WTu9NK79Vn0PhhVIg4kyUIyBIQ3OQ3yNZeqXfKN5fHOBToCBkkmaWldSBLmBGkEcRLSP
         qCZ5MNysByPcisNByPM/ogsmhJAAkVOu7z88+Dd5ukwVdtWprq0SaTz0QZoVrhrJgCvv
         4tnUJHsJ+BS3irvu7aJR9/XGbBU0U/P+gc9y7gvUqxaKqlB2wUTGMferYbNi2korZjer
         +bDg==
X-Gm-Message-State: AOJu0YxptOQ6kmI38BqADgt2iVQ7Hh13awPDp9x11lF5FyDRp42wUFyo
	yLZUSkpa8y9eBEWzMB5cUzGYAvbApbIcpwZjwmW33ALYSxVjADDu
X-Google-Smtp-Source: AGHT+IFC+eSvbwvLZ002ngbOBji8GKUcJw5nH9j9wpY6Gedc+chnI76qLMCULegVWHZdTFs1ZzA9PQ==
X-Received: by 2002:a05:600c:1990:b0:40e:f66f:1959 with SMTP id t16-20020a05600c199000b0040ef66f1959mr99040wmq.17.1707147050604;
        Mon, 05 Feb 2024 07:30:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUwA7HMxEA4gThYRnXQYMyCL/TwpFT6sIB1nEU4rbKx1Rg8juOaN6Nh7GqoFjCAj/KdqitbJra7fLO6+PGtK7JKnmBx00jsKCE6bKubYqVrHGIWFeALdkjSMdVRZ/B67HUctsWa2wo/roOyCP0vJuqytLc3QOl8hptDCO7edfghrJQ2uHC3r6ACXDT740m9j4sMD14/Naf0
Received: from ran.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b0040ecdd672fasm171617wmq.13.2024.02.05.07.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 07:30:50 -0800 (PST)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: richardcochran@gmail.com,
	jonathan.lemon@gmail.com,
	vadfed@fb.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next v6] ptp: ocp: add Adva timecard support
Date: Mon,  5 Feb 2024 17:30:46 +0200
Message-Id: <20240205153046.3642-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.26.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support for the Adva timecard.
The card uses different drivers to provide access to the
firmware SPI flash (Altera based).
Other parts of the code are the same and could be reused.

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 Changes since version 5:
 - set Adva fw_tag = 3, since other tags are for other vendors.
 
 drivers/ptp/ptp_ocp.c | 302 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 293 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 9507681e0d12..6506cfb89aa9 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -34,6 +34,9 @@
 #define PCI_VENDOR_ID_OROLIA			0x1ad7
 #define PCI_DEVICE_ID_OROLIA_ARTCARD		0xa000
 
+#define PCI_VENDOR_ID_ADVA			0xad5a
+#define PCI_DEVICE_ID_ADVA_TIMECARD		0x0400
+
 static struct class timecard_class = {
 	.name		= "timecard",
 };
@@ -63,6 +66,13 @@ struct ocp_reg {
 	u32	status_drift;
 };
 
+struct ptp_ocp_servo_conf {
+	u32	servo_offset_p;
+	u32	servo_offset_i;
+	u32	servo_drift_p;
+	u32	servo_drift_i;
+};
+
 #define OCP_CTRL_ENABLE		BIT(0)
 #define OCP_CTRL_ADJUST_TIME	BIT(1)
 #define OCP_CTRL_ADJUST_OFFSET	BIT(2)
@@ -397,10 +407,14 @@ static int ptp_ocp_sma_store(struct ptp_ocp *bp, const char *buf, int sma_nr);
 
 static int ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
+static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
+
 static const struct ocp_attr_group fb_timecard_groups[];
 
 static const struct ocp_attr_group art_timecard_groups[];
 
+static const struct ocp_attr_group adva_timecard_groups[];
+
 struct ptp_ocp_eeprom_map {
 	u16	off;
 	u16	len;
@@ -700,6 +714,12 @@ static struct ocp_resource ocp_fb_resource[] = {
 	},
 	{
 		.setup = ptp_ocp_fb_board_init,
+		.extra = &(struct ptp_ocp_servo_conf) {
+			.servo_offset_p = 0x2000,
+			.servo_offset_i = 0x1000,
+			.servo_drift_p = 0,
+			.servo_drift_i = 0,
+		},
 	},
 	{ }
 };
@@ -831,6 +851,170 @@ static struct ocp_resource ocp_art_resource[] = {
 	},
 	{
 		.setup = ptp_ocp_art_board_init,
+		.extra = &(struct ptp_ocp_servo_conf) {
+			.servo_offset_p = 0x2000,
+			.servo_offset_i = 0x1000,
+			.servo_drift_p = 0,
+			.servo_drift_i = 0,
+		},
+	},
+	{ }
+};
+
+static struct ocp_resource ocp_adva_resource[] = {
+	{
+		OCP_MEM_RESOURCE(reg),
+		.offset = 0x01000000, .size = 0x10000,
+	},
+	{
+		OCP_EXT_RESOURCE(ts0),
+		.offset = 0x01010000, .size = 0x10000, .irq_vec = 1,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 0,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(ts1),
+		.offset = 0x01020000, .size = 0x10000, .irq_vec = 2,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 1,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(ts2),
+		.offset = 0x01060000, .size = 0x10000, .irq_vec = 6,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 2,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	/* Timestamp for PHC and/or PPS generator */
+	{
+		OCP_EXT_RESOURCE(pps),
+		.offset = 0x010C0000, .size = 0x10000, .irq_vec = 0,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 5,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(signal_out[0]),
+		.offset = 0x010D0000, .size = 0x10000, .irq_vec = 11,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 1,
+			.irq_fcn = ptp_ocp_signal_irq,
+			.enable = ptp_ocp_signal_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(signal_out[1]),
+		.offset = 0x010E0000, .size = 0x10000, .irq_vec = 12,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 2,
+			.irq_fcn = ptp_ocp_signal_irq,
+			.enable = ptp_ocp_signal_enable,
+		},
+	},
+	{
+		OCP_MEM_RESOURCE(pps_to_ext),
+		.offset = 0x01030000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(pps_to_clk),
+		.offset = 0x01040000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(tod),
+		.offset = 0x01050000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(image),
+		.offset = 0x00020000, .size = 0x1000,
+	},
+	{
+		OCP_MEM_RESOURCE(pps_select),
+		.offset = 0x00130000, .size = 0x1000,
+	},
+	{
+		OCP_MEM_RESOURCE(sma_map1),
+		.offset = 0x00140000, .size = 0x1000,
+	},
+	{
+		OCP_MEM_RESOURCE(sma_map2),
+		.offset = 0x00220000, .size = 0x1000,
+	},
+	{
+		OCP_SERIAL_RESOURCE(gnss_port),
+		.offset = 0x00160000 + 0x1000, .irq_vec = 3,
+		.extra = &(struct ptp_ocp_serial_port) {
+			.baud = 9600,
+		},
+	},
+	{
+		OCP_SERIAL_RESOURCE(mac_port),
+		.offset = 0x00180000 + 0x1000, .irq_vec = 5,
+		.extra = &(struct ptp_ocp_serial_port) {
+			.baud = 115200,
+		},
+	},
+	{
+		OCP_MEM_RESOURCE(freq_in[0]),
+		.offset = 0x01200000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(freq_in[1]),
+		.offset = 0x01210000, .size = 0x10000,
+	},
+	{
+		OCP_SPI_RESOURCE(spi_flash),
+		.offset = 0x00310400, .size = 0x10000, .irq_vec = 9,
+		.extra = &(struct ptp_ocp_flash_info) {
+			.name = "spi_altera", .pci_offset = 0,
+			.data_size = sizeof(struct altera_spi_platform_data),
+			.data = &(struct altera_spi_platform_data) {
+				.num_chipselect = 1,
+				.num_devices = 1,
+				.devices = &(struct spi_board_info) {
+					.modalias = "spi-nor",
+				},
+			},
+		},
+	},
+	{
+		OCP_I2C_RESOURCE(i2c_ctrl),
+		.offset = 0x150000, .size = 0x100, .irq_vec = 7,
+		.extra = &(struct ptp_ocp_i2c_info) {
+			.name = "ocores-i2c",
+			.fixed_rate = 50000000,
+			.data_size = sizeof(struct ocores_i2c_platform_data),
+			.data = &(struct ocores_i2c_platform_data) {
+				.clock_khz = 50000,
+				.bus_khz = 100,
+				.reg_io_width = 4, // 32-bit/4-byte
+				.reg_shift = 2, // 32-bit addressing
+				.num_devices = 2,
+				.devices = (struct i2c_board_info[]) {
+					{ I2C_BOARD_INFO("24c02", 0x50) },
+					{ I2C_BOARD_INFO("24mac402", 0x58),
+					 .platform_data = "mac" },
+				},
+			},
+		},
+	},
+	{
+		.setup = ptp_ocp_adva_board_init,
+		.extra = &(struct ptp_ocp_servo_conf) {
+			.servo_offset_p = 0xc000,
+			.servo_offset_i = 0x1000,
+			.servo_drift_p = 0,
+			.servo_drift_i = 0,
+		},
 	},
 	{ }
 };
@@ -839,6 +1023,7 @@ static const struct pci_device_id ptp_ocp_pcidev_id[] = {
 	{ PCI_DEVICE_DATA(FACEBOOK, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(CELESTICA, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(OROLIA, ARTCARD, &ocp_art_resource) },
+	{ PCI_DEVICE_DATA(ADVA, TIMECARD, &ocp_adva_resource) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, ptp_ocp_pcidev_id);
@@ -917,6 +1102,30 @@ static const struct ocp_selector ptp_ocp_art_sma_out[] = {
 	{ }
 };
 
+static const struct ocp_selector ptp_ocp_adva_sma_in[] = {
+	{ .name = "10Mhz",	.value = 0x0000,      .frequency = 10000000},
+	{ .name = "PPS1",	.value = 0x0001,      .frequency = 1 },
+	{ .name = "PPS2",	.value = 0x0002,      .frequency = 1 },
+	{ .name = "TS1",	.value = 0x0004,      .frequency = 0 },
+	{ .name = "TS2",	.value = 0x0008,      .frequency = 0 },
+	{ .name = "FREQ1",	.value = 0x0100,      .frequency = 0 },
+	{ .name = "FREQ2",	.value = 0x0200,      .frequency = 0 },
+	{ .name = "None",	.value = SMA_DISABLE, .frequency = 0 },
+	{ }
+};
+
+static const struct ocp_selector ptp_ocp_adva_sma_out[] = {
+	{ .name = "10Mhz",	.value = 0x0000,  .frequency = 10000000},
+	{ .name = "PHC",	.value = 0x0001,  .frequency = 1 },
+	{ .name = "MAC",	.value = 0x0002,  .frequency = 1 },
+	{ .name = "GNSS1",	.value = 0x0004,  .frequency = 1 },
+	{ .name = "GEN1",	.value = 0x0040 },
+	{ .name = "GEN2",	.value = 0x0080 },
+	{ .name = "GND",	.value = 0x2000 },
+	{ .name = "VCC",	.value = 0x4000 },
+	{ }
+};
+
 struct ocp_sma_op {
 	const struct ocp_selector *tbl[2];
 	void (*init)(struct ptp_ocp *bp);
@@ -1363,7 +1572,7 @@ ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
 }
 
 static int
-ptp_ocp_init_clock(struct ptp_ocp *bp)
+ptp_ocp_init_clock(struct ptp_ocp *bp, struct ptp_ocp_servo_conf *servo_conf)
 {
 	struct timespec64 ts;
 	u32 ctrl;
@@ -1371,12 +1580,11 @@ ptp_ocp_init_clock(struct ptp_ocp *bp)
 	ctrl = OCP_CTRL_ENABLE;
 	iowrite32(ctrl, &bp->reg->ctrl);
 
-	/* NO DRIFT Correction */
-	/* offset_p:i 1/8, offset_i: 1/16, drift_p: 0, drift_i: 0 */
-	iowrite32(0x2000, &bp->reg->servo_offset_p);
-	iowrite32(0x1000, &bp->reg->servo_offset_i);
-	iowrite32(0,	  &bp->reg->servo_drift_p);
-	iowrite32(0,	  &bp->reg->servo_drift_i);
+	/* servo configuration */
+	iowrite32(servo_conf->servo_offset_p, &bp->reg->servo_offset_p);
+	iowrite32(servo_conf->servo_offset_i, &bp->reg->servo_offset_i);
+	iowrite32(servo_conf->servo_drift_p, &bp->reg->servo_drift_p);
+	iowrite32(servo_conf->servo_drift_p, &bp->reg->servo_drift_i);
 
 	/* latch servo values */
 	ctrl |= OCP_CTRL_ADJUST_SERVO;
@@ -2348,6 +2556,14 @@ static const struct ocp_sma_op ocp_fb_sma_op = {
 	.set_output	= ptp_ocp_sma_fb_set_output,
 };
 
+static const struct ocp_sma_op ocp_adva_sma_op = {
+	.tbl		= { ptp_ocp_adva_sma_in, ptp_ocp_adva_sma_out },
+	.init		= ptp_ocp_sma_fb_init,
+	.get		= ptp_ocp_sma_fb_get,
+	.set_inputs	= ptp_ocp_sma_fb_set_inputs,
+	.set_output	= ptp_ocp_sma_fb_set_output,
+};
+
 static int
 ptp_ocp_set_pins(struct ptp_ocp *bp)
 {
@@ -2427,7 +2643,7 @@ ptp_ocp_fb_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 		return err;
 	ptp_ocp_sma_init(bp);
 
-	return ptp_ocp_init_clock(bp);
+	return ptp_ocp_init_clock(bp, r->extra);
 }
 
 static bool
@@ -2589,7 +2805,44 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 	if (err)
 		return err;
 
-	return ptp_ocp_init_clock(bp);
+	return ptp_ocp_init_clock(bp, r->extra);
+}
+
+/* ADVA specific board initializers; last "resource" registered. */
+static int
+ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
+{
+	int err;
+	u32 version;
+
+	bp->flash_start = 0xA00000;
+	bp->eeprom_map = fb_eeprom_map;
+	bp->sma_op = &ocp_adva_sma_op;
+
+	version = ioread32(&bp->image->version);
+	/* if lower 16 bits are empty, this is the fw loader. */
+	if ((version & 0xffff) == 0) {
+		version = version >> 16;
+		bp->fw_loader = true;
+	}
+	bp->fw_tag = 3;
+	bp->fw_version = version & 0xffff;
+	bp->fw_cap = OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
+
+	ptp_ocp_tod_init(bp);
+	ptp_ocp_nmea_out_init(bp);
+	ptp_ocp_signal_init(bp);
+
+	err = ptp_ocp_attr_group_add(bp, adva_timecard_groups);
+	if (err)
+		return err;
+
+	err = ptp_ocp_set_pins(bp);
+	if (err)
+		return err;
+	ptp_ocp_sma_init(bp);
+
+	return ptp_ocp_init_clock(bp, r->extra);
 }
 
 static ssize_t
@@ -3564,6 +3817,37 @@ static const struct ocp_attr_group art_timecard_groups[] = {
 	{ },
 };
 
+static struct attribute *adva_timecard_attrs[] = {
+	&dev_attr_serialnum.attr,
+	&dev_attr_gnss_sync.attr,
+	&dev_attr_clock_source.attr,
+	&dev_attr_available_clock_sources.attr,
+	&dev_attr_sma1.attr,
+	&dev_attr_sma2.attr,
+	&dev_attr_sma3.attr,
+	&dev_attr_sma4.attr,
+	&dev_attr_available_sma_inputs.attr,
+	&dev_attr_available_sma_outputs.attr,
+	&dev_attr_clock_status_drift.attr,
+	&dev_attr_clock_status_offset.attr,
+	&dev_attr_ts_window_adjust.attr,
+	&dev_attr_tod_correction.attr,
+	NULL,
+};
+
+static const struct attribute_group adva_timecard_group = {
+	.attrs = adva_timecard_attrs,
+};
+
+static const struct ocp_attr_group adva_timecard_groups[] = {
+	{ .cap = OCP_CAP_BASIC,	    .group = &adva_timecard_group },
+	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal0_group },
+	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal1_group },
+	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq0_group },
+	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq1_group },
+	{ },
+};
+
 static void
 gpio_input_map(char *buf, struct ptp_ocp *bp, u16 map[][2], u16 bit,
 	       const char *def)
-- 
2.26.3


