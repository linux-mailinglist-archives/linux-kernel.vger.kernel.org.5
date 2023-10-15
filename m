Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93F07C980C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 07:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjJOFdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 01:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjJOFdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 01:33:32 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A2A2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:33:30 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-57f02eeabcaso2152123eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697348010; x=1697952810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeCI1NwP8+gNkfLZ//g6QG7eHPqu4x99wp4QGWvVdhI=;
        b=ExquvxiQmCxElUhNHw0/9m+nVRxJeJJaPCIrTvajP8D9GjqlQ83Z7WEsQdfswl4ZJN
         P/QV8Nkz3H2rAPzmKE0fO4V21SyoXNE00ddsPmpYHsWHIVQ7kOwwVf+/Isg94ZolL8Oy
         wI7K05ZcmUbQRfB31j1R4jQWXqV1+USAWfXjlPS0xsHpuCE+lrU8NiGeFkhw/hMrwN1C
         0v9+fXUt/ZpEN9iYcCMTLP7EUEMEbTN8Na6mpkRjj0ECaezrsNz2eXTqgwuWLTwDPmaI
         E3YA1EtoIouGCfLpDQSgGiG/Ab/mrW8j9vxZ6QJTy8XPSl9ranO0H33hMr0OeFoq8HcF
         7xNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697348010; x=1697952810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeCI1NwP8+gNkfLZ//g6QG7eHPqu4x99wp4QGWvVdhI=;
        b=HLMjrzBp63q/vsxEaGIAYyy3ubQRGMC4Z1Yz30dEwvlK3fXkwi+eWDYWdlEYYEq0vo
         v68Mp6oVCkwf+UMb4s/Ci+0HSeT8eg6B4zu/iK41xhlkLGtwM+IeZCeqHvae87nfv8/Y
         ifAgSgu/BUzoLIHvp3iUgDiOIChUnHxwGNZBUu4o3EtPp1Dqjft/Nq/Lymc6xTiISqDu
         b60UOmuo2g/l92/9kye/+Js4EliUZwmbrYle6Ga2bkzsw7Hv5CwdxpM6PuxoPV+Pkfyk
         m9GYbgoR3mURjsnyivWvBwGBlbCt7RV8dASLb+PtzvLiC+TjNUwF1oQi3GIi291JuDzU
         b3Cg==
X-Gm-Message-State: AOJu0YwvOiJ9zqGCBwQaEA/AbkZB4tv2BYsUVF1DxG67vz16aEwMx85r
        OuhPyS/J75lym//jePerGUzWgw==
X-Google-Smtp-Source: AGHT+IG6r0kE6RMY8l0gzwHOQxKyVYaEf3zbjZQCgHkq5CE/3d4c6N5/hWMqsYghwdxFLGFVHTRjTw==
X-Received: by 2002:a05:6358:4291:b0:143:8601:54d with SMTP id s17-20020a056358429100b001438601054dmr29481986rwc.2.1697348010175;
        Sat, 14 Oct 2023 22:33:30 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id u22-20020a62ed16000000b00690fe1c928csm16187368pfh.147.2023.10.14.22.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 22:33:29 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v10 4/5] kprobes: freelist.h removed
Date:   Sun, 15 Oct 2023 13:32:50 +0800
Message-Id: <20231015053251.707442-5-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
References: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

