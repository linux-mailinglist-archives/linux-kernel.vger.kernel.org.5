Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDCC780B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376713AbjHRLpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376697AbjHRLpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:45:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B8B2723;
        Fri, 18 Aug 2023 04:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ke4aNMUN4zvgiGJ0og23EcEg8tlUfvI24SiDaZkgPDGFztxDEMzId/5RkMANGxRhw4WtyajH8majPFJ97WP+QYvU2BE3FTFquVoJilyanunE4/QwO2nZoSHSgph1xD8C+oH5DxSCjqb15WHHuHTu12rMOeVkdcSExzLMP2UPnesAlEPh7/eGRL6QdyCACW52GCssm0ZL08bdbjBmujsggGPr3k9bMVACJHGPGLXxzd2RU89mCJWzPb+zZ+zTTXEUH3RjqWiyPi2YXVoaPxr/5tHkqQfY3VRRvFpwKImidXjQRvkBuRavfk2wy0GSMgzY094/3OiMt/JYThj1l4uLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbCkFvZmQVjvEPMj0X65iiUoV9b7/t4uD64UZ1z7Cy4=;
 b=TiN6n5JA8EKt+oDD+udhnvpGkbW5pCg06SjbFmiCjxyczqR9Hz0oroOpOSGbGKbRxzUQBK+o7dbAwq31+X67jd3z2rWdUGBsSIRw0eEvc4yjnjq0M3c2VacZycAfPSa3l8J/4Lb7UfgE5VOy/peOWe3DJ89Z5Jj2v8aVB7J0lY68xD7Cs95oN368538NWd5pNqWQeKC5S0HEpVotYmgcIbwtTvRwuYf09Hjs2Ho5//aKOLW4YGLK9zcYBnfzIykEZGxE3kG25lnuFqEBg6/o1qGV+uBechv5spIiwmYOaQ3jtXfHAUmbw+6InvVsw8PrsFz5eM+eduLwzEuAfNVQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbCkFvZmQVjvEPMj0X65iiUoV9b7/t4uD64UZ1z7Cy4=;
 b=NJiE/lT+OuUHRqzbbRyqfa5u7F5o17J8+vOYHPG338bmirUpdKerKFA+sEb6C5i0q3W0icajQ1l3jLyjnf2xIqjxFN+iXFKFPvfcDC/5/F+l+Cs3F5v0XQhJdWy6m01xJgvBviQZNG4x9rrWSkc/gN1JODWkwtezS//kGMY2Wyk=
