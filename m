Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C567B654B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbjJCJTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjJCJTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:19:06 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0316C90
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:19:04 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a2379a8b69so8495797b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696324743; x=1696929543; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LR8b7je7NOs49VXpiW5eNLJIFvtfHAwACqkCzwughIA=;
        b=AZoRDgPpSCA8aF2yMWzL8A4MDQsAX/kFpelTeHbZhPjWUriYD3cnMqsnWdq+8lsx8T
         jWTpEhiS4icYqfNLLR5ecmTvz3XBvpOYdeYjrMnrR90rkgjHNtV6o/+NwBfVu34g4Mwv
         KEpDK4ijZ/q5Ga7sTm8sG606i/rDYHNlgxipX9o0lBPk7A2OF2pyLi+DqSA5Z0OhfSSU
         RCTwKH6t9JqCApbO3rVGMoSD5aWsjQrKPbVZsNctlPeTIpgsJWd3Xv3jHBgsm6v5DfdH
         uCksOVvkfIkL2P1s1hc1stxwLn5wQ7qPudzOr58MFNRH+EaR7gfO45iEGXxFf1i6fNbJ
         aojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696324743; x=1696929543;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LR8b7je7NOs49VXpiW5eNLJIFvtfHAwACqkCzwughIA=;
        b=FONY8kvH0EKb7+Yx8KOaMrDQpOzCuFcZWTMdCtXrchXzjISLdI8ROadMyUcN+A2x47
         wid9/NeLZZBEYG4mlHjajAvg/8Rzt8qdZGrlHi8r05cJoWO1RvTy2tdHCcwEkye77yI1
         /IQ6e+toa9pfBw2gbOI0qVMz73U7WUaozB+oe+EO06Nd8OalF6kgwMe0CxBERq94BYl7
         gGifGnYMqM5mGejKJ6wQ19Qk8uSSckEVf4kAqsvOFuMjeD/I7uxW0mKeQRD2jFPldczC
         uXERFAvtIiQM/EoH+F2cd6xMySZ1+wi/N2f4z9urtzkv6y539QrjITNwXJLDdFGFnEUS
         cvdQ==
X-Gm-Message-State: AOJu0YybZgLxA94OmrTvqW+8D89+tY+gn+FyzDgoNImovoMWf6cae++n
        XjQHJ5VelltolNXL/kBxGIwTcQ==
X-Google-Smtp-Source: AGHT+IFH85rdPCXOMMxGLSgYctSHwOqC5dIVzsLz9Oex7w6UXQP98Odac2vWY0r35FgWvr6pMI/Gjg==
X-Received: by 2002:a81:a212:0:b0:586:a170:7dbe with SMTP id w18-20020a81a212000000b00586a1707dbemr15010102ywg.13.1696324743080;
        Tue, 03 Oct 2023 02:19:03 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j13-20020a81920d000000b0059f61be458esm245153ywg.82.2023.10.03.02.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:19:02 -0700 (PDT)
Date:   Tue, 3 Oct 2023 02:19:00 -0700 (PDT)
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
Subject: [PATCH v2 04/12] mempolicy trivia: delete those ancient
 pr_debug()s
In-Reply-To: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
Message-ID: <f25135-ffb2-40d8-9577-720772b333@google.com>
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

Delete those ancient pr_debug()s - PDprintk()s in Andi Kleen's original
submission of core NUMA API, and useful when debugging shared mempolicy
lifetime back then, but not used recently.

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/mempolicy.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 752d880dcdf8..780498662b75 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -264,9 +264,6 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 {
 	struct mempolicy *policy;
 
-	pr_debug("setting mode %d flags %d nodes[0] %lx\n",
-		 mode, flags, nodes ? nodes_addr(*nodes)[0] : NUMA_NO_NODE);
-
 	if (mode == MPOL_DEFAULT) {
 		if (nodes && !nodes_empty(*nodes))
 			return ERR_PTR(-EINVAL);
@@ -768,11 +765,6 @@ static int vma_replace_policy(struct vm_area_struct *vma,
 
 	vma_assert_write_locked(vma);
 
-	pr_debug("vma %lx-%lx/%lx vm_ops %p vm_file %p set_policy %p\n",
-		 vma->vm_start, vma->vm_end, vma->vm_pgoff,
-		 vma->vm_ops, vma->vm_file,
-		 vma->vm_ops ? vma->vm_ops->set_policy : NULL);
-
 	new = mpol_dup(pol);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
@@ -1293,10 +1285,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (!new)
 		flags |= MPOL_MF_DISCONTIG_OK;
 
-	pr_debug("mbind %lx-%lx mode:%d flags:%d nodes:%lx\n",
-		 start, start + len, mode, mode_flags,
-		 nmask ? nodes_addr(*nmask)[0] : NUMA_NO_NODE);
-
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
 		lru_cache_disable();
 	{
@@ -2516,8 +2504,6 @@ static void sp_insert(struct shared_policy *sp, struct sp_node *new)
 	}
 	rb_link_node(&new->nd, parent, p);
 	rb_insert_color(&new->nd, &sp->root);
-	pr_debug("inserting %lx-%lx: %d\n", new->start, new->end,
-		 new->policy ? new->policy->mode : 0);
 }
 
 /* Find shared policy intersecting idx */
@@ -2656,7 +2642,6 @@ void mpol_put_task_policy(struct task_struct *task)
 
 static void sp_delete(struct shared_policy *sp, struct sp_node *n)
 {
-	pr_debug("deleting %lx-l%lx\n", n->start, n->end);
 	rb_erase(&n->nd, &sp->root);
 	sp_free(n);
 }
@@ -2813,12 +2798,6 @@ int mpol_set_shared_policy(struct shared_policy *info,
 	struct sp_node *new = NULL;
 	unsigned long sz = vma_pages(vma);
 
-	pr_debug("set_shared_policy %lx sz %lu %d %d %lx\n",
-		 vma->vm_pgoff,
-		 sz, npol ? npol->mode : -1,
-		 npol ? npol->flags : -1,
-		 npol ? nodes_addr(npol->nodes)[0] : NUMA_NO_NODE);
-
 	if (npol) {
 		new = sp_alloc(vma->vm_pgoff, vma->vm_pgoff + sz, npol);
 		if (!new)
-- 
2.35.3

