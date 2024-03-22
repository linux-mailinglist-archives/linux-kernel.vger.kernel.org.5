Return-Path: <linux-kernel+bounces-111168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA3B8868A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454B02882C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ECE224EA;
	Fri, 22 Mar 2024 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="uR8iUj/J"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19011003.outbound.protection.outlook.com [52.103.64.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC319475;
	Fri, 22 Mar 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097813; cv=fail; b=H4OGVLMAT33D1nuUxBTj7IjKnn9QkxGh710vMAv4jHdMY2KtT3yJM+wtO+CEFHaD5qFNK1KOn89VmbhxlyaZOWcJK+hKwlUJUQjAznUMED7v90PwGc/3clF/40/kfrcMFhm2ARPVeleoFMGqiFm8B5fhk/mve9cBM1sHbsvBunU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097813; c=relaxed/simple;
	bh=CE9rJ6YqiZIptrf0u8T9LOLW+ImUjKp8wbTlBvnPwUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nmWWM1U7/9uHYzSHAqAN+5vgrEgkRlTEwzQh1d/O17ck7kWEi/UUR2338Hy3brSgsiEHSbrhcwZcbvhsXmj+p38nT9Cxga0tKm81XjYIGLts1d5cNhUMl0opVkRNzBCZjSqLc5RIUgKpI6sH+vphnYVBPQR5qs4mwzrgijnd+3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=uR8iUj/J; arc=fail smtp.client-ip=52.103.64.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuIuQp/xVdNn9BoSpI4i8E1dCL/mTJAgZaMfRkER0XUXBVbcej7CrP4gr4gD6IHzohrXezsQaT1HpxzGRHf4iI4+JtYbxZfwW+Sa0EeyRcEAon2cvCm5jLYb6ZgT+Cd7JelWaWcolHAVyyoWqt8QQFuctmySzbUoQDoP5WepFgq7YxZx/5IzK5KnxuRTW7L9UnTk983op8WZ1WAmOH9CKLkUDioDjrnK7eeC+7nK6X5kDVp7A9eiKFSQVb8PSVWLWOG1MN84UST4BHxL+hn9E5qvoTbwNNLrfVXujZLfI7Qw3ccpmpp0ClskiCPX1jQEXYvF2eJbHZJUbtAr/gR5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQJyGZPwRlVI7ReqM3YuMwvJE6Hi08CgUoAmyBY8io8=;
 b=glpXo5H2YRQEKtGv1da8ro9VRGcTDjauWbojnkoSgOxp8mnt2wtLfxeZcxF4kjLArZZm0fve92QBo/vetJcE2ihT4jvrQVNR8xzqdSzp1ggTDSG0rU6IIMHI/8HSQStxa2Ma1yx3JNEYDkU1GALqo/HL1N3PrzaqiCGTKjtgLRAFC4tQslmMxKp9ZorDYoeftDpx/s5vRv+6Jt/TAet1rMLOU7rI1F+QqTJm9Iie+8nHMuZPEEpkMrxE6l8xw68nEbcadyNrtqo35i+8YmArvaFj7Snehv7jhfzGGNF52Wig/IV3FL/psiOrK0WIPmCA+Yq3WQ436nAxcyehSpKarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQJyGZPwRlVI7ReqM3YuMwvJE6Hi08CgUoAmyBY8io8=;
 b=uR8iUj/JsumLj7j59GYVwdXzyqBB4v00HgfilOl222iL2vMpIoKLVji3vHf/ctkqKo5DfIZQQOCVxFCEJt/rACSlGE7Z9XvPXZ3YSs104xe8Xxq86WTFJoECfUsw+87b3PO27gCCsPN5bXp0XULFjdx9Io06CcF3Qwn7nN+b8KHuuQTiqGLAUvk+WYEf1HDmOzRXQpVdfKfB/cI/9AZ/C8BhDpy1jqSnuLzcZxDVscr2jqdgQboRX5rNMiFhaTQZHlT6bECPYN0SY8XPbFQF1qtmJT38Ti0usQ77f0oUvCQDfv/GCuL6ILXW6jmSMPbxJ1ChrhLrQ6+6qEzfLfDo9Q==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by TY0PR06MB5260.apcprd06.prod.outlook.com (2603:1096:400:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Fri, 22 Mar
 2024 08:56:46 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 08:56:46 +0000
From: Allen_Lin <allencl_lin@hotmail.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v1 3/4] HID: Add DRM panel follower function
Date: Fri, 22 Mar 2024 16:56:05 +0800
Message-ID:
 <TY0PR06MB561151065B3018C6DE31C8EA9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322085606.993896-1-allencl_lin@hotmail.com>
References: <20240322085606.993896-1-allencl_lin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [EJAPc8YsSsO0zB9r2jlTOerjgtiCdYtS]
X-ClientProxiedBy: PS2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:300:59::28) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <20240322085606.993896-4-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|TY0PR06MB5260:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b2ff34-cbda-47d0-d436-08dc4a4e00d7
X-MS-Exchange-SLBlob-MailProps:
	Z68gl6A5j2+di5YwL2kzS6NfVWp1s0uFP9NBuG4Kj4rQ3Vc1iWcsKDH+zFSrdhu5NQ9PlyjeJsR0QtNoHE2cMN0BEJ1p/mzcY0l4IOGhvinii6/DMI0Y5xEt2+pIRD2u8RD6UhmuCQucmtwemGHhOTWrXJRdhOifO7VVmiyxQjompUGvS0UEvWx0QNRFcbVBuRCNoP7JThiAMb/cSiDlsHgYb3b/pUIMWbL6ixG9nqySnyozDfLt/HMGKaYo+Bp2XFGxomk+C1pAb112YjmdwiaCxxEiBD7zjtgtYOlGcT6yA8VxmBCNCagCKUdy5jR70/K9VOvdzL5l7CG75bNIuVbFJ4NPBUEPOj4RFc2InnNWyW40qlKHKQbZS10hViSCP+8AW9KXt25KEu7aAyPCreHyzxRsY6DvLbi18WsSuv4qtiZHSeIUmDMmzldvRtAl16niJj9eoHGN+3fp57k/dgTVuo/3nZ0Rv62Yg7dAQ6bLOtV2FfxPvyuXZM5ZFexJVhf8dxgtGBxrB5WDfdYx5hItSKwqaty0pcgwPdBAVtrzNUIqG3CqNbJrm+EMtzL4sSSff3cxqxzi+xcy/HuUszPaF1tdO6BUNyz04KMa662jzVG0i2VECCu8vBI1AjaUJ8veTjsaUOPkJwezzlvyhrDMdFjqCoMpDpRTlPdLPd9tp1N6xbPKFmFVuRQiFHQ1EeQoBlwuBPe+JaGIE+YkkIpRDwCCD336mNt4R5ZUW9m1NkGu5/WhMzjVUEs93ddIvFANeFM8f0gssgAim9M8RpMF+TF0Op4DO5lf9eklq2dHv5QaU0CqHOL1owsoOaN0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	leKgKzZnLNV7kubZL84MCd2x2PpYgZKbdtTdoXC0GMyiIN6jOJ3tXttIa+X4fNHVBdjzZDvTaCybBSR1cTuInAovRpP9/YIu/qAc9Gvlhp7wn81A50c6wp7TjezhpV/yBIWc3dTkZwMKmMG0Lj+vFDv5ylcA0Qb09qCNbrOyiDv0R2uMRshaYPl1e+myP8myGrw/ORby1ljIVCdESNWW+8NtRN5Fyl0OUQuMZbI7VkOM2WXfc4xqBaZXVcRGQLpAEgMCzluE/GkRjSU7v2PfWx4P7Jp7owWN9JnCnUmsHL7embX1+A4H7SBogMZPrDlgRT/iYB/IB002rwN6jDXT59sTqRBBp1Ys7372zvifXHHvgoqf0QVrkC+zxOVaMJ6EBfJnYDqxInbap84ldVWE1K93tWaYnkYMa2YCwdO6ObUFn2xYycy6z4q1NtCeT5rljf6EQNi2Zkf9MePKtsokUqh2m0wGMhP9LYjNV/97Kzytj+lGPlObqSKrEpYtRMeqTe/KGlJoIA9DoFcsTOslrWBpPytHjcQRzZqFhylfkvOZf7ECmdvkxwCNmfahZWOKEVe+fhxSp9S5yjD1eKcglUSg3j3y5TeIhuvvajtfI0A9knef2ADSQDKKjMM4Q6wgwSg/W2yshaZfiWjc+Ko+NDrarvMQ6QjKhmQUa98xto1+fgAz+xpzkN9r3rt8C3Bu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o+1ae4ojM0XojORDwF0JqUIoHg1Zh+o3Zz7PZuRzVh/eyEuTwtbFhyeMMWSb?=
 =?us-ascii?Q?hwQ9Nbm1oYWGFcT1oPAAFAKaNJsddk3NvqNSpZr1B4vZL0BLMX+7BO73GljX?=
 =?us-ascii?Q?vgAX/k0ngvaqqMlGG/kO/libY5wpCfK9o4NB3LUrtzsbZaeKiTKtkAEfdDBc?=
 =?us-ascii?Q?Fg7/o431TbTfH+e+xGs8m6AmJAr8VNu3O5zp6qcKqfId7ANlAoIP392XqKQ3?=
 =?us-ascii?Q?k3FFGV0UcIUw+iyO9tf52c78XUQ/FCK/ELTd5cfb/8qzR/NHoiTCyK5bzQjJ?=
 =?us-ascii?Q?IahaQZhhXBUSa8ykm12z79JSDac2Js374IAGcugJL+tzNuGn/V0djZV5zep6?=
 =?us-ascii?Q?npWM/9gQn3KC1opDUfyHpY1kj+qDz+0Dt456wGd0xmrhDpNVChXSiMZZ3FL4?=
 =?us-ascii?Q?rJh6855+EgPcXv1F4ToPju+9A7lHvRzkmgBKQwpeKL22E5PPBasqky3M50St?=
 =?us-ascii?Q?1OD6BwUO7VLLxUDOwsrdVfIZ1nxBJdIdShJREieDOTfGKpklF12C6/Ar5u7J?=
 =?us-ascii?Q?vbH5UKHnWeYrqGkzDT4PpA8doj5RpeFvKHQvOaTNQta9ceIxTD5FEIeCcXoL?=
 =?us-ascii?Q?Z7257mCjFEWSzJVEQBGl97E69LLQdFFjUVLpLn7lSoJVQ+OvnW+IaZK3y+pJ?=
 =?us-ascii?Q?GA6noaK+qKAjGrf5Vf3ao15Yx9XGqO2eH5ujTTEBMatrewVEwruV/roUoxoE?=
 =?us-ascii?Q?yCDl7S2tDMolDQMI10LoHkmPvolrx70WT800VS7VpnV658ke6AusvpStdnIX?=
 =?us-ascii?Q?OcpLL/5sokTwPj+dmh6NmHwHTIrgNJqSSW7NZKfOxd9d6CXYkWMcEefVh4Sc?=
 =?us-ascii?Q?zYYt5AX66CwuOYj7CCu/oZbnnL1s4HZqhngpLfIRoLjBlvsUYvDF0jzdVhTT?=
 =?us-ascii?Q?+Vf0MDvlKRtHvi5KnxFgpz326nDAvseELCyb7lqF2OkZQkBoQkuC5No8d2hw?=
 =?us-ascii?Q?yNSWIQl4LfMCs3scbc/4V/UxeJWLh/CatD/EfA/1Yf735ba7HLu6oVTswQFD?=
 =?us-ascii?Q?xdRBZLY8B7xnHR3wgPrD0r3B5CnwOuzQP8gFIYqkgfirpMXK4ZgSmHQohM57?=
 =?us-ascii?Q?ONC7gldtK4Eqa1qxxgzBqeN59OKg3iHlVhEICsJr3g4W4PvXsm6f4Bq0p3yP?=
 =?us-ascii?Q?8SPd15hX2eQ8vTpitbg0kyvN6dkOLJ6OUTWY6lJMZ2z5khpbuKL4PmO4zrmY?=
 =?us-ascii?Q?FMbrrscJbSBUfVAzSaSdmTL8J71j0IM1BOfn29V70Q1XYlcjOEC8CDjW5s8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-f764d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b2ff34-cbda-47d0-d436-08dc4a4e00d7
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 08:56:46.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5260

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


