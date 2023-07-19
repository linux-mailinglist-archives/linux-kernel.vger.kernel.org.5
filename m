Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A24758E34
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjGSG6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGSG6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:58:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAC410A;
        Tue, 18 Jul 2023 23:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TixDvjc/li8L9p+h1L8MnqvFy1Dcsxtwy+9zH9OQN3MlZyFsVM4utyeQ3DysZ+3VV4oWiTVi+xcTxr71AXm7LcdA0/HKUYG9gob83stkffdWuVf59ZmeE6g1kTpXX12ye9n0Ejhk1R9tsmTttDvBosjSZRrzUgUHTV2e3OlTuNsXgdn5bG3VBxPuEvau3U5ScvkATPEKC4BSOMpp4u1dxfqba89qAIgF1pqaMt3L2uiQnGVfqI5XP9FVwOLKknsQ0PDRfZGgKUgjvtd5FtojFzlitWwhv45Y1jAyM/bKAtX+SCH8bti4UC5di/exfXH39VZ03dTN0EXXiJY+294spA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weOXGP6LbgDsIogCjgxThSVU9bQcyzHQ0DMmYFblQO0=;
 b=jCSIhXzqEx8PE7RbqjPtK6g+FSlUVHyETNXbRq4SKlqSIUuauq3DXTM0dES9/hgxRPkhtMmZ3Bd79nFuOo0IOOzJLtaz49PbiZCeNoJf4hbCnS2u5dhL/Mq1GSUDkEbWaGxrPzYYK7n244bro2atUBmdXQzjjVMziZV5cuGONMkM0Qf0iAPr//Ywf3pvzK56+/CQGL57vrKHPzxDKcEVF9MMrtAK7i+RfQHk5frk1CR1qn9DBndrGEtRvaTDHSEahgtktq6AOe6WsSV6mo+n8ksvotvOh4d8KSkeMDGTzM9i398VbDIuziHsNe49wddUdSZ94ASZjw9Mc/+R/exEag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weOXGP6LbgDsIogCjgxThSVU9bQcyzHQ0DMmYFblQO0=;
 b=0NvddeaqV/ikwRdRuFeIJSxiKHRUx0mrr9FLg8xvB+/ztkEX7YbDGnz45FROumd0ua9xF3xRM/UDYHdQsfGtajq2fb3M6A2ecN1LbeBZkL0OGA1KO1aCi4yguntVLixWF/SQ3iZUEkjeYDjm7722QH7dOcXbOnUEQp9Y+eU6/Is=
Received: from BN9PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:fb::15)
 by PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 06:57:56 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::62) by BN9PR03CA0040.outlook.office365.com
 (2603:10b6:408:fb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 06:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 06:57:55 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 01:57:34 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 4/6] perf/x86/amd/uncore: Add group exclusivity
Date:   Wed, 19 Jul 2023 12:25:39 +0530
Message-ID: <92465f174413553410aaa876223817b156808800.1689748843.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689748843.git.sandipan.das@amd.com>
References: <cover.1689748843.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|PH0PR12MB5433:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d6f756-a901-416f-58e4-08db88257ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDg8xIlRxe+wzbLHOvVSxiekiA3qN+JP9EAk0DKC9hL6JAQM74InQxspJh00UgfFmZkWONbupzDK5MGx4C7NlDZNiKXve28RJe+CUWNN6ceds0XtarE7peAW9vwjuLktiM5AOSMl5HxXmfd8m6s9hMNHMuZBB0wxI9hneVcxY1jIBm68yW17zFs/MCYpsXkNKq+WILma1bUSKMqnUmVtwQVY57dnz448oHLMvOLT0rLI7ZJ9Mj/s8HZgnJEl43IHB8hI5Xx08JxaEzDg6V0NMwdFNt109O4R3h6b2Il++pwgdO79q5GJ+I0nHh2yU1JZGUpj8pBm8WemrzrBth7NW/LEg7Nc46YMwCuUTgP7BUOVjaG0hHbkWHDHU2CH+bM7sFagAuMLhQrycVamMiT0gtDfJyhOu29UNZGxei9YKV/mrHgxZ0Ogx3IZ96Fe5dEQ8HUzS1XtVDipxZkW3IWfmA08dDMpQ7kv9CT7v8PpnUs8Yf+5iJhOoiRZThAwa0e5E8friXahvDVUH991uAuNvq543sEeciSOguOxH8rAuWrSSdi7V3ZLabOH0lkZ4LXYDK5udNOvxz5miK72635UxSpt36/LNyIn6AfHMqOFjnHG+9rjPJgc1RABkNkeZ9OOA8VktHGRe8sguS/r3pu3N9k2awwfwYgf4wOXIuE8ugNtIX4pBYmbn8XNQJAWgV2bJ1A9QlXCJRL7zp53LJemxBXymVEhSVDInZdangP9tJo6O9I49tB4hLZ7q3M3YOPzHpJdQE9W0jefWhxkKk6EDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(44832011)(478600001)(110136005)(54906003)(36860700001)(2616005)(83380400001)(426003)(47076005)(40460700003)(86362001)(36756003)(40480700001)(2906002)(70586007)(186003)(336012)(16526019)(26005)(356005)(82740400003)(81166007)(4326008)(70206006)(316002)(41300700001)(5660300002)(7416002)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 06:57:55.9475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d6f756-a901-416f-58e4-08db88257ae3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, it may be necessary to restrict opening PMU events to a
subset of CPUs. Uncore PMUs which require this restriction can use the
new group attribute in struct amd_uncore to set a valid uncore ID during
initialization. In the starting phase of hotplug, the per-CPU context
will be marked as unused if the ID in group does not match the uncore ID
for the CPU that is being onlined.

