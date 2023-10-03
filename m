Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC567B6538
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjJCJP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjJCJPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:15:24 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F57AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:15:19 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59c268676a9so8601177b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696324519; x=1696929319; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwYZSOOB/glvz2EnW/qnimnVXLIQ+wJ0Ri+lf09J6gI=;
        b=OnZFZ40Azgj3uWjlyJMTLvLXYlxokqrNuXf+bhobnWBUVAfcXDn78w24FTdLCn/7WH
         yKQ5JEcuiKlonNiOl7rJiFODJeflZEINrcKG7B10BHqifAJaRNLc+9kzPowPSqFD2Wmz
         qRlgt96bzNoom+QD74fwSo5alglnbFuFprHeZrRlA8vQMubH+3oGNtSeyjv2jEODUMFp
         qoqLkpuJ0XX4f1FEPdPWXcZLtT0PhpLnwTkAPhvVWPB9Xb0aUi0hJEbQ0+ZDu4qTvYwZ
         nzOB/aoqMxEm9+ctSuimi4NQvWJE0bzsR3LmpG0RTYOht7LHQzGOkthmp//S5kwgUZY4
         tA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696324519; x=1696929319;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwYZSOOB/glvz2EnW/qnimnVXLIQ+wJ0Ri+lf09J6gI=;
        b=gmVMnZPDwbOe2z+n74rJhSmnddksScwh7U3VXke6TBaP2Gh5tMaQMBcjBu4kRH64/a
         Ccs606GH0c/gSQOkUuEL83O/QxppdkmXSXgNYgn9swuFqXYrvJYDF2aHwvcWdqYo9DWQ
         avN9UdcLqiQ3g5PcHpw3tVg8gmZr6xd4PyOioxUig6gb2O5T5k39tmaVHntJQFeo/wzF
         hR0e6DiK9U7EsDSao8UGyJwu9HV3qgKERZ2DkBK0Vt1ixRjnNAP6pfcCNEdFC+UeAEnq
         0E0AJf5h9tgso8B73ID6Jzj+vQElJJkT5kIji4/DNSvKJKZ2NVUEo1XBDrmea4kcRdhr
         1OaA==
X-Gm-Message-State: AOJu0YycllyLtB3qKeeEjd68BffeGmY05NbcasdITmAxA4irv2jkMahz
        uOm2A1Sz0+mDBaww03Z/Yt7eCw==
X-Google-Smtp-Source: AGHT+IHGzltakHVdO+OL/afC9cmnMy82Tb0Z7wP4Wxec5m1WelVAghemXtF1xjfUCVDqbZcaUXYemA==
X-Received: by 2002:a81:8907:0:b0:59b:518a:639c with SMTP id z7-20020a818907000000b0059b518a639cmr14262844ywf.36.1696324518906;
        Tue, 03 Oct 2023 02:15:18 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m131-20020a817189000000b005950e1bbf11sm244244ywc.60.2023.10.03.02.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:15:18 -0700 (PDT)
Date:   Tue, 3 Oct 2023 02:15:09 -0700 (PDT)
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
Subject: [PATCH v2 01/12] hugetlbfs: drop shared NUMA mempolicy pretence
In-Reply-To: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
Message-ID: <cae82d4b-904a-faaf-282a-34fcc188c81f@google.com>
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

hugetlbfs_fallocate() goes through the motions of pasting a shared NUMA
mempolicy onto its pseudo-vma, but how could there ever be a shared NUMA
mempolicy for this file?  hugetlb_vm_ops has never offered a set_policy
method, and hugetlbfs_parse_param() has never supported any mpol options
for a mount-wide default policy.

It's just an illusion: clean it away so as not to confuse others, giving
us more freedom to adjust shmem's set_policy/get_policy implementation.
But hugetlbfs_inode_info is still required, just to accommodate seals.

Yes, shared NUMA mempolicy support could be added to hugetlbfs, with a
set_policy method and/or mpol mount option (Andi's first posting did
include an admitted-unsatisfactory hugetlb_set_policy()); but it seems
that nobody has bothered to add that in the nineteen years since v2.6.7
made it possible, and there is at least one company that has invested
enough into hugetlbfs, that I guess they have learnt well enough how to
manage its NUMA, without needing shared mempolicy.

