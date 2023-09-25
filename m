Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734B27AD37B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjIYIge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjIYIgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:36:31 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BDBAF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:36:25 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d8673a90f56so3127963276.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695630984; x=1696235784; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OU+65snbrvpR+Q3ulaNy8J1cYx1gkkm9B2VLdfzl674=;
        b=ua6Fhr0pbpKnRPggu3qgJu7o4SR8jVlEu/g22x22zuduOmCYVTIkrjJmC/r6pE/04Z
         n272kMRGZYS3vxpULjLZYT4N0JzOjPaZ2GQ8H/3Ys4vbAc/acyO+eD0q3+RzIk7TCfQB
         mTIqAjA/9Y1vkCJ9vhfX4WkE1v7sm/kzDlGOel2gGcLms1Rj7AYssafxcW8xHOtHUbYE
         ip8cZJp9mGu9P9IgNPB43ynJLZHc3nqtSRt0PytpcepfW658W1m/58f/piLLluurSZkl
         Zlo3eNqhlH2EDpPc2UnoLKSxPpJoA2yDEAGb/p9APTHeVMjKIxePwKVI9rEz9Rn1HxV2
         Eo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695630984; x=1696235784;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OU+65snbrvpR+Q3ulaNy8J1cYx1gkkm9B2VLdfzl674=;
        b=UejHUIMdGkaNglbnRcO0TS96c+er3lATTtNcv/iwf0Ezg/6HRDpA/j1Zxnh6N7J5QW
         XYWYQzewW8NXdkcxaRGTNZwWsNNHOgbbi4+abBGeEnYYYJD17x7lTJjqXGtsM3uz5Brc
         8TzUC6jSUjVjuYdUjHGmnq7XEyJzi7RhjpaI5atOSegrGM7ICx6lRPAtHMWjJ4+pLv4z
         HRjPCkggdzldfvQONQBcJtQsPVrgZYUSpohYTeXIJiSvSC/vnRTScSmxRttg6v5e7vf7
         66636pV/9zzTzXYGfr9lN1KFkcgF3plNNbIIlntTKArY/AWqb6ZOiFJBPRbGzi9potnw
         evAw==
X-Gm-Message-State: AOJu0YyZfxPXDp6qNSb+j+SlSDyk1m4DhV5GQpreuZp2eiiqQy2TVJW/
        rfZhqiF55iDVLh9GBVPgV+e5yQ==
X-Google-Smtp-Source: AGHT+IHXAX1QQV6PVx66keFoYyD4CtYdpXj+z0LhxW9OnhchJFVwm0d282m2rz466G2xal6CpuLvhA==
X-Received: by 2002:a25:c092:0:b0:d53:f98f:8018 with SMTP id c140-20020a25c092000000b00d53f98f8018mr5028309ybf.65.1695630984516;
        Mon, 25 Sep 2023 01:36:24 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m17-20020a258011000000b00d85abbdc93esm2014417ybk.12.2023.09.25.01.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:36:23 -0700 (PDT)
Date:   Mon, 25 Sep 2023 01:36:21 -0700 (PDT)
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
Subject: [PATCH 12/12] mempolicy: migration attempt to match interleave
 nodes
In-Reply-To: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
Message-ID: <21a2895b-4590-a0f4-c81c-67e059494583@google.com>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve alloc_migration_target_by_mpol()'s treatment of MPOL_INTERLEAVE.

Make an effort in do_mbind(), to identify the correct interleave index
for the first page to be migrated, so that it and all subsequent pages
from the same vma will be targeted to precisely their intended nodes.
Pages from following vmas will still be interleaved from the requested
nodemask, but perhaps starting from a different base.

Whether this is worth doing at all, or worth improving further, is
arguable: queue_folio_required() is right not to care about the precise
placement on interleaved nodes; but this little effort seems appropriate.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/mempolicy.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 74b1894d29c1..7bb9ff69879b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -430,6 +430,11 @@ static bool strictly_unmovable(unsigned long flags)
 			 MPOL_MF_STRICT;
 }
 
+struct migration_mpol {		/* for alloc_migration_target_by_mpol() */
+	struct mempolicy *pol;
+	pgoff_t ilx;
+};
+
 struct queue_pages {
 	struct list_head *pagelist;
 	unsigned long flags;
@@ -1175,8 +1180,9 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 						    unsigned long private)
 {
-	struct mempolicy *pol = (struct mempolicy *)private;
-	pgoff_t ilx = 0;	/* improve on this later */
+	struct migration_mpol *mmpol = (struct migration_mpol *)private;
+	struct mempolicy *pol = mmpol->pol;
+	pgoff_t ilx = mmpol->ilx;
 	struct page *page;
 	unsigned int order;
 	int nid = numa_node_id();
@@ -1231,6 +1237,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
 	struct vma_iterator vmi;
+	struct migration_mpol mmpol;
 	struct mempolicy *new;
 	unsigned long end;
 	long err;
@@ -1311,9 +1318,48 @@ static long do_mbind(unsigned long start, unsigned long len,
 			new = get_task_policy(current);
 			mpol_get(new);
 		}
+		mmpol.pol = new;
+		mmpol.ilx = 0;
+
+		/*
+		 * In the interleaved case, attempt to allocate on exactly the
+		 * targeted nodes, for the first VMA to be migrated; for later
+		 * VMAs, the nodes will still be interleaved from the targeted
+		 * nodemask, but one by one may be selected differently.
+		 */
+		if (new->mode == MPOL_INTERLEAVE) {
+			struct page *page;
+			unsigned int order;
+			unsigned long addr = -EFAULT;
+
+			list_for_each_entry(page, &pagelist, lru) {
+				if (!PageKsm(page))
+					break;
+			}
+			if (!list_entry_is_head(page, &pagelist, lru)) {
+				vma_iter_init(&vmi, mm, start);
+				for_each_vma_range(vmi, vma, end) {
+					addr = page_address_in_vma(page, vma);
+					if (addr != -EFAULT)
+						break;
+				}
+			}
+			if (addr != -EFAULT) {
+				order = compound_order(page);
+				/* We already know the pol, but not the ilx */
+				mpol_cond_put(get_vma_policy(vma, addr, order,
+							     &mmpol.ilx));
+				/* HugeTLBfs indexes in hpage_size */
+				if (order && PageHuge(page))
+					order = 0;
+				/* Set base from which to increment by index */
+				mmpol.ilx -= page->index >> order;
+			}
+		}
+
 		nr_failed |= migrate_pages(&pagelist,
 				alloc_migration_target_by_mpol, NULL,
-				(unsigned long)new, MIGRATE_SYNC,
+				(unsigned long)&mmpol, MIGRATE_SYNC,
 				MR_MEMPOLICY_MBIND, NULL);
 	}
 
-- 
2.35.3

