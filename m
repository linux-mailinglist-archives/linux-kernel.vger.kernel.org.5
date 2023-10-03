Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4437B7583
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbjJCXzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbjJCXzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:55:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B10BBF;
        Tue,  3 Oct 2023 16:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLNJQBKRJPzhi16l1P8zDDyEjYocuiuwINootZr4hOnQGaTi3LVQkVmxl9+zr1u1o+tAVxCw9TGz5brPBnn+AmRzz7GGxCUkq/AGmFeA1tBMVdzE2bMuG26s+2dTS8aumKoAlnmYUKeOdER/tkKKuNCqZbJ0Plr/YavY0Umu2xWTJIolqt2pB0ilzvZycEWEbtq5zSaRcskZXZPu26nfmodoR98pXb63gLSOEN4jLCwXgm2aenQVWG8LalWK3rQNNA8OMhZRIiXvlZEcnDJ/GWe/cPay9vFU734eYRQVk5xX6rqyT8wM9yy+o8HRIA6OegXq+YmAb8058Wafc98BRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J+w0jVFnvyWGsoedzrlMz9PpUJA018ZIyHAgQ0g1v8=;
 b=Tispr3p8LkouUV++pZ/S8RIyvzzvBWBNtTvwfv6gkPL/SAvxZk818FjymFU3jq0z4md97Yasgau+H4paQjYMM91d6O1DyjuThov1ansRYeFqgffAsekzirjHgnCGQ8VF+67rlEeHRVeiHyTKUnMv6rdtahl4st0aI9oO9PBbUOxRNoSPtrXZNVmSVIqC0Wp+6aAZ0zepGiU5ngceDqu1A6MF7Xg9W36O1VfFfpMNoQD+V1nTzd65b1Ei7R2Lw77QQ/3kUIazFvmAa4Vc25wVmzrHAaojPWTW4EPoK/z2tL1Udt2XB1RVgASeIC4Z9dZtckSfhz1uGJv6wUcdVKZpmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J+w0jVFnvyWGsoedzrlMz9PpUJA018ZIyHAgQ0g1v8=;
 b=zAYsLan/qie3OCUChWBa6EODdlhaHIYS2U1LYEevzcmsNYtZqzQPEy0mmlc0WNjrZTVV2VrIFeG2l9tksWNHkRkqr9QZQgZuPeX/3IV7tAtcHUqoEFuYA3rYAF7o9na/QYR7TEsdjUQPCSUmWTLCY25m/NdBmyg+I2p/KTomk2M=
