Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205AC7B757B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbjJCXyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjJCXyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:54:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500FBA9;
        Tue,  3 Oct 2023 16:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdgZvuh0AOahsCW3buPSUAoQH5tnS3Yka4dfC8yPhjTOYCq2bM7fjmSO6MNEePFO8yVkiciDyqO8HDZihS2Xg2jPk3EDkrsn/AUl3yYan4fG0Jt1DE9nMAgfZx1DG70f73d1FvrT5FznPZLyQCV6XHlH1k5S2qTaU3znBZWTi0cJoUy3O/7WNtfLUu8Py++Zfj41FAQ0yryEmXuJx793BypoX0XeL3YlNBfKBciNx4X1KmiyRRDqFWbWJF23VOt/pCDYI8l25LSN3pN9y/hO10Q8GD/UPSS68JpWTi+q1geaJnPQJPUdU9NqkytZGJN+UeEvt2IYZyruQY5InfAEvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaCH8MTSkc0UzW+UL86tyRkNZrgjqp9oEk2+/H79ms4=;
 b=dP1TDGiXYSYz9nKlB6r187a0Mhyk6XIi20pkvK+CoNz60xJnrLkzIq5HPxErtsYLmK5H6+cpkOoEWf9ulFNi7pHcA21qh1cd3W1mhA9yyppfSMX64feiEuBpRr/RkQhghCM5+K2oPzcii6It5ye7stAEZ7dFIjvUbpu7cELbxdH5Ii75fT4R+F0/w6Eq13rYrfzgKyMhPtCiRq8lRUqJTwdqjmf0CWMtFIz4lSvLc65esypXSD0Dy+EP/P8XGbqd+ESq+w9ldfjjhe97Rio+LFDvjJt0raaaZjzBBcEPAev18F2FJ4in3MaFU7ePvshqynlw4tpGFfsogQqJRVY1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaCH8MTSkc0UzW+UL86tyRkNZrgjqp9oEk2+/H79ms4=;
 b=1Bp8dORq5/U9O44IBJ1OGbMpjwdZ0eeHwrYg4uPTyAe5ditcDRVdChZ91YtI0/2pIO8SPtPeEzmJ2kACmYyT252bSusle6oidUUGgK4twzSdWsGeVqlx0RNAXKGo+vmCBSPEsrsIU03Y3kRaDmA4qzP2v46IBN99aGq4T3/ep/s=
