Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81307B653E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbjJCJQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjJCJQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:16:36 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8D3A9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:16:32 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a1d0fee86aso8520767b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696324592; x=1696929392; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6szECgvu3nTPHPzEk6DBfoYWo45M6R50iawIs9FUBJg=;
        b=1PDhxzPPHzsD6Urjg+kXaM0DBAlDyXf3oNm9lYy5ypKB1CzPiUY9BJcGdPmMAch3hR
         en/wwPJw/j4IPgO6xmJrDPo0OBUvENSdaqjc8jKvyGQEWa2zT5vpOPIz7sUW6SQi1vK4
         8Nd+Dr9ctVakimyk7nSee2qlmy5tFRL7f5yvP019Iu+uSNth9D7JLZIfrL79iJYCBBc/
         bk9b8PFctVdi1b2+//sMLmhXpIZ7lo3Zixg1VzcpA9F8nGt4RthoCCpa+W54CaWX2eI2
         sDfY3SMbqey6ex6JlaKXE/QYMvRlcx0S8EqjrHxSJf5oa2M7Z18g4wd/SIAEoc2RFQ9K
         WaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696324592; x=1696929392;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6szECgvu3nTPHPzEk6DBfoYWo45M6R50iawIs9FUBJg=;
        b=c8YujxbmzhhkmW3QN8KXTcsfrGNOb4QGrGMC+IPDej2rv2RKNWmR8ekLHnQSdn3la7
         T3eNA/gEXM7BuKxmlMCnxbsDtPc/cEu+7SCAh6OJnI4JeCC40ek4VwOfbOu5jIhiDso/
         mGj5MYTyCeyoAvV8CT5AFitFcjhag+/rH4NDn6P4uTKd7Zqk79PtSfY5Ltyghs6djSrs
         aaJRiS42YTSSp50K4TD0yXZZUgE/q0zGjt/KLUCuknojnF5BR0X7okJcCfN5LSO47EAr
         gm8HDrlB1TH1BcsHLbH6gdOSaECOmLcx1IeKzxrtvNKcWcK6CMiAkOTJyWAgi3+GYeUl
         O8Xw==
X-Gm-Message-State: AOJu0YxXU73Kq81LJsT5CAbWnteA2GdDVKGibVqxPBbnWKbKvvBjLGrE
        15WhUxGt4uoR6FvhyASXRDCURQ==
X-Google-Smtp-Source: AGHT+IF7TKqrMTfEG37/bwFMCSN9pzNnHHphoLkIAInKebAgyaWY8C3y19zZ2lbUvYlV8i48+gNb6Q==
X-Received: by 2002:a0d:ee46:0:b0:5a1:635e:e68 with SMTP id x67-20020a0dee46000000b005a1635e0e68mr11991552ywe.46.1696324591927;
        Tue, 03 Oct 2023 02:16:31 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m14-20020a819c0e000000b00583f8f41cb8sm244237ywa.63.2023.10.03.02.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:16:31 -0700 (PDT)
Date:   Tue, 3 Oct 2023 02:16:29 -0700 (PDT)
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
Subject: [PATCH v2 02/12] kernfs: drop shared NUMA mempolicy hooks
In-Reply-To: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
Message-ID: <302164-a760-4a9e-879b-6870c9b4013@google.com>
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

It seems strange that kernfs should be an outlier with a set_policy and
get_policy in its kernfs_vm_ops.  Ah, it dates back to v2.6.30's commit
095160aee954 ("sysfs: fix some bin_vm_ops errors"), when I had crashed
on powerpc's pci_mmap_legacy_page_range() fallback to shmem_zero_setup().

Well, that was commendably thorough, to give sysfs-bin a set_policy and
get_policy, just to avoid the way it was coded resulting in EINVAL from
mmap when CONFIG_NUMA; but somehow feels a bit over-the-top to me now.

It's easier to say that nobody should expect to manage a shmem object's
shared NUMA mempolicy via some kernfs backdoor to that object: delete
that code (and there's no longer an EINVAL from mmap in the NUMA case).

This then leaves set_policy/get_policy as implemented only by shmem -
though importantly also by SysV SHM, which has to interface with shmem
which implements them, and with SHM_HUGETLB which does not.

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/kernfs/file.c | 49 -------------------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 180906c36f51..aaa76410e550 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -429,60 +429,11 @@ static int kernfs_vma_access(struct vm_area_struct *vma, unsigned long addr,
 	return ret;
 }
 
-#ifdef CONFIG_NUMA
-static int kernfs_vma_set_policy(struct vm_area_struct *vma,
-				 struct mempolicy *new)
-{
-	struct file *file = vma->vm_file;
-	struct kernfs_open_file *of = kernfs_of(file);
-	int ret;
-
-	if (!of->vm_ops)
-		return 0;
-
-	if (!kernfs_get_active(of->kn))
-		return -EINVAL;
-
-	ret = 0;
-	if (of->vm_ops->set_policy)
-		ret = of->vm_ops->set_policy(vma, new);
-
-	kernfs_put_active(of->kn);
-	return ret;
-}
-
-static struct mempolicy *kernfs_vma_get_policy(struct vm_area_struct *vma,
-					       unsigned long addr)
-{
-	struct file *file = vma->vm_file;
-	struct kernfs_open_file *of = kernfs_of(file);
-	struct mempolicy *pol;
-
-	if (!of->vm_ops)
-		return vma->vm_policy;
-
-	if (!kernfs_get_active(of->kn))
-		return vma->vm_policy;
-
-	pol = vma->vm_policy;
-	if (of->vm_ops->get_policy)
-		pol = of->vm_ops->get_policy(vma, addr);
-
-	kernfs_put_active(of->kn);
-	return pol;
-}
-
-#endif
-
 static const struct vm_operations_struct kernfs_vm_ops = {
 	.open		= kernfs_vma_open,
 	.fault		= kernfs_vma_fault,
 	.page_mkwrite	= kernfs_vma_page_mkwrite,
 	.access		= kernfs_vma_access,
-#ifdef CONFIG_NUMA
-	.set_policy	= kernfs_vma_set_policy,
-	.get_policy	= kernfs_vma_get_policy,
-#endif
 };
 
 static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
-- 
2.35.3

