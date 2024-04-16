Return-Path: <linux-kernel+bounces-146108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DE78A60CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EA51C20A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3EA12E61;
	Tue, 16 Apr 2024 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Djqp9CbL"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2101.outbound.protection.outlook.com [40.92.107.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964B1B812;
	Tue, 16 Apr 2024 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233601; cv=fail; b=WMw9DG7QcE87kwbr+kQZ3icOJF/N3XZxu5HrTIrzow2Q/SBoZ0P6kk5cmduRsvSjfA6rrpo+7E1ZqayRd0OPf4ePafBtH/B9Xjzd32CRGdQ2PLoyd8ZH1Vn93n2XnxvkvmlULWV5idxAx08qkY1SmmNvAupxxNnjc6CpPey+wJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233601; c=relaxed/simple;
	bh=T/a31Qb4WtJ1yYukKpkIo3R/awxFw5sN6SEY3njPn7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WXGGkGzM468bVg3cBQlm3ZFtBBT7WRH2C6kyS952i7R8CZiTHg+d+1HMYH0zZQxKLfOApbp+8tOdH6xKd1U2rK8ftbqPitDuvUoR918ryPBRN1EwmU+b/nWjr+Tg45CuqjvmenVIB/W39cep1NircVtK1SKRj8AVDWlwG3psU1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Djqp9CbL; arc=fail smtp.client-ip=40.92.107.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyou6DU5yGNewlfwM3dyLLQLIqDmgQGIC+dRfSGziafOCJCEeS/UWFL9Z7P1G2Qa+qhDWwP13BUimavfsUEF7f8tWSUEzEqIQiRi21aTV2UKZ/oIXM3bJfcEDWAlxvhZKOyb2fj8XKpHoxdKN585LzGJpyVg5YV96IFZeO1reFBWCDDBoM58BTGg4KAZKRebRij7SjqTQGKKqPTqHYdjB9AZ6vU5CB810knNeshk6bPi4pWRGgyND2itH4SWqRz8EQ0s+qS3U9FG3DLjiiCIfARqRS7ZQTt1rm2qX9aV43MyNcHmPCWxEUSS556YqEKZ5ZKNwcY4lwZUPq32/zH+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pQXezMRgn+zhmfmeqnHHpMDvnQzpKuIvb6hdfC2rd0=;
 b=a3r77kpAHK27DJ2uE61tBvYK3VnKSbSachTirFBXuZtcFWL+LZXYfW4vKvQapTwQRig+w7NJeph/KNB55xkoHLlfo5qxc8fsC43jvgXi9XzxFiZYnCZqwVhbpzUHjdp7+GemVngXMgzuhKNLMZWFupH3uAT/gGEl0OO3FWlvm8GMtidKnMVYaGf4aK4c4XxS1B8LcyY9ObQL5tihpZhPTQys5ibVIadbWx8Ja+ypLqrIvSa49IGyfxfiwOc370w0EkagsDsjp1KqfkAkMYGKqrcl5/MqvrgCeh9mOtF1kpe4EWelV4cTapw+01SQ3S96guquKXpUKCh/SxNXaMXZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pQXezMRgn+zhmfmeqnHHpMDvnQzpKuIvb6hdfC2rd0=;
 b=Djqp9CbLf7p/gI5FCu3cMJjFYiOLujLkwIQhOn+HVaEgUqqDpCMdycXVYm6A0ZXYoMru7SqLURFntMEguB/52uAUfTIZ6uA7hNM80i4sxh+rChkOXpqYk2EY3FDgjjGw5PUKgTp64H+paSt9q2FOUY9740UGu3OwPGblj1X4cy/CwNeA1OxFfFBm40qYyK7AphAVY2eVtepR4A3rsY4s9y+gMqBHAh5Yw17U5YH6w4UBLpY0dk21GAZdk/6TD0vw2D6ZXYdqNXK47JLExbftzegwIP7rfYATja0kHyMJMWrGCc3LVAh9fZRTBXw5JKslWubD6cVGciMCl/adcAeh9Q==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by TYZPR06MB5323.apcprd06.prod.outlook.com (2603:1096:400:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 02:13:12 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 02:13:12 +0000
From: Allen_Lin <allencl_lin@hotmail.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v3 4/4] HID: Load firmware directly from file to IC
Date: Tue, 16 Apr 2024 10:12:28 +0800
Message-ID:
 <TY0PR06MB5611403AB33B63A8656E75A19E082@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416021228.1092678-1-allencl_lin@hotmail.com>
References: <20240416021228.1092678-1-allencl_lin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [JeGE7dpZ4g6n3WcR2eFJKHVJYDLcGYfe]
X-ClientProxiedBy: PS2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::14) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <20240416021228.1092678-5-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|TYZPR06MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: bca1f807-f09a-40d7-4b94-08dc5dbac457
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hYONiaQ7o9dvVCGMGxXsAgdua4Gmbz8di7BseAlANS1oUtImyoAQ5am5JH1Y2dAev19ZS8vF2iS7t7MYqw6ywBH1L6NHCvOTCxFl6oqa456CswPsr6K4Bw8SZFW5oZ8k/0FPljs2BKCV82sYfBRF5UZ1/SZPcghdJmJtKvifaPPk5XIuagmMbayMw9n2W+ZCGLYPst5DX2v9Bvq5a+HhgMhTQ0jXLo64MgSqDRGLzXRzb+byxguMCWbhGPG8gFtMR2tn9jkPXcjau/vr1+Hbh2CBuCJ5wvnitx/LySEteVx0uRZ5xsSpRKV6xaoj+cf2CKIkCliEoHXa4DMtKqWtRp5RY2z7HTP8OsmyNm+ZODfSgiYBBhjbhKExBi3qBIKQRwXzrUjN5xukQz7H1iDv3aId3aSw+bgUOMOKlQLcf3yvfhrEu8OyfMcJzQcs5PBfV/AFXHVqBtvoU5Moz0RpMzJM9ZJ6Wezox2CKt8oAIKqtvq6Qwy+b5d6qknFnZLnBPn5WtnrBI2EOy+4gzEDEC02Gkuq7ETekLt2qwV7wF80JmU5X9PCDlvD2it2hSsYWIpDSqCQ7RuRiuIVx0E38vQB/tS3JQAVejF4/4LaFxhUAOnuXSToTOD7bYPzTu6LS
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x4VxfRiRawpZXyvnaJyk0FHeP+GkxbAeTHaL7QMhurb+UCXxNREdD2mZzBl2?=
 =?us-ascii?Q?/HzufslCytQrD+SK7T05v62B+EDG3URfVsVzXWBAIl9UsfHqbFYZAclEOWyb?=
 =?us-ascii?Q?a2OegUrCGk6Rro3dOe5Tt760uwyOT/NuwkqQVQnh+2VDsOzEhDCiQZ0gsQky?=
 =?us-ascii?Q?ixpr38P4d61UoSK+v1ZVXGm3dCAnbtNvHgHvRNdkceV5YqZBfAOwLfQaZXbD?=
 =?us-ascii?Q?umoSUJ0SDGpROwSQVYp7Ojx6NHt5HujhR3bsO9w60HGqoo4CbvdvodPEqg39?=
 =?us-ascii?Q?XxRrIZeW/CkWFr6BXa8wz3KgkBzcJHUHSMlhO00OhMVdqfdBef/UpyDtthoB?=
 =?us-ascii?Q?PQCBbuTiIqnYGqqkVYGFrzkRK7L2KW/Al0AGXUmFBdyyRahPwQc6An+L9CIK?=
 =?us-ascii?Q?wHoW/hZT/KOPtTGPc6w5uZJC3ayxZpGbPXFkty9sdxVGlbNj1qcdwOcE2ew5?=
 =?us-ascii?Q?VenrW/YiUrir6cCgf/SLEwxiDtaqbySOfP6EzRjytwOKx7GvvzQkzTH8AHz1?=
 =?us-ascii?Q?prgPa0Qo+vCeo/Lv9HibDGciPYiLc6pce4rQ1ihDt5/t2uJz7Rbsw9nuc/sr?=
 =?us-ascii?Q?wFas0snsYgDNlQBg7dG3DuMmUYFbJpxQFng8/qXijnonSpvEzr+AaIMETvEj?=
 =?us-ascii?Q?66NZ2hZvhrYwOLzLs6ZTNQ4VTXn2HUBIQVKzkmq28ZIpO7wyRfPXM4pQr+zh?=
 =?us-ascii?Q?EDzrX8dVzgnnp15wPNFpWeLqEHajv/dvOkIi8EaJbnafojf65/LYyMCKhpLL?=
 =?us-ascii?Q?RW3TS+JmkbT5JryOuoLhAAq564TceG6HCwDu+68DPl16vPyfrShSMv81c5t8?=
 =?us-ascii?Q?9fAdkPJPtjNt0fm2UL0rnhWueCU7+SpMsSnH/GHBXl8TvpQPHjYm/nly0A7B?=
 =?us-ascii?Q?9djrFkowBYyzl8JfHZKdwGDENSrJQd1d3jjCaX3GSM4sKohkEZNRWJt+zsZ9?=
 =?us-ascii?Q?p0cO0SkzFHHgH2Td+N57yXLnU/9geUFtvARzIVTWj56Uwj4fc5cyQgr1JDSL?=
 =?us-ascii?Q?iI6gWqdT6wCsEtpAyeVztQIFTGH9OVvayre9XwfH2Q2lb4j1NA8bfc6srEYv?=
 =?us-ascii?Q?e7fcMRMpLQpr452e+i84qLwcqVXBl+oCmqkB2Q9LPqAd7XXWDI3oF6LSI9k2?=
 =?us-ascii?Q?wYR7KZkhGaZ5Bhslzhh+lqOTJqlgPM5yJbuhxtOghCjpNAcFixjiFWzXyv22?=
 =?us-ascii?Q?82XxtWNrKkwBlfY7H4FAkbaSNWNd3DTzl1HGiNuxIFiLScCgRPC3IuisNwFd?=
 =?us-ascii?Q?UXv1ZrcpV0nwrwLrUq9t?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bca1f807-f09a-40d7-4b94-08dc5dbac457
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 02:13:12.3869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5323

For HX83102J, often shipped without flash for costdown purpose.
This patch implement the function to load firmware file from
user-space, write into IC sram and make it running.

The procedure as following:
1. Check OF to get FW name specified: himax_parse_dt
2. Load specified FW: i_get_FW, upload process use workqueue
   himax_boot_upgrade
3. Write FW into IC sram: i_update_FW
3-1. FW file contain a mapping table to indicate various section,
     such code, data, version info and HID info
3-2. Call update process himax_mcu_firmware_update_0f, which stop
     the internal MCU: i. system reset. ii. hx83102j_sense_off
3-3. Parsing FW and upload file: himax_zf_part_info. info[0] contain
     the code section and will upload to ISRAM. Other info[x] are
     data sections will be combined and upload to DSRAM separately.
     After upload FW, driver will use crc to check integrity:
     himax_sram_write_crc_check for code(HW CRC result must be 0),
     himax_mcu_calculate_crc_with_ap for pre-calculate data CRC[1],
     Upload data section by himax_mcu_register_write,
     himax_mcu_check_crc use HW calculate CRC and compared with [1]
4. Disable HW reload FW from flash function before MCU start running:
   himax_disable_fw_reload
5. Start running the FW: himax_mcu_power_on_init
5-1. Setting varies FW settings before FW start running
5-2. Start FW: hx83102j_sense_on
5-3. Wait until FW initial process complete: Read 0x72C0 from IC
6. Read HID info from FW
7. Read TP properties from IC: himax_mcu_tp_info_check
8. Read FW information fromIC: himax_mcu_read_FW_ver
9. Release FW, IC initial complete