Received: from MW4P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::24)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 23:54:48 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::c4) by MW4P221CA0019.outlook.office365.com
 (2603:10b6:303:8b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Tue, 3 Oct 2023 23:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Tue, 3 Oct 2023 23:54:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 18:54:45 -0500
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
Subject: [PATCH v11 01/10] x86/resctrl: Add multiple tasks to the resctrl group at once
Date:   Tue, 3 Oct 2023 18:54:21 -0500
Message-ID: <20231003235430.1231238-2-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CY5PR12MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9cbbf1-a000-4710-5823-08dbc46c2024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHEvOhmEw+wAcQw9B3/vJ5UA2zxfdaLwFE9zNjTeXMFMFCBTgfMc7Nx3BR211ADsQFoCzcHg6u+w1086JtWegV+hljkAIeASN63K0SH4X9BoPFPJ/E0FBA/bWczYicNe0RBaaf/fodE/ff7ZgqXs2Y9blkc7f12AoN8KfWpzS8hqN8V9ydH/VQv7M2i+caq0lCDWHKgmr9tou94n+R9SOSLy8GRX+U87NGBa0iZ1CePJBfkmtyipgtXIW6cQGVASgu9ursUifrCRNgwuux9QSEJI58vY2DpUV1siTFgt3oJlllBubuC1BJCrOi376C+83MRdC++veXTAKm+px1sq0vRxI4zNaC9xDU2RreyYKh4Noxj2W13Gq1f+9KNb4FZ50IDIHuBhGob/71xv2pcDgNhru3bmJ29oXxyYQJluCjxofbITM1X8Jv0p/08WmSdR6CE3cCZqTH1iLxNAKlUjicieuxmwPK5ID2hL8GxDEIOXaCdWIYPaoqj/+tajlWeux12+OL4cKNHZiVlI5wr/x8FGyPQje2wn0pSIRFI5mhbKyamMih/HMUBQptzwLmDfMA/YFXYxQWzyzRp3v2RzBXTVYqb8yRW64Z/cHpaJKNa2hN3Y4Jzb9SZmGZrjrxoESCdmt70CP4JhwN7Wa3AiGqTd+NqjIU07XYGnMRjlrN7fLuZ1AqcRoTv/K6Ndgf3Tct1ONufoGJJdv+k5m0RI0xCYhItiyhge/75ntJoYO3nMstiaa2Eg6mkePih313aybXujhP2vSPccHKPZVhwxTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(186009)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(110136005)(66899024)(40480700001)(70206006)(70586007)(54906003)(316002)(36860700001)(1076003)(41300700001)(44832011)(2906002)(426003)(336012)(66574015)(40460700003)(7416002)(7406005)(36756003)(83380400001)(7696005)(26005)(5660300002)(6666004)(8936002)(16526019)(8676002)(4326008)(2616005)(81166007)(82740400003)(356005)(478600001)(47076005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:54:47.6415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9cbbf1-a000-4710-5823-08dbc46c2024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resctrl task assignment for monitor or control group needs to be
done one at a time. For example:

  $mount -t resctrl resctrl /sys/fs/resctrl/
  $mkdir /sys/fs/resctrl/ctrl_grp1
  $echo 123 > /sys/fs/resctrl/ctrl_grp1/tasks
  $echo 456 > /sys/fs/resctrl/ctrl_grp1/tasks
  $echo 789 > /sys/fs/resctrl/ctrl_grp1/tasks

This is not user-friendly when dealing with hundreds of tasks.

Support multiple task assignment in one command with tasks ids separated
by commas. For example:
  $echo 123,456,789 > /sys/fs/resctrl/ctrl_grp1/tasks

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 Documentation/arch/x86/resctrl.rst     |  9 ++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 25 ++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index cb05d90111b4..8154e9975d1e 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -299,7 +299,14 @@ All groups contain the following files:
 "tasks":
 	Reading this file shows the list of all tasks that belong to
 	this group. Writing a task id to the file will add a task to the
-	group. If the group is a CTRL_MON group the task is removed from
+	group. Multiple tasks can be added by separating the task ids
+	with commas. Tasks will be assigned sequentially. Multiple
+	failures are not supported. A single failure encountered while
+	attempting to assign a task will cause the operation to abort and
+	already added tasks before the failure will remain in the group.
+	Failures will be logged to /sys/fs/resctrl/info/last_cmd_status.
+
+	If the group is a CTRL_MON group the task is removed from
 	whichever previous CTRL_MON group owned the task and also from
 	any MON group that owned the task. If the group is a MON group,
 	then the task must already belong to the CTRL_MON parent of this
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 725344048f85..f0d163950969 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -696,11 +696,10 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off)
 {
 	struct rdtgroup *rdtgrp;
+	char *pid_str;
 	int ret = 0;
 	pid_t pid;
 
-	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
-		return -EINVAL;
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
 		rdtgroup_kn_unlock(of->kn);
@@ -715,7 +714,27 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 		goto unlock;
 	}
 
-	ret = rdtgroup_move_task(pid, rdtgrp, of);
+	while (buf && buf[0] != '\0' && buf[0] != '\n') {
+		pid_str = strim(strsep(&buf, ","));
+
+		if (kstrtoint(pid_str, 0, &pid)) {
+			rdt_last_cmd_printf("Task list parsing error pid %s\n", pid_str);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (pid < 0) {
+			rdt_last_cmd_printf("Invalid pid %d\n", pid);
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = rdtgroup_move_task(pid, rdtgrp, of);
+		if (ret) {
+			rdt_last_cmd_printf("Error while processing task %d\n", pid);
+			break;
+		}
+	}
 
 unlock:
 	rdtgroup_kn_unlock(of->kn);
-- 
2.34.1

