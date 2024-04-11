Return-Path: <linux-kernel+bounces-141705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9578A2232
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3A64B22274
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE75F47F6F;
	Thu, 11 Apr 2024 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="LooeFVMT"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2115.outbound.protection.outlook.com [40.107.237.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF77648CE0;
	Thu, 11 Apr 2024 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877536; cv=fail; b=G+AkvrFsW7I3xiR1t4F2EPdckrtu1TEAp5P+G7F/Cwfbfz2NuxSPl8ctL95NkdCM5Y9cH+CClq6ZKaRArjjbZDSFph7+BnuHQC5sRe7Pn+rgqZbCsfcQ0d7mF1VE2nrngwfEvO/c/Qy0kjcWQT8Po0Tx0KEhm+i85oTb9Cj4JnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877536; c=relaxed/simple;
	bh=DvhS//OkESqsYF9ZiEp1tehaeqplFMnPK3ciUw+oB3g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ftkk2SD9jML/pIR1ixX5aCpH/b3HuJrJbhHpbKouK9r7SnG2sAEx6Y4b4DVwx+u2TRKTov38m+1+iRN89Uixr3J+4ciO697PpFxxv0YtUroowybn0S8+D8q13gADPRWbJUkfad53PvHEnlR1GMGPwfMmCGcugC7pz9f4NpkC8uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=LooeFVMT; arc=fail smtp.client-ip=40.107.237.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkT3dpl0lVgpwGbRAzXS4ffuu0ra8wJVWIv6yEY8ukEHL+imJn0afz9o2+CTKHTGeFdni6OE8fXqWQa9aSshikR/j7UxhAzXp+Lv0wEhD2JBvYR36G1UGPOdlemGUHojcYR3RkLnp2Ro3hiKsHEgwNzwxFrS285njiWsU0KVLere6cMNVIAPqqem6+EUCV/MHmu3REdOIxBBc/jNivB4wzR4VD3wZ3a3G/e6l4R4iwV/nH0Sq7QnhiUM9sYUttvUhH7qZpFSITvKgzPMYXbY0/j+s3uuIBNxfLET1xgBhZbESXBPKq5/hkKChWjSdO4oKuSRtWinAxksqDsfYW8HcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0ZaL0LElsp36GNEIoUrGpanbNBfV/ET8+hNbmI1L5c=;
 b=SpEH5eKmkekbh0YtQ2QBjBX0NsvaC44ZrSvlf60YPbSrpXgdthHy/nsTVywkTm6REO5Kxxw6VNNmqPuZAxmoty1TJ2PeMKvLzZKCihmo8wCECMj/Wt+Y8cnrUQuXOBuKWxWbZIH5CUHU7nkz/BdHwfHLIjLfo5nQMl31ZvRDHCiMRek0r9EfuyCTvkV4Eogev/jeQnBxyxf7r5suezOJxFKOivejT+KWl24BXe7Sq+xOabynSu/ArkzeMbH39oCxZ2bY+8mQaBNAmSheIcD7iDcD3gvu5xjARPwcpceo7OZbyAf7yol7oPYxXGXSS0wVQs8dKngooitMfAlLdE2eRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0ZaL0LElsp36GNEIoUrGpanbNBfV/ET8+hNbmI1L5c=;
 b=LooeFVMT+gKWawfTWIW3HEkDiHLu9v/Vs+eu4t0t2MOitHWcIvj+DRmg6oN063qcn4iXRPjP59P52za5IAo+eYHXWusnILGmm+HWjCK8E6hj25RIn1GUUXuRhouc6tr7X8h+BXL8Y0Vzz28Ooga+F98HC4NuL5/6fa1EfA3KUKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 DM4PR01MB7883.prod.exchangelabs.com (2603:10b6:8:6e::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 11 Apr 2024 23:18:51 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b%5]) with mapi id 15.20.7409.048; Thu, 11 Apr 2024
 23:18:51 +0000
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Jarred White <jarredwhite@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	"5 . 15+" <stable@vger.kernel.org>
Subject: [PATCH v3] ACPI: CPPC: Fix access width used for PCC registers
Date: Thu, 11 Apr 2024 16:18:44 -0700
Message-ID: <20240411231844.3306037-1-vanshikonda@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0043.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::23) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|DM4PR01MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 78bad130-3094-42df-e4ba-08dc5a7dbfa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LUXrNWHyaEiIZJwVywMvvSkBlT4AU/zbPcfmJGRZV8n/3GcIuTDYPo5NcpeQfITWJDF8/sctkFHsVJpGePXBI1vIz3mlapFEERStbJR1X0KJWUTLfHe/KA6ZuyU8l9pcMXgsiozSIf2wjcyIXZBDkt6upSOJq12Jl0GSoCNUbfQAcEvMSGDJGWgo5Lo4wWHlmJMyLDCy4Rr2yzrzCHQ3WngTVCN5jlqWZzrbqLrkiLLqjdhwqkbS2pzuzhP8l0WHA9qT3Utn5a843wcXQpB9EUjIxQPDOF/5o7iB4hUpYeXTHuKsZl6kObPB2VNGqgFVhKYJ8ZlIWqwSH+MtScjDyQ8JeE6UXv4JSSSQf7Xg2CIUCkRKeC6xtt+5teg7nUS+NKdgtR4OFmdpGYaMDBkUXMW/sHdnCIiIwoO16GY+vK48rV5ei9PFWKF91WP29va60oH+Q6RbVu5s//TWsRVCrNIjK9WPDtSSjM1hLuqmwhWK1U2YC1RaA6Xi72JxIpJPm5T+ItqUERygsx+m9813qLNY1A4iAd4Z3XBBJ5OPTCykuKkSFZuhHl/ssjUiW5uO9crZOVTQBR6eHAqqZibmAHsqJk4Q6Ar+Jxbz382ef4TSidB1KZeKMfTg1d3dCI0lF0ojKiG87EqljCi3M0m9et3uGPCigG2PoYmKTGRwgAQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qlkzVys9+xRFTWGLIZw9XrEaLmxVswlrXtE5TaMkAFr+HxDm/j8mSTF2I56D?=
 =?us-ascii?Q?oHKS/fH1AZUxINnMQH7hwmbbeCYlP6HfKVDnUPpvP9WIo5/khqQOZ/2hdML4?=
 =?us-ascii?Q?MadivpIzQIn4u4K7ea1UBeD5C03K5FHHipuOrVnFqB8wiuhcaZm+aj0HdYLc?=
 =?us-ascii?Q?PZKTVNK3OQrhzNEKu6W2TvjbEoiRE+UYA42djbab3FcXHuYxtW9Qu+86yYTh?=
 =?us-ascii?Q?6A2yxyZAdSPqLCbiRgQys/csLy4I/UuXbIa8/3L/k+5QFngyni/kSz4xxkwZ?=
 =?us-ascii?Q?ngbFBUisVhODTKZM+hShQ/OsYPhBATyWi43LIX3VoY3MEZmHeV0ichuQ1i8j?=
 =?us-ascii?Q?ILb1VEgV/wpuQqRWlYpQOT8Y468ZxHyHEnt8yrmklFFNkAdsZVU8zgci8C+4?=
 =?us-ascii?Q?RnXJ244SJgZRioIexG0qXPO7X6qBazhV2kl5S4joP7fa33kKZ5UYCx1EKJ80?=
 =?us-ascii?Q?E2IeGwTgRu+SrC3c8J4xcT6JqZa3cibzVwl0EO0C2grn7WvZLktrN+50GbCN?=
 =?us-ascii?Q?u61LGCxveKtrhJybcc0sadL8zcOUp/tRaJq6V5ygXBZy/DWFar5alqNZG8a8?=
 =?us-ascii?Q?zwFkE6zC4aeic8Aj2kL0FbN/mzQSmIdGtuUkJDH5aIsFXRQ71azFO0DMCOaA?=
 =?us-ascii?Q?sMVyRYmuF9srjr8XV1JCijyAF5vucUrorprSYOyK5HwSr3Td+ELapNKIIOXi?=
 =?us-ascii?Q?sg2AT2y9COVD3u3C0RJ+SURdLT0DywVFfuCXAJa80iBoCnYZXplXCmD4ae5Y?=
 =?us-ascii?Q?wPuw7KYgJ3VX6HWMUX2QyQKal4UZw9m5O4JnXnkzatiQZC9P31igWry/sYf9?=
 =?us-ascii?Q?OX6SUrbEemQfByUk4clm0QYO45smhzC5fdBnzh2knfROrXcknSZZQi8DAlYG?=
 =?us-ascii?Q?rJNjL63JRkHpxwUoIj5b+fyE50QEcHp+5ljry54qnp+ucs+0cBx+9pIKCzx6?=
 =?us-ascii?Q?+LzLxtKYujZTwhAXzOeMl4huuFyLyXsvR0x5nrIdg2//wGdAkv7AgWM9u0bP?=
 =?us-ascii?Q?nNjjeotCSWCUSy1/6PWkDm8gDOk3KVMAXymzS33yXFTTX8o1OsexqxL8gyHU?=
 =?us-ascii?Q?gdxtupfKbLZutj/MOPizehyk5nJRWZXMdvw49GF8XYPRSvhKTAPyLGKlby1z?=
 =?us-ascii?Q?fKsjEi2iKdPFvCGmtxeQaKqEg2vKkH63WpoHdvREJdTL42WUx3VWzaW71WGX?=
 =?us-ascii?Q?y9G5zM5/LE8IoNi9zUrXzpC5K2TRb+NDiApMLhy8j7amFwu/zHMFJIqHJTnP?=
 =?us-ascii?Q?o5b/q/vJu0+plKt22zfzRJi0I7E/sgaliOGaOcXlTx1J/HOkyYWOjx8MhBk4?=
 =?us-ascii?Q?nA8I0lENr/6HFhcbJWPqovfGSRL4mRZ0l4vCE1qB5LAEKY5sCv+ru4flvARR?=
 =?us-ascii?Q?FQmEhrqwQsFzQtmdsZMhqB74ACyNx8UHr9qWLTh6/ZMLDvpf/SpZJETYYDNd?=
 =?us-ascii?Q?vCR72B4WiMKRp0cV2iI4i7of8vA8CqyCWoILxwUlbK0Pl9lpdqXqhA2ElF3X?=
 =?us-ascii?Q?KQCRxExc8C9oIyDvVrOW6mHQaXpz8rKRW+LzQ0CuiXqP+HbNQAJBU1xTi7Xe?=
 =?us-ascii?Q?9nEmDQFNcA4oG4sC7veasTvsmb4I9my4gAfZPLQXLRDVylI1nfSRsw7xfj7b?=
 =?us-ascii?Q?4iuancN10nZPDqLujPULzb8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bad130-3094-42df-e4ba-08dc5a7dbfa7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 23:18:51.3985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/t3EfyafWd9tVNChLC1euv15h1SE3IP9zRoJ0CQiYTnlXfyVIxhC4Ue7H3/Y8WU0f07g78LBAR08kIAluOUTVdTAYePbXqzrucDTtjDCgh0eJuZzGtXEPSdfnVYm+Pn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7883

