Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3576A4AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGaXRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjGaXRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:17:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51971BE7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DAF761353
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C85BC433CC;
        Mon, 31 Jul 2023 23:17:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQc8P-003fKr-1V;
        Mon, 31 Jul 2023 19:17:05 -0400
Message-ID: <20230731231705.275332195@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 19:16:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>
Subject: [for-next][PATCH 02/15] ring_buffer: Use try_cmpxchg instead of cmpxchg
References: <20230731231634.031452225@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uros Bizjak <ubizjak@gmail.com>

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
ring_buffer.c. x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

No functional change intended.

Link: https://lore.kernel.org/linux-trace-kernel/20230714154418.8884-1-ubizjak@gmail.com

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 52dea5dd5362..78502d4c7214 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -692,10 +692,7 @@ static void rb_time_set(rb_time_t *t, u64 val)
 static inline bool
 rb_time_read_cmpxchg(local_t *l, unsigned long expect, unsigned long set)
 {
-	unsigned long ret;
-
-	ret = local_cmpxchg(l, expect, set);
-	return ret == expect;
+	return local_try_cmpxchg(l, &expect, set);
 }
 
 static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
@@ -752,9 +749,7 @@ static void rb_time_set(rb_time_t *t, u64 val)
 
 static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 {
-	u64 val;
-	val = local64_cmpxchg(&t->time, expect, set);
-	return val == expect;
+	return local64_try_cmpxchg(&t->time, &expect, set);
 }
 #endif
 
@@ -1494,14 +1489,11 @@ static bool rb_head_page_replace(struct buffer_page *old,
 {
 	unsigned long *ptr = (unsigned long *)&old->list.prev->next;
 	unsigned long val;
-	unsigned long ret;
 
 	val = *ptr & ~RB_FLAG_MASK;
 	val |= RB_PAGE_HEAD;
 
-	ret = cmpxchg(ptr, val, (unsigned long)&new->list);
-
-	return ret == val;
+	return try_cmpxchg(ptr, &val, (unsigned long)&new->list);
 }
 
 /*
@@ -3003,7 +2995,6 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 {
 	unsigned long new_index, old_index;
 	struct buffer_page *bpage;
-	unsigned long index;
 	unsigned long addr;
 	u64 write_stamp;
 	u64 delta;
@@ -3060,8 +3051,9 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		 */
 		old_index += write_mask;
 		new_index += write_mask;
-		index = local_cmpxchg(&bpage->write, old_index, new_index);
-		if (index == old_index) {
+
+		/* caution: old_index gets updated on cmpxchg failure */
+		if (local_try_cmpxchg(&bpage->write, &old_index, new_index)) {
 			/* update counters */
 			local_sub(event_length, &cpu_buffer->entries_bytes);
 			return true;
-- 
2.40.1
