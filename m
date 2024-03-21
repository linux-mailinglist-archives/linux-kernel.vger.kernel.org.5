Return-Path: <linux-kernel+bounces-110778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84315886389
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D03D1F23BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D002B6AAD;
	Thu, 21 Mar 2024 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QTVbtfi7"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2130.outbound.protection.outlook.com [40.107.100.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BE1E534;
	Thu, 21 Mar 2024 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711061795; cv=fail; b=eeOEGnirG0JaqBKC2wjP9CVQ8StyvI8CS9gKmiLmvK4wvWxVlA5YSYaX0fdN4ZdQmk+kyHvYOPeFMbxZKCQ4J1KY1uPIupXsUWgsj+PWTikM9Ftzcy5zg0Xf1SYJR5AkajP/xkcbohbPuP8lNacujyZnTXUTKj442WXQeG+Fes0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711061795; c=relaxed/simple;
	bh=gAq1uDOcPYkdTtGC4RbMmQfFfLNo2J56k1THTkZOs8g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=riVrto7uYyQhIihMGpWR8q+1iuxnq35NPG5Ii9IgwQp04Iw4hT6OjY4zjRPgpAWPES3pw2mHYhVCfYTxlR0pR4f/oDNrNOFk6dEZypIAyGBwToViiSfUfKrFNLmsPQo3Bmjn/P2oMipEV1p6DruKjciQYvGDZaT4KN5TQLVtxFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QTVbtfi7; arc=fail smtp.client-ip=40.107.100.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo+RWWmBM0a1rkoBvhySwvVEBZpieVE+ke5DsQEr7OfsSgT0sheJs8NYvPOLRjmNDcfKmMVgNBZFd+tON4VD7mlaR2AatNfL9cCDQNH8WhgWdjLqng8oMeNQzMfQ+uPH9NoGrBR+MTAjE+TtF3I+AiGxXXq038SNxhaZGRQd7JjcT+ow0iJcikU6I+/RgPuM+0pxE+FZKbvvZjhtlHGL6GOMsUhHeIOI4d5ZVfFJMauex/VX/hbeorvzM2wHPtby1hQTSCyk2fM+IZI/eUf5zZ4oQp8LP/U5E2vROkw4JLx6vtp9jkWe6IKgDWhRqkYWBPbmcd8ukR+ZCixNSoaTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3sDMF4sdC7CaU0BZYrtXeQ6T4NypaIu6cOxw0LEmXY=;
 b=mAR3XWBiIebx9/7G09La25W1NRc6xKC7qrR9hgii5uKQTtaxfhjkJ7UUK4rhoO9Lfa48byyXM72RAkpHYAUHIttAL+2ZPqQ3rMgBakPTT/QEhGTk/u6u2E6MLhlpJaMMLpVBjDxNhTNYYezekYR1zOf7yMg6aFThEG3lO18CWuXc9cHGpxKKO3DQuL+6PnBwseBK4oF+cniB0Q4uXYDRLh2EjIOoEAXWc9/92doFOPsWe8lbS7ngTkdo2bYVFwb/RgqMaV2pZuI5IPn9bI5xQo79Ljsn8VlJ7sC1j5dpYO+BKRK4AeTXd+mimlQcVLK50kgi5HcESiObiPRJgGmgfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3sDMF4sdC7CaU0BZYrtXeQ6T4NypaIu6cOxw0LEmXY=;
 b=QTVbtfi7ZHs4xUYAl9FEf0VbfDF4IBAWQulwkwVC3+gnFv+Vq0n2HqoD6kFw0y+S4kZqEpgpQ1K3RcIm9sI+VMZdF3m+JbbdU0xY/JRxaT63AKID+toTwgLPxCdy9Bi3HT8Vy+iMkdM8s1iscu7flwIAXomKzl4xLhfgfbMQG9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CO1PR01MB7370.prod.exchangelabs.com (2603:10b6:303:159::16) by
 PH0PR01MB8021.prod.exchangelabs.com (2603:10b6:510:281::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.30; Thu, 21 Mar 2024 22:56:27 +0000
Received: from CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::994c:4200:8a4b:6882]) by CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::994c:4200:8a4b:6882%6]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 22:56:27 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Thu, 21 Mar 2024 15:55:54 -0700
Subject: [PATCH v5 2/2] RAS: Report ARM processor information to userspace
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-b4-arm-ras-error-vendor-info-v5-rc3-v5-2-850f9bfb97a8@os.amperecomputing.com>
References: <20240321-b4-arm-ras-error-vendor-info-v5-rc3-v5-0-850f9bfb97a8@os.amperecomputing.com>
In-Reply-To: <20240321-b4-arm-ras-error-vendor-info-v5-rc3-v5-0-850f9bfb97a8@os.amperecomputing.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-edac@vger.kernel.org, 
 Daniel Ferguson <danielf@os.amperecomputing.com>, 
 Shengwei Luo <luoshengwei@huawei.com>, 
 Jason Tian <jason@os.amperecomputing.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: CH2PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:610:38::18) To CO1PR01MB7370.prod.exchangelabs.com
 (2603:10b6:303:159::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR01MB7370:EE_|PH0PR01MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: d1db089c-000e-42bd-5606-08dc49fa23fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ct7yfdPzhI2oXflOey9OF6GD4exVn2kk1hDMKw0lLQQWQaP7ZtP1mjpLfjShn25xjb2w37HueeyCLuNGAbpCniSa78iQy2no7oTg7K8Jn4+mSZxHkYAw5BQGKWhImBBEb2JfSuV4X6YWGInM71shyloQBb4RnSWyTx4mrBSAzsquJzUrpebmVmC1h6toibPFTDFb47UDZ+ZPNItISXnjdSUIfrl71LNtV1W6UrFBkD2EAu9q0OGVfqepgdutNI/llRcE6ejCHzZgpIomFedsCG++fEExI6R+Kre/OlzbbOWEE8WcXls+r6k5Y0v3SRNsS5giwNIX+j2Nuw31wxzvvR+Fy2Nc/jX9KDWZvdeRBDVc3JU3Be3Ud0s7JaBGq8I79pQaqYIFy+gUl6b0nOfc3Vgk2pYxLwHe9fANtIvM4cj9YP/nqqjeMtwrWHcpe4+Ihljw51tg/j+2LM/8c1/EwzzJ4XkkGc/plIBOcCviQWOIlmLGyXfE650leF/+GtVa/VRkBbnrZrQDtwhidBhhgUyT/1kazwwF28mxGtCvoy8Dd0GaEy/m9FnfJX9k+B9tlPS1CLK1Vb8ejOQUwkCf+TmeQGm3DYCB2VGEpXvc6E4o4dy2Q8vFWCy8aUEdiWGe8Xhiwg3CAVazoHNHiPC2NsLTYyqQ7Du1vl2mh738VaLxRVBwqKxcckGd3SuuSB9ytlt62NaXqi4DL3HaHnDT21uocSYGkxIH+dFGSguEwHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7370.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3haclFVT3NNQVRObmZaOG1abFNqdmFncE5JUzNyRlBNTVRkSTJLdG8yWUlH?=
 =?utf-8?B?N1RCNnNZMVp3ZnU0RW5rMXZjV05UNFhmSGJGcGczZElObnZBd21xYzhGOTBM?=
 =?utf-8?B?UVRSZy9ZWXR2S213R20vcFZwYVBZbEhhQnJ0K3lwbUl6ZWg1YS96RkFLUmV3?=
 =?utf-8?B?Qmwra0hDUHNFdG0zZjg1VFFOSEg3Ym1ma0J3WVJFWFFhS0tyQ3gzQkVLSVRy?=
 =?utf-8?B?S2Z1UExTZldEZGw1Qm9pZmYvYUpDSjYvVktUU3pUSHY3VC9rejgwaCszSlJy?=
 =?utf-8?B?MHFkbG5VSWlSbURELzAzM2ord0Z0djhweWlabEs0T01LaGNqYU04eG9RLzBy?=
 =?utf-8?B?b0F6WUthNCt5a042VlRkallZVnhLZGhKTi94WndiMHMrNVlnR2F6NHFlVlNN?=
 =?utf-8?B?VXFnWEo3bDlmVDJYVmxKVnhFZXRUL2FwbjRuQXEzLzZEdEgzSk0vTnNJZUkx?=
 =?utf-8?B?cndMcDVaRE90K3Q5UVowcnFpQmZXeEI5SHlkZS8xWSs1L0MvMmF4aDdDd3I1?=
 =?utf-8?B?N2tiK09DRkxsMmg5dklnWkNnb29lb05FR1pLYmVYdEplMmNIWnkvTE1YOXcw?=
 =?utf-8?B?a0REUWVVM2pvazFnK0tHeURWNlJxTkpDR3FyaFVucnUxQmpNUzdmY2dTeG5H?=
 =?utf-8?B?YWdQSVIyN0FPYldPU1BQaU0zZmJ5U0FiNnc2WC84V2NzYnprVDFSY1cza1Fw?=
 =?utf-8?B?clRkZXpLZkMzd2J0U2F1aTRQQkd0RFovcTdKNWRXcjQ1Y25xbUdEY2RqVXIr?=
 =?utf-8?B?TnhNNWNFaTIrMGxjUXN0MFNVaWJqM3hISXUxSTA0emFaQWJmc1MzWWFRN0tw?=
 =?utf-8?B?bWRMVWtGQmp3a0sybXhpS1Zac2NEQ2drTHpldnNFWVdDWWdIWlFmNlZoSG8r?=
 =?utf-8?B?V3Qrc283aXA4V1BtbjNSb0JNWEFrYnFzQ09LSk9LeHM1UXNTVEhqQjY3ZmxR?=
 =?utf-8?B?SjI1Rk1mUmxPMktjanBlaGFEVytIbVZjSG1OczFkZThmbVJ3ZmdVcjB5V0dj?=
 =?utf-8?B?ZkdFQVNvSmJhNHRKa3VWSGgwYTJ0eUZHQUJmayt3aS8wQWZ3V3ZwNEx4eXN0?=
 =?utf-8?B?eVhTT0k2d3ByUVdwYmlaNXRqTTFUenVKMUNhdzRqb1FsSysvclVhNHVpaUFM?=
 =?utf-8?B?K1NUbGZGNEVlMHlFY0g4aEpwOHJocmk0bmlFNktrSmlMbXBENEM5NVczc0xp?=
 =?utf-8?B?VkV2aVV4Q3VSRGM3YTBrQitocmg5ajRjMmphZnVRekMzTWVMdENndEUyRUpV?=
 =?utf-8?B?QmVBOEtBQVlTZWR6cnFTTDNRbkF5N1NxZmpSMytFMUlvTFZ4UFNMcEhxK2tC?=
 =?utf-8?B?T3JuY0NDT1RJM1VXWGJURC9sMWVVajV3YWd2aDRKZEJweEJNM29BUHhVcHhz?=
 =?utf-8?B?UHJLRG9LdjhGS0VTWmFMOU1haDJ3K2FZMkpQZzZob3JsUzUrUUhOSUc4VGFw?=
 =?utf-8?B?UTNZMVc1K3FFZnBpckdBd0wwZTUxSldtTUJtL3JLVmVTdzhPZ1MvLzJiNWQr?=
 =?utf-8?B?V1Ewd3hlQm5uWk1iZzRCSCtQUis1TlNqSVNXOXRpT2tkN29iOWpZdEhQZGpK?=
 =?utf-8?B?YXdjTnlyc1VyZ2JlOXl6K2dEc2NtWGh3bnE4K1VKSzZaNEp6ZldLeERtTE5R?=
 =?utf-8?B?Y2Z4WHVna1BzWm1LdFNBUmdPMFVXRloyTnNLSW1nc3dEdTcrMWgrYXowam9X?=
 =?utf-8?B?aVpYWVdiSU0vYVFzMC9tMHoxUEE2Z1k5enJUL05qMzB6RG9tdFNRRUoxZk9T?=
 =?utf-8?B?QjNEV1A1MHoveGF5bk05cDVINklXOUR2cTR1cjZEVHpPeDhTcWlJbFlyS3V0?=
 =?utf-8?B?bi9sNGNGZUlKaUl5bThXZEZpcUxxSlB3Q0lhZGdnRzhUTG1oWmRHUzNQRk9S?=
 =?utf-8?B?cU5Rckxld0FsUjR4S1V6WkI3UUcvZ2VCaE9yUUR2UXBhM3AwR2JxWEtNditk?=
 =?utf-8?B?Y0FGZm5iYi9hOWJXZXdmQVhHd095S2lGZnV2QThkd2VrVldiSHIvS01JQnMz?=
 =?utf-8?B?TTN3Q0dLbXJ6QU1SRk51WTVrdzBvWGJ4cmRiWmhwUlZYWllPQ2NRZFBlZ09F?=
 =?utf-8?B?VFNBNm5jaHhkVWtpSThPTzlXYXE2RjZ0RGtiZkltQWVPNlpObzNLQllndkda?=
 =?utf-8?B?WkR3QTZkcmNxb0JIVjBQMGNQenQ2OUxHeFlkaWU3Sk9UejAyS1FqVGtTOE5z?=
 =?utf-8?Q?50Ru5/tEWcH8mjTsrrvr7f4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1db089c-000e-42bd-5606-08dc49fa23fa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7370.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 22:56:27.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1HigtmsBAnNoaBEZFVIZBqTAwcitAWHkoRdxVkMFpYOuzq0w8e4bkE0BrHU4dRvMObD3vn2eWyQ8NJMGVVY9JR717ycl5H7o47XWe4AlBc39Ic+weC2w+ObdmoB9yGx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8021

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
 include/linux/ras.h      | 15 ++++++++++++---
 include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 100 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 58014558b8e0..a93c80fe1bab 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -535,9 +535,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 	int sec_sev, i;
 	char *p;
 
-	log_arm_hw_error(err);
-
 	sec_sev = ghes_severity(gdata->error_severity);
+	log_arm_hw_error(err, sec_sev);
 	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
 		return false;
 
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 249dce21a738..3e2beed2db07 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -53,9 +53,51 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
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
index 811feb9d8160..2070e4ae0626 100644
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
@@ -35,7 +35,7 @@ log_non_standard_event(const guid_t *sec_type,
 { return; }
 #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 static inline void
-log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
+log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev) { return; }
 #endif
 #endif
 
@@ -55,5 +55,14 @@ static inline void amd_retire_dram_row(struct atl_err *err) { }
 static inline unsigned long
 amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
 #endif /* CONFIG_AMD_ATL */
-
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
 #endif /* __RAS_H__ */
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index c011ea236e9b..a7d7b6e717b6 100644
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


