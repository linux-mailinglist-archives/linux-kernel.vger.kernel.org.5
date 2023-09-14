Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BA57A08F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbjINPVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239530AbjINPVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:21:45 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F0EC1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:21:41 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76dcf1d8957so75332785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694704900; x=1695309700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a5AAJjTPKJrbM2I7UYPlK+5KUhbVO5e1/2BSYEunOT4=;
        b=3WI7VxyESBxfqKW2eyaDDY2HtyQARmAbdQS35iy7BVr/1jhtHHrXDT78rGWjtT6ZT3
         BS1iPsssEbDBBbPBCmKJm0Vf86OOssZJkOwkH9Yd9NdaEdCJFqSCu2tnsDudUAvZCdE4
         Y0fsYvCH57rpGDqG9iVgrvWTpMOI/RM+aYxcO2w5xWouvoijttCgCX8ml9ICb8vha5lE
         FRmnEbo+sOkHL8LS4jWetWhU2qVFGZwxSpjcf6VW0i0KiXbWG3YHvqEBtXJoznnqUmFp
         yduYjnxc8K39LsXVcf009AeJ6H9MtpEBp4fZTlNOtwf9xgh0FWnRFu8X5kjpgww1JbFy
         9s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694704900; x=1695309700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5AAJjTPKJrbM2I7UYPlK+5KUhbVO5e1/2BSYEunOT4=;
        b=Hw6swdxNnjpdjGzxYDdWpab8kJnUe7bc766EloUWtRn8wnDibRsBMbXGUJkycjLFPv
         c2xktSXJol0CdunRVFtrRCuhCw2pmxRmEFS5+AmTdfQHAgb/pvMZEmjArxgBUtDclVho
         HDhkhYnx1aQEnegOsQGLYAYdloQetRNnmOKm/x2lpq5MbBV6OpmqeStbB34Q72bRwwkC
         Y/qQ0Cu5MH6Q9rZNnH2FMWjxS5ex4lyixjJ7YoYSEkUgKaaZ4mqt1NoGA1/YeNXCqPN4
         HPeaqJVqcW2TR9ym6gqWtL6LZgAyjgEbma8AUh7J5WZytq1woZ8UVw1Ot4zD+6/J8dtw
         ahig==
X-Gm-Message-State: AOJu0YzIqEHho3QVOidzgGRBkNXOe8HTW/7xG+zsuIaSWt/NUi3RGzHa
        kiKXBMBnJwAUThNl9xpG8nIxk8sJuLZFxRSoJLk=
X-Google-Smtp-Source: AGHT+IHgtk6WfW2S9wNIgrLhLx0aGlhPzs87X2FNRaKA/uPvD9Pcu8aQedVeuRULw1Fcn3jL1s7COw==
X-Received: by 2002:a05:620a:404b:b0:76e:f279:4c36 with SMTP id i11-20020a05620a404b00b0076ef2794c36mr7068909qko.29.1694704900315;
        Thu, 14 Sep 2023 08:21:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:35bb])
        by smtp.gmail.com with ESMTPSA id ou19-20020a05620a621300b0076cf49bcb50sm543795qkn.37.2023.09.14.08.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:21:40 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Breno Leitao <leitao@debian.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: memcontrol: fix GFP_NOFS recursion in memory.high enforcement
Date:   Thu, 14 Sep 2023 11:21:39 -0400
Message-ID: <20230914152139.100822-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Breno and Josef report a deadlock scenario from cgroup reclaim
re-entering the filesystem:

[  361.546690] ======================================================
[  361.559210] WARNING: possible circular locking dependency detected
[  361.571703] 6.5.0-0_fbk700_debug_rc0_kbuilder_13159_gbf787a128001 #1 Tainted: G S          E
[  361.589704] ------------------------------------------------------
[  361.602277] find/9315 is trying to acquire lock:
[  361.611625] ffff88837ba140c0 (&delayed_node->mutex){+.+.}-{4:4}, at: __btrfs_release_delayed_node+0x68/0x4f0
[  361.631437]
[  361.631437] but task is already holding lock:
[  361.643243] ffff8881765b8678 (btrfs-tree-01){++++}-{4:4}, at: btrfs_tree_read_lock+0x1e/0x40

