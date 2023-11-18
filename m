Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A12A7F027C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjKRTdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjKRTdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B613130;
        Sat, 18 Nov 2023 11:33:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2iKbFreCfX4/y5IAzUxEzJ4lQJddxsmCsv9jK/kr7s8BRFtaS8rXqMihFvUBN9Dr9WQK3JLOAj7LsS2B8ydYmc30Vu7YgsU8Ksv5qmZW80OBuQdj55F2fV75LS+3YW5JWVeLXLbSUXebUu3Q8zK7OI12CiUYxlWlVngnraEQYW2xtXkqQlqukvilxew15CNmNXPpxqkJw36LUW5IJWhtM9Y0LijVvQ0rUrBk0ZTcBpDhO4jf8EIrqj05lOCkPW0CV0NjKL4wRbknWDtivjkOMBe7esGAyvdJaLkaCGityy8BjgAc7UxfVf12cXTLxRPr3Nw2rO0wW6SMbKXU47MEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLfogYxZA1xsuZQETSFyU7142XhjtoQVlHB6k2wQ2Fg=;
 b=jblMSGB1N2YCTo+ZBnnnHnTTXl9/8SpTSlqfNlV86b7UAmuRojeMIsxyAXTuHo7GFAsPwUqNo7niH9HkZsYyTlVdBgd8uBWHxgUz3XxfzEVhYRXxcO5MS7/RT8CZJu1KiTgp8ofQJrTAQ49gmAhO4cB0+zWDdLwJbmHb5L7kLaY956f28GXAsVAXutDEuEHdw8wlpUcIOuER9oIQPtE06hsDRKmPR01GmS1DtbbVXrS8h7u5uHL8oCOjX6Ru1Ne0/wIw35Aju/MhW0p5qt2Rtn98c1/8SjoTQkpZ1Ytlk+tsP/Js5QBZpUpweBdpndkkH5r1b/iux8cxEfvv4RdGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLfogYxZA1xsuZQETSFyU7142XhjtoQVlHB6k2wQ2Fg=;
 b=pmcrhlksi2ZhVyHZIYarsmae1HAjrrQJfM/JaHgv/Hp5p5E2c9ZIQjhOQOpOiSIDYxMIVqC+944GmzrFVLF5/zCy1YU1maCBL4HnXDOA3/v+Og28q+UL7IaTH9Qb74QoiqmtYueu0ZHey+L2NpDSoKy1zDCfqBU0G33Jo5NwjRE=
Received: from MN2PR10CA0035.namprd10.prod.outlook.com (2603:10b6:208:120::48)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 19:33:08 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::af) by MN2PR10CA0035.outlook.office365.com
 (2603:10b6:208:120::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:07 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:00 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 02/20] x86/mce: Define mce_setup() helpers for global and per-CPU fields
