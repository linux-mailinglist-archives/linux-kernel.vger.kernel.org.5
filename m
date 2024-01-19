Return-Path: <linux-kernel+bounces-31481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FD4832EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29E95B250CE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2745A7A0;
	Fri, 19 Jan 2024 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CpeGqYGV"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61AD5A799;
	Fri, 19 Jan 2024 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688635; cv=fail; b=Er007ximspudqpRxWWIgpIEhVoQUa1tlH6sZSVqb5s99ibc4qF/ZBqihIq+IJkJl1CeOJW/y6wn92/CASEV4nMTG+Sh3Z7nmHploa6n62SqC3pmrxDoKKdXFKGChCai4DSP632hiimzsvO30WWA+a5q7XonngI5/bqiwhmZFWBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688635; c=relaxed/simple;
	bh=Gs0Irv7M0dLT2QinRZX9aSRMAYhD+Z6nwnJ50OSajzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNHbqjaa3SzgASAsBgjfx7yvRxqx+jW9kUGOgoPW7aSWKRyV5JpYT8I4qkpH+8AY4ZgXFXaKociPdTxDzsvOUUbLsoUPDLDeJL+na8P3TaB2tRyeS8LDLGQsT1JX4Bh+HJ1LI1EgsVXaNx5ou7QFeitpaU+xuHUU30DQpSEcue4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CpeGqYGV; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVEw6ckcwSuQOC51bgmrU0EmbPqCotqRCuTwE5W9taUJtR9JgDYJ1fSiMpGaYOqTgvLu+P156GJMPnvQkv6icLizCm5BLCoA0ex/eRxawoZh1u5zIev7baKTv3eqazDLDC+P+Y1VaJFt2x7P3GUH1qgAO2cTQy1Nku4Gu2540eDbhnmv5HryUQFQyhR3mY2TqLeU5AC+u2aRbz0AO3V8gx9FwVc5ZJepXyguHc9fWyr9Jqyl+lHU/pRjfgxDXRhMMs2J59+nCxoEI/U4ch029jx5mU+KEyVvacbuqU4ryIcsReK1ZhzFPb8xr+rIIdxESpHBUFwxDD4mTkwxjvI2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aWqAGbcxoStdb87y3e2or3fgD6yiv73frY9+EG7yPE=;
 b=nYbdaDY/Mn1lBCu1tdiFFFEIyKUUhbnO61a7TWUgkfzjMct0rg8k5q27zTbWMkR5PYNlzoDd7dph3NyYzm3VOIEVS0ZwEMb29QrkGNtSnVG4Hc4zZb4pVmZc2iaPAOKKNSHvCdfBYmov8ibMlOeqG/c6L9oS9gtzH6cnwCOmZ6TCYMoE4c2m88ZuSmr4C7bFmqCVHHmpmAeykwkWIez+P3MSOawxzJNGF/dTivN2f7wLEtHlNyg8FCXdFL0PWPTe4bdeLBw9MKs5g7+JRJMBGppjpQUBSABgLQTYivK/H6ToFG6vRHHEwYCGyzT12pvrWhBhNK34grS94G85EU0YNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aWqAGbcxoStdb87y3e2or3fgD6yiv73frY9+EG7yPE=;
 b=CpeGqYGVu5cuHzF37b4vUihk7f2kkdfGPwnBBfnyyGS3S8WUa5RaOC6zq8u6W+kvxW95+6lIFEHvgDXPoFEboF0rtmb4AYniRPD1EUJINWRVZBnivW3VZlEOM6TNMB6+MulRwRgcw0p47v2na/Ev2WcpCmdlmMH7+PY76hBt8No=
