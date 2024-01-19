Return-Path: <linux-kernel+bounces-31474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8818F832ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEDF9B23A90
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B46158213;
	Fri, 19 Jan 2024 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pdhe6ywi"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B905958132;
	Fri, 19 Jan 2024 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688582; cv=fail; b=kf/5qt5amJzGWsJ1V5d0iiX6q2fkqjkJW+77Jf/TH9UCjxsLc9avRkuer3veHml0zbo48jJT4B528Gqmh5YI8yZ9YrMwMLmh2Uow5tah26BWB2DOlrvJX/ZopWxEjAmLIuc6AurPytAUrsprBSndEwdebL9oQ5kydE7e/CB5gCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688582; c=relaxed/simple;
	bh=ciqPavoLBy20KuEH+Xq+If2WRe7d525D7PmtjqUmKS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omp0QvQ4eVlRFv0f8qZ75ppxgAp60kRMUIg15QQNQ1VaVuWhA6NOPxhSK/Xq6K+wp/DLGGXMeyt/SD+dnxaW3+FKxEN4Q35/J9OWTzK/zqU/wJQWfFJuLsrHmFgFbCTTm3ojdwRH3t3AICofn815vPYkgtb4B48Xu/7kpPJOdyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pdhe6ywi; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=am1YB+ZV7OYZBMZPSFtjuDNVjItd06ltcWeuZbB/HGYxLQMHVUlVBXzxM6AtliTnQgVUTzRYPaiuU3aZs6pxeb712gxx/AaNFhIJ5jPzPJ3+bWLHni1xbzxhljoZ0Z/GOiDv3AS/ioGCAR8/yP+Tpz7roQ0GxeA14sbkQ7re9fy6FtEaZ97wB+W1sHfSIiTNC6QPA8AD94saQmMTyJg1CmBi3pxUKGYG39AM88+HZEOynIFauJB+vRhwBWXoJubMfQ4gMOkK3eTnnHf/NlXInGTmhDiQwmq5X0KOmhg4LWQg+m4D970t0+8j/cTxo90egyTQOdzCxFYREyBK6/GRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMqqU1WSoXCzgdQX/pBhMkOGrAJ7Ok6crq3Rz/aXwf8=;
 b=l5g8u+Ee9wxPLbto+2MeLk7/iHyI4TAszskIH03xjDqzaELip3At9DvrzJ0GWMht+ic8v+zMJw++LtLA13wm/yQwNs5+xg3hrqel8W7/Gpv3HyCSsgtPs4DxG2rQI63Yxk+avqZA28f0es/AfGSzTNTBPrkXT2/+avO5MZIkNfeTExTTs8cTikteItHuuUADnfj5rnQ6ixxlv357zWWCOYx3SxRhdIAcgo1Xl4cSnN59/yeFznnyYhLFVjGO9C6CUfUxJKZCgC5N3iw12bprr/dMWFCeJOI3r0p9LG1zU4lqLYGQMuR3lWtEKF4UZiURP+P0Fe8s/oZJQnQccnhg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMqqU1WSoXCzgdQX/pBhMkOGrAJ7Ok6crq3Rz/aXwf8=;
 b=pdhe6ywiE74Rjv7jtYsvjL9QK4SimZULiM4AN7IXn94AbhfbtonfC4Pl2RKEgDxXHi+NpvTr/7+K0vp7FyD0ms6beMntR5LIj+gKKzuCDj39RHvRJnAnO+eGul5KFzlRlEfyroKP1aJsR0ucJQ0fSBD/2mo/1QvLi6pbSQY80N4=