The resume procedure do part of boot process, it also need to reload
FW from user-space into IC sram: himax_0f_op_file_dirly
1. Request FW
2. Upload FW: himax_mcu_firmware_update_0f
3. Disable HW reload FW from flash function: himax_disable_fw_reload
4. Start running the FW: himax_mcu_power_on_init

Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
---
 drivers/hid/hid-himax.c | 1501 +++++++++++++++++++++++++++++++++------
 drivers/hid/hid-himax.h |  166 ++++-
 2 files changed, 1467 insertions(+), 200 deletions(-)

diff --git a/drivers/hid/hid-himax.c b/drivers/hid/hid-himax.c
index 7b0ee48acfae..50acb87bee35 100644
--- a/drivers/hid/hid-himax.c
+++ b/drivers/hid/hid-himax.c
@@ -532,6 +532,92 @@ static void himax_mcu_ic_reset(struct himax_ts_data *ts, bool int_off)
 		himax_int_enable(ts, true);
 }
 
+/**
+ * hx83102j_reload_to_active() - Reload to active mode
+ * @ts: Himax touch screen data
+ *
+ * This function is used to write a flag to the IC register to make MCU restart without
+ * reload the firmware.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int hx83102j_reload_to_active(struct himax_ts_data *ts)
+{
+	int ret;
+	u32 retry_cnt;
+	const u32 addr = HIMAX_REG_ADDR_RELOAD_TO_ACTIVE;
+	const u32 reload_to_active_cmd = 0xec;
+	const u32 reload_to_active_done = 0x01ec;
+	const u32 retry_limit = 5;
+	union himax_dword_data data;
+
+	for (retry_cnt = 0; retry_cnt < retry_limit; retry_cnt++) {
+		data.dword = cpu_to_le32(reload_to_active_cmd);
+		ret = himax_mcu_register_write(ts, addr, data.byte, 4);
+		if (ret < 0)
+			return ret;
+		usleep_range(1000, 1100);
+		ret = himax_mcu_register_read(ts, addr, data.byte, 4);
+		if (ret < 0)
+			return ret;
+		data.dword = le32_to_cpu(data.dword);
+		if (data.word[0] == reload_to_active_done)
+			break;
+	}
+
+	if (data.word[0] != reload_to_active_done) {
+		dev_err(ts->dev, "%s: Reload to active failed!\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * hx83102j_en_hw_crc() - Enable/Disable HW CRC
+ * @ts: Himax touch screen data
+ * @en: true for enable, false for disable
+ *
+ * This function is used to enable or disable the HW CRC. The HW CRC
+ * is used to protect the SRAM data.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int hx83102j_en_hw_crc(struct himax_ts_data *ts, bool en)
+{
+	int ret;
+	u32 retry_cnt;
+	const u32 addr = HIMAX_HX83102J_REG_ADDR_HW_CRC;
+	const u32 retry_limit = 5;
+	union himax_dword_data data, wrt_data;
+
+	if (en)
+		data.dword = cpu_to_le32(HIMAX_HX83102J_REG_DATA_HW_CRC);
+	else
+		data.dword = cpu_to_le32(HIMAX_HX83102J_REG_DATA_HW_CRC_DISABLE);
+
+	wrt_data.dword = data.dword;
+	for (retry_cnt = 0; retry_cnt < retry_limit; retry_cnt++) {
+		ret = himax_mcu_register_write(ts, addr, data.byte, 4);
+		if (ret < 0)
+			return ret;
+		usleep_range(1000, 1100);
+		ret = himax_mcu_register_read(ts, addr, data.byte, 4);
+		if (ret < 0)
+			return ret;
+
+		if (data.word[0] == wrt_data.word[0])
+			break;
+	}
+
+	if (data.word[0] != wrt_data.word[0]) {
+		dev_err(ts->dev, "%s: ECC fail!\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * hx83102j_sense_off() - Stop MCU and enter safe mode
  * @ts: Himax touch screen data
@@ -641,6 +727,56 @@ static int hx83102j_sense_off(struct himax_ts_data *ts, bool check_en)
 	return -EIO;
 }
 
+/**
+ * hx83102j_sense_on() - Sense on the touch chip
+ * @ts: Himax touch screen data
+ * @sw_reset: true for software reset, false for hardware reset
+ *
+ * This function is used to sense on the touch chip, which means to start running the
+ * FW. The process begin with wakeup the IC bus interface, then write a flag to the IC
+ * register to make MCU restart running the FW. When sw_reset is true, the function will
+ * send a command to the IC to leave safe mode. Otherwise, the function will call
+ * himax_mcu_ic_reset() to reset the touch chip by hardware pin.
+ * Then enable the HW CRC to protect sram data, and reload to active to make the MCU
+ * start running without reload the firmware.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int hx83102j_sense_on(struct himax_ts_data *ts, bool sw_reset)
+{
+	int ret;
+	const union himax_dword_data re_init = {
+		.dword = cpu_to_le32(HIMAX_REG_DATA_FW_RE_INIT)
+	};
+	union himax_dword_data data;
+
+	dev_info(ts->dev, "%s: software reset %s\n", __func__, sw_reset ? "true" : "false");
+	ret = himax_mcu_interface_on(ts);
+	if (ret < 0)
+		return ret;
+
+	ret = himax_mcu_register_write(ts, HIMAX_REG_ADDR_CTRL_FW, re_init.byte, 4);
+	if (ret < 0)
+		return ret;
+	usleep_range(10000, 11000);
+	if (!sw_reset) {
+		himax_mcu_ic_reset(ts, false);
+	} else {
+		data.word[0] = cpu_to_le16(HIMAX_AHB_CMD_LEAVE_SAFE_MODE);
+		ret = himax_write(ts, HIMAX_AHB_ADDR_PSW_LB, NULL, data.byte, 2);
+		if (ret < 0)
+			return ret;
+	}
+	ret = hx83102j_en_hw_crc(ts, true);
+	if (ret < 0)
+		return ret;
+	ret = hx83102j_reload_to_active(ts);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 /**
  * hx83102j_chip_detect() - Check if the touch chip is HX83102J
  * @ts: Himax touch screen data
@@ -783,166 +919,980 @@ static int hx83102j_read_event_stack(struct himax_ts_data *ts, u8 *buf, u32 leng
 	int ret;
 	const u32 max_trunk_sz = ts->spi_xfer_max_sz - HIMAX_BUS_R_HLEN;
 
-	for (i = 0; i < length; i += max_trunk_sz) {
-		ret = himax_read(ts, HIMAX_AHB_ADDR_EVENT_STACK, buf + i,
-				 min(length - i, max_trunk_sz));
+	for (i = 0; i < length; i += max_trunk_sz) {
+		ret = himax_read(ts, HIMAX_AHB_ADDR_EVENT_STACK, buf + i,
+				 min(length - i, max_trunk_sz));
+		if (ret) {
+			dev_err(ts->dev, "%s: read event stack error!\n", __func__);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * hx83102j_chip_init_data() - Initialize the touch chip data
+ * @ts: Himax touch screen data
+ *
+ * This function is used to initialize hx83102j touch specific data in himax_ts_data.
+ * The chip_max_dsram_size is the maximum size of the DSRAM of hx83102j.
+ *
+ * Return: None
+ */
+static void hx83102j_chip_init_data(struct himax_ts_data *ts)
+{
+	ts->chip_max_dsram_size = HIMAX_HX83102J_DSRAM_SZ;
+}
+
+/**
+ * himax_touch_get() - Get touch data from touch chip
+ * @ts: Himax touch screen data
+ * @buf: Buffer to store the data
+ *
+ * This function is a wrapper to call hx83102j_read_event_stack() to read the touch
+ * data from the touch chip. The touch_data_sz is the size of the touch data to read,
+ * which is calculated by hid report descriptor provided by the firmware.
+ *
+ * Return: HIMAX_TS_SUCCESS on success, negative error code on failure. We categorize
+ * the error code into HIMAX_TS_GET_DATA_FAIL when the read fails, and HIMAX_TS_SUCCESS
+ * when the read is successful. The reason is that the may need special handling when
+ * the read fails.
+ */
+static int himax_touch_get(struct himax_ts_data *ts, u8 *buf)
+{
+	if (hx83102j_read_event_stack(ts, buf, ts->touch_data_sz)) {
+		dev_err(ts->dev, "can't read data from chip!");
+		return HIMAX_TS_GET_DATA_FAIL;
+	}
+
+	return HIMAX_TS_SUCCESS;
+}
+
+/**
+ * himax_mcu_assign_sorting_mode() - Write sorting mode to dsram and verify
+ * @ts: Himax touch screen data
+ * @tmp_data_in: password to write
+ *
+ * This function is used to write the sorting mode password to dsram and verify the
+ * password is written correctly. The sorting mode password is used as a flag to
+ * FW to let it know which mode the touch chip is working on.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_mcu_assign_sorting_mode(struct himax_ts_data *ts, u8 *tmp_data_in)
+{
+	int ret;
+	u8 rdata[4];
+	u32 retry_cnt;
+	const u32 retry_limit = 3;
+
+	for (retry_cnt = 0; retry_cnt < retry_limit; retry_cnt++) {
+		ret = himax_mcu_register_write(ts, HIMAX_DSRAM_ADDR_SORTING_MODE_EN,
+					       tmp_data_in, HIMAX_REG_SZ);
+		if (ret < 0) {
+			dev_err(ts->dev, "%s: write sorting mode fail\n", __func__);
+			return ret;
+		}
+		usleep_range(1000, 1100);
+		ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_SORTING_MODE_EN,
+					      rdata, HIMAX_REG_SZ);
+		if (ret < 0) {
+			dev_err(ts->dev, "%s: read sorting mode fail\n", __func__);
+			return ret;
+		}
+
+		if (!memcmp(tmp_data_in, rdata, HIMAX_REG_SZ))
+			return 0;
+	}
+	dev_err(ts->dev, "%s: fail to write sorting mode\n", __func__);
+
+	return -EINVAL;
+}
+
+/**
+ * himax_mcu_read_FW_status() - Read FW status from touch chip
+ * @ts: Himax touch screen data
+ *
+ * This function is used to read the FW status from the touch chip. The FW status is
+ * values from dsram and register from TPIC. Which shows the FW vital working status
+ * for developer debug.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_mcu_read_FW_status(struct himax_ts_data *ts)
+{
+	int i;
+	int ret;
+	size_t len;
+	u8 data[4];
+	const char * const reg_name[] = {
+		"DBG_MSG",
+		"FW_STATUS",
+		"DD_STATUS",
+		"RESET_FLAG"
+	};
+	const u32 dbg_reg_array[] = {
+		HIMAX_DSRAM_ADDR_DBG_MSG,
+		HIMAX_REG_ADDR_FW_STATUS,
+		HIMAX_REG_ADDR_DD_STATUS,
+		HIMAX_REG_ADDR_RESET_FLAG
+	};
+
+	len = ARRAY_SIZE(dbg_reg_array);
+
+	for (i = 0; i < len; i++) {
+		ret = himax_mcu_register_read(ts, dbg_reg_array[i], data, HIMAX_REG_SZ);
+		if (ret < 0) {
+			dev_err(ts->dev, "%s: read FW status fail\n", __func__);
+			return ret;
+		}
+
+		dev_info(ts->dev, "%s: %10s(0x%08X) = 0x%02X, 0x%02X, 0x%02X, 0x%02X\n",
+		  __func__, reg_name[i], dbg_reg_array[i],
+			 data[0], data[1], data[2], data[3]);
+	}
+
+	return 0;
+}
+
+/**
+ * himax_mcu_power_on_init() - Power on initialization
+ * @ts: Himax touch screen data
+ *
+ * This function is used to do the power on initialization after firmware has been
+ * loaded to sram. The process initialize varies IC register and dsram to make sure
+ * FW start running correctly. When all set, sense on the touch chip to make the FW
+ * start running and wait for the FW reload done password.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_mcu_power_on_init(struct himax_ts_data *ts)
+{
+	int ret;
+	u32 retry_cnt;
+	const u32 retry_limit = 30;
+	union himax_dword_data data;
+
+	/* RawOut select initial */
+	data.dword = cpu_to_le32(HIMAX_DATA_CLEAR);
+	ret = himax_mcu_register_write(ts, HIMAX_HX83102J_DSRAM_ADDR_RAW_OUT_SEL, data.byte, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: set RawOut select fail\n", __func__);
+		return ret;
+	}
+	/* Initial sorting mode password to normal mode */
+	ret = himax_mcu_assign_sorting_mode(ts, data.byte);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: assign sorting mode fail\n", __func__);
+		return ret;
+	}
+	/* N frame initial */
+	/* reset N frame back to default value 1 for normal mode */
+	data.dword = cpu_to_le32(1);
+	ret = himax_mcu_register_write(ts, HIMAX_DSRAM_ADDR_SET_NFRAME, data.byte, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: set N frame fail\n", __func__);
+		return ret;
+	}
+	/* Initial FW reload status */
+	data.dword = cpu_to_le32(HIMAX_DATA_CLEAR);
+	ret = himax_mcu_register_write(ts, HIMAX_DSRAM_ADDR_2ND_FLASH_RELOAD, data.byte, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: initial FW reload status fail\n", __func__);
+		return ret;
+	}
+
+	ret = hx83102j_sense_on(ts, false);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: sense on fail\n", __func__);
+		return ret;
+	}
+
+	dev_info(ts->dev, "%s: waiting for FW reload data\n", __func__);
+	for (retry_cnt = 0; retry_cnt < retry_limit; retry_cnt++) {
+		ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_2ND_FLASH_RELOAD, data.byte, 4);
+		if (ret < 0) {
+			dev_err(ts->dev, "%s: read FW reload status fail\n", __func__);
+			return ret;
+		}
+
+		/* use all 4 bytes to compare */
+		if (le32_to_cpu(data.dword) == HIMAX_DSRAM_DATA_FW_RELOAD_DONE) {
+			dev_info(ts->dev, "%s: FW reload done\n", __func__);
+			break;
+		}
+		dev_info(ts->dev, "%s: wait FW reload %u times\n", __func__, retry_cnt + 1);
+		ret = himax_mcu_read_FW_status(ts);
+		if (ret < 0)
+			dev_err(ts->dev, "%s: read FW status fail\n", __func__);
+
+		usleep_range(10000, 11000);
+	}
+
+	if (retry_cnt == retry_limit) {
+		dev_err(ts->dev, "%s: FW reload fail!\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * himax_mcu_calculate_crc() - Calculate CRC-32 of given data
+ * @data: Data to calculate CRC
+ * @len: Length of data
+ *
+ * This function is used to calculate the CRC-32 of the given data. The function
+ * calculate the CRC-32 value by the polynomial 0x82f63b78.
+ *
+ * Return: CRC-32 value
+ */
+static u32 himax_mcu_calculate_crc(const u8 *data, int len)
+{
+	int i, j, length;
+	u32 crc = GENMASK(31, 0);
+	u32 current_data;
+	u32 tmp;
+	const u32 mask = GENMASK(30, 0);
+
+	length = len / 4;
+
+	for (i = 0; i < length; i++) {
+		current_data = data[i * 4];
+
+		for (j = 1; j < 4; j++) {
+			tmp = data[i * 4 + j];
+			current_data += (tmp) << (8 * j);
+		}
+		crc = current_data ^ crc;
+		for (j = 0; j < 32; j++) {
+			if ((crc % 2) != 0)
+				crc = ((crc >> 1) & mask) ^ CRC32C_POLY_LE;
+			else
+				crc = (((crc >> 1) & mask));
+		}
+	}
+
+	return crc;
+}
+
+/**
+ * himax_mcu_check_crc() - Let TPIC check CRC itself
+ * @ts: Himax touch screen data
+ * @start_addr: Start address of the data in sram to check
+ * @reload_length: Length of the data to check
+ * @crc_result: CRC result for return
+ *
+ * This function is used to let TPIC check the CRC of the given data in sram. The
+ * function write the start address and length of the data to the TPIC, and wait for
+ * the TPIC to finish the CRC check. When the CRC check is done, the function read
+ * the CRC result from the TPIC.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_mcu_check_crc(struct himax_ts_data *ts, u32 start_addr,
+			       int reload_length, u32 *crc_result)
+{
+	int ret;
+	int length = reload_length / HIMAX_REG_SZ;
+	u32 retry_cnt;
+	const u32 retry_limit = 100;
+	union himax_dword_data data, addr;
+
+	addr.dword = cpu_to_le32(start_addr);
+	ret = himax_mcu_register_write(ts, HIMAX_REG_ADDR_RELOAD_ADDR_FROM, addr.byte, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: write reload start address fail\n", __func__);
+		return ret;
+	}
+
+	data.word[1] = cpu_to_le16(HIMAX_REG_DATA_RELOAD_PASSWORD);
+	data.word[0] = cpu_to_le16(length);
+	ret = himax_mcu_register_write(ts, HIMAX_REG_ADDR_RELOAD_ADDR_CMD_BEAT, data.byte, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: write reload length and password fail!\n", __func__);
+		return ret;
+	}
+
+	ret = himax_mcu_register_read(ts, HIMAX_REG_ADDR_RELOAD_ADDR_CMD_BEAT, data.byte, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: read reload length and password fail!\n", __func__);
+		return ret;
+	}
+
+	if (le16_to_cpu(data.word[0]) != length) {
+		dev_err(ts->dev, "%s: length verify failed!\n", __func__);
+		return -EINVAL;
+	}
+
+	for (retry_cnt = 0; retry_cnt < retry_limit; retry_cnt++) {
+		ret = himax_mcu_register_read(ts, HIMAX_REG_ADDR_RELOAD_STATUS, data.byte, 4);
+		if (ret < 0) {
+			dev_err(ts->dev, "%s: read reload status fail!\n", __func__);
+			return ret;
+		}
+
+		data.dword = le32_to_cpu(data.dword);
+		if ((data.byte[0] & HIMAX_REG_DATA_RELOAD_DONE) != HIMAX_REG_DATA_RELOAD_DONE) {
+			ret = himax_mcu_register_read(ts, HIMAX_REG_ADDR_RELOAD_CRC32_RESULT,
+						      data.byte, HIMAX_REG_SZ);
+			if (ret < 0) {
+				dev_err(ts->dev, "%s: read crc32 result fail!\n", __func__);
+				return ret;
+			}
+			*crc_result = le32_to_cpu(data.dword);
+			return 0;
+		}
+
+		dev_info(ts->dev, "%s: Waiting for HW ready!\n", __func__);
+		usleep_range(1000, 1100);
+	}
+
+	if (retry_cnt == retry_limit) {
+		ret = himax_mcu_read_FW_status(ts);
+		if (ret < 0)
+			dev_err(ts->dev, "%s: read FW status fail\n", __func__);
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * himax_mcu_read_FW_ver() - Read varies version from touch chip
+ * @ts: Himax touch screen data
+ *
+ * This function is used to read the firmware version, config version, touch config
+ * version, display config version, customer ID, customer info, and project info from
+ * the touch chip. The function will call himax_mcu_register_read() to read the data
+ * from the TPIC, and store the data to the IC data in himax_ts_data.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_mcu_read_FW_ver(struct himax_ts_data *ts)
+{
+	int ret;
+	u8 data[HIMAX_TP_INFO_STR_LEN];
+
+	ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_FW_VER, data, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: read FW version fail\n", __func__);
+		return ret;
+	}
+	ts->ic_data.vendor_panel_ver =  data[0];
+	ts->ic_data.vendor_fw_ver = data[1] << 8 | data[2];
+	dev_info(ts->dev, "%s: PANEL_VER: %X\n", __func__, ts->ic_data.vendor_panel_ver);
+	dev_info(ts->dev, "%s: FW_VER: %X\n", __func__, ts->ic_data.vendor_fw_ver);
+
+	ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_CFG, data, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: read CFG version fail\n", __func__);
+		return ret;
+	}
+	ts->ic_data.vendor_config_ver = data[2] << 8 | data[3];
+	ts->ic_data.vendor_touch_cfg_ver = data[2];
+	dev_info(ts->dev, "%s: TOUCH_VER: %X\n", __func__, ts->ic_data.vendor_touch_cfg_ver);
+	ts->ic_data.vendor_display_cfg_ver = data[3];
+	dev_info(ts->dev, "%s: DISPLAY_VER: %X\n", __func__, ts->ic_data.vendor_display_cfg_ver);
+
+	ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_VENDOR, data, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: read customer ID fail\n", __func__);
+		return ret;
+	}
+	ts->ic_data.vendor_cid_maj_ver = data[2];
+	ts->ic_data.vendor_cid_min_ver = data[3];
+	dev_info(ts->dev, "%s: CID_VER: %X\n", __func__, (ts->ic_data.vendor_cid_maj_ver << 8
+		 | ts->ic_data.vendor_cid_min_ver));
+
+	ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_CUS_INFO, data, HIMAX_TP_INFO_STR_LEN);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: read customer info fail\n", __func__);
+		return ret;
+	}
+	memcpy(ts->ic_data.vendor_cus_info, data, HIMAX_TP_INFO_STR_LEN);
+	dev_info(ts->dev, "%s: Cusomer ID : %s\n", __func__, ts->ic_data.vendor_cus_info);
+
+	ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_PROJ_INFO, data, HIMAX_TP_INFO_STR_LEN);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: read project info fail\n", __func__);
+		return ret;
+	}
+	memcpy(ts->ic_data.vendor_proj_info, data, HIMAX_TP_INFO_STR_LEN);
+	dev_info(ts->dev, "%s: Project ID : %s\n", __func__, ts->ic_data.vendor_proj_info);
+
+	return 0;
+}
+
+/**
+ * himax_bin_desc_data_get() - Parse descriptor data from firmware token
+ * @ts: Himax touch screen data
+ * @addr: Address of the data in firmware image
+ * @descript_buf: token for parsing
+ *
+ * This function is used to parse the descriptor data from the firmware token. The
+ * descriptors are mappings of information in the firmware image. The function will
+ * check checksum of each token first, and then parse the token to get the related
+ * data. The data includes CID version, FW version, CFG version, touch config table,
+ * HID table, HID descriptor, and HID read descriptor.
+ *
+ * Return: true on success, false on failure
+ */
+static bool himax_bin_desc_data_get(struct himax_ts_data *ts, u32 addr, u8 *descript_buf)
+{
+	u16 chk_end;
+	u16 chk_sum;
+	u32 hid_table_addr;
+	u32 i, j;
+	u32 image_offset;
+	u32 map_code;
+	const u32 data_sz = 16;
+	const u32 report_desc_offset = 24;
+	union {
+		u8 *buf;
+		u32 *word;
+	} map_data;
+
+	/* looking for mapping in page, each mapping is 16 bytes */
+	for (i = 0; i < HIMAX_HX83102J_PAGE_SIZE; i = i + data_sz) {
+		chk_end = 0;
+		chk_sum = 0;
+		for (j = i; j < (i + data_sz); j++) {
+			chk_end |= descript_buf[j];
+			chk_sum += descript_buf[j];
+		}
+		if (!chk_end) { /* 1. Check all zero */
+			return false;
+		} else if (chk_sum % 0x100) { /* 2. Check sum */
+			dev_warn(ts->dev, "%s: chk sum failed in %X\n", __func__, i + addr);
+		} else { /* 3. get data */
+			map_data.buf = &descript_buf[i];
+			map_code = le32_to_cpup(map_data.word);
+			map_data.buf = &descript_buf[i + 4];
+			image_offset = le32_to_cpup(map_data.word);
+			/* 4. load info from FW image by specified mapping offset */
+			switch (map_code) {
+			/* Config ID */
+			case HIMAX_FW_CID:
+				ts->fw_info_table.addr_cid_ver_major = image_offset;
+				ts->fw_info_table.addr_cid_ver_minor = image_offset + 1;
+				break;
+			/* FW version */
+			case HIMAX_FW_VER:
+				ts->fw_info_table.addr_fw_ver_major = image_offset;
+				ts->fw_info_table.addr_fw_ver_minor = image_offset + 1;
+				break;
+			/* Config version */
+			case HIMAX_CFG_VER:
+				ts->fw_info_table.addr_cfg_ver_major = image_offset;
+				ts->fw_info_table.addr_cfg_ver_minor = image_offset + 1;
+				break;
+			/* Touch config table */
+			case HIMAX_TP_CONFIG_TABLE:
+				ts->fw_info_table.addr_cfg_table = image_offset;
+				break;
+			/* HID table */
+			case HIMAX_HID_TABLE:
+				ts->fw_info_table.addr_hid_table = image_offset;
+				hid_table_addr = image_offset;
+				ts->fw_info_table.addr_hid_desc = hid_table_addr;
+				ts->fw_info_table.addr_hid_rd_desc =
+					hid_table_addr + report_desc_offset;
+				break;
+			}
+		}
+	}
+
+	return true;
+}
+
+/**
+ * himax_mcu_bin_desc_get() - Check and get the bin description from the data
+ * @fw: Firmware data
+ * @ts: Himax touch screen data
+ * @max_sz: Maximum size to check
+ *
+ * This function is used to check and get the bin description from the firmware data.
+ * It will check the given data to see if it match the bin description format, and
+ * call himax_bin_desc_data_get() to get the related data.
+ *
+ * Return: true on mapping_count > 0, false on otherwise
+ */
+static bool himax_mcu_bin_desc_get(unsigned char *fw, struct himax_ts_data *ts, u32 max_sz)
+{
+	bool keep_on_flag;
+	u32 addr;
+	u32 mapping_count;
+	unsigned char *fw_buf;
+	const u8 header_id = 0x87;
+	const u8 header_id_loc = 0x0e;
+	const u8 header_sz = 8;
+	const u8 header[8] = {
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+	};
+
+	/* Check bin is with description table or not */
+	if (!(memcmp(fw, header, header_sz) == 0 && fw[header_id_loc] == header_id)) {
+		dev_err(ts->dev, "%s: No description table\n", __func__);
+		return false;
+	}
+
+	for (addr = 0, mapping_count = 0; addr < max_sz; addr += HIMAX_HX83102J_PAGE_SIZE) {
+		fw_buf = &fw[addr];
+		/* Get related data */
+		keep_on_flag = himax_bin_desc_data_get(ts, addr, fw_buf);
+		if (keep_on_flag)
+			mapping_count++;
+		else
+			break;
+	}
+
+	return mapping_count > 0;
+}
+
+/**
+ * himax_mcu_tp_info_check() - Read touch information from touch chip
+ * @ts: Himax touch screen data
+ *
+ * This function is used to read the touch information from the touch chip. The
+ * information includes the touch resolution, touch point number, interrupt type,
+ * button number, stylus function, stylus version, and stylus ratio. These information
+ * is filled by FW after the FW initialized, so it must be called after FW finish
+ * loading.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_mcu_tp_info_check(struct himax_ts_data *ts)
+{
+	int ret;
+	char data[HIMAX_REG_SZ];
+	u8 stylus_ratio;
+	u32 button_num;
+	u32 max_pt;
+	u32 rx_num;
+	u32 tx_num;
+	u32 x_res;
+	u32 y_res;
+	const u32 button_num_mask = 0x03;
+	const u32 interrupt_type_mask = 0x01;
+	const u32 interrupt_type_edge = 0x01;
+	bool int_is_edge;
+	bool stylus_func;
+	bool stylus_id_v2;
+
+	ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_RXNUM_TXNUM, data, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: read rx/tx num fail\n", __func__);
+		return ret;
+	}
+	rx_num = data[2];
+	tx_num = data[3];
+
+	ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_MAXPT_XYRVS, data, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: read max touch point fail\n", __func__);
+		return ret;
+	}
+	max_pt = data[0];
+
+	ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_X_Y_RES, data, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: read x/y resolution fail\n", __func__);
+		return ret;
+	}
+	y_res = be16_to_cpup((u16 *)&data[0]);
+	x_res = be16_to_cpup((u16 *)&data[2]);
+
+	ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_INT_IS_EDGE, data, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: read interrupt type fail\n", __func__);
+		return ret;
+	}
+	if ((data[1] & interrupt_type_mask) == interrupt_type_edge)
+		int_is_edge = true;
+	else
+		int_is_edge = false;
+
+	ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_MKEY, data, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: read button number fail\n", __func__);
+		return ret;
+	}
+	button_num = data[0] & button_num_mask;
+
+	ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_STYLUS_FUNCTION, data, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: read stylus function fail\n", __func__);
+		return ret;
+	}
+	stylus_func = data[3] ? true : false;
+
+	if (stylus_func) {
+		ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_STYLUS_VERSION, data, 4);
+		if (ret < 0) {
+			dev_err(ts->dev, "%s: read stylus version fail\n", __func__);
+			return ret;
+		}
+		/* dsram_addr_stylus_version + 2 : 0=off 1=on */
+		stylus_id_v2 = data[2] ? true : false;
+		/* dsram_addr_stylus_version + 3 : 0=ratio_1 10=ratio_10 */
+		stylus_ratio = data[3];
+	}
+
+	ts->ic_data.button_num = button_num;
+	ts->ic_data.stylus_function = stylus_func;
+	ts->ic_data.rx_num = rx_num;
+	ts->ic_data.tx_num = tx_num;
+	ts->ic_data.x_res = x_res;
+	ts->ic_data.y_res = y_res;
+	ts->ic_data.max_point = max_pt;
+	ts->ic_data.interrupt_is_edge = int_is_edge;
+	if (stylus_func) {
+		ts->ic_data.stylus_v2 = stylus_id_v2;
+		ts->ic_data.stylus_ratio = stylus_ratio;
+	} else {
+		ts->ic_data.stylus_v2 = false;
+		ts->ic_data.stylus_ratio = 0;
+	}
+
+	dev_info(ts->dev, "%s: rx_num = %u, tx_num = %u\n", __func__,
+	  ts->ic_data.rx_num, ts->ic_data.tx_num);
+	dev_info(ts->dev, "%s: max_point = %u\n", __func__, ts->ic_data.max_point);
+	dev_info(ts->dev, "%s: interrupt_is_edge = %s, stylus_function = %s\n", __func__,
+	  ts->ic_data.interrupt_is_edge ? "true" : "false",
+		 ts->ic_data.stylus_function ? "true" : "false");
+	dev_info(ts->dev, "%s: stylus_v2 = %s, stylus_ratio = %u\n", __func__,
+	  ts->ic_data.stylus_v2 ? "true" : "false", ts->ic_data.stylus_ratio);
+	dev_info(ts->dev, "%s: TOUCH INFO updated\n", __func__);
+
+	return 0;
+}
+
+/**
+ * himax_disable_fw_reload() - Disable the FW reload data from flash
+ * @ts: Himax touch screen data
+ *
+ * This function is used to tell FW not to reload data from flash. It needs to be
+ * set before FW start running.
+ *
+ * return: 0 on success, negative error code on failure
+ */
+static int himax_disable_fw_reload(struct himax_ts_data *ts)
+{
+	union himax_dword_data data = {
+		/*
+		 * HIMAX_DSRAM_ADDR_FLASH_RELOAD: 0x10007f00
+		 * 0x10007f00 <= 0x9aa9, let FW know there's no flash
+		 *	      <= 0x5aa5, there has flash, but not reload
+		 *	      <= 0x0000, there has flash, and reload
+		 */
+		.dword = cpu_to_le32(HIMAX_DSRAM_DATA_DISABLE_FLASH_RELOAD)
+	};
+
+	/* Disable Flash Reload */
+	return himax_mcu_register_write(ts, HIMAX_DSRAM_ADDR_FLASH_RELOAD, data.byte, 4);
+}
+
+/**
+ * himax_sram_write_crc_check() - Write the data to SRAM and check the CRC by hardware
+ * @ts: Himax touch screen data
+ * @addr: Address to write to
+ * @data: Data to write
+ * @len: Length of data
+ *
+ * This function is use to write FW code/data to SRAM and check the CRC by hardware to make
+ * sure the written data is correct. The FW code is designed to be CRC result 0, so if the
+ * CRC result is not 0, it means the written data is not correct.
+ *
+ * return: 0 on success, negative error code on failure
+ */
+static int himax_sram_write_crc_check(struct himax_ts_data *ts, u32 addr, const u8 *data, u32 len)
+{
+	int ret;
+	u32 crc;
+	u32 retry_cnt;
+	const u32 retry_limit = 3;
+
+	for (retry_cnt = 0; retry_cnt < retry_limit; retry_cnt++) {
+		dev_info(ts->dev, "%s: Write FW to SRAM - total write size = %u\n", __func__, len);
+		ret = himax_mcu_register_write(ts, addr, data, len);
+		if (ret) {
+			dev_err(ts->dev, "%s: write FW to SRAM fail\n", __func__);
+			return ret;
+		}
+		ret = himax_mcu_check_crc(ts, addr, len, &crc);
+		if (ret) {
+			dev_err(ts->dev, "%s: check CRC fail\n", __func__);
+			return ret;
+		}
+		dev_info(ts->dev, "%s: HW CRC %s in %u time\n", __func__,
+		  crc == 0 ? "OK" : "Fail", retry_cnt);
+
+		if (crc == 0)
+			break;
+	}
+
+	if (crc != 0) {
+		dev_err(ts->dev, "%s: HW CRC fail\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * himax_zf_part_info() - Get and write the partition from the firmware to SRAM
+ * @fw: Firmware data
+ * @ts: Himax touch screen data
+ *
+ * This function is used to get the partition information from the firmware and write
+ * the partition to SRAM. The partition information includes the DSRAM address, the
+ * firmware offset, and the write size. The function will get the partition information
+ * into a table, and then write the partition to SRAM according to the table. After
+ * writing the partition to SRAM, the function will check the CRC by hardware to make
+ * sure the written data is correct.
+ *
+ * return: 0 on success, negative error code on failure
+ */
+static int himax_zf_part_info(const struct firmware *fw, struct himax_ts_data *ts)
+{
+	int i;
+	int i_max = -1;
+	int i_min = -1;
+	int pnum;
+	int ret;
+	u8 buf[HIMAX_ZF_PARTITION_DESC_SZ];
+	u32 cfg_crc_sw;
+	u32 cfg_crc_hw;
+	u32 cfg_sz;
+	u32 dsram_base = 0xffffffff;
+	u32 dsram_max = 0;
+	u32 retry_cnt = 0;
+	u32 sram_min;
+	const u32 retry_limit = 3;
+	const u32 table_addr = ts->fw_info_table.addr_cfg_table;
+	struct himax_zf_info *info;
+
+	/* 1. initial check */
+	ret = hx83102j_en_hw_crc(ts, true);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: Failed to enable HW CRC\n", __func__);
+		return ret;
+	}
+	pnum = fw->data[table_addr + HIMAX_ZF_PARTITION_AMOUNT_OFFSET];
+	if (pnum < 2) {
+		dev_err(ts->dev, "%s: partition number is not correct\n", __func__);
+		return -EINVAL;
+	}
+
+	info = kcalloc(pnum, sizeof(struct himax_zf_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	memset(info, 0, pnum * sizeof(struct himax_zf_info));
+
+	/*
+	 * 2. record partition information:
+	 * partition 0: FW main code
+	 */
+	memcpy(buf, &fw->data[table_addr], HIMAX_ZF_PARTITION_DESC_SZ);
+	memcpy(info[0].sram_addr, buf, 4);
+	info[0].write_size = le32_to_cpup((u32 *)&buf[4]);
+	info[0].fw_addr = le32_to_cpup((u32 *)&buf[8]);
+
+	/* partition 1 ~ n: config data */
+	for (i = 1; i < pnum; i++) {
+		memcpy(buf, &fw->data[i * HIMAX_ZF_PARTITION_DESC_SZ + table_addr],
+		       HIMAX_ZF_PARTITION_DESC_SZ);
+		memcpy(info[i].sram_addr, buf, 4);
+		info[i].write_size = le32_to_cpup((u32 *)&buf[4]);
+		info[i].fw_addr = le32_to_cpup((u32 *)&buf[8]);
+		info[i].cfg_addr = le32_to_cpup((u32 *)&info[i].sram_addr[0]);
+
+		/* Write address must be multiple of 4 */
+		if (info[i].cfg_addr % 4 != 0) {
+			info[i].cfg_addr -= (info[i].cfg_addr % 4);
+			info[i].fw_addr -= (info[i].cfg_addr % 4);
+			info[i].write_size += (info[i].cfg_addr % 4);
+		}
+
+		if (dsram_base > info[i].cfg_addr) {
+			dsram_base = info[i].cfg_addr;
+			i_min = i;
+		}
+		if (dsram_max < info[i].cfg_addr) {
+			dsram_max = info[i].cfg_addr;
+			i_max = i;
+		}
+	}
+
+	if (i_min < 0 || i_max < 0) {
+		dev_err(ts->dev, "%s: DSRAM address invalid!\n", __func__);
+		return -EINVAL;
+	}
+
+	/* 3. prepare data to update */
+	sram_min = info[i_min].cfg_addr;
+
+	cfg_sz = (dsram_max - dsram_base) + info[i_max].write_size;
+	/* Wrtie size must be multiple of 4 */
+	if (cfg_sz % 4 != 0)
+		cfg_sz = cfg_sz + 4 - (cfg_sz % 4);
+
+	dev_info(ts->dev, "%s: main code sz = %d, config sz = %d\n", __func__,
+	  info[0].write_size, cfg_sz);
+	/* config size should be smaller than DSRAM size */
+	if (cfg_sz > ts->chip_max_dsram_size) {
+		dev_err(ts->dev, "%s: config size error[%d, %u]!!\n", __func__,
+		  cfg_sz, ts->chip_max_dsram_size);
+		ret = -EINVAL;
+		goto alloc_cfg_buffer_failed;
+	}
+
+	memset(ts->zf_update_cfg_buffer, 0x00,
+	       ts->chip_max_dsram_size * sizeof(u8));
+
+	/* Collect all partition in FW for DSRAM in a cfg buffer */
+	for (i = 1; i < pnum; i++)
+		memcpy(&ts->zf_update_cfg_buffer[info[i].cfg_addr - dsram_base],
+		       &fw->data[info[i].fw_addr], info[i].write_size);
+
+	/*
+	 * 4. write to sram
+	 * First, write FW main code and check CRC by HW
+	 */
+	ret = himax_sram_write_crc_check(ts, le32_to_cpup((u32 *)info[0].sram_addr),
+					 &fw->data[info[0].fw_addr], info[0].write_size);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: HW CRC fail\n", __func__);
+		goto write_main_code_failed;
+	}
+
+	/*
+	 * Second, FW config data: Calculate CRC of CFG data which is going to write.
+	 * CFG data don't have CRC pre-defined in FW and need to be calculated by driver.
+	 */
+	cfg_crc_sw = himax_mcu_calculate_crc(ts->zf_update_cfg_buffer, cfg_sz);
+	for (retry_cnt = 0; retry_cnt < retry_limit; retry_cnt++) {
+		/* Write hole cfg data to DSRAM */
+		dev_info(ts->dev, "%s: Write cfg to SRAM - total write size = %d\n",
+		  __func__, cfg_sz);
+		ret = himax_mcu_register_write(ts, sram_min, ts->zf_update_cfg_buffer, cfg_sz);
+		if (ret < 0) {
+			dev_err(ts->dev, "%s: write cfg to SRAM fail\n", __func__);
+			goto write_cfg_failed;
+		}
+		/*
+		 * Check CRC: Tell HW to calculate CRC from CFG start address in SRAM and check
+		 * size is equal to size of CFG buffer written. Then we compare the two CRC data
+		 * make sure data written is correct.
+		 */
+		ret = himax_mcu_check_crc(ts, sram_min, cfg_sz, &cfg_crc_hw);
 		if (ret) {
-			dev_err(ts->dev, "%s: read event stack error!\n", __func__);
-			return ret;
+			dev_err(ts->dev, "%s: check CRC failed!\n", __func__);
+			goto crc_failed;
 		}
-	}
 
-	return 0;
-}
+		if (cfg_crc_hw != cfg_crc_sw)
+			dev_err(ts->dev, "%s: Cfg CRC FAIL, HWCRC = %X, SWCRC = %X, retry = %u\n",
+			  __func__, cfg_crc_hw, cfg_crc_sw, retry_cnt);
+		else
+			break;
+	}
 
-/**
- * himax_touch_get() - Get touch data from touch chip
- * @ts: Himax touch screen data
- * @buf: Buffer to store the data
- *
- * This function is a wrapper to call hx83102j_read_event_stack() to read the touch
- * data from the touch chip. The touch_data_sz is the size of the touch data to read,
- * which is calculated by hid report descriptor provided by the firmware.
- *
- * Return: HIMAX_TS_SUCCESS on success, negative error code on failure. We categorize
- * the error code into HIMAX_TS_GET_DATA_FAIL when the read fails, and HIMAX_TS_SUCCESS
- * when the read is successful. The reason is that the may need special handling when
- * the read fails.
- */
-static int himax_touch_get(struct himax_ts_data *ts, u8 *buf)
-{
-	if (hx83102j_read_event_stack(ts, buf, ts->touch_data_sz)) {
-		dev_err(ts->dev, "can't read data from chip!");
-		return HIMAX_TS_GET_DATA_FAIL;
+	if (retry_cnt == retry_limit && cfg_crc_hw != cfg_crc_sw) {
+		dev_err(ts->dev, "%s: Write cfg to SRAM fail\n", __func__);
+		ret = -EINVAL;
+		goto crc_not_match;
 	}
 
-	return HIMAX_TS_SUCCESS;
+crc_not_match:
+crc_failed:
+write_cfg_failed:
+write_main_code_failed:
+alloc_cfg_buffer_failed:
+	kfree(info);
+
+	return ret;
 }
 
 /**
- * himax_bin_desc_data_get() - Parse descriptor data from firmware token
+ * himax_mcu_firmware_update_zf() - Update the firmware to the touch chip
+ * @fw: Firmware data
  * @ts: Himax touch screen data
- * @addr: Address of the data in firmware image
- * @descript_buf: token for parsing
  *
- * This function is used to parse the descriptor data from the firmware token. The
- * descriptors are mappings of information in the firmware image. The function will
- * check checksum of each token first, and then parse the token to get the related
- * data. The data includes CID version, FW version, CFG version, touch config table,
- * HID table, HID descriptor, and HID read descriptor.
+ * This function is used to update the firmware to the touch chip. The first step is
+ * to reset the touch chip, stop the MCU and then write the firmware to the touch chip.
  *
- * Return: true on success, false on failure
+ * return: 0 on success, negative error code on failure
  */
-static bool himax_bin_desc_data_get(struct himax_ts_data *ts, u32 addr, u8 *descript_buf)
+static int himax_mcu_firmware_update_zf(const struct firmware *fw, struct himax_ts_data *ts)
 {
-	u16 chk_end;
-	u16 chk_sum;
-	u32 hid_table_addr;
-	u32 i, j;
-	u32 image_offset;
-	u32 map_code;
-	const u32 data_sz = 16;
-	const u32 report_desc_offset = 24;
-	union {
-		u8 *buf;
-		u32 *word;
-	} map_data;
+	int ret;
+	union himax_dword_data data_system_reset = {
+		.dword = cpu_to_le32(HIMAX_REG_DATA_SYSTEM_RESET)
+	};
 
-	/* looking for mapping in page, each mapping is 16 bytes */
-	for (i = 0; i < HIMAX_HX83102J_PAGE_SIZE; i = i + data_sz) {
-		chk_end = 0;
-		chk_sum = 0;
-		for (j = i; j < (i + data_sz); j++) {
-			chk_end |= descript_buf[j];
-			chk_sum += descript_buf[j];
-		}
-		if (!chk_end) { /* 1. Check all zero */
-			return false;
-		} else if (chk_sum % 0x100) { /* 2. Check sum */
-			dev_warn(ts->dev, "%s: chk sum failed in %X\n", __func__, i + addr);
-		} else { /* 3. get data */
-			map_data.buf = &descript_buf[i];
-			map_code = le32_to_cpup(map_data.word);
-			map_data.buf = &descript_buf[i + 4];
-			image_offset = le32_to_cpup(map_data.word);
-			/* 4. load info from FW image by specified mapping offset */
-			switch (map_code) {
-			/* Config ID */
-			case HIMAX_FW_CID:
-				ts->fw_info_table.addr_cid_ver_major = image_offset;
-				ts->fw_info_table.addr_cid_ver_minor = image_offset + 1;
-				break;
-			/* FW version */
-			case HIMAX_FW_VER:
-				ts->fw_info_table.addr_fw_ver_major = image_offset;
-				ts->fw_info_table.addr_fw_ver_minor = image_offset + 1;
-				break;
-			/* Config version */
-			case HIMAX_CFG_VER:
-				ts->fw_info_table.addr_cfg_ver_major = image_offset;
-				ts->fw_info_table.addr_cfg_ver_minor = image_offset + 1;
-				break;
-			/* Touch config table */
-			case HIMAX_TP_CONFIG_TABLE:
-				ts->fw_info_table.addr_cfg_table = image_offset;
-				break;
-			/* HID table */
-			case HIMAX_HID_TABLE:
-				ts->fw_info_table.addr_hid_table = image_offset;
-				hid_table_addr = image_offset;
-				ts->fw_info_table.addr_hid_desc = hid_table_addr;
-				ts->fw_info_table.addr_hid_rd_desc =
-					hid_table_addr + report_desc_offset;
-				break;
-			}
-		}
+	dev_info(ts->dev, "%s: Updating FW - total FW size = %u\n", __func__, (u32)fw->size);
+	ret = himax_mcu_register_write(ts, HIMAX_REG_ADDR_SYSTEM_RESET, data_system_reset.byte, 4);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: system reset fail\n", __func__);
+		return ret;
 	}
 
-	return true;
+	ret = hx83102j_sense_off(ts, false);
+	if (ret)
+		return ret;
+
+	ret = himax_zf_part_info(fw, ts);
+
+	return ret;
 }
 
 /**
- * himax_mcu_bin_desc_get() - Check and get the bin description from the data
- * @fw: Firmware data
+ * himax_zf_reload_from_file() - Complete firmware update sequence
+ * @file_name: File name of the firmware
  * @ts: Himax touch screen data
- * @max_sz: Maximum size to check
  *
- * This function is used to check and get the bin description from the firmware data.
- * It will check the given data to see if it match the bin description format, and
- * call himax_bin_desc_data_get() to get the related data.
+ * This function process the full sequence of updating the firmware to the touch chip.
+ * It will first check if the other thread is updating now, if not, it will request the
+ * firmware from user space and then call himax_mcu_firmware_update_zf() to update the
+ * firmware, and then tell firmware not to reload data from flash and initial the touch
+ * chip by calling himax_mcu_power_on_init().
  *
- * Return: true on mapping_count > 0, false on otherwise
+ * return: 0 on success, negative error code on failure
  */
-static bool himax_mcu_bin_desc_get(unsigned char *fw, struct himax_ts_data *ts, u32 max_sz)
+static int himax_zf_reload_from_file(char *file_name, struct himax_ts_data *ts)
 {
-	bool keep_on_flag;
-	u32 addr;
-	u32 mapping_count;
-	unsigned char *fw_buf;
-	const u8 header_id = 0x87;
-	const u8 header_id_loc = 0x0e;
-	const u8 header_sz = 8;
-	const u8 header[8] = {
-		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
-	};
+	int ret;
+	const struct firmware *fw;
 
-	/* Check bin is with description table or not */
-	if (!(memcmp(fw, header, header_sz) == 0 && fw[header_id_loc] == header_id)) {
-		dev_err(ts->dev, "%s: No description table\n", __func__);
-		return false;
+	if (!mutex_trylock(&ts->zf_update_lock)) {
+		dev_warn(ts->dev, "%s: Other thread is updating now!\n", __func__);
+		return 0;
 	}
+	dev_info(ts->dev, "%s: Preparing to update %s!\n", __func__, file_name);
 
-	for (addr = 0, mapping_count = 0; addr < max_sz; addr += HIMAX_HX83102J_PAGE_SIZE) {
-		fw_buf = &fw[addr];
-		/* Get related data */
-		keep_on_flag = himax_bin_desc_data_get(ts, addr, fw_buf);
-		if (keep_on_flag)
-			mapping_count++;
-		else
-			break;
+	ret = request_firmware(&fw, file_name, ts->dev);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: request firmware fail, code[%d]!!\n", __func__, ret);
+		goto load_firmware_error;
 	}
 
-	return mapping_count > 0;
+	ret = himax_mcu_firmware_update_zf(fw, ts);
+	release_firmware(fw);
+	if (ret < 0)
+		goto load_firmware_error;
+
+	ret = himax_disable_fw_reload(ts);
+	if (ret < 0)
+		goto load_firmware_error;
+	ret = himax_mcu_power_on_init(ts);
+
+load_firmware_error:
+	mutex_unlock(&ts->zf_update_lock);
+
+	return ret;
 }
 
 /**
@@ -1248,6 +2198,7 @@ static int himax_ts_operation(struct himax_ts_data *ts)
  * This function is used to handle interrupt bottom half work. It will
  * call the himax_ts_operation() to get the touch data, dispatch the data
  * to HID core. If the touch data is not valid, it will reset the TPIC.
+ * It will also call the hx83102j_reload_to_active() after the reset action.
  *
  * Return: void
  */
@@ -1256,7 +2207,38 @@ static void himax_ts_work(struct himax_ts_data *ts)
 	if (himax_ts_operation(ts) == HIMAX_TS_GET_DATA_FAIL) {
 		dev_info(ts->dev, "%s: Now reset the Touch chip\n", __func__);
 		himax_mcu_ic_reset(ts, true);
+		if (hx83102j_reload_to_active(ts))
+			dev_warn(ts->dev, "%s: Reload to active failed\n", __func__);
+	}
+}
+
+/**
+ * himax_update_fw() - update firmware using firmware structure
+ * @ts: Himax touch screen data
+ *
+ * This function use already initialize firmware structure in ts to update
+ * firmware.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_update_fw(struct himax_ts_data *ts)
+{
+	int ret;
+	u32 retry_cnt;
+	const u32 retry_limit = 3;
+
+	for (retry_cnt = 0; retry_cnt < retry_limit; retry_cnt++) {
+		ret = himax_mcu_firmware_update_zf(ts->himax_fw, ts);
+		if (ret < 0) {
+			dev_err(ts->dev, "%s: TP upgrade error, upgrade_times = %d\n", __func__,
+			  retry_cnt);
+		} else {
+			dev_info(ts->dev, "%s: TP FW upgrade OK\n", __func__);
+			return 0;
+		}
 	}
+
+	return -EIO;
 }
 
 /**
@@ -1289,9 +2271,8 @@ static int himax_hid_rd_init(struct himax_ts_data *ts)
 			if (!ts->hid_rd_data.rd_data)
 				return -ENOMEM;
 		}
-		/* Copy the base RD from firmware table */
 		memcpy((void *)ts->hid_rd_data.rd_data,
-		       &ts->himax_fw_data[ts->fw_info_table.addr_hid_rd_desc],
+		       &ts->himax_fw->data[ts->fw_info_table.addr_hid_rd_desc],
 		       ts->hid_desc.report_desc_length);
 		ts->hid_rd_data.rd_length = ts->hid_desc.report_desc_length;
 	}
@@ -1401,81 +2382,95 @@ static void himax_power_deconfig(struct himax_platform_data *pdata)
 	}
 }
 
