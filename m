Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0614C7DD37D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376324AbjJaQx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346788AbjJaQw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:52:26 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2111.outbound.protection.outlook.com [40.107.21.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD77310CA;
        Tue, 31 Oct 2023 09:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igVGpNMP9KC3ZB/STj5EiiRNGczo7Whr2IgaCUCZ0oM/9scvfcxSDTXjGrypZLTrTQ0VojN+ttavjm0vzDBavNIpMEJYbNcuHbDbDKZ29l0JWaa3VUXyup5w2n7df3geYdbFyAVFGYCtAgJqq7un4EHpxTdmQPcW7BjgvP8Bmi7Ko9brNDjcGEwahkf1adKoHoa2Mt2s8vwPGY+LbtxkxlRHUW3Ii65cnlCLwz98tydShBsVQESx4kvc9BTZjCq5pjalCTZ6/RGUjCcs14yHuV7Kypw3W544Lepzg5PbRsUt9xAgpN2gZs0+99+Lz3wvpBiMkm2GqFLLTMwYaVzw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JHK0hircicLZe+BQeKQFtK0FkTAy+hezrKCg4iJ0KA=;
 b=i+6Sc8cFzWZPTW3EraAqK2Fux65tlwY8slrzN0hSMUwd21AFeybEFHxZ/FyOll1Y/thOY5G8qJqPSTP2nkKW5II6di08tKcPLvAE68uthFrkwuLI/dJskLndECR9WtCYbEjMcfHtS69ygN7LRnVTSpOXwLklXVLPlFvPPo8oQbKwKwhew7nGeQoS5Il4wEkMGkFzRGjWanYkbhN+D+8NQ7TO9lWLo6eLP/c570w0JhRdKCpfi2tjPGexoXco1Ru4tJ+vY738Zy1ICedcAT9t4TKHCBBRHbtGVgZ6mQkLjhFhxHaafTmESxIJui0Aw6RXSoYRFDt616Aun6HSeTZrKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JHK0hircicLZe+BQeKQFtK0FkTAy+hezrKCg4iJ0KA=;
 b=TjJYOXJFwgCnL0git/ZPtRptHmoYL6yY+Eg0NFVP5hoDCzicbJTfzoXa8sJEl4aWhBZz7CrxQrtqW2fopaBX43feMC7T0Y+XzgMDBd/eSH+gAG7f/NDgnvVeH2dzmzDx84RCSlarIFtckFfCXNY3CTpfpl9baDyH8JzxFSK+mck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32) by DB4PR03MB8706.eurprd03.prod.outlook.com
 (2603:10a6:10:382::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 16:49:53 +0000
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa]) by VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa%4]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 16:49:53 +0000
From:   Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Aleksandar Rikalo <arikalo@gmail.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v3 09/11] MIPS: pm-cps: Use per-CPU variables as per-CPU, not per-core
Date:   Tue, 31 Oct 2023 17:49:25 +0100
Message-Id: <20231031164927.371663-10-aleksandar.rikalo@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031164927.371663-1-aleksandar.rikalo@syrmia.com>
References: <20231031164927.371663-1-aleksandar.rikalo@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0065.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::18) To VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3486:EE_|DB4PR03MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 25649b2e-5b85-4b01-ea3f-08dbda3167a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WgMLgo+wMGAjnHY9SRI0NMnmHf2ylMr0POALF5eaB8i2UZOPz5auzfm25EZgsR9Y97j08EuKpSJYx27zZVS2sQ457c4if7McTRddAQDLYWNQO1F/ecWuhOAXTydybeDhgaiVQxiZv3l8FG7sMfwpPriXF0LWmLNEfhzfC2wvZh/BbC7VJFRvXXI17LCssrMEjq8nKzwimtqfDHzkTQcCBhPxQg3xT/jOIuT7cTG8UQu9uHo6ursTLQPZwwbx6+NZpZxBKhC8MaMyD04SBGa2yM9CAMA+GOyAI4rjKygMf3/V4M18OYZiDRLhojDIOXvT8D3d2f9NFjnmVj6v6J5lno2Tl9aF1Y4/IzGvKv1vsdUaoSaYv/lYy84VLvz0O5CFPiZ507aTLOC4GxrbA7bJywV2tDnsmrjvHb3HO8ymGFav41LxkGNYd6tJqm50TEx4c3WStl2gOpV3+hBXQWVFlBa8/+w5X7v1A6vQi7d55P8Gk0A6BZtal30TAmZzCwQnYxVX5X/E5UTSU6xZu3EPblRMBoJiQ0Av8PkjlA/qglC4+RvlZ+nRicOLBJ55Jja3608g/yidt/A3hhhL6DwD/kxlUYTUe1NGaJ+KoYHRs4UDkeH+PPHk+AXWf+EjS15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0302MB3486.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39830400003)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6512007)(2616005)(1076003)(26005)(6666004)(478600001)(4326008)(6506007)(83380400001)(44832011)(6486002)(7416002)(2906002)(41300700001)(66556008)(66946007)(66476007)(8936002)(8676002)(52116002)(6916009)(5660300002)(54906003)(316002)(36756003)(38100700002)(86362001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/hrsxKKvaE4y25wmtisPEuOBfW8GHfo6t9ueLKV5G4qOgyHC2p7yKPfEz6tQ?=
 =?us-ascii?Q?AHF1s32dmoLfp/bvcd0aQbyniU9tIQt2PpOdHnN0acBfI5SJhC8fuhLC5rFs?=
 =?us-ascii?Q?wzvlk5/dYUKstA6a5U4lq4p0YylJcTqrMae6VCbulsHORd4dNFE/P5JSzHrv?=
 =?us-ascii?Q?nUxaMBHfLKgYg4k/VMMTmKBUVp3swErNwWWcgdlE+MgN52NHEmcD3NH7XXV+?=
 =?us-ascii?Q?SYrUlUwQoL7PPuLV2C8PphG/ESdDyhdOVJSAC4Al3MTsRt9igwdH1KHTFTm2?=
 =?us-ascii?Q?jqoQPvasz5Qba+NtJbNNfQrtTptSc7Vq8Px6jJ9Y7eUTVtHXP2LC90Cl4cyB?=
 =?us-ascii?Q?Gr0+7Jr1QEhi+cgtPvGFDH/zlpjn6hHtaHa81de0g08FxgqNjXU+knpiCHut?=
 =?us-ascii?Q?rX61JJGi1caCgWd4/EemTd7cI/BwwW8OpIfVNrb/33W4vleEQ9Q4i1augmf+?=
 =?us-ascii?Q?gUrdPJKm53ZwE+ce1IKavXCSUPe84VD3kg7wILK6Tu2MH8VXCds3MeeJ1wmE?=
 =?us-ascii?Q?OWXR2yAGsPrQmX0GBvHytf7xq/in/Kgp0JLoQ2AlW39ZqgdB+GCv5EMq3AJB?=
 =?us-ascii?Q?lqYxBM8J1dUnTYxz+AeKwZCcyd65dAi15s0Nen1PSFQBOsd22rcPAVNIvz6P?=
 =?us-ascii?Q?TfGzeONMu0i4gsOY9+wMho5XP70jzURg1dtTNkb+5X2pIPxYraTuBBhkI4Te?=
 =?us-ascii?Q?8tt2JJBZ97TIQGhHH2tM1RD+K8o9Y2EByGXPz8J8E+2K10jCsUIRARYa2rG9?=
 =?us-ascii?Q?ocZcya0umj1Ln1dlLENlucie91BZYfPoOzAuUnnJjEJCULnJxL7ngTH3eM7V?=
 =?us-ascii?Q?vtHi90tnyiblyj12zppBrg6r7bi6Zl1NF7AA9/0hHtupETdzXhhLI4jHZbK6?=
 =?us-ascii?Q?RG+Q2nn2E/GtIBOwU+Jd2K2+UjuG7mGZO9dq9P9seCb9B5JkUlybrYWJ4aJ5?=
 =?us-ascii?Q?HrVpVzV9T1ojITHL94meljs/cgSDCqjC5AJn8iaNvtSjcuImN0cl7fmOot0m?=
 =?us-ascii?Q?aAP05c9yShsf6JFS+y97rn0Ap63WHEro/KDmfSWijx0xNZ3DmV2AFRvJqx1T?=
 =?us-ascii?Q?s2EQDHN3k2wyJKTjpVqRs9+fMMiRIsrYbxUWa/O81aWX8WysdGa5xwEiAWtI?=
 =?us-ascii?Q?Dl6el0zqMBNpAyqpYBvd3wlvA4biImV6zaeKUhwQKxH+bF1O1O49jimMFGY1?=
 =?us-ascii?Q?6unnBeZS8ysRlnTqkINYeX1kvUh0B9hRaqdLCrQPRQ2/oCXhDI/N+8m3qj9c?=
 =?us-ascii?Q?R1aS9/PM7z5i7DqsXhVewAqNJX1BwkWKdr3EIx978ID3MfMuX1ig+oi9Kwaq?=
 =?us-ascii?Q?mVR8NAvNU3i8HouGlqdDOqijYh1asHEPuGeO19GZJSxZZLHheX7TPrSt91r5?=
 =?us-ascii?Q?4an/aT3DkuGkYDBKML/b1cQhggIWkYb2hnXzkPNX+vSQWNVMCF8zUUka1C8y?=
 =?us-ascii?Q?mZ9WmQ/EsQCZ7Jds4EyoEPVEaLCf127tX/t+iK0vrX/XhJCQTpENM+eYegHk?=
 =?us-ascii?Q?H40qRRr+16HhQF/BU0cBsK/pfheKdz5DmTAVl7JZUXvtYbk51QSEwgwyCrNK?=
 =?us-ascii?Q?LaPC7gugfJT4ROJr6WMS6kGFcicPKKL3LBW3R/lMNJVQZVuL18gkB6ITLfB/?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25649b2e-5b85-4b01-ea3f-08dbda3167a0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0302MB3486.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:49:53.1212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sd6aAnnu+KWbsCkGWnlGaycJqgAboZm+3YBrsQcuss7Ttdxny3jEDGz+EBBpO4H9t4XyzG+U6fU+7kiHAejpvXvKvo/bfKW5lLPLnNzEFZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB8706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paulburton@kernel.org>

The pm-cps code has up until now used per-CPU variables indexed by core,
rather than CPU number, in order to share data amongst sibling CPUs (ie.
VPs/threads in a core). This works fine for single cluster systems, but
with multi-cluster systems a core number is no longer unique in the
system, leading to sharing between CPUs that are not actually siblings.

Avoid this issue by using per-CPU variables as they are more generally
used - ie. access them using CPU numbers rather than core numbers.
Sharing between siblings is then accomplished by:
 - Assigning the same pointer to entries for each sibling CPU for the
   nc_asm_enter & ready_count variables, which allow this by virtue of
   being per-CPU pointers.

 - Indexing by the first CPU set in a CPUs cpu_sibling_map in the case
   of pm_barrier, for which we can't use the previous approach because
   the per-CPU variable is not a pointer.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
---
 arch/mips/kernel/pm-cps.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 9bf60d7d44d3..a7bcf2b814c8 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -56,10 +56,7 @@ static DEFINE_PER_CPU_ALIGNED(u32*, ready_count);
 /* Indicates online CPUs coupled with the current CPU */
 static DEFINE_PER_CPU_ALIGNED(cpumask_t, online_coupled);
 
-/*
- * Used to synchronize entry to deep idle states. Actually per-core rather
- * than per-CPU.
- */
+/* Used to synchronize entry to deep idle states */
 static DEFINE_PER_CPU_ALIGNED(atomic_t, pm_barrier);
 
 /* Saved CPU state across the CPS_PM_POWER_GATED state */
@@ -118,9 +115,10 @@ int cps_pm_enter_state(enum cps_pm_state state)
 	cps_nc_entry_fn entry;
 	struct core_boot_config *core_cfg;
 	struct vpe_boot_config *vpe_cfg;
+	atomic_t *barrier;
 
 	/* Check that there is an entry function for this state */
-	entry = per_cpu(nc_asm_enter, core)[state];
+	entry = per_cpu(nc_asm_enter, cpu)[state];
 	if (!entry)
 		return -EINVAL;
 
@@ -156,7 +154,7 @@ int cps_pm_enter_state(enum cps_pm_state state)
 	smp_mb__after_atomic();
 
 	/* Create a non-coherent mapping of the core ready_count */
-	core_ready_count = per_cpu(ready_count, core);
+	core_ready_count = per_cpu(ready_count, cpu);
 	nc_addr = kmap_noncoherent(virt_to_page(core_ready_count),
 				   (unsigned long)core_ready_count);
 	nc_addr += ((unsigned long)core_ready_count & ~PAGE_MASK);
@@ -164,7 +162,8 @@ int cps_pm_enter_state(enum cps_pm_state state)
 
 	/* Ensure ready_count is zero-initialised before the assembly runs */
 	WRITE_ONCE(*nc_core_ready_count, 0);
-	coupled_barrier(&per_cpu(pm_barrier, core), online);
+	barrier = &per_cpu(pm_barrier, cpumask_first(&cpu_sibling_map[cpu]));
+	coupled_barrier(barrier, online);
 
 	/* Run the generated entry code */
 	left = entry(online, nc_core_ready_count);
@@ -635,12 +634,14 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 
 static int cps_pm_online_cpu(unsigned int cpu)
 {
-	enum cps_pm_state state;
-	unsigned core = cpu_core(&cpu_data[cpu]);
+	unsigned int sibling, core;
 	void *entry_fn, *core_rc;
+	enum cps_pm_state state;
+
+	core = cpu_core(&cpu_data[cpu]);
 
 	for (state = CPS_PM_NC_WAIT; state < CPS_PM_STATE_COUNT; state++) {
-		if (per_cpu(nc_asm_enter, core)[state])
+		if (per_cpu(nc_asm_enter, cpu)[state])
 			continue;
 		if (!test_bit(state, state_support))
 			continue;
@@ -652,16 +653,19 @@ static int cps_pm_online_cpu(unsigned int cpu)
 			clear_bit(state, state_support);
 		}
 
-		per_cpu(nc_asm_enter, core)[state] = entry_fn;
+		for_each_cpu(sibling, &cpu_sibling_map[cpu])
+			per_cpu(nc_asm_enter, sibling)[state] = entry_fn;
 	}
 
-	if (!per_cpu(ready_count, core)) {
+	if (!per_cpu(ready_count, cpu)) {
 		core_rc = kmalloc(sizeof(u32), GFP_KERNEL);
 		if (!core_rc) {
 			pr_err("Failed allocate core %u ready_count\n", core);
 			return -ENOMEM;
 		}
-		per_cpu(ready_count, core) = core_rc;
+
+		for_each_cpu(sibling, &cpu_sibling_map[cpu])
+			per_cpu(ready_count, sibling) = core_rc;
 	}
 
 	return 0;
-- 
2.25.1

