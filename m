Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5529D792651
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbjIEQG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245224AbjIEBxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:53:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C238CD4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 18:53:29 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1335503a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 18:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693878809; x=1694483609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeCI1NwP8+gNkfLZ//g6QG7eHPqu4x99wp4QGWvVdhI=;
        b=NOx9AcKliZNOePnhEiaoAeWZJglS5Zj/1K2YXz/9Fg4EQk2nDPru3bIpizeRqqOqin
         G9inMTbuHUff7P5qQhD5HPHxYNQle+N26loc/WBRpZjiI4YgplFB9Y1AaStfKuOxM2l7
         BmfCEozjeqY+Izqf5d3Ab1JJ8F647qLIvu1JDeDSseTBeAcSz6Z0lWyHRtUj9okAs/H6
         8UnFut9fi0DZ3vVTIJBA+PbnBAPNVCOviCo0IJeNJ+L2C6zVnresm6nPLvVnzhulcFdN
         cf//31qm01CWbQ2irrImEvA3UCSzT2xHZxw28lwrFb+wa9zZeSx+DYZabDmPVxl+yMXR
         nopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693878809; x=1694483609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeCI1NwP8+gNkfLZ//g6QG7eHPqu4x99wp4QGWvVdhI=;
        b=gT7xo5mQ0gKNK7grnF+D/Gf6zYdY0lraYlk8CiDiFC+x5LlDo/19SV8lTVrfpXghYg
         HBWdYW9MoG3JB2IqovEuRamKALb/HX4oBJtvbNVW8MyTSJ5rfKaazf0Gxz0GaurjirUL
         y9QZGi4LmgPMmNnYBZO9HzYAHhfHTWKzgZoXPultF8mpTJWc/D38/B3QO94XwGD5Uxbh
         QJOLxwp0NC7AS84t6R9tz5Z5UL5x8X7ZSru1/nTfJi2f3yyHN/e7xgIqRFi/WU1JUsbQ
         qHFfsPhnVjWoBZ1TPB0gUG1xjvjIul/Iq889HmOfTjz3pSNB8rzmBlTSl1e09HmJ8nUQ
         Eo9A==
X-Gm-Message-State: AOJu0Yw8Pc4zaVk5Dl1v0HK4ArjJ29L6AR/BAMg3EYe3w22PrJP6Jj/2
        h9ZvzLbBnap2jKvRBy97BwgRWg==
X-Google-Smtp-Source: AGHT+IEb+MdC5QmuX1vP1E88PNYHkXtGqyNFHPovzxjNaejFjyx3gru9y+Ck6zxKDFbmkmp/puqYMA==
X-Received: by 2002:a05:6a21:7905:b0:14d:7b6:cf2f with SMTP id bg5-20020a056a21790500b0014d07b6cf2fmr13014056pzc.47.1693878809047;
        Mon, 04 Sep 2023 18:53:29 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78045000000b0064d74808738sm7910483pfm.214.2023.09.04.18.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 18:53:28 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v9 4/5] kprobes: freelist.h removed
Date:   Tue,  5 Sep 2023 09:52:54 +0800
Message-Id: <20230905015255.81545-5-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
References: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will remove freelist.h from kernel source tree, since the
only use cases (kretprobe and rethook) are converted to objpool.

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 include/linux/freelist.h | 129 ---------------------------------------
 1 file changed, 129 deletions(-)
 delete mode 100644 include/linux/freelist.h