Received: from MW4PR04CA0095.namprd04.prod.outlook.com (2603:10b6:303:83::10)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:45:39 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::a) by MW4PR04CA0095.outlook.office365.com
 (2603:10b6:303:83::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.19 via Frontend
 Transport; Fri, 18 Aug 2023 11:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 11:45:38 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 06:45:37 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Meng Li <li.meng@amd.com>, "Wyes Karny" <wyes.karny@amd.com>
Subject: [PATCH v1 2/2] amd-pstate-ut: Fix kernel panic due to loading amd-pstate-ut driver
Date:   Fri, 18 Aug 2023 11:44:52 +0000
Message-ID: <20230818114452.66780-3-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818114452.66780-1-swapnil.sapkal@amd.com>
References: <20230818114452.66780-1-swapnil.sapkal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce0ecb6-8c7e-4ebf-2c90-08db9fe0a4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBl9T6dHMjqxDNvO78kNDj+Vc5x69IjB3pEQKSooh57s6RffKZ7GMWlgAcMLNH3B4LBD1SqfOSeL2DmQsQKWCESJCdsye2gfjNHbNan6OACMrtIfr6T9RY0DRo+eVnZt/hJkCkHZr0nFa/vAhdJZpKNBzYHIIy/XZftyX4T8NqQzeEm96JIZyWbXroe0j5Z3oxPsjiPxvJMP8H2x/UGFgQv5DhYWJ0AqkHYV2G0I3q2mVvvza+BsnH21hvEujcCBC66Y4+EiNtxuaSATU0nYDBtMczf4/O+o5taWdz0YcBlKvm5BmqdhIxSbumRp80Ct9wrQa9GK5fiysb4E5uFrUVFmYa+ALeHnDmmeXwHT10viECRKFN1QgxVhQxmJUPuL+QQ7Fqzrsbf9x8JEkvTUMp9wRLBaCPJT795vCfgQHyj+iKAZFCpvyVGII5BsnbkzZU2uXAIlDg0nxw+8reaGTrxGiV3lxgTqoxM8qAgB0GTN3YoqrbEfGcoEgnoSZp1S4V0yytjtu2h52VjhKfW4KDYv3AGJIX8FxoToaBwB9n1lGUP94sNRITdCQW9Z6slZol+Ko2OfnIQirqCK1SKm4uuK9CQ0G8ONSWiVH+KZkReRvit2F5SQ21cPAOMZmCzuU7/eOE8xwf6iCrkglRSplsfg1DlSzvRZDpDDRTWoxxLPAeApVYH+Hzb9uW2NF6YOP5rRwNO5x3MkRg7eiksTCrIpk2KC464YUnHMWHD07ZxBTyNrs8SDLCTV6aubsQ5i1+8LPCLxZ1sKzSS4Y0dXMZ2A2UpHXLVEjW94U9vNTSo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(356005)(40460700003)(316002)(2616005)(36860700001)(426003)(1076003)(336012)(16526019)(6666004)(26005)(7696005)(47076005)(44832011)(83380400001)(4326008)(5660300002)(8936002)(8676002)(2906002)(478600001)(41300700001)(70586007)(110136005)(54906003)(70206006)(82740400003)(36756003)(40480700001)(86362001)(81166007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:45:38.8222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce0ecb6-8c7e-4ebf-2c90-08db9fe0a4d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After loading amd-pstate-ut driver, amd_pstate_ut_check_perf()
and amd_pstate_ut_check_freq() functions uses cpufreq_cpu_get()
to get the policy of the cpu and mark it as busy. In this
functions cpufreq_cpu_put() should be used to release the
policy. As cpufreq_cpu_put() is not used to release the policy,
any other entity trying to access the policy is blocked indefinitely.
One such scenario is when amd_pstate mode is changed leading to following
splat:

[ 1332.103727] INFO: task bash:2929 blocked for more than 120 seconds.
[ 1332.110001]       Not tainted 6.5.0-rc2-amd-pstate-ut #5
[ 1332.115315] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1332.123140] task:bash            state:D stack:0     pid:2929  ppid:2873   flags:0x00004006
[ 1332.123143] Call Trace:
[ 1332.123145]  <TASK>
[ 1332.123148]  __schedule+0x3c1/0x16a0
[ 1332.123154]  ? _raw_read_lock_irqsave+0x2d/0x70
[ 1332.123157]  schedule+0x6f/0x110
[ 1332.123160]  schedule_timeout+0x14f/0x160
[ 1332.123162]  ? preempt_count_add+0x86/0xd0
[ 1332.123165]  __wait_for_common+0x92/0x190
[ 1332.123168]  ? __pfx_schedule_timeout+0x10/0x10
[ 1332.123170]  wait_for_completion+0x28/0x30
[ 1332.123173]  cpufreq_policy_put_kobj+0x4d/0x90
[ 1332.123177]  cpufreq_policy_free+0x157/0x1d0
[ 1332.123178]  ? preempt_count_add+0x58/0xd0
[ 1332.123180]  cpufreq_remove_dev+0xb6/0x100
[ 1332.123182]  subsys_interface_unregister+0x114/0x120
[ 1332.123185]  ? preempt_count_add+0x58/0xd0
[ 1332.123187]  ? __pfx_amd_pstate_change_driver_mode+0x10/0x10
[ 1332.123190]  cpufreq_unregister_driver+0x3b/0xd0
[ 1332.123192]  amd_pstate_change_driver_mode+0x1e/0x50
[ 1332.123194]  store_status+0xe9/0x180
[ 1332.123197]  dev_attr_store+0x1b/0x30
[ 1332.123199]  sysfs_kf_write+0x42/0x50
[ 1332.123202]  kernfs_fop_write_iter+0x143/0x1d0
[ 1332.123204]  vfs_write+0x2df/0x400
[ 1332.123208]  ksys_write+0x6b/0xf0
[ 1332.123210]  __x64_sys_write+0x1d/0x30
[ 1332.123213]  do_syscall_64+0x60/0x90
[ 1332.123216]  ? fpregs_assert_state_consistent+0x2e/0x50
[ 1332.123219]  ? exit_to_user_mode_prepare+0x49/0x1a0
[ 1332.123223]  ? irqentry_exit_to_user_mode+0xd/0x20
[ 1332.123225]  ? irqentry_exit+0x3f/0x50
[ 1332.123226]  ? exc_page_fault+0x8e/0x190
[ 1332.123228]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 1332.123232] RIP: 0033:0x7fa74c514a37
[ 1332.123234] RSP: 002b:00007ffe31dd0788 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 1332.123238] RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007fa74c514a37
[ 1332.123239] RDX: 0000000000000008 RSI: 000055e27c447aa0 RDI: 0000000000000001
[ 1332.123241] RBP: 000055e27c447aa0 R08: 00007fa74c5d1460 R09: 000000007fffffff
[ 1332.123242] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
[ 1332.123244] R13: 00007fa74c61a780 R14: 00007fa74c616600 R15: 00007fa74c615a00
[ 1332.123247]  </TASK>

