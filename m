Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1627AD34E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjIYI20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjIYI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:28:24 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CA9D3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:28:18 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59c215f2f4aso73611007b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695630497; x=1696235297; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ny+Jruw5kljLWGVDgFi/c0BN4bXVfRfudV3E3SL5ba0=;
        b=YJehBPjLRrzsJRRRxYwf5k2fr3z5ZmoQcsUDS7Yt/XX6Q5ZsOznEI/tgaNd1g3+X0r
         RUllEWlxZlWzYbS/SqaaCAP/7qpaV11Kc65h9obAOZqv/mtmVXQ6FbEMRs2gctaucrLA
         C11XFIPvhAUpqJ4ad3s17FV1mZSc2nGKYIVVdn4/WHmqRWTcE6+k308S3dlTQDmPf8HV
         LLzJqT21h6vZnwmBpyIvG2wTIppvcdXQIXav6xAcxd4oEZ8Hh60UAQg8mBWrIVmFGgBG
         Fl1SGnSEUvnJWHtY0mT07kZyF7xb85p9/JAGNT+o1144rjy9VA/DsI43fOL+AxC03Mxy
         eqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695630497; x=1696235297;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ny+Jruw5kljLWGVDgFi/c0BN4bXVfRfudV3E3SL5ba0=;
        b=Wv6snQhmxruoKABYf4NilPhirw7I300GbUpv8BtuvLvAmtiR5a0RIY6mCmu27jS0J3
         tgOO0h2oxMSbHil5KHuLrj6R1/DmxpsOKWMkqPikWzwnCC0mk7pNo16tzpPzFvH/svXL
         tdZWionY5zyfuqGP/1avyso35+lAV1RvbUb6nOi0IbNry3qdaLaBP+48CNRxau3gdDau
         5bgKJ5Q+H351r0tbRtm2TZM06IxtzNQQgRc928tsdu+XYuxz4BgPTsRUblnQOUy0Yh+w
         r80zYEIgw/svH2hIE6jdwrDS/+KQBSVu9UCCeqSpEszu3BqQRvPU7C52mI8wU/xeNFA6
         8LAQ==
X-Gm-Message-State: AOJu0Yy7/mopuarUWw3oMlmrWC4s/DUKue1r80D1dc5gJwlHZnA5dFvC
        7NlEgwW2Yb1JtfY0DsPIUM0TOw==
X-Google-Smtp-Source: AGHT+IH7TByv+2j1g6DH4DUwI+5DujRbEJ2kgtwKlcyesipljkA02KuVspk813qm/mayffaiCSX9vQ==
X-Received: by 2002:a0d:f2c7:0:b0:599:b59f:5280 with SMTP id b190-20020a0df2c7000000b00599b59f5280mr5636415ywf.28.1695630497424;
        Mon, 25 Sep 2023 01:28:17 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x187-20020a81a0c4000000b0058c55d40765sm2270742ywg.106.2023.09.25.01.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:28:16 -0700 (PDT)
Date:   Mon, 25 Sep 2023 01:28:14 -0700 (PDT)
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
Subject: [PATCH 06/12] mempolicy trivia: use pgoff_t in shared mempolicy
 tree
In-Reply-To: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
Message-ID: <d09b9c35-2856-f749-6a13-64dfe6415ef1@google.com>
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

Prefer the more explicit "pgoff_t" to "unsigned long" when dealing with
a shared mempolicy tree.  Delete confusing comment about pseudo mm vmas.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/mempolicy.h | 12 +++---------
 mm/mempolicy.c            |  8 ++++----
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 8013d716dc46..12f7dc74a457 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -107,18 +107,12 @@ static inline bool mpol_equal(struct mempolicy *a, struct mempolicy *b)
 
 /*
  * Tree of shared policies for a shared memory region.
- * Maintain the policies in a pseudo mm that contains vmas. The vmas
- * carry the policy. As a special twist the pseudo mm is indexed in pages, not
- * bytes, so that we can work with shared memory segments bigger than
- * unsigned long.
  */
-
 struct sp_node {
 	struct rb_node nd;
-	unsigned long start, end;
+	pgoff_t start, end;
 	struct mempolicy *policy;
 };
-
 struct shared_policy {
 	struct rb_root root;
 	rwlock_t lock;
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
index 121bb490481b..065e886ec9b6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2444,7 +2444,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
  * reading or for writing
  */
 static struct sp_node *
-sp_lookup(struct shared_policy *sp, unsigned long start, unsigned long end)
+sp_lookup(struct shared_policy *sp, pgoff_t start, pgoff_t end)
 {
 	struct rb_node *n = sp->root.rb_node;
 
@@ -2499,7 +2499,7 @@ static void sp_insert(struct shared_policy *sp, struct sp_node *new)
 
 /* Find shared policy intersecting idx */
 struct mempolicy *
-mpol_shared_policy_lookup(struct shared_policy *sp, unsigned long idx)
+mpol_shared_policy_lookup(struct shared_policy *sp, pgoff_t idx)
 {
 	struct mempolicy *pol = NULL;
 	struct sp_node *sn;
@@ -2665,8 +2665,8 @@ static struct sp_node *sp_alloc(unsigned long start, unsigned long end,
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