Received: from SJ0PR13CA0103.namprd13.prod.outlook.com (2603:10b6:a03:2c5::18)
 by BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 18:23:51 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::75) by SJ0PR13CA0103.outlook.office365.com
 (2603:10b6:a03:2c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.9 via Frontend
 Transport; Fri, 19 Jan 2024 18:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:23:50 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:23:49 -0600
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
Subject: [PATCH v2 11/17] x86/resctrl: Report Unsupported when MBM events are read
Date: Fri, 19 Jan 2024 12:22:13 -0600
Message-ID: <6a265cb586e4707a97b92641462007d5bda37cb9.1705688539.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|BN9PR12MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: f24c4501-7aee-4e02-7725-08dc191bc90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kYZWyKrgHTLuslMXnp1TDBiQOeZNrdJPLKWtTkOqf9We5VBoQZQOFzoPVBQFSKEQ3KqJl9xtD/jqZWp3RTin6e3lK4npSIs34CafyMp5LWmB05sd0+6G4F0lNmlgR3yc9/lCC90ChUhvzY2tfqF1M29xX1dQViEXi2t0we1UaSdJIgdO1m0Z6S0x5GP74kTCe9GYsjnh8hOhLkIt6TjvGv45vQj+o3/I4FjL+PdCkbjGBNOeh6eh0ZIf+VFkKzNsK6tGlCdKIXMzuoV5GKh2PJbc1IdcKhmHI9KTkiponrae3ZvvfWTpipk0jPIH1om+z0l8tadQ1tJ4ScxjytOvj8MJIfoDodAkgT83zHiVhKpA1zkbFfei42lteK3EDwXbPYvUriQZymVAOM7tA1sHuwl9d97MAV2XMFNEhH8unyhESbNMoG8m4ZpwtBj4RgwdEpheQVmfW+56ke2baAhaouzL8nQG1PrUzfJ1e02F+AogPlVwA7uBdpc8kjPo+0GO3FUOjrLBTiwZMDdOOeELA3wi3tCR4MRKypVf7cAhyb28phBCC9ho3JCYzodtkksRblGINpRm0U1SUMXSthP4zpdjwkLE/rYwpkh6zkVWyLyatvwYesH9aSrk50td2n0ryfMXx8QteDiFszOkHMGdFDCti/nDcmDloWGyu7SQNBAtO6xa0S1kZBZFAGS6TrrHyeWlPlm+myTPAty0Ic8MZ0J/xAXpgP9momFBSFR/YjFTgcfMoax9CM2yddwkP4D0JKgYdu3sVre82lsOYNIZsQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(426003)(7696005)(6666004)(86362001)(16526019)(336012)(26005)(478600001)(110136005)(70206006)(70586007)(4326008)(54906003)(8936002)(83380400001)(2616005)(316002)(47076005)(82740400003)(36756003)(41300700001)(356005)(44832011)(81166007)(7416002)(2906002)(8676002)(7406005)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:23:50.6391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f24c4501-7aee-4e02-7725-08dc191bc90a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5381

Hardware reports "Unavailable" when a user tries to read the event when
ABMC is enabled and event is not assigned. "Unavailable" is reported in
other error cases also.

To differentiate these cases, skip reading the event and report
"Unsupported" that way users can take corrective action.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: New patch based on feedback.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index beccb0e87ba7..cc4c41eede25 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -542,12 +542,14 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
+	struct rdt_hw_resource *hw_res;
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	union mon_data_bits md;
 	struct rdt_domain *d;
 	struct rmid_read rr;
+	int mon_state;
 	int ret = 0;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
@@ -568,6 +570,19 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		goto out;
 	}
 
+	hw_res = resctrl_to_arch_res(r);
+	if (hw_res->abmc_enabled && evtid != QOS_L3_OCCUP_EVENT_ID) {
+		if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID)
+			mon_state = TOTAL_ASSIGN;
+		else
+			mon_state = LOCAL_ASSIGN;
+
+		if (!(rdtgrp->mon.monitor_state & mon_state)) {
+			seq_puts(m, "Unsupported\n");
+			goto out;
+		}
+	}
+
 	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
 
 	if (rr.err == -EIO)
-- 
2.34.1