-/* load firmware data from flash, parse HID info and register HID */
 /**
- * himax_load_config() - Load the firmware from the flash
- * @ts: Himax touch screen data
+ * himax_initial_work() - Initial work for the touch screen
+ * @work: Work structure
+ *
+ * This function is used to do the initial work for the touch screen. It will
+ * call the request_firmware() to get the firmware from the file system, and parse the
+ * mapping table in 1k header. If the headers are parsed successfully, it will
+ * call the himax_update_fw() to update the firmware and power on the touch screen.
+ * If the power on action is successful, it will load the hid descriptor and
+ * check the touch panel information. If the touch panel information is correct,
+ * it will call the himax_hid_rd_init() to initialize the HID report descriptor,
+ * and call the himax_hid_register() to register the HID device. After all is done,
+ * it will release the firmware and enable the interrupt.
  *
- * This function is used to load the firmware from the flash. It will read
- * the firmware from the flash and parse the HID info. If the HID info is
- * valid, it will initialize the HID report descriptor and register the HID
- * device. If the HID device is probed, it will initialize the report data
- * and enable the interrupt.
- *
- * Return: 0 on success, negative error code on failure
+ * Return: None
  */
-static int himax_load_config(struct himax_ts_data *ts)
+static void himax_initial_work(struct work_struct *work)
 {
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+						initial_work.work);
 	int ret;
