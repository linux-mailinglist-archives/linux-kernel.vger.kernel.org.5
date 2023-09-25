Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032937AD347
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjIYIZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjIYIZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:25:19 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916DFA9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:25:13 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59c04237bf2so74011117b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695630313; x=1696235113; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hroENP4HhihHjQySGJW5cTAKXjm0pfkryRKjlEMKAf0=;
        b=YtWrHOkK9mbiVfF5REEHwqN7GeumN0YCqkrxKrJJAFM2M65GeFAYmvVlFPZ2xKKzZ2
         8DN2KwgjNlUXLAJeAT1RYEfeGrbvyXvOj3HaXSen4DF8gfOeEo4oLTjxMkcOwMa/6LNN
         PilrshLtQKPmOrE10wk0jAGdgy36p3i9KUcR5ZVy9dCPW7L8uYFGPyKN7E6Ak4GMBDJK
         b8HPbGdZ0lX0pvQxs4UiQMjqFplI7g6TzD2kLz9abLR4APqFZ273fSH2ADiqYh/z3eGI
         4T7QofA3JqverA+GxOWILjr3/N5mtrKT3blYEtGijJAFwWSBll7qjS86xxOj5kxo9pDa
         fp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695630313; x=1696235113;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hroENP4HhihHjQySGJW5cTAKXjm0pfkryRKjlEMKAf0=;
        b=QN+nloGH2RnPPC69O2FKlKQAikQ87NM03vuc9iptqXvJMWq/GxDPMfJkfSak9hToE1
         Ql4T1vQreWMwrlkhYv+Awk9juRz4G6KipJBbrfL2lNVtXz2S2FO/5P48oygm6nMQB1Bh
         LoAByGnA5z0+5fJWJRu8G0DJyQ/0/djBPw4rhi0jgzHgLAzcMxpk59mF43iffbReF1cg
         ypbZQ75nCnuVFtYbKbIbmLzToJAt9hH96XidhE8cHslRvcd4/d2AMZuF9i5riOLGvTn4
         WmA7RJaucP2xsUux4+nib5KCLqnsOtvtN4/BcpCxlJbYvK0ktWPVIoRKjf84Sv6DOb9H
         YE0A==
X-Gm-Message-State: AOJu0Yy8QOs6ttURTfH2xUjAhnNS/vTd8h1w+BaTybxZUGjmKuku4var
        nKfQO/SPsMYmRZfW4ScFxVFkIA==
X-Google-Smtp-Source: AGHT+IGswZO2h3vhIcg/xM5XdhydTtdSAqCgFDwsheA7+YxiMWnOmcWx3WkqpsQDKBWY2Pxy5ekbXw==
X-Received: by 2002:a05:690c:3603:b0:571:11ea:b2dd with SMTP id ft3-20020a05690c360300b0057111eab2ddmr5712836ywb.32.1695630312698;
        Mon, 25 Sep 2023 01:25:12 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x2-20020a818702000000b005869ca8da8esm2265401ywf.146.2023.09.25.01.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:25:11 -0700 (PDT)
Date:   Mon, 25 Sep 2023 01:25:09 -0700 (PDT)
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
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 04/12] mempolicy trivia: delete those ancient pr_debug()s
In-Reply-To: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
Message-ID: <d16bae78-6731-7c73-ecb4-5099e03f658d@google.com>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
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
---
 mm/mempolicy.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 937386409c28..b2573921b78f 100644
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
@@ -765,11 +762,6 @@ static int vma_replace_policy(struct vm_area_struct *vma,
 
 	vma_assert_write_locked(vma);
 
-	pr_debug("vma %lx-%lx/%lx vm_ops %p vm_file %p set_policy %p\n",
-		 vma->vm_start, vma->vm_end, vma->vm_pgoff,
-		 vma->vm_ops, vma->vm_file,
-		 vma->vm_ops ? vma->vm_ops->set_policy : NULL);
-
 	new = mpol_dup(pol);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
@@ -1290,10 +1282,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (!new)
 		flags |= MPOL_MF_DISCONTIG_OK;
 
-	pr_debug("mbind %lx-%lx mode:%d flags:%d nodes:%lx\n",
-		 start, start + len, mode, mode_flags,
-		 nmask ? nodes_addr(*nmask)[0] : NUMA_NO_NODE);
-
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
 		lru_cache_disable();
 	{
@@ -2511,8 +2499,6 @@ static void sp_insert(struct shared_policy *sp, struct sp_node *new)
 	}
 	rb_link_node(&new->nd, parent, p);
 	rb_insert_color(&new->nd, &sp->root);
-	pr_debug("inserting %lx-%lx: %d\n", new->start, new->end,
-		 new->policy ? new->policy->mode : 0);
 }
 
 /* Find shared policy intersecting idx */
@@ -2649,7 +2635,6 @@ void mpol_put_task_policy(struct task_struct *task)
 
 static void sp_delete(struct shared_policy *sp, struct sp_node *n)
 {
-	pr_debug("deleting %lx-l%lx\n", n->start, n->end);
 	rb_erase(&n->nd, &sp->root);
 	sp_free(n);
 }
@@ -2806,12 +2791,6 @@ int mpol_set_shared_policy(struct shared_policy *info,
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

