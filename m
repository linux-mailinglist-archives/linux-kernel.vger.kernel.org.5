Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870747AD33B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjIYIVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjIYIV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:21:28 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC2F11F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:21:21 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59f4db9e11eso38937797b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695630080; x=1696234880; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=51Cow/pgH6uhDfisazzoiSztYmzsaEmF2Mt51ptIi+M=;
        b=Fuj+wssXVCONsVnYstmMS7XThFL0S0Tmt+vu4YyU7EiirNiWppPOMrpKPXGpJYXW4o
         xFCV0AztEguVLkUi7L3Wrf7TrJqNSXDOdbB0SLBj2S1zOyfjgY6pDkzMtJJ7miPBTIag
         8tsXu1HLX7pW1UglLsjr26fVRMj7yAkTd+Dllz41rQT4QCkvs72dmOBSuQeN1SozU/qO
         adesdkGGLAci3vfVY5egevDIQGto2k1AZfW07ERjCVFyFqgtf+KcNLi0zV7xiVOn7wr8
         XRQohKGGz0o9dqVNPGSXkA5+kk7ArdsEYeFKgP+DuMGuANi8eDz2BWpkjizFwfetXbdn
         UDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695630080; x=1696234880;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51Cow/pgH6uhDfisazzoiSztYmzsaEmF2Mt51ptIi+M=;
        b=YK15mDH9MsR6YIFkXHJgNbeFWzjmBtRaVLMzY1cXsSc6VIHiQq72ZYhvICe2aCKLPT
         Job5Zp+n0wI3+QKxjyY9NLcD6f8KZHe+JKXN/Pgnk6wN7rTXPh0hZJChVtdG1NOmPejL
         /gs3Ru+agdGRXiWrgLAxUZx7hcxZUv1cTaSp1jlepy1Xuaz1tDIoVGEsxVhCqx1OAuA5
         Zg7qFquZ6N5hwRDKHWNPmNNpPifXemQahDRM2tKmkgPZJIyYRjRc2edld9XNUMPXDn8N
         sE+Na6fXQ4Gn+5b1c38XuWoA2M8sPy5QuqcZn+7lwPZh1PeE0+MOhvJBZMqaEtzRQpeb
         urIg==
X-Gm-Message-State: AOJu0YwCCPj5B6CMtMluPrymiblz3XYZa4iCWEFruA3fd9U0lZjnK59d
        WJXoNdoR2i7jXS0fOkiaV4eLyA==
X-Google-Smtp-Source: AGHT+IGr7os4V6FD7A0Dc+N5PVL7LECactrhqyVufW3y5mQ7Ilx2z2M+P22nvGF/P0KFm7TJWuxF3Q==
X-Received: by 2002:a0d:f884:0:b0:59b:dbb7:5c74 with SMTP id i126-20020a0df884000000b0059bdbb75c74mr6123161ywf.32.1695630080347;
        Mon, 25 Sep 2023 01:21:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h67-20020a0dc546000000b00583b144fe51sm2289914ywd.118.2023.09.25.01.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:21:19 -0700 (PDT)
Date:   Mon, 25 Sep 2023 01:21:10 -0700 (PDT)
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
Subject: [PATCH 01/12] hugetlbfs: drop shared NUMA mempolicy pretence
In-Reply-To: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
Message-ID: <47a562a-6998-4dc6-5df-3834d2f2f411@google.com>
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

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/hugetlbfs/inode.c    | 41 +----------------------------------------
 include/linux/hugetlb.h |  2 --
 2 files changed, 1 insertion(+), 42 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 316c4cebd3f3..ffee27b10d42 100644
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
@@ -852,8 +829,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
 	/*
 	 * Initialize a pseudo vma as this is required by the huge page
-	 * allocation routines.  If NUMA is configured, use page index
-	 * as input to create an allocation policy.
+	 * allocation routines.
 	 */
 	vma_init(&pseudo_vma, mm);
 	vm_flags_init(&pseudo_vma, VM_HUGETLB | VM_MAYSHARE | VM_SHARED);
@@ -901,9 +877,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 * folios in these areas, we need to consume the reserves
 		 * to keep reservation accounting consistent.
 		 */
-		hugetlb_set_vma_policy(&pseudo_vma, inode, index);
 		folio = alloc_hugetlb_folio(&pseudo_vma, addr, 0);
-		hugetlb_drop_vma_policy(&pseudo_vma);
 		if (IS_ERR(folio)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			error = PTR_ERR(folio);
@@ -1282,18 +1256,6 @@ static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
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
 
@@ -1305,7 +1267,6 @@ static void hugetlbfs_free_inode(struct inode *inode)
 static void hugetlbfs_destroy_inode(struct inode *inode)
 {
 	hugetlbfs_inc_free_inodes(HUGETLBFS_SB(inode->i_sb));
-	mpol_free_shared_policy(&HUGETLBFS_I(inode)->policy);
 }
 
 static const struct address_space_operations hugetlbfs_aops = {
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5b2626063f4f..6522eb3cd007 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -30,7 +30,6 @@ void free_huge_folio(struct folio *folio);
 
 #ifdef CONFIG_HUGETLB_PAGE
 
-#include <linux/mempolicy.h>
 #include <linux/shm.h>
 #include <asm/tlbflush.h>
 
@@ -512,7 +511,6 @@ static inline struct hugetlbfs_sb_info *HUGETLBFS_SB(struct super_block *sb)
 }
 
 struct hugetlbfs_inode_info {
-	struct shared_policy policy;
 	struct inode vfs_inode;
 	unsigned int seals;
 };
-- 
2.35.3

