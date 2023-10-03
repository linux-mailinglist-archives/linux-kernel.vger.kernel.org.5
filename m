Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571C27B6550
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbjJCJUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjJCJUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:20:23 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB36EB8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:20:18 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d8673a90f56so730877276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696324818; x=1696929618; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WpSDmja3k+xJDYdjjbygGD+ZOvEonrCZy7oEBpIDr3Y=;
        b=2qkyGMP2rfn/rqi5B3pyn9C3CPURYD7MBSYtcTBwbDYvOPCKSooeOd63M2MY/H+jW6
         optuBF+duQhiCZkXct+LdijUzQEXb+4O8jRT0Nk7NGo3Oov5kceHAeJ8cM775/eRk9wz
         CWpAcJJEQ5mG5uGs6AFBIDCbIN063iecVcWs6rhtsiYnt3L/Se+Aa1koYU7mpe9iQJ+X
         tg0LnIWET3RoL22fI9Qib2L3fTJH077mmsmNDWHks1qSPBL13VMH5QzlNZR3ufTCTIy0
         4qA0xBmDxdM4dC2Mk0QYZllBmKsB6XnG0RhA8asN+jS8Bx64k0NcYV75G+TW4JeKsrkv
         30VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696324818; x=1696929618;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WpSDmja3k+xJDYdjjbygGD+ZOvEonrCZy7oEBpIDr3Y=;
        b=DpOJYSAYUD7d9FRTnnFf4HnE8PRarCQSXTNGaQ4juKrWfmvw9sH9JnyB/sRuHCXzLa
         6Oa1hNOyBKV6cU+Vv9rjYijNbNY2MCFI6VHNYVBFi1WyaJRUc1nz4np0WFeOe1HUHoiW
         3AYy1wvmzCqDGomssJzORYMyWEgTJ1F2aY601Q3tglFtn+/6wNweS4dGzb5lCfhIJ9Mw
         1lXgQ39av+S4iWDDJYkavsXXftXeuCABy29JjlX9sSsT+wUUX4tOTxWHgHcQNvL2FiqI
         PF2eRQPdWVbz+uOqVRYKxVllAa+PQFXuyvWSLeEjuC4llYU7eLGT1x1Vgzc/K22f5YYD
         ALpw==
X-Gm-Message-State: AOJu0YyCeNBk5oGMTsLoEpJxXs71cy9pHquciNaaHMptaDjGIbEKrmc1
        AbE9bpVC+Fz+zfGLujfqMaXUwg==
X-Google-Smtp-Source: AGHT+IEft503DS0lDDt3TXmtWRBCS6YBAa+I/5dVhW15BOv+4PDW9asRrQ3b3VJqUbGfVYzkZaPOgg==
X-Received: by 2002:a25:50ce:0:b0:d90:b45d:6e6a with SMTP id e197-20020a2550ce000000b00d90b45d6e6amr5801772ybb.2.1696324817790;
        Tue, 03 Oct 2023 02:20:17 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j2-20020a258b82000000b00d8674371317sm279506ybl.36.2023.10.03.02.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:20:17 -0700 (PDT)
Date:   Tue, 3 Oct 2023 02:20:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Andi Kleen <ak@linux.intel.com>, Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 05/12] mempolicy trivia: slightly more consistent naming
In-Reply-To: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
Message-ID: <68287974-b6ae-7df-4ba-d19ddd69cbf@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before getting down to work, do a little cleanup, mainly of inconsistent
variable naming.  I gave up trying to rationalize mpol versus pol versus
policy, and node versus nid, but let's avoid p and nd.  Remove a few
superfluous blank lines, but add one; and here prefer vma->vm_policy to
vma_policy(vma) - the latter being appropriate in other sources, which
have to allow for !CONFIG_NUMA.  That intriguing line about KERNEL_DS?
should have gone in v2.6.15, when numa_policy_init() stopped using
set_mempolicy(2)'s system call handler.

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mempolicy.h | 11 +++----
 mm/mempolicy.c            | 73 +++++++++++++++++++----------------------
 2 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 6c2754d7bfed..325b7200c311 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -126,10 +126,9 @@ struct shared_policy {
 
 int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst);
 void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol);
-int mpol_set_shared_policy(struct shared_policy *info,
-				struct vm_area_struct *vma,
-				struct mempolicy *new);
-void mpol_free_shared_policy(struct shared_policy *p);
+int mpol_set_shared_policy(struct shared_policy *sp,
+			   struct vm_area_struct *vma, struct mempolicy *mpol);
+void mpol_free_shared_policy(struct shared_policy *sp);
 struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 					    unsigned long idx);
 
