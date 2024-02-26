Return-Path: <linux-kernel+bounces-80752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCF3866C11
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04E01C2298E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EFD1CA83;
	Mon, 26 Feb 2024 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzdnX2BE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D847E1CA81
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935941; cv=none; b=flloKybA1qzJLglD/AWR7RVt6cM1UJ+pKGO/xLZzcTrkgPqRwQSyE/gACkll7Lz7xEN9gevvbgFwcg4mAJbot6j2lfo5EybEynffss/7aCPnjUaDooTTkCaAq2QeDuVyGgBXY70A3J8H7/IPSbO9Bt4NgTukRto7buU1x4vNoek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935941; c=relaxed/simple;
	bh=d9TfJ1vj7CqpSO3yp7wBMj3Qok8UMIT9GlpK+EBJT5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QDhrnBv9mbpZ7RJZ/is13rYHv9zsOOfczt/e5VCGDSmz5gfJNOxYWgN+NMQ1mb6RE6uLzX3m/qCJeDsPWutMmevpSbVRBNrxFGE3GeMY+5PfDTz3lD8pXw6IxSKxBVbDwvzQ5oxWYB/Mke1DXJLifyXlKddRsIPKlAmH9wrlRnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzdnX2BE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708935940; x=1740471940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d9TfJ1vj7CqpSO3yp7wBMj3Qok8UMIT9GlpK+EBJT5I=;
  b=SzdnX2BE9f+rvX4I8fpH3gEVtQjkzHSqNYRWtLggqAJ8XheBATPR8qI9
   3uuCAbw3xfwiRjPbmvk57xcFLyfA+U88GwPI2lAvOpvSqr/IdCzumNJJV
   cCkq5hCUL+Rpa9D29yF4ODZ0zIvVbBB5d2njJvQ2e9ur8FUvngiXbRXlC
   SAqHa5oAPD3VNYqB9FTwWsbkIFzNYdeZpSAPu8V0xefjSl6XgmPqQGi7g
   gcp3REZNuuUO9uGlv1i5BsZFm8RPW7bbEV9Y9/8XHopuyZOo+tw6g2dw7
   yKg0bV2HPUoIypj6vXZYOamlVRsLD5dB19IQDVC7/QT9xAQD481Dvls8h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="20750875"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="20750875"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 00:25:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6734000"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa008.fm.intel.com with ESMTP; 26 Feb 2024 00:25:35 -0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	Tim Chen <tim.c.chen@intel.com>,
	"Tiwei Bie" <tiwei.btw@antgroup.com>,
	Honglei Wang <wanghonglei@didichuxing.com>,
	Aaron Lu <aaron.lu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf() if no eligible entity is found
Date: Mon, 26 Feb 2024 16:23:49 +0800
Message-Id: <20240226082349.302363-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is occasional report from lkp that the kernel hits the NULL pointer
exception:

[  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
[  512.080897][ T8305] #PF: supervisor read access in kernel mode
[  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
[  512.082337][ T8305] *pde = 00000000
[  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
[  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W
[  512.086203][ T8305] EIP: set_next_entity (fair.c:?)

This is caused by NULL candidate returned by pick_eevdf() as Abel analyzed.
After
commit 2227a957e1d5 ("sched/eevdf: Sort the rbtree by virtual deadline")
the NULL candidate would trigger the NULL pointer exception. While before
this commit, there would be warning.

This NULL entity issue was always there before above commit. With debug
patch to print the cfs_rq and all the entities in the tree, we have the
information when the issue was reproduced:

[  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:2048 min_vruntime:763383370431
[  514.535935][ T8390] current on_rq se 0xc5851400, deadline:18435852013562231446
			min_vruntime:18437121115753667698 vruntime:18435852013561943404, load:629
[  514.536772][ T8390] Traverse rb-tree from left to right
[  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible
[  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
[  514.538539][ T8390] Traverse rb-tree from topdown
[  514.538877][ T8390]  middle se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible
[  514.539605][ T8390]  middle se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
[  514.540340][ T8390] Found best:0x0
[  514.540613][ T8390] BUG: kernel NULL pointer dereference, address: 00000074

We can see that non of the entities in the tree are eligible, neither is
the current entity on this cfs_rq. As a result, curr is set to NULL:
if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
	curr = NULL;

and the best is set to NULL, which caused the problem:
if (!best || (curr && entity_before(curr, best)))
	best = curr;

The cause is that, the curr is eligible, but vruntime_eligible()
returns false. And the false negative is due to the following
code in vruntime_eligible():

return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;

According to the log, vruntime is 18435852013561943404, the
cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 = 2677,
thus:
s64 delta = (s64)(18435852013561943404 - 763383370431) = -10892823530978643
    delta * 2677 = 7733399554989275921
that is to say, the multiply result overflow the s64, which turns the
negative value into a positive value, thus eligible check fails.

So where is this insane huge vruntime 18435852013561943404 coming from?
My guess is that, it is because the initial value of cfs_rq->min_vruntime
is set to (unsigned long)(-(1LL << 20)). If the task(watchdog in this case)
seldom scheduled in, its vruntime might not move forward too much and
remain its original value by previous place_entity().

The proper fix should deal with the overflow of entity_key() * load, but
I don't have much clue on that, so propose this conservative method to
restore the previous behavior before the mentioned commit.

Fixes: 2227a957e1d5 ("sched/eevdf: Sort the rbtree by virtual deadline")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/lkml/202401301012.2ed95df0-oliver.sang@intel.com/
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..fb9202f464e2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -880,7 +880,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
 	struct sched_entity *se = __pick_first_entity(cfs_rq);
 	struct sched_entity *curr = cfs_rq->curr;
-	struct sched_entity *best = NULL;
+	struct sched_entity *best = NULL, *leftmost;
 
 	/*
 	 * We can safely skip eligibility check if there is only one entity
@@ -905,6 +905,8 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 		goto found;
 	}
 
+	leftmost = se;
+
 	/* Heap search for the EEVD entity */
 	while (node) {
 		struct rb_node *left = node->rb_left;
@@ -937,6 +939,15 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (!best || (curr && entity_before(curr, best)))
 		best = curr;
 
+	/*
+	 * entity_eligible() could bring false negative due to
+	 * multiply overflow, which reports no eligible entity.
+	 * Return leftmost entity as a backup(it is guaranteed
+	 * the tree is not NULL.
+	 */
+	if (!best)
+		best = leftmost;
+
 	return best;
 }
 
-- 
2.25.1


