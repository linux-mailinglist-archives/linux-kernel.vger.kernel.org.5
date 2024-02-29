Return-Path: <linux-kernel+bounces-87075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC35086CF1A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1951F26A58
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E9A75801;
	Thu, 29 Feb 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="WjllIipT"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2131.outbound.protection.outlook.com [40.107.95.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6870AE6;
	Thu, 29 Feb 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223938; cv=fail; b=ji8wdzeZuSljacbrTzeyQGbbfvj9Z4kw92vyCumwERdtltwqLK9/LsP+Z0Xms2c0ieEp5mv+Rrb/HT/qh6sLmBEC4FtsIzafHv31/cV4/YzvQUEIP6pcO2+obwFI5w3JSORl7jioE7vNFeLTtzgRUOhJIukzzJmq57s2l28m+xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223938; c=relaxed/simple;
	bh=akCzDfabACtg2Ea9LgKZ9QnqG4lJ+HMdiMr6ggTo/YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxdQf8vNzM2ai5qOGDNdSy+t2lOJhmbE36s4ARl9wbp+3Y35r7NGEOwkV8VYPCUbFEC+zRPHQNmF1e7O/yd1hVjsFBr7Atn87+JZEe9jz21dDXqxLmvAyqkbSmqu1pjmb/zFNEcJFt6uSzxD7buG8bfwh3/tYCcLttjPUeUtChQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=WjllIipT; arc=fail smtp.client-ip=40.107.95.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUITIbcW3t4Kj/OxamBy2thdw6rr+u4xd2qqvYLKQpq46KIiwM6aRFzcnjEjAuzTyncT6sCsF7Gs4NiOPVM2pnOBIm2Cl+sld55ZedzFtxZj0b8VqymDA9BVIIcJJVtnnE5md5fVXQCdRFw4Bt6K+6o8P3lfEOWucrfYC3T4b3Lk/7Wq+9dMue4WmZ0KdbVwzu8Le5jnxZejC3p92gopCSgR4GpDiUZZsURYFDkeR/MKgBgvDevE7yxHWHOEKyyr9QzLHfsctmxjwaxZ4Lw5PYEWMNYP/aDx7sSC0ctC3+8PwmG3wHzDUQpkCbKZ/8nEIIafxTvX0X9L/vvm3gSSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYCcDFr9oBZ1ay1btoaoim+BeSDQ/pxZBKtFob/bDko=;
 b=oUUaDw2JgygriaMjvYmYenkF5megW5wskA4OguFSHJNmCIcmcdZsygq2qQnm2ZM1E2TXh6vL9UnHfmdK4O00hPJUbQNN1QIUaP0SDjB+vBc6d9N/Iax5cxgkfD6BUlvCUjvjMuKCC6ZQEsRf9HxYXOpiXDOEnzUY+lXizQZ7SVp3l5ecTwuzuy1BQcLx+uDDsIIC6qWjEyj/+4D47j/NZ6MNQ8dfrJE/5T9W3W5PXsAqBhr/VZMXL3fu7fMKfGQ4WiYcDX6gs2XRBtK58NtXNg45tedh0gPq2kwPna01BdNkyHxQOBD6VB6kIVH8hS/Mbe05l/74LHcLIKwhfy6suQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYCcDFr9oBZ1ay1btoaoim+BeSDQ/pxZBKtFob/bDko=;
 b=WjllIipTdJKk1znntIHgccxOSo/SSdX6A/dE5GCSDX8VrPVlQGJxhlnK8jBQJgYT74LqIWMKOkPpJ4y0v3HhLMN3Y7cc+KlWxSmjy+PlRTGzS6eG5FVk5azf3XBl66h2nxCE6xZ916IbSb8DMs3G/mrY5yqNi2bV1hqPZWN2izQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6509.prod.exchangelabs.com (2603:10b6:a03:294::17) by
 CO1PR01MB7225.prod.exchangelabs.com (2603:10b6:303:160::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.33; Thu, 29 Feb 2024 16:25:33 +0000
Received: from SJ0PR01MB6509.prod.exchangelabs.com ([fe80::3bf9:56fb:dd12:56])
 by SJ0PR01MB6509.prod.exchangelabs.com ([fe80::3bf9:56fb:dd12:56%6]) with
 mapi id 15.20.7316.037; Thu, 29 Feb 2024 16:25:33 +0000
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Huisong Li <lihuisong@huawei.com>,
	Beata Michalska <beata.michalska@arm.com>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	sumitg@nvidia.com,
	zengheng4@huawei.com,
	yang@os.amperecomputing.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	liuyonglong@huawei.com,
	zhanjie9@hisilicon.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH v1 3/3] ACPI: CPPC: Read CPC FFH counters in a single IPI
Date: Thu, 29 Feb 2024 08:25:15 -0800
Message-ID: <20240229162520.970986-4-vanshikonda@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240229162520.970986-1-vanshikonda@os.amperecomputing.com>
References: <20240229162520.970986-1-vanshikonda@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:610:33::10) To SJ0PR01MB6509.prod.exchangelabs.com
 (2603:10b6:a03:294::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6509:EE_|CO1PR01MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: b2853955-8707-48eb-1abc-08dc39430d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	unhMk4IPWuCmqbDoybDBisAGIAMPcwKYLyj+zFop7V1nopZsadkF/b4rXwGevwqYEkLGSU8bWlF4ZnkQZQtl4g7+Sks/DH8XFdjN4ZHO/4trl1qX3RnvCRuEl3nHZiqrKjvjxdHolaZCrY+SsSdaK8rFdhpOGdP2dDMXx0pWiwwSnr6B9/K6wMatvAuJAfKmTTi/KmzyiQwa8uwn46/PQmBd6p7F6CG6Z/514BZYWmVg35ABKlPeKnjiqdKz2zfeBT5uBiEWiEBbHHanQtJJ5IT5eeNcvSVfnX1H5HgU8/tquXv7r2jj/IeVrKfV2zTCADAdL/J/Q1ug7tAtSepkuI6oGd/YKorvcmJI7FiIs6BeJe0RHB4qAlFTGrQIx3y7JYPkqzku60bfaDGZHaNayg23/2hDQzYyDREhwBKnz7bl8qTQCfpa7ynSubie37k1yrxoyEfR7P/vXrMSQ4YUaXEu9pe54hFXKdyCG5W1pZjhh0/FA3FbbGgcDUCL7vBh4NSJLjNgXblXBV1udJHb3Y/dI5O0xEs1KU2C5lB0ZW4EsdxfIf3cGz5J5f49rsgnxfSsOKEajBwcP6pg6Zv+Zg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6509.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tlKAnk7khcqV1FplTjEZBWLOG0bnON/NX4ki9DpOpDuJZaJDNa7dOeInpWEV?=
 =?us-ascii?Q?b57iS26iCcJc1ahIVkzzLHyBUIc+sKDIEYtuK1bcrFS2Fc2qAhjWlch4lZuB?=
 =?us-ascii?Q?D1qcmpoFbWCg0Vgx7+DXhvVTnXUTiLbkOnlvtPP5UA/MAMJAzIxKloVU9Q0h?=
 =?us-ascii?Q?6lsGPQUq9QWFdd6rHNGRSIq5WmHRWu4SPFh7rMc6rgck0ouyPWIaMoPHic9/?=
 =?us-ascii?Q?YbHqWGaRnYLLmfnNYwHNRCqsklauTBL3+ayb/qr5l1mwAcr5yjdEKa1kR/4A?=
 =?us-ascii?Q?FAtXkgBNWgpJ2Sxsjat85ZuEJMYeImqXOGxuIQZXlRATNF6tD5QlIBHuoMEE?=
 =?us-ascii?Q?NhdpcXzNSU2PYbpd3RjakqqdpkMqPZ89ZZaFp0CsB53WFvkEpkplMFah/vJN?=
 =?us-ascii?Q?HsC6iUjJosYVHvMvmEnY7Z8xRlHLruoZsjJzFPQnQxpMja7PGL6QksbXnmtJ?=
 =?us-ascii?Q?Bnq5Oq3PcSPMGIS6KCTvRrR8x6obpDt4dHQkRe/b+y7PQ71ZCn3XBffh+/Yg?=
 =?us-ascii?Q?PuIeBjm9/g0OMnOIQU0QmE3/y63Msz2UE1wzV0q6TJTJE09zBZEklFnWQ57o?=
 =?us-ascii?Q?ZDTrPy6U9P8T5GvKu9b95mBs27EFx0EMuVMxU3ldWRusfU+SMHAYAPc0yuac?=
 =?us-ascii?Q?15DTYF81hHACmROTbO7I5fPdOrjkdl6VSugfUNxOhk5TqLotBs/3FdUzzFCn?=
 =?us-ascii?Q?41ff2wTuYSwH7c7vbzWj8qhrYCbG1tFEK9jvW90zV8H5qwdMfJL0pWjbGm6f?=
 =?us-ascii?Q?2GU0Cq47+ws5m6r0spFZqufTuPqNuwaQztZkPY5bUk7IcdUAwE5eunkC3wU3?=
 =?us-ascii?Q?SJQHApIgnfL6soP4WOzY9ntnFu+CiVXKcQllCnwuS/0rM2ETWej8IMWoRlqB?=
 =?us-ascii?Q?Aq19tJTl6KzvuVDIDrcrfm4KGwBUI8XshhooU75QsJoPMVWc+pvQFdNlhZgr?=
 =?us-ascii?Q?HHPcm5BFgMjIiBUJ9xyjgp2Ek7rYTajvSvOMiFrBO84BsTguA+F/65oNfjBT?=
 =?us-ascii?Q?uF7bQqhjrPVaDUolSrut2uoqrDEvd8nZZBmW7fbdyvT7qUvRe5ntschqbQOF?=
 =?us-ascii?Q?0HdSp8HS/GrbzMdkCWQe9I0fM65J8MRjSzQ376PMGWOwUU+pBuUhuDqHoex1?=
 =?us-ascii?Q?h7XNQrNu+cBsmenrwjzhDQpRDGR44HOpt+IA2vUAA6a4A60fQQHtYmxVW55X?=
 =?us-ascii?Q?g0LaBAGm7veTh8V/WYPnEGk7H1ji759u14BReS8ozFzbcHrzidY2mQuQHWaT?=
 =?us-ascii?Q?lB8tk2oZbWP8Klp4bC+lIv6vI1LEw4an+L630f2dCagnWuow1I3zKWFdSImC?=
 =?us-ascii?Q?VTEyEw9J6ltzqkEwlvWJidkHIEb8WSa2l17/Fdl5A8Y3hyTw117DY+RmXi26?=
 =?us-ascii?Q?TYvf6X+n0R95EX1aZg/ywDsHTpymrkgNRe/Yapk/5A8PAm0tVmSiu1Ws0+BY?=
 =?us-ascii?Q?GAf2VD3EiDVPzmWqdyrFA2a5G4oWu68NX3X2neFOuYwq2IdnEGQ8JVhecz2s?=
 =?us-ascii?Q?hGmS4NWx2uNfDHDML0HuENlxpn5dc22tNyX8pzu525iaI+ntjUPOyOndk1u1?=
 =?us-ascii?Q?99QK2AUWdzPGFbajS10iCDJSNAFZTR6x/Lev5mt6uhIGdVFZMe3mosaGg7SP?=
 =?us-ascii?Q?YMKH/6b64w4QTth5pozfxO2I/EksAEe9R6EH6hS8puMl?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2853955-8707-48eb-1abc-08dc39430d67
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6509.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 16:25:33.1284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEH+csnGl4oqncGnu/oRx528M6BFTBZO9FcdnV675svZBmlIZI6PdxawZQSAT3BPr9RRI1zu+cbuMUtMLMcYQpz0ObJlC2XTFmtnNi0Fcb8ZgSE3g9UpaeklDnkXaKq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7225

The CPPC driver reads delivered and reference counters using cpc_read
one at a time. This leads to inaccurate measurement of CPU frequency
discussed in [1]. If the firmware indicates that both the registers are
in the FFH interface the kernel can read the registers together in a
single IPI. This has two benefits:
1. Reduces the number of IPIs needed to read the two registers
2. The two registers will be read in close proximity resulting in more
   accurate CPU frequency measurement

[1]: https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/

Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
---
 arch/arm64/kernel/topology.c | 37 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/cppc_acpi.c     | 32 +++++++++++++++++++++++++++----
 include/acpi/cppc_acpi.h     | 13 +++++++++++++
 3 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 8905eb0c681f..8207565f43ee 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -421,6 +421,43 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 	return ret;
 }
 
