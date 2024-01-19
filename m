Return-Path: <linux-kernel+bounces-31483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B16D832EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606F8280A87
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B92C5BAC8;
	Fri, 19 Jan 2024 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BYIAOA+u"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486DF5B5BF;
	Fri, 19 Jan 2024 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688653; cv=fail; b=AsjgMs1g4JZWB8Plj4a3X1p+qIcUL/HLgxFc1vwcnLmYabd96ehp5kzknC70RC3QnUuK/Ct9pMCizGGg8blDuBFS0k+/pqNfOHnUOxgtLY/GWp5RZOPItav3DZlSMuWCLN7HcAU9gJgiMGBIGTXfcFDJixKxDXjYI6pTUdp8ekQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688653; c=relaxed/simple;
	bh=/p6RMQW70xIjci1hJHNUyvIMHWdVSqypSNBC+h9ZKR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVOwCILPkuV5YwPb7BSMOKw7invel8PTsz4bs/kLlsvul0Yd9LSWMidOdt2BBfkR9HU/S7QyJdyow/0L372BLalbTRu+kYorFYds8JL6+lDhG/NRePDsQSsOZh9Ec3l9U9R+1zkhcW+lz0kEA6m0stRpDiVfnxL6LgE1N+UuSe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BYIAOA+u; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFxuPWAAVpgFQhRDDPq9uhdicGX3Xk+YeHk1+9saxWMvhkTe7chwmjjtBPAqPBh1GLTvYPAV88RLXiWMlr7+S2rauCUO3ljqpbOcbxZ7BbN3FK3M1K8S085cguWrCgxCQabI2G+MLnQ6t3qWbOkqKeWLRS+QnpZeCipKFkCCmbmIedzK+H5Fmnl4LkF+2jiO0bVpBrNCgjAWeJmc5+F8wt3fRhnH5ZchKtLGHez+mGhCA/YAUAT8RUP/hPp+hzGyt4e9YyQt0vMiakc228cnNhK9tHt1m1TWTSLMSiFiitxyoti0RPid9VKgLedZUUtgOdX5ll2KVJtfucPZZ2+d/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6Kf4gaMxAnI0VG19n+90PnY2/kQmThflPbXE3dh2G8=;
 b=e28k9iI6aykWTBRtYoTjKhUjHjH5C3hUq6gL8EIn+TvbmpF9LKn4m/ujtbAUJoCjfkoIbmdCjR+2J4DhpuYgWEddlxzkp/ogIa8/dxKSVfWuXBH071LtVQZqDF2t0Ad1HGobXUz2JhL+wrfoG41WlpQqb6SyLGfeYD439iipclTL9B+fWoajodIGn0gHC1KxdQJ8t2x9wtSQBfi1OA9AWCawhsBz/mjgK5890uhyW05ng64TSYWlZPU9w46I9lSJRnU5TLaR8SgA77T6Vqg29gEO2ty4+OGoJ99VRmMEX5b+06tPaCZmOy/ua31FbzKgM6Q46FoM3NSaiwPOBVanVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6Kf4gaMxAnI0VG19n+90PnY2/kQmThflPbXE3dh2G8=;
 b=BYIAOA+uJ/D+pTL3kAezL81K6X7KwPDQg3IZB75TCt52C1I9S4nVIow9rTQtfDfNer5CO+rxoH5yEz+mlf6aeSRi+GMrha0CLMxY3aPLwQQ6vz//wUW8vqY7b/FtRCfHWkK3QiblWoGUzycFQM1JkrVRVL+rRx4K3bfExrmqWXg=
