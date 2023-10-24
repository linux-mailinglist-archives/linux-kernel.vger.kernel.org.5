Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC117D577D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344041AbjJXQJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjJXQJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:09:56 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36152D7D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:09:54 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7afd45199so48056157b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698163793; x=1698768593; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9uwebOammgYNOokYzgscdbftdR0pMLZxQ7ReST9beIs=;
        b=xrDdVZEPl66hK7bC1XfxTZe0LV7yfnlWwEF7VPeBCjlH5AqJqAA5dnfJsa92rfMES7
         hV16HfB/fLbvkIRn9MtLyq3txz1O5Wbtzn/B0oFRaR9Kn0L6GlhHUZRlOr1KjaXDIaMX
         Qfs7xwhYVdVCmpLY9at3ElYTs5TWtuSUJGA14geTrLMMu1zrDTkKuXHg+0jA+D3ZsMOw
         vZ3GCIwfEj8YoUY0hyy+bW4p5PSM4UxvVEgm8IIYSgggQrpf+GLnLlGRRoJkCYujBCBK
         iarZUTS+husiAM/Pr5Lg04krJfGpqIHkcHjw9/p+b3VWkrt7/OU4NTpdTlYFICkLJJk9
         7GKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698163793; x=1698768593;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uwebOammgYNOokYzgscdbftdR0pMLZxQ7ReST9beIs=;
        b=Ve580ClGiOjPOHoKoxUdnixXAoiI2GeALG1pGkRZUeV2jqViAcjJIDCww1SK4N2mqT
         d2wC2awmvl0gBw0zHL1THxBKkakdNroUBcaausFRCNk3KkQAln/qHLNN8tHIuU+2m3KL
         b8q+unH8yBP10yIkH3vYt0ZBzSy8+VgK8NR9UPMWRXHrLhph3h5reFlz2pN/JORha9Jj
         k1FMoHci0M9NRZnki1RY1CoBbsJx8CThogCGD4gZzdj7PM4j3K43dFGVyaYRI/0IAZca
         puevN2OYdsiQoVsT3sZwah0ChzJsOoCP+u3IAPdV41hQBzlF/87SfsrKAln6SDsnEMAP
         SBaw==
X-Gm-Message-State: AOJu0YwkYYtGtxPOhckwmQ33tYDJ+qCjW07HkBS6FG7Xy/B2/32G9fOf
        eN0oemYnOsSXXxYxG9NNsnCzRw==
X-Google-Smtp-Source: AGHT+IFYSVPo7yy9HeVbLbMVQ6/aFEFb+qcE4/a5SXXKaSxcMB9+EZkYJQg5qpUHBV1yTvOcAtoRQA==
X-Received: by 2002:a0d:d494:0:b0:5a8:78b0:a9fd with SMTP id w142-20020a0dd494000000b005a878b0a9fdmr13896756ywd.29.1698163793274;
        Tue, 24 Oct 2023 09:09:53 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e6-20020a0df506000000b005837633d9cbsm4117562ywf.64.2023.10.24.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 09:09:52 -0700 (PDT)
Date:   Tue, 24 Oct 2023 09:09:39 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
        domenico cerasuolo <mimmocerasuolo@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmammil.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] mempolicy: alloc_pages_mpol() for NUMA policy without
 vma: fix
In-Reply-To: <00dc4f56-e623-7c85-29ea-4211e93063f6@google.com>
Message-ID: <ea419956-4751-0102-21f7-9c93cb957892@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com> <74e34633-6060-f5e3-aee-7040d43f2e93@google.com> <1738368e-bac0-fd11-ed7f-b87142a939fe@google.com> <CAFYChMvWFdHq-OJHBE3DycmGtGmczDOHVGfoSqdvY-BxM2hWyg@mail.gmail.com>
 <20231023105331.311373ed33a0dfe78ddaa9e5@linux-foundation.org> <CAFYChMu9DO7OeXqQmKbfMY-iGKykHB21V8nqjy=tQa+StfDAUQ@mail.gmail.com> <20231023190555.GA1964810@cmpxchg.org> <00dc4f56-e623-7c85-29ea-4211e93063f6@google.com>
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

mm-unstable commit 48a7bd12d57f ("mempolicy: alloc_pages_mpol() for NUMA
policy without vma") ended read_swap_cache_async() supporting NULL vma -
okay; but missed the NULL mpol being passed to __read_swap_cache_async()
by zswap_writeback_entry() - oops!

Since its other callers all give good mpol, add get_task_policy(current)
there in mm/zswap.c, to produce the same good-enough behaviour as before
(and task policy, acted on in current task, does not require the refcount
to be dup'ed).

But if that policy is (quite reasonably) MPOL_INTERLEAVE, then ilx must
be NO_INTERLEAVE_INDEX rather than 0, to provide the same distribution
as before: move that definition from mempolicy.c to mempolicy.h.

Reported-by: Domenico Cerasuolo <mimmocerasuolo@gmail.com>
Closes: https://lore.kernel.org/linux-mm/74e34633-6060-f5e3-aee-7040d43f2e93@google.com/T/#mf08c877d1884fc7867f9e328cdf02257ff3b3ae9
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Fixes: 48a7bd12d57f ("mempolicy: alloc_pages_mpol() for NUMA policy without vma")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
v2: !CONFIG_NUMA builds with a get_task_policy() added in mempolicy.h

 include/linux/mempolicy.h | 7 +++++++
 mm/mempolicy.c            | 2 --
 mm/zswap.c                | 7 +++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 2801d5b0a4e9..931b118336f4 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -17,6 +17,8 @@
 
 struct mm_struct;
 
+#define NO_INTERLEAVE_INDEX (-1UL)	/* use task il_prev for interleaving */
+
 #ifdef CONFIG_NUMA
 
 /*
@@ -179,6 +181,11 @@ extern bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone);
 
 struct mempolicy {};
 
+static inline struct mempolicy *get_task_policy(struct task_struct *p)
+{
+	return NULL;
+}
+
 static inline bool mpol_equal(struct mempolicy *a, struct mempolicy *b)
 {
 	return true;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 898ee2e3c85b..989293180eb6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -114,8 +114,6 @@
 #define MPOL_MF_INVERT       (MPOL_MF_INTERNAL << 1)	/* Invert check for nodemask */
 #define MPOL_MF_WRLOCK       (MPOL_MF_INTERNAL << 2)	/* Write-lock walked vmas */
 
-#define NO_INTERLEAVE_INDEX (-1UL)
-
 static struct kmem_cache *policy_cache;
 static struct kmem_cache *sn_cache;
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 37d2b1cb2ecb..060857adca76 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -24,6 +24,7 @@
 #include <linux/swap.h>
 #include <linux/crypto.h>
 #include <linux/scatterlist.h>
+#include <linux/mempolicy.h>
 #include <linux/mempool.h>
 #include <linux/zpool.h>
 #include <crypto/acompress.h>
@@ -1057,6 +1058,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 {
 	swp_entry_t swpentry = entry->swpentry;
 	struct page *page;
+	struct mempolicy *mpol;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct zpool *pool = zswap_find_zpool(entry);
@@ -1075,8 +1077,9 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	}
 
 	/* try to allocate swap cache page */
-	page = __read_swap_cache_async(swpentry, GFP_KERNEL, NULL, 0,
-				       &page_was_allocated);
+	mpol = get_task_policy(current);
+	page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
+				NO_INTERLEAVE_INDEX, &page_was_allocated);
 	if (!page) {
 		ret = -ENOMEM;
 		goto fail;
-- 
2.35.3

