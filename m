Return-Path: <linux-kernel+bounces-100801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AF2879D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65505B23AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15F3143C46;
	Tue, 12 Mar 2024 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="u29DjRRv"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2126.outbound.protection.outlook.com [40.107.237.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C5143736;
	Tue, 12 Mar 2024 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278805; cv=fail; b=Gd6a3X66dve3rljdvoAnIgPOJivTgI6fCM+/YQqbAUgv2RCxNA7AhWqQvqdwIgM1mLFNUFKPG5Fx0xIExlw3NTij7oCTNsoDo+v0EnAOVUlek6ANvswpe/4fKx7bkOsjBQa+P9nTDCnMYGDiGxYlA864GiqG5sACOWtEoBhL6XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278805; c=relaxed/simple;
	bh=jy2Nbs7wx3OEKREZuBRlgCIg3NMfGpVhAbidgcXQoxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jm3tVUyCfA/z6T7zHQxo8WJbVPw8joogHFQR2EZKVdIx368KfH7ZXwE3sURYSU22PSo1N+BF2rus5xrkIx8u0cbBswWcgtd0AzwllWG7i504SzR/CkfY1rAUSGxVMVYsSP7A3+S0UoOTQPXtQtiEBiagtWwp6nVR24qQT4GiRhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=u29DjRRv; arc=fail smtp.client-ip=40.107.237.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1eLP6o2JIKGDybAU1HxaV5cbE/CSz8c8waPHwmpuHesU3vmg0gPJngQKDf+io3Iy0AZYZzbwB9wvbdHkqe5Aa7K8glXh7VQ3Vn0IzeC4ulfCdF7ZfLNwZFxrdD95UUWBWQpGGcMQc310W380plpw5zer13bSWUgAM2j7Zmp5V/iOcmZVcIUH/bEg+eGo06NE+8GqDogMw9W4YMdRmFhe33pz+NaL4N52i+rbNF0pjU0DAcwi0oxIVBFMxbmgadrgVXaa6J9Spp4iZDBf0wNLm+834x01Ii4UU796BsN4KlDtex3ajrzd6QegJBV4l7SmYLARdeV3zWOHvOaoHqw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNfGY6PYHTNwvv3RKekdKVsmPafI2kCRy74YtRcvR5Q=;
 b=JEeAZ08Fjc2pp+AGKnQZU1wXVQ8hxOhTmkph1V9lWuZBKr6v0CoWRjvGhuaV5QA/R/xIf5Iwk58Vfg+rYiQk+EjZqBI/4rwO/Zv7qi4y5RhJ7BXuGMbVbYbtjbmBw7oqexjdJLz54ZKuNwg2OpV2WJomMAOzFLdHc5Y2TxuSlbDOQw3nD9oMxVir553btelmxH4G9GGaDTYdvt0UB4ywVxddkc5inJnVA5He/7UpsMpJ4QeF9lFmhwCjIJgjEr+9aqK4t+zYHZg7BaLD6P8OtWvPVVy9pbpEJcORNkT39D81ttFXJ8z0a512BRCodi82pvWiHE+wpGJ1lfxTMZzJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNfGY6PYHTNwvv3RKekdKVsmPafI2kCRy74YtRcvR5Q=;
 b=u29DjRRvDEOt2RYPNV606NTIaNkg36EoxbV1n1tkiw4t31KwGC2ZcJUin28jzjil9H4r46cPx+Lpgkz1D5oiqwdZJxQWli91xTa+JgCA3DxK7wELQHrJk+UZS3zJsaJG3WT5WTnmTQ7jKQnTo5GoGstu9tUKaH6A8fiAXcsL9Gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SJ2PR01MB8102.prod.exchangelabs.com (2603:10b6:a03:4fd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.18; Tue, 12 Mar 2024 21:26:38 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::32c0:d77c:f00b:bacd]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::32c0:d77c:f00b:bacd%6]) with mapi id 15.20.7362.031; Tue, 12 Mar 2024
 21:26:38 +0000
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
Subject: [RFC PATCH 1/5] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
Date: Tue, 12 Mar 2024 14:26:22 -0700
Message-Id: <20240312212626.29007-2-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3e1ed599-288f-45df-ba07-08dc42db1a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sCU3T+uOjb2IpKqBXGrEhhD9R7ajTRmPLvr4kMV8eo4wceGRzrxuYTHg0M9zT63t4bt+M5foED/GJzWEXmdjXt1m/eUYzqGa/yEWTGNdlq2gPoLMqggd1yxM/OICOyveExC0V51V4Qkvst5TMtftkdGtWm55eexzi4LYHu4MUykA6jCylDSzqyN1IfP2gYtN7byl74svgYA665Ob54m0rCLRd5f3hzoyvNn64brckpPoNaGdpnJuYzeOiLcaVy3eop6nRJysRn1pgJTP/HW8PWFVHLGvAUNitP5dSsyGiAoXVforXa8T1TLc2BJvPhEJTqxK/KMgsIcNN1bzO76eOUg5gd2KvDtrG9KaY1xfqdTmEBCYHZcN3p2SWx7TRnC8vJN+1htFABc7me8DkGvy/F2TtvBqnAuK1ChxY4L4V2zTEbY5Aw3Kg/xafjQujEL+ZRt5lR/XvwkQwF/844ZSgzFsOns/vnEBlpsYHiCE4hjP9YSakBEXE4KgLe+RPqU71qNaiPbH/dqsiTlrNRpHUTXeNQqxjF30Jj/US0Lcyo5Nzdra7S1pppVKa6uAl0N/CVzDIxo/4l60lNp/lza5mkDgUDgUOMxTOxDIjDw6MeMFFDqE2KZY35BuMhYOwDXGVFHITV9JHDudRwacVwsP3fVUA9a+9LMFGrqiyLH5PQLksv0+S8bH/VZcmDkZUQISgsNBoR1B2ySey0FFjEBzRqsFOUTmVTtEKImh/wWdvwY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+FIXpn1KDn2NJmm0vQwplmjCqaukPSBmXcOqBCwNM7jKWAW+NUQzblazBouq?=
 =?us-ascii?Q?g4KskdTBPkK9GVYeKbuodTFVFtajIstCSbVpZDJ84gT8+QuHERFF2/jLMIFf?=
 =?us-ascii?Q?JBxl9nbMGN+OcIrg33piqdzhsNi0Kbjf4KDgsn6B0x0UpQclKBrskITHirCH?=
 =?us-ascii?Q?LN6gim2wFpvymiAzbRBAd7S2L3SnZkMkp+CHIpHsf9JuK3D1ps74SPo87yLX?=
 =?us-ascii?Q?QfhbgSDFJCIvKmHvVLXsbh3KBOOFzkOWqGsSoqJqcrqsa/UBBAO19Epm3Dn2?=
 =?us-ascii?Q?CnWLi5jmSIVO62c017EbYxEgZ7dKEAm+QfbgSZa8ioFUFcTcnzhqYd6AthcX?=
 =?us-ascii?Q?6O/O0Me3XOxzw7JQFAkiPmsEzaHtkYRQv3Xx/anCT7b/i4HwDIr9WJW3Jc/t?=
 =?us-ascii?Q?RGu6Rj7RoFaQLkV2QAqzEsuHyYePdUfquk8cZhWcmQRGlU9Tay0SumjgpOOd?=
 =?us-ascii?Q?7N/B4UB1cOKAKhC7r7V4cqx4d8vzl6UA8bamkg7HK38bcc9rjuY7hq5UXOq3?=
 =?us-ascii?Q?O1k3ZzdnhZZ0pr1sNCNqh7D6macfHxb2TJfaz0I4XFZkDIaaqfGOenThPsMD?=
 =?us-ascii?Q?8MptpbUr0Fa/YkMmwdeUVQ9UKYjVBfDTdDbP0lY5i9eJlsqWZL5M86M2ne1a?=
 =?us-ascii?Q?1hefXM5T3u+3EDQ1O0xaUp/u/gswwaiAFj98HwC0pSxvLAP0yl03/cD6Qq2B?=
 =?us-ascii?Q?S/8OwWWRYxZAqMTWMuu68/UJMXnY8Cps8uODMVO15KIjg4mAYuTsY6KKRuYn?=
 =?us-ascii?Q?QoX5PxgnCfgrW3M/8s+5v5FOGiklrcyUrb769Qkh9+DTAvc9sacxaKez1twB?=
 =?us-ascii?Q?E9x6B7XnXP8R15W0ic0XHbd8Bqn169QUa/1Tjs7LpX5Z78qMZYa3hLRp7cAO?=
 =?us-ascii?Q?JRl3QzpmrHgQuGFfMa4IEIe1f4qQ7M3WjFpqb+Fu6+Y10cOAQxQ0HfTUlTiI?=
 =?us-ascii?Q?8+/WwuZbVFbTYitVeYZ96eeHCOnDkxm9jADSyoXsFSE5o03MKbOHY0HKJRA/?=
 =?us-ascii?Q?02EVB2MBsbcKlve8Q81bH2lVW1YcHGUQcaymfDnA1pydvtNRyPoaqXv+ghA5?=
 =?us-ascii?Q?FItwKyer8de7B0jd2tr8J47t0FmJ0sUn0sQePKyvxeT+DeWXRECXUTL+7ZsD?=
 =?us-ascii?Q?awXqZX3jcTvNS7ChqWnE+KllCjHCSjXX+fx+J+smBH9asA2Vnx1h/idkZ4wh?=
 =?us-ascii?Q?/iLi8Ye7q5z0zaXMnqnJLnwHwUB67CnjbVzBbPDXdBZst8+6Mc5NLw4JN6ZB?=
 =?us-ascii?Q?DSoYLgMHxqBJrlL6oqkZMc36lkn0Uq6gmuX2FB1IGuDb5AtEctOW49BMfr76?=
 =?us-ascii?Q?0u2sQhzi+NTq+AP95XaV7Ddqw/SsJ/4kU3OXPYHSpJlfcEGCrfVW02FHND/q?=
 =?us-ascii?Q?a7A3APJfndmOsR0HqdHMZnVExbStB529xI00qI6jK+iafHmuPkAel90IpDja?=
 =?us-ascii?Q?oEi5Fb1r/udCDnPWrOmWs/Jh9mhgUfuDQ99F0GpOq8YBVezL1gcNfekoNYZb?=
 =?us-ascii?Q?bRk2xUnAr342JlTE3Yn/5dysfyt5RFBpUsaxoqn+0j6/cmNhJcqNfi/jMxdr?=
 =?us-ascii?Q?RmaTsoZG94g66GM6Qw5iQDKfluDoUKrbzOX35iGBBpLKWU2LIRbdc7c1HSa0?=
 =?us-ascii?Q?9siA7QOIMp30L8qJNFI8zes=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1ed599-288f-45df-ba07-08dc42db1a13
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 21:26:38.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onH7Re8X/I/yjCB0utQ5u4/mIHMYyBc0rr9OImmHwmCRnFr33RNJ1b8bb8f22kgsZXOhISTdC9c//VwxVIQ1U2lAyYAyvOJ+GNUqGDaZbW7dUCIpximBgqyPfowVVZ+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8102

