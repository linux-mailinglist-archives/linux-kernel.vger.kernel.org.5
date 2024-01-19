Return-Path: <linux-kernel+bounces-31487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E4D832EED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95F0CB25F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827D55D730;
	Fri, 19 Jan 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c/K2deDR"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07C5C8E0;
	Fri, 19 Jan 2024 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688683; cv=fail; b=D7Fe+KQgf3DH3Bsp+hz2LLALaf9HQscJ8sVfFyOwmAtcRzjnmYRAGhhLz1BB8I5O5h4HUggZtWWSpEkYjjL+nRtYQmcKeC3DFn/q8YDQBsqj5GT/SP2YLAcdAgtwA1kiNzq1d+8YoYysSj1Lg2HU8i9WyooZ+u497G3FjyZdon0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688683; c=relaxed/simple;
	bh=ij/B2r66LmkTZgHMKRic6q6Ab2JCPxqpv1y2mcVigPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ky0CjJG9d4f+D9G7vsLCrCu2sfD3kPqZ0OkubVmowp6z56Ibi1NPmrrBd4ohC+anEiC2HLWepknZqQ2hbBr0vMyyTyg10XiLHBeTdGuxo4dt8JfzUJ9Y1GtECYcQ6D7MTA2r6qnrRhfVZbulLF9zUpOAvgNBsQMpv78ZnHg2B+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c/K2deDR; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtH0H9rxZ7CTKhHe67ov1ZkkH7SKb8QNBzy+BRQ82OC+DRSbgMVICALe9tzxTpP5GPJrsW+0z5HdmXx59e8njIYhyGTJnOfPFRz/J1h3hTu9P7pdR1wqoR+essmanaaA2dM0z00jY+oEHffhYzVCUsK6Un3kxdfE1FuyhJOp8fsviVt1zQkkO2MIrEOcK8bIgc9/tzl+AsHWMX6c7w3b+SL8dOGmPbM7dkdnBW02/oEYQ2zcbGzJ5NHRXE7629zVbRpXUEQm/zeH9q1ugIHk6Av3LdYswpjuL6I5e3+52QZ9vPxzwVLC7AZIaUBfkqTT+0IvjNzfxjw6z98p2tx3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey/aUdM46vV/KAGNVtqFoFQ5hxPwP+uOLGZwLn0Qt1A=;
 b=G963+ru/zeb2abuAU/CJkcg71YJvjqR9iKs7aG3bEI3hMdpzLM8A9DZYsjSBj1tZz8bo+xWBy6ElEaGgg8dKe09Lc2qKZY/c/vnT6SEPZefObbArtzow8CJhSXQCprNCNKnlEGWLRZA9xYul1YJcJ4glRC6L1aEJHhLjvYJdoiaruA2ZnRh2oKrNLhDLkd55+dsldd3r6TDd7UojAxhwdQpdOcnbgUlCr8/aKRxpq+oLklNDbYyPYNxZ0uMA8BDkM6WV4LAvX7N9jUsLl4fbLsd4DO731cYVcpqHIB/Lc1HpdGfc6RyAINvBnSAYZdZoltAYi02CfRCfAXfyFoDp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey/aUdM46vV/KAGNVtqFoFQ5hxPwP+uOLGZwLn0Qt1A=;
 b=c/K2deDRFDy2AX6JK9WbNgl7oYSTdoYR/TocwqIP8jNjCtArHRNjEFu034QtPpvUv3t79e383AViM5kA2YTZ1nwiFmv4AKs9yYeVW9QYjzlzbmKP8b1vizPL369oYIcGlwz8RiJ+U8+3Q6RFivKN5PkOyA9PENEDpz0xYUu/eqY=