@@ -193,7 +192,7 @@ static inline bool mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	return true;
 }
 
-static inline void mpol_put(struct mempolicy *p)
+static inline void mpol_put(struct mempolicy *pol)
 {
 }
 
@@ -212,7 +211,7 @@ static inline void mpol_shared_policy_init(struct shared_policy *sp,
 {
 }
 
-static inline void mpol_free_shared_policy(struct shared_policy *p)
+static inline void mpol_free_shared_policy(struct shared_policy *sp)
 {
 }
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 780498662b75..c7906a034959 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -25,7 +25,7 @@
  *                to the last. It would be better if bind would truly restrict
  *                the allocation to memory nodes instead
  *
- * preferred       Try a specific node first before normal fallback.
+ * preferred      Try a specific node first before normal fallback.
  *                As a special case NUMA_NO_NODE here means do the allocation
  *                on the local CPU. This is normally identical to default,
  *                but useful to set in a VMA when you have a non default
@@ -52,7 +52,7 @@
  * on systems with highmem kernel lowmem allocation don't get policied.
  * Same with GFP_DMA allocations.
  *
- * For shmfs/tmpfs/hugetlbfs shared memory the policy is shared between
+ * For shmem/tmpfs shared memory the policy is shared between
  * all users and remembered even when nobody has memory mapped.
  */
 
@@ -291,6 +291,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 			return ERR_PTR(-EINVAL);
 	} else if (nodes_empty(*nodes))
 		return ERR_PTR(-EINVAL);
+
 	policy = kmem_cache_alloc(policy_cache, GFP_KERNEL);
 	if (!policy)
 		return ERR_PTR(-ENOMEM);
@@ -303,11 +304,11 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 }
 
 /* Slow path of a mpol destructor. */
-void __mpol_put(struct mempolicy *p)
+void __mpol_put(struct mempolicy *pol)
 {
-	if (!atomic_dec_and_test(&p->refcnt))
+	if (!atomic_dec_and_test(&pol->refcnt))
 		return;
-	kmem_cache_free(policy_cache, p);
+	kmem_cache_free(policy_cache, pol);
 }
 
 static void mpol_rebind_default(struct mempolicy *pol, const nodemask_t *nodes)
@@ -364,7 +365,6 @@ static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
  *
  * Called with task's alloc_lock held.
  */
-
 void mpol_rebind_task(struct task_struct *tsk, const nodemask_t *new)
 {
 	mpol_rebind_policy(tsk->mempolicy, new);
@@ -375,7 +375,6 @@ void mpol_rebind_task(struct task_struct *tsk, const nodemask_t *new)
  *
  * Call holding a reference to mm.  Takes mm->mmap_lock during call.
  */
-
 void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 	struct vm_area_struct *vma;
@@ -757,7 +756,7 @@ queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
  * This must be called with the mmap_lock held for writing.
  */
 static int vma_replace_policy(struct vm_area_struct *vma,
-						struct mempolicy *pol)
+				struct mempolicy *pol)
 {
 	int err;
 	struct mempolicy *old;
@@ -803,7 +802,7 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vmstart = vma->vm_start;
 	}
 