EINJv2 capabilities can be discovered by checking the return value
of get_error_type, where bit 30 set indicates EINJv2 support. This
commit enables the driver to show all supported error injections
for EINJ and EINJv2 at the same time.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj.c | 37 ++++++++++++++++++++++++++++++-------
 include/acpi/actbl1.h    |  1 +
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 89fb9331c611..90efbcbf6b54 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -32,6 +32,7 @@
 #define SLEEP_UNIT_MAX		5000			/* 5ms */
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
+#define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
@@ -145,13 +146,13 @@ static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 			   EINJ_TAB_ENTRY(einj_tab), einj_tab->entries);
 }
 
-static int __einj_get_available_error_type(u32 *type)
+static int __einj_get_available_error_type(u32 *type, int version)
 {
 	struct apei_exec_context ctx;
 	int rc;
 
 	einj_exec_ctx_init(&ctx);
-	rc = apei_exec_run(&ctx, ACPI_EINJ_GET_ERROR_TYPE);
+	rc = apei_exec_run(&ctx, version);
 	if (rc)
 		return rc;
 	*type = apei_exec_ctx_get_output(&ctx);
@@ -160,12 +161,12 @@ static int __einj_get_available_error_type(u32 *type)
 }
 
 /* Get error injection capabilities of the platform */
