Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6B67A1E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjIOMFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjIOMFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:05:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE86630FC;
        Fri, 15 Sep 2023 05:03:29 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:03:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694779408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Knz92vbi3xQjwBg4Oo4g/J44FErfuk1HmZsD73zqmVE=;
        b=QLVAjCrtfjXvQuu09jprgAhNAGUafer6iu6XvAEgwPxZHI2TPYubDxU8X9EfO/hI2xvOrf
        wOUB12JQGqa6VYQVrh2K36ofmeT1xjDe6jEzMX/mRnjHuEA97ySAYoY066Qy9/QWB4TX4j
        YLCRllwRnt+H0c8Dq7FQtsMofyLhsmPuNzQnTrprT/Pbmo9BN1v3ZVegDq/VNqdrY2i0IO
        I9FpBsScmUFdi/pfx585aegBs9tLl57T5EhC4+mooqybOgi3o+PdbtBoJNEXVdVPFwDUmM
        cWop7Z/hUtQWqMUoxTvVlFGIoA7lxzoZ4V3bBJELEBYuDGT+eYb0WkoCkfZqrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694779408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Knz92vbi3xQjwBg4Oo4g/J44FErfuk1HmZsD73zqmVE=;
        b=qFrzo0I/hWBhFAz8CNGa2/ZnOUm3o58+c6Lhd08KY0qGQ2eBgwqEPPi/Z+JFhhyjgbN4M3
        Fj2tGu6kkyNV06Bw==
From:   "tip-bot2 for Yury Norov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Fix sched_numa_find_nth_cpu() in
 non-NUMA case
Cc:     Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230819141239.287290-5-yury.norov@gmail.com>
References: <20230819141239.287290-5-yury.norov@gmail.com>
MIME-Version: 1.0
Message-ID: <169477940797.27769.5804988700503210268.tip-bot2@tip-bot2>
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

Commit-ID:     8ab63d418d4339d996f80d02a00dbce0aa3ff972
Gitweb:        https://git.kernel.org/tip/8ab63d418d4339d996f80d02a00dbce0aa3ff972
Author:        Yury Norov <yury.norov@gmail.com>
AuthorDate:    Sat, 19 Aug 2023 07:12:36 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 13:48:10 +02:00

sched/topology: Fix sched_numa_find_nth_cpu() in non-NUMA case

When CONFIG_NUMA is enabled, sched_numa_find_nth_cpu() searches for a
CPU in sched_domains_numa_masks. The masks includes only online CPUs,
so effectively offline CPUs are skipped.

When CONFIG_NUMA is disabled, the fallback function should be consistent.

Fixes: cd7f55359c90 ("sched: add sched_numa_find_nth_cpu()")
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20230819141239.287290-5-yury.norov@gmail.com
---
 include/linux/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index fea3237..52f5850 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -251,7 +251,7 @@ extern const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int
 #else
 static __always_inline int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 {
-	return cpumask_nth(cpu, cpus);
+	return cpumask_nth_and(cpu, cpus, cpu_online_mask);
 }
 
 static inline const struct cpumask *
