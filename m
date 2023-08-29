Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAA978CA66
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbjH2RMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbjH2RLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:11:42 -0400
Received: from out-245.mta1.migadu.com (out-245.mta1.migadu.com [95.215.58.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31581B9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:11:37 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693329096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Opt9t2Sh3BPQLxjav3raWw4j3L9ASrpPJpFprr4WIwg=;
        b=FMOUlvJxgMB5WpKRQ7t3KX2aGQnwsNKzQ2ccI31MOspuXDov1WZjg8f3zBxS9aiip16KLg
        QsPLydt7gf0VxZWrz0MHedBxpNNjUHO1AeoE3D3p5RwVNU7SOLfTAhOveTf+35NDZNtujl
        ResgGbrFAGlj6khMSxwabRc53OkvSPc=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 02/15] stackdepot: simplify __stack_depot_save
Date:   Tue, 29 Aug 2023 19:11:12 +0200
Message-Id: <20dbc3376fccf2e7824482f56a75d6670bccd8ff.1693328501.git.andreyknvl@google.com>
In-Reply-To: <cover.1693328501.git.andreyknvl@google.com>
References: <cover.1693328501.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

The retval local variable in __stack_depot_save has the union type
handle_parts, but the function never uses anything but the union's
handle field.

Define retval simply as depot_stack_handle_t to simplify the code.

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

