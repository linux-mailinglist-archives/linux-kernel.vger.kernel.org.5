Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBAC7E3126
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjKFXSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjKFXRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:17:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101E41BF8;
        Mon,  6 Nov 2023 15:16:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AE2C433C7;
        Mon,  6 Nov 2023 23:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312573;
        bh=dy5s2yWfOfc+yxLskZ+7lO8TKlL3bcAfleQ7Y95HKos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8ZmkWwuv8E+lZrR0vD23BoYui7F/815Syj/Z+SibgB9ewzPwuhTM+VCfXyQ3SB58
         n1ATT0sPpXIabaE9pQG0s2eAoQS9apwiiP9qmNvKT80EJK8ODL+ELVzFNhKALGtsyw
         HEz0D29I2ymWM8jD33orGTPz3eYfqgMX7V4Gj9fpoDrhvKNVqAXhc36y4fajuvzZ6w
         /KlN0GvWUve/lrnIFFmMKzX1jozZ1Npliyh5xwyuw3d4DSjwJM4OLmhysuWE76Z/JG
         qEWhyz+xO8yMKciMTixlONUjHslL7rZudwZKVUF6eNNyokgNYbHO70I1eC2E4ynB3b
         xUNgcXTayvdpg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>, peterz@infradead.org
Subject: [PATCH AUTOSEL 6.1 09/11] cpu/hotplug: Don't offline the last non-isolated CPU
Date:   Mon,  6 Nov 2023 18:15:43 -0500
Message-ID: <20231106231553.3735366-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106231553.3735366-1-sashal@kernel.org>
References: <20231106231553.3735366-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

[ Upstream commit 38685e2a0476127db766f81b1c06019ddc4c9ffa ]

If a system has isolated CPUs via the "isolcpus=" command line parameter,
then an attempt to offline the last housekeeping CPU will result in a
WARN_ON() when rebuilding the scheduler domains and a subsequent panic due
to and unhandled empty CPU mas in partition_sched_domains_locked().

cpuset_hotplug_workfn()
  rebuild_sched_domains_locked()
    ndoms = generate_sched_domains(&doms, &attr);
      cpumask_and(doms[0], top_cpuset.effective_cpus, housekeeping_cpumask(HK_FLAG_DOMAIN));

Thus results in an empty CPU mask which triggers the warning and then the
subsequent crash:

WARNING: CPU: 4 PID: 80 at kernel/sched/topology.c:2366 build_sched_domains+0x120c/0x1408
Call trace:
 build_sched_domains+0x120c/0x1408
 partition_sched_domains_locked+0x234/0x880
 rebuild_sched_domains_locked+0x37c/0x798
 rebuild_sched_domains+0x30/0x58
 cpuset_hotplug_workfn+0x2a8/0x930

Unable to handle kernel paging request at virtual address fffe80027ab37080
 partition_sched_domains_locked+0x318/0x880
 rebuild_sched_domains_locked+0x37c/0x798

Aside of the resulting crash, it does not make any sense to offline the last
last housekeeping CPU.

Prevent this by masking out the non-housekeeping CPUs when selecting a
target CPU for initiating the CPU unplug operation via the work queue.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/202310171709530660462@zte.com.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cpu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index f8eb1825f704f..0e4d362e90825 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1243,11 +1243,14 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 	/*
 	 * Ensure that the control task does not run on the to be offlined
 	 * CPU to prevent a deadlock against cfs_b->period_timer.
+	 * Also keep at least one housekeeping cpu onlined to avoid generating
+	 * an empty sched_domain span.
 	 */
-	cpu = cpumask_any_but(cpu_online_mask, cpu);
-	if (cpu >= nr_cpu_ids)
-		return -EBUSY;
-	return work_on_cpu(cpu, __cpu_down_maps_locked, &work);
+	for_each_cpu_and(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_DOMAIN)) {
+		if (cpu != work.cpu)
+			return work_on_cpu(cpu, __cpu_down_maps_locked, &work);
+	}
+	return -EBUSY;
 }
 
 static int cpu_down(unsigned int cpu, enum cpuhp_state target)
-- 
2.42.0

