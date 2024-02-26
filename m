Return-Path: <linux-kernel+bounces-82285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096D68681CB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E8D1C225B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FA013175E;
	Mon, 26 Feb 2024 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Q+7MLUsS"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2094.outbound.protection.outlook.com [40.107.94.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCD130E3E;
	Mon, 26 Feb 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708978589; cv=fail; b=qrroN635ETx6yhYtSf7z2Zi/IoMpXLSwXLQBdjE+dvZaXd1RYMncqeEVWDvDJwB5b3Zp57lDZD3cu2JE+R3hdpoT7IoG8DNr4UPrkrDEbTbA2dfucAMGJ7WZNZVxuEsesStBEW95UCbSIsAU/FATy2IWtSyRDdNSGiRU8OAlD/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708978589; c=relaxed/simple;
	bh=O4tT15hQZqEmnMO1qud9rxu2FlM8XIIrLhInZ2/CdNA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Y113PR2MhLWrUc+8o9yEUrqBQWVHch7E0IXrGkytgCfYKBxg7dhSosXuYi4WSW9TEfibLU/wOe6Mn3orr6w1zicAltkgUEtczWqAZk2PXzCkSrfIGuqBfS+jOs95WQk0yfEkVDUypc7cRSgJafypvD+gkvTJ+UL+XKsPPIpjmw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Q+7MLUsS; arc=fail smtp.client-ip=40.107.94.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ag6QbwUun3iXibzl+udcXz9qT0QO8FKxRRfnGXfIXM6n1FOmECbQliAa2F7d2BoVS3QOyQj3QCihh2vNfu+8hCiOoKpbKpQ/5/ibqqP3PpZyiBSkRvvGyYXHrK+axeaBBShO5MVewti1pV0gKrEisk2xzQExCecsrTpC+bWcff4clvvWljzvjqMikrNtM+nFrsqWMNVzW9yAjL0gN2V/dlZtYO11Y9UrOH+0U37ztmTdklFUAKKc12TCrTegag9fjr/yEw0RVH5arFSvmOpkS/8UKNJSPA3/vjjaMjBPxnrv9/88pKGSU9OuUoshdtEyxtd99FuxnNi/ARAdKfyWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+TaA0r2xgJJz7zagwym1yatxqvMpiIus63+CrSkTTQ=;
 b=jX0eHcIsYo8CdMz0BBbYCzc7APPgds8FkZpcuuLVyikhhapZP1psZ0KRIbs9gtLSyvAGWD8K6ZWP9eHpO7I2210eON77C+VW4kvQgw6w2lTh7xiLolCx4PheZuqSs8/kOCVXYLf4ivWVjAwS3N8VHNrHrqkvRjosfR+uJLFV3AzadHlE/19C5PrLqCDpXfWdkRT4rup3I1Pw+PoUR07n63I/drvYLt6pYrvCs+d+rBH1XI8gVrJUtAQ5kDcCnuFOTcE/A2FLpHbl1aZv6JVMq17J+8BOnT1HWH++Z1FQ4/fKX+uPo1vP+JWaGTtxr4ZhwLFM78tW1yEnHpYk3RQCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+TaA0r2xgJJz7zagwym1yatxqvMpiIus63+CrSkTTQ=;
 b=Q+7MLUsS544UxGJQUxGeJ/MEya+1NAiEPLQg7x1K/Af5dvz5DY04R5Z28tVE7G1RFB1+iuDeHLdAmJXLxth+N5yEbE7ZESkpXUmHLTe8qMJTYebNgXMS2P6HgNijr1mp++gQOtOlpU6Gbci+Eo6nVzr9ux+SE6GdbKW/xlCCyHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CO1PR01MB7370.prod.exchangelabs.com (2603:10b6:303:159::16) by
 CO1PR01MB6629.prod.exchangelabs.com (2603:10b6:303:d6::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Mon, 26 Feb 2024 20:16:21 +0000
Received: from CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::28bb:f135:bd95:a21d]) by CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::28bb:f135:bd95:a21d%7]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 20:16:21 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Mon, 26 Feb 2024 12:15:20 -0800
Subject: [PATCH v4 2/2] RAS: Report ARM processor information to userspace
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-arm-ras-error-vendor-info-v4-rc3-v4-2-08e0f168fec1@os.amperecomputing.com>
References: <20240226-b4-arm-ras-error-vendor-info-v4-rc3-v4-0-08e0f168fec1@os.amperecomputing.com>
In-Reply-To: <20240226-b4-arm-ras-error-vendor-info-v4-rc3-v4-0-08e0f168fec1@os.amperecomputing.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-edac@vger.kernel.org, 
 Daniel Ferguson <danielf@os.amperecomputing.com>, 
 Shengwei Luo <luoshengwei@huawei.com>, 
 Jason Tian <jason@os.amperecomputing.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: PH7PR17CA0037.namprd17.prod.outlook.com
 (2603:10b6:510:323::28) To CO1PR01MB7370.prod.exchangelabs.com
 (2603:10b6:303:159::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR01MB7370:EE_|CO1PR01MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 5075147d-3440-4181-8cc4-08dc3707cc82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9sfwCsDgmRVMQFocvpc36v0xKNmzF/01OaaXPIQShMIAcwHsabojdKlDvgtP+llVAY/PKiDnPXSqrAj2tGdMcRiYboKjQMYgS1ZDkhjVION6JmLQqDgQW9rCuwyQMPQJ7r2qIj7MneOuIyxLGBz2FisHbSFjEICZIy5TwbmV4h8WY2Eik1ilEK04Cf5oC+7F7OYQgE8V/Rod/iMIlTbvxJbpVQyIXuOkxaFsYDdyYuTkd+40fPbIO/qW82pCv8hHAEL2g7xspa23z+Tut+MwfPYMw32xwi2KRuXKccWuttXGk2tPQTXR6fVEBQQ/vOw8N7/A9z6vcqaVEEJMp2LRoyZncLi8dSSWUJP7DXkjgD01mXyiAvckUB+nz6HisT3mtdiQmWUnZjm3xkBeP4kzmxH22JoCwTekJk8rSWkj9Ub3IK2jly8urjDNclfJM5L6acUSqVI/x2fQpDHcohT25S/I2gWiZZtAKphICgzEJhT+oICw6M2SYe7j4qgGFIAxbHkt4ieQ/6YfNyRmvW1gOmZQp6/z/ZjhR6Ufa7Wev4kaSsuV5esOStxWyKNMCtSeBXRskG5vPlk448HY0OI/QMGgTvG4gOY/9a8X0KhwEQ5Yng7aVqvy1YlnmLVNLraIy/tvD6knRzRjy8HrZgrApjPk+ODdLv8G2Nrwmjh5Q1Ue6V0r4qU4xgvILWPdaLsvPpvId+s8fDDrJj4XbP9WWBbD28ci7GJKe8sL9ohUTbY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7370.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUx6M0xvdjJudHlGUmoxMlVPcWhmN0V2dzdNQ0NzeDA0MGpQVW9DV205WVVT?=
 =?utf-8?B?cjJ3YzdRMFNYZ3MzcDFHeWd4SjE5cDNCS2U1OGo0ZjZ2bkkrZUdzSzBqalBL?=
 =?utf-8?B?R0xjMFFWNnRwTW13b0JqRzhBMnd1aVIxR1Q4UEZvMXk4VnZ3WnVjbkxXQ0pG?=
 =?utf-8?B?THFGTi9YanNULzdjblVJelVlZ29tanRqSnlkMmJreVhEMmJPNkdEOW96b2I4?=
 =?utf-8?B?clJvRDVzTG0vQVVXOXVjV2pSa0ZuRkg4RjJxbFFjc2ZtYjc0cjJmUU9CRi84?=
 =?utf-8?B?WWlEUjdKdm12SndrM05xS2tlL3E2ZGpWYmNpWW55YzRkbXJ1dG44MFp0VTIv?=
 =?utf-8?B?dmlINDNBamd5MjduSXB2Z1c4RFIzdEJ5dXlYb29ONzlXT0VkSVpDQlBzeEov?=
 =?utf-8?B?YU1YUWEzdENJWnRYZ01Md24yckp3MncxN3hUaXpyY2lUdnoyaVZ2Skg4VWhC?=
 =?utf-8?B?VngzZ1pZOFBpK1JWVXhaMytxOVprSm1uRFNER0Yrbk5GQ2s0Rk1GZHVXcEpv?=
 =?utf-8?B?ZWN2WlBUUDdpVzNvMmxOVE1XdnViL3U1eEdTSjFnazZmRHlXU2tZR0t0ZERu?=
 =?utf-8?B?T2Y2Tm8zM3EwQUpFRWxnNFVQMCtBQXF0bmxZTUh4WnFRMDBMZjFYUkJkcENn?=
 =?utf-8?B?YzhHZi9Za1YyV2kzWlFnTng1S0lDZHdQK3ZXUlhia1hIMWZXNnN4SGQvN0dE?=
 =?utf-8?B?OE9hQzNyaytLLzF5dzBic0xESCtJQXZWQTFoNmdXbHNVdktnMHF6VEQ2OUg0?=
 =?utf-8?B?MDU0WURQVlVTR0ovMWJTMzJJTVh1cElvZk5pL2dIZFJ6V0YyRmNwZzlLNVRi?=
 =?utf-8?B?Q0t0K1VCSHYxZUFsMXk1T2Q4N3E1bFZQeUN2N1Q5d3QwQXpVcTV6eUJ2YXFm?=
 =?utf-8?B?RWhoRm5seUJrVS9YK1p5c0pDajQ3R1EyZ1l1c2MxWVU2K2hRNVZpb1dOdS80?=
 =?utf-8?B?YTllWmE1Unh5Z3duTTR6cGVyOUJQdUdFaEZDM3J4WVNWS3VRaWp2NThuMVJo?=
 =?utf-8?B?d1kwQVQ4ZU9NQlA1K1piZ2lDYU9OVkduK2ovbGQ4anRmYnNBZU04NFRtaWRT?=
 =?utf-8?B?UkRzOWQyMjhXbEw3dHdvMjZLQzRHUWZaUmRxMGVaZjcwU2xFcnBFWmZGdVhT?=
 =?utf-8?B?TTVlREpEU3JNNjlUNmFZTi82MVdPMGxNbkJxVHBSVytFY2JQVzcwZCt1MXkw?=
 =?utf-8?B?dkIyeDdhY29sUUx5amU2ZVhESklhUkNONC9wZ21sL3pqMzRzYlFjeWlCbys1?=
 =?utf-8?B?a3JSTXdrUllIQVFVdFowa01XVGtzcFpXZFd5bGMyRWx6dDFuMTNsVkgrbUxw?=
 =?utf-8?B?YkhLSnFhdnVjajNlT09NZnppSVVPWm43bmtVRmJlZUVsWDFjYlc1eEpiS1Vq?=
 =?utf-8?B?eHE0SXpuT0RKZksxK0RNV2thS0l1Z1BRc2xLeWlURWNhTXMreDJUUXZmbDlS?=
 =?utf-8?B?SzlaYzRzaEJBMjBKWDNSNGxJdk8vdmJNbEJDN3NlaG1abzQrSXlLUytLSWQw?=
 =?utf-8?B?Unh4Vm55OUM2NjkvL2VKaE11UHV3WTU1Y1dCek9DQzRjeUdhRkEzRDh2TEpY?=
 =?utf-8?B?cGFCOFZQZjVRSzJNZWFiRW5Ka21aN0FsNnp5Z0VNNWJ4Q0plTUE5ZHhhN28w?=
 =?utf-8?B?KzcwbkN4WnAyU2pJMERtNjl3cTF5QUsrS21ZaHdTR2xJdnRtYkxQQkwxK1lK?=
 =?utf-8?B?RmVWS0ROSHBvdGJnNmtheVVJTzU0VldVWDVreWpsRWNxYk9xc3V3WERzSGxS?=
 =?utf-8?B?NlFWMnBQMldZK0t0Y2p4czllNlpYTDByUkZWK1htZGFlTmF6MnlYYmJwVHFq?=
 =?utf-8?B?OGZWK0tDRS94ZlVVazJrTWhhL3psSktramhTYWd3VHJjTStPeUluanRTTDdr?=
 =?utf-8?B?eXhnM0pvMVp6MGdjeVI2Z2ZHdlpjbExRZWQwMmVyczhMdkpJZkczS0ZXbEdy?=
 =?utf-8?B?RUVxOS9SVGNxZElZdkFNWmlpWmtnNGlBYjZSVWxKNklldkc5UVlZWEF5WWlG?=
 =?utf-8?B?WnUyb1Z6UkdrT1JVaG9RdmJOaHRiQ1YrWWp6OUw0d1NDa2J4UGZUTUs0MVFx?=
 =?utf-8?B?MzB1NFd1Yi8wNWtGeW11MFd4K3dTVGNXYWdxS241ZUNHV0t2cVFkYSs1RC9w?=
 =?utf-8?B?ZGlYb3J5TUtzNjJiU1h0VmZ6M21QYzZIZFNsNEZ0VWhwalhxWDJkNU1YeW9X?=
 =?utf-8?Q?q2mkyX+eaIQmS8YRX4/0A+0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5075147d-3440-4181-8cc4-08dc3707cc82
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7370.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 20:16:21.7571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMniQCPlEmmnCTUWZyxf51GoZ1teLv/u7U+9NgmFN3Eqw63zBiTezscVZtuJ7vkS2QuUXbFZxOIaa71Zw1w5GnScuOpcrZnez0edcndq9TSRRlvcluyND1sLyGovO87a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6629

From: Shengwei Luo <luoshengwei@huawei.com>

The original arm_event trace code only traces out ARM processor error
information data. It's not enough for user to take appropriate action.

According to UEFI_2_9 specification chapter N2.4.4, the ARM processor
error section includes several ARM processor error information, several
ARM processor context information and several vendor specific error
information structures. In addition to these info, there are error
severity and cpu logical index about the event. Report all of these
information to userspace via perf i/f. So that the user can do cpu core
isolation according to error severity and other info.

Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
---
 drivers/acpi/apei/ghes.c |  3 +--
 drivers/ras/ras.c        | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/ras.h      | 15 +++++++++++++--
 include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 101 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 5980f70ca0e4..8265d85801aa 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -536,9 +536,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 	int sec_sev, i;
 	char *p;
 
-	log_arm_hw_error(err);
-
 	sec_sev = ghes_severity(gdata->error_severity);
+	log_arm_hw_error(err, sec_sev);
 	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
 		return false;
 
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 355c0d78bd50..cfeedd66c607 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -22,9 +22,51 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 }
 
 #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
