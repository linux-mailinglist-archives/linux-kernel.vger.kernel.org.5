Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED47AD35E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjIYIbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjIYIbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:31:04 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805EB10A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:30:55 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59bf1dde73fso73722417b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695630654; x=1696235454; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ulgX9THEbQN3dQQC629PIbXmK6AWD1UO9BuCeRr1HmQ=;
        b=hAuFfZwGzDzbP92DfXsFO5VvWvyyotdTRX0i+PghfBePGRAZv4PMQ8eh5m8KUenAkL
         7w+9ciXDiU0DP9t0Cv2PGYfQ4NTUWgG7naUhQ8YGrVyle1El3BwdY34AsoDjxqpCZJiQ
         V2upxJ3Kx4bgX2kIwMExNWoAVFEL32/1PQ9OXXHd/GCeXFxweW9P0N72XRwL0mk1prME
         IQSbrDlZcNoh+PGPisual4uY+Erw12fgkjEW1OIWPKdrkjdbT9OxbpmX6Y80r+RDarKd
         rDx0DN04esdCT3FwkSMPJdd2tmXFfGrdp7IB6hM5xFyBZdOJ6bhWjhQU6YvzHvnXCwsK
         idfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695630654; x=1696235454;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulgX9THEbQN3dQQC629PIbXmK6AWD1UO9BuCeRr1HmQ=;
        b=GAHlaIPKsXV7jYGbezsVy5ubraRWMy0wnkxfEmGioeR0UVS/x05h+Ca8pEOAw5u0vM
         VfiOt0wrs57uS9mBPLrqE6flDKXsuelbLEC6rpaK4wdtzdhp42Z763vZMsuIgtnd9Bcq
         1w5uTUFxDSIJOW4QUMDy2ms40NyO1MqqhVmroYl3C0om+XbtZNKrvP7slp/tqNfeCE6y
         CiH6a3WSTbjBd8qNUtGEw7IK21C1VOYou/SnWdWzoUikeM29ER1JMUzJPOQWeSCXGckC
         mPiIN7HJAU4/MlqLwQhiY2or8rLxmQlqmQIe/X6kDMhT9CHNsgFvfKCFHkw8p1Ow9/BL
         HtQA==
X-Gm-Message-State: AOJu0YxCCg/4YxZDrUqq28h4PxmTHa8YjEs3AoFflHVa05sH27M2VzZh
        ULD+Ee3M58QXtkds64PrmQJHTw==
X-Google-Smtp-Source: AGHT+IEGFXRC2nnrJxyRas7mIKt1ska0D212eRm9P7TUFWDSpRyUl8E9tDZ9Nksk92zJ5nQ/VXHlUQ==
X-Received: by 2002:a05:690c:3603:b0:571:11ea:b2dd with SMTP id ft3-20020a05690c360300b0057111eab2ddmr5723589ywb.32.1695630654594;
        Mon, 25 Sep 2023 01:30:54 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j185-20020a816ec2000000b00592236855cesm2259304ywc.61.2023.09.25.01.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:30:53 -0700 (PDT)
Date:   Mon, 25 Sep 2023 01:30:51 -0700 (PDT)
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
Subject: [PATCH 08/12] mempolicy: remove confusing MPOL_MF_LAZY dead code
In-Reply-To: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
Message-ID: <2cb8b08a-a96c-2a61-94dd-4cd51ad0605d@google.com>
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

v3.8 commit b24f53a0bea3 ("mm: mempolicy: Add MPOL_MF_LAZY") introduced
MPOL_MF_LAZY, and included it in the MPOL_MF_VALID flags; but a720094ded8
("mm: mempolicy: Hide MPOL_NOOP and MPOL_MF_LAZY from userspace for now")
immediately removed it from MPOL_MF_VALID flags, pending further review.
"This will need to be revisited", but it has not been reinstated.

The present state is confusing: there is dead code in mm/mempolicy.c to
handle MPOL_MF_LAZY cases which can never occur.  Remove that: it can be
resurrected later if necessary.  But keep the definition of MPOL_MF_LAZY,
which must remain in the UAPI, even though it always fails with EINVAL.

https://lore.kernel.org/linux-mm/1553041659-46787-1-git-send-email-yang.shi@linux.alibaba.com/
links to a previous request to remove MPOL_MF_LAZY.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/uapi/linux/mempolicy.h |  2 +-
 mm/mempolicy.c                 | 18 ------------------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 046d0ccba4cd..a8963f7ef4c2 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -48,7 +48,7 @@ enum {
 #define MPOL_MF_MOVE	 (1<<1)	/* Move pages owned by this process to conform
 				   to policy */
 #define MPOL_MF_MOVE_ALL (1<<2)	/* Move every page to conform to policy */
-#define MPOL_MF_LAZY	 (1<<3)	/* Modifies '_MOVE:  lazy migrate on fault */
+#define MPOL_MF_LAZY	 (1<<3)	/* UNSUPPORTED FLAG: Lazy migrate on fault */
 #define MPOL_MF_INTERNAL (1<<4)	/* Internal flags start here */
 
 #define MPOL_MF_VALID	(MPOL_MF_STRICT   | 	\
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a22b641cfd6b..7ab6102d7da4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -632,12 +632,6 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 
 	return nr_updated;
 }
-#else
-static unsigned long change_prot_numa(struct vm_area_struct *vma,
-			unsigned long addr, unsigned long end)
-{
-	return 0;
-}
 #endif /* CONFIG_NUMA_BALANCING */
 
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
@@ -676,14 +670,6 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 	if (endvma > end)
 		endvma = end;
 
-	if (flags & MPOL_MF_LAZY) {
-		/* Similar to task_numa_work, skip inaccessible VMAs */
-		if (!is_vm_hugetlb_page(vma) && vma_is_accessible(vma) &&
-			!(vma->vm_flags & VM_MIXEDMAP))
-			change_prot_numa(vma, start, endvma);
-		return 1;
-	}
-
 	/*
 	 * Check page nodes, and queue pages to move, in the current vma.
 	 * But if no moving, and no strict checking, the scan can be skipped.
@@ -1271,9 +1257,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
-	if (flags & MPOL_MF_LAZY)
-		new->flags |= MPOL_F_MOF;
-
 	/*
 	 * If we are using the default policy then operation
 	 * on discontinuous address spaces is okay after all
@@ -1318,7 +1301,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 	if (!err) {
 		if (!list_empty(&pagelist)) {
-			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
 			nr_failed |= migrate_pages(&pagelist, new_folio, NULL,
 				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND, NULL);
 		}
-- 
2.35.3

