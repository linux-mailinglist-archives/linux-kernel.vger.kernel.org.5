Return-Path: <linux-kernel+bounces-31484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880A4832EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4DD1C20FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9DE5BAE8;
	Fri, 19 Jan 2024 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VGQCJlSj"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B85BAD6;
	Fri, 19 Jan 2024 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688660; cv=fail; b=WcdjR6M/5F31zmhlKpy4osABP+uaq6GueY6Alo9bDfqNBfaz18xmETKXSm89h5SqHsDYeZttkTcVpUGkvBitY8ngqWedYjeVGsn0e/BFz1054Q8MZDZYhxnpRhxP21p4gcBkEkyAwtYSHp1beCiSHVmlR4VxN09swoOsiiWUtJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688660; c=relaxed/simple;
	bh=2qulbEjR/C6zol3vcHkV2iMlGj8evM0dCBCJPjyLtA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzfXgvyFVtj8gNvF2m5tl4/BM4c4FhcYHJ1/wmWfpPwmaNpihL8JyxYCVOlkatenUglFg0c/d8Y1CnEtFz67T6qbVUhGg1LjWbySrk/pUyp4qoX4Zvw+aH5PPtic9oumTkzcB8qTYJQJG9u78rdiOJ1VFFJQuOP9czSsm0VQfCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VGQCJlSj; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbOIXV1OhnGYZLoMrfIL4rsCen/Weuu2+tu7IxHpErInBMdr0RKFe5vtH+ftsDDtb/UaiYLpaT4sU6JHzcUcqhSiFQVy7+a7L1NylQE1fg2+EZZIOHPzrLR6/sAIsslOh6wIrMO5Wu/UuNutWdYDdaKF1qlGd5AKnLxPboYukgPzLoryJZiT8c1Hrk6DHkx5GXuITrpbtjPdLV0cE8fWm0BDkLuVz87G34O3wn5vYTWxDygUBtrJikqLLlpM1jJsiqZzf1/6mPZZ2+mjH0eDFsu2CKPce6oVF85cvuqja2BL1tWjhlDA/9FgYQnbPj1rxulDW3PpGoM+z02l3HZygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoP32n0iAgsInVFglETHnSGFNdUjX+9gZh82vJqDZMc=;
 b=JhFIh5l1LD5wOxTHrYDUutCFEvW2NSS15UQodFIrt4yDKuNlTSO9gguUpHAYn02nTRG/Iw8PIonOXLI96H5BXnKYcIeyFM1J44PCdzFK73YUNy1uebTmXS5R2AQ9Te386cRl15MJTlHSM6GWMHx3OJcoEoJ9jo/T1BTdocSPRz/ytt+2fAna6PLaaFUek3jDX0SVj0JiD4tMkH5R7YwFDlR1PXEUe9aIzuVmj4bLxauFJkpGo1JLsL4yVpmUMJ1D/urZVttZVx7ht2glk7TsO6iw48tbEMHKPU+1oRFc3oe1St8c4ulsA9E5n5HxQnGyGjucGJ+uItuKJa6pWz95Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoP32n0iAgsInVFglETHnSGFNdUjX+9gZh82vJqDZMc=;
 b=VGQCJlSjNOK5tt8X/VsKuehrn2FJJ7E1nt2WLaEamAbmzYr7TcOG0FHXRWIlbu/GRd3T7qDUuLpOrUwp0JA1+mR4hAQE27kIHwNS+anxG7fAHDIH4g8fWOVQkuOFCIpTN/cGC2x0/l3DFL/gvtNsTHXLuW45+hwAqWyvpYrn7zI=
