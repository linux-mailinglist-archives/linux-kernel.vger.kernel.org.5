Return-Path: <linux-kernel+bounces-127779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 859DC8950DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C71328135F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC51A605BB;
	Tue,  2 Apr 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="tULaxgsK"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2017.outbound.protection.outlook.com [40.92.52.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FCC5FDDB;
	Tue,  2 Apr 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055020; cv=fail; b=dQACchtaVCEb3EgdAAq+Tlhe9FVetJah1kMW7wfOtQAdT+N1cHZUUyEbkCVVhsRy4joL1oznKdxgI/3hDJN23t1WNuBdryYUZ7l7G+OlqMbtxL76CxY+wXY3OOZYMHQlFTQG7itqr7auLl6iHxRCEbMW3QNueuKA8SlVao2N0VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055020; c=relaxed/simple;
	bh=CE9rJ6YqiZIptrf0u8T9LOLW+ImUjKp8wbTlBvnPwUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YeVaILlhvfcj2lY4IBV3uRaj3zXAkDl2WM5r0d6bzrSIpy6HqngZHCpqdviXSS+CzPM2C3gbepTR5R6FWVPBXl7FloB59215yPUZ/aQsH0bwdCDokMgzMMVhhrPoKQj/COnTx61Uece7FTLPPcEor6JZYp/ovI6Va4hInAVXE6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=tULaxgsK; arc=fail smtp.client-ip=40.92.52.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2JDDWQ+SRSQWWbzfCiBXlUNAW2qcgeT3b1z/uV77zd8uEqLjlf/sXB+9mCH7khYabjTEyIIHLwCz/3jau56wyYyxCsZBn//vURatwtdJ3wzljHHWSJKomiSWoSSKSvIXbFachQOmNd17VEa8wH1iEIeg0xLRzR8+lMeyIepMpTTEnrzUebkniCoIssS9+xe/g5KAQnALkfaLsea2JMbdYWLnJUmEdA03bdmLyXvFEdiJVD3eV9JXVD1cIE1EZrbPxvCi4Lnm7eH5mpjRiA0aiTk/a7/qHEFNBfNUg38yzl/h2BC39R9bbag3STcb/noRn6b5s+/HYb4CMyfc3jjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQJyGZPwRlVI7ReqM3YuMwvJE6Hi08CgUoAmyBY8io8=;
 b=WNUVCHiWbApgs7T43fMfiazTUvz30YZNPkqPpDGwaG0t18RpXkNcNQgnW6H2MQbmVwxI4m+Ml+l8m8fAFvyjFG82W9MsQUBIyNEghOLnvA8VrJ8TIrWo7zHQt3U4kuUijbNvvQzXR4nfg82v36k+yRkg25YJKOQttuwUvoc6sK+ujekfBQ2JB7BbDmW9LdvP8WgNHvTWZy64euYnrMAeYhEfTaQawTiJ5CdRYQXa+X1BcZ+qoWQC7HGUeie/k1JfzxUSg/YaZCK69spPvbwBzpPY1KhY5/CshFXNPmmmlpvrrxRuuaSmNoKL0cxcH+8IWAVar58RRRmjfr5gyuQ3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQJyGZPwRlVI7ReqM3YuMwvJE6Hi08CgUoAmyBY8io8=;
 b=tULaxgsKmayDXFDY6RCVVN3ciDeFGOXY4LQuxFjzaV16mE/rSDez7RkmExmrK3SHWO5GZm5aJwH5hY71KjNZCuhVBP4vZ3Q6hXrZwmzCcJC/sCIRNW6zEmLDWzB7qwSjZITH722Suj+KCDgq2/Z9q5qJeVblFw8BJXTm4CoYaQHzqcu4xrX4ibzdmmY4j2cOpGWisyvwcQboBRm8gI6RgLNBVfZFaO2mA/9xoigOtTYXZWCsh+uS6yPWmcIIDeGndxrJXfrSFWlCdUDs4xtQqE14ENRgPk2L7ihI5lbCQcMxDT/F9ocIZnshD9MoFy3cpU3EOLR/utg/b9HXkTyMYA==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by KL1PR06MB6964.apcprd06.prod.outlook.com (2603:1096:820:121::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:50:11 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:50:11 +0000
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
Subject: [PATCH v2 3/4] HID: Add DRM panel follower function
Date: Tue,  2 Apr 2024 18:49:29 +0800
Message-ID:
 <TY0PR06MB5611D2A2675DF1D021ED30DE9E3E2@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402104930.1053016-1-allencl_lin@hotmail.com>
References: <20240402104930.1053016-1-allencl_lin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [k++IVqfsyqAuCcDwHd1UvUQqDgLH7aBG]
X-ClientProxiedBy: PS2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:300:59::19) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <20240402104930.1053016-4-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|KL1PR06MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0647b671-9b50-47d2-6444-08dc5302ab69
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gPrN+4I2tpGvJAwL7+je9xVEGLj7f/2CyQulriHLvNWPeD73r8SwGaI7sLho2jf7C2mhgkBOXQZPyy1urKcdcU3txwnHH9NO8uhCckadCJ8g6oCeBoSxHgNsZ9Mf9RSERPw4oJiSnBiPjvQl5/3xWicyIPup4/e132BOZ91uRNChsOXHWov6RedfMfL9tbkXMVuWKNpNaK19+s3/ogE7xrQYVF4636jVbmTrsNgIs7zvuboMjFLnlAWAQmpiEc1eqA0u+hLe1QYEb7dhv04fOnoFoK3cfX+4qKlX/xqal9DXngiy6wTDK67s6Yu+KZkqpZIh/n/wOecDytORS2s6zefbjMyRbTKCYi2tJpHJmOcnI9tj1l/6JiESPtkhnfxWjHWkCsR3C8pwNKlv6GeG6CM6hvcQeCXnowUpZ3p481G95Ta4eUjtaKZt5Vx7ZpE6MEv2Y7HF/eo4Fyv846WLKQ03D+aBXDyGZq2VeEArvojC88aDIv6YTxFKGL/CaSBHxIVoFa3ttwYXRJ+bf36f8xKOV+yQv1tLCz5h01fHwmhmf4/lAylh/A6W40Bm0AyA7VPe//aAMmOcnyrLiWIVRjbuCo8EESS5rH19TuMjpBI/idgSv7e17BqyW+FWQTGSAP/wKPgECQ2/yFfH6b/wnDug5sYZrZvDwNbwQDqP/NcmvLfJ72X3P4HToFeTjqYa
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oysl8BxOn2rY0Dcm5/dZCQ0TAQ8cuvbA/qd0Voq8b4N7cZoTVAqDSZRWRjNE?=
 =?us-ascii?Q?2Hs0sSxRmSZRz4dQdGKSjosH2TZVGrgES50nembvk4rxXIKOuk/Kd5jqHCBD?=
 =?us-ascii?Q?PIHQJTbzg7nAFS08vKcGw3Jt3x9RPVrfIc8SxrYVp9qu7V2bz2H/ZdW0CrXg?=
 =?us-ascii?Q?TqHi4pl3v/zwrTzDnGD2NCSxTyr6YiDqRpbKo5fuyZbXFzimrYHzzahAyPym?=
 =?us-ascii?Q?XlPQfkq5Pyo+N4QVz/MPxraoAI0dg81654/vjDrxuY7PnLEwnzINctgdLYd/?=
 =?us-ascii?Q?Qx5iuPft3HVReHkFVsIddGPDL6DyNKRXfLainzdwwMu2mI91PunfjRjajRkC?=
 =?us-ascii?Q?sNKIVrr+Ew+GFhDjGaYUNCO+Ch94xDVZjjH/oW5RBA0OA6pu9Vq37+krL7el?=
 =?us-ascii?Q?3RQP/DKRDOnQ02a2ZoRig/uP8QPN8syXuu9rUNynmKMOMSoR8PZMHyYHGiEv?=
 =?us-ascii?Q?l2mihjgAdSYG2i5CRs/HQxbGJl3YFcnCToYa5CrnnS3C7O909Z72QUKhbGzo?=
 =?us-ascii?Q?rgYAq2W5CDKuUrnxNCuaU1DQoWAyVn7ihdUcKQTKynNopIwuQvWoqxC/so2q?=
 =?us-ascii?Q?f52jiePHNIEX7X9ZXXHu0XhCD8M+NysWBWu4q4zotFCyJZZ2gCSgjWfI6qpF?=
 =?us-ascii?Q?7laaB2hdakayGdSkF5EiJ53sAojEDfrdL9CpC3Gb9shCuthoLW4il9Lg6BFd?=
 =?us-ascii?Q?2AhcSq5qy17p4J5DmOr9WGU30XJISo7jjEsov+1kso9IDZmUAKO8AZryY000?=
 =?us-ascii?Q?TlEItRHp8Oi2E0GcO0bmEUfJvhTLAAq+UTU/OmZ+vp4J6q7RfG7hUVHCl4mW?=
 =?us-ascii?Q?Uuh924alCOPVmxSYiDYAW3dtJqq2iFwpKgMlNhNMyHt7KhvP5N7/oHOk4TXR?=
 =?us-ascii?Q?9XxOJNx2P0MH9cS7OmNnqurSZtwsrOaQCqho5/nN0pUZtRc2OICGQybtQ/vn?=
 =?us-ascii?Q?bEyOx4m1cHhILSbuJlSjtYStTA84JExDHJllzwCxfNm7alW/ijeiEHwXemZt?=
 =?us-ascii?Q?Pn13tlAjIEOSUAYaeywgFoFZFGLFVFs7C93QYg2WbS3yFtEDDTZAMC/YF6Nr?=
 =?us-ascii?Q?xZ6E13DeYLvdTJRQ2bjciWIXbIrLAIhAWfypk2VgBggeBH0Ew57Dfv2khfy+?=
 =?us-ascii?Q?H5JRTpp36JJgfk+MbsHn4o33gkNLtE/gPEIGvVECdLALpn3unbBvnLRGzLjh?=
 =?us-ascii?Q?EPPCYxYIBshxAN876N1X7q9gsg4PFKfUvKwyuEtd/Rmr0vmTa0JugWDfyBQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0647b671-9b50-47d2-6444-08dc5302ab69
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:50:11.3923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6964

Add DRM panel follower[1] to trigger suspend/resume due to TDDI nature,
TP need to follow panel power sequence.

[1]:
https://lore.kernel.org/all/20230727171750.633410-1-dianders@chromium.org

Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
---
 drivers/hid/hid-himax-83102j.c | 289 +++++++++++++++++++++++++++++++--
 drivers/hid/hid-himax-83102j.h |  10 ++
 2 files changed, 283 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-himax-83102j.c b/drivers/hid/hid-himax-83102j.c
index aa8d0b6677bb..0a2be071a6c4 100644
--- a/drivers/hid/hid-himax-83102j.c
+++ b/drivers/hid/hid-himax-83102j.c
@@ -8,6 +8,7 @@
 #include "hid-himax-83102j.h"
 
 static int himax_chip_init(struct himax_ts_data *ts);
+static int himax_platform_init(struct himax_ts_data *ts);
 static void himax_ts_work(struct himax_ts_data *ts);
 
 /**
@@ -1135,7 +1136,6 @@ static int himax_hid_probe(struct himax_ts_data *ts)
 
 	hid = ts->hid;
 	if (hid) {
-		dev_warn(ts->dev, "%s: hid device already exist!\n", __func__);
 		hid_destroy_device(hid);
 		hid = NULL;
 	}
@@ -1443,6 +1443,151 @@ static int himax_load_config(struct himax_ts_data *ts)
 	return -EINVAL;
 }
 
+/**
+ * himax_ap_notify_fw_suspend() - Notify the FW of AP suspend status
+ * @ts: Himax touch screen data
+ * @suspend: Suspend status, true for suspend, false for resume
+ *
+ * This function is used to notify the FW of AP suspend status. It will write
+ * the suspend status to the DSRAM and read the status back to check if the
+ * status is written successfully. If IC is powered off when suspend, this
+ * function will only be used when resume.
+ *
+ * Return: None
+ */
+static void himax_ap_notify_fw_suspend(struct himax_ts_data *ts, bool suspend)
+{
+	int ret;
+	u32 retry_cnt;
+	const u32 retry_limit = 10;
+	union himax_dword_data rdata, data;
+
+	if (suspend)
+		data.dword = cpu_to_le32(HIMAX_DSRAM_DATA_AP_NOTIFY_FW_SUSPEND);
+	else
+		data.dword = cpu_to_le32(HIMAX_DSRAM_DATA_AP_NOTIFY_FW_RESUME);
+
+	for (retry_cnt = 0; retry_cnt < retry_limit; retry_cnt++) {
+		ret = himax_mcu_register_write(ts, HIMAX_DSRAM_ADDR_AP_NOTIFY_FW_SUSPEND,
+					       data.byte, 4);
+		if (ret) {
+			dev_err(ts->dev, "%s: write suspend status failed!\n", __func__);
+			return;
+		}
+		usleep_range(1000, 1100);
+		ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_AP_NOTIFY_FW_SUSPEND,
+					      rdata.byte, 4);
+		if (ret) {
+			dev_err(ts->dev, "%s: read suspend status failed!\n", __func__);
+			return;
+		}
+
+		if (rdata.dword == data.dword)
+			break;
+	}
+}
+
+/**
+ * himax_resume_proc() - Chip resume procedure of touch screen
+ * @ts: Himax touch screen data
+ *
+ * This function is used to resume the touch screen. It will call the
+ * himax_ap_notify_fw_suspend() to notify the FW of AP resume status.
+ *
+ * Return: None
+ */
+static void himax_resume_proc(struct himax_ts_data *ts)
+{
+	himax_ap_notify_fw_suspend(ts, false);
+}
+
+/**
+ * himax_chip_suspend() - Suspend the touch screen
+ * @ts: Himax touch screen data
+ *
+ * This function is used to suspend the touch screen. It will disable the
+ * interrupt and set the reset pin to activate state. Remove the HID at
+ * the end, to prevent stuck finger when resume.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_chip_suspend(struct himax_ts_data *ts)
+{
+	himax_int_enable(ts, false);
+	gpiod_set_value(ts->pdata.gpiod_rst, 1);
+	himax_hid_remove(ts);
+
+	return 0;
+}
+
+/**
+ * himax_chip_resume() - Setup flags, I/O and resume
+ * @ts: Himax touch screen data
+ *
+ * This function is used to resume the touch screen. It will set the resume
+ * success flag to false, and disable reset pin. Then call the himax_resume_proc()
+ * to process detailed resume procedure.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_chip_resume(struct himax_ts_data *ts)
+{
+	gpiod_set_value(ts->pdata.gpiod_rst, 0);
+	himax_resume_proc(ts);
+	himax_hid_probe(ts);
+	himax_int_enable(ts, true);
+
+	return 0;
+}
+
+/**
+ * himax_suspend() - Suspend the touch screen
+ * @dev: Device structure
+ *
+ * Wrapper function for himax_chip_suspend() to be called by the PM or
+ * the DRM panel notifier.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_suspend(struct device *dev)
+{
+	struct himax_ts_data *ts = dev_get_drvdata(dev);
+
+	if (!ts->initialized) {
+		dev_err(ts->dev, "%s: init not ready, skip!\n", __func__);
+		return -ECANCELED;
+	}
+	himax_chip_suspend(ts);
+
+	return 0;
+}
+
+/**
+ * himax_resume() - Resume the touch screen
+ * @dev: Device structure
+ *
+ * Wrapper function for himax_chip_resume() to be called by the PM or
+ * the DRM panel notifier.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_resume(struct device *dev)
+{
+	int ret;
+	struct himax_ts_data *ts = dev_get_drvdata(dev);
+
+	if (!ts->initialized) {
+		if (himax_chip_init(ts))
+			return -ECANCELED;
+	}
+
+	ret = himax_chip_resume(ts);
+	if (ret < 0)
+		dev_err(ts->dev, "%s: resume failed!\n", __func__);
+
+	return ret;
+}
+
 /**
  * himax_chip_init() - Initialize the Himax touch screen
  * @ts: Himax touch screen data
@@ -1473,6 +1618,130 @@ static int himax_chip_init(struct himax_ts_data *ts)
 	return 0;
 }
 
+/**
+ * __himax_initial_power_up() - Initial power up of the Himax touch screen
+ * @ts: Himax touch screen data
+ *
+ * This function is used to perform the initial power up sequence of the Himax
+ * touch screen for DRM panel notifier.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int __himax_initial_power_up(struct himax_ts_data *ts)
+{
+	int ret;
+
+	ret = himax_platform_init(ts);
+	if (ret) {
+		dev_err(ts->dev, "%s: platform init failed\n", __func__);
+		return ret;
+	}
+
+	ret = hx83102j_chip_detect(ts);
+	if (ret) {
+		dev_err(ts->dev, "%s: IC detect failed\n", __func__);
+		return ret;
+	}
+
+	ret = himax_chip_init(ts);
+	if (ret) {
+		dev_err(ts->dev, "%s: chip init failed\n", __func__);
+		return ret;
+	}
+	ts->probe_finish = true;
+
+	return 0;
+}
+
+/**
+ * himax_panel_prepared() - Panel prepared callback
+ * @follower: DRM panel follower
+ *
+ * This function is called when the panel is prepared. It will call the
+ * __himax_initial_power_up() when the probe is not finished which means
+ * the first time driver start. Otherwise, it will call the himax_resume()
+ * to performed resume process.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_panel_prepared(struct drm_panel_follower *follower)
+{
+	struct himax_platform_data *pdata =
+		container_of(follower, struct himax_platform_data, panel_follower);
+	struct himax_ts_data *ts = container_of(pdata, struct himax_ts_data, pdata);
+
+	if (!ts->probe_finish)
+		return __himax_initial_power_up(ts);
+	else
+		return himax_resume(ts->dev);
+}
+
+/**
+ * himax_panel_unpreparing() - Panel unpreparing callback
+ * @follower: DRM panel follower
+ *
+ * This function is called when the panel is unpreparing. It will call the
+ * himax_suspend() to perform the suspend process.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_panel_unpreparing(struct drm_panel_follower *follower)
+{
+	struct himax_platform_data *pdata =
+		container_of(follower, struct himax_platform_data, panel_follower);
+	struct himax_ts_data *ts = container_of(pdata, struct himax_ts_data, pdata);
+
+	return himax_suspend(ts->dev);
+}
+
+/* Panel follower function table */
+static const struct drm_panel_follower_funcs himax_panel_follower_funcs = {
+	.panel_prepared = himax_panel_prepared,
+	.panel_unpreparing = himax_panel_unpreparing,
+};
+
+/**
+ * himax_register_panel_follower() - Register the panel follower
+ * @ts: Himax touch screen data
+ *
+ * This function is used to register the panel follower. It will set the
+ * pdata.is_panel_follower to true and register the panel follower.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_register_panel_follower(struct himax_ts_data *ts)
+{
+	struct device *dev = ts->dev;
+
+	ts->pdata.is_panel_follower = true;
+	ts->pdata.panel_follower.funcs = &himax_panel_follower_funcs;
+
+	if (device_can_wakeup(dev)) {
+		dev_warn(ts->dev, "Can't wakeup if following panel");
+		device_set_wakeup_capable(dev, false);
+	}
+
+	return drm_panel_add_follower(dev, &ts->pdata.panel_follower);
+}
+
+/**
+ * himax_initial_power_up() - Initial power up of the Himax touch screen
+ * @ts: Himax touch screen data
+ *
+ * This function checks if the device is a panel follower and calls
+ * himax_register_panel_follower() if it is. Otherwise, it calls
+ * __himax_initial_power_up().
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_initial_power_up(struct himax_ts_data *ts)
+{
+	if (drm_is_panel_follower(ts->dev))
+		return himax_register_panel_follower(ts);
+	else
+		return __himax_initial_power_up(ts);
+}
+
 /**
  * himax_platform_deinit() - Deinitialize the platform related settings
  * @ts: Pointer to the himax_ts_data structure
@@ -1588,25 +1857,13 @@ static int himax_spi_drv_probe(struct spi_device *spi)
 	ts->initialized = false;
 	ts->ic_boot_done = false;
 
-	ret = himax_platform_init(ts);
-	if (ret) {
-		dev_err(ts->dev, "%s: platform init failed\n", __func__);
-		return ret;
-	}
-
-	ret = hx83102j_chip_detect(ts);
+	ret = himax_initial_power_up(ts);
 	if (ret) {
-		dev_err(ts->dev, "%s: IC detect failed\n", __func__);
-		return ret;
+		dev_err(ts->dev, "%s: initial power up failed\n", __func__);
+		return -ENODEV;
 	}
 
-	ret = himax_chip_init(ts);
-	if (ret < 0)
-		return ret;
-	ts->probe_finish = true;
-
 	return ret;
-	himax_platform_deinit(ts);
 }
 
 /**
diff --git a/drivers/hid/hid-himax-83102j.h b/drivers/hid/hid-himax-83102j.h
index 1b8e8904e9ab..eef55c45b1d4 100644
--- a/drivers/hid/hid-himax-83102j.h
+++ b/drivers/hid/hid-himax-83102j.h
@@ -9,6 +9,7 @@
 #define __HID_HIMAX_83102J_H__
 // #define HX_PWR_CONFIG
 
+#include <drm/drm_panel.h>
 #include <linux/delay.h>
 #include <linux/hid.h>
 #include <linux/interrupt.h>
@@ -69,6 +70,11 @@
 #define HIMAX_AHB_CMD_INCR4				0x10
 #define HIMAX_AHB_CMD_INCR4_ADD_4_BYTE			0x01
 #define HIMAX_AHB_CMD_LEAVE_SAFE_MODE			0x0000
+/* DSRAM flag addresses */
+#define HIMAX_DSRAM_ADDR_AP_NOTIFY_FW_SUSPEND		0x10007fd0
+/* dsram flag data */
+#define HIMAX_DSRAM_DATA_AP_NOTIFY_FW_SUSPEND		0xa55aa55a
+#define HIMAX_DSRAM_DATA_AP_NOTIFY_FW_RESUME		0x00000000
 /* hx83102j-specific register/dsram flags/data */
 #define HIMAX_HX83102J_REG_ADDR_TCON_RST		0x80020004
 /* hardware register addresses */
@@ -219,11 +225,15 @@ struct himax_hid_desc {
 
 /**
  * struct himax_platform_data - Platform data holder
+ * @is_panel_follower: Is panel follower enabled
+ * @panel_follower: DRM panel follower
  * @gpiod_rst: GPIO reset
  *
  * This structure is used to hold the platform related data.
  */
 struct himax_platform_data {
+	bool is_panel_follower;
+	struct drm_panel_follower panel_follower;
 	struct gpio_desc *gpiod_rst;
 };
 
-- 
2.34.1