-	if (mpol_equal(vma_policy(vma), new_pol)) {
+	if (mpol_equal(vma->vm_policy, new_pol)) {
 		*prev = vma;
 		return 0;
 	}
@@ -875,18 +874,18 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
  *
  * Called with task's alloc_lock held
  */
-static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
+static void get_policy_nodemask(struct mempolicy *pol, nodemask_t *nodes)
 {
 	nodes_clear(*nodes);
-	if (p == &default_policy)
+	if (pol == &default_policy)
 		return;
 
-	switch (p->mode) {
+	switch (pol->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
-		*nodes = p->nodes;
+		*nodes = pol->nodes;
 		break;
 	case MPOL_LOCAL:
 		/* return empty node mask for local allocation */
@@ -1654,7 +1653,6 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 out_put:
 	put_task_struct(task);
 	goto out;
-
 }
 
 SYSCALL_DEFINE4(migrate_pages, pid_t, pid, unsigned long, maxnode,
@@ -1664,7 +1662,6 @@ SYSCALL_DEFINE4(migrate_pages, pid_t, pid, unsigned long, maxnode,
 	return kernel_migrate_pages(pid, maxnode, old_nodes, new_nodes);
 }
 
-
 /* Retrieve NUMA policy */
 static int kernel_get_mempolicy(int __user *policy,
 				unsigned long __user *nmask,
@@ -1847,10 +1844,10 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
  * policy_node() is always coupled with policy_nodemask(), which
  * secures the nodemask limit for 'bind' and 'prefer-many' policy.
  */
-static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
+static int policy_node(gfp_t gfp, struct mempolicy *policy, int nid)
 {
 	if (policy->mode == MPOL_PREFERRED) {
-		nd = first_node(policy->nodes);
+		nid = first_node(policy->nodes);
 	} else {
 		/*
 		 * __GFP_THISNODE shouldn't even be used with the bind policy
@@ -1865,19 +1862,18 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 	    policy->home_node != NUMA_NO_NODE)
 		return policy->home_node;
 
-	return nd;
+	return nid;
 }
 
 /* Do dynamic interleaving for a process */
-static unsigned interleave_nodes(struct mempolicy *policy)
+static unsigned int interleave_nodes(struct mempolicy *policy)
 {
-	unsigned next;
-	struct task_struct *me = current;
+	unsigned int nid;
 
-	next = next_node_in(me->il_prev, policy->nodes);
-	if (next < MAX_NUMNODES)
-		me->il_prev = next;
-	return next;
+	nid = next_node_in(current->il_prev, policy->nodes);
+	if (nid < MAX_NUMNODES)
+		current->il_prev = nid;
+	return nid;
 }
 
 /*
@@ -2367,7 +2363,7 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 
 int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
 {
-	struct mempolicy *pol = mpol_dup(vma_policy(src));
+	struct mempolicy *pol = mpol_dup(src->vm_policy);
 
 	if (IS_ERR(pol))
 		return PTR_ERR(pol);
@@ -2791,40 +2787,40 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 	}
 }
 
-int mpol_set_shared_policy(struct shared_policy *info,
-			struct vm_area_struct *vma, struct mempolicy *npol)
+int mpol_set_shared_policy(struct shared_policy *sp,
+			struct vm_area_struct *vma, struct mempolicy *pol)
 {
 	int err;
 	struct sp_node *new = NULL;
 	unsigned long sz = vma_pages(vma);
 
-	if (npol) {
-		new = sp_alloc(vma->vm_pgoff, vma->vm_pgoff + sz, npol);
+	if (pol) {
+		new = sp_alloc(vma->vm_pgoff, vma->vm_pgoff + sz, pol);
 		if (!new)
 			return -ENOMEM;
 	}
-	err = shared_policy_replace(info, vma->vm_pgoff, vma->vm_pgoff+sz, new);
+	err = shared_policy_replace(sp, vma->vm_pgoff, vma->vm_pgoff + sz, new);
 	if (err && new)
 		sp_free(new);
 	return err;
 }
 
 /* Free a backing policy store on inode delete. */
-void mpol_free_shared_policy(struct shared_policy *p)
+void mpol_free_shared_policy(struct shared_policy *sp)
 {
 	struct sp_node *n;
 	struct rb_node *next;
 
-	if (!p->root.rb_node)
+	if (!sp->root.rb_node)
 		return;
-	write_lock(&p->lock);
-	next = rb_first(&p->root);
+	write_lock(&sp->lock);
+	next = rb_first(&sp->root);
 	while (next) {
 		n = rb_entry(next, struct sp_node, nd);
 		next = rb_next(&n->nd);
-		sp_delete(p, n);
+		sp_delete(sp, n);
 	}
-	write_unlock(&p->lock);
+	write_unlock(&sp->lock);
 }
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -2874,7 +2870,6 @@ static inline void __init check_numabalancing_enable(void)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-/* assumes fs == KERNEL_DS */
 void __init numa_policy_init(void)
 {
 	nodemask_t interleave_nodes;
@@ -2937,7 +2932,6 @@ void numa_default_policy(void)
 /*
  * Parse and format mempolicy from/to strings
  */
-
 static const char * const policy_modes[] =
 {
 	[MPOL_DEFAULT]    = "default",
@@ -2948,7 +2942,6 @@ static const char * const policy_modes[] =
 	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
 
-
 #ifdef CONFIG_TMPFS
 /**
  * mpol_parse_str - parse string to mempolicy, for tmpfs mpol mount option.
-- 
2.35.3

