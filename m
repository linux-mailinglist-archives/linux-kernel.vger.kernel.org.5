Return-Path: <linux-kernel+bounces-95377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB57E874CFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E3B2837FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E1C128390;
	Thu,  7 Mar 2024 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="GRD4P3uW"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2118.outbound.protection.outlook.com [40.107.14.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57679126F3E;
	Thu,  7 Mar 2024 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809658; cv=fail; b=RzVLVg5r+ClWfgQdkNElAsSU7mz7rnL+iNRnIbpO9ddZ8ZMp692N0w4In2s+1vnaAoyWwmMKnUOs7JvujwmNXDiizAZBm4CA5Nzumg2urqISQm/hZ6Y/ZcnCNPx75MsLV+EawlN36/QxVeTmXkVzu5O+MLqiUDne5R9yWBFSj3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809658; c=relaxed/simple;
	bh=1yDZ4C+7wuAF4x1/Dy1IbDFKfZNKuDpc1YmpvUUxPqY=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=o9dFCbGZXUG5QPsmFL5bTI1wfwUqqPi8WCETSgy7XxVX8+306IO8q+ClScFkcxjPUVV5XJnpzm7IFFNYnnbnKOUQwo0GH6w+ngqPLxlGmlZVNGHneIbhd+mHAU/vzHyaL3nykkH0beKbnCzKIItWGJgTshabVerlzZyEflqKDN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=GRD4P3uW; arc=fail smtp.client-ip=40.107.14.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVo7NPYiaJ/tZd5nh8fRFBgwOuSuPW8osXSxqvsPq1cm+Td5XwPVScyKghLibLF1OGU6L1fhBlZkiu2g/8aHhEGYFbymlMhwmeNXwkHYchPP4mH1jMo2Dgm7A2X5MSjspKOCx3h10+Gp8V8AzB///LTHwtFg5Dli97BctE3gATff8oBIhhHQ9cGbjIttSM0sVsXbkfInxu4GPxEt+xqoKhba9i35fKHF2qKh4sZES3SERBoXFsmsUaj4QD20j6hQZHLL0hx4nuxKHE9EiT7ULup1yAQv9rpsiH2Rk21St3HVDdvE3BJSOBk+fcI9owtyxsxCSTcFCdKQF23iaqrCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFf+yuUu3Sr7kpoNItzUY7Z35fSz8Du0K/MnmuHsRqs=;
 b=OAwyP+xrSOoQM+f2c6zyLH2KgWO1om32mBi2Ice5M70LY/vJzU5Ub/YMC6IgkYTGLOePiGFz3c2IJhpanpA67G0BvT8QOYu1EOfppSp/Py+XURReE7pzHRKZFx0b/PEP0FtRJYFMzuj5fL4upYaVTd5L3wpp3DiOWdnpfW3udfcbSxm3cxN6CkH2JSucyU/wROlN7+Y7PYSilcPMF+FF79X1BlOjYtBn3yooMBQnR/VFawDcGakyIUBs9k/uRv9czkivnbCyJjbxU8uO5eXoEZ4rX3B0UrmkfJJYjlmDUHPNEXGebL6xq+ZiuGc2XBEPra+RHa25pv/EzyoFdDfQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFf+yuUu3Sr7kpoNItzUY7Z35fSz8Du0K/MnmuHsRqs=;
 b=GRD4P3uWWAQPAbE9LT9KcyDR6u0Ntr25JVFU73qrkBGgG3A9qcHA8st8ULEFPwlwpXCk3jCmFYR5d92Hu+BqbNv5bT7SSoCUbOZdRHBX80/wQ9ls9VYQnfy5/XafdR9riIielcwcs0XNxEV+9s+hf8AOKpsAvLfK8unKOoA+eF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU0PR04MB9298.eurprd04.prod.outlook.com (2603:10a6:10:355::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 7 Mar
 2024 11:07:32 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%4]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 11:07:32 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 07 Mar 2024 12:06:58 +0100
Subject: [PATCH] hwmon: (amc6821) add of_match table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-amc6821-of-match-v1-1-5f40464a3110@solid-run.com>
X-B4-Tracking: v=1; b=H4sIANGf6WUC/x3MQQqAIBBA0avIrBtQJyq6SrQwG2sWZWhEEN09a
 fkW/z+QOQln6NUDiS/JEvcCUynwq9sXRpmLwWpba9Itus03nTUYA27u9CsSE+kuTMEQQcmOxEH
 ufzmM7/sBwgeMl2IAAAA=
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, linux-hwmon@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU0PR04MB9298:EE_
X-MS-Office365-Filtering-Correlation-Id: f34b0e5f-f7c7-4606-58dd-08dc3e96c958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fRX6GUnmAzwyO+4mGGpDMEmyU2eluP5gSusYr3oIf13/5EOAwil/SKZxOaxttF5o4sMiN8jpC3ssSzXGmOVO2GQxDTVABAwvmzm4fjZ6YdLxmPXYwZh2xRoRMondvagcgWQrzgfy1+D8kJPvZ3lJ/h4/dJnP3YmI+1n5CV0yHEt/txg1bsGm4FtoSt+9mSUEeYmRIdRZrqRdXkPRRDSUU5fdTbrGx+7HYq175yG4lKBPNBs/jSpO+mT8e083xx3emhSrawEJ+MSiyRnGYTwlHzofADBQ3WOx55U+0803qb24R2bElBNP/NwuewZs1ulqeP21eS+7/ltj66AsISoLiW5EBvzo1+/ezHiEMsf8xD5xnoOA4zOnJ6zoFjZygU20LmJn1uyoTHQX4UW+2vWVoWZIf8Hax3zNNfx9uxt6t7ERlMXJymHoBVWeat8ST8jU+y+wO7OzvzeZcMs7T1fN64JSsP6G8g+PqCvcWv7oSLB+nvFm9VZlF6Y7hCQs/x1m3JfW6/NJJDZzvHNd3xwMyQSmHbmMXAVopei/hayMdk1uAX/zl7tc8pgAjPgcyWwMdJkiRXUv1jihWWRSp4cSjQXoC8Lfb/1oVFVD9hOOxZLN3FazQjC/E23qdiWOaX9rdtB8mL62cLWVZN+XDGl2v4+LA1aTTb4tGC2ig9h01LfoC0skrFrsPIN5R+AHIGlV9FS4LpSGOa+tR7ABOk/v/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGFVb0tjcnd6ZUd3dFJiTlhSZURCSGhhTUZ6ZjVpeXVFZlZFekNvbUFkWExt?=
 =?utf-8?B?aU5WT1pTN0dkME1WMVlYRmJoZ040MFF1KzltaWcvTHFZWnJQV2VUcDRyQ3Bw?=
 =?utf-8?B?NVo3UVVFdXp0MGsxemtMQnhHaEpKMEkvTkJBeStxU3Q0OGxiR1N5VUlyT0hL?=
 =?utf-8?B?eHg0QmFzRy9uOXBOVkFhRitLU2hCY0Z2eEZFcWcycjByQ3NDOXh6MVYwQ1gr?=
 =?utf-8?B?MzFrNjFlVEk0SGlKTXdzRHBSTUJxS3dyRGlKZkhybnJQcHZlSzQvRy9ZZ1Uz?=
 =?utf-8?B?ZlBPSG85TW80RXpPUXp5MVUwQlpBejFkTVdwNithOW1ObjNlckRISkcvanI4?=
 =?utf-8?B?RHpYdUtMTDBPK0NWVkZUeks0RXc4dU9sYW8yMDF2WGQzVTB4eFZJaTdZbEIr?=
 =?utf-8?B?TVZrK21vVGpuMmM3NmRIb1p5ektZU1pOSXJ1elRiTVQvUGc0YStTRmJZekNn?=
 =?utf-8?B?OFlZSEY5REViaWxmdTExUU41b0JCZHY3YmtvN2s4ZWo0ektnVGQwK29FdDRY?=
 =?utf-8?B?bk1oY3dIVW9acXB5d3BmUEVxdjFqaHJ0QUZtQy9Mdm53YUdKWktaYnNYKzkz?=
 =?utf-8?B?Z1NFbTFhZkpmRWhSbUlWQzlyREh1RndKNE1qdnprQXFWRmpjWDQwczVYdElO?=
 =?utf-8?B?M0JPWjZ5cE9WeHpJeUhaYlpxWm9NUU1BY3JWWnpDUlorWnhjSnhXcWFST2Ex?=
 =?utf-8?B?ajViamdWZTdkVHdhdmY4Mnk3b056SHNjc0hGd2FBaWNxWHNRTmhVUUlpTVlG?=
 =?utf-8?B?bmcrWEhiZTRPRUNMQ2hFNC9yV25aSndGNk42Wk8xWGtUWXg1eUc5UVFBVzlC?=
 =?utf-8?B?amluYkRncWdkangxVERuaWxuTUUxbnJ5a3ovWWpLNlFDNnl5R1J3RFRydzBK?=
 =?utf-8?B?ZkVyZmc3ODVHUG9wcTdXUGtuUXJ0dDBuKzBQdG9NK1FxeXNCSWJoTWNjQThD?=
 =?utf-8?B?cUtwMmJ6bW9VSjJ3RDM5WWl5RjBjbjNuc0lNVThlbThwM2huZnNXUkJhZXR1?=
 =?utf-8?B?ODY2RHVtUnJTSGhmMU9WQVFYdTNaNjlGelNjSWJ3VW1uS3kwQ0JJV3RERGFF?=
 =?utf-8?B?K3VheGNNQzBiTDBvMmNVODNDR2ZQVG9qSW9veEVrUmFlZnFjdEoyM3NMY0tq?=
 =?utf-8?B?dDNMQ1hUSHBlRnhKRDRvcG03OGF4WnVIM0xzL0ZCQ3puc0NudWdJczB1STRY?=
 =?utf-8?B?WE5PeDhUK3VWa1hUN2pyNk9Dcno3V0dNOVZRN01DblBsczl5ZStOQXBrdm5S?=
 =?utf-8?B?L09ocFlhcFE4YkhGQ0hUZ05qbnA2bklSVSsxeTJCNmZGQVZJbnk1eUU1RUY1?=
 =?utf-8?B?dHZtVzhsOTlQaUpnYjE4S2ZOcFV6djR0a0JrTlNJRXFuN1g0T1Y4UzVPckRi?=
 =?utf-8?B?RGpFN1k3Njdra1FtNFRFQXI0aXNkdmkvMCthOGpQeHRidHpQQ2dJcmVya0VH?=
 =?utf-8?B?cmxmc3B2QVRVVThFRUtXMSs4NGV4ckpOSDV3ZTNyLzl2RnN1b0RRNGh2b0xl?=
 =?utf-8?B?azlnakY0WFNHVXB2VVJiY28wa3UvVnhkaTB5TXNSSXFqVkZJbWNvbW8ydDVa?=
 =?utf-8?B?V1M4K0tSN3NsRDJzMFFNNEtGb0lOdlNYanBvR2FFWEE2UFhTbDY3dng3ai9Y?=
 =?utf-8?B?UnNBbmRsdEdxNXZhZnBIT0xEK214WE0wWVNDR3dBZWxGMGd6UlBVVVFLNmh2?=
 =?utf-8?B?bE0xK0NndmFHb2VtNFRKcThpS20zeW5QQ3JsRDdnVGY4UXFxN0xSb2xvd2FG?=
 =?utf-8?B?UEtHWklFRUZQUU9FaVZuSGZ5cS9NUHFkcGgvN2R0bDRMZVNaVzRha2g1U1Uv?=
 =?utf-8?B?cHU4YjhKWitiVTZmdUY3dC92cGJsQjdXTldjVDBmT0xSTVcwNXRSQnM1SGg5?=
 =?utf-8?B?ZC9obDREemJEdi9YTzBDSHQwYVlWdStEaFRSQkdTMmtXUGJPZjM2eEdEOGFL?=
 =?utf-8?B?UkRZM3dkSysxTXNadm9GKzVwQWtIcGlyL3c0dXpFZlp5L3pWVjVoeDBkMUZZ?=
 =?utf-8?B?ZkIzcm0rTDVaTWZiT2tjTW1XcVhTVUxvTXBmbjE2NmY2d0dhSlcybEUzNllr?=
 =?utf-8?B?V1VXQy9yb2dCUzJyT0hHMURxL0JrOCtLd2c4Mmo1MmEwK0N4eGJ6b3lSMEUw?=
 =?utf-8?Q?H8RaKChGvAu5h+zRbFPYyjmpY?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34b0e5f-f7c7-4606-58dd-08dc3e96c958
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 11:07:32.5886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypj07NFziTFSdKxu1/r8NxxIWgpEwFJCLW2HfloNcRu/PhEcHZ9e5KpJZJrdwqwfaLolEfM+0Qr4tlf1dcum9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9298

Add of_match table for "ti,amc6821" compatible string.
This fixes automatic driver loading by userspace when using device-tree,
and if built as a module like major linux distributions do.

While devices probe just fine with i2c_device_id table, userspace can't
match the "ti,amc6821" compatible string from dt with the plain
"amc6821" device id. COnsequently kernel module ca not be loaded.

Cc: stable@vger.kernel.org
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Bcc: Rabeeh Khoury <rabeeh@solid-run.com>
---
 drivers/hwmon/amc6821.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 2a7a4b6b0094..9b02b304c2f5 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -934,10 +934,21 @@ static const struct i2c_device_id amc6821_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, amc6821_id);
 
+static const struct of_device_id __maybe_unused amc6821_of_match[] = {
+	{
+		.compatible = "ti,amc6821",
+		.data = (void *)amc6821,
+	},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, amc6821_of_match);
+
 static struct i2c_driver amc6821_driver = {
 	.class = I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "amc6821",
+		.of_match_table = of_match_ptr(amc6821_of_match),
 	},
 	.probe = amc6821_probe,
 	.id_table = amc6821_id,

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240307-amc6821-of-match-3e3308fbf133

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


