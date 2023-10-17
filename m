Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8217CBB01
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjJQGWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQGWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:22:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29947AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:22:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F6FC433C8;
        Tue, 17 Oct 2023 06:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697523749;
        bh=PjgXcsl4PXsm9VaDRSYsui/J+fCpjosNZ6QzsEtjF5s=;
        h=From:To:Cc:Subject:Date:From;
        b=tbROSQ8Mb5+Da2QkZxiCTzzbNxulSkjJ/GkAQ/4HEjtDWeuXFrSaJBvb2CA7LIbLC
         mrvXK0bD9l2kXPGxlVrtqGy4XfUhaALZlZfRuVyl6/YSdsitWH2z9jeGt1w1pxZx+O
         T89d0+n16F8e4q4lHW4YU0dwkrb9X0VWhIQe/X2X+P37xAob5BHsEidzZLZo+dQqG0
         RJip3Fckh32Wm5mti8XWbTDG6g23ehhePVf+ghU5Zk08lcCdrcXRG+QHmZ1UpSlwC0
         cC2O+NOPgiLM5XzLL7t/YngCJKH8jzsdUUIH2+abQCwSVlLoAvQo+rM5sR+vd5eqM9
         I17Ssw+IWgxow==
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] x86/mm: drop 4MB restriction on minimal NUMA node size
Date:   Tue, 17 Oct 2023 09:22:15 +0300
Message-Id: <20231017062215.171670-1-rppt@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Qi Zheng reports crashes in a production environment and provides a
simplified example as a reproducer:

  For example, if we use qemu to start a two NUMA node kernel,
  one of the nodes has 2M memory (less than NODE_MIN_SIZE),
  and the other node has 2G, then we will encounter the
  following panic:

  [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
  [    0.150783] #PF: supervisor write access in kernel mode
  [    0.151488] #PF: error_code(0x0002) - not-present page
  <...>
  [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
  <...>
  [    0.169781] Call Trace:
  [    0.170159]  <TASK>
  [    0.170448]  deactivate_slab+0x187/0x3c0
  [    0.171031]  ? bootstrap+0x1b/0x10e
  [    0.171559]  ? preempt_count_sub+0x9/0xa0
  [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
  [    0.172735]  ? bootstrap+0x1b/0x10e
  [    0.173236]  bootstrap+0x6b/0x10e
  [    0.173720]  kmem_cache_init+0x10a/0x188
  [    0.174240]  start_kernel+0x415/0x6ac
  [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
  [    0.175417]  </TASK>
  [    0.175713] Modules linked in:
  [    0.176117] CR2: 0000000000000000

The crashes happen because of inconsistency between nodemask that has
nodes with less than 4MB as memoryless and the actual memory fed into
core mm.

The commit 9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring
empty node in SRAT parsing") that introduced minimal size of a NUMA node
does not explain why a node size cannot be less than 4MB and what boot
failures this restriction might fix.

Since then a lot has changed and core mm won't confuse badly about small
node sizes.

Drop the limitation for the minimal node size.

Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Link: https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
---
 arch/x86/include/asm/numa.h | 7 -------
 arch/x86/mm/numa.c          | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index e3bae2b60a0d..ef2844d69173 100644
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
index 2aadb2019b4f..55e3d895f15c 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -601,13 +601,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
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
 

base-commit: 94f6f0550c625fab1f373bb86a6669b45e9748b3
-- 
2.39.2