-	s32 i;
-	s32 page_sz = (s32)HIMAX_HX83102J_PAGE_SIZE;
-	s32 flash_sz = (s32)HIMAX_HX83102J_FLASH_SIZE;
-	bool fw_load_status = false;
+	bool fw_load_status;
 	const u32 fw_bin_header_sz = 1024;
 
 	ts->ic_boot_done = false;
-
-	ts->himax_fw_data = devm_kzalloc(ts->dev, HIMAX_HX83102J_FLASH_SIZE, GFP_KERNEL);
-	if (!ts->himax_fw_data)
-		return -ENOMEM;
-
-	for (i = 0; i < flash_sz; i += page_sz) {
-		ret = himax_mcu_register_read(ts, i, ts->himax_fw_data + i,
-					      (flash_sz - i) > page_sz ? page_sz : (flash_sz - i));
-		if (ret < 0) {
-			dev_err(ts->dev, "%s: read FW from flash fail!\n", __func__);
-			return ret;
-		}
+	dev_info(ts->dev, "%s: request file %s\n", __func__, ts->firmware_name);
+	ret = request_firmware(&ts->himax_fw, ts->firmware_name, ts->dev);
+	if (ret < 0) {
+		dev_err(ts->dev, "%s: request firmware failed, error code = %d\n", __func__, ret);
+		return;
 	}
-	/* Search mapping table in 1k header */
-	fw_load_status = himax_mcu_bin_desc_get((unsigned char *)ts->himax_fw_data,
+	/* Parse the mapping table in 1k header */
+	fw_load_status = himax_mcu_bin_desc_get((unsigned char *)ts->himax_fw->data,
 						ts, fw_bin_header_sz);
 	if (!fw_load_status) {
-		dev_err(ts->dev, "%s: FW load status fail!\n", __func__);
-		return -EINVAL;
+		dev_err(ts->dev, "%s: Failed to parse the mapping table!\n", __func__);
+		goto err_load_bin_descriptor;
 	}
 
-	if (ts->fw_info_table.addr_hid_desc != 0) {
-		memcpy(&ts->hid_desc,
-		       &ts->himax_fw_data[ts->fw_info_table.addr_hid_desc],
-		       sizeof(struct himax_hid_desc));
-		ts->hid_desc.desc_length =
-			le16_to_cpu(ts->hid_desc.desc_length);
-		ts->hid_desc.bcd_version =
-			le16_to_cpu(ts->hid_desc.bcd_version);
-		ts->hid_desc.report_desc_length =
-			le16_to_cpu(ts->hid_desc.report_desc_length);
-		ts->hid_desc.max_input_length =
-			le16_to_cpu(ts->hid_desc.max_input_length);
-		ts->hid_desc.max_output_length =
-			le16_to_cpu(ts->hid_desc.max_output_length);
-		ts->hid_desc.max_fragment_length =
-			le16_to_cpu(ts->hid_desc.max_fragment_length);
-		ts->hid_desc.vendor_id =
-			le16_to_cpu(ts->hid_desc.vendor_id);
-		ts->hid_desc.product_id =
-			le16_to_cpu(ts->hid_desc.product_id);
-		ts->hid_desc.version_id =
-			le16_to_cpu(ts->hid_desc.version_id);
-		ts->hid_desc.flags =
-			le16_to_cpu(ts->hid_desc.flags);
+	if (himax_update_fw(ts)) {
+		dev_err(ts->dev, "%s: Update FW fail\n", __func__);
+		goto err_update_fw_failed;
 	}
 
+	dev_info(ts->dev, "%s: Update FW success\n", __func__);
+	/* write flag to sram to stop fw reload again. */
+	if (himax_disable_fw_reload(ts))
+		goto err_disable_fw_reload;
+	if (himax_mcu_power_on_init(ts))
+		goto err_power_on_init;
+	/* get hid descriptors */
+	if (!ts->fw_info_table.addr_hid_desc) {
+		dev_err(ts->dev, "%s: No HID descriptor! Wrong FW!\n", __func__);
+		goto err_wrong_firmware;
+	}
+	memcpy(&ts->hid_desc,
+	       &ts->himax_fw->data[ts->fw_info_table.addr_hid_desc],
+	       sizeof(struct himax_hid_desc));
+	ts->hid_desc.desc_length =
+		le16_to_cpu(ts->hid_desc.desc_length);
+	ts->hid_desc.bcd_version =
+		le16_to_cpu(ts->hid_desc.bcd_version);
+	ts->hid_desc.report_desc_length =
+		le16_to_cpu(ts->hid_desc.report_desc_length);
+	ts->hid_desc.max_input_length =
+		le16_to_cpu(ts->hid_desc.max_input_length);
+	ts->hid_desc.max_output_length =
+		le16_to_cpu(ts->hid_desc.max_output_length);
+	ts->hid_desc.max_fragment_length =
+		le16_to_cpu(ts->hid_desc.max_fragment_length);
+	ts->hid_desc.vendor_id =
+		le16_to_cpu(ts->hid_desc.vendor_id);
+	ts->hid_desc.product_id =
+		le16_to_cpu(ts->hid_desc.product_id);
+	ts->hid_desc.version_id =
+		le16_to_cpu(ts->hid_desc.version_id);
+	ts->hid_desc.flags =
+		le16_to_cpu(ts->hid_desc.flags);
+
+	if (himax_mcu_tp_info_check(ts))
+		goto err_tp_info_failed;
+	if (himax_mcu_read_FW_ver(ts))
+		goto err_read_fw_ver;
 	if (himax_hid_rd_init(ts)) {
 		dev_err(ts->dev, "%s: hid rd init fail\n", __func__);
 		goto err_hid_rd_init_failed;
 	}
 
+	usleep_range(1000000, 1000100);
 	himax_hid_register(ts);
 	if (!ts->hid_probed) {
 		goto err_hid_probe_failed;
@@ -1486,19 +2481,28 @@ static int himax_load_config(struct himax_ts_data *ts)
 		}
 	}
 
-	ts->himax_fw_data = NULL;
+	release_firmware(ts->himax_fw);
+	ts->himax_fw = NULL;
+
 	ts->ic_boot_done = true;
 	himax_int_enable(ts, true);
 
-	return 0;
+	return;
 
 err_report_data_init_failed:
 	himax_hid_remove(ts);
 	ts->hid_probed = false;
 err_hid_probe_failed:
 err_hid_rd_init_failed:
-
-	return -EINVAL;
+err_read_fw_ver:
+err_tp_info_failed:
+err_wrong_firmware:
+err_power_on_init:
+err_disable_fw_reload:
+err_update_fw_failed:
+err_load_bin_descriptor:
+	release_firmware(ts->himax_fw);
+	ts->himax_fw = NULL;
 }
 
 /**
@@ -1550,12 +2554,22 @@ static void himax_ap_notify_fw_suspend(struct himax_ts_data *ts, bool suspend)
  * @ts: Himax touch screen data
  *
  * This function is used to resume the touch screen. It will call the
+ * himax_zf_reload_from_file() to reload the firmware. And call the
  * himax_ap_notify_fw_suspend() to notify the FW of AP resume status.
  *
  * Return: None
  */
 static void himax_resume_proc(struct himax_ts_data *ts)
 {
+	int ret;
+
+	ret = himax_zf_reload_from_file(ts->firmware_name, ts);
+	if (ret) {
+		dev_err(ts->dev, "%s: update FW fail, code[%d]!!\n", __func__, ret);
+		return;
+	}
+	ts->resume_succeeded = true;
+
 	himax_ap_notify_fw_suspend(ts, false);
 }
 
@@ -1586,17 +2600,25 @@ static int himax_chip_suspend(struct himax_ts_data *ts)
  * This function is used to resume the touch screen. It will set the resume
  * success flag to false, and disable reset pin. Then call the himax_resume_proc()
  * to process detailed resume procedure.
+ * If the resume action is succeeded, it will call the himax_hid_probe() to restore
+ * the HID device and enable the interrupt.
  *
  * Return: 0 on success, negative error code on failure
  */
 static int himax_chip_resume(struct himax_ts_data *ts)
 {
+	ts->resume_succeeded = false;
 	if (himax_power_set(ts, true))
 		return -EIO;
 	gpiod_set_value(ts->pdata.gpiod_rst, 0);
 	himax_resume_proc(ts);
-	himax_hid_probe(ts);
-	himax_int_enable(ts, true);
+	if (ts->resume_succeeded) {
+		himax_hid_probe(ts);
+		himax_int_enable(ts, true);
+	} else {
+		dev_err(ts->dev, "%s: resume failed!\n", __func__);
+		return -ECANCELED;
+	}
 
 	return 0;
 }
@@ -1657,8 +2679,7 @@ static int himax_resume(struct device *dev)
  * initialize interrupt lock, register the interrupt, and disable the
  * interrupt. If later part of initialization succeed, then interrupt will
  * be enabled.
- * It will also load the firmware from the flash, parse the HID info, and
- * register the HID device by calling the himax_load_config().
+ * And initialize varies flags, workqueue and delayed work for later use.
  *
  * Return: 0 on success, negative error code on failure
  */
@@ -1666,18 +2687,93 @@ static int himax_chip_init(struct himax_ts_data *ts)
 {
 	int ret;
 
+	hx83102j_chip_init_data(ts);
 	if (himax_ts_register_interrupt(ts)) {
 		dev_err(ts->dev, "%s: register interrupt failed\n", __func__);
 		return -EIO;
 	}
 	himax_int_enable(ts, false);
-	ret = himax_load_config(ts);
-	if (ret < 0)
-		return ret;
+	ts->zf_update_cfg_buffer = devm_kzalloc(ts->dev, ts->chip_max_dsram_size, GFP_KERNEL);
+	if (!ts->zf_update_cfg_buffer) {
+		ret = -ENOMEM;
+		goto err_update_cfg_buf_alloc_failed;
+	}
+	INIT_DELAYED_WORK(&ts->initial_work, himax_initial_work);
+	schedule_delayed_work(&ts->initial_work, msecs_to_jiffies(HIMAX_DELAY_BOOT_UPDATE_MS));
 	ts->initialized = true;
 
+	return 0;
+	cancel_delayed_work_sync(&ts->initial_work);
+err_update_cfg_buf_alloc_failed:
+
+	return ret;
+}
+
+/**
+ * himax_chip_deinit() - Deinitialize the Himax touch screen
+ * @ts: Himax touch screen data
+ *
+ * This function is used to deinitialize the Himax touch screen.
+ *
+ * Return: None
+ */
+static void himax_chip_deinit(struct himax_ts_data *ts)
+{
+	cancel_delayed_work_sync(&ts->initial_work);
+}
+
+#if defined(CONFIG_OF)
+/**
+ * himax_parse_dt() - Parse the device tree
+ * @dt: Device node
+ * @pdata: Himax platform data
+ *
+ * This function is used to parse the device tree. If "himax,pid" is found,
+ * it will parse the PID value and set it to the platform data. The firmware
+ * name will set to himax_i2chid_$PID.bin if the PID is found, or
+ * himax_i2chid.bin if the PID is not found.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_parse_dt(struct device_node *dt, struct himax_platform_data *pdata)
+{
+	int err;
+	size_t fw_name_len;
+	const char *fw_name;
+	struct himax_ts_data *ts;
+
+	if (!dt || !pdata)
+		return -EINVAL;
+
+	ts = container_of(pdata, struct himax_ts_data, pdata);
+	/* Set default firmware name, without PID */
+	strscpy(ts->firmware_name, HIMAX_BOOT_UPGRADE_FWNAME HIMAX_FW_EXT_NAME,
+		sizeof(HIMAX_BOOT_UPGRADE_FWNAME HIMAX_FW_EXT_NAME));
+
+	if (of_property_read_bool(dt, "vccd-supply")) {
+		pdata->vccd_supply = regulator_get(ts->dev, "vccd");
+		if (IS_ERR(pdata->vccd_supply)) {
+			dev_err(ts->dev, "%s:  DT:failed to get vccd supply\n", __func__);
+			err = PTR_ERR(pdata->vccd_supply);
+			pdata->vccd_supply = NULL;
+			return err;
+		}
+		dev_info(ts->dev, "%s: DT:vccd-supply=%p\n", __func__, pdata->vccd_supply);
+	} else {
+		pdata->vccd_supply = NULL;
+	}
+
+	if (of_property_read_string(dt, "firmware-name", &fw_name)) {
+		dev_info(ts->dev, "%s: DT:firmware-name not found\n", __func__);
+	} else {
+		fw_name_len = strlen(fw_name) + 1;
+		strscpy(ts->firmware_name, fw_name, min(sizeof(ts->firmware_name), fw_name_len));
+		dev_info(ts->dev, "%s: firmware-name = %s\n", __func__, ts->firmware_name);
+	}
+
 	return 0;
 }