Received: from BYAPR05CA0104.namprd05.prod.outlook.com (2603:10b6:a03:e0::45)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Fri, 19 Jan
 2024 18:24:08 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::6c) by BYAPR05CA0104.outlook.office365.com
 (2603:10b6:a03:e0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.9 via Frontend
 Transport; Fri, 19 Jan 2024 18:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:24:06 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:24:04 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>
Subject: [PATCH v2 13/17] x86/resctrl: Add data structures for ABMC assignment
Date: Fri, 19 Jan 2024 12:22:15 -0600
Message-ID: <d4c5931a48be9cb922e1dc41024e26546d7ff069.1705688539.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705688538.git.babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com> <cover.1705688538.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b2b605-7c44-4b2d-9776-08dc191bd260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oTD46GDAaz7uMCJb3SilOjIDrlVyrYdHtsZM6D3zHejj/kqtqqDR2uO3SbQP0bhoUYwTRgEomTZHFUoTDtZa4lwlWLhwx5Zv4dT9hVTlAho+tEfvL1PBeNTKkErT9jQYejizgZqqA2YKeEgz2TLH0Y+E7m0j1W1QSdAnSOKlncifcfOghwdjuFzZG9zs2rXtlR9glE65yRHwKETFyzvwtc/5jig1hfBrsIlagQY6Efbz/26kTlOPrmmNBz6I1TuNQAau++rXhL9kpUw8fdSLoh7yiT+9IEvZflDp0qLLXHMPO6iKUkGqfJifjAX6OvKIGeL2R3av01Pi+AX0k4GdzqW82shbGUSWQ4gaKUB2s9+S35CTYZKNKNOecqLohO2+LJ1dcIr4NM7fqy2hcAuvtFL3e7M9H2hC1sdaeWmPwbySztBE5TTRYD4/nySCOo1QeaTNqT5NtF6EvMHLjGjTO9xpXJ1Q8QVhvdpybkI8DeIyxtc8up0L18I5vcjZwybNKjf2e4vrgrPaxUDtNcWZtREa8KZAEUnN9xh6VuLo3KYtAXGmjHNxZXR0xLALGm+5FWXq2TZTcswB5iZMLJ6cdMlg4PrtdjVHocN+TiWtG5ykbwzpyYJAqfV430EQ4JdB919UZjM3pmZGq32yAdWandrTgeG48VjXQHLf9bYp2/bwuvYmBn+vy5YZJ+ax9zdcn0HHhYRHzJAwsDiYdbYfukvgeCGvZSK0muqAhPLGjiRxFBy3fLDltUPZSQtsGi7aH2rdvzduCYvgV1qNpvWqPA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(7696005)(26005)(36860700001)(426003)(16526019)(2616005)(6666004)(336012)(82740400003)(36756003)(86362001)(356005)(81166007)(44832011)(8936002)(4326008)(8676002)(41300700001)(2906002)(966005)(83380400001)(47076005)(5660300002)(7416002)(7406005)(478600001)(316002)(70586007)(70206006)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:24:06.2874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b2b605-7c44-4b2d-9776-08dc191bd260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556

ABMC (Bandwidth Monitoring Event Configuration) counters can be configured
by writing to L3_QOS_ABMC_CFG MSR. When ABMC is enabled, the user can
configure a counter by writing to L3_QOS_ABMC_CFG setting the CfgEn field
while specifying the Bandwidth Source, Bandwidth Types, and Counter
Identifier. Add the MSR definition and individual field definitions.

MSR L3_QOS_ABMC_CFG (C000_03FDh) definitions.

==========================================================================
Bits 	Mnemonic	Description		Access Type   Reset Value
==========================================================================
63 	CfgEn 		Configuration Enable 	R/W 		0

62 	CtrEn 		Counter Enable 		R/W 		0

61:53 	– 		Reserved 		MBZ 		0

52:48 	CtrID 		Counter Identifier	R/W		0

47 	IsCOS		BwSrc field is a COS	R/W		0
			(not an RMID) R/W 0

46:44 	–		Reserved		MBZ		0

43:32	BwSrc		Bandwidth Source	R/W		0
			(RMID or COS)

31:0	BwType		Bandwidth types to	R/W		0
			track for this counter
==========================================================================

The feature details are documentd in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
v2: No changes.
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ac0ce88a5978..148c2b8a2264 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1127,6 +1127,7 @@
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
+#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 865101c5e1c2..130854dc8b7f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -63,6 +63,9 @@
 #define TOTAL_ASSIGN			BIT(0)
 #define LOCAL_ASSIGN			BIT(1)
 
+/* Maximum assignable counters per resctrl group */
+#define ABMC_MAX_CTR_PER_GROUP		2
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -170,6 +173,7 @@ enum rdtgrp_mode {
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
  * @monitor_state:		Assignment state of the group
+ * @abmc_ctr_id:		ABMC counterids assigned to this group
  */
 struct mongroup {
 	struct kernfs_node	*mon_data_kn;
@@ -177,6 +181,7 @@ struct mongroup {
 	struct list_head	crdtgrp_list;
 	u32			rmid;
 	u32			monitor_state;
+	u32			abmc_ctr_id[ABMC_MAX_CTR_PER_GROUP];
 };
 
 /**
@@ -532,6 +537,24 @@ union cpuid_0x10_x_edx {
 	unsigned int full;
 };
 
+/*
+ * L3_QOS_ABMC_CFG MSR details. ABMC counters can be configured
+ * by writing to L3_QOS_ABMC_CFG.
+ */
+union l3_qos_abmc_cfg {
+	struct {
+		unsigned long  bw_type	:32,
+			       bw_src	:12,
+			       rsvrd1	: 3,
+			       is_cos	: 1,
+			       ctr_id	: 5,
+			       rsvrd	: 9,
+			       ctr_en	: 1,
+			       cfg_en	: 1;
+	} split;
+	unsigned long full;
+};
+
 void rdt_last_cmd_clear(void);
 void rdt_last_cmd_puts(const char *s);
 __printf(1, 2)
-- 
2.34.1


