Return-Path: <linux-kernel+bounces-110777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72712886386
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC631F239BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61C8111AC;
	Thu, 21 Mar 2024 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="vddYI49s"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441116AAD;
	Thu, 21 Mar 2024 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711061787; cv=fail; b=tco6ETpfJUuNO86OTM3pq9nrQeq5buoX0w2GjUkzBOCzc6ExEGMYg5uum6MgHYDE2j36A1CoKVGXEb3Ayc3QZ3gNx3NAFb9D2OnG5lHKvzaS17vTXCc2ITEz6x0qq6d/PDUCSUYGUSsZA91oGDkIbESiYkSPCma6+UiQXEgQoFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711061787; c=relaxed/simple;
	bh=0e+ZNND/1HLdervh6GawgcAM64IfHHntx8jjLawhw/E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tlmljQtKbTeKpqtPf0pI4mcUONwoYw9AMtewt9fkiXZpBNAs7jg3OiznteYD1PfJSZetnTDOeTR/gIrC7dad3lvBEKPc9vGU1F2PFahr45itiUOBp03121FG9LQV8HQsVMVzRpNtXRnfHZ8Cit+GysVLPttR9tstel413AAALWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=vddYI49s; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5teVtPRegGPN8RFYZx9V7Hns+rtujbAKK4wvxHK1gSL/nu1bjVYWEbWV195zd21clq1PvAKdv6QhO5kEIKtAh8YZ6IzEwralrDBBtI+FjhhTnGB6OCMpJLYLnUQL3ZCxQfVDe/Y1sZ85tQIzm0A8V44h16+G3MEcPL64b5cRMbYorBWn7rJ0Ix5Kk6I5Jy9rTKz7Q9Y2dJNxjTeeYqrlVwf45nxoZ3JGZ9MvYJds0mGdyIMKcxPGLafQ9gYTRyXeJEaZlF2KR564cfw6XJo9JwXqo2DkJqnbn6lfO0PEnsOtuLnboXKdCPe/hATGrwx3akUYnZEOvVnQj+sLPe0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUHQyhJ390/RWKvQ91KzEINJVU6IIWUHxxcWU3gYjyo=;
 b=dBNMuGIcdn2suiy0sXMs296i1WbhCwjWecjHNO0UBDPu7AlcwzHZULRXjaYszYocD/MOG4qrwQ1sn3XTRQqhaXnrhsoTkTW8oOotPO5uWcApZYb77ScXHuF8XoPcPco9yglAbTr2YZ+7wEthPPLCCOfjQLqCHosncC4WIaxAPuoGYD3UoUKDV49TWi65EYNu0tyH+juHzq8t2/R/ga8xHX+x2wQDw161TMOdCNgvI/NVzSuRPSIxMYfGbgCjicQtOnYlHTQ07bGMvlnnbaDbBLHT0fCsQ3qAdd2tIUFcnwnONtjkLDzSj8ooqU61fQcXwOVl5GXOhAvwhMzknRHS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUHQyhJ390/RWKvQ91KzEINJVU6IIWUHxxcWU3gYjyo=;
 b=vddYI49s0X8+zFLtp5YCacCAhsFslx0t+wgE4hk8rp0LlvdaFUH5ezImBut31SEhHABNNTyWEpil9ZfMgOxWmCT5Axr+OaZtvvJ1cjheCRDa2r2HI8o/BsYpor1h+5qXIXc8r9cjQfD+G5jD1k2/kCHfDOZjaZY+B/gOR/7K5hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CO1PR01MB7370.prod.exchangelabs.com (2603:10b6:303:159::16) by
 PH7PR01MB8668.prod.exchangelabs.com (2603:10b6:510:2fe::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.31; Thu, 21 Mar 2024 22:56:22 +0000
Received: from CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::994c:4200:8a4b:6882]) by CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::994c:4200:8a4b:6882%6]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 22:56:22 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Thu, 21 Mar 2024 15:55:53 -0700
Subject: [PATCH v5 1/2] RAS: ACPI: APEI: add conditional compilation to ARM
 specific error reporting routines.
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-b4-arm-ras-error-vendor-info-v5-rc3-v5-1-850f9bfb97a8@os.amperecomputing.com>
References: <20240321-b4-arm-ras-error-vendor-info-v5-rc3-v5-0-850f9bfb97a8@os.amperecomputing.com>
In-Reply-To: <20240321-b4-arm-ras-error-vendor-info-v5-rc3-v5-0-850f9bfb97a8@os.amperecomputing.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-edac@vger.kernel.org, 
 Daniel Ferguson <danielf@os.amperecomputing.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: CH0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:610:e4::14) To CO1PR01MB7370.prod.exchangelabs.com
 (2603:10b6:303:159::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR01MB7370:EE_|PH7PR01MB8668:EE_
X-MS-Office365-Filtering-Correlation-Id: 914d5a46-e61d-4840-3850-08dc49fa20ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hhcb0FiuO/1y2DUywxvvQh61+maJpmsNQhgmOgKFtJ0pn6ETW/6lYdMDnuVATvxlr1hnnPt3p852PN8uz2SUGxY8nNCbr/lHMBs3ePvhswyxzUnLy2EqiCjJ09/cLXIMWPN6Hilj+muKejqhhkrf2UfGJ40NGGeeU3VHbJEltTTVfP8qGviI6Tz3bV//d0avR6OqmK5iRV0g0zdNHPwab1uGJLW9JNMWvk2MCJuksNf08RMXHjG+b/8r07qFTqMzFhusFVWjeV148rLpJPNqmCe3B2Q4YO+ygOxiGEMDQ+1EV9jJjTS6bDo7aJ/qTSzZ06JfEEjFzv9JpZWUAUOF9eo5ySjiLXc/jMX24MqHBJjeu06/tqhPBeT4Qufuyft6jOLFxjuA0KBhMmYGSnWl3/wGAIM5f3Iv3fxunN7O0nOoSs4eEDfBBhdTRMJnsWBHjnONyFQDQ7PqUNFcD5+bD+TRdmwnLI/x69MN9z5cBR9GVqtxtsT9d6msYo8nO8wurR2rGjMSkIcgsxi5wg648mXCF027mTzs5nYIbJHuNPamUmPJo9yj6+rLVeBZu65888qYEUB8deBzgiX2QB+J4pKpeWg6f2ICiptJhMg350ZMCY6VQziFAXmGQObkWYCRU7uJR1dOZzVfCPNXzXGnlhmW98CtRGgmQv3a/WRRaqbH6ZOhlDpv4FIcotZBvZHpM/hUi/LQEqdUNxPHp5T2/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7370.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUVpNk00cW5lY0lyd0xBTGE3d3RpUTZMSlJyaXl6bktHVENaRzNXYmFKTDBR?=
 =?utf-8?B?YlZ3cG82elN3eGlVVDRNWGpHQ0xIeERvbkdqMHZzbDMxZmJZQ2dlWGVPTG00?=
 =?utf-8?B?c2lEb2Q5OEFIRnRrRDJWeDJsWUJwN3p5cTMxRG82VVA2TTdxb1d2OENqZVJk?=
 =?utf-8?B?YzZtaXBRbEdzRzFxTEh4QWlNYXVVd3ErNTJpOFdSeWp5TTBnRlBMSUtxZHE1?=
 =?utf-8?B?UzhBaFhab1NyUmpPcEJaeHdVZ3Zyd2JHSUt1MmJVQnp6WXlTY29sbTdJVUVy?=
 =?utf-8?B?RGRRaXJKaktSb2sxTk5HbGw5OG1BN2N1K2w2dmJHRXVTK3hkTDUzNWtpM3RU?=
 =?utf-8?B?VzNEUm9tT2tZVUFUcERNemgvdG9tdzVBUS9LNS9GZ2NnSFpjNzhRbXIxQnBl?=
 =?utf-8?B?NGtGd2Z0a1ZGWjFnSFg1MktKQkVGQnFwZU5wZ2tKTHErWFBGUjF6WHZ4eXZV?=
 =?utf-8?B?YW9rUXJ1dnhBc0JIT0lxY1ZyVjZBSFBBaTdpU2RCZmN6Y0lnU2xyblJLd1FO?=
 =?utf-8?B?b2NmMGlGSVZ2eStXRWdHNFhWSUZTdjcyZlc0dTF2SnliK0UvRWZ5WjJ0c0FP?=
 =?utf-8?B?WnRXcjl6QWdZWlBhUytxcTNTMk9HcWRaVDVTTEtIb0tmREl3OXJOSTVuWUU5?=
 =?utf-8?B?NjRSb3ZBT1RSQnFDcFQ3eUx1UVdkV2l5bnFQUE1nYUNOMjZaUS9PbXYrampD?=
 =?utf-8?B?MzFHakJNQ3JSRWJ0UWtQa21hVjhRdFk3ZnExUWlkU3F1K1l0UVFvRXdSekJp?=
 =?utf-8?B?NDcxV0QvYmZ3T1ZBb1VtbDg0QWZ1SXRsZG9VWEdFbVZTS1pXRzczNkttU3NR?=
 =?utf-8?B?Z1loUGl5Zm95WTN5cnRpcXpqL1BZNTFtdWYrbnIrQ3dXY0dxOUN2cGY4QVdI?=
 =?utf-8?B?MDNSbjJYVnpUS2lIajBjUEVMeGk3OE1KM0xkYlNIQ01KL2FIN3lCc2l3NzNW?=
 =?utf-8?B?a3NkUDVKbVMyRURkVndyblhUTHZFekZ3cFc3SGdpYkxhR0d6dnQzemR6Qit4?=
 =?utf-8?B?dytHdEQxR1ZNR3F3Y3Z6R00rVzVCeVRvWTVjQ3dkREhwM0xlcVA1TkUwK3dK?=
 =?utf-8?B?VTVTNXhFejVJWnlOWGRMODBDd3UvRkZVblZXZklHbExjcG5helNXMFY4TU11?=
 =?utf-8?B?ZW82NGpSYmlKd1ZDK2FWTURzL25Mc2RucWV0c0U1dWduczhFamJIYmVPWHZP?=
 =?utf-8?B?MWQ5amIydmF3RXBpTlpWamVvR2tpNWQ2VU8wY0xIS3QwdmliTUtQK0RyL2tz?=
 =?utf-8?B?dWVoZUhOUE5JM05TbTBqVFR2anlJUHN1d212bG9TWTZ1WW1vK205eHU0Qmt4?=
 =?utf-8?B?QTM1R3FxQ09Kc2tqSjBIN0tGazNZVWxJaXlkcjJlRjAxdUlyWnNWTUpQekpW?=
 =?utf-8?B?ZkhJSUVJaFNvditGaWZWcTJwcGFuLzNZL3JIYjhSNkFHOWdKTlVGY2JUUElv?=
 =?utf-8?B?TW1WdlBFQU5zbTNlMVEwSWNXZUVCNzZ6Sk5vWjFGS2Qvb0hsdVBYRDc3cjRi?=
 =?utf-8?B?RXpxa1lRbUdMRkk0c21FTDU2Q3RFVG9TUENpKzBkVnNOenhha3RETmw3bmd5?=
 =?utf-8?B?WVlBWkd3TWx0N3lKYnhuUlUzdEJhYmlWcXNkRkFQRUZlcmpnalRUbHJSOGxw?=
 =?utf-8?B?bTV6TmM3Q3VveFRkODhaRE54ZzhOa1FXbURhSzd0cUhtUlF0NTJ1QnhhdHJE?=
 =?utf-8?B?Q1JBZDhwNlNJZ2JyemhzNnVPOTZnbzArTHo5UDExcEdieHU5azh4RDk0Y043?=
 =?utf-8?B?ZnNKT1JIa2ovKytCMGlxWXJEWDU0bDJ2cUN2SndPdEhhVnM2cy9ESWtJTDE1?=
 =?utf-8?B?R2xUMUNIejNvSlNiK2NFdXNKei9vNXJWbitLWlZuRTI3Y1VoQUp0MFZ1Rkw4?=
 =?utf-8?B?UXlKQVJsbW5FRkNLVGN2ZXJsV1N6aEFTOEI1OGVLZGNHdjJ6RW1jdjhhcGlI?=
 =?utf-8?B?bHpoKytkb2daNC9YUGFCbkJtbGQ0NDkvekt2bTlJaHQxckhKSC9jdSs4YVVV?=
 =?utf-8?B?WC9DSmI3NDRPZHVza1hjMjFRWWtwd200eWtmaVhadTkxK0NOQ0tXd09EOWNV?=
 =?utf-8?B?VEp6ZUE4UmFjblgyWENMMXNqTXl0Zm8vT1huYkI2dEdEQjh5czJubmNDQzkw?=
 =?utf-8?B?Q05yd0VSNzFsMXdMRlBIVThMN2pSWFlZMm9FZFdzYncvbXE3blBvYllJQWNo?=
 =?utf-8?Q?bkqW1s2vxFrdd8z6IZFoybY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914d5a46-e61d-4840-3850-08dc49fa20ee
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7370.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 22:56:22.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvJlpVudPaQIb7v8PAgBVY+6M+uC35FOTXP2mb46nQ9eXycBxDpOhj9gge1c+ISzy1GSRRbDgPGAIPY0rtPJzgRnsBF+FPtAvcUJ/YTy8B3Hp0FSr6Ao48ATrqtygwKi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8668

This prevents the unnecessary inclusion of ARM specific RAS error handling
routines in non-ARM platforms.

Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
---
 drivers/acpi/apei/ghes.c | 4 ++++
 drivers/ras/ras.c        | 2 ++
 include/linux/ras.h      | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 512067cac170..58014558b8e0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -525,6 +525,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	return false;
 }
 
