Return-Path: <linux-kernel+bounces-100803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEB9879D73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859D128425C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430E014402C;
	Tue, 12 Mar 2024 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="nihC92+v"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2126.outbound.protection.outlook.com [40.107.237.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9F143C5A;
	Tue, 12 Mar 2024 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278809; cv=fail; b=XkzA6ok7xZgVYdUjjCkoWxlTL0Q6VAGes0R4vYQJvFYgmGJ1mOeRD9Zz0CQ8223vJq33iaM+PD0mmrToTRTPEXB6YUk8urcqVSqCGEKpp1M7xXC9JmFroDd3pcmlOOkmmO+g/F7W+nKhS4HpLodvtThxW4bpuJ132LCwTlTrCYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278809; c=relaxed/simple;
	bh=ba02vKZZDpq+pXgFEqxEZTzP6l50J6Ucjh38GcXJ/+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hN1gXlJDLJZCkBcadDFJ+gi3EQypVekUg+r1MIjedewTFRWMU2MFkWAFPL8+nQbA2J67dzEJo1q1DP/aDEYhseHEhRYQNOF0ceN+caX5Pn4nZwVmMtfVqxcxRsnaxF7yZW/XBBNibp68j2atrEtkxi9Z5xjyoHHlQoBoamnADTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=nihC92+v; arc=fail smtp.client-ip=40.107.237.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCatB8zXfEhe5RzREjb6xxJi2X5MKPbAjFna1gGt3tbMXdPU5HnBnYAsd8BHnX/nEsGPDaR4R1sS9GEfCFIXphq9XVYeE5w0QBKmMvoJPB/PdfTUcGLF+p8/zaC34F61xDHj7xn9Fvhou5Wwdydrg1SNG9ga/eTmQtRQ6P8zVRbNTMa17dngFNOCl6zhpK7pV7l38J7KxziuXPC7YTHzuZsBKdbZ/uepTMUjmUpGp8Dnt61AC0s2Cg16sboOiG6IdUSiKNmH8tE7HU1EJYNpeLUfi3IG5mtrE0c8g+Sm6T+3e5tBfK7LDw06Dq98rtzBKm4Ln+SslsAhSw3iaeSLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uiGQIU/A3Z3ZYKATxPdS4Xr87BjtAlcqy/z+qxPY8Y=;
 b=hvUhanGEyCHraYKmLEiAdVGsZpjLj6v1JoSBd8Bl2kOYzfzOCQc/2Nz8N/KsXnZGEcVF9bhzUDkR9SvpRvjyhDuppCyTUQOj+Nxn6LaAWr/f3v8WuRrijLyZIE2fAQzolDdamqYNiKDEsGqJ4DyVDNx7lfD8rjRN/zlXsYwb45BKUSC+Jph3tnXkjdNhw2uhLiRIcS/2yCN4QJh5oBqRhLT96lTRJbxv/y0k6b1Bbhbki9UH8pd3YoNbvG8889vLhMFQKqkNd/QuHh2tdbyxu706KrBK39R8LYcTNg3gucoYcPzqUfoP4MGVt4DRdRIWJDOFyPAhzrHNlSU8tw62OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uiGQIU/A3Z3ZYKATxPdS4Xr87BjtAlcqy/z+qxPY8Y=;
 b=nihC92+ve7opHKIGKMhP82AtX+NZMTE88AeAqj9MmVhuwVIlju+1lev6VnSzNJmSRbTEk/cl6hIv96CWhNXNZCQL+ESrJWsiOuVHEkTBsBwkia7xOzMel4yHyLuJkQPkyOWwLhU5oRHGjdEej+tXVdjjaOo7S7B0CqW9O+DY/RQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SJ2PR01MB8102.prod.exchangelabs.com (2603:10b6:a03:4fd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.18; Tue, 12 Mar 2024 21:26:40 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::32c0:d77c:f00b:bacd]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::32c0:d77c:f00b:bacd%6]) with mapi id 15.20.7362.031; Tue, 12 Mar 2024
 21:26:40 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: zaidal@os.amperecomputing.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Avadhut.Naik@amd.com,
	xueshuai@linux.alibaba.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [RFC PATCH 3/5] ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