Received: from SJ0PR05CA0093.namprd05.prod.outlook.com (2603:10b6:a03:334::8)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 18:22:57 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::5c) by SJ0PR05CA0093.outlook.office365.com
 (2603:10b6:a03:334::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.9 via Frontend
 Transport; Fri, 19 Jan 2024 18:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:22:57 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:22:55 -0600
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
Subject: [PATCH v2 04/17] x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
Date: Fri, 19 Jan 2024 12:22:06 -0600
Message-ID: <bba869886410265ffac0250ba2a495e3e7576dfa.1705688539.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|BN9PR12MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecd1568-35a0-4511-8706-08dc191ba964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nsW2Ztjd8/HnoXAjBBaG9FmiukUQbezXZqzD+gIx5z7Z9zHVLtthpf1qA6p/Ya8Vd4GDz+Yf1+8U/nDpkG4ymev774505kVvny69uOi4vvmo4XFDuRFGubRJ7sYc/9UzB/W53Txe50f9ZKR2DF3M+S6fSOsFklRUQv4R61EIWuvzF6uoxGN5wWDr3emD7jAxSoEHt8yTBsEG1MdSAK/GLC1SsC7rk6iqfr7NkvGViHn1PpaIVtPiQkRjdfhaOE+YHn35/HHy9S5UUhMs29eT/L9Ow6QGMoSuXmgsK+TwzoxBUwQVRIlc9oCjdCxtfieYtKvl4+MwA7y5HZrZV0Fv3njbP8MmsJ/cKmCCN6kYjQ21Bl8VODJRi7UlwjiCld5AP0b8nRw8QlQuhCuayQ+uo3MwOxFrjmb8fB+VTlcU8UHqwKumef2dfEbC7MNGafICndZuXedELwLhrCZ0a9PNfG9P1UPsmMLG55C15LBkBpio2TxpCvHuBdj4KC+GdQb3F3QopcEMfL90nom3Uyvwbnfh3PsR52pypfsCSLWZCT23HWf6tswYhskAE0m/Mt4b2SRLCT9ZsE9yf/ubmUN60c0IgaQnzjkBS5YOx8Xwfh4DVfHldgGlLqyn4/VnXcWIxYuOtqQrSkmuT9NaAjree2TyG+fQUMwN+BApLgX5fl/ijZBT90QqI8LTb0ysl9avS2jn6VVNxUvAR000aYu3gUSjHC9kQICkZotgW2sEdZQjpSBAzmf+EUeBowixr6xXrhjrNpEUZuZjR29Za/Q6HA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(46966006)(36840700001)(40470700004)(7416002)(7406005)(2906002)(82740400003)(36756003)(36860700001)(41300700001)(86362001)(81166007)(356005)(54906003)(6666004)(110136005)(26005)(478600001)(316002)(16526019)(70206006)(70586007)(426003)(966005)(7696005)(5660300002)(47076005)(4326008)(8936002)(8676002)(83380400001)(336012)(2616005)(44832011)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:22:57.5266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecd1568-35a0-4511-8706-08dc191ba964
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368

ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
Bits Description
15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
     Monitoring Counter ID + 1

Detect the feature details and update
/sys/fs/resctrl/info/L3_MON/mon_features.

If the system supports Assignable Bandwidth Monitoring Counters (ABMC),
the output will have additional text.
 $ cat /sys/fs/resctrl/info/L3_MON/mon_features
   mbm_assign_capable

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

---
v2: Changed the field name to mbm_assign_capable from abmc_capable.
---
 Documentation/arch/x86/resctrl.rst     |  7 +++++++
 arch/x86/kernel/cpu/resctrl/core.c     | 17 +++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  3 +++
 include/linux/resctrl.h                |  2 ++
 5 files changed, 32 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index d816ded93c22..ecc6c65bdaca 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -197,6 +197,13 @@ with the following files:
 			mbm_local_bytes
 			mbm_local_bytes_config
 
+		If the system supports Assignable Bandwidth Monitoring
+		Counters (ABMC), the output will have additional text.
+		Example::
+
+			# cat /sys/fs/resctrl/info/L3_MON/mon_features
+			mbm_assign_capable
+
 "mbm_total_bytes_config", "mbm_local_bytes_config":
 	Read/write files containing the configuration for the mbm_total_bytes
 	and mbm_local_bytes events, respectively, when the Bandwidth
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4efe2d6a9eb7..f40ee271a5c7 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -303,6 +303,17 @@ static void rdt_get_cdp_l2_config(void)
 	rdt_get_cdp_config(RDT_RESOURCE_L2);
 }
 
+static void rdt_get_abmc_cfg(struct rdt_resource *r)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	u32 eax, ebx, ecx, edx;
+
+	r->mbm_assign_capable = true;
+	/* Query CPUID_Fn80000020_EBX_x05 for number of ABMC counters */
+	cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
+	hw_res->mbm_assignable_counters = (ebx & 0xFFFF) + 1;
+}
+
 static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
@@ -815,6 +826,12 @@ static __init bool get_rdt_alloc_resources(void)
 	if (get_slow_mem_config())
 		ret = true;
 
+	if (rdt_cpu_has(X86_FEATURE_ABMC)) {
+		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+		rdt_get_abmc_cfg(r);
+		ret = true;
+	}
+
 	return ret;
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a4f1aa15f0a2..01eb0522b42b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -391,6 +391,8 @@ struct rdt_parse_data {
  *			resctrl_arch_get_num_closid() to avoid confusion
  *			with struct resctrl_schema's property of the same name,
  *			which has been corrected for features like CDP.
+ * @mbm_assignable_counters:
+ *			Maximum number of assignable ABMC counters
  * @msr_base:		Base MSR address for CBMs
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
@@ -404,6 +406,7 @@ struct rdt_parse_data {
 struct rdt_hw_resource {
 	struct rdt_resource	r_resctrl;
 	u32			num_closid;
+	u32			mbm_assignable_counters;
 	unsigned int		msr_base;
 	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
 				 struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 69a1de92384a..9b82ba977d98 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1077,6 +1077,9 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 			seq_printf(seq, "%s_config\n", mevt->name);
 	}
 
+	if (r->mbm_assign_capable)
+		seq_printf(seq, "mbm_assign_capable\n");
+
 	return 0;
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 66942d7fba7f..1751a7b0a369 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -162,6 +162,7 @@ struct resctrl_schema;
  * @evt_list:		List of monitoring events
  * @fflags:		flags to choose base and info files
  * @cdp_capable:	Is the CDP feature available on this resource
+ * @assign_capable:	Does system capable of supporting monitor assignment?
  */
 struct rdt_resource {
 	int			rid;
@@ -182,6 +183,7 @@ struct rdt_resource {
 	struct list_head	evt_list;
 	unsigned long		fflags;
 	bool			cdp_capable;
+	bool			mbm_assign_capable;
 };
 
 /**
-- 
2.34.1