Received: from BY3PR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:39b::30)
 by SA1PR12MB5639.namprd12.prod.outlook.com (2603:10b6:806:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 18:24:39 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::73) by BY3PR05CA0055.outlook.office365.com
 (2603:10b6:a03:39b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.9 via Frontend
 Transport; Fri, 19 Jan 2024 18:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:24:36 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:24:35 -0600
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
Subject: [PATCH v2 17/17] x86/resctrl: Update RMID assignments on event configuration changes
Date: Fri, 19 Jan 2024 12:22:19 -0600
Message-ID: <b2553864edcf571d0374dc12ef6319459942c62a.1705688539.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SA1PR12MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4c0f7d-d4e7-4732-6448-08dc191be4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IOx6+aybQFbiUVBqdSJTFijpc5WMcVCwuvYQLKDhJxLu8x4Hprbo1PZE02GKqnNI1BdBwl8IQRbE3ATH+eIQItL9ACN3cskCyi+H4+GgZV3GgGwNvyspaJhPjTxu3g1Tj3Cq9FmGTQMndIVdP+f1Mk8KgKLHc3phpZlB0y3X41jNdTqGtrtm4kecOBGaWOdBvQ3YlGPOCovUOh9tuwXSxpBCeQB0a1LYx4xnSToPeu0uADAJvKuHTK+dox+Uwq+tQquIyS43J0/JdcLxTD1S4m5TtRJzPLS18IVXPNLwLF84oWba4q2ZThSXPoa7KB7z7KqBz7o3pON5Kr8BVhZr5SkOeJ7V9L/JzwFNuC5LdYeuXeu0Ua9QGQdOZQOt0LgHg1lFyThfnr9hk5Dt/yWkmh73DKQ7fWK45IkaBDo6xqEqDexYPwyRA7j7NJLCKlSQbyw4L0z91wjPsVx46xIuIXQojm1lAZNHTHZOUBWBOCWLKHLwim10xvHV4rt+QgMQjBiVjjnq+Qh2pwt/A6ckGnObSl9IEwbjrZAT+zwmbkoxKQKwAyzqbLQHMDUl2j3eBYPCPLJj693c4xQ9S3xjjCGtMy8udm1tPwTrFNDzzN3krOFcElSUg/Jo+IojxYnBVDBAZKbJPihiACEOy0CCDIYV/81xZdu/9XO23r2j26XOp/CSwDGJGvPUsGb6BS+ZoOyH9AhKFSo/xtwyR9rtQ9TWpkXh5F1wNl38sJjeIax0T1mDQpQtmO060GQWHAMe6xi4FchroduqZURLpT9A0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(6666004)(426003)(26005)(16526019)(2616005)(7696005)(336012)(82740400003)(86362001)(81166007)(36756003)(356005)(41300700001)(44832011)(83380400001)(5660300002)(36860700001)(7416002)(7406005)(15650500001)(2906002)(47076005)(478600001)(8676002)(966005)(110136005)(8936002)(4326008)(70586007)(54906003)(70206006)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:24:36.9797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4c0f7d-d4e7-4732-6448-08dc191be4b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5639

When ABMC (Assignable Bandwidth Monitoring Counters) feature is enabled,
bandwidth events can be read in following methods.

1. The contents of a specific counter can be read by setting the following
fields in QM_EVTSEL: [ExtendedEvtID]=1, [EvtID]=L3CacheABMC and setting
[RMID] to the desired counter ID. Reading QM_CTR will then return the
contents of the specified counter. The E bit will be set if the counter
configuration was invalid, or if an invalid counter ID was set in the
QM_EVTSEL[RMID] field. The rmid_read interface (resctrl_arch_rmid_read)
does not support this method currently. Supporting this method will
require changes in rmid_read interface.

2. Alternatively, the contents of a counter may be read by specifying an
RMID and setting the [EvtID] to L3BWMonEvtn where n= {0,1}. If an
assignable bandwidth counter is monitoring that RMID with a BwType bitmask
that matches a QOS_EVT_CFG_n, that counter’s value will be returned when
reading QM_CTR. However, if multiple counters have the same configuration,
QM_CTR will return the value of the counter with the lowest CtrID.

Method 2 can be supported without any changes to rmid_read interface.
However, this requires the contents of the MSR QOS_EVT_CFG_[0,1] to match
the BwType while assigning total and local events respectively. So,
whenever event configuration changes, the ABMC assignment needs to be
updated to match the event configuration.

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
v2: Minor text changes.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 869fab878087..91a20e601ffd 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1828,6 +1828,38 @@ static ssize_t rdtgroup_monitor_state_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static void rdtgroup_update_abmc(struct rdt_resource *r,
+				 struct rdt_domain *d, u32 evtid)
+{
+	struct rdtgroup *prgrp, *crgrp;
+	int index, mon_state;
+
+	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID)
+		mon_state = TOTAL_ASSIGN;
+	else
+		mon_state = LOCAL_ASSIGN;
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX) {
+		pr_warn_once("Invalid event id %d\n", evtid);
+		return;
+	}
+
+	/*
+	 * Update the assignment for all the monitor groups if the group
+	 * is configured with ABMC assignment.
+	 */
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		if (prgrp->mon.monitor_state & mon_state)
+			rdtgroup_abmc_domain(d, prgrp, evtid, index, 1);
+
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
+			if (crgrp->mon.monitor_state & mon_state)
+				rdtgroup_abmc_domain(d, crgrp, evtid, index, 1);
+		}
+	}
+}
+
 static void mon_event_config_read(void *info)
 {
 	struct mon_config_info *mon_info = info;
@@ -1912,6 +1944,7 @@ static void mon_event_config_write(void *info)
 static int mbm_config_write_domain(struct rdt_resource *r,
 				   struct rdt_domain *d, u32 evtid, u32 val)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct mon_config_info mon_info = {0};
 	int ret = 0;
@@ -1952,6 +1985,13 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 	else
 		goto out;
 
+	/*
+	 * Event configuration changed for the domain, so Update
+	 * the ABMC assignment.
+	 */
+	if (hw_res->abmc_enabled)
+		rdtgroup_update_abmc(r, d, evtid);
+
 	/*
 	 * When an Event Configuration is changed, the bandwidth counters
 	 * for all RMIDs and Events will be cleared by the hardware. The
-- 
2.34.1