-void log_arm_hw_error(struct cper_sec_proc_arm *err)
+void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 {
-	trace_arm_event(err);
+	u32 pei_len;
+	u32 ctx_len = 0;
+	s32 vsei_len;
+	u8 *pei_err;
+	u8 *ctx_err;
+	u8 *ven_err_data;
+	struct cper_arm_err_info *err_info;
+	struct cper_arm_ctx_info *ctx_info;
+	int n, sz;
+	int cpu;
+
+	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
+	pei_err = (u8 *)err + sizeof(struct cper_sec_proc_arm);
+
+	err_info = (struct cper_arm_err_info *)(err + 1);
+	ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
+	ctx_err = (u8 *)ctx_info;
+	for (n = 0; n < err->context_info_num; n++) {
+		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
+		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
+		ctx_len += sz;
+	}
+
+	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) +
+						pei_len + ctx_len);
+	if (vsei_len < 0) {
+		pr_warn(FW_BUG
+			"section length: %d\n", err->section_length);
+		pr_warn(FW_BUG
+			"section length is too small\n");
+		pr_warn(FW_BUG
+			"firmware-generated error record is incorrect\n");
+		vsei_len = 0;
+	}
+	ven_err_data = (u8 *)ctx_info;
+
+	cpu = GET_LOGICAL_INDEX(err->mpidr);
+	/* when return value is invalid, set cpu index to -1 */
+	if (cpu < 0)
+		cpu = -1;
+
+	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
+			ven_err_data, (u32)vsei_len, sev, cpu);
 }
 #endif
 
