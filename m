Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ADB7A1E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjIOMF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjIOMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:05:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88A42D69;
        Fri, 15 Sep 2023 05:03:29 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:03:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694779408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m7xp2X0Q8S/UayPYw7OGxOiHU450hlKqChD/eZZVcCs=;
        b=Hirae0LrG0bLpw07ZY4W7bV7I4wTnVTmEXli7fCJdPnPWnYZBDfylWRhZuvic8Qt8bQFFK
        88XIbWPiXNWRvQr+fzoZwkjkOBr1CN6cU8ixvriM4uhJUA9Lck91q+MVmVeHyleJC5GTte
        IVAiUp33si+gfiQQ7WQ3n1JYbbpB+fveCzEFJAhGExwNF8UDjyiHftmZXqMnOhgQtKZrh1
        86/k4c7K1yLHzrl4F9Md9VMFRpag2cIzBr/5OSAYoVNgnaP55lobC6VbgUiuXmQj9T24m5
        x/SJVSyzB0TeSdAf/IHbp+cG4SPcTocNJU8K0E+DLiIUDcchArMc2Qt8kPVhUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694779408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m7xp2X0Q8S/UayPYw7OGxOiHU450hlKqChD/eZZVcCs=;
        b=yHAMCmnFUsnH1KgsSFDYFIGpnHy1xGG2jfTXs8Ob+CZ1WXc5wHE/AD2q6eObxiZMoG1pYE
        7Q8TEefphUgewWCg==
From:   "tip-bot2 for Yury Norov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Handle NUMA_NO_NODE in
 sched_numa_find_nth_cpu()
Cc:     Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230819141239.287290-6-yury.norov@gmail.com>
References: <20230819141239.287290-6-yury.norov@gmail.com>
MIME-Version: 1.0
Message-ID: <169477940743.27769.15976789729426503596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9ecea9ae4d3127a09fb5dfcea87f248937a39ff5
Gitweb:        https://git.kernel.org/tip/9ecea9ae4d3127a09fb5dfcea87f248937a39ff5
Author:        Yury Norov <yury.norov@gmail.com>
AuthorDate:    Sat, 19 Aug 2023 07:12:37 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 13:48:11 +02:00

sched/topology: Handle NUMA_NO_NODE in sched_numa_find_nth_cpu()

sched_numa_find_nth_cpu() doesn't handle NUMA_NO_NODE properly, and
may crash kernel if passed with it. On the other hand, the only user
of sched_numa_find_nth_cpu() has to check NUMA_NO_NODE case explicitly.

It would be easier for users if this logic will get moved into
sched_numa_find_nth_cpu().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20230819141239.287290-6-yury.norov@gmail.com
---
 kernel/sched/topology.c | 3 +++
 lib/cpumask.c           | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 423d089..a60ecf4 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2126,6 +2126,9 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 	struct cpumask ***hop_masks;
 	int hop, ret = nr_cpu_ids;
 
+	if (node == NUMA_NO_NODE)
+		return cpumask_nth_and(cpu, cpus, cpu_online_mask);
+
 	rcu_read_lock();
 
 	/* CPU-less node entries are uninitialized in sched_domains_numa_masks */
diff --git a/lib/cpumask.c b/lib/cpumask.c
index a7fd02b..34335c1 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -146,9 +146,7 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
 	/* Wrap: we always want a cpu. */
 	i %= num_online_cpus();
 
-	cpu = (node == NUMA_NO_NODE) ?
-		cpumask_nth(i, cpu_online_mask) :
-		sched_numa_find_nth_cpu(cpu_online_mask, i, node);
+	cpu = sched_numa_find_nth_cpu(cpu_online_mask, i, node);
 
 	WARN_ON(cpu >= nr_cpu_ids);
 	return cpu;
