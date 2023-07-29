Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D5A7680FE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 20:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjG2Se1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 14:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjG2SeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 14:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606EF30FC
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 11:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6D40608C3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 18:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C4FC433C8;
        Sat, 29 Jul 2023 18:34:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qPolh-0035IS-0l;
        Sat, 29 Jul 2023 14:34:21 -0400
Message-ID: <20230729183421.051522156@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 29 Jul 2023 14:33:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <vnagarnaik@google.com>, Zheng Yejian <zhengyejian1@huawei.com>
Subject: [for-linus][PATCH 1/7] ring-buffer: Fix wrong stat of cpu_buffer->read
References: <20230729183333.357029101@goodmis.org>
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

From: Zheng Yejian <zhengyejian1@huawei.com>

When pages are removed in rb_remove_pages(), 'cpu_buffer->read' is set
to 0 in order to make sure any read iterators reset themselves. However,
this will mess 'entries' stating, see following steps:

  # cd /sys/kernel/tracing/
  # 1. Enlarge ring buffer prepare for later reducing:
  # echo 20 > per_cpu/cpu0/buffer_size_kb
  # 2. Write a log into ring buffer of cpu0:
  # taskset -c 0 echo "hello1" > trace_marker
  # 3. Read the log:
  # cat per_cpu/cpu0/trace_pipe
       <...>-332     [000] .....    62.406844: tracing_mark_write: hello1
  # 4. Stop reading and see the stats, now 0 entries, and 1 event readed:
  # cat per_cpu/cpu0/stats
   entries: 0
   [...]
   read events: 1
  # 5. Reduce the ring buffer
  # echo 7 > per_cpu/cpu0/buffer_size_kb
  # 6. Now entries became unexpected 1 because actually no entries!!!
  # cat per_cpu/cpu0/stats
   entries: 1
   [...]
   read events: 0

To fix it, introduce 'page_removed' field to count total removed pages
since last reset, then use it to let read iterators reset themselves
instead of changing the 'read' pointer.

Link: https://lore.kernel.org/linux-trace-kernel/20230724054040.3489499-1-zhengyejian1@huawei.com

Cc: <mhiramat@kernel.org>
Cc: <vnagarnaik@google.com>
Fixes: 83f40318dab0 ("ring-buffer: Make removal of ring buffer pages atomic")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index de061dd47313..46b4a3c7c3bf 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -523,6 +523,8 @@ struct ring_buffer_per_cpu {
 	rb_time_t			before_stamp;
 	u64				event_stamp[MAX_NEST];
 	u64				read_stamp;
+	/* pages removed since last reset */
+	unsigned long			pages_removed;
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -559,6 +561,7 @@ struct ring_buffer_iter {
 	struct buffer_page		*head_page;
 	struct buffer_page		*cache_reader_page;
 	unsigned long			cache_read;
+	unsigned long			cache_pages_removed;
 	u64				read_stamp;
 	u64				page_stamp;
 	struct ring_buffer_event	*event;
@@ -1957,6 +1960,8 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		to_remove = rb_list_head(to_remove)->next;
 		head_bit |= (unsigned long)to_remove & RB_PAGE_HEAD;
 	}
+	/* Read iterators need to reset themselves when some pages removed */
+	cpu_buffer->pages_removed += nr_removed;
 
 	next_page = rb_list_head(to_remove)->next;
 
@@ -1978,12 +1983,6 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		cpu_buffer->head_page = list_entry(next_page,
 						struct buffer_page, list);
 
-	/*
-	 * change read pointer to make sure any read iterators reset
-	 * themselves
-	 */
-	cpu_buffer->read = 0;
-
 	/* pages are removed, resume tracing and then free the pages */
 	atomic_dec(&cpu_buffer->record_disabled);
 	raw_spin_unlock_irq(&cpu_buffer->reader_lock);
@@ -4395,6 +4394,7 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 
 	iter->cache_reader_page = iter->head_page;
 	iter->cache_read = cpu_buffer->read;
+	iter->cache_pages_removed = cpu_buffer->pages_removed;
 
 	if (iter->head) {
 		iter->read_stamp = cpu_buffer->read_stamp;
@@ -4849,12 +4849,13 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	buffer = cpu_buffer->buffer;
 
 	/*
-	 * Check if someone performed a consuming read to
-	 * the buffer. A consuming read invalidates the iterator
-	 * and we need to reset the iterator in this case.
+	 * Check if someone performed a consuming read to the buffer
+	 * or removed some pages from the buffer. In these cases,
+	 * iterator was invalidated and we need to reset it.
 	 */
 	if (unlikely(iter->cache_read != cpu_buffer->read ||
-		     iter->cache_reader_page != cpu_buffer->reader_page))
+		     iter->cache_reader_page != cpu_buffer->reader_page ||
+		     iter->cache_pages_removed != cpu_buffer->pages_removed))
 		rb_iter_reset(iter);
 
  again:
@@ -5298,6 +5299,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->last_overrun = 0;
 
 	rb_head_page_activate(cpu_buffer);
+	cpu_buffer->pages_removed = 0;
 }
 
 /* Must have disabled the cpu buffer then done a synchronize_rcu */
-- 
2.40.1