Date: Tue, 12 Mar 2024 14:26:24 -0700
Message-Id: <20240312212626.29007-4-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312212626.29007-1-zaidal@os.amperecomputing.com>
References: <20240312212626.29007-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:907::18)
 To SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SJ2PR01MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 32efdd6e-9c4c-4f02-0d53-08dc42db1b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F+TM/MgicbSAp0P2YNkv5or7CG24Rv+gDmUf6vcWCMBDJG0U2Mp+y7T8G8a9Liza064aXAn6TNularsbkXmZqg03WPFN69jZH0v+aGh2LIHEHnCY+IHY8C1Oe9pKmQnx4qiyJD4M7b29rYhIIo6aXu/kXTuzlHYdRIa+6F5UecXDlMKrXbp3la7D4D/V5cNB0xdyvA1XFnBvTf1HmQ2pYLvvFFRq7W3mLsB6dFVP1frho7T8qdYtcP3slWHgVp40P/KqN2/fYhoazTALVvdtgR+CuVBIZw52mhQZRBdg5URYkOc6N3j3661xfibTypZS/FxSycyDgr2ROF3pXq0eYLGd2XOaWdSkLdiV7SyP/f1Dn1WpTfW8qQRizedGH/imV6XFkt0KltKa78LTl5yvbhDYMTEAiI4pu3zENt9h3VZDa/wIIM7rpAy7vJvNeJ/ivxLnygyfmDBLE3XBmINUj/7+socTSCrgenX73MDBSM/dTO8w/At1m8cfxJcPG5hleJS+72zhTZn2STvKU7EFELU6jMt+3yRGzxags4iLNp3empVT7k++CvanNWII8leiSgDz1etQtRY+ktdJppmVUiyg1vzN8/PUmagNo4j/bYiD4a2QrCHJ75rCmpNstmqWivYCTuWql15mrXj9t6Wu++XEmbKjKROCqYfx9N1HFmhEJdpc9ESoCuWdJ4hsr1XK5+scHIdHZ7RTTt6fRweeCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l6wg2LNzRM4IHyt3zVLTirH0bRgVyCIWMzAGUiJMUq2fk8kaHnB2fXvdIICJ?=
 =?us-ascii?Q?spNdxjk5Mqq6lyBGZLjMiMfsmNjOz6QG8P2wljEVMd71xLazkM5q31o5qjfx?=
 =?us-ascii?Q?Gq6wtNAbU3J4Vpk7B0F7OMqp5uAz6Cfp+ue6a+xk04CE/0/BF34lvZEBSlN9?=
 =?us-ascii?Q?0IjWQNU6HfbwvIcW5HsGFj1tQhEPXTyJibizwy+Bj7zRrNo+lMW6GzYNnwhN?=
 =?us-ascii?Q?yTnmTF1mZGipyBu8yR2a5OlHF2AlyiuSw+132VfjiiixFB3ByPiLSapUwVew?=
 =?us-ascii?Q?ctUg1aE/CSAayEUZZeszF/fQjUF8+HDIoZKvcY6fiHBKSIa03+YdIOUBW+8Q?=
 =?us-ascii?Q?RveCjgeUugH3DkOuN9KsGeH//0+DFjCtJGPOxz2ipTiNI7awhFZq8zys6FaD?=
 =?us-ascii?Q?qjq+IMROF6v+ua6Apjhd192UYkyAz5scrtVOlyCbj/AvWtjrt84aJAeFg1tu?=
 =?us-ascii?Q?yePg9L9nX8A6bPwgh4BVLiPBYfGFwY7AdFkeFStQ4j00hsCpwTX4SWYsauDB?=
 =?us-ascii?Q?lNAOZ22S1WobVPnlPKUlq8SPr3eIK4ZrQGwuSbHu7qb0ubKGhUbqDQgzuo93?=
 =?us-ascii?Q?t30KvepVDemI4BoqXbaGrcXAPlCcpCBh+UPLNv3bwUX2qmz/hIamhyeTKnNH?=
 =?us-ascii?Q?cwpFEOKnYwdfPI0LlhkQP+zeKGpVDvymAkc38ReehyByGEVO0rjqevBFpYNZ?=
 =?us-ascii?Q?+wcJKJahwwjP4qDZ+3cHBPYAc6hVlc3kEyQftuOjU5f3eX0z8f1XNIU7nNhc?=
 =?us-ascii?Q?xbJOKyL9Ifz+kMLYTF54k29IyC/z7Me6rZJcpxt0D7jLFJ9u+DJDRmnaa3BG?=
 =?us-ascii?Q?/x7M9cakvnk0t7pAr88+x8OlzN5jZMaug0rxQA+CJA6zXcbCzcvkFVQTFzzC?=
 =?us-ascii?Q?D2j9rwu3tW/kLwGyD6hbcgu6nE6sEUues703Ho2zDpGXrp8hVP/PCjX1gTMc?=
 =?us-ascii?Q?RZFDj72vNVb5W86B0Dcy9AD4C41BGPAKmOdy+owhO6u5fOh16U3Tv+0hCLic?=
 =?us-ascii?Q?8rZO6luzvdTYuVe3w3H2ugRVtPrzmXEhV6DWDRDI5leNLA7aMAVeNgQtm0wk?=
 =?us-ascii?Q?GJI3sWIfje/wCwsC9s5oMu4zeaYMv94WPnfBMpcTXK1fiqYJgycSw/o4P06W?=
 =?us-ascii?Q?JRUlbenPi6s4ljiOKiIyFAvXI+0O7VCeSE5trwfsVu0fGjqPV/r2HDSAKZPL?=
 =?us-ascii?Q?f21YbbD9On1KpoBp62CUNkl43aOvODEApDaHhGW5IXWsG6bZWsq38+jxrvqe?=
 =?us-ascii?Q?SZqS+7P+tbdxbTCg1cD4btFbW0Nx2qpfADYsjHSKY2S9Wa7Z2qxahyDAtU+1?=
 =?us-ascii?Q?WqHYXh32i+p4hWKCOnY0XeijyI9br4oiOkt0p074cenBiRHkwY7MeM+QVJom?=
 =?us-ascii?Q?IECR9wCafggsyKfvNlLVmkBRT0owo5dWh+s7YdCQvFm2m4iMN0L9Ftn0OGWA?=
 =?us-ascii?Q?bjaPMRem+lbqEifTwA96kvbpPFiSaEttdfmefDxwKQsSq/6gjeSj57J31IRs?=
 =?us-ascii?Q?i90GGtDKfN92a8NefOtl/E5T3upir9sDEgl77hUxeC8Um5KTnzHR8aNbNCce?=
 =?us-ascii?Q?qPzyYVDp/4DUnH2uyJoH0Oh7lBWtcXBMRdb2NzX0MMChhfVs7tksZmH3seM5?=
 =?us-ascii?Q?5lu7CCESfom5ksnSNdVJbPo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32efdd6e-9c4c-4f02-0d53-08dc42db1b50
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 21:26:40.4334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMClVZaNH5a6MGfSW1VDHhfB7b/oaIwcwGi+s2Nk4nzxioNvyZQaPK39Hyl1m3Utc13l+saijgd2bJI5AJIhqY0Jrr8lXN6AvJ6IZdV/Syu32U8tOIEjUNoiFRA1oeRi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8102

