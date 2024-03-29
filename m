Return-Path: <linux-kernel+bounces-125471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 335C689268B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581851C210EB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1861D13CC5E;
	Fri, 29 Mar 2024 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="O0h1z7YS"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77F048CCD;
	Fri, 29 Mar 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749676; cv=fail; b=Be/F3ZdQwrw047hfethP/yAoBTkvyUF6QRap9ZyZmNUiTymYNCKBecMS6f3nClWhP9TU/SdVtMa3u0uqpd1O0oDAWUJSh/ZQ1FnPk63mjkHBJnVgt0HqcfsmoNhJXMX8rfSnzAPzVi5Ae/ectPLxk+Xa1rpvvdA1apG6Q9vcDcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749676; c=relaxed/simple;
	bh=HJZRi6jWSO2n5SP7Apyp77l4K071wxQZzQcrvt5o0Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EjzLvZQnAbYI9x5xGDCElTudAzsk2m+/X3BokMAkm1kXA2nABgnPFev+3aE9HC1ABOW9Qcf5hJiKdH4FFTrUuU78dy9seKpmszpTCv81U0/kvkJ2YHW01fpJjFBC6hsP7fvi8VANaoG4n1qeCDnNkzTN9Slmi6YWEW+tz04yPAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=O0h1z7YS; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guHHZ2i0kOiswygLGQ0fPTzCIUWpEULHvGG28sQucD8QkbzJ+B6nbKg5y+hSckBQ3UnqPpuSdYCKD8BO0dtuKPAvE/91PoPZWqbv+nBnAjhPrDwNruk1ySvaYgoZ1xft8Xyi8I9Q10tRUWSstLU+p4Fxvr0vFbSQSK4+WNPN6L7TfQGyU7yt33C113N8gZ0+HCEHFfC3RRM1K7Ea+xRi51H36MSvX+UN4lR6iF66oQGK4T1lCvJmnIYY0k3Mv6+Gl/g7wditUkwdyerPsx9wrx1EKX1IQVgjIEDYwwS+ZEB4KDjNkNJyFU1rD1QogQBsCRF7Y/VfIGMw+CM9ID7/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/8Q+41xpSk8U8z62Yf+wqZxjJFUbzgLX5Jaxm5Rsa4=;
 b=iVu1QTtKe32LCCZ7lu6okG8Th9KNJP0cAqAi8fcBaUsgp5tGzrmbHFXnYp/eZ+18twPdy+eUUkhezcgSBxIegWcwt3VsaDtpMdq0nDHBVTgRb2CDjmc9DmHkG7zLZqaQPQa/tshe1sOvyuvsdJAzgQ1ZSfahPgwuYZ0C9UCqZx48X9e348scF9WF0kM4v6vsrbfewQHduayh3svMRNaCOlsCjo6iM8MJwarVXx4Owbxg/dn4gUFgFBHBwjNJwb9monsOxHJx06HizENno1cVTf7FBWkuWEzo6cjyLxCOMxjycBL9aSPt2TL0/cxuEmiwer3mZEqZrehUajQs2HUYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/8Q+41xpSk8U8z62Yf+wqZxjJFUbzgLX5Jaxm5Rsa4=;
 b=O0h1z7YSJSAh0oZWVfHvV0xqNaGqnlfGSKfaywkPz3wxWyuAKIFrqt8jjdOtvhxoMaUMpXcEx8TJ7Sr8OUjxPzP/NEYVNLrvLh5D5uwBd2e1YupWstMRUful1HzYg8TWqLGxgKFS5GWT/5MluzDqGSz72I/fTGyr30EF4QJb3FE=
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 SJ0PR01MB6222.prod.exchangelabs.com (2603:10b6:a03:292::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.38; Fri, 29 Mar 2024 22:01:07 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b%5]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 22:01:07 +0000
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Jarred White <jarredwhite@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Subject: [PATCH v1 1/1] ACPI: CPPC: Fix access width used for PCC registers
Date: Fri, 29 Mar 2024 15:00:54 -0700
Message-ID: <20240329220054.1205596-1-vanshikonda@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:930:4f::27) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|SJ0PR01MB6222:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	js5/uXJliDVl3klsQhjQ684ijzwZAn6k5J8g2mTfV0NBpJHJhfcQ9PdGezBbzPgikwDc5NJtQaloGUxqXQTxI31pOF/voAMfELagTgyybZkh+5EGks8bDpvI22kVYnvg4gUFL6GzRExqkN7sPG6I/rtSQVtpxiOaT50HKcfPsPJFwte58/eh4OGERDYIq2Xx44pPg95BNUX/aFDgkTqGm4hQ9Rb7UT9NdVPNRklAe87CzfO/xeuBat5rEwVDilXyjazUb7IHQ2n5u4y0B6EoZ9Vv1H0IN/dfXZV7obf2ft0ryPFBH+RdxnQsWgQsXzmXL8/+D/YPT9AdNuSEsMlLB4qasZdNSiUMUT0HP6WBUJ4RlVpixxjoG2JWQiaSD9lYWd3XkA5QqJRJeyiY537De0n39/zHqTnfnMc91mYGblxtgi/vXXYP61qC7nUYhK0KeAyTIr/JtWskISTFecDxsDQA6GZABYbUw04S9uGoQjC32Myuvk3rK5ChMWAbQ3OrHo7vxOG9z3VyXIbnyomBXyUN8FhHTpK1HiohukQWc/6aDYQyNZN2TjdgBYGWfdk1jXeuwf5c6/Ccc9UASTjLwmiar0Jb9sTTVairJDqjN9UMddNQvXiS2jyZ9xwC1uJYeGMANx9ACYpf98rDz05TWtqoCv+bMNYc67ps3qWm7Us=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EZN36iqlDpIxui9Dj0ANE3WBTvmG+TaX9J/Ai1mR5J8K3EDvYF8CI+vP8Fb9?=
 =?us-ascii?Q?1vgJggTvfS+4pVMDqcjQnqIXrAMveJnMb2eF+YB7uvWbs/7+6vnHc57pOePe?=
 =?us-ascii?Q?5oI0QFpvqtg+/684PrL/ebovcLPGXxRta/SUOZqjm5zymaXI3FANuFo3ao/u?=
 =?us-ascii?Q?Gj0rYR/Q0gSuHI5UoLGxeXU8q7LqcG2QTswS5SUEgP1x+iqDfzKxpNQEPdsh?=
 =?us-ascii?Q?vNjPmoRCvsK4K6BdCkn8/AiUPMJLjrJ+87H0iAJ+KBWyN3nQFBEmyEbrEHAL?=
 =?us-ascii?Q?0rpN3++AKu94loixokq/C2yikasDGKz3TjO64nvCzwlitt/UjmgmFTjegoP2?=
 =?us-ascii?Q?9tcK6n5KgaASLlaUH746lEZ+6h89Fl89HljOS7+z+hBQbkg7BIc6QvPHVPLo?=
 =?us-ascii?Q?nmVS+0yxpZqogW57lYhdl0Lg5qkbTZy5ZJjRq/GhYQuY6+oYiT5iSJ942gBc?=
 =?us-ascii?Q?iw4k1Ny/P5P6oA+L+1GxbRRIcWHPAOcFAwvwOgp8YD6V/+GHDQPZS3xGP4Je?=
 =?us-ascii?Q?k3SZFyqlGXFTNtq40AhZS1zZ6sqzXjV3ePUEBqpGsJ73cDLO7DZQQqGZI3B1?=
 =?us-ascii?Q?bGYSZNgC3I75qhaxfn1reC0D+4+05EzC92/WBQ0imcs42VTWWK/icI8FMjQo?=
 =?us-ascii?Q?gth9IIk01M7PiRuWDkesmFGkqAtLvdsT3Ln3b+3eMVZTJE7ib5rFbMzc+NfL?=
 =?us-ascii?Q?FLEdqOcHrwB01HxwtYcKkMiFkLkO4sh6pJH8i6tVuZoILfMe9U0RAA+Asrlc?=
 =?us-ascii?Q?F6tHEI9NQMNTEQO7ACeUppGyT96BZDQTolCC+cizjGCf5sdiQv1SEMaNFFhZ?=
 =?us-ascii?Q?VfvrXek8gTrKNaGzoMEFYFrS8HcQ5M2w8JLnh/MwQx6zutodWLfUVpiluzVf?=
 =?us-ascii?Q?/iF14IhgusPZ1BdVlLp1ouNUYq/r3Nz46yb3k3z/KwR79otbXUOsMY49zTa/?=
 =?us-ascii?Q?vXOJlleHw1vm/SnhI8dYR7J60L63Z5KXOR5N7mAhg5Y9+rC+7Rr8xiX3pEvG?=
 =?us-ascii?Q?H6yhrX5iI/CMXt3KgoDQ9jo7l+voP2pEl27ZSJt/E4MEXTgGKbZhXkCGkpNl?=
 =?us-ascii?Q?q/dC85sR7sTM0UXofAMsT+1M9wBFJxkgO7/jhjIudCus1ybsTu/tqJlZg61t?=
 =?us-ascii?Q?oPhhx96ffVdzJUWI+TTLcPKPjLDvTX7PWuzp8bObINRKdU5yQ9iTSP74G0Yp?=
 =?us-ascii?Q?9IhgUuuHW65Ix8X/zC+AF7HXhAc2wParY3eXteLmQ39rAQTHm9eLuAjt1cLo?=
 =?us-ascii?Q?uQE4+vPcXJIyhdDpNDSyL/r6TIkFtio3moLOqv94yp2+YAYv5wRxElOeVxCY?=
 =?us-ascii?Q?w669GIxjNYAd11Aoi/sEI5wyMVWWRJ12jKWenWkj5nBJhWPUg+pQGlBae6pV?=
 =?us-ascii?Q?bOyAjVq6YzourAEkDNFfUh9e57iIOK3jznPFvF04A0FCtoUKLrMWp5i/0ZEa?=
 =?us-ascii?Q?J4LY7v4sI5winymT8wQuVzSAESwZXz8G8bNjT3dMAH1i5RNYbnyYZdfP2Y+D?=
 =?us-ascii?Q?KB4J4pkYjZ9RhKM4zpyNN/WQpaQ9FWe+DdGdSouZcTjwBumNl/vFjrP4Usxc?=
 =?us-ascii?Q?U4plqSy2+49DpWbXg2MtVgH8RpPsUyuXhC2o+e7vxKmWy65uqTU/zvUihAhQ?=
 =?us-ascii?Q?YfYyx73+PBrrcqZB4t7tbD8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f4d4b9-d30a-4151-a52b-08dc503bbc66
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 22:01:07.4891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0h5Hnt+9ZoUp5PK+zt6NIIjBrb/EJ/7INhOCY8xYuODi4CvXR/xRIxx3A6rxHlGL/VlBXAGLlfeS1RAfdtfYzC+chQCAJe1/vWWzaRO9U6ZfJGpV2j6yxUjNFqlHxUl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6222