commit 2f4a4d63a193be6fd530d180bb13c3592052904c modified
cpc_read/cpc_write to use access_width to read CPC registers. For PCC
registers the access width field in the ACPI register macro specifies
the PCC subspace id. For non-zero PCC subspace id the access width is
incorrectly treated as access width. This causes errors when reading
from PCC registers in the CPPC driver.

For PCC registers base the size of read/write on the bit width field.
The debug message in cpc_read/cpc_write is updated to print relevant
information for the address space type used to read the register.

Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Tested-by: Jarred White <jarredwhite@linux.microsoft.com>
Reviewed-by: Jarred White <jarredwhite@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: 5.15+ <stable@vger.kernel.org> # 5.15+
---

When testing v6.9-rc1 kernel on AmpereOne system dmesg showed that
cpufreq policy had failed to initialize on some cores during boot because
cpufreq->get() always returned 0. On this system CPPC registers are in PCC
subspace index 2 that are 32 bits wide. With this patch the CPPC driver
interpreted the access width field as 16 bits, causing the register read
to roll over too quickly to provide valid values during frequency
computation.

v2:
- Use size variable in debug print message
- Use size instead of reg->bit_width for acpi_os_read_memory and
  acpi_os_write_memory

v3:
- Fix language in error messages in cpc_read/cpc_write

 drivers/acpi/cppc_acpi.c | 53 ++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 4bfbe55553f4..7d476988fae3 100644
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
@@ -1018,17 +1018,22 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 
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
 		return cpc_read_ffh(cpu, reg, val);
 	else
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
-				val, reg->bit_width);
-
-	size = GET_BIT_WIDTH(reg);
+				val, size);
 
 	switch (size) {
 	case 8:
@@ -1044,8 +1049,13 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		*val = readq_relaxed(vaddr);
 		break;
 	default:
-		pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
-			 reg->bit_width, pcc_ss_id);
+		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+			pr_debug("Error: Cannot read %u bit width from system memory: 0x%llx\n",
+				size, reg->address);
+		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+			pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
+				size, pcc_ss_id);
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
@@ -1076,17 +1087,22 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
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
 		return cpc_write_ffh(cpu, reg, val);
 	else
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
-				val, reg->bit_width);
-
-	size = GET_BIT_WIDTH(reg);
+				val, size);
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		val = MASK_VAL(reg, val);
@@ -1105,8 +1121,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		writeq_relaxed(val, vaddr);
 		break;
 	default:
-		pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
-			 reg->bit_width, pcc_ss_id);
+		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+			pr_debug("Error: Cannot write %u bit width to system memory: 0x%llx\n",
+				size, reg->address);
+		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+			pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
+				size, pcc_ss_id);
+		}
 		ret_val = -EFAULT;
 		break;
 	}
-- 
2.43.1