E.g. the Zen 4 memory controller (UMC) PMUs are specific to each active
memory channel and the MSR address space for the PERF_CTL and PERF_CTR
registers is reused on each socket. Thus, PMU events corresponding to a
memory controller should only be opened on CPUs belonging to the socket
associated with that memory controller.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index f17df6574ba5..6653e8e164bd 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -50,6 +50,7 @@ struct amd_uncore {
 	int num_counters;
 	int rdpmc_base;
 	u32 msr_base;
+	int group;
 	cpumask_t active_mask;
 	struct pmu pmu;
 	struct amd_uncore_ctx * __percpu *ctx;
@@ -423,6 +424,17 @@ static int amd_uncore_cpu_starting(unsigned int cpu)
 		uncore = &uncores[i];
 		ctx = *per_cpu_ptr(uncore->ctx, cpu);
 		ctx->id = uncore->id(cpu);
+
+		/*
+		 * Reclaim the context if events can only be opened by CPUs
+		 * within the same group
+		 */
+		if (uncore->group >= 0 && ctx->id != uncore->group) {
+			hlist_add_head(&ctx->node, &uncore_unused_list);
+			*per_cpu_ptr(uncore->ctx, cpu) = NULL;
+			continue;
+		}
+
 		ctx = amd_uncore_find_online_sibling(ctx, uncore);
 		*per_cpu_ptr(uncore->ctx, cpu) = ctx;
 	}
@@ -453,7 +465,7 @@ static int amd_uncore_cpu_online(unsigned int cpu)
 	for (i = 0; i < num_uncores; i++) {
 		uncore = &uncores[i];
 		ctx = *per_cpu_ptr(uncore->ctx, cpu);
-		if (cpu == ctx->cpu)
+		if (ctx && cpu == ctx->cpu)
 			cpumask_set_cpu(cpu, &uncore->active_mask);
 	}
 
@@ -469,12 +481,14 @@ static int amd_uncore_cpu_down_prepare(unsigned int cpu)
 	for (i = 0; i < num_uncores; i++) {
 		uncore = &uncores[i];
 		this = *per_cpu_ptr(uncore->ctx, cpu);
+		if (!this)
+			continue;
 
 		/* this cpu is going down, migrate to a shared sibling if possible */
 		for_each_online_cpu(j) {
 			that = *per_cpu_ptr(uncore->ctx, j);
 
-			if (cpu == j)
+			if (!that || cpu == j)
 				continue;
 
 			if (this == that) {
@@ -499,6 +513,9 @@ static int amd_uncore_cpu_dead(unsigned int cpu)
 	for (i = 0; i < num_uncores; i++) {
 		uncore = &uncores[i];
 		ctx = *per_cpu_ptr(uncore->ctx, cpu);
+		if (!ctx)
+			continue;
+
 		if (cpu == ctx->cpu)
 			cpumask_clear_cpu(cpu, &uncore->active_mask);
 
@@ -584,6 +601,7 @@ static int amd_uncore_df_init(void)
 	uncore->msr_base = MSR_F15H_NB_PERF_CTL;
 	uncore->rdpmc_base = RDPMC_BASE_NB;
 	uncore->id = amd_uncore_df_id;
+	uncore->group = -1;
 
 	if (pmu_version >= 2) {
 		*df_attr++ = &format_attr_event14v2.attr;
@@ -693,6 +711,7 @@ static int amd_uncore_l3_init(void)
 	uncore->msr_base = MSR_F16H_L2I_PERF_CTL;
 	uncore->rdpmc_base = RDPMC_BASE_LLC;
 	uncore->id = amd_uncore_l3_id;
+	uncore->group = -1;
 
 	if (boot_cpu_data.x86 >= 0x17) {
 		*l3_attr++ = &format_attr_event8.attr;
-- 
2.34.1