Received: from MW4P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::31)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 23:54:54 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::59) by MW4P221CA0026.outlook.office365.com
 (2603:10b6:303:8b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Tue, 3 Oct 2023 23:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Tue, 3 Oct 2023 23:54:54 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 18:54:51 -0500
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
Subject: [PATCH v11 05/10] x86/resctrl: Unwind the errors inside rdt_enable_ctx()
Date:   Tue, 3 Oct 2023 18:54:25 -0500
Message-ID: <20231003235430.1231238-6-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e76f15-63ad-4d22-3c84-08dbc46c23f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rO6UjeExdgLCtKR7Pzx1j/gbRvlCTzWr5FxhBFffBUOeOdpeD2zxjn5KDz6GNDymEg9g5taIAlksDA2WZSnRJt+JdX6csDOI3vVIpUpFMxyVxd5pmuV1cwTY1/q9vu3euF+B2T3n9g5wlPFADbwwdKXyp1yRQoikmQfM3N0ut3DmS3JUQRNozLmeAePUbWJcqoV81mR+FEAWa6uh6wNV1daIYuwXD3wI5YbllpTSNagOx/3j8Uo53w50Q8bUJE35EyNeYkr47Rik3nCPkCEcTFxJESVUHZF4N6Boq/qra0WOKRerq2O0WCrXmVOxzlwB/zwL3G9WbHixtpC/E/cAa+OQufQcn1tPe+KUGzRJha1LL1qkl/vTxYEECzX7EmNhhBPllyKoYUxtdlyMkg/RP7KOhqF2h5Z+Y/1zwC8+H8TbdkBXYw33HA0qbLGTwI5cAhhng8b2JfMGBndn8HdRzAgFGg/ZtniziKh/lIoTrZkXobfR8soheo6bsUhNwd0pyqtrojKtRPgN5lKcnICRowwN0E+1uI2Q8cw9uuXFp0S0fw1oXdfum+qhzJli2s7GbgGkoVbr8o5NWU+McnTrgYOnzn+EkZh+OU2nl6r4apq6JAI5dsDCMie7/U/1y66vqXH6VbGFyMzDp+/J7Wd1GHFXc7xQ4FwIsrWrApm+r6z6H/cDdBq/iTs2MBS8FdQivPGua4sigXhzz7ZX2jyJTewDY+dS6mKxQuDStYrx6roL4Kewx9975Rl5LYZWl8t489K0eeYXmSwdBfAQBaMAIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(426003)(7696005)(6666004)(478600001)(66574015)(336012)(2616005)(16526019)(1076003)(26005)(83380400001)(7406005)(7416002)(2906002)(110136005)(41300700001)(70586007)(4326008)(8676002)(70206006)(5660300002)(54906003)(44832011)(8936002)(316002)(36756003)(86362001)(36860700001)(47076005)(356005)(81166007)(82740400003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:54:54.0633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e76f15-63ad-4d22-3c84-08dbc46c23f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdt_enable_ctx() enables the features provided during resctrl mount.

Additions to rdt_enable_ctx() are required to also modify error paths
of rdt_enable_ctx() callers to ensure correct unwinding if errors
are encountered after calling rdt_enable_ctx(). This is error prone.

Introduce rdt_disable_ctx() to refactor the error unwinding of
rdt_enable_ctx() to simplify future additions. This also simplifies
cleanup in rdt_kill_sb().

Remove cdp_disable_all() as it is not used anymore after the refactor.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 53 ++++++++++++++++----------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 35945b4bf196..3ea874c80c22 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2290,14 +2290,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
 	return 0;
 }
 
-static void cdp_disable_all(void)
-{
-	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
-		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
-	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
-		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
-}
-
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
@@ -2377,19 +2369,42 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 			     struct rdtgroup *prgrp,
 			     struct kernfs_node **mon_data_kn);
 
+static void rdt_disable_ctx(void)
+{
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
+	set_mba_sc(false);
+}
+
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 {
 	int ret = 0;
 
-	if (ctx->enable_cdpl2)
+	if (ctx->enable_cdpl2) {
 		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
+		if (ret)
+			goto out_done;
+	}
 
-	if (!ret && ctx->enable_cdpl3)
+	if (ctx->enable_cdpl3) {
 		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
+		if (ret)
+			goto out_cdpl2;
+	}
 
-	if (!ret && ctx->enable_mba_mbps)
+	if (ctx->enable_mba_mbps) {
 		ret = set_mba_sc(true);
+		if (ret)
+			goto out_cdpl3;
+	}
+
+	return 0;
 
+out_cdpl3:
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+out_cdpl2:
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
+out_done:
 	return ret;
 }
 
@@ -2497,13 +2512,13 @@ static int rdt_get_tree(struct fs_context *fc)
 	}
 
 	ret = rdt_enable_ctx(ctx);
-	if (ret < 0)
-		goto out_cdp;
+	if (ret)
+		goto out;
 
 	ret = schemata_list_create();
 	if (ret) {
 		schemata_list_destroy();
-		goto out_mba;
+		goto out_ctx;
 	}
 
 	closid_init();
@@ -2562,11 +2577,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	kernfs_remove(kn_info);
 out_schemata_free:
 	schemata_list_destroy();
-out_mba:
-	if (ctx->enable_mba_mbps)
-		set_mba_sc(false);
-out_cdp:
-	cdp_disable_all();
+out_ctx:
+	rdt_disable_ctx();
 out:
 	rdt_last_cmd_clear();
 	mutex_unlock(&rdtgroup_mutex);
@@ -2798,12 +2810,11 @@ static void rdt_kill_sb(struct super_block *sb)
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
-	set_mba_sc(false);
+	rdt_disable_ctx();
 
 	/*Put everything back to default values. */
 	for_each_alloc_capable_rdt_resource(r)
 		reset_all_ctrls(r);
-	cdp_disable_all();
 	rmdir_all_sub();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
-- 
2.34.1