+#endif
 
 /**
  * __himax_initial_power_up() - Initial power up of the Himax touch screen
@@ -1895,6 +2991,13 @@ static int himax_spi_drv_probe(struct spi_device *spi)
 		dev_err(ts->dev, "%s: gpio-rst value is not valid\n", __func__);
 		return -EIO;
 	}
+#if defined(CONFIG_OF)
+	if (himax_parse_dt(spi->dev.of_node, pdata) < 0) {
+		dev_err(ts->dev, "%s:  parse OF data failed!\n", __func__);
+		ts->dev = NULL;
+		return -ENODEV;
+	}
+#endif
 
 	spi->bits_per_word = 8;
 	spi->mode = SPI_MODE_3;
@@ -1925,6 +3028,7 @@ static int himax_spi_drv_probe(struct spi_device *spi)
 	spin_lock_init(&ts->irq_lock);
 	mutex_init(&ts->rw_lock);
 	mutex_init(&ts->reg_lock);
+	mutex_init(&ts->zf_update_lock);
 	dev_set_drvdata(&spi->dev, ts);
 	spi_set_drvdata(spi, ts);
 
@@ -1960,6 +3064,7 @@ static void himax_spi_drv_remove(struct spi_device *spi)
 			if (ts->hid_probed)
 				himax_hid_remove(ts);
 		}
+		himax_chip_deinit(ts);
 		himax_platform_deinit(ts);
 	}
 }
diff --git a/drivers/hid/hid-himax.h b/drivers/hid/hid-himax.h
index 45dc3e6283ae..e426ffdc4cf2 100644
--- a/drivers/hid/hid-himax.h
+++ b/drivers/hid/hid-himax.h
@@ -9,7 +9,9 @@
 #define __HID_HIMAX_83102J_H__
 
 #include <drm/drm_panel.h>
+#include <linux/crc32poly.h>
 #include <linux/delay.h>
+#include <linux/firmware.h>
 #include <linux/hid.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -41,6 +43,13 @@
 							 HIMAX_BUS_W_HLEN + HIMAX_REG_SZ)
 /* SPI CS setup time */
 #define HIMAX_SPI_CS_SETUP_TIME				300
