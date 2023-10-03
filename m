Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100F37B656C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbjJCJY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239647AbjJCJYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:24:25 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F584D8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:24:22 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59e77e4f707so8703087b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696325061; x=1696929861; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ooRbfvgflrDJY0S/ihm6kiwAA3KtmVPaxx1CoMlS90Q=;
        b=fQhXw5qOFrZ+qe5pfcTUSkuk7nURhFWkGQ6lxdt4sX/fzZmHedjnxQAI/8xRJu7ohs
         wEHBzC6oCYe+NvDRiDOCobj3OWG4JaHCzJhdI24oS/BeCOxbsI3bhQ/EWjRp6ogYgrjk
         fL3EDNEXsl/EEG67YYHz+embQVFNVuAqdfbsWI6+iqqWgHD9JiTadqSO58v5fjYuFuRu
         T892yINe2+ADCsL+kGn5GvLU6E7P7aRHp0gcu6/xMsr/QQdMGM3+Y8kIPWgWzfwYrQAF
         skMj7PQm/snd8HKnFlv16jsbbHV45BhdHJWoj9RWrcPsYrbVPC+mhgoTlnZ5evEkHXGl
         7tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696325061; x=1696929861;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooRbfvgflrDJY0S/ihm6kiwAA3KtmVPaxx1CoMlS90Q=;
        b=bKnEPGLK82mgCVkMZggfeiJt7toZ5b016ziUiWiCR13Cm6cnQKOuacXocC8HTh1Rj7
         Z4EGILGL6Tf9El7zOb9Sf5WCBMcyu0gnqHKk6ZKG1cyNwBDgoiNPi515ULHSViP+iIl0
         fIcWXh0aBjReUsb3EtWCCmHwcYtg4iHvFbtNmnQbAp+t9OJMCRJ7ZNF0+ObNGspeWyAO
         haMoLWHlzNUJcar2yJA/7e51jXvRxSpmdaKC0YJFcJBgOltBBdcdmmhQL+Nyk+Bxwsbm
         QCHhTodR6XwC5FKcWXPDht7OfCVzTpviYbEmccx9j2jHmKhKSDln5QbAbaNXTyEhPWze
         19lQ==
X-Gm-Message-State: AOJu0YzmKdkyQXTtGBI8CPTDOTYPSuW9K4y5WaHeyTEWd85q0pQVeR8g
        ZUn4T3uXW5js9jRUkyQyjIRI9A==
X-Google-Smtp-Source: AGHT+IF7dS6FmToNAISxPIKOdrXv16fI38OSw83FP5I+O2/LMzV34kyuZxVB4HUMbC6kZMjwwcoTsQ==
X-Received: by 2002:a81:a08b:0:b0:58f:ae13:462b with SMTP id x133-20020a81a08b000000b0058fae13462bmr14655078ywg.4.1696325061140;
        Tue, 03 Oct 2023 02:24:21 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x9-20020a814a09000000b005463e45458bsm251441ywa.123.2023.10.03.02.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:24:20 -0700 (PDT)
Date:   Tue, 3 Oct 2023 02:24:18 -0700 (PDT)
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
Subject: [PATCH v2 08/12] mempolicy: remove confusing MPOL_MF_LAZY dead
 code
In-Reply-To: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
Message-ID: <80c9665c-1c3f-17ba-21a3-f6115cebf7d@google.com>
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
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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
index 5d99fd5cd60b..f3224a8b0f6c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -636,12 +636,6 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 
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
@@ -680,14 +674,6 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
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
@@ -1274,9 +1260,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
-	if (flags & MPOL_MF_LAZY)
-		new->flags |= MPOL_F_MOF;
-
 	/*
 	 * If we are using the default policy then operation
 	 * on discontinuous address spaces is okay after all
@@ -1321,7 +1304,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 	if (!err) {
 		if (!list_empty(&pagelist)) {
-			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
 			nr_failed |= migrate_pages(&pagelist, new_folio, NULL,
 				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND, NULL);
 		}
-- 
2.35.3

