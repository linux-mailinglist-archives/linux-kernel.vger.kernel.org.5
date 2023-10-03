Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F43E7B7582
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbjJCXzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238856AbjJCXzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:55:15 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F0C103;
        Tue,  3 Oct 2023 16:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miLX+OHuc4kz+CSxsyKWaVKcQa2FQD1q/vn+e2qL5Um5bpv/C+azQO2TlUnaGJRkZ8ppf1+8Dw47ZxBEaihKu2mKsj6hQ0a7eu/h//e87QiX83v2BL/6i7bK5dRtHv5NIulvI2wQtYGXuzsI3oBq5GOfpiq2+uXFndvAH47AVpbP0FhjCqkCS74A1K3gIBgY3ObspkRLBB1w1p1VkI+nSitwVcnnmeYD2BWk6E9/vAxwVDa4vY9y2dxHzLaLGXFHYEkHhHPGdmJT6cBBAIsdThIvKXhaII5MrLiVjt71vplrLmKjlZHhVZ0e9U9+BWe9dPnCkFI9m64YIfFTqWyDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JiSYhzZ7ZrAaeGF3y7DlJvPqROP28FicXzZSrk25Ko=;
 b=Bq5rC0C8AOWFOxwkJ+NiYeb+j1bxipRJ26jZy2jFmu0R5pUqQZ2y1GdjEscdgPsNNTFQ1ZgQX0Y/+PHoyeK2XPtxlgN5rWOICxSBc+Ltuk6TFdOLY22BSrlskg1T3/gwEBRhjivSbhMgdXKpX5oZgsQQZo292AbjZrvoikFxE4SBky0Es84ge3l5PZfWfdgJ6s3YirBFslLX9FP7P40SfZ9oSRBaGUDuNIbaIBPGO2k9lp92sM9jjNuSZF1/hCyj+ZTijqebnkL08l2O2082WiKcLhT5V4fkd9Z0Djl7ZQBwmKrmVRHoeGAVZ4Xz1kMRduc4ICHGeL396OtGBoMoBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JiSYhzZ7ZrAaeGF3y7DlJvPqROP28FicXzZSrk25Ko=;
 b=fii6Kc6VqZAuKfi2+GxFRO1a92Z7vCq8jYFKpMmAUMNNejZw7WNddeJRHf9x2lgXfjbzBNMRFXpemgRp379sE1llT0QciEHXCQNm2lTInPoCcZhdxF+URxFAh1QD/pDeYIHpHsiZGapIhyTOcutsoVyn8F3EtrdS/uDSLmceSts=
Received: from MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::9)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 23:55:04 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::e1) by MW4P222CA0004.outlook.office365.com
 (2603:10b6:303:114::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Tue, 3 Oct 2023 23:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.21 via Frontend Transport; Tue, 3 Oct 2023 23:55:03 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 18:54:59 -0500
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
Subject: [PATCH v11 10/10] x86/resctrl: Display RMID of resource group
Date:   Tue, 3 Oct 2023 18:54:30 -0500
Message-ID: <20231003235430.1231238-11-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003235430.1231238-1-babu.moger@amd.com>
References: <20231003235430.1231238-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: cab93b6b-fd01-4e3a-8b54-08dbc46c29de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xFmmYbHn7AShgaDiXC5Gr6G+SK+mDXXMuRifHCa1Mhb40R7qBmJ2uqw2NBAR1Ksgme/MDSVNhhSg1s4SYKO7ODqKXfIUz26ZbDsjFJYpG2K6UU8pjbaA/BlbMt2K6V3NSdp9bVkvmMcNHxGqACeP+0GzxnSNjqUYTyZX189xq3KdM9ydDhfUjguWjvqXoe7+ZhYvQidMQxaGdidxOApNYoFooZ28SyLs36gyv629f/4RRRJr8a7cB9mbLb2zRYM2YoMzSg41X3GKJAVEyRNXeKy4h1ptpUZPPNe9cl+R/u2JJ0Myxj5CX/SHHRLDIReAj1lHsQ09IatoEkclx86fGo+t8pLRi0EUvQbbOFUd4Yrg6f3ARx/APL0OCq4a5o7IUv6YjZGYchd5arc0m9VZeNxQ0wjX6DggVNbU9KTZ2CySmATthbQQdai70WinI4EvAKRfiIJc3gGm2sed8qR7fRa6BNtpsHS0UXURAJjFpPSF48U4FxbRiNe9b2jSbXcKt7Hnk5pyTHV7/a1Gjwyc+gxgBFe5pj9NKmcn/kx9UTidSekmiDx3vwCTOL0DVY88jrmNaFV8xKMQGUCKNh7uSCjSEH+6vVTw/CGNCVcydBDbCPKAz9+gaq/uEwk+J1nR11KmFTTUn9dHuFITcegY31kJ6BxubdWffvT0+hZgKcYMt378MylFN4RK1/QA/Pd9Fq4z8GI4VMTxt4SY375OYZMa59qocX+NxYzscgX1hBX2MdRInWpZK5WRez170StHwkehfcJx4UVeDDRafDv0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(316002)(70586007)(70206006)(356005)(82740400003)(110136005)(54906003)(478600001)(7416002)(7406005)(86362001)(2906002)(41300700001)(426003)(81166007)(2616005)(8936002)(7696005)(8676002)(5660300002)(36860700001)(83380400001)(47076005)(66574015)(1076003)(4326008)(44832011)(16526019)(26005)(336012)(6666004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:55:03.8988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cab93b6b-fd01-4e3a-8b54-08dbc46c29de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In x86, hardware uses RMID to identify a monitoring group. When a user
creates a monitor group these details are not visible. These details
can help resctrl debugging.

Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
Users can see these details when resctrl is mounted with "-o debug" option.

Other architectures do not use "RMID". Use the name mon_hw_id to refer
to "RMID" in an effort to keep the naming generic.

For example:
 $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id
 3

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 Documentation/arch/x86/resctrl.rst     |  4 ++++
 arch/x86/kernel/cpu/resctrl/internal.h |  5 +++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 54691c8b832d..98b0eb509ed4 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -369,6 +369,10 @@ When monitoring is enabled all MON groups will also contain:
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
 
+"mon_hw_id":
+	Available only with debug option. The identifier used by hardware
+	for the monitor group. On x86 this is the RMID.
+
 Resource allocation rules
 -------------------------
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index eda5da9ab81f..a25407fde6fc 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -296,6 +296,11 @@ struct rdtgroup {
  *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
  *	    Files: cpus, cpus_list, tasks
  *
+ *		--> RFTYPE_MON (Files for MON group)
+ *
+ *			--> RFTYPE_DEBUG (Files to help resctrl debugging)
+ *			    File: mon_hw_id
+ *
  *		--> RFTYPE_CTRL (Files for CTRL group)
  *		    Files: mode, schemata, size
  *
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 55d1b90f460e..ef4b18091e5d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -795,6 +795,22 @@ static int rdtgroup_closid_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int rdtgroup_rmid_show(struct kernfs_open_file *of,
+			      struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	int ret = 0;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (rdtgrp)
+		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
+	else
+		ret = -ENOENT;
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1856,6 +1872,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_tasks_show,
 		.fflags		= RFTYPE_BASE,
 	},
+	{
+		.name		= "mon_hw_id",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_rmid_show,
+		.fflags		= RFTYPE_MON_BASE | RFTYPE_DEBUG,
+	},
 	{
 		.name		= "schemata",
 		.mode		= 0644,
-- 
2.34.1

