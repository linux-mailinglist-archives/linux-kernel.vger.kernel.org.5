Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4C77D479F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjJXGo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjJXGo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:44:26 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFFDF9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 23:44:22 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9beb863816so3692711276.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 23:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698129862; x=1698734662; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWkAilm3qKxCzp8T0O3zII3wehqdTtuy7Tj/TdEVfLI=;
        b=afOW5pvi6IxOeWreS3k6+dElC0aPPbXzl44LfwlkQKJag+i5aE37dxTBim87U8+WtH
         qkjOcLb0wI4iaA4mNi0jB4POghkSQoG4CDAVICa6r42Xb0GHABV7bPwqMNkBcgyllmsn
         78UhsPKf/f5wDidNEzKk8kdxvdutrjkN0sDMBvOVhS5i4VGvks/H8E3JTv4PW9A3JQgR
         H4GE7+R5jbBGAH4texZg1VLWqq4v2WiAUiBkVoOONZjVA9Ef7q1mva2kZMZO6YCa47At
         mUHq09/2P9gcITRQ4UtEUuTaeurWZXtEZVomDy27U5207gq5wO7hoekrbGJtUka/ykAg
         Smyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698129862; x=1698734662;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWkAilm3qKxCzp8T0O3zII3wehqdTtuy7Tj/TdEVfLI=;
        b=WkOI5Me/NoxDGP7/fq2o4iqNHU8o3b/PEF2l1g0vVn1N8WbgyYcm3ESyQnVpS9mfRv
         g7/zsINk4ruGgNbIKJPVJYkMHw5pwG90kVVR5xpy2d8eJUoydUvuJFf47ae44wGjXwD3
         UvgB8/TrbhUAPnjW5fhrHQKd1ruDDAPx94HDZcLcoHLmR9lAZqS19X6ficLIR5o4Pasp
         mGcrcmZWTCHn3/4P6lJ+JNuuef+z/KJ+XTyAsXUCa3RmjSgzf26mm1rbCXz4X77OM3kA
         6MhgEOhaldhWl3RRFZ6zLB8dquKYfXdZRAdTeZi61ywWvTS1Yt42pU2OiHmyU82Y9PE1
         TZ1g==
X-Gm-Message-State: AOJu0YwWcrRv/P6x2DIQBCvalh806WR4+yLArfeVAcABUfTW+SFkgoNX
        MCPTUHR394q8viwKeuFHc2NV0Q==
X-Google-Smtp-Source: AGHT+IFRjXjXsGt5DJkxXS0KJojysZ8XeQK/gsibTxLGbsR00Tz1R2O1nDPs/rt5ugs3IqWEGWnc/Q==
X-Received: by 2002:a25:5f09:0:b0:d89:5638:8bb7 with SMTP id t9-20020a255f09000000b00d8956388bb7mr9710375ybb.20.1698129861840;
        Mon, 23 Oct 2023 23:44:21 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a32-20020a25ae20000000b00d7b9fab78bfsm3361396ybj.7.2023.10.23.23.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 23:44:21 -0700 (PDT)
Date:   Mon, 23 Oct 2023 23:44:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
        domenico cerasuolo <mimmocerasuolo@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.co>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmamil.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mempolicy: alloc_pages_mpol() for NUMA policy without vma:
 fix
In-Reply-To: <20231023190555.GA1964810@cmpxchg.org>
Message-ID: <00dc4f56-e623-7c85-29ea-4211e93063f6@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com> <74e34633-6060-f5e3-aee-7040d43f2e93@google.com> <1738368e-bac0-fd11-ed7f-b87142a939fe@google.com> <CAFYChMvWFdHq-OJHBE3DycmGtGmczDOHVGfoSqdvY-BxM2hWyg@mail.gmail.com>
 <20231023105331.311373ed33a0dfe78ddaa9e5@linux-foundation.org> <CAFYChMu9DO7OeXqQmKbfMY-iGKykHB21V8nqjy=tQa+StfDAUQ@mail.gmail.com> <20231023190555.GA1964810@cmpxchg.org>
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
 include/linux/mempolicy.h | 2 ++
 mm/mempolicy.c            | 2 --
 mm/zswap.c                | 7 +++++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 2801d5b0a4e9..dd9ed2ce7fd5 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -17,6 +17,8 @@
 
 struct mm_struct;
 
+#define NO_INTERLEAVE_INDEX (-1UL)	/* use task il_prev for interleaving */
+
 #ifdef CONFIG_NUMA
 
 /*
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