diff --git a/include/linux/ras.h b/include/linux/ras.h
index bded04044d33..fbb74ecde984 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -25,7 +25,7 @@ void log_non_standard_event(const guid_t *sec_type,
 			    const guid_t *fru_id, const char *fru_text,
 			    const u8 sev, const u8 *err, const u32 len);
 #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
-void log_arm_hw_error(struct cper_sec_proc_arm *err);
+void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev);
 #endif
 #else
 static inline void
@@ -35,8 +35,19 @@ log_non_standard_event(const guid_t *sec_type,
 { return; }
 #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 static inline void
-log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
+log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev) { return; }
 #endif
 #endif
 
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+#include <asm/smp_plat.h>
+/*
+ * Include ARM specific SMP header which provides a function mapping mpidr to
+ * cpu logical index.
+ */
+#define GET_LOGICAL_INDEX(mpidr) get_logical_index(mpidr & MPIDR_HWID_BITMASK)
+#else
+#define GET_LOGICAL_INDEX(mpidr) -EINVAL
+#endif /* CONFIG_ARM || CONFIG_ARM64 */
+
 #endif /* __RAS_H__ */
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index cbd3ddd7c33d..0dac67d1cad4 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -168,11 +168,24 @@ TRACE_EVENT(mc_event,
  * This event is generated when hardware detects an ARM processor error
  * has occurred. UEFI 2.6 spec section N.2.4.4.
  */
+#define APEIL "ARM Processor Err Info data len"
+#define APEID "ARM Processor Err Info raw data"
+#define APECIL "ARM Processor Err Context Info data len"
+#define APECID "ARM Processor Err Context Info raw data"
+#define VSEIL "Vendor Specific Err Info data len"
+#define VSEID "Vendor Specific Err Info raw data"
 TRACE_EVENT(arm_event,
 
-	TP_PROTO(const struct cper_sec_proc_arm *proc),
+	TP_PROTO(const struct cper_sec_proc_arm *proc, const u8 *pei_err,
+			const u32 pei_len,
+			const u8 *ctx_err,
+			const u32 ctx_len,
+			const u8 *oem,
+			const u32 oem_len,
+			u8 sev,
+			int cpu),
 
-	TP_ARGS(proc),
+	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len, sev, cpu),
 
 	TP_STRUCT__entry(
 		__field(u64, mpidr)
@@ -180,6 +193,14 @@ TRACE_EVENT(arm_event,
 		__field(u32, running_state)
 		__field(u32, psci_state)
 		__field(u8, affinity)
+		__field(u32, pei_len)
+		__dynamic_array(u8, buf, pei_len)
+		__field(u32, ctx_len)
+		__dynamic_array(u8, buf1, ctx_len)
+		__field(u32, oem_len)
+		__dynamic_array(u8, buf2, oem_len)
+		__field(u8, sev)
+		__field(int, cpu)
 	),
 
 	TP_fast_assign(
@@ -199,12 +220,29 @@ TRACE_EVENT(arm_event,
 			__entry->running_state = ~0;
 			__entry->psci_state = ~0;
 		}
+		__entry->pei_len = pei_len;
+		memcpy(__get_dynamic_array(buf), pei_err, pei_len);
+		__entry->ctx_len = ctx_len;
+		memcpy(__get_dynamic_array(buf1), ctx_err, ctx_len);
+		__entry->oem_len = oem_len;
+		memcpy(__get_dynamic_array(buf2), oem, oem_len);
+		__entry->sev = sev;
+		__entry->cpu = cpu;
 	),
 
-	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
-		  "running state: %d; PSCI state: %d",
+	TP_printk("cpu: %d; error: %d; affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
+		  "running state: %d; PSCI state: %d; "
+		  "%s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s: %s",
+		  __entry->cpu,
+		  __entry->sev,
 		  __entry->affinity, __entry->mpidr, __entry->midr,
-		  __entry->running_state, __entry->psci_state)
+		  __entry->running_state, __entry->psci_state,
+		  APEIL, __entry->pei_len, APEID,
+		  __print_hex(__get_dynamic_array(buf), __entry->pei_len),
+		  APECIL, __entry->ctx_len, APECID,
+		  __print_hex(__get_dynamic_array(buf1), __entry->ctx_len),
+		  VSEIL, __entry->oem_len, VSEID,
+		  __print_hex(__get_dynamic_array(buf2), __entry->oem_len))
 );
 
 /*

-- 
2.43.0