+/* Clear 4 bytes data */
+#define HIMAX_DATA_CLEAR				0x00000000
+/* boot update start delay */
+#define HIMAX_DELAY_BOOT_UPDATE_MS			2000
+#define HIMAX_TP_INFO_STR_LEN				12U
+#define HIMAX_ZF_PARTITION_AMOUNT_OFFSET		12
+#define HIMAX_ZF_PARTITION_DESC_SZ			16U
 /* HIDRAW report header size */
 #define HIMAX_HID_REPORT_HDR_SZ				2U
 /* hx83102j IC parameters */
@@ -71,17 +80,48 @@
 #define HIMAX_AHB_CMD_INCR4_ADD_4_BYTE			0x01
 #define HIMAX_AHB_CMD_LEAVE_SAFE_MODE			0x0000
 /* DSRAM flag addresses */
+#define HIMAX_DSRAM_ADDR_VENDOR				0x10007000
+#define HIMAX_DSRAM_ADDR_FW_VER				0x10007004
+#define HIMAX_DSRAM_ADDR_CUS_INFO			0x10007008
+#define HIMAX_DSRAM_ADDR_PROJ_INFO			0x10007014
+#define HIMAX_DSRAM_ADDR_CFG				0x10007084
+#define HIMAX_DSRAM_ADDR_INT_IS_EDGE			0x10007088
+#define HIMAX_DSRAM_ADDR_MKEY				0x100070e8
+#define HIMAX_DSRAM_ADDR_RXNUM_TXNUM			0x100070f4
+#define HIMAX_DSRAM_ADDR_MAXPT_XYRVS			0x100070f8
+#define HIMAX_DSRAM_ADDR_X_Y_RES			0x100070fc
+#define HIMAX_DSRAM_ADDR_STYLUS_FUNCTION		0x1000719c
+#define HIMAX_DSRAM_ADDR_STYLUS_VERSION			0x100071fc
+#define HIMAX_DSRAM_ADDR_SET_NFRAME			0x10007294
+#define HIMAX_DSRAM_ADDR_2ND_FLASH_RELOAD		0x100072c0
+#define HIMAX_DSRAM_ADDR_FLASH_RELOAD			0x10007f00
+#define HIMAX_DSRAM_ADDR_SORTING_MODE_EN		0x10007f04
+#define HIMAX_DSRAM_ADDR_DBG_MSG			0x10007f40
 #define HIMAX_DSRAM_ADDR_AP_NOTIFY_FW_SUSPEND		0x10007fd0
 /* dsram flag data */
 #define HIMAX_DSRAM_DATA_AP_NOTIFY_FW_SUSPEND		0xa55aa55a
 #define HIMAX_DSRAM_DATA_AP_NOTIFY_FW_RESUME		0x00000000
