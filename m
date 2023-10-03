Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425277B6558
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbjJCJVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjJCJVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:21:41 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0652690
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:21:38 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77410032cedso54870485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696324897; x=1696929697; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKEb9Cd3xCSrgbL40B7c6RQSPbdbractxdPzCveSCj4=;
        b=wVEBzCa6TWI1w/l66MYDermvG1lhghYe0MvLeHM41NvjIQ869kXawkgSADOZQI10SQ
         1C6MEI3fRrJo+E/zuB5iY8EzzBicy+bLy6GKsPewlj86KZQVqi1lswt8kKiS+6/3NRR3
         FoiADPOGAuC5suC+uoeMA+uISKXTtS95rx2eNNZwxVE3ON/Hrq5l7hVsKOZAB1qHrJ43
         VyWWb5c60RL5oGP6Mvx2ARLd8MG4KQbxlUc2Urx1xJpA1aTIzmh65d79tG2o41DXQY4H
         cMvv3lgr0PwSpSAD4mgICRiAq7dUIjFLM5cdszkGn5lp8/lQOZXkypF8kZh1JtKahIm/
         /SmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696324897; x=1696929697;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKEb9Cd3xCSrgbL40B7c6RQSPbdbractxdPzCveSCj4=;
        b=AWTM55ZZsAIOkVTl9F3nCSatL95WLXjUzpXRUenCy0oEnwuO6+1IkZrpdlojGdJSAQ
         qy3gXicIv1qGogpVDCv1r4hdUszLWjxe/2imS84vB1RLnm0FSCIu97G54u51nSjXXeQ3
         xIkAan5LNRQLiwJrwMwuKanfYf02Yf1nwYqGUIxBQKB4x2H0tYncfgEoCvc2QP3Zee46
         i54hMzomDGXu321t9KZnMNHwdZbY12ZXbC3Buy/OQz97yLAkkw0hGTnZ/rZnTOe8GKhF
         vfRubRAGwCmCr0JsHKPMagGNAi1hkDexWVU0Oh6fXCe9Iv6dPbH41lZyUO53ZIJDkazg
         ZF3A==
X-Gm-Message-State: AOJu0Yy17ryH3Mu39aUSTFlXlMHHrJDkCGgLQNhMmL4GaAv1Bpxc1FAF
        sS6+NUZ5u1iaU7wqD2joxGUCwA==
X-Google-Smtp-Source: AGHT+IGmyNX1mGOvsxjDJ+VgdVzrziqLJLl2hhCUT+uZ6s1yuT2hqDhi9cPwKTZ3QGcrdlo0VxUawQ==
X-Received: by 2002:a05:620a:95c:b0:774:1d91:e41a with SMTP id w28-20020a05620a095c00b007741d91e41amr13254046qkw.77.1696324897011;
        Tue, 03 Oct 2023 02:21:37 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a14-20020a81bb4e000000b0059be6a5fcffsm247867ywl.44.2023.10.03.02.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:21:36 -0700 (PDT)
Date:   Tue, 3 Oct 2023 02:21:34 -0700 (PDT)
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
Subject: [PATCH v2 06/12] mempolicy trivia: use pgoff_t in shared mempolicy
 tree
In-Reply-To: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
Message-ID: <5451157-3818-4af5-fd2c-5d26a5d1dc53@google.com>
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

Prefer the more explicit "pgoff_t" to "unsigned long" when dealing with
a shared mempolicy tree.  Delete confusing comment about pseudo mm vmas.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/mempolicy.h | 20 +++++++-------------
 mm/mempolicy.c            | 12 ++++++------
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 325b7200c311..c69f9480d5e4 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -107,22 +107,16 @@ static inline bool mpol_equal(struct mempolicy *a, struct mempolicy *b)
 
 /*
  * Tree of shared policies for a shared memory region.
- * Maintain the policies in a pseudo mm that contains vmas. The vmas
- * carry the policy. As a special twist the pseudo mm is indexed in pages, not
- * bytes, so that we can work with shared memory segments bigger than
- * unsigned long.
  */
-
-struct sp_node {
-	struct rb_node nd;
-	unsigned long start, end;
-	struct mempolicy *policy;
-};
-
 struct shared_policy {
 	struct rb_root root;
 	rwlock_t lock;
 };
+struct sp_node {
+	struct rb_node nd;
+	pgoff_t start, end;
+	struct mempolicy *policy;
+};
 
 int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst);
 void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol);
@@ -130,7 +124,7 @@ int mpol_set_shared_policy(struct shared_policy *sp,
 			   struct vm_area_struct *vma, struct mempolicy *mpol);
 void mpol_free_shared_policy(struct shared_policy *sp);
 struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
-					    unsigned long idx);
+					    pgoff_t idx);
 
 struct mempolicy *get_task_policy(struct task_struct *p);
 struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
@@ -216,7 +210,7 @@ static inline void mpol_free_shared_policy(struct shared_policy *sp)
 }
 
 static inline struct mempolicy *
-mpol_shared_policy_lookup(struct shared_policy *sp, unsigned long idx)
+mpol_shared_policy_lookup(struct shared_policy *sp, pgoff_t idx)
 {
 	return NULL;
 }
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index c7906a034959..1d3f9e1ecbb8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2448,8 +2448,8 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
  * lookup first element intersecting start-end.  Caller holds sp->lock for
  * reading or for writing
  */
-static struct sp_node *
-sp_lookup(struct shared_policy *sp, unsigned long start, unsigned long end)
+static struct sp_node *sp_lookup(struct shared_policy *sp,
+					pgoff_t start, pgoff_t end)
 {
 	struct rb_node *n = sp->root.rb_node;
 
@@ -2503,8 +2503,8 @@ static void sp_insert(struct shared_policy *sp, struct sp_node *new)
 }
 
 /* Find shared policy intersecting idx */
-struct mempolicy *
-mpol_shared_policy_lookup(struct shared_policy *sp, unsigned long idx)
+struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
+						pgoff_t idx)
 {
 	struct mempolicy *pol = NULL;
 	struct sp_node *sn;
@@ -2672,8 +2672,8 @@ static struct sp_node *sp_alloc(unsigned long start, unsigned long end,
 }
 
 /* Replace a policy range. */
-static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
-				 unsigned long end, struct sp_node *new)
+static int shared_policy_replace(struct shared_policy *sp, pgoff_t start,
+				 pgoff_t end, struct sp_node *new)
 {
 	struct sp_node *n;
 	struct sp_node *n_new = NULL;
-- 
2.35.3

