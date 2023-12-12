Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F2F80DFEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345450AbjLLAOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345415AbjLLAOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:14:05 -0500
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [IPv6:2001:41d0:203:375::ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EFCAD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:14:11 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702340049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4Cn8Rdft153TNfaMCqmpUoRbUij/xgpu9Ka1HxHDYI=;
        b=UvkDjF/5ctTo0nGnQabktnmBPXGfus3/X3idORYN6B4D44rXq0KJToDsQKy9BeHFX8qw7b
        qQCY+W0sZZweOoacCTj/1cWItkpd82s9p4KPKbjHROXaD7+UwOj6FNmJAKaJ2G1O+XKX3R
        d6piyZ++vR5FIz/37yANY5B0lerp6zk=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        syzbot+186b55175d8360728234@syzkaller.appspotmail.com
Subject: [PATCH mm 2/4] kasan: handle concurrent kasan_record_aux_stack calls
Date:   Tue, 12 Dec 2023 01:14:01 +0100
Message-Id: <432a89fafce11244287c8af757e73a2eb22a5354.1702339432.git.andreyknvl@google.com>
In-Reply-To: <cover.1702339432.git.andreyknvl@google.com>
References: <cover.1702339432.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

kasan_record_aux_stack can be called concurrently on the same object.
This might lead to a race condition when rotating the saved aux stack
trace handles.

Fix by introducing a spinlock to protect the aux stack trace handles
in kasan_record_aux_stack.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: syzbot+186b55175d8360728234@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000784b1c060b0074a2@google.com/
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

This can be squashed into "kasan: use stack_depot_put for Generic mode"
or left standalone.
---
 mm/kasan/generic.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 54e20b2bc3e1..ca5c75a1866c 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/stackdepot.h>
 #include <linux/stacktrace.h>
 #include <linux/string.h>
@@ -35,6 +36,8 @@
 #include "kasan.h"
 #include "../slab.h"
 
+DEFINE_SPINLOCK(aux_lock);
+
 /*
  * All functions below always inlined so compiler could
  * perform better optimizations in each of __asan_loadX/__assn_storeX
@@ -502,6 +505,8 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
 	struct kmem_cache *cache;
 	struct kasan_alloc_meta *alloc_meta;
 	void *object;
+	depot_stack_handle_t new_handle, old_handle;
+	unsigned long flags;
 
 	if (is_kfence_address(addr) || !slab)
 		return;
@@ -512,9 +517,15 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
 	if (!alloc_meta)
 		return;
 
-	stack_depot_put(alloc_meta->aux_stack[1]);
+	new_handle = kasan_save_stack(0, depot_flags);
+
+	spin_lock_irqsave(&aux_lock, flags);
+	old_handle = alloc_meta->aux_stack[1];
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
-	alloc_meta->aux_stack[0] = kasan_save_stack(0, depot_flags);
+	alloc_meta->aux_stack[0] = new_handle;
+	spin_unlock_irqrestore(&aux_lock, flags);
+
+	stack_depot_put(old_handle);
 }
 
 void kasan_record_aux_stack(void *addr)
-- 
2.25.1

