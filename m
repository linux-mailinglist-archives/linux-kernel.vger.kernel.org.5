Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4595579F010
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjIMRPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjIMRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:14:59 -0400
Received: from out-228.mta0.migadu.com (out-228.mta0.migadu.com [91.218.175.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A725F19B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:14:54 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694625289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hlykGlfL2an/VgWBLR95t+wE6CpOLlFaVT0cHbSVLN0=;
        b=pRcWYiA4V9DcqOTdN2gLjPxezJ2SlGOHPh1Fz59jRDjJpcStfHaMZtV5oUBDvkHZp9pcN1
        2sU42kzOkV4/EmNirmCx2z3pluIo9R1jBj4CZupNvF1dF6+hUeuhGaZZv4dXI+nj7Z61iS
        xPrZS4MeqQS5+CE7Icb238Gz0TxGYDs=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 02/19] lib/stackdepot: simplify __stack_depot_save
Date:   Wed, 13 Sep 2023 19:14:27 +0200
Message-Id: <3336cf19b8e53ed5449550a085cff9bddec4c873.1694625260.git.andreyknvl@google.com>
In-Reply-To: <cover.1694625260.git.andreyknvl@google.com>
References: <cover.1694625260.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

The retval local variable in __stack_depot_save has the union type
handle_parts, but the function never uses anything but the union's
handle field.

Define retval simply as depot_stack_handle_t to simplify the code.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 3a945c7206f3..0772125efe8a 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -360,7 +360,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					gfp_t alloc_flags, bool can_alloc)
 {
 	struct stack_record *found = NULL, **bucket;
-	union handle_parts retval = { .handle = 0 };
+	depot_stack_handle_t handle = 0;
 	struct page *page = NULL;
 	void *prealloc = NULL;
 	unsigned long flags;
@@ -377,7 +377,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	nr_entries = filter_irq_stacks(entries, nr_entries);
 
 	if (unlikely(nr_entries == 0) || stack_depot_disabled)
-		goto fast_exit;
+		return 0;
 
 	hash = hash_stack(entries, nr_entries);
 	bucket = &stack_table[hash & stack_hash_mask];
@@ -443,9 +443,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		free_pages((unsigned long)prealloc, DEPOT_POOL_ORDER);
 	}
 	if (found)
-		retval.handle = found->handle.handle;
-fast_exit:
-	return retval.handle;
+		handle = found->handle.handle;
+	return handle;
 }
 EXPORT_SYMBOL_GPL(__stack_depot_save);
 
-- 
2.25.1

