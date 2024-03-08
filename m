Return-Path: <linux-kernel+bounces-97467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE1A876ACD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1731F21624
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27955A78E;
	Fri,  8 Mar 2024 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y52v5zXD"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2522C853
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923012; cv=fail; b=V4c7CBL064sT34z4gJcB1qkNxHGFhR0GflUynnQ+e9zSFIDN4jaUHeVFjvLONfgiEOy3RJKawe6YNGnpQ0h/vnjnk9j8uT7KjfMC71ovgmHW7FBVd1UgvLMKzdncrKtnATNhqb0bDzJUoddus5jUYtkYE9JM/L6uNBDtkOkl+XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923012; c=relaxed/simple;
	bh=eQpZZLp8q27xgh8e18ni18Wvt7mBGKNlLLyED6aJJJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwyCgqoxByK5i4mUoywFAwUHYwmVaiph5pa3wQOrSJoo5vbqx86qL2s2cqiRah1xqghJQ51fF7bOo9GIuRi1Ux3ovfD3Z34sNwjz943s2rnQESOGIA5F8YmCfcChPADyQISC7uUD+ev/eakRwkD7qsYbW0LVbmv9ZOyyNwTz2xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y52v5zXD; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7M4E43puR+WfZMWvdIThXyCI/Wrz2IyUEqOPDyPFM9s5a352dLJiQH+wLPPs2JbAReK3X71qWQcNvnFhP7B6cmNf5x/BUUonfvAm/qSE5S1eQGLhEbyphM+LgpJqMFH8GZcrzCDbpwiX0g5TOk8hdLdpoXNvJh3iM7/jTtm2V1n/QtxUYvpjD4jm6O9XvfySj5JLwOu9CQ5Cu9hJc666J5b4KyxWf+sQfVz0FmX3D2ICbwnpCmXBqtL5xaTWBeUYHbH1ri2FvUzuemavMcYRk7v+G5s4QV0EMYJPgFOeSvgIL1Ddg0qZ2s5Uk9f65h0+NGAdLTAU+aVj9LgcGEypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKqPApDiBTzVeb993ffITlkwFFr+djWcJNDaGNnmuRc=;
 b=dm2bpHgaBabX+BbLpFaYgYDYedPzvEDaj2E1LPL1x2uoGibkcwj8/3qLzfFfaHZCf0oNV9BUNwgnEFUhVUOi6DcRQLVAjd+MbUIuI/5vR/n1iselywV1oBZhtnNLQYyGPRv7Kk8BmFod6IQR5RxexolLW+Ji9guqjJAGptYr8Z8WMKFst2qYeX0HbPkiN0mw3ltQMRqCUvvSVwj618wYLqdc4gKh3py7VwtVYyVdm5MGoLOBoLsuRy9bpAekvR8+sG8RQXXgqZoU/lLgozVYAjRZnNfwYz61obPWBuTMHp5D3e550KzxzK6CZew30IyBQ7YI3g8KhQ+3jLThBO8chw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKqPApDiBTzVeb993ffITlkwFFr+djWcJNDaGNnmuRc=;
 b=Y52v5zXDin+7hPrbE1i1ID3SZvWEvTLtMoqz67A+nWREdPCHHgXdfjxyZdhumuChiVabxqei2kCjtmdRCDFNzPzkSZi+JYpqbhri+/qZOeUF6BXlwpvyNpFFrpE2oXAeeEURD8lByEQE4dScSbXJtnOy0lhyHR/fFlX2Feu5ous=
Received: from BN9PR03CA0465.namprd03.prod.outlook.com (2603:10b6:408:139::20)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 18:36:49 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::9b) by BN9PR03CA0465.outlook.office365.com
 (2603:10b6:408:139::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Fri, 8 Mar 2024 18:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 8 Mar 2024 18:36:49 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 12:36:48 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 09/14] virt: sev-guest: Choose the VMPCK key based on executing VMPL
