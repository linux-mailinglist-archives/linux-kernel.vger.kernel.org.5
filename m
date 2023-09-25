Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5997AD354
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjIYI3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjIYI3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:29:39 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA26FB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:29:32 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59f4db9e11eso39059217b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695630572; x=1696235372; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HPVWJplZZXmT6NBbA8O4nkrJWg/FlNHzJ5g3rgEWw70=;
        b=O2Ihfwy7PRFZcDJNk8KgiiDn23MAFkJayE6WB6xaZiWlyrOnz3aPQK2SwjfZER7cRl
         fy8oGoOIXtFfMBvbY65yPz5DVtDL7BMeyINTAjPvWpxP1GpLnIlSlehni9/nrP+ZIP75
         8d9R437dkJVc4A2aHkDB7J0w+SBuSsmrohhiMFCKxpJBAjwPs8A51zlwqx+CBZUZZl3C
         NTlpp1vcWbSAvxmOlNyX+NOk/+yn2K9uel1dJDY56Nc3R2nYTCSq1WfzYz7e1HpaChcH
         cqy64aY+nHlQY5bhuX6BuMCYV3icOVwRerjTRkF0sxd6CXNJVliCxXsDotHYAfFa7Bmc
         9IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695630572; x=1696235372;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPVWJplZZXmT6NBbA8O4nkrJWg/FlNHzJ5g3rgEWw70=;
        b=u+hMDWK1A31y1kVxpYDyqFiTJGSP0SYxnhNbuIXFMOiIukZZcpriiXYIp6/HOzkZWJ
         sQVJ2kPE8x15ZJAHCd5S+9wwq+tF/cDf23mxNF99vVvXtxK9eQw4Y0dZxyiHcU7LxdJa
         6B5Mc1G30vBof8PURIIz+bjxTKGgzj552oQvBw5s0q13+yWLC5MVO51InwvlD+4Em96s
         r+dAUXnvB0TR6CpVJ3R+oVGQNgAFvuAjwu6OT7DWSJJjubSxVpqFPFNRZX2iaxW4WkSg
         FRwobXrbC7APqgr+AKAAylGeEzgERHJyaKoPOXHvGDtVI7+pQf2RsN6RJrSJBYTwhqwb
         +v2A==
X-Gm-Message-State: AOJu0YzRnRC3uC3Xva6HxETDlWbjKcYzqzo55HeUNDBKRuJZm8EKg9kz
        9/hiDBKVFlhkqfjOWlGJtlDd3Q==
X-Google-Smtp-Source: AGHT+IHogreXDslqhpyk+Ms3XFo/uXGtPLAXb4cvDc8C5nh9Ehy9UaqEagZCyCvQ6vw015lUH0Gb7A==
X-Received: by 2002:a81:52c9:0:b0:59c:c79:eeee with SMTP id g192-20020a8152c9000000b0059c0c79eeeemr5778750ywb.44.1695630571804;
        Mon, 25 Sep 2023 01:29:31 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c64-20020a0dc143000000b0059a34cfa2a5sm2259385ywd.67.2023.09.25.01.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:29:30 -0700 (PDT)
Date:   Mon, 25 Sep 2023 01:29:28 -0700 (PDT)
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
Subject: [PATCH 07/12] mempolicy: mpol_shared_policy_init() without
 pseudo-vma
In-Reply-To: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
Message-ID: <ea413d84-8b43-91c2-feef-92998bc7c1e2@google.com>
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

mpol_shared_policy_init() does not need to use a pseudo-vma: it can use
sp_alloc() and sp_insert() directly, since the object's shared policy
tree is empty and inaccessible (needing no lock) at get_inode() time.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/mempolicy.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 065e886ec9b6..a22b641cfd6b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2749,7 +2749,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 	rwlock_init(&sp->lock);
 
 	if (mpol) {
-		struct vm_area_struct pvma;
+		struct sp_node *n;
 		struct mempolicy *new;
 		NODEMASK_SCRATCH(scratch);
 
@@ -2766,11 +2766,10 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		if (ret)
 			goto put_new;
 
-		/* Create pseudo-vma that contains just the policy */
-		vma_init(&pvma, NULL);
-		pvma.vm_end = TASK_SIZE;	/* policy covers entire file */
-		mpol_set_shared_policy(sp, &pvma, new); /* adds ref */
-
+		/* alloc node covering entire file; adds ref to new */
+		n = sp_alloc(0, MAX_LFS_FILESIZE >> PAGE_SHIFT, new);
+		if (n)
+			sp_insert(sp, n);
 put_new:
 		mpol_put(new);			/* drop initial ref */
 free_scratch:
-- 
2.35.3