diff --git a/include/linux/freelist.h b/include/linux/freelist.h
deleted file mode 100644
index fc1842b96469..000000000000
--- a/include/linux/freelist.h
+++ /dev/null
@@ -1,129 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
-#ifndef FREELIST_H
-#define FREELIST_H
-
-#include <linux/atomic.h>
-
-/*
- * Copyright: cameron@moodycamel.com
- *
- * A simple CAS-based lock-free free list. Not the fastest thing in the world
- * under heavy contention, but simple and correct (assuming nodes are never
- * freed until after the free list is destroyed), and fairly speedy under low
- * contention.
- *
- * Adapted from: https://moodycamel.com/blog/2014/solving-the-aba-problem-for-lock-free-free-lists
- */
-
-struct freelist_node {
-	atomic_t		refs;
-	struct freelist_node	*next;
-};
-
-struct freelist_head {
-	struct freelist_node	*head;
-};
-
-#define REFS_ON_FREELIST 0x80000000
-#define REFS_MASK	 0x7FFFFFFF
-
-static inline void __freelist_add(struct freelist_node *node, struct freelist_head *list)
-{
-	/*
-	 * Since the refcount is zero, and nobody can increase it once it's
-	 * zero (except us, and we run only one copy of this method per node at
-	 * a time, i.e. the single thread case), then we know we can safely
-	 * change the next pointer of the node; however, once the refcount is
-	 * back above zero, then other threads could increase it (happens under
-	 * heavy contention, when the refcount goes to zero in between a load
-	 * and a refcount increment of a node in try_get, then back up to
-	 * something non-zero, then the refcount increment is done by the other
-	 * thread) -- so if the CAS to add the node to the actual list fails,
-	 * decrese the refcount and leave the add operation to the next thread
-	 * who puts the refcount back to zero (which could be us, hence the
-	 * loop).
-	 */
-	struct freelist_node *head = READ_ONCE(list->head);
-
-	for (;;) {
-		WRITE_ONCE(node->next, head);
-		atomic_set_release(&node->refs, 1);
-
-		if (!try_cmpxchg_release(&list->head, &head, node)) {
-			/*
-			 * Hmm, the add failed, but we can only try again when
-			 * the refcount goes back to zero.
-			 */
-			if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) == 1)
-				continue;
-		}
-		return;
-	}
-}
-
-static inline void freelist_add(struct freelist_node *node, struct freelist_head *list)
-{
-	/*
-	 * We know that the should-be-on-freelist bit is 0 at this point, so
-	 * it's safe to set it using a fetch_add.
-	 */
-	if (!atomic_fetch_add_release(REFS_ON_FREELIST, &node->refs)) {
-		/*
-		 * Oh look! We were the last ones referencing this node, and we
-		 * know we want to add it to the free list, so let's do it!
-		 */
-		__freelist_add(node, list);
-	}
-}
-
-static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
-{
-	struct freelist_node *prev, *next, *head = smp_load_acquire(&list->head);
-	unsigned int refs;
-
-	while (head) {
-		prev = head;
-		refs = atomic_read(&head->refs);
-		if ((refs & REFS_MASK) == 0 ||
-		    !atomic_try_cmpxchg_acquire(&head->refs, &refs, refs+1)) {
-			head = smp_load_acquire(&list->head);
-			continue;
-		}
-
-		/*
-		 * Good, reference count has been incremented (it wasn't at
-		 * zero), which means we can read the next and not worry about
-		 * it changing between now and the time we do the CAS.
-		 */
-		next = READ_ONCE(head->next);
-		if (try_cmpxchg_acquire(&list->head, &head, next)) {
-			/*
-			 * Yay, got the node. This means it was on the list,
-			 * which means should-be-on-freelist must be false no
-			 * matter the refcount (because nobody else knows it's
-			 * been taken off yet, it can't have been put back on).
-			 */
-			WARN_ON_ONCE(atomic_read(&head->refs) & REFS_ON_FREELIST);
-
-			/*
-			 * Decrease refcount twice, once for our ref, and once
-			 * for the list's ref.
-			 */
-			atomic_fetch_add(-2, &head->refs);
-
-			return head;
-		}
-
-		/*
-		 * OK, the head must have changed on us, but we still need to decrement
-		 * the refcount we increased.
-		 */
-		refs = atomic_fetch_add(-1, &prev->refs);
-		if (refs == REFS_ON_FREELIST + 1)
-			__freelist_add(prev, list);
-	}
-
-	return NULL;
-}
-
-#endif /* FREELIST_H */
-- 
2.40.1