Remove linux/mempolicy.h from linux/hugetlb.h: include linux/pagemap.h in
its place, because hugetlb.h's recently added use of filemap_lock_folio()
requires that (although most .configs and .c's get it in some other way).

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hugetlbfs/inode.c    | 41 +----------------------------------------
 include/linux/hugetlb.h |  3 +--
 2 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 926d01c493fb..0586c90cb9a5 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -83,29 +83,6 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
 	{}
 };
 
-#ifdef CONFIG_NUMA
-static inline void hugetlb_set_vma_policy(struct vm_area_struct *vma,
-					struct inode *inode, pgoff_t index)
-{
-	vma->vm_policy = mpol_shared_policy_lookup(&HUGETLBFS_I(inode)->policy,
-							index);
-}
-
-static inline void hugetlb_drop_vma_policy(struct vm_area_struct *vma)
-{
-	mpol_cond_put(vma->vm_policy);
-}
-#else
-static inline void hugetlb_set_vma_policy(struct vm_area_struct *vma,
-					struct inode *inode, pgoff_t index)
-{
-}
-
-static inline void hugetlb_drop_vma_policy(struct vm_area_struct *vma)
-{
-}
-#endif
-
 /*
  * Mask used when checking the page offset value passed in via system
  * calls.  This value will be converted to a loff_t which is signed.
@@ -853,8 +830,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
 	/*
 	 * Initialize a pseudo vma as this is required by the huge page
-	 * allocation routines.  If NUMA is configured, use page index
-	 * as input to create an allocation policy.
+	 * allocation routines.
 	 */
 	vma_init(&pseudo_vma, mm);
 	vm_flags_init(&pseudo_vma, VM_HUGETLB | VM_MAYSHARE | VM_SHARED);
@@ -902,9 +878,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 * folios in these areas, we need to consume the reserves
 		 * to keep reservation accounting consistent.
 		 */
-		hugetlb_set_vma_policy(&pseudo_vma, inode, index);
 		folio = alloc_hugetlb_folio(&pseudo_vma, addr, 0);
-		hugetlb_drop_vma_policy(&pseudo_vma);
 		if (IS_ERR(folio)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			error = PTR_ERR(folio);
@@ -1283,18 +1257,6 @@ static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
 		hugetlbfs_inc_free_inodes(sbinfo);
 		return NULL;
 	}
-
-	/*
-	 * Any time after allocation, hugetlbfs_destroy_inode can be called
-	 * for the inode.  mpol_free_shared_policy is unconditionally called
-	 * as part of hugetlbfs_destroy_inode.  So, initialize policy here
-	 * in case of a quick call to destroy.
-	 *
-	 * Note that the policy is initialized even if we are creating a
-	 * private inode.  This simplifies hugetlbfs_destroy_inode.
-	 */
-	mpol_shared_policy_init(&p->policy, NULL);
-
 	return &p->vfs_inode;
 }
 
@@ -1306,7 +1268,6 @@ static void hugetlbfs_free_inode(struct inode *inode)
 static void hugetlbfs_destroy_inode(struct inode *inode)
 {
 	hugetlbfs_inc_free_inodes(HUGETLBFS_SB(inode->i_sb));
-	mpol_free_shared_policy(&HUGETLBFS_I(inode)->policy);
 }
 
 static const struct address_space_operations hugetlbfs_aops = {
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3c4427a2396d..a574e26e18a2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -30,7 +30,7 @@ void free_huge_folio(struct folio *folio);
 
 #ifdef CONFIG_HUGETLB_PAGE
 
-#include <linux/mempolicy.h>
+#include <linux/pagemap.h>
 #include <linux/shm.h>
 #include <asm/tlbflush.h>
 
@@ -513,7 +513,6 @@ static inline struct hugetlbfs_sb_info *HUGETLBFS_SB(struct super_block *sb)
 }
 
 struct hugetlbfs_inode_info {
-	struct shared_policy policy;
 	struct inode vfs_inode;
 	unsigned int seals;
 };
-- 
2.35.3

