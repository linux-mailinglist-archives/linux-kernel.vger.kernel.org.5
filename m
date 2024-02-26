Return-Path: <linux-kernel+bounces-82284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DABB18681C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 506D8B2479E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1298A130E58;
	Mon, 26 Feb 2024 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="BSeMmiLo"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2094.outbound.protection.outlook.com [40.107.94.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71ED130E3D;
	Mon, 26 Feb 2024 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708978586; cv=fail; b=ZA47tCkERQy1O2XqNbKK98fqK7994fzes4dg0IFyCcb9nM8O8rN56ei8fTLSN/r3Vyu9GOPcirG2eGa5Tj6k1cBD6rdKwld5eomh7qn+L6O933K4ZdZ/l6U1lVd9MCI6tO1ICJgPZIgClNQbmPUObdWdBViMu7m/0GUgqX2Jgp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708978586; c=relaxed/simple;
	bh=L0+xsFTSdr/2PufmiCH7/xGFA9frNWI65iy3TDO5fR0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mgeDIdzQcY++BSghx2E+0LjzfcJjD2zyYFDcGJS0wF4MXYVvymdodgPSL5CFWxygLRrQBO0CZ6CLdoQ0dPtN22tHsiLZs+hxlMSt2ssADyGLOQe+CHsjZ4ZY0JWvHMdu3S93BT1XXt4a13RKsCllBWwrAivQQrAYc3qANHylUKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=BSeMmiLo; arc=fail smtp.client-ip=40.107.94.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LefeWpRTDcaCe6J/iRqjeFKILIy6eCP/SSzNf//dF803ghUpkl76mGVT2dPsHumW3BuNQ66GeKZbKJiVXQczVvYvQZ5gO/sMRQY+/sNdkvrJOqHVI0AD1cFG5v/yrppd1TB/nrn512kqkEe0eG/3k5C39QZ1Hklr3P1Tzy3P65ZWzXni86ceYtqFVKRPAy0lIxqBlyd2O0G/wSVtOtD9A176cN7EYcLwFvWmtExk4165Y3Arl8pqQaJ5ChuDmfFW0KGUiEZBC0Vw6VOBRKZGRsBNZj8rDT9cWl4fweJ3pjahl2U6lDnDstiAkXC+l+ovk4CbBZyvLJ2td2dZysGYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQXYvBbRM9gqHDLwox+XNxSA3Br7oAknoKyZaCrG3Es=;
 b=ktSxAEzk2ttoGk85kJ4RKXIje9SEkdW+n90Du+ozGqKHCCju3L1dgN/E5gMtLnSHMCGvV59Ua0Rvs4zuGysAJxKA6e/l4uQ4aoGneU8lQ59DzZJE6Dleg1/gnc0WaVAXo0AjHFt1p/LULyLauQrf9kr5h2bGFKP1fsuJQbWXgsa7/owUOMAfG6iLQwIvCfBktmx0W6QV3OebdNPHL//H7sjUlg+sLF2W3qTUOgseos6IaZHS/Z23HIdvVxjGZ3bgX5u1PuTsowvkKInCwxEygtpQJK+MExrbvHa8uSA0IWaP2ToaMNosXNiNu1HE/kgp+i+B7PZe4rF2cN4OlF3bzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQXYvBbRM9gqHDLwox+XNxSA3Br7oAknoKyZaCrG3Es=;
 b=BSeMmiLoc/EEUZhsCk4PY7Afs9rUUPeLDqfBBNgoMrFIj+M/lMN47oOdaXdQ1LtEOz/4IAnMjoUjlfY9D2HxQwzTSLVnxItkGfyg346O01nyhrAbNzUJAke4eO4Z2jGaS6Nx4F2Nmypg71ftHBsh3gdXYPWJSrTenec6AgMvcdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CO1PR01MB7370.prod.exchangelabs.com (2603:10b6:303:159::16) by
 CO1PR01MB6629.prod.exchangelabs.com (2603:10b6:303:d6::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Mon, 26 Feb 2024 20:16:18 +0000
Received: from CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::28bb:f135:bd95:a21d]) by CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::28bb:f135:bd95:a21d%7]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 20:16:18 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Mon, 26 Feb 2024 12:15:19 -0800
Subject: [PATCH v4 1/2] RAS: ACPI: APEI: add conditional compilation to ARM
 specific error reporting routines.
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-arm-ras-error-vendor-info-v4-rc3-v4-1-08e0f168fec1@os.amperecomputing.com>
References: <20240226-b4-arm-ras-error-vendor-info-v4-rc3-v4-0-08e0f168fec1@os.amperecomputing.com>
In-Reply-To: <20240226-b4-arm-ras-error-vendor-info-v4-rc3-v4-0-08e0f168fec1@os.amperecomputing.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-edac@vger.kernel.org, 
 Daniel Ferguson <danielf@os.amperecomputing.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: PH0PR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:510:e::13) To CO1PR01MB7370.prod.exchangelabs.com
 (2603:10b6:303:159::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR01MB7370:EE_|CO1PR01MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 34814eb1-6519-4c82-5777-08dc3707ca90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	snZfID1ms8CefAxcOjmMkLUTtzlR5szQfX2a2DjW/kydBGwHhMFdK+n2Tggf5eeyJgSAaC7xO6xzVyXDmJeL6mqen+4Gk57jTZ09enowO7RKjB8QNPbJETJUFKcF650aw186UuC39SKAFcW+rqfm5yQQNiWozxFe3wNc+eAqCgO91FnS5U/GYPcSWrxCedAqFUo/kwMJAzP9G/AQfLDl+Mb/w3LnTX34m73sJXezRSI+SC/h5bh22nOSuXav8+peouc87JAXSGLeGvhg1vR9U0cC78+Yn0ygntN9Z5jASvGHiaQvx2gtLs8f35ZeJMUuzNFnq6gE09KiXn1eDOaQGRlJ9fDqvJLh0ZAGKX9CCJdPZmgaIxRV0YkMKaTPLIw6TANPERNnwiUGFf637PMm46PiOhIUFKXnOf+MDTJkAT3fA9DLMASjW+aZEvot5gnlXcbNyQXZhG9pCNdIJzlUjh7jKoXed1hFT6qXUnwqopG5xnBnncmw8EmZURuYKkzEwQI4Lz4V5bAJfPaWqxZsDUey3LsLdUFcWxbWe95+eVWjTLmbKwjCKmLm8kI7LnubIb0OFXKTDMZJ1YjbLmExS4cwOC1lzZAFmJmgd5b/o+dBuPx1RydmkKJqHVTBbvcQKHj6TT0LtJlGxJuKzm2P8l8UIR0elhCzpmWTc6ttRHowojYUZ6TZ65ORwBNllcdDX4lp7Tf5BjhRbBXqmOFryQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7370.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2x1OGhBTlN2M2hJSE40Q0pFb1U1UXM2eExvVXkvMEdFV1RYbGpBczE5Nmw1?=
 =?utf-8?B?NFB3VWJKc2FTbTBiN0FQdisrKysxSlpKV0NFVFVWUkQ1cFluSllqT2tSMTRJ?=
 =?utf-8?B?L1VwNEhnZXdNTFRlbmtrOU92eFVqbk5jN0N2OFdJVkRnWGIzWU4yUExSWVhL?=
 =?utf-8?B?cHdHenZhRkpmZStNRTBFTTQwRFVERFhLM2cxQkNqZ1Y4d2NOTmZaYmVnKzkw?=
 =?utf-8?B?RkJFQ0kweHRaZXJRWDd0bnpKd05wcXVSR2o5NEhNVjMySGFPUlBuQkFiQm9J?=
 =?utf-8?B?NWJ3d21uT2dxZ1F6ck5PQ2ZLVzY1WDVodlVWcWkyR1o0dnpNRWZJS2ZOeVZy?=
 =?utf-8?B?OFB5Y3dUMDdOc0pjbzQxMk54a1hHZ2NwU3lRMGpTMThYbzlhb01KMVA0UVN6?=
 =?utf-8?B?eExNRUhGYXpCUlowbnR1eWc1dVlqZy9HUGZidExxN05mVEpmNW5aQ1lrMzZN?=
 =?utf-8?B?WnJiek8wYURQeXVXRHYzcWN1MTQzS2QweGQ2c0diUGNENXpqWTVVTXF5NFgw?=
 =?utf-8?B?MFhTNXFMVWZZMmlvdHF4b0tvZ0JoR0lwUno1K1c1TnJLNnV0SjZacFIzenht?=
 =?utf-8?B?dGdtRnF2a3BJV1BHTFV4UWxZd0drQnNQK1JrMHVGWmZrOEJIbTJuYWtyNFRF?=
 =?utf-8?B?YzlQOUkzUERKdnV1eEs3UTg5RXhWSEtLb0JjN042cDFrR3A4VTRjcTllNWo3?=
 =?utf-8?B?UGRjZDNMUHd6Yk5sZjR4MjRzeUlSZzVyTzdjc1YvY2FKN2YzcUc0UmkzZ2FI?=
 =?utf-8?B?dHhPTGRDODUwUTdsa3d0dkplNlUwdlFYMTRiVzBGNGZlejEreXY3Z3VhYmY2?=
 =?utf-8?B?dEViTE1HTDRnR3pFRWZ1VDZUVGdvQ05tR1ZRRHpYTU96VFpyK0c4b2lrV3ZH?=
 =?utf-8?B?dkRDZG9WZXpqMlllbzJQbG1NTndnNVIvR3dTUDRpOVRsRFBvOGpPL1Jyc2Fa?=
 =?utf-8?B?b1laQ2Fwd3lnUTVGWDFEZExqUnlYK0xyU2I0TVNVMFpWdHZVU1BIbWprY0hK?=
 =?utf-8?B?bVhzVXQ3Y3RtczlVakVFZ1ovMWkvUE5uZnBLbEo2dU10cFpUTUxadUdUMkI3?=
 =?utf-8?B?SXgvaXJpWUFZMVVvbkUwc21vRGxrdkZkTG9ydjRrU1NHWWlzTHNtYXFhL082?=
 =?utf-8?B?TXgyTjVSTUs3T1c5ZjdEUHplL0EwMHo0V2tSY3FOeStCNTMyWTRqSmdnY2dM?=
 =?utf-8?B?YjFCNGQrSk5aUDJpZWxuc0VnT1RpUkVZYWI4UzdCWlFBa3N0K1haREtNMkZy?=
 =?utf-8?B?aVJRYXV6bm1HNDRrN2hIOExhSWttQW1uSnlKb0pJSnBuSlBQVG9aZkxTMDdP?=
 =?utf-8?B?cGVGdVZkaHYyRUo4bjNya1J5WHlFeG5hWnhrRkp1WTRyUVJmMHo1S3lsY215?=
 =?utf-8?B?aVEzWGFMcmRWWWE3Q3c4K1dCQVd0djdTQUdOSHBrWkZEcmxsL3BvUWc2Qzl4?=
 =?utf-8?B?Z29NalRnbWxKaDRvZ21EcDRJMytxMnZOcmNydkRCVG1IWExpbUtxWDZaOUlu?=
 =?utf-8?B?VEEwRm5sNHNmbkVPazl6ZXZBcm1MQzhUcG9nYzFGZDgyeURZVjN0OHFzc0hu?=
 =?utf-8?B?SzF5RFppdGl0bE1PWm5XNXppaEFiTWZveFFaNWVlazdQUzhOam1vdXYweW1G?=
 =?utf-8?B?aThDdkdHazhZSnY2amJURFYyZmZ5RGJtUHlTeHdoby9JemNrY3ZNcDhPaUx3?=
 =?utf-8?B?RjFrZjdMVjgxRlcvdGZOUzhUbUNkQ3FwbC9VcFJhTUM4ZGRZUmU3ekhNSWFS?=
 =?utf-8?B?Ym41aUEzcUNpVWJIN040N0Zoc0FJRGZWOGtNYVVhNGpXOUV6bWJNOGxpUlMy?=
 =?utf-8?B?NHA5MW84VWJzdTBCcmxZRmVaUGZlT0R0MGpubjQyYU5BNnYxL1ovN0k5SmVr?=
 =?utf-8?B?S0lNMm9aejhuZG0wMzBEY0lkMkEwK1hGMTJYVWFqMytzcXNBSFQ5bUkwWGtL?=
 =?utf-8?B?M2NyckgwL1FRcUczRXp0YzFGTHdMNk5tdUNsYXRHb0plMFdCOWtLSXhxSXdG?=
 =?utf-8?B?MkNvNExvdXZHMnYxTTJReUR0ZzFnamtZUnZxOHBmeDZXTGh4aW1oTm0ya2Rj?=
 =?utf-8?B?MGRncFFnekFoa2RrWHNoZXFKNnEvSkdBSnlhZjN0THRpdkRxemhuZDNSSGtM?=
 =?utf-8?B?ZFEwMHA4eXNhcEFLS25tNlpBNFFzOGI3Y1VJb1BHaThSZmFTZDlXYjd1VlNB?=
 =?utf-8?Q?oNkUL1oztjOsXxZIMg8vTUY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34814eb1-6519-4c82-5777-08dc3707ca90
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7370.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 20:16:18.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3lZcrY1Tir+/PGq4TPpXEqq6Rgga8KWB0qL9NdG1Gei0BSauQ1qtsFV04J2DG8qnNbWJpwb7DMIujd3eQO+yyVQCpg0vMFn+L7BceaZgB71qLzHjkGC7Tz32Ml+4fYT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6629

Conditional compilation directives were added in some places to
prevent the unnecessary inclusion of ARM specific RAS error handling
routines in non-ARM platforms.

Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
---
 drivers/acpi/apei/ghes.c | 4 ++++
 drivers/ras/ras.c        | 2 ++
 include/linux/ras.h      | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fe825a432c5b..5980f70ca0e4 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -526,6 +526,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	return false;
 }
 
+#if defined(CONFIG_ARM) || defined (CONFIG_ARM64)
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 				       int sev, bool sync)
 {
@@ -571,6 +572,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 
 	return queued;
 }
+#endif
 
 /*
  * PCIe AER errors need to be sent to the AER driver for reporting and
@@ -751,9 +753,11 @@ static bool ghes_do_proc(struct ghes *ghes,
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
+#if defined(CONFIG_ARM) || defined (CONFIG_ARM64)
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
+#endif
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
 			struct cxl_cper_event_rec *rec =
 				acpi_hest_get_payload(gdata);
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 95540ea8dd9d..355c0d78bd50 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -21,10 +21,12 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
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
index 1f4048bf2674..bded04044d33 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -24,15 +24,19 @@ int __init parse_cec_param(char *str);
 void log_non_standard_event(const guid_t *sec_type,
 			    const guid_t *fru_id, const char *fru_text,
 			    const u8 sev, const u8 *err, const u32 len);
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 void log_arm_hw_error(struct cper_sec_proc_arm *err);
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
 
 #endif /* __RAS_H__ */

-- 
2.43.0


