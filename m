Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC557B6579
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbjJCJ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjJCJ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:29:06 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0380890
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:29:04 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d8198ca891fso718862276.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696325343; x=1696930143; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvvp9tOZAm0ZnFPspgZt0Lcdrx1YEcxNfvbw4PaEVR0=;
        b=ZtZrkFL2E3gKWPgFwvtJN5irugGphkYJM3l1JM9chce5X9nwsdAaQaweSjv/KD3rlr
         aufCFAPD3iLna2Qo0Wwga4GLU6fetZFVEeSlM2Ad7sN3Lceu2KGaVV9kiXyUMMw0Ncnl
         wkb4LmLwbghKR2XagSW92Utkxd0Dmqnc1NzR6Aut7mf1eQ1GIVRTegvq4MiJZMWIPauh
         C4iBeTF0R0/a0ZFlDG2PTLO0kH+nD+4w4dg7gwsy+9bImpzn+RyLRhK7iF9ys4TDHoWL
         rD4ObStxgjESS93Gg77ZVD5Vqf1T09AeJEqIN2h2e3wfyVOhOhJcN+ye4s+/ZgkclRXh
         YBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696325343; x=1696930143;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvvp9tOZAm0ZnFPspgZt0Lcdrx1YEcxNfvbw4PaEVR0=;
        b=EV/XoizGSdK1RYyBWaeKGUWt7K/8WU6G1djnEsg2miuHRMuu1wExDhr9GRR4rq8vIa
         Gncz902bac106vNILxeJdd8foFd+bVMtBoxvUqX4EQ166VJzP1HOAhy1Xe+YlmlbEHgp
         ZrXRsRvxRz8byQpBh18NftqAWM8R6a3eAJXSLyLutowITGDUoaD2rw/BY0AlYyhb8gvm
         Pqcked/i8sPc/8tF7kqYHTnvxZ53DchOVHbhq7wBTtPz2mYtsf1G/s5eCZ2jrh+u/zhr
         cCvj105Y04VmpWL4vaC3Isee2cOQ+4MiUvTZzM11XXfS0OqQsBgEr10x9T2k/2Jx9ogK
         IHWQ==
X-Gm-Message-State: AOJu0Yz0deBNob8I6OHA6zWhzzivQWfMO/tbu+FnID4wevxAcHIBNDzS
        nzJkBoV0ngP58BbA8JYlUz3yRw==
X-Google-Smtp-Source: AGHT+IG82Q8rMpJY3BZE97NKeDHGMxciJo3XfpIVLFLHZCNcKqiXapr+aAI39Q2ReaCSAdFAa0T/Yg==
X-Received: by 2002:a25:da4e:0:b0:d7a:d628:f69d with SMTP id n75-20020a25da4e000000b00d7ad628f69dmr13139965ybf.32.1696325343062;
        Tue, 03 Oct 2023 02:29:03 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w196-20020a25c7cd000000b00d1b86efc0ffsm291695ybe.6.2023.10.03.02.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:29:02 -0700 (PDT)
Date:   Tue, 3 Oct 2023 02:29:00 -0700 (PDT)
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
Subject: [PATCH v2 12/12] mempolicy: migration attempt to match interleave
 nodes
In-Reply-To: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
Message-ID: <77954a5-9c9b-1c11-7d5c-3262c01b895f@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
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
 mm/mempolicy.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a7b34b9c00ef..b01922e88548 100644
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
@@ -1178,8 +1183,9 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
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
@@ -1234,6 +1240,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
 	struct vma_iterator vmi;
+	struct migration_mpol mmpol;
 	struct mempolicy *new;
 	unsigned long end;
 	long err;
@@ -1314,9 +1321,45 @@ static long do_mbind(unsigned long start, unsigned long len,
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