Commit 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for
system memory accesses") modified cpc_read/cpc_write to use access_width to
read CPC registers. For PCC registers the access width field in the ACPI
register macro specifies the PCC subspace id. For non-zero PCC subspace id
the access width is incorrectly treated as access width. This causes errors
when reading from PCC registers in the CPPC driver.

For PCC registers base the size of read/write on the bit width field.
The debug message in cpc_read/cpc_write is updated to print relevant
information for the address space type used to read the register.

Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
---

When testing v6.9-rc1 kernel on AmpereOne system dmesg showed that
cpufreq policy had failed to initialize on some cores during boot because
cpufreq->get() always returned 0. On this system CPPC registers are in PCC
subspace index 2 that are 32 bits wide. With this patch the CPPC driver
interpreted the access width field as 16 bits, causing the register read
to roll over too quickly to provide valid values during frequency
computation.

 drivers/acpi/cppc_acpi.c | 45 +++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 4bfbe55553f4..23d16a1ee878 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1002,14 +1002,14 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	*val = 0;
+	size = GET_BIT_WIDTH(reg);
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-		u32 width = GET_BIT_WIDTH(reg);
 		u32 val_u32;
 		acpi_status status;
 
 		status = acpi_os_read_port((acpi_io_address)reg->address,
-					   &val_u32, width);
+					   &val_u32, size);
 		if (ACPI_FAILURE(status)) {
 			pr_debug("Error: Failed to read SystemIO port %llx\n",
 				 reg->address);
@@ -1018,8 +1018,15 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 
 		*val = val_u32;
 		return 0;
-	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
+		/*
+		 * For registers in PCC space, the register size is determined
+		 * by the bit width field; the access size is used to indicate
+		 * the PCC subspace id.
+		 */
+		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
+	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
 	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
@@ -1028,8 +1035,6 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
 				val, reg->bit_width);
 