+static void cpc_update_freq_counters(void *info)
+{
+	update_freq_counters_refs();
+}
+
+int cpc_read_regs_ffh(int cpu, struct ffh_cpc_reg_values *ffh_regs)
+{
+	struct amu_counters *ctrs = per_cpu_ptr(&cpu_samples, cpu);
+	int idx;
+
+	if (!cpc_ffh_supported() || !freq_counters_valid(cpu))
+		return -EOPNOTSUPP;
+
+	if (WARN_ON_ONCE(irqs_disabled()))
+		return -EPERM;
+
+	if (!idle_cpu(cpu))
+		smp_call_function_single(cpu, cpc_update_freq_counters, NULL, 1);
+
+	for (idx = 0; idx < MAX_NUM_CPC_REGS_FFH; idx++) {
+
+		if (!ffh_regs->regs[idx].reg)
+			continue;
+
+		switch ((u64)(ffh_regs->regs[idx].reg->address)) {
+		case 0x0:
+			ffh_regs->regs[idx].value = ctrs->core_cnt;
+			break;
+		case 0x1:
+			ffh_regs->regs[idx].value = ctrs->const_cnt;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 {
 	return -EOPNOTSUPP;
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index d155a86a8614..55ffb1915e4f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -113,6 +113,10 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 				(cpc)->cpc_entry.reg.space_id ==	\
 				ACPI_ADR_SPACE_SYSTEM_IO)
 
+#define CPC_IN_FFH(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&		\
+				(cpc)->cpc_entry.reg.space_id ==	\
+				ACPI_ADR_SPACE_FIXED_HARDWARE)
+
 /* Evaluates to True if reg is a NULL register descriptor */
 #define IS_NULL_REG(reg) ((reg)->space_id ==  ACPI_ADR_SPACE_SYSTEM_MEMORY && \
 				(reg)->address == 0 &&			\
@@ -974,6 +978,11 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 	return -ENOTSUPP;
 }
 
+int __weak cpc_read_regs_ffh(int cpu, struct ffh_cpc_reg_values *regs)
+{
+	return -ENOTSUPP;
+}
+
 /*
  * Since cpc_read and cpc_write are called while holding pcc_lock, it should be
  * as fast as possible. We have already mapped the PCC subspace during init, so
@@ -1317,7 +1326,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
 	u64 delivered, reference, ref_perf, ctr_wrap_time;
-	int ret = 0, regs_in_pcc = 0;
+	int ret = 0, regs_in_pcc = 0, regs_read_in_ffh = 0;
 
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
@@ -1353,8 +1362,23 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 		}
 	}
 
-	cpc_read(cpunum, delivered_reg, &delivered);
-	cpc_read(cpunum, reference_reg, &reference);
+	if (CPC_IN_FFH(delivered_reg) && CPC_IN_FFH(reference_reg)) {
+		struct ffh_cpc_reg_values ffh_regs;
+
+		ffh_regs.regs[0].reg = &(delivered_reg->cpc_entry.reg);
+		ffh_regs.regs[1].reg = &(reference_reg->cpc_entry.reg);
+		ret = cpc_read_regs_ffh(cpunum, &ffh_regs);
+		if (!ret) {
+			delivered = ffh_regs.regs[0].value;
+			reference = ffh_regs.regs[1].value;
+			regs_read_in_ffh = 1;
+		}
+	}
+
+	if (!regs_read_in_ffh) {
+		cpc_read(cpunum, delivered_reg, &delivered);
+		cpc_read(cpunum, reference_reg, &reference);
+	}
 	cpc_read(cpunum, ref_perf_reg, &ref_perf);
 
 	/*
@@ -1366,7 +1390,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 	if (CPC_SUPPORTED(ctr_wrap_reg))
 		cpc_read(cpunum, ctr_wrap_reg, &ctr_wrap_time);
 
-	if (!delivered || !reference ||	!ref_perf) {
+	if (!delivered || !reference || !ref_perf) {
 		ret = -EFAULT;
 		goto out_err;
 	}
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 3a0995f8bce8..0da614a50edd 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -137,6 +137,18 @@ struct cppc_cpudata {
 };
 
 #ifdef CONFIG_ACPI_CPPC_LIB
+
+#define MAX_NUM_CPC_REGS_FFH 2
+
+struct ffh_cpc_reg {
+	struct cpc_reg *reg;
+	u64 value;
+};
+
+struct ffh_cpc_reg_values {
+	struct ffh_cpc_reg regs[MAX_NUM_CPC_REGS_FFH];
+};
+
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
@@ -153,6 +165,7 @@ extern unsigned int cppc_get_transition_latency(int cpu);
 extern bool cpc_ffh_supported(void);
 extern bool cpc_supported_by_cpu(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
+extern int cpc_read_regs_ffh(int cpu, struct ffh_cpc_reg_values *regs);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
-- 
2.43.1