-static int einj_get_available_error_type(u32 *type)
+static int einj_get_available_error_type(u32 *type, int version)
 {
 	int rc;
 
 	mutex_lock(&einj_mutex);
-	rc = __einj_get_available_error_type(type);
+	rc = __einj_get_available_error_type(type, version);
 	mutex_unlock(&einj_mutex);
 
 	return rc;
@@ -221,9 +222,14 @@ static void check_vendor_extension(u64 paddr,
 
 static void *einj_get_parameter_address(void)
 {
-	int i;
+	int i, rc;
 	u64 pa_v4 = 0, pa_v5 = 0;
 	struct acpi_whea_header *entry;
+	u32 error_type = 0;
+
+	rc = einj_get_available_error_type(&error_type, ACPI_EINJ_GET_ERROR_TYPE);
+	if (rc)
+		return NULL;
 
 	entry = EINJ_TAB_ENTRY(einj_tab);
 	for (i = 0; i < einj_tab->entries; i++) {
@@ -615,19 +621,35 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
 	{ BIT(31), "Vendor Defined Error Types" },
 };
+static struct { u32 mask; const char *str; } const einjv2_error_type_string[] = {
+	{ BIT(0), "EINJV2 Processor Error" },
+	{ BIT(1), "EINJV2 Memory Error" },
+	{ BIT(2), "EINJV2 PCI Express Error" },
+};
 
 static int available_error_type_show(struct seq_file *m, void *v)
 {
 	int rc;
 	u32 error_type = 0;
 
-	rc = einj_get_available_error_type(&error_type);
+	rc = einj_get_available_error_type(&error_type, ACPI_EINJ_GET_ERROR_TYPE);
 	if (rc)
 		return rc;
 	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
 		if (error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
 				   einj_error_type_string[pos].str);
+	if (error_type & ACPI65_EINJV2_SUPP) {
+		rc = einj_get_available_error_type(&error_type, ACPI_EINJV2_GET_ERROR_TYPE);
+		if (rc)
+			return rc;
+		seq_printf(m, "====================\n");
+		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++)
+			if (error_type & einjv2_error_type_string[pos].mask)
+				seq_printf(m, "0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
+					einjv2_error_type_string[pos].str);
+
+	}
 
 	return 0;
 }
@@ -662,7 +684,8 @@ static int error_type_set(void *data, u64 val)
 	if (tval & (tval - 1))
 		return -EINVAL;
 	if (!vendor) {
-		rc = einj_get_available_error_type(&available_error_type);
+		rc = einj_get_available_error_type(&available_error_type,
+				ACPI_EINJ_GET_ERROR_TYPE);
 		if (rc)
 			return rc;
 		if (!(val & available_error_type))
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index a33375e055ad..a07d564b0590 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1030,6 +1030,7 @@ enum acpi_einj_actions {
 	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS = 8,
 	ACPI_EINJ_GET_EXECUTE_TIMINGS = 9,
 	ACPI_EINJ_ACTION_RESERVED = 10,	/* 10 and greater are reserved */
+	ACPI_EINJV2_GET_ERROR_TYPE = 0x11,
 	ACPI_EINJ_TRIGGER_ERROR = 0xFF	/* Except for this value */
 };
 
-- 
2.34.1