-	size = GET_BIT_WIDTH(reg);
-
 	switch (size) {
 	case 8:
 		*val = readb_relaxed(vaddr);
@@ -1044,8 +1049,13 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		*val = readq_relaxed(vaddr);
 		break;
 	default:
-		pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
+		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+			pr_debug("Error: Cannot read %u width from for system memory: 0x%llx\n",
+				reg->bit_width, reg->address);
+		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+			pr_debug("Error: Cannot read %u bit width to PCC for ss: %d\n",
 			 reg->bit_width, pcc_ss_id);
+		}
 		return -EFAULT;
 	}
 
@@ -1063,12 +1073,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
+	size = GET_BIT_WIDTH(reg);
+
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-		u32 width = GET_BIT_WIDTH(reg);
 		acpi_status status;
 
 		status = acpi_os_write_port((acpi_io_address)reg->address,
-					    (u32)val, width);
+					    (u32)val, size);
 		if (ACPI_FAILURE(status)) {
 			pr_debug("Error: Failed to write SystemIO port %llx\n",
 				 reg->address);
@@ -1076,8 +1087,15 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		}
 
 		return 0;
-	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
+		/*
+		 * For registers in PCC space, the register size is determined
+		 * by the bit width field; the access size is used to indicate
+		 * the PCC subspace id.
+		 */
+		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
+	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
 	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
@@ -1086,8 +1104,6 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
 				val, reg->bit_width);
 
-	size = GET_BIT_WIDTH(reg);
-
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		val = MASK_VAL(reg, val);
 
@@ -1105,8 +1121,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		writeq_relaxed(val, vaddr);
 		break;
 	default:
-		pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
+		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+			pr_debug("Error: Cannot write %u width from for system memory: 0x%llx\n",
+				reg->bit_width, reg->address);
+		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+			pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
 			 reg->bit_width, pcc_ss_id);
+		}
 		ret_val = -EFAULT;
 		break;
 	}
-- 
2.43.1