Received: from BYAPR11CA0043.namprd11.prod.outlook.com (2603:10b6:a03:80::20)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 18:24:14 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::be) by BYAPR11CA0043.outlook.office365.com
 (2603:10b6:a03:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 18:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:24:14 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:24:12 -0600
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
Subject: [PATCH v2 14/17] x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
Date: Fri, 19 Jan 2024 12:22:16 -0600
Message-ID: <a9648e33ea4893477350734995648c5820ee0e6a.1705688539.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705688538.git.babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com> <cover.1705688538.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 9084ddee-9ab8-4697-9144-08dc191bd735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HwIlCVETP383ooFYGgP4FA0bMNU8trjoZejww4/IRfRQIn3UW8xy/SWkrCG4wr29wjE/i4FSaJy3AWgYM7za3CX1nZFKDgNTh6ULtVCKVXuOuicGcHtVR44O6DQ236t+meFyRwfogefw4aTSZSWinEJzd6PeoDex24qbGUdpSfOrSCwe1n8/taNcfR/e4YFXydhG02enS3WNU+R9iQlHMz5SU8nfeJpmjqjk0CLYCvPL5kmEHmCnaLvs9f1+CTUz19C2cKpKWmZgc99gfuKQ0coVEJN3jSfow6RRbfnK3ubfU5LsUxrwARPk4FMt4Aa55PzEgWOHl5f9+4jXhzm5ezuFjuDVVOolZMsLzmv4wJXUbki5LBVIEuodjjjphVxom3f0QCM9Xs1IXN9ghh/ah7WJ1OpIUxBpydenZZycwR+VlM5BhVmzAZHThk/16wQ1yroSjB7gFjGky2ynjh5jRA7dzl1i9RD9CfpWzZShSZjZ6VXBo5aUcVhMMtbCs3DYQeCMDohpeJ1Mwdp7J1FRl0LsXjL5OzlWx1TT04u3ZVU2dXqM7NA5hbCaG+Us3r07grjdGN7v7pL7yp9615Q0oV4K1zPvDH98c1Z98Sd861peM0jrRbkk/zWo8w6snAepeTUemqXhvuM7CIY+1531vneaOeiFLIWd+8OG1QHZtN97KURbbPbz47G4OvrzTrqF/02NlO/nEL7mtq9qpyHd8ou8+MPTuomm8l9xg/BEAFoB/LdmU+qIaakOdNYBkE0AJzBWa6kIvJaPphU+kggCwg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(16526019)(2616005)(336012)(26005)(83380400001)(426003)(54906003)(36860700001)(47076005)(4326008)(5660300002)(8676002)(44832011)(7406005)(8936002)(7696005)(110136005)(478600001)(2906002)(82740400003)(70206006)(316002)(70586007)(7416002)(36756003)(86362001)(356005)(81166007)(41300700001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:24:14.3941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9084ddee-9ab8-4697-9144-08dc191bd735
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862

If the BMEC (Bandwidth Monitoring Event Configuration) feature is
supported, the bandwidth events can be configured to track specific events.
The event configuration is domain specific. ABMC (Assignable Bandwidth
Monitoring Counters) feature needs event configuration information to
assign RMID to the hardware counter. Currently, this information is not
available.

Save the event configuration information in the rdt_hw_domain, so it can
be used while for RMID assignment.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: No changes.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 11 +++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
 4 files changed, 27 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index a38609c82b9e..e0ba43387afe 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -558,6 +558,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
+	arch_domain_mbm_evt_config(hw_dom);
+
 	list_add_tail(&d->list, add_pos);
 
 	err = resctrl_online_domain(r, d);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 130854dc8b7f..e109c0388762 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -349,6 +349,8 @@ struct rdt_hw_domain {
 	u32				*ctrl_val;
 	struct arch_mbm_state		*arch_mbm_total;
 	struct arch_mbm_state		*arch_mbm_local;
+	u32				mbm_total_cfg;
+	u32                             mbm_local_cfg;
 };
 
 static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
@@ -611,5 +613,6 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
 void rdt_staged_configs_clear(void);
+void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index de43be2252cc..ec480015980c 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -854,3 +854,14 @@ void __init intel_rdt_mbm_apply_quirk(void)
 	mbm_cf_rmidthreshold = mbm_cf_table[cf_index].rmidthreshold;
 	mbm_cf = mbm_cf_table[cf_index].cf;
 }
+
+void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom)
+{
+	if (mbm_total_event.configurable)
+		hw_dom->mbm_total_cfg = MAX_EVT_CONFIG_BITS;
+
+	if (mbm_local_event.configurable)
+		hw_dom->mbm_local_cfg = READS_TO_LOCAL_MEM |
+					NON_TEMP_WRITE_TO_LOCAL_MEM |
+					READS_TO_LOCAL_S_MEM;
+}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 19b0ebf4f435..df8d2390fc69 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1719,6 +1719,7 @@ static void mon_event_config_write(void *info)
 static int mbm_config_write_domain(struct rdt_resource *r,
 				   struct rdt_domain *d, u32 evtid, u32 val)
 {
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct mon_config_info mon_info = {0};
 	int ret = 0;
 
@@ -1748,6 +1749,16 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 	smp_call_function_any(&d->cpu_mask, mon_event_config_write,
 			      &mon_info, 1);
 
+	/*
+	 * Update event config value in the domain when user changes it.
+	 */
+	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID)
+		hw_dom->mbm_total_cfg = val;
+	else if (evtid == QOS_L3_MBM_LOCAL_EVENT_ID)
+		hw_dom->mbm_local_cfg = val;
+	else
+		goto out;
+
 	/*
 	 * When an Event Configuration is changed, the bandwidth counters
 	 * for all RMIDs and Events will be cleared by the hardware. The
-- 
2.34.1


