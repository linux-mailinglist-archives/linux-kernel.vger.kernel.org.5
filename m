Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4228A76C170
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjHBAUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjHBAUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:20:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD0A2708
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 17:19:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58667d06607so7558327b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 17:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690935595; x=1691540395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oILqqqD951CZa6vFO5lwCGBJV16jZziGq+aTih9CvRM=;
        b=liEq2TRJ6uphA1n1WRctdr12b14csuDNelgmOB3P8uUfovqp001PwMVQtOenzPkHJi
         whIzAspyWYUBqUAPEv0+bxGp/kCYHZiDZCj4aPoXHdFKRGOuA0OAPUxh2lZcKRB9DmY4
         +sVvZ4qnTj42uetZgk1spG0aKDlJUYjhXZPRCghRJr5QNKGlAn8bEhwP4JK0KqRABLaT
         fhKrvbkr8HehDdLCVM2/wiJlQ2zpWgZOa9ODGSx5g36gQV2AuKOzP/RpJ1d7pqrnbT8W
         MmvhG/Y18dFWO4yMQQmXypjHnDfl+eqfjiVHy0xIyI41FCe/pW+Xv7cf+eIVYSkn4fkR
         1ENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690935595; x=1691540395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oILqqqD951CZa6vFO5lwCGBJV16jZziGq+aTih9CvRM=;
        b=AGXm5dCl6AgVsTJTklYLOrI0//3l/o73w8aedFX1KPS18f7OYvFE/O2yx1JGt98ieH
         hwMtJo85qqURtL7zeZ+DcvvfTMfgCgfH8AJVD8DBNWk8iPgsSjjzHBtWT3IqKcLjsBd/
         OjXkGEs93SyabLaGaaxm5MH9t/3+GhHO0so3gEq+oIGtCJepuNZeUflmHhlHglrnrP0v
         4A/JetUgJDIe1xBmXXVoZOFURKfVSCAGuHzspoKxqy97dwjXUODpqLJA4vlQetfZlufL
         vuZ3mmdd845gm/MS9mdM2falVDatHiu/AWWoqjRxT/LrbuEelcNB8r6vR8c8kY6A6znq
         z0Sg==
X-Gm-Message-State: ABy/qLa4JjSok6WajEDP3QvdrqHc2/aiSwKOJy5uGyG0RXG2KcuDcIa2
        LchfKZVVXm0uLsfoaqAoFF5Wefp03qbntWOTsQ==
X-Google-Smtp-Source: APBJJlGVSXTcSf5HWtAwgVhVMNFG4pScdB5810WzB/3elwhK2y7pd9aNX9CzOkX3wIMvukUfcHZ5QeIzWXNdnmzMyw==
X-Received: from kalesh.mtv.corp.google.com ([2620:15c:211:201:aa5f:ff75:318:255])
 (user=kaleshsingh job=sendgmr) by 2002:a81:b301:0:b0:576:fdbe:76b2 with SMTP
 id r1-20020a81b301000000b00576fdbe76b2mr121491ywh.3.1690935595421; Tue, 01
 Aug 2023 17:19:55 -0700 (PDT)
Date:   Tue,  1 Aug 2023 17:19:36 -0700
In-Reply-To: <20230802001938.3913174-1-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20230802001938.3913174-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230802001938.3913174-2-kaleshsingh@google.com>
Subject: [PATCH 2/3] mm-unstable: Multi-gen LRU: Avoid race in inc_min_seq()
From:   Kalesh Singh <kaleshsingh@google.com>
To:     yuzhao@google.com, akpm@linux-foundation.org
Cc:     surenb@google.com, android-mm@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inc_max_seq() will try to inc_min_seq() if nr_gens == MAX_NR_GENS. This
is because the generations are reused (the last oldest now empty
generation will become the next youngest generation).

inc_min_seq() is retried until successful, dropping the lru_lock
and yielding the CPU on each failure, and retaking the lock before
trying again:

        while (!inc_min_seq(lruvec, type, can_swap)) {
                spin_unlock_irq(&lruvec->lru_lock);
                cond_resched();
                spin_lock_irq(&lruvec->lru_lock);
        }

However, the initial condition that required incrementing the min_seq
(nr_gens == MAX_NR_GENS) is not retested. This can change by another
call to inc_max_seq() from run_aging() with force_scan=true from the
debugfs interface.

Since the eviction stalls when the nr_gens == MIN_NR_GENS, avoid
unnecessarily incrementing the min_seq by rechecking the number of
generations before each attempt.

This issue was uncovered in previous discussion on the list by Yu Zhao
and Aneesh Kumar [1].

[1] https://lore.kernel.org/linux-mm/CAOUHufbO7CaVm=xjEb1avDhHVvnC8pJmGyKcFf2iY_dpf+zR3w@mail.gmail.com/

Cc: Yu Zhao <yuzhao@google.com>
Cc: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/vmscan.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 489a4fc7d9b1..6eecd291756c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4439,7 +4439,7 @@ static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_scan)
 	int prev, next;
 	int type, zone;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
-
+restart:
 	spin_lock_irq(&lruvec->lru_lock);
 
 	VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
@@ -4450,11 +4450,12 @@ static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_scan)
 
 		VM_WARN_ON_ONCE(!force_scan && (type == LRU_GEN_FILE || can_swap));
 
-		while (!inc_min_seq(lruvec, type, can_swap)) {
-			spin_unlock_irq(&lruvec->lru_lock);
-			cond_resched();
-			spin_lock_irq(&lruvec->lru_lock);
-		}
+		if (inc_min_seq(lruvec, type, can_swap))
+			continue;
+
+		spin_unlock_irq(&lruvec->lru_lock);
+		cond_resched();
+		goto restart;
 	}
 
 	/*
-- 
2.41.0.255.g8b1d071c50-goog