[  362.904457]  mutex_lock_nested+0x1c/0x30
[  362.912414]  __btrfs_release_delayed_node+0x68/0x4f0
[  362.922460]  btrfs_evict_inode+0x301/0x770
[  362.982726]  evict+0x17c/0x380
[  362.988944]  prune_icache_sb+0x100/0x1d0
[  363.005559]  super_cache_scan+0x1f8/0x260
[  363.013695]  do_shrink_slab+0x2a2/0x540
[  363.021489]  shrink_slab_memcg+0x237/0x3d0
[  363.050606]  shrink_slab+0xa7/0x240
[  363.083382]  shrink_node_memcgs+0x262/0x3b0
[  363.091870]  shrink_node+0x1a4/0x720
[  363.099150]  shrink_zones+0x1f6/0x5d0
[  363.148798]  do_try_to_free_pages+0x19b/0x5e0
[  363.157633]  try_to_free_mem_cgroup_pages+0x266/0x370
[  363.190575]  reclaim_high+0x16f/0x1f0
[  363.208409]  mem_cgroup_handle_over_high+0x10b/0x270
[  363.246678]  try_charge_memcg+0xaf2/0xc70
[  363.304151]  charge_memcg+0xf0/0x350
[  363.320070]  __mem_cgroup_charge+0x28/0x40
[  363.328371]  __filemap_add_folio+0x870/0xd50
[  363.371303]  filemap_add_folio+0xdd/0x310
[  363.399696]  __filemap_get_folio+0x2fc/0x7d0
[  363.419086]  pagecache_get_page+0xe/0x30
[  363.427048]  alloc_extent_buffer+0x1cd/0x6a0
[  363.435704]  read_tree_block+0x43/0xc0
[  363.443316]  read_block_for_search+0x361/0x510
[  363.466690]  btrfs_search_slot+0xc8c/0x1520

This is caused by the mem_cgroup_handle_over_high() not respecting the
gfp_mask of the allocation context. We used to only call this function
on resume to userspace, where no locks were held. But c9afe31ec443
("memcg: synchronously enforce memory.high for large overcharges")
added a call from the allocation context without considering the gfp.

Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: Josef Bacik <josef@toxicpanda.com>
Fixes: c9afe31ec443 ("memcg: synchronously enforce memory.high for large overcharges")
Cc: stable@vger.kernel.org # 5.17+
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h       | 4 ++--
 include/linux/resume_user_mode.h | 2 +-
 mm/memcontrol.c                  | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ab94ad4597d0..e4e24da16d2c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -920,7 +920,7 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 	return READ_ONCE(mz->lru_zone_size[zone_idx][lru]);
 }
 
-void mem_cgroup_handle_over_high(void);
+void mem_cgroup_handle_over_high(gfp_t gfp_mask);
 
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
 
@@ -1458,7 +1458,7 @@ static inline void mem_cgroup_unlock_pages(void)
 	rcu_read_unlock();
 }
 
-static inline void mem_cgroup_handle_over_high(void)
+static inline void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 {
 }
 
diff --git a/include/linux/resume_user_mode.h b/include/linux/resume_user_mode.h
index 285189454449..f8f3e958e9cf 100644
--- a/include/linux/resume_user_mode.h
+++ b/include/linux/resume_user_mode.h
@@ -55,7 +55,7 @@ static inline void resume_user_mode_work(struct pt_regs *regs)
 	}
 #endif
 
-	mem_cgroup_handle_over_high();
+	mem_cgroup_handle_over_high(GFP_KERNEL);
 	blkcg_maybe_throttle_current();
 
 	rseq_handle_notify_resume(NULL, regs);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a4d3282493b6..d13dde2f8b56 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2555,7 +2555,7 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
  * Scheduled by try_charge() to be executed from the userland return path
  * and reclaims memory over the high limit.
  */
-void mem_cgroup_handle_over_high(void)
+void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 {
 	unsigned long penalty_jiffies;
 	unsigned long pflags;
@@ -2583,7 +2583,7 @@ void mem_cgroup_handle_over_high(void)
 	 */
 	nr_reclaimed = reclaim_high(memcg,
 				    in_retry ? SWAP_CLUSTER_MAX : nr_pages,
-				    GFP_KERNEL);
+				    gfp_mask);
 
 	/*
 	 * memory.high is breached and reclaim is unable to keep up. Throttle
@@ -2819,7 +2819,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
 	    !(current->flags & PF_MEMALLOC) &&
 	    gfpflags_allow_blocking(gfp_mask)) {
-		mem_cgroup_handle_over_high();
+		mem_cgroup_handle_over_high(gfp_mask);
 	}
 	return 0;
 }
-- 
2.42.0

