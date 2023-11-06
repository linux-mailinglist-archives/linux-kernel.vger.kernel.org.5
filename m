Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C837E30EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjKFXPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjKFXPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:15:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A304F1981;
        Mon,  6 Nov 2023 15:15:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2706DC433CB;
        Mon,  6 Nov 2023 23:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312505;
        bh=LO4hMTKUYKEyxNtgfrH8fljSkWOJqgcyCWbJec+fCtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ABJYL1laRH9/Tu2DChiLBdryg50TaEOezmn/q7itsNsw2kAxH4JrwYaw7H5fYM3Nf
         9VJOWt/FawwlAPCYVIP/JTE7RaAnXgkaAo3UptuLFUDgnTApSGtAQnuC2T+eHwoRVk
         cOC6ZgFcY1LUnljVPwBG//bXmXfC/gwpKrIsXqKB7Sx8bS+tSSeD2BpY6SDYGt6syf
         2AqOBzbqOiPGZrTOl1Zi+t5gJgifKj2oG1EvPIbDcrApkN2DWDBauFVCdZqpdwZK/f
         XHHRiQDQqgSf/mKyqyS0TJ2phFS2ewNus5fEHAF/rt57XNYq820M+VMEbMkL4PoqFc
         ZsgUNCe9xPBPA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Mario Casquero <mcasquer@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Sasha Levin <sashal@kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org
Subject: [PATCH AUTOSEL 6.6 13/13] x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size
Date:   Mon,  6 Nov 2023 18:14:26 -0500
Message-ID: <20231106231435.3734790-13-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106231435.3734790-1-sashal@kernel.org>
References: <20231106231435.3734790-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

[ Upstream commit a1e2b8b36820d8c91275f207e77e91645b7c6836 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/numa.h | 7 -------
 arch/x86/mm/numa.c          | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index e3bae2b60a0db..ef2844d691735 100644
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
index 2aadb2019b4f2..55e3d895f15c3 100644
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
 
-- 
2.42.0