Date: Fri, 8 Mar 2024 12:35:24 -0600
Message-ID: <a828ef42eb6af8789f4d1516693f950cea51d6c3.1709922929.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709922929.git.thomas.lendacky@amd.com>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc9ee1c-3338-43fc-59c5-08dc3f9eb75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T/V9iXBfycWaTbeA7e0hKWzFniIxdIVX+CNp8ftG79XxWK1lNLew1iOJNHt18CMMNJW6x6RiSJtW+dvZmTeM32/bPluO8ny/vBKLwxzb9aSBVpLsjvjhf4UFhjY1FwfhJdleE7nWNrzWIn0WBCBXKvPJA8aE3uYHwxHj2tj8COxWXl4LHdYpbGskS1HFgeg+i5IUZeYreigxB6nR4E5EU4SQA1jIOwrpDfPehI8/Wx7i+9eYLAbJFE8VoL8q/38AOSkfX84fx0tiepQ/U+Q+ycrDaE58XyNZBkY7XkQAt5trJvguamLbxp79z03MQjlgr4JYqp19hNtTzc9jQ1KHRJrB9u/xHSIzFL5gkqCrDX7A6+YZS3wODrHO2O3LWt5UejPsaxJFSqT1MPOLtKxKGmEYiEF8DIKrSr2XMXoaxo+qghT3ICndF1XwASXjYH4buChw/mQOcBfQ2wcgL7fleB1n2Zq3SZyRFcot6JHdscbchY8kEL7sCOC5Cehb3GMoIGlpBic5HCJjD8kX3ZEiKIP1egy6OdlT81liWRab5DAFCDuYr6uu3M41I3KpPcBaToLWRktjwPQjG33aYL4wedTWHOu/4Xolfcn1EDv0g2V3k7CjCM/nZtfTkK9tCghw/1yGEcrm3K5b5y/YcHCs2Qy0GzNnPPYUqGi0OGKrjEzxj/bOJQLcjJFCHRSCrN2LslwddPSapldj9J1XJzF97eGRvk/93tryLxT0hjGOHeM3ueShGAKw69HpHnaef5FH
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:36:49.2898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc9ee1c-3338-43fc-59c5-08dc3f9eb75b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732

Currently, the sev-guest driver uses the vmpck-0 key by default. When an
SVSM is present the kernel is running at a VMPL other than 0 and the
vmpck-0 key is no longer available. So choose the vmpck key based on the
active VMPL level.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev.h              |  2 ++
 arch/x86/kernel/sev.c                   |  6 ++++++
 drivers/virt/coco/sev-guest/sev-guest.c | 10 +++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 1a07d86eb9d1..34bc84aee969 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -308,6 +308,7 @@ u64 sev_get_status(void);
 void kdump_sev_callback(void);
 void sev_show_status(void);
 void __init snp_remap_svsm_ca(void);
+int snp_get_vmpl(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -339,6 +340,7 @@ static inline u64 sev_get_status(void) { return 0; }
 static inline void kdump_sev_callback(void) { }
 static inline void sev_show_status(void) { }
 static inline void snp_remap_svsm_ca(void) { }
+static inline int snp_get_vmpl(void) { return 0; }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 807bd6ea8d85..8682af55802c 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2466,6 +2466,12 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
 }
 EXPORT_SYMBOL_GPL(snp_issue_guest_request);
 
+int snp_get_vmpl(void)
+{
+	return vmpl;
+}
+EXPORT_SYMBOL_GPL(snp_get_vmpl);
+
 static struct platform_device sev_guest_device = {
 	.name		= "sev-guest",
 	.id		= -1,
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 87f241825bc3..1ff897913bf4 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -2,7 +2,7 @@
 /*
  * AMD Secure Encrypted Virtualization (SEV) guest driver interface
  *
- * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ * Copyright (C) 2021-2024 Advanced Micro Devices, Inc.
  *
  * Author: Brijesh Singh <brijesh.singh@amd.com>
  */
@@ -70,8 +70,8 @@ struct snp_guest_dev {
 	u8 *vmpck;
 };
 
-static u32 vmpck_id;
-module_param(vmpck_id, uint, 0444);
+static int vmpck_id = -1;
+module_param(vmpck_id, int, 0444);
 MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
 
 /* Mutex to serialize the shared buffer access and command handling. */
@@ -923,6 +923,10 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (!snp_dev)
 		goto e_unmap;
 
+	/* Adjust the default VMPCK key based on the executing VMPL level */
+	if (vmpck_id == -1)
+		vmpck_id = snp_get_vmpl();
+
 	ret = -EINVAL;
 	snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
 	if (!snp_dev->vmpck) {
-- 
2.43.2