+#define HIMAX_DSRAM_DATA_DISABLE_FLASH_RELOAD		0x00009aa9
+#define HIMAX_DSRAM_DATA_FW_RELOAD_DONE			0x000072c0
 /* hx83102j-specific register/dsram flags/data */
+#define HIMAX_HX83102J_DSRAM_ADDR_RAW_OUT_SEL		0x100072ec
+#define HIMAX_HX83102J_REG_ADDR_HW_CRC			0x80010000
 #define HIMAX_HX83102J_REG_ADDR_TCON_RST		0x80020004
+#define HIMAX_HX83102J_REG_DATA_HW_CRC			0x0000ecce
+#define HIMAX_HX83102J_REG_DATA_HW_CRC_DISABLE		0x00000000
 /* hardware register addresses */
 #define HIMAX_REG_ADDR_SPI200_DATA			0x8000002c
+#define HIMAX_REG_ADDR_RELOAD_STATUS			0x80050000
+#define HIMAX_REG_ADDR_RELOAD_CRC32_RESULT		0x80050018
+#define HIMAX_REG_ADDR_RELOAD_ADDR_FROM			0x80050020
+#define HIMAX_REG_ADDR_RELOAD_ADDR_CMD_BEAT		0x80050028
+#define HIMAX_REG_ADDR_SYSTEM_RESET			0x90000018
+#define HIMAX_REG_ADDR_RELOAD_TO_ACTIVE			0x90000048
 #define HIMAX_REG_ADDR_CTRL_FW				0x9000005c
 #define HIMAX_REG_ADDR_FW_STATUS			0x900000a8
 #define HIMAX_REG_ADDR_ICID				0x900000d0
