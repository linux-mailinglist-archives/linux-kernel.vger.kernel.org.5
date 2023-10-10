Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859237BF582
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442718AbjJJITe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379447AbjJJITc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:19:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B292AB8;
        Tue, 10 Oct 2023 01:19:30 -0700 (PDT)
Date:   Tue, 10 Oct 2023 08:19:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696925969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s5TK6Nd796vNEe4gx/egyQpR7vU+hLD9A6+fXoPVnsw=;
        b=DvhcLL+j7c8AAhxijxIpCE8CpLw3KMdl1I+KORu/F5nUXtLfihpb51MVeULf3sJ3IibvWC
        SKRKcGFJz9f/CbLA8oHKbE+bjHyfXbr5Zvnth7ZB2FmD2WN5puZW+Ur5moknaeDAHnQS2H
        35l+Uz6zYusSvjtI5xpSpZWzvuBA09PAJ5D7sFwHJF8QiUnKQmfRTENf97wFbsvBGAfRM+
        ugH0nRZ1oz2zNqeSIYlJ7OwzUl70vqjYBgD0efmyc2LMQ99y0/k78nooXs121VxYZBYP2G
        81jpvpfx+/D4EdNVrnOCkBe4flcTe+IV8hnfVLGXtehIo+kibBBr5tqnsP/KIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696925969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s5TK6Nd796vNEe4gx/egyQpR7vU+hLD9A6+fXoPVnsw=;
        b=RKbfalcRmQAFWS3WvBHqsrQW95xDSjW78afp4TwCN00vn6QOJBWgt+ZHj6lnYolIiXcyHb
        425b6QlGhOXj2/Bw==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Add group exclusivity
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C937d6d71010a48ea4e069f4904b3116a5f99ecdf=2E16964?=
 =?utf-8?q?25185=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C937d6d71010a48ea4e069f4904b3116a5f99ecdf=2E169642?=
 =?utf-8?q?5185=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169692596868.3135.2166851776629649995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     83a43c622123e714b0317a57176b336187f5deb3
Gitweb:        https://git.kernel.org/tip/83a43c622123e714b0317a57176b336187f5deb3
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 05 Oct 2023 10:53:14 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Oct 2023 16:12:24 +02:00

perf/x86/amd/uncore: Add group exclusivity

In some cases, it may be necessary to restrict opening PMU events to a
subset of CPUs. E.g. Unified Memory Controller (UMC) PMUs are specific
to each active memory channel and the MSR address space for the PERF_CTL
and PERF_CTR registers is reused on each socket. Thus, opening events
for a specific UMC PMU should be restricted to CPUs belonging to the
same socket as that of the UMC. The "cpumask" of the PMU should also
reflect this accordingly.

Uncore PMUs which require this can use the new group attribute in struct
amd_uncore_pmu to set a valid group ID during the scan() phase. Later,
during init(), an uncore context for a CPU will be unavailable if the
group ID does not match.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/937d6d71010a48ea4e069f4904b3116a5f99ecdf.1696425185.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 2fe6239..3189829 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -27,6 +27,7 @@
 
 #define COUNTER_SHIFT		16
 #define UNCORE_NAME_LEN		16
+#define UNCORE_GROUP_MAX	256
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"amd_uncore: " fmt
@@ -45,6 +46,7 @@ struct amd_uncore_pmu {
 	int num_counters;
 	int rdpmc_base;
 	u32 msr_base;
+	int group;
 	cpumask_t active_mask;
 	struct pmu pmu;
 	struct amd_uncore_ctx * __percpu *ctx;
@@ -61,6 +63,7 @@ union amd_uncore_info {
 	struct {
 		u64	aux_data:32;	/* auxiliary data */
 		u64	num_pmcs:8;	/* number of counters */
+		u64	gid:8;		/* group id */
 		u64	cid:8;		/* context id */
 	} split;
 	u64		full;
@@ -372,6 +375,13 @@ int amd_uncore_ctx_cid(struct amd_uncore *uncore, unsigned int cpu)
 }
 
 static __always_inline
+int amd_uncore_ctx_gid(struct amd_uncore *uncore, unsigned int cpu)
+{
+	union amd_uncore_info *info = per_cpu_ptr(uncore->info, cpu);
+	return info->split.gid;
+}
+
+static __always_inline
 int amd_uncore_ctx_num_pmcs(struct amd_uncore *uncore, unsigned int cpu)
 {
 	union amd_uncore_info *info = per_cpu_ptr(uncore->info, cpu);
@@ -409,18 +419,23 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 {
 	struct amd_uncore_ctx *curr, *prev;
 	struct amd_uncore_pmu *pmu;
-	int node, cid, i, j;
+	int node, cid, gid, i, j;
 
 	if (!uncore->init_done || !uncore->num_pmus)
 		return 0;
 
 	cid = amd_uncore_ctx_cid(uncore, cpu);
+	gid = amd_uncore_ctx_gid(uncore, cpu);
 
 	for (i = 0; i < uncore->num_pmus; i++) {
 		pmu = &uncore->pmus[i];
 		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
 		curr = NULL;
 
+		/* Check for group exclusivity */
+		if (gid != pmu->group)
+			continue;
+
 		/* Find a sibling context */
 		for_each_online_cpu(j) {
 			if (cpu == j)
@@ -603,6 +618,7 @@ void amd_uncore_df_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 
 	info.split.aux_data = 0;
 	info.split.num_pmcs = NUM_COUNTERS_NB;
+	info.split.gid = 0;
 	info.split.cid = topology_die_id(cpu);
 
 	if (pmu_version >= 2) {
@@ -641,6 +657,7 @@ int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 	pmu->num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
 	pmu->msr_base = MSR_F15H_NB_PERF_CTL;
 	pmu->rdpmc_base = RDPMC_BASE_NB;
+	pmu->group = amd_uncore_ctx_gid(uncore, cpu);
 
 	if (pmu_version >= 2) {
 		*df_attr++ = &format_attr_event14v2.attr;
@@ -734,6 +751,7 @@ void amd_uncore_l3_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 
 	info.split.aux_data = 0;
 	info.split.num_pmcs = NUM_COUNTERS_L2;
+	info.split.gid = 0;
 	info.split.cid = get_llc_id(cpu);
 
 	if (boot_cpu_data.x86 >= 0x17)
@@ -770,6 +788,7 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 	pmu->num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
 	pmu->msr_base = MSR_F16H_L2I_PERF_CTL;
 	pmu->rdpmc_base = RDPMC_BASE_LLC;
+	pmu->group = amd_uncore_ctx_gid(uncore, cpu);
 
 	if (boot_cpu_data.x86 >= 0x17) {
 		*l3_attr++ = &format_attr_event8.attr;
