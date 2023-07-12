Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD33E751321
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjGLWBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjGLWBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:01:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130B21FE3;
        Wed, 12 Jul 2023 15:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A22FD61965;
        Wed, 12 Jul 2023 22:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABF8C433CA;
        Wed, 12 Jul 2023 22:00:58 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qJhtJ-000QjM-1c;
        Wed, 12 Jul 2023 18:00:57 -0400
Message-ID: <20230712220057.311944701@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Jul 2023 17:50:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Zheng Yejian <zhengyejian1@huawei.com>
Subject: [for-linus][PATCH 3/5] ring-buffer: Fix deadloop issue on reading trace_pipe
References: <20230712215044.496021196@goodmis.org>
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

Soft lockup occurs when reading file 'trace_pipe':

  watchdog: BUG: soft lockup - CPU#6 stuck for 22s! [cat:4488]
  [...]
  RIP: 0010:ring_buffer_empty_cpu+0xed/0x170
  RSP: 0018:ffff88810dd6fc48 EFLAGS: 00000246
  RAX: 0000000000000000 RBX: 0000000000000246 RCX: ffffffff93d1aaeb
  RDX: ffff88810a280040 RSI: 0000000000000008 RDI: ffff88811164b218
  RBP: ffff88811164b218 R08: 0000000000000000 R09: ffff88815156600f
  R10: ffffed102a2acc01 R11: 0000000000000001 R12: 0000000051651901
  R13: 0000000000000000 R14: ffff888115e49500 R15: 0000000000000000
  [...]
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f8d853c2000 CR3: 000000010dcd8000 CR4: 00000000000006e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   __find_next_entry+0x1a8/0x4b0
   ? peek_next_entry+0x250/0x250
   ? down_write+0xa5/0x120
   ? down_write_killable+0x130/0x130
   trace_find_next_entry_inc+0x3b/0x1d0
   tracing_read_pipe+0x423/0xae0
   ? tracing_splice_read_pipe+0xcb0/0xcb0
   vfs_read+0x16b/0x490
   ksys_read+0x105/0x210
   ? __ia32_sys_pwrite64+0x200/0x200
   ? switch_fpu_return+0x108/0x220
   do_syscall_64+0x33/0x40
   entry_SYSCALL_64_after_hwframe+0x61/0xc6

Through the vmcore, I found it's because in tracing_read_pipe(),
ring_buffer_empty_cpu() found some buffer is not empty but then it
cannot read anything due to "rb_num_of_entries() == 0" always true,
Then it infinitely loop the procedure due to user buffer not been
filled, see following code path:

  tracing_read_pipe() {
    ... ...
    waitagain:
      tracing_wait_pipe() // 1. find non-empty buffer here
      trace_find_next_entry_inc()  // 2. loop here try to find an entry
        __find_next_entry()
          ring_buffer_empty_cpu();  // 3. find non-empty buffer
          peek_next_entry()  // 4. but peek always return NULL
            ring_buffer_peek()
              rb_buffer_peek()
                rb_get_reader_page()
                  // 5. because rb_num_of_entries() == 0 always true here
                  //    then return NULL
      // 6. user buffer not been filled so goto 'waitgain'
      //    and eventually leads to an deadloop in kernel!!!
  }

By some analyzing, I found that when resetting ringbuffer, the 'entries'
of its pages are not all cleared (see rb_reset_cpu()). Then when reducing
the ringbuffer, and if some reduced pages exist dirty 'entries' data, they
will be added into 'cpu_buffer->overrun' (see rb_remove_pages()), which
cause wrong 'overrun' count and eventually cause the deadloop issue.

To fix it, we need to clear every pages in rb_reset_cpu().

Link: https://lore.kernel.org/linux-trace-kernel/20230708225144.3785600-1-zhengyejian1@huawei.com

Cc: stable@vger.kernel.org
Fixes: a5fb833172eca ("ring-buffer: Fix uninitialized read_stamp")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 834b361a4a66..14d8001140c8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5242,28 +5242,34 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
+static void rb_clear_buffer_page(struct buffer_page *page)
+{
+	local_set(&page->write, 0);
+	local_set(&page->entries, 0);
+	rb_init_page(page->page);
+	page->read = 0;
+}
+
 static void
 rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 {
+	struct buffer_page *page;
+
 	rb_head_page_deactivate(cpu_buffer);
 
 	cpu_buffer->head_page
 		= list_entry(cpu_buffer->pages, struct buffer_page, list);
-	local_set(&cpu_buffer->head_page->write, 0);
-	local_set(&cpu_buffer->head_page->entries, 0);
-	local_set(&cpu_buffer->head_page->page->commit, 0);
-
-	cpu_buffer->head_page->read = 0;
+	rb_clear_buffer_page(cpu_buffer->head_page);
+	list_for_each_entry(page, cpu_buffer->pages, list) {
+		rb_clear_buffer_page(page);
+	}
 
 	cpu_buffer->tail_page = cpu_buffer->head_page;
 	cpu_buffer->commit_page = cpu_buffer->head_page;
 
 	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
 	INIT_LIST_HEAD(&cpu_buffer->new_pages);
-	local_set(&cpu_buffer->reader_page->write, 0);
-	local_set(&cpu_buffer->reader_page->entries, 0);
-	local_set(&cpu_buffer->reader_page->page->commit, 0);
-	cpu_buffer->reader_page->read = 0;
+	rb_clear_buffer_page(cpu_buffer->reader_page);
 
 	local_set(&cpu_buffer->entries_bytes, 0);
 	local_set(&cpu_buffer->overrun, 0);
-- 
2.40.1