Fixed this by calling cpufreq_cpu_put() wherever necessary.

Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver") 
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Meng Li <li.meng@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Suggested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index cf07ee77d3cc..502d494499ae 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -140,7 +140,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 			if (ret) {
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 				pr_err("%s cppc_get_perf_caps ret=%d error!\n", __func__, ret);
-				return;
+				goto skip_test;
 			}
 
 			nominal_perf = cppc_perf.nominal_perf;
@@ -151,7 +151,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 			if (ret) {
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 				pr_err("%s read CPPC_CAP1 ret=%d error!\n", __func__, ret);
-				return;
+				goto skip_test;
 			}
 
 			nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
@@ -169,7 +169,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 				nominal_perf, cpudata->nominal_perf,
 				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
 				lowest_perf, cpudata->lowest_perf);
-			return;
+			goto skip_test;
 		}
 
 		if (!((highest_perf >= nominal_perf) &&
@@ -180,11 +180,15 @@ static void amd_pstate_ut_check_perf(u32 index)
 			pr_err("%s cpu%d highest=%d >= nominal=%d > lowest_nonlinear=%d > lowest=%d > 0, the formula is incorrect!\n",
 				__func__, cpu, highest_perf, nominal_perf,
 				lowest_nonlinear_perf, lowest_perf);
-			return;
+			goto skip_test;
 		}
+		cpufreq_cpu_put(policy);
 	}
 
 	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
+	return;
+skip_test:
+	cpufreq_cpu_put(policy);
 }
 
 /*
@@ -212,14 +216,14 @@ static void amd_pstate_ut_check_freq(u32 index)
 			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
 				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
 				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
-			return;
+			goto skip_test;
 		}
 
 		if (cpudata->min_freq != policy->min) {
 			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d cpudata_min_freq=%d policy_min=%d, they should be equal!\n",
 				__func__, cpu, cpudata->min_freq, policy->min);
-			return;
+			goto skip_test;
 		}
 
 		if (cpudata->boost_supported) {
@@ -231,16 +235,20 @@ static void amd_pstate_ut_check_freq(u32 index)
 				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
 					__func__, cpu, policy->max, cpudata->max_freq,
 					cpudata->nominal_freq);
-				return;
+				goto skip_test;
 			}
 		} else {
 			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d must support boost!\n", __func__, cpu);
-			return;
+			goto skip_test;
 		}
+		cpufreq_cpu_put(policy);
 	}
 
 	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
+	return;
+skip_test:
+	cpufreq_cpu_put(policy);
 }
 
 static int __init amd_pstate_ut_init(void)
-- 
2.34.1