Date:   Sat, 18 Nov 2023 13:32:30 -0600
Message-ID: <20231118193248.1296798-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118193248.1296798-1-yazen.ghannam@amd.com>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|CO6PR12MB5427:EE_
X-MS-Office365-Filtering-Correlation-Id: d276c711-0b7f-4bdc-3b5f-08dbe86d30f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPSQKxVrJWN05VZW7fkiIB+gWdW76GE/XMwCaUQNNBAqy1KN+nIDghzMaLtOSdm0yJsrR5O0/KpUS7+TkYCpNN2Y4Aic1ei+EHdtyh7UfN8m0TTI1t77/BMXhYgdhOm/hP47taYC9g8XXa0VUnsFf2f1bgoCYjWS7QXJZFZXP2mTD5wJrxmSGLpF63z6x070FARFu2s8z8/eL+q5s3+lA22cdrEVJ84Hgeb5w2oyqu6S4TiZwjPCbs8aNfbZMO5jbHQ2NjpqOi2NuYlRK/Hkt0ZrMpt0ES3mvDokFg0FDnDDWDjuxyqi9NofDyaETUg1FLjHPgqYLpWBcHeGgIP2LuQwvj6IL8i55JtjzKeYB5eH4yJ/wKSEkBEa7G16URQxTXH1DEZO3jdCefxFwylIvoAxH8vZDTW8a1CZKEfylhSr/CnVoeaTc9eLU1T1lQW81UxqXY0t93xHDrdWCSc8GU16RvlRekuwnLE/oaEfLmsxTyC21vQYsH4fbJtc39GaTqKFLDMYepLw71e/Rq8LA7EIHOx4qoTW4tjde6o2W0oGLNvmKz2x5mIN03HTZaNCgE73ps4PJg+SUK3p7DfD3ZiTQQBU/SOE8VtKZfeBi35wugFFvn9Md6HrEbKnaTViinW7NqaHe8s+r1dXdIlIo9nVmbHjHL/ypjJTUeUMG52Zv8yELxa8T96aoLQnLrji8zZyNs3Aef2/CZlMGd1eUCgAntu3GTvIdnTVi3IxkzAsxJMwGFxoArR1vVECth13db9bFxs1o1wEr6zSjMiyMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(40470700004)(46966006)(36840700001)(2906002)(41300700001)(8936002)(8676002)(4326008)(40460700003)(316002)(5660300002)(44832011)(86362001)(36756003)(2616005)(1076003)(83380400001)(16526019)(336012)(426003)(26005)(82740400003)(6666004)(7696005)(81166007)(356005)(47076005)(36860700001)(40480700001)(478600001)(6916009)(54906003)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:07.3332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d276c711-0b7f-4bdc-3b5f-08dbe86d30f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally, MCA information for an error is gathered on the CPU that
reported the error. In this case, CPU-specific information from the
running CPU will be correct.

However, this will be incorrect if the MCA information is gathered while
running on a CPU that didn't report the error. One example is creating
an MCA record using mce_setup() for errors reported from ACPI.

Split mce_setup() so that there is a helper function to gather global,
i.e. not CPU-specific, information and another helper for CPU-specific
information.

Don't set the CPU number in either helper function. This will be set
appropriately for each call site of the helpers.

Leave mce_setup() defined as-is for the common case when running on the
reporting CPU.

Get MCG_CAP in the global helper even though the register is per-CPU.
This value is not already cached per-CPU like other values. And it does
not assist with any per-CPU decoding or handling.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 1642018dd6c9..7e86086aa19c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -115,20 +115,31 @@ static struct irq_work mce_irq_work;
  */
 BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 
+void mce_setup_global(struct mce *m)
+{
+	memset(m, 0, sizeof(struct mce));
+
+	m->cpuid	= cpuid_eax(1);
+	m->cpuvendor	= boot_cpu_data.x86_vendor;
+	m->mcgcap	= __rdmsr(MSR_IA32_MCG_CAP);
+	/* need the internal __ version to avoid deadlocks */
+	m->time		= __ktime_get_real_seconds();
+}
+
+void mce_setup_per_cpu(struct mce *m)
+{
+	m->apicid		= cpu_data(m->extcpu).topo.initial_apicid;
+	m->microcode		= cpu_data(m->extcpu).microcode;
+	m->ppin			= cpu_data(m->extcpu).ppin;
+	m->socketid		= cpu_data(m->extcpu).topo.pkg_id;
+}
+
 /* Do initial initialization of a struct mce */
 void mce_setup(struct mce *m)
 {
-	memset(m, 0, sizeof(struct mce));
+	mce_setup_global(m);
 	m->cpu = m->extcpu = smp_processor_id();
-	/* need the internal __ version to avoid deadlocks */
-	m->time = __ktime_get_real_seconds();
-	m->cpuvendor = boot_cpu_data.x86_vendor;
-	m->cpuid = cpuid_eax(1);
-	m->socketid = cpu_data(m->extcpu).topo.pkg_id;
-	m->apicid = cpu_data(m->extcpu).topo.initial_apicid;
-	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
-	m->ppin = cpu_data(m->extcpu).ppin;
-	m->microcode = boot_cpu_data.microcode;
+	mce_setup_per_cpu(m);
 }
 
 DEFINE_PER_CPU(struct mce, injectm);
-- 
2.34.1

