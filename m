Return-Path: <linux-kernel+bounces-141625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9811E8A20D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4AEDB216FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B758539AC3;
	Thu, 11 Apr 2024 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="lYMjxSdg"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2136.outbound.protection.outlook.com [40.107.236.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1937205E0D;
	Thu, 11 Apr 2024 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712870597; cv=fail; b=GMi5qFnUWFtE2bi8TynaK8trPbAbOoN+8/09paJj/eNBJAbWp2F8BmXaoDORUpdp1HSuIjZBj7QBrzNVhPTVllK8iiHPSJeKvCpSwZMqrO0pfZHqaL3kOjiXzkMl40aTF+Xn/FD5fUJvbLUkDLcUpKk2BFw7i/snH0D5XxKs4OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712870597; c=relaxed/simple;
	bh=e65CuOU5MD7ODC5XbPiiT/TV5KT4/44yIhAxuQVo7iE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NUI3L8kCQGyoZTsseNj+s3za44MpcAOdGri52TBIFFAV8MqNkNWtPlJqbuGU7EIL5UyBf+iAaApY4OCQS0ZR10e1mrIdWp1Wb3MVCM8XhZ2VSvP+BDs91r3weCr2kbLcnQPSZW9XDpI2mbJDmhabLmZeR4zQJz1kMayJxfyYtrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=lYMjxSdg; arc=fail smtp.client-ip=40.107.236.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5GhND3FhT2YcMSUToOlQEv8nXb3UUa9v04wJIUNQ6n813ctgRpfW9Dh6qXCP/HB2TDDstt2o9rQw4MbOOF3O/JjcFBu3jpH133Gx8S5d9wrhDoSgYHd7b0Ljm6vUmXAA8DoFkONLfGmadE2ej57BSMD+EfsSWPLx1o8Ntt/EZ5PzHMKsPg1zyeAM7shQ8QHQNQh8cwokzhufhMlM+QYVhPZVdR9CVEU+vwb1U5RPHe1saOE6V/4Tt6qeJdd3H2wStuDbpg0x3ca5t2lHn+FoIMqXcmYfd0Bq9bMH5lM6dPobdX7h0ZiE/Geb0hgdYd3yfsNrg6vvVHK3LeEfM46EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28qqhRrAWogChWLn65zalKJml1ysEKJPLnucucHWJjs=;
 b=hHY0H5jnZ8gDl9oHlTAwu4k5x1+9O4FRnsBXWe7FiOzjKDBhVqSL6GNg+Mbe5ekCf31k9JrXArW1YIuwIB3UWbEMtv0OlKRxy0FTOy5HSf1wSfSdTiKOXFz5rDNCrPpED7V9fQl+S91kd0rHlGbM+35Ud9tM6drPRlZOC/fn6i5ILyourYUnU0Y8D263AmRNasm6uzImXJiibkhFVoRfXVRZ4TMeEBhGs6eZpEgAm+Alys36Q4TD9fZg7QoDvQkoedtNYmxjiWzAJBjqr8kFuJUEqATr/91ZEqpTu+LHxRyJr9hIskpguGfc5KTVZjyhvv4nGYnxh7EVKLcZUBr/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28qqhRrAWogChWLn65zalKJml1ysEKJPLnucucHWJjs=;
 b=lYMjxSdgG9lSDNjkiY3YuttPUW6Ph/l53MH8kSEYcXAfBuZg/GavBhl9mSRpay8HiRUrnuxvCE1WjA1mDciRYm0oYZLdTELQqQeeLQEiAF0S+e26jiqlPscYu8EhTMjKJiNvs/mmdNjJ6X/4K2wawHR8K7jxM6Ft5kH5H1PzctU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 SJ0PR01MB7430.prod.exchangelabs.com (2603:10b6:a03:3d7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 11 Apr 2024 21:23:12 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b%5]) with mapi id 15.20.7409.048; Thu, 11 Apr 2024
 21:23:12 +0000
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Jarred White <jarredwhite@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	"5 . 15+" <stable@vger.kernel.org>
Subject: [PATCH v2] ACPI: CPPC: Fix access width used for PCC registers
Date: Thu, 11 Apr 2024 14:23:06 -0700
Message-ID: <20240411212306.1359466-1-vanshikonda@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::26) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|SJ0PR01MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b19214-a9de-4dfd-5fed-08dc5a6d97a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	88zF4GyGKmefRG0MsTjPN/gZrF5Nm6T10dCS8HJjiUX7Lqe3MnixCv3YR6Zn7C4VaRQgVoohXdNv++yG0N+Jn2byXV4RwJ04VllRNgrJyUoVRKpUVBV4wVfyaZnduQst6CyKoHnRDdC1AGq13J4WUC2969ZH+MyZU7hU5YFErdJQCPndtkX+ICtwC4QePZ6jX6AUsa/pFVNcX30hy08iSiiZrIUtzeCtoGk3RhWhI8uSs5h2NtaWu861+2QZDuEfWeat4j41AQqOzpqOZFL81Vp1FvX/ET1FAe8Y4sU8flqxUj5rLiqxgD9k6ekcMITSmbUANWzEAbK/SAmLnwfNRFulkY3bMJUovD7JaYrCM8Q+D56hiBl9Oanf6Nk8acTu+zbjRgKMKaN3DW6sCQKieBTizlq2/4tu1GkVUO/jIZmv2eJY9rh4T8TBL/l4ywR71ygpUXDXl447eVwmbrClnl9jMpxmbuNRkOTou+PnwNZChBDGHmTd2fPSrLVcIOq+FlaFTtVOSw3eOvgEzHphgvUYL0VZ8rJ0+825KCik/GfCoUuqYDno4Ah6e93QR9tEiAbl0PpvHxqK9OuA7IsJp61qM3CRsKnZNKhXm9IDnuPxS7g43wVeLNxYOyf8kHwjWH90w6ebjmjEh1l85Z1598wyFkz9yZZ09cXOaMsr4fw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AvpjEpldXwH5nYdPQa5r+TWHOOTp80VgNv59cEw+3tivURKwJ/nCO/S7xB0h?=
 =?us-ascii?Q?WGIfB/wRpiq+oqthkcPHvQoA1amWMeceSlHuYpKriXLPiOdAkURidI61OBAD?=
 =?us-ascii?Q?Oo2Ox8a37IMQqQgg4UqqUe8sSNRbCzLMhCHgT9CwRbCVGdNk/Ld917X3/WPP?=
 =?us-ascii?Q?gAaA9JqCOfvJ3FwPmDbu4p6JqaxgMqnerH4SZ0373Bn7HqGDQi3eDT8Xj66W?=
 =?us-ascii?Q?fkZ4nF6QkVAvUe109duSAc01zG4Pb/rqhC9bBW18c50/feweG1mJihQdwnFu?=
 =?us-ascii?Q?Da9a53sZJJfmUrp5zothj8sEnuJUMHlOBfgO5hjkPxm57m3D1k2oSn9/pvWp?=
 =?us-ascii?Q?E88nk5d3m906ppWvnwD72pRDzU31CD57NLq6POVLqzc1Z9VlrQzLjnmDaFS2?=
 =?us-ascii?Q?eGvJgDF88InzAydROACQGH9AX5wvwnfBC1NPpta0eTv1h14V3d6ej0bQY0Dc?=
 =?us-ascii?Q?kn3IeUOskEzdkoG+UjXIlGugtcXYU3MfXM6JPakUjb/WLvlc/S0O49Ho7/zJ?=
 =?us-ascii?Q?2bR5aRc2F+kfZ9xlzvvRHV6coYCPSOQgKgkgS3kBYUUX3P8KF3IOaAa6Vckm?=
 =?us-ascii?Q?/kttSNlqBLpTCp0MLIIq3hrDah8yFS9xtMph9ikcxV0OyuAeUrS5UA4Tn423?=
 =?us-ascii?Q?hKTsMgzBpQnzQvjyHB2kE0yLUnPoc+t2qGBzBl9Iji4IHeMtIx9/yFoghlCG?=
 =?us-ascii?Q?nwX5mbNdRNAMBem17QEhMlneBqdsLRfC8w7F1CB13RwGgiiryvas7Nry26tF?=
 =?us-ascii?Q?3kM415JnsTZMcvrSsrBq6ffwmftpbl3XKz6m0QftLU16cLtnO9p/7+b+qtdm?=
 =?us-ascii?Q?1K4VVCS9YGAKpBc4zU+3kabiaEfH0FW187mD7OTY43nAGu1qkoel7NcU2S9L?=
 =?us-ascii?Q?l/AZbchWxQ1sl8y57tww7XkHS0kRyNvNKLTeWM5tjzNHuvt1Jc11AHy7Du4X?=
 =?us-ascii?Q?S1hS0D3FwYduDiprsuG3L92Uo/j6gy8ikCOux5gaXkevuvxHHIM8Jd7NQ/n6?=
 =?us-ascii?Q?KTlvjO71gSjctEQ2X05BI2mSjZE7suxKpSpOSAiN+KbA5MwU976IIlmuYSy6?=
 =?us-ascii?Q?FQug8+IoGjN1rKUu5cuFtZaPhEnxJhIUWKPUrLT47Tp/XEtqBvpJatkEqlB2?=
 =?us-ascii?Q?qOJsfAzNpJLVmBdwxn7LitwWhp55QnB+7uo4EmPSpl0fb+CaJNbceO59V0lB?=
 =?us-ascii?Q?ElvtZ1dhsS6Okxb+TitZ2rEZJNgVz2D6OABeWtKQgEGpG3VsH9nWwTSPTAGo?=
 =?us-ascii?Q?h1TqK8UhbVOl4PaWLUAHkSc+kFcnsp0RHqMtQ5s0zBT0DonPLPBD0oqFmqXi?=
 =?us-ascii?Q?iXQKc7MYfUwnM8B33hXtlztTShniQRInJi4ZSI1iLnzM2aW+1m5U00Zj4YN0?=
 =?us-ascii?Q?k7vIGBKlmDIHK3ebaGsi72kF37cVXVeCcOslKuaguLlWNMLw4+uvIk3Bi5d2?=
 =?us-ascii?Q?b0vxQf2A6e2RH6bZff3tFQD6vuhCrTDWmW3lVdJDi+FqB7uhtji784GqJSjS?=
 =?us-ascii?Q?porud/k96gCpOuGh8TchWiDFr0IA6QPG3xmzafSoBwe/JJXLgXWZukdfwdmF?=
 =?us-ascii?Q?6YRUiRF3a75svKYk1nirSCoBOsnaStG+hQroCUfTZ4P0sgr5l0oh3Ophz/KN?=
 =?us-ascii?Q?hX+DnM9/ynnWwflYl0BfXZ4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b19214-a9de-4dfd-5fed-08dc5a6d97a9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 21:23:12.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIYEAxbbNq0frZyG7SbUYqWeS2PTm+2Gk+NUqe6ukwfcgNGxZmOaojUmF/NXlMwrpwshuLT22r8/uf6hUXsdB1Ww/hnvl6kYRsUeXrun/w5x8WRRXFLAhHGieLbQIg6g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7430

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

 drivers/acpi/cppc_acpi.c | 53 ++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 4bfbe55553f4..a037e9d15f48 100644
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
+			pr_debug("Error: Cannot read %u width from for system memory: 0x%llx\n",
+				size, reg->address);
+		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+			pr_debug("Error: Cannot read %u bit width to PCC for ss: %d\n",
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
+			pr_debug("Error: Cannot write %u width from for system memory: 0x%llx\n",
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