+#if defined(CONFIG_ARM) || defined (CONFIG_ARM64)
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 				       int sev, bool sync)
 {
@@ -570,6 +571,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 
 	return queued;
 }
+#endif
 
 /*
  * PCIe AER errors need to be sent to the AER driver for reporting and
@@ -704,9 +706,11 @@ static bool ghes_do_proc(struct ghes *ghes,
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
+#if defined(CONFIG_ARM) || defined (CONFIG_ARM64)
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
+#endif
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index a6e4792a1b2e..249dce21a738 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -52,10 +52,12 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
 }
 
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 void log_arm_hw_error(struct cper_sec_proc_arm *err)
 {
 	trace_arm_event(err);
 }
+#endif
 
 static int __init ras_init(void)
 {
diff --git a/include/linux/ras.h b/include/linux/ras.h
index a64182bc72ad..811feb9d8160 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -24,17 +24,20 @@ int __init parse_cec_param(char *str);
 void log_non_standard_event(const guid_t *sec_type,
 			    const guid_t *fru_id, const char *fru_text,
 			    const u8 sev, const u8 *err, const u32 len);
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 void log_arm_hw_error(struct cper_sec_proc_arm *err);
-
+#endif
 #else
 static inline void
 log_non_standard_event(const guid_t *sec_type,
 		       const guid_t *fru_id, const char *fru_text,
 		       const u8 sev, const u8 *err, const u32 len)
 { return; }
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 static inline void
 log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
 #endif
+#endif
 
 struct atl_err {
 	u64 addr;

-- 
2.43.0


