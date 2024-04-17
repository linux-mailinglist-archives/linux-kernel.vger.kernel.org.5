Return-Path: <linux-kernel+bounces-148071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F4A8A7D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FEA283736
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987156F072;
	Wed, 17 Apr 2024 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Bgc7xZQX"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2107.outbound.protection.outlook.com [40.92.53.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAEF6EB44;
	Wed, 17 Apr 2024 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339739; cv=fail; b=joicv2j9AmhqjYo2Xm1hAqLz7c5kSv3ie9w4LSIKqOeRqHbqdflJi/emIT3NOKQwmWvM8wgPL3qNYiOdTgi21BbirIDSJVrM75OAm6W0HBsJwM7iKYXEA3Q6IV9drvO4dLDHhdtdxpl+QUKj6NMIYRJ91BP2PRPw+PezpedxSoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339739; c=relaxed/simple;
	bh=NHXiNIS4SV+N3FIj8fzVb2/lualN7izIdYHoiES3N18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ht8v/gWDtHpqamlUDiPzlv5uDFjp010uBvnyJ4M6jHH/9RgFMuZN89xQYNQeoUNt3KmmGYu24vVhbfyTbHiKLHr9xAj16AqkkIBtg3wrHNTwfZxurlwld2iiiTXMNPuhu9OTPeC+Gs/paRqiHJNshbmb5Y4/rw4RGMBoJYWX8lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Bgc7xZQX; arc=fail smtp.client-ip=40.92.53.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vp3v4a7Whymavis6HCmrt8uT6q7PkoZAkSjp6dMPseryTl0nYt5nIKHvYj6iRT5WitFmJqRwiXVbUpbitY2V8RFdgYelbsT1LHaE8vdmdyTX4xWmLUPS8YvJYjTH7Xzeozz/sm1pUWhiwFmTtyixwkOcQU9iAAf4HEWRPL/985jEc/R3VifOLCeIcuwUlP35s4mzSiAphCBTsAaPc6/s+3OasxgN0ha57GSigvlZOd6daf1DW4qS+HAFbq0I/lkLMxfxbsG0pEHHSUBhonW2y667fbMUgEtrXKqNYrLj/W0VgFcMdhr0Hs24is5QIESMwmWiscMDuDudks88GzIY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCOj7uV9ms03Ow1RoUlRpVuhMHp2LsgloqSeKq63ceQ=;
 b=bh1q6WTP7KbGyJnz+qDY6xBmhBPpXaujrADQdWPAyd6KgH6mVlcPbe8TvI7pu3H41o5dwOHBc/m9Equm01+ye2tZ9mLrKEwakf9Ee/zQT2MiS2DTBfGgCAe4fPn68NTT7oERDRjkpocxKq90jqPlpt0SHU4w5p91X3d5usRriCJnNwRtXKmGXXVY/JZoSfTZWkMbGNA4vTduHMteIAwhcPZxHUjT5M6XTy2JigihLFnRWpKnibUPoQyrP1IbDiPb/+bsWsITnGj4MFtA4CY39TLZSkvCTXXAqB35TT6Rz8OKROtaKbUZv4W0J3TJy56vM7gJZamU7C5y3yn+QxG5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCOj7uV9ms03Ow1RoUlRpVuhMHp2LsgloqSeKq63ceQ=;
 b=Bgc7xZQX9OeHVWKPcZ3tc99pux4nCyPlbEE1FMcMpr1jO4QQt92CgQgcHqKP6vvtXMX3BQEUoF6LbMDTBNFNl6fHkFHBXQ8dDHqNNTGYGnbEwKd8dATXmSTVjWUp1bi5PHxYWNcC3VFzfy25SEgVbMoP8xJGPsbQ6P7NDZBaOXvV0wW5b1AwPOL7dGlZAYgUdWgHrjvyKNeT9uJGhqg96eZs38K+f9Cc0LYJk4KJonLWV570zSFGCRj9ongyCmvAEdkWOURPnSLPbm0pMFStGdJBf5F9vCRAv2t4mc3MYjVI0LAefdq0yP5w06Dl+AsKeCtinFfBTzX/lbf4gtZ8sg==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by JH0PR06MB7296.apcprd06.prod.outlook.com (2603:1096:990:a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 07:42:12 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 07:42:11 +0000
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
Subject: [PATCH v4 3/4] HID: Add DRM panel follower function
Date: Wed, 17 Apr 2024 15:41:14 +0800
Message-ID:
 <TY0PR06MB56111848DF06B1CB3B4EEEBE9E0F2@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417074115.1137885-1-allencl_lin@hotmail.com>
References: <20240417074115.1137885-1-allencl_lin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [BFJ81qA57iV4sqiUC1LdV2Coo/jOQPQY]
X-ClientProxiedBy: PU1PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::28) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <20240417074115.1137885-4-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|JH0PR06MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: cd390fb6-6cbe-4e79-a60b-08dc5eb1e47b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o2r5vmDptqYQ+ZKgzhI2RXk2+Uqa5StD7D+DkBtRgVtSTPpRQSLjguDKlE6YJXfrb51TA28kJuheLPOHGWzX+iO0FOYpqsNK/CYBa+bzXyV/LYguaeRuM7/0zA1x9stH2bZ5yvMP/n7suACnNtRm9sc6HK3uRjUaSIkvooVNOJjL4nrSAQXoGqbWKsZKqH3qcfLRNU839mltnoT4rmqFMma7w6M9IVp5Srz1ae3a0yIwiFyTBHwu+Een/i6G4Q1rrAsQ71rIL2XrB9QAcHccjJeaCdzswBPcGTT/tedkgF/kC6H6UiQqCiuFlX88cBjsMEB5xdJChBGRJoskn4TaInJWxOCwN+NtyM6I/N8Jix8hxsYrn8iBpVE2WuEjYDa3nxjNg6dm6cwRrlHxRphWmGXIUins8mcUB7g6wnHJUCTpbFIfLV6RLuH8Baz44usne3jMKlyxu+6jOWjSngQmK6VLBA3R4pFubed3hff8ll2p9Z24GRwJNoCrfCw/vxcrUiPMyAnUGuO4jeoqpyTNMfe95l8c7rbyhbhLIKzvZnODtYtsshs49m7R1QMRb+2bv8t9gXdpT8iqzDRX3+8TztbvApofufivYjnqMaSiOS1G9k1OXgVro5p+c7S0IHesnEaQLbGkKVt2uW438HVVCMUl+8A+40NrvGBzdaaeT28R+7HfOyzmenaUKVeXQ+G9GmF1LLTuDWMp4uVWyNhs/cIby77W8NAZaC8TmalWiNJ07XiaRvMWui8TKlDLY00s
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TKdvszq/aB8MWQIQXDDQn170QFO+WmQNjbpTncE/bgkihWayHulEV5ZYig48?=
 =?us-ascii?Q?NtxkCv4U7DQoFm3oDAZ3X0CBiJ80Ci58c5GuKm6WxNWCT3vrb2rI5JKEx6nr?=
 =?us-ascii?Q?+bg5Ey5FxzIfdz5GUv2uouxPpNAQIF7aGrhrk4fBFQO1G1AS5cmMRMaHQS7z?=
 =?us-ascii?Q?c4AA4tdmiS56hUsc250owS0rRl5Q+N3YVhSI+tK3jkMGR2osPCaAu4SFGGnt?=
 =?us-ascii?Q?gioNKAWM5+t1IvjA84vWRywYSh151fP4M6XtW2AdZas1WyvYnsMyYUTDLLSJ?=
 =?us-ascii?Q?gYWuoBz9eIzzOuYXW9s055ghkIgH5mz0sNFxZC5Sgb8R4Cw3ubxzASOjPopT?=
 =?us-ascii?Q?bA3v9Jz6iZnAoXtChTSwbAZ7t25DAMXoFL9jD5d3AoK2h90Bm8IYaBO47ecM?=
 =?us-ascii?Q?k7x54g67W/A++UjoXp/ewbRbwNEisKAKbGvN1vpDOaEpwYl4UQ//mKo9zxHP?=
 =?us-ascii?Q?UebBRXf/UmEOSi/Sn14cJx1p1rI5hyVVDiQJPnmmClbFyqAV4UbXdRaTOWFR?=
 =?us-ascii?Q?Hm3pcWZxFOpec/5cXoWYQ68DWsmGlPHtSztmNYPoiBdxloY4C89txXs0XnqX?=
 =?us-ascii?Q?Ue/d6EtyeSJhqAut9eq/8KK703xT+mCQt87aZsOMSs+sPZ1YnTwPZnac1VLO?=
 =?us-ascii?Q?4dBN6VTPgxrDi2Op+jbDop1iCgkwGx6l1x6C0tr6bjwG/02Q5qJx6dIqVS6d?=
 =?us-ascii?Q?E+rdfSSty1FIL8GLKH6HTvLnEJBKN1OkjWNnWUNcvH30+CWYqAfVNbVIJzAg?=
 =?us-ascii?Q?3GMT5kv8PN/P52DTQOPto4XCY/sML7TWhy7MmZR6SKG9F/ZOsG0SyDgHE2FT?=
 =?us-ascii?Q?zRzv2VBTRLZKJ/dRw36LaPZQ5rRft7PE4zhmghYGTLLDxinswXEQEG1u9DGc?=
 =?us-ascii?Q?okA58b/TAG2RspZG5AnEUDDd7zOciQWoD7A8I1V1gxJ63e0EqwxyOshC91Di?=
 =?us-ascii?Q?UP2x4ssmFWYJ/xk4W9FK6sA5YxUGi0CH8Kv/v1tMVm+bH5yi8yJDyLFdh71n?=
 =?us-ascii?Q?Xjm7zGd+C3UidL0JGxTfg6+K/doA9XmrZA/fQmJWzTFf7YI2Dx+ME3cqpLUy?=
 =?us-ascii?Q?UOFsZBE1yBqnikcJ5Y9jZPIgOSkHob5YeSWqBqAA/xZWZ6Luw/5QouyNRJEP?=
 =?us-ascii?Q?0507JjaZsmSUJC4EuQN7bmD5tmSpELuNlhKyHh/BA6yKxd8/fgkZ0MwaZ5G2?=
 =?us-ascii?Q?ypmESFC8VIPwxPOKAf3EOSjQPKFhKwy8sSewOShv8U2xCzzWk3Q/c77Omg0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cd390fb6-6cbe-4e79-a60b-08dc5eb1e47b
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 07:42:11.8451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7296

