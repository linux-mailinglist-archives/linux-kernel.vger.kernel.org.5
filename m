Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F38575638C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGQM5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjGQM5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:57:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A9319AE;
        Mon, 17 Jul 2023 05:56:42 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:56:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598573;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eknuv9JzEkTP8q2JWBFLcMfKm/vef1f57vqL4RUF+M0=;
        b=Dah4yfUr2ZAnTYLZjviQ9J5JhglZ+f8A/6WeVQ+my6VJQG99N8GIYnuYZu3HXEYrBCyFUR
        vDvES0375l+K6TEpo7WMlTxaYDp5yMlirF3tDPAlwSTw4avWpeMfy0y524M9YzjTkZshGW
        qaNgfITTqKatfhli+Z40P792PVDim4OjG3CX6pUYiAk8n/doXkAAvsKCfyL1yqUiME0xZ0
        AExyPfnfvU9mfD6dhvQUkHkL/asKGTXDHT+gz2uRBshw1Ru/9CuiRgqe92QeOIS0ENfSGN
        ZhILAldqgvUjBB8Zm4Pov7fNCi/UbrdBRLXby/y/52nYXQgjYWHwe6BmdDfS+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598573;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eknuv9JzEkTP8q2JWBFLcMfKm/vef1f57vqL4RUF+M0=;
        b=bYuPTL5aaW0YxGwTHpM8HZbHUT2D11h4xvWMITYeCm/y1lxhGzzK6gfqjztp1kDsxg9xsV
        qAYMxrVWaW2JivDA==
From:   "tip-bot2 for Tim C Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Record number of cores in sched group
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C04641eeb0e95c21224352f5743ecb93dfac44654=2E16887?=
 =?utf-8?q?70494=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3C04641eeb0e95c21224352f5743ecb93dfac44654=2E168877?=
 =?utf-8?q?0494=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <168959857267.28540.7534555852542758519.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d24cb0d9113f5932b8832533ce82351b5911ed50
Gitweb:        https://git.kernel.org/tip/d24cb0d9113f5932b8832533ce82351b5911ed50
Author:        Tim C Chen <tim.c.chen@linux.intel.com>
AuthorDate:    Fri, 07 Jul 2023 15:57:01 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 13 Jul 2023 15:21:51 +02:00

sched/topology: Record number of cores in sched group

When balancing sibling domains that have different number of cores,
tasks in respective sibling domain should be proportional to the
number of cores in each domain. In preparation of implementing such a
policy, record the number of cores in a scheduling group.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/04641eeb0e95c21224352f5743ecb93dfac44654.1688770494.git.tim.c.chen@linux.intel.com
---
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1dcea9b..9baeb1a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1884,6 +1884,7 @@ struct sched_group {
 	atomic_t		ref;
 
 	unsigned int		group_weight;
+	unsigned int		cores;
 	struct sched_group_capacity *sgc;
 	int			asym_prefer_cpu;	/* CPU of highest priority in group */
 	int			flags;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d3a3b26..7cfcfe5 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1275,14 +1275,24 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 {
 	struct sched_group *sg = sd->groups;
+	struct cpumask *mask = sched_domains_tmpmask2;
 
 	WARN_ON(!sg);
 
 	do {
-		int cpu, max_cpu = -1;
+		int cpu, cores = 0, max_cpu = -1;
 
 		sg->group_weight = cpumask_weight(sched_group_span(sg));
 
+		cpumask_copy(mask, sched_group_span(sg));
+		for_each_cpu(cpu, mask) {
+			cores++;
+#ifdef CONFIG_SCHED_SMT
+			cpumask_andnot(mask, mask, cpu_smt_mask(cpu));
+#endif
+		}
+		sg->cores = cores;
+
 		if (!(sd->flags & SD_ASYM_PACKING))
 			goto next;
 
