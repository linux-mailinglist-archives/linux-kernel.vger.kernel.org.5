Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E07C458F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344240AbjJJXeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344141AbjJJXeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:34:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8611BE0;
        Tue, 10 Oct 2023 16:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A09/HRyQnSlBWJCexeRgVIFOXTfGQ/KTHrYWNv++ceq+zOAnEuGwDUEMk2WLlru71GJpa1CTVg3LWhk45sUpHFeCgkP7y59a49GSIHS5ab3ASp268le+2lgHs/3DhE6UMm1NNohu1PHagSd3UFdpVJytG3hYvgdSkjBYwbW75yZ3kE9AlG9PVdEuyWQcJvMCaZx7tEoYUHhDKMthlx1ATjh6oEiFKXAewrqNs806OmoeeEcygFfERaoWRDmTAYhhvGJrGmgyHFmNpJ7lyTwB0NRl8VK+zc9tKSXXzwjEXj1T8CmP4ojgA8rWO406+RFiOF1g2d3lYm5MhTyrcCWUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dc+oJiQA2vAp3G2TZl+W32BuVWJbjfvwNJiGkrhQPQ=;
 b=fWqbSBQAkMdzxLMxWZOUseJCjtd8bLgNeTBsjMIbkm8P1BO8wV4IlNREgpbdy3cvNbfNOuV83JWguzdGKiU6cRI0Ci7Fk3aLsraQ5OUu9l9xGEoeewQkXzkUuUfiZwwDdPyrWI96RTxNd5IETSO+bkgVFKcgdB60mpgXie0iHl6MkhaK8RoJUSbJUdnm3qR1noIA+soZNz3PW154UlQ7qDbQpjTE0V478HjH2Im0083QqMrCjEX0xIQYOguQPHY4KJnfTc2fyTUUnHSTmzrj5JLQ7zeAu6f+1FPqQdru3ATIKTr9bZrHfHOVkgGub7C4kqezRC3sJf9lF90GeycWGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dc+oJiQA2vAp3G2TZl+W32BuVWJbjfvwNJiGkrhQPQ=;
 b=d676wSvbq+pazsBsnGz4Javt/eWUMpqC3C9Bu5cNT6W5NV4MKf/FaPSVb6dkqDEQuR4+GnlSx8FmgcocO91FUaH07yXZ6gWzUloO9xiAJ3b2vEKkOFOz5dqh05FKgblpcgAiz49nSWItf70fQzdyOfKIMeU1kjVhlgb0Ev+NToQ=
Received: from BL1PR13CA0449.namprd13.prod.outlook.com (2603:10b6:208:2c3::34)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 10 Oct
 2023 23:33:58 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::21) by BL1PR13CA0449.outlook.office365.com
 (2603:10b6:208:2c3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.23 via Frontend
 Transport; Tue, 10 Oct 2023 23:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 23:33:58 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 18:33:56 -0500
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
Subject: [PATCH v12 09/10] x86/resctrl: Add support for the files for MON groups only
Date:   Tue, 10 Oct 2023 18:33:34 -0500
Message-ID: <20231010233335.998475-10-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010233335.998475-1-babu.moger@amd.com>
References: <20231010233335.998475-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: e26d3233-126e-4de7-42a9-08dbc9e96038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJ3Lfg2BUiYtiOL5R24wsXiCEamJBlLCMue7S1a0NXcy9/Oar0KZb22bCPC0aA+dnuIOdbe7TGFFOB48Avu2rw3udMza4lKgDpRVGzGsJdGQIGFrYyXQzrLPVu+p8+uYv9560IRSiP3jefQhFCZ/byL3WTFpWZqpNkYOaLat4gdZNSGgk6H362uSLHlmrgqf3CHTkx5J8k9wMlXzk+EVOwv1l5ABrrPHBIHzXBFWn6Uj6J/YDPSpw8p8OBW83VA6Azv4E+5KT0eUGEkiBCkYP35ETq1gVCir239xu5mm6NuIkf3khc7zJ+LcEMAKFN+nS2Q2yTfbQ0q8ON/vO/NryhMAuIi9lZvzTM8vt52soBfOZhsKT3krhgn2Ae73e1nLfHdfblUhd0HyBwdbh2N9LKKfkjmYd8D3rC/S/2Vc+Njy61nEzSXVbuSh2GR9XK859/B/SFTu8pHGMHb+IuOvdFUxYYVm8zyAnXGX9GmwkMoGqkxl4lmL3K/R9Aur5vrMmT3UOT5LRpG74p5TEq6zVUb7Njkd34cG0UsgiZSM/wa3HcAx2fsNwBoauIW89vA3j1dKHvOpzKTDIZ7NeDW2cCAFBnxgvwgDxEfNGkisYGwRvvJIYLYGVOn/NJY03ZTYtLLFo4c37R5IcgL9aauoM7U//i0CWtLFot5tAzqUfVBYbesYs0zmlq4tkoOt+7dB1cyhG6t2dye7wqjy4JRfikKoIUM7854Vp+8LVX7o2+08IU9pRihbondoLRx7rD2gOqRsaE2cNZ6NzjTf7xS12w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(426003)(1076003)(36860700001)(16526019)(66574015)(82740400003)(478600001)(70586007)(36756003)(81166007)(7696005)(54906003)(336012)(2616005)(83380400001)(6666004)(356005)(26005)(47076005)(70206006)(41300700001)(8936002)(40460700003)(7416002)(110136005)(44832011)(8676002)(4326008)(316002)(40480700001)(5660300002)(2906002)(86362001)(7406005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 23:33:58.1294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e26d3233-126e-4de7-42a9-08dbc9e96038
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Files unique to monitoring groups have the RFTYPE_MON flag. When a new
monitoring group is created the resctrl files with flags RFTYPE_BASE
(files common to all resource groups) and RFTYPE_MON (files unique to
monitoring groups) are created to support interacting with the new
monitoring group.

A resource group can support both monitoring and control, also termed
a CTRL_MON resource group. CTRL_MON groups should get both monitoring
and control resctrl files but that is not the case. Only the
RFTYPE_BASE and RFTYPE_CTRL files are created for CTRL_MON groups.
Ensure that files with the RFTYPE_MON flag are created for CTRL_MON groups.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
--
v12: Removed the comments about the later patch. The text is
     moved to patch 10. (Boris)
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 953b082cec8a..55d1b90f460e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2533,6 +2533,7 @@ static void schemata_list_destroy(void)
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
+	unsigned long flags = RFTYPE_CTRL_BASE;
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
 	int ret;
@@ -2563,7 +2564,10 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	closid_init();
 
-	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
+	if (rdt_mon_capable)
+		flags |= RFTYPE_MON;
+
+	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
 	if (ret)
 		goto out_schemata_free;
 
@@ -3253,8 +3257,8 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
 {
 	struct rdtgroup *prdtgrp, *rdtgrp;
+	unsigned long files = 0;
 	struct kernfs_node *kn;
-	uint files = 0;
 	int ret;
 
 	prdtgrp = rdtgroup_kn_lock_live(parent_kn);
@@ -3306,10 +3310,13 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_destroy;
 	}
 
-	if (rtype == RDTCTRL_GROUP)
+	if (rtype == RDTCTRL_GROUP) {
 		files = RFTYPE_BASE | RFTYPE_CTRL;
-	else
+		if (rdt_mon_capable)
+			files |= RFTYPE_MON;
+	} else {
 		files = RFTYPE_BASE | RFTYPE_MON;
+	}
 
 	ret = rdtgroup_add_files(kn, files);
 	if (ret) {
-- 
2.34.1