Add DRM panel follower[1] to trigger suspend/resume due to TDDI nature,
TP need to follow panel power sequence.

[1]:
https://lore.kernel.org/all/20230727171750.633410-1-dianders@chromium.org

Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
---
 drivers/hid/hid-himax.c | 292 +++++++++++++++++++++++++++++++++++++---
 drivers/hid/hid-himax.h |  10 ++
 2 files changed, 286 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-himax.c b/drivers/hid/hid-himax.c
index f8a417e07f0c..7b0ee48acfae 100644
--- a/drivers/hid/hid-himax.c
+++ b/drivers/hid/hid-himax.c
@@ -8,6 +8,7 @@
 #include "hid-himax.h"
 
 static int himax_chip_init(struct himax_ts_data *ts);
+static int himax_platform_init(struct himax_ts_data *ts);
 static void himax_ts_work(struct himax_ts_data *ts);
 
 /**
@@ -1145,7 +1146,6 @@ static int himax_hid_probe(struct himax_ts_data *ts)
 
 	hid = ts->hid;
 	if (hid) {
-		dev_warn(ts->dev, "%s: hid device already exist!\n", __func__);
 		hid_destroy_device(hid);
 		hid = NULL;
 	}
@@ -1501,6 +1501,154 @@ static int himax_load_config(struct himax_ts_data *ts)
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
+					       rdata.byte, 4);
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
+	himax_power_set(ts, false);
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
+	if (himax_power_set(ts, true))
+		return -EIO;
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
@@ -1531,6 +1679,130 @@ static int himax_chip_init(struct himax_ts_data *ts)
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
@@ -1660,25 +1932,13 @@ static int himax_spi_drv_probe(struct spi_device *spi)
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
diff --git a/drivers/hid/hid-himax.h b/drivers/hid/hid-himax.h
index 26b47be49714..45dc3e6283ae 100644
--- a/drivers/hid/hid-himax.h
+++ b/drivers/hid/hid-himax.h
@@ -8,6 +8,7 @@
 #ifndef __HID_HIMAX_83102J_H__
 #define __HID_HIMAX_83102J_H__
 
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
@@ -219,13 +225,17 @@ struct himax_hid_desc {
 
 /**
  * struct himax_platform_data - Platform data holder
+ * @is_panel_follower: Is panel follower enabled
  * @vccd_supply: VCCD supply
+ * @panel_follower: DRM panel follower
  * @gpiod_rst: GPIO reset
  *
  * This structure is used to hold the platform related data.
  */
 struct himax_platform_data {
+	bool is_panel_follower;
 	struct regulator *vccd_supply;
+	struct drm_panel_follower panel_follower;
 	struct gpio_desc *gpiod_rst;
 };
 
-- 
2.34.1


