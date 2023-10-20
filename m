Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D8B7D0AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376552AbjJTI44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376520AbjJTI4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:56:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED694D46;
        Fri, 20 Oct 2023 01:56:50 -0700 (PDT)
Date:   Fri, 20 Oct 2023 08:56:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697792209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/v7dhIVAF1zthVlRMitXiJdAtF/pjTP4sYxVNTwMQgs=;
        b=4h7yOK8OhGX1XBcsSKVCHpn/IR3HxKvNvqGg9jwawgxci0ePxe9Ut5ZzZvOp7U5+VfXzm+
        F+WGCJUglWDRj9T38Q5lO6tEnr2368DLhM5BSsltr4KAzDCZHXbGadFU9sr3L5YxsTMB5g
        BWTJI7OaP2vQuuebKKfxp1zBxWUbWalqS3J9pHnEei3xfJyC/zsIqFuG+aKj3wpja9RrrH
        JUvdTkI6YunBVmzT0oeWHg8KITl+Imlh/H++tqG/WTorYuZYpr9Gq7OOwV2KAvnOuTl/Lp
        Lrm0dlS7nlyNEMWi5VERtPLXr5DuP9AazsWjmOjhT6W248rLtqFEbmEFMvJv1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697792209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/v7dhIVAF1zthVlRMitXiJdAtF/pjTP4sYxVNTwMQgs=;
        b=pR9VQ/Dw41GsLseKmOFMsavXxaM2aDd2p0usLsboW/IoWeEjOL1E8iU56ynRpbP4QVortT
        32BCKmge8zGKdXBQ==
From:   "tip-bot2 for Mike Rapoport (IBM)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Drop the 4 MB restriction on minimal NUMA node
 memory size
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Mario Casquero <mcasquer@redhat.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <867br@gmail.com>
References: <867br@gmail.com>
MIME-Version: 1.0
Message-ID: <169779220868.3135.10791045037524733897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     a1e2b8b36820d8c91275f207e77e91645b7c6836
Gitweb:        https://git.kernel.org/tip/a1e2b8b36820d8c91275f207e77e91645b7c6836
Author:        Mike Rapoport (IBM) <rppt@kernel.org>
AuthorDate:    Wed, 18 Oct 2023 12:42:50 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 20 Oct 2023 10:40:22 +02:00

x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size

Qi Zheng reported crashes in a production environment and provided a
simplified example as a reproducer:

 |  For example, if we use Qemu to start a two NUMA node kernel,
 |  one of the nodes has 2M memory (less than NODE_MIN_SIZE),
 |  and the other node has 2G, then we will encounter the
 |  following panic:
 |
 |    BUG: kernel NULL pointer dereference, address: 0000000000000000
 |    <...>
 |    RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
 |    <...>
 |    Call Trace:
 |      <TASK>
 |      deactivate_slab()
 |      bootstrap()
 |      kmem_cache_init()
 |      start_kernel()
 |      secondary_startup_64_no_verify()

The crashes happen because of inconsistency between the nodemask that
has nodes with less than 4MB as memoryless, and the actual memory fed
into the core mm.

The commit:

  9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring empty node in SRAT parsing")

... that introduced minimal size of a NUMA node does not explain why
a node size cannot be less than 4MB and what boot failures this
restriction might fix.

Fixes have been submitted to the core MM code to tighten up the
memory topologies it accepts and to not crash on weird input:

  mm: page_alloc: skip memoryless nodes entirely
  mm: memory_hotplug: drop memoryless node from fallback lists

Andrew has accepted them into the -mm tree, but there are no
stable SHA1's yet.

This patch drops the limitation for minimal node size on x86:

  - which works around the crash without the fixes to the core MM.
  - makes x86 topologies less weird,
  - removes an arbitrary and undocumented limitation on NUMA topologies.

[ mingo: Improved changelog clarity. ]

Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Rik van Riel <riel@surriel.com>
Link: https://lore.kernel.org/r/ZS+2qqjEO5/867br@gmail.com
---
 arch/x86/include/asm/numa.h | 7 -------
 arch/x86/mm/numa.c          | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index e3bae2b..ef2844d 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -12,13 +12,6 @@
 
 #define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
 
-/*
- * Too small node sizes may confuse the VM badly. Usually they
- * result from BIOS bugs. So dont recognize nodes as standalone
- * NUMA entities that have less than this amount of RAM listed:
- */
-#define NODE_MIN_SIZE (4*1024*1024)
-
 extern int numa_off;
 
 /*
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index c01c550..aa39d67 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -602,13 +602,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 		if (start >= end)
 			continue;
 
-		/*
-		 * Don't confuse VM with a node that doesn't have the
-		 * minimum amount of memory:
-		 */
-		if (end && (end - start) < NODE_MIN_SIZE)
-			continue;
-
 		alloc_node_data(nid);
 	}
 