EINJv2 enables users to inject errors to multiple components/
devices at the same time. This commit creates a debugfs blob
file to be used for reading the user input for component array.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 119f7accd1c9..ceac53aa0d3f 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -101,6 +101,10 @@ static struct debugfs_blob_wrapper vendor_blob;
 static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
+static struct debugfs_blob_wrapper einjv2_component_arr;
+static u64 component_count;
+static void *user_input;
+
 /*
  * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
  * EINJ table through an unpublished extension. Use with caution as
@@ -810,6 +814,8 @@ static int __init einj_init(void)
 
 	einj_param = einj_get_parameter_address();
 	if ((param_extension || acpi5) && einj_param) {
+		u32 error_type;
+
 		debugfs_create_x32("flags", S_IRUSR | S_IWUSR, einj_debug_dir,
 				   &error_flags);
 		debugfs_create_x64("param1", S_IRUSR | S_IWUSR, einj_debug_dir,
@@ -820,6 +826,25 @@ static int __init einj_init(void)
 				   &error_param3);
 		debugfs_create_x64("param4", S_IRUSR | S_IWUSR, einj_debug_dir,
 				   &error_param4);
+
+		rc = einj_get_available_error_type(&error_type, ACPI_EINJ_GET_ERROR_TYPE);
+		if (rc)
+			return rc;
+
+		if (error_type & ACPI65_EINJV2_SUPP) {
+			debugfs_create_x64("einjv2_component_count", S_IRUSR | S_IWUSR,
+					einj_debug_dir,	&component_count);
+			user_input = kzalloc(PAGE_SIZE, GFP_KERNEL);
+			if (!user_input) {
+				rc = -ENOMEM;
+				goto err_release;
+			}
+			einjv2_component_arr.data = user_input;
+			einjv2_component_arr.size = PAGE_SIZE;
+			debugfs_create_blob("einjv2_component_array", S_IRUSR | S_IWUSR,
+					einj_debug_dir, &einjv2_component_arr);
+		}
+
 		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
 				   einj_debug_dir, &notrigger);
 	}
@@ -871,6 +896,7 @@ static void __exit einj_exit(void)
 	apei_resources_fini(&einj_resources);
 	debugfs_remove_recursive(einj_debug_dir);
 	acpi_put_table((struct acpi_table_header *)einj_tab);
+	kfree(user_input);
 }
 
 module_init(einj_init);
-- 
2.34.1