+#define HIMAX_REG_ADDR_RESET_FLAG			0x900000e4
+#define HIMAX_REG_ADDR_DD_STATUS			0x900000e8
 /* hardware reg data/flags */
 #define HIMAX_REG_DATA_FW_STATE_RUNNING			0x05
 #define HIMAX_REG_DATA_FW_STATE_SAFE_MODE		0x0c
@@ -89,6 +129,9 @@
 #define HIMAX_REG_DATA_FW_GO_SAFEMODE			0xa5
 #define HIMAX_REG_DATA_FW_IN_SAFEMODE			0x87
 #define HIMAX_REG_DATA_ICID				0x83102900
+#define HIMAX_REG_DATA_RELOAD_DONE			0x01
+#define HIMAX_REG_DATA_RELOAD_PASSWORD			0x99
+#define HIMAX_REG_DATA_SYSTEM_RESET			0x00000055
 #define HIMAX_REG_DATA_TCON_RST				0x00000000
 /* HIMAX SPI function select, 1st byte of any SPI command sequence */
 #define HIMAX_SPI_FUNCTION_READ				0xf3
@@ -100,6 +143,8 @@
 #define HIMAX_CFG_VER					0x10000600
 #define HIMAX_HID_TABLE					0x30000100
 #define HIMAX_FW_BIN_DESC				0x10000000
+#define HIMAX_BOOT_UPGRADE_FWNAME			"himax_i2chid"
+#define HIMAX_FW_EXT_NAME				".bin"
 
 /**
  * enum himax_hidraw_id_function - HIDRAW report IDs
@@ -119,6 +164,20 @@ enum himax_touch_report_status {
 	HIMAX_TS_SUCCESS = 0,
 };
 
+/**
+ * struct himax_zf_info - Zero flash update information
+ * @sram_addr: SRAM address byte array buffer
+ * @write_size: Write size of each chunk
+ * @fw_addr: Offset in firmware file
+ * @cfg_addr: target sram address
+ */
+struct himax_zf_info {
+	u8 sram_addr[4];
+	int write_size;
+	u32 fw_addr;
+	u32 cfg_addr;
+};
+
 /**
  * struct himax_fw_address_table - address/offset in firmware image
  * @addr_fw_ver_major: Address to Major version of firmware
@@ -170,9 +229,21 @@ union himax_dword_data {
 /**
  * struct himax_ic_data - IC information holder
  * @stylus_ratio: Stylus ratio
+ * @vendor_cus_info: Vendor customer information
+ * @vendor_proj_info: Vendor project information
+ * @vendor_fw_ver: Vendor firmware version
+ * @vendor_config_ver: Vendor config version
+ * @vendor_touch_cfg_ver: Vendor touch config version
+ * @vendor_display_cfg_ver: Vendor display config version
+ * @vendor_cid_maj_ver: Vendor CID major version
+ * @vendor_cid_min_ver: Vendor CID minor version
+ * @vendor_panel_ver: Vendor panel version
+ * @vendor_sensor_id: Vendor sensor ID
  * @rx_num: Number of RX
  * @tx_num: Number of TX
  * @button_num: Number of buttons
+ * @x_res: X resolution
+ * @y_res: Y resolution
  * @max_point: Maximum touch point
  * @icid: IC ID
  * @interrupt_is_edge: Interrupt is edge otherwise level
@@ -181,9 +252,21 @@ union himax_dword_data {
  */
 struct himax_ic_data {
 	u8 stylus_ratio;
+	u8 vendor_cus_info[12];
+	u8 vendor_proj_info[12];
+	int vendor_fw_ver;
+	int vendor_config_ver;
+	int vendor_touch_cfg_ver;
+	int vendor_display_cfg_ver;
+	int vendor_cid_maj_ver;
+	int vendor_cid_min_ver;
+	int vendor_panel_ver;
+	int vendor_sensor_id;
 	u32 rx_num;
 	u32 tx_num;
 	u32 button_num;
+	u32 x_res;
+	u32 y_res;
 	u32 max_point;
 	u32 icid;
 	bool interrupt_is_edge;
@@ -191,6 +274,38 @@ struct himax_ic_data {
 	bool stylus_v2;
 };
 
+/**
+ * struct himax_bin_desc - Firmware binary descriptor
+ * @passwd: Password to indicate the binary is valid
+ * @cid: Customer ID
+ * @panel_ver: Panel version
+ * @fw_ver: Firmware version
+ * @ic_sign: IC signature
+ * @customer: Customer name
+ * @project: Project name
+ * @fw_major: Major version of firmware
+ * @fw_minor: Minor version of firmware
+ * @date: Generate date of firmware
+ * @ic_sign_2: IC signature 2
+ *
+ * This structure is used to hold the firmware binary descriptor.
+ * It directly maps to a sequence of bytes in firmware image,
+ * thus need to be packed.
+ */
+struct himax_bin_desc {
+	u16 passwd;
+	u16 cid;
+	u8 panel_ver;
+	u16 fw_ver;
+	u8 ic_sign;
+	char customer[12];
+	char project[12];
+	char fw_major[12];
+	char fw_minor[12];
+	char date[12];
+	char ic_sign_2[12];
+} __packed;
+
 /**
  * struct himax_hid_desc - HID descriptor
  * @desc_length: Length of HID descriptor
@@ -223,6 +338,39 @@ struct himax_hid_desc {
 	u32 reserved;
 } __packed;
 
+/**
+ * struct himax_hid_info - IC information holder for HIDRAW function
+ * @vid: Vendor ID
+ * @pid: Product ID
+ * @cfg_info: Configuration information
+ * @cfg_version: Configuration version
+ * @disp_version: Display version
+ * @rx: Number of RX
+ * @tx: Number of TX
+ * @y_res: Y resolution
+ * @x_res: X resolution
+ * @pt_num: Number of touch points
+ * @mkey_num: Number of mkey
+ * @debug_info: Debug information
+ *
+ * This structure is used to hold the IC config information for HIDRAW.
+ * The format is binary fixed, thus need to be packed.
+ */
+struct himax_hid_info {
+	u16 vid;
+	u16 pid;
+	u8 cfg_info[32];
+	u8 cfg_version;
+	u8 disp_version;
+	u8 rx;
+	u8 tx;
+	u16 y_res;
+	u16 x_res;
+	u8 pt_num;
+	u8 mkey_num;
+	u8 debug_info[78];
+} __packed;
+
 /**
  * struct himax_platform_data - Platform data holder
  * @is_panel_follower: Is panel follower enabled
@@ -244,8 +392,9 @@ struct himax_platform_data {
  * @xfer_buf: Interrupt data buffer
  * @xfer_rx_data: SPI Transfer receive data buffer
  * @xfer_tx_data: SPI Transfer transmit data buffer
- * @himax_fw_data: Firmware data holder from flash
+ * @zf_update_cfg_buffer: Zero flash update configuration buffer
  * @himax_irq: IRQ number
+ * @chip_max_dsram_size: Maximum size of DSRAM
  * @spi_xfer_max_sz: Size of SPI controller max transfer size
  * @xfer_buf_sz: Size of interrupt data buffer
  * @irq_state: IRQ state
@@ -254,24 +403,30 @@ struct himax_platform_data {
  * @probe_finish: Indicate the driver probe is finished
  * @ic_boot_done: Indicate the IC boot is done
  * @hid_probed: Indicate the HID device is probed
+ * @resume_succeeded: Indicate the resume is succeeded
+ * @firmware_name: Firmware name
  * @touch_data_sz: Size of each interrupt data from IC
+ * @himax_fw: Firmware data holder from user space
  * @dev: Device pointer
  * @spi: SPI device pointer
  * @hid: HID device pointer
  * @reg_lock: Mutex lock for reg access
  * @rw_lock: Mutex lock for read/write action
+ * @zf_update_lock: Mutex lock for zero-flash FW update
  * @ic_data: IC information holder
  * @pdata: Platform data holder
  * @fw_info_table: Firmware information address table of firmware image
  * @hid_desc: HID descriptor
  * @hid_rd_data: HID report descriptor data
+ * @initial_work: Delayed work for TP initialization
  */
 struct himax_ts_data {
 	u8 *xfer_buf;
 	u8 *xfer_rx_data;
 	u8 *xfer_tx_data;
-	u8 *himax_fw_data;
+	u8 *zf_update_cfg_buffer;
 	s32 himax_irq;
+	u32 chip_max_dsram_size;
 	u32 spi_xfer_max_sz;
 	u32 xfer_buf_sz;
 	atomic_t irq_state;
@@ -281,7 +436,11 @@ struct himax_ts_data {
 	bool probe_finish;
 	bool ic_boot_done;
 	bool hid_probed;
+	bool resume_succeeded;
+	bool zf_update_flag;
+	char firmware_name[64];
 	int touch_data_sz;
+	const struct firmware *himax_fw;
 	struct device *dev;
 	struct spi_device *spi;
 	struct hid_device *hid;
@@ -289,10 +448,13 @@ struct himax_ts_data {
 	struct mutex reg_lock;
 	/* lock for bus read/write action */
 	struct mutex rw_lock;
+	/* lock for zero-flash FW update */
+	struct mutex zf_update_lock;
 	struct himax_ic_data ic_data;
 	struct himax_platform_data pdata;
 	struct himax_fw_address_table fw_info_table;
 	struct himax_hid_desc hid_desc;
 	struct himax_hid_rd_data hid_rd_data;
+	struct delayed_work initial_work;
 };
 #endif
-- 
2.34.1


