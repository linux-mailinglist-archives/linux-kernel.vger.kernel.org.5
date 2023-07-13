Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7207516DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjGMDpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjGMDpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D6D1FFD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2208D61919
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADE8C433C7;
        Thu, 13 Jul 2023 03:45:04 +0000 (UTC)
Date:   Wed, 12 Jul 2023 23:45:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Florent Revest <revest@chromium.org>,
        Mohamed Khalfella <mkhalfella@purestorage.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [GIT PULL v2] tracing: Fixes for v6.5-rc1
Message-ID: <20230712234502.3c6eb43d@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes and clean ups:

- Fix some missing-prototype warnings

- Fix user events struct args (did not include size of struct)
  When creating a user event, the "struct" keyword is to denote
  that the size of the field will be passed in. But the parsing
  failed to handle this case.

- Add selftest to struct sizes for user events

- Fix sample code for direct trampolines.
  The sample code for direct trampolines attached to handle_mm_fault().
  But the prototype changed and the direct trampoline sample code
  was not updated. Direct trampolines needs to have the arguments correct
  otherwise it can fail or crash the system.

- Remove unused ftrace_regs_caller_ret() prototype.

- Quiet false positive of FORTIFY_SOURCE
  Due to backward compatibility, the structure used to save stack traces
  in the kernel had a fixed size of 8. This structure is exported to
  user space via the tracing format file. A change was made to allow
  more than 8 functions to be recorded, and user space now uses the
  size field to know how many functions are actually in the stack.
  But the structure still has size of 8 (even though it points into
  the ring buffer that has the required amount allocated to hold a
  full stack. This was fine until the fortifier noticed that the
  memcpy(&entry->caller, stack, size) was greater than the 8 functions
  and would complain at runtime about it. Hide this by using a pointer
  to the stack location on the ring buffer instead of using the address
  of the entry structure caller field.

- Fix a deadloop in reading trace_pipe that was caused by a mismatch
  between ring_buffer_empty() returning false which then asked to
  read the data, but the read code uses rb_num_of_entries() that
  returned zero, and causing a infinite "retry".

- Fix a warning caused by not using all pages allocated to store
  ftrace functions, where this can happen if the linker inserts a bunch of
  "NULL" entries, causing the accounting of how many pages needed
  to be off.

- Fix histogram synthetic event crashing when the start event is
  removed and the end event is still using a variable from it.


Please pull the latest trace-v6.5-rc1-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.5-rc1-2

Tag SHA1: e4442d1b2035213b9e982c9fc4d222c360162190
Head SHA1: 6018b585e8c6fa7d85d4b38d9ce49a5b67be7078


Arnd Bergmann (1):
      tracing: arm64: Avoid missing-prototype warnings

Beau Belgrave (2):
      tracing/user_events: Fix struct arg size match check
      selftests/user_events: Test struct size match cases

Florent Revest (2):
      samples: ftrace: Save required argument registers in sample trampolines
      arm64: ftrace: Add direct call trampoline samples support

Mohamed Khalfella (1):
      tracing/histograms: Add histograms to hist_vars if they have referenced variables

Steven Rostedt (Google) (1):
      tracing: Stop FORTIFY_SOURCE complaining about stack trace caller

YueHaibing (1):
      x86/ftrace: Remove unsued extern declaration ftrace_regs_caller_ret()

Zheng Yejian (2):
      ring-buffer: Fix deadloop issue on reading trace_pipe
      ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()

----
 arch/arm64/Kconfig                             |  2 ++
 arch/arm64/include/asm/ftrace.h                |  4 +++
 arch/arm64/include/asm/syscall.h               |  3 ++
 arch/arm64/kernel/syscall.c                    |  3 --
 arch/x86/kernel/ftrace.c                       |  1 -
 include/linux/ftrace.h                         |  9 ++++++
 kernel/trace/fgraph.c                          |  1 +
 kernel/trace/ftrace.c                          | 45 ++++++++++++++++++--------
 kernel/trace/ftrace_internal.h                 |  5 +--
 kernel/trace/ring_buffer.c                     | 24 ++++++++------
 kernel/trace/trace.c                           | 21 ++++++++++--
 kernel/trace/trace_events_hist.c               |  8 +++--
 kernel/trace/trace_events_user.c               |  3 ++
 kernel/trace/trace_kprobe_selftest.c           |  3 ++
 samples/ftrace/ftrace-direct-modify.c          | 34 +++++++++++++++++++
 samples/ftrace/ftrace-direct-multi-modify.c    | 40 +++++++++++++++++++++++
 samples/ftrace/ftrace-direct-multi.c           | 25 ++++++++++++++
 samples/ftrace/ftrace-direct-too.c             | 40 +++++++++++++++++++----
 samples/ftrace/ftrace-direct.c                 | 24 ++++++++++++++
 tools/testing/selftests/user_events/dyn_test.c | 12 +++++++
 20 files changed, 267 insertions(+), 40 deletions(-)
---------------------------
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7856c3a3e35a..a2511b30d0f6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -197,6 +197,8 @@ config ARM64
 		    !CC_OPTIMIZE_FOR_SIZE)
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
 		if DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_SAMPLE_FTRACE_DIRECT
+	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 21ac1c5c71d3..ab158196480c 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -211,6 +211,10 @@ static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs
 {
 	return ret_regs->fp;
 }
+
+void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
+			   unsigned long frame_pointer);
+
 #endif /* ifdef CONFIG_FUNCTION_GRAPH_TRACER  */
 #endif
 
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 4cfe9b49709b..ab8e14b96f68 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -85,4 +85,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_AARCH64;
 }
 
+int syscall_trace_enter(struct pt_regs *regs);
+void syscall_trace_exit(struct pt_regs *regs);
+
 #endif	/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 5a668d7f3c1f..b1ae2f2eaf77 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -75,9 +75,6 @@ static inline bool has_syscall_work(unsigned long flags)
 	return unlikely(flags & _TIF_SYSCALL_WORK);
 }
 
-int syscall_trace_enter(struct pt_regs *regs);
-void syscall_trace_exit(struct pt_regs *regs);
-
 static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 			   const syscall_fn_t syscall_table[])
 {
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 01e8f34daf22..12df54ff0e81 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -282,7 +282,6 @@ static inline void tramp_free(void *tramp) { }
 
 /* Defined as markers to the end of the ftrace default trampolines */
 extern void ftrace_regs_caller_end(void);
-extern void ftrace_regs_caller_ret(void);
 extern void ftrace_caller_end(void);
 extern void ftrace_caller_op_ptr(void);
 extern void ftrace_regs_caller_op_ptr(void);
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8e59bd954153..ce156c7704ee 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -41,6 +41,15 @@ struct ftrace_ops;
 struct ftrace_regs;
 struct dyn_ftrace;
 
+char *arch_ftrace_match_adjust(char *str, const char *search);
+
+#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
+struct fgraph_ret_regs;
+unsigned long ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs);
+#else
+unsigned long ftrace_return_to_handler(unsigned long frame_pointer);
+#endif
+
 #ifdef CONFIG_FUNCTION_TRACER
 /*
  * If the arch's mcount caller does not support all of ftrace's
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index cd2c35b1dd8f..c83c005e654e 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -15,6 +15,7 @@
 #include <trace/events/sched.h>
 
 #include "ftrace_internal.h"
+#include "trace.h"
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 #define ASSIGN_OPS_HASH(opsname, val) \
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3740aca79fe7..05c0024815bf 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3305,6 +3305,22 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 	return cnt;
 }
 
+static void ftrace_free_pages(struct ftrace_page *pages)
+{
+	struct ftrace_page *pg = pages;
+
+	while (pg) {
+		if (pg->records) {
+			free_pages((unsigned long)pg->records, pg->order);
+			ftrace_number_of_pages -= 1 << pg->order;
+		}
+		pages = pg->next;
+		kfree(pg);
+		pg = pages;
+		ftrace_number_of_groups--;
+	}
+}
+
 static struct ftrace_page *
 ftrace_allocate_pages(unsigned long num_to_init)
 {
@@ -3343,17 +3359,7 @@ ftrace_allocate_pages(unsigned long num_to_init)
 	return start_pg;
 
  free_pages:
-	pg = start_pg;
-	while (pg) {
-		if (pg->records) {
-			free_pages((unsigned long)pg->records, pg->order);
-			ftrace_number_of_pages -= 1 << pg->order;
-		}
-		start_pg = pg->next;
-		kfree(pg);
-		pg = start_pg;
-		ftrace_number_of_groups--;
-	}
+	ftrace_free_pages(start_pg);
 	pr_info("ftrace: FAILED to allocate memory for functions\n");
 	return NULL;
 }
@@ -6471,9 +6477,11 @@ static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
 {
+	struct ftrace_page *pg_unuse = NULL;
 	struct ftrace_page *start_pg;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
+	unsigned long skipped = 0;
 	unsigned long count;
 	unsigned long *p;
 	unsigned long addr;
@@ -6536,8 +6544,10 @@ static int ftrace_process_locs(struct module *mod,
 		 * object files to satisfy alignments.
 		 * Skip any NULL pointers.
 		 */
-		if (!addr)
+		if (!addr) {
+			skipped++;
 			continue;
+		}
 
 		end_offset = (pg->index+1) * sizeof(pg->records[0]);
 		if (end_offset > PAGE_SIZE << pg->order) {
@@ -6551,8 +6561,10 @@ static int ftrace_process_locs(struct module *mod,
 		rec->ip = addr;
 	}
 
-	/* We should have used all pages */
-	WARN_ON(pg->next);
+	if (pg->next) {
+		pg_unuse = pg->next;
+		pg->next = NULL;
+	}
 
 	/* Assign the last page to ftrace_pages */
 	ftrace_pages = pg;
@@ -6574,6 +6586,11 @@ static int ftrace_process_locs(struct module *mod,
  out:
 	mutex_unlock(&ftrace_lock);
 
+	/* We should have used all pages unless we skipped some */
+	if (pg_unuse) {
+		WARN_ON(!skipped);
+		ftrace_free_pages(pg_unuse);
+	}
 	return ret;
 }
 
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 382775edf690..5012c04f92c0 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -2,6 +2,9 @@
 #ifndef _LINUX_KERNEL_FTRACE_INTERNAL_H
 #define  _LINUX_KERNEL_FTRACE_INTERNAL_H
 
+int __register_ftrace_function(struct ftrace_ops *ops);
+int __unregister_ftrace_function(struct ftrace_ops *ops);
+
 #ifdef CONFIG_FUNCTION_TRACER
 
 extern struct mutex ftrace_lock;
@@ -15,8 +18,6 @@ int ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs);
 
 #else /* !CONFIG_DYNAMIC_FTRACE */
 
-int __register_ftrace_function(struct ftrace_ops *ops);
-int __unregister_ftrace_function(struct ftrace_ops *ops);
 /* Keep as macros so we do not need to define the commands */
 # define ftrace_startup(ops, command)					\
 	({								\
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
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4529e264cb86..20122eeccf97 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3118,6 +3118,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 	struct ftrace_stack *fstack;
 	struct stack_entry *entry;
 	int stackidx;
+	void *ptr;
 
 	/*
 	 * Add one, for this function and the call to save_stack_trace()
@@ -3161,9 +3162,25 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 				    trace_ctx);
 	if (!event)
 		goto out;
-	entry = ring_buffer_event_data(event);
+	ptr = ring_buffer_event_data(event);
+	entry = ptr;
+
+	/*
+	 * For backward compatibility reasons, the entry->caller is an
+	 * array of 8 slots to store the stack. This is also exported
+	 * to user space. The amount allocated on the ring buffer actually
+	 * holds enough for the stack specified by nr_entries. This will
+	 * go into the location of entry->caller. Due to string fortifiers
+	 * checking the size of the destination of memcpy() it triggers
+	 * when it detects that size is greater than 8. To hide this from
+	 * the fortifiers, we use "ptr" and pointer arithmetic to assign caller.
+	 *
+	 * The below is really just:
+	 *   memcpy(&entry->caller, fstack->calls, size);
+	 */
+	ptr += offsetof(typeof(*entry), caller);
+	memcpy(ptr, fstack->calls, size);
 
-	memcpy(&entry->caller, fstack->calls, size);
 	entry->size = nr_entries;
 
 	if (!call_filter_check_discard(call, entry, buffer, event))
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index b97d3ad832f1..c8c61381eba4 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6663,13 +6663,15 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	if (get_named_trigger_data(trigger_data))
 		goto enable;
 
-	if (has_hist_vars(hist_data))
-		save_hist_vars(hist_data);
-
 	ret = create_actions(hist_data);
 	if (ret)
 		goto out_unreg;
 
+	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
+		if (save_hist_vars(hist_data))
+			goto out_unreg;
+	}
+
 	ret = tracing_map_init(hist_data->map);
 	if (ret)
 		goto out_unreg;
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 4f5e74bbdab2..33cb6af31f39 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1317,6 +1317,9 @@ static int user_field_set_string(struct ftrace_event_field *field,
 	pos += snprintf(buf + pos, LEN_OR_ZERO, " ");
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "%s", field->name);
 
+	if (str_has_prefix(field->type, "struct "))
+		pos += snprintf(buf + pos, LEN_OR_ZERO, " %d", field->size);
+
 	if (colon)
 		pos += snprintf(buf + pos, LEN_OR_ZERO, ";");
 
diff --git a/kernel/trace/trace_kprobe_selftest.c b/kernel/trace/trace_kprobe_selftest.c
index 16548ee4c8c6..3851cd1e6a62 100644
--- a/kernel/trace/trace_kprobe_selftest.c
+++ b/kernel/trace/trace_kprobe_selftest.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include "trace_kprobe_selftest.h"
+
 /*
  * Function used during the kprobe self test. This function is in a separate
  * compile unit so it can be compile with CC_FLAGS_FTRACE to ensure that it
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 06d889149012..e5ed08098ff3 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -2,7 +2,9 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
+#endif
 
 extern void my_direct_func1(void);
 extern void my_direct_func2(void);
@@ -96,6 +98,38 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:"
+"	bti	c\n"
+"	sub	sp, sp, #16\n"
+"	stp	x9, x30, [sp]\n"
+"	bl	my_direct_func1\n"
+"	ldp	x30, x9, [sp]\n"
+"	add	sp, sp, #16\n"
+"	ret	x9\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:"
+"	bti	c\n"
+"	sub	sp, sp, #16\n"
+"	stp	x9, x30, [sp]\n"
+"	bl	my_direct_func2\n"
+"	ldp	x30, x9, [sp]\n"
+"	add	sp, sp, #16\n"
+"	ret	x9\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_ARM64 */
+
 #ifdef CONFIG_LOONGARCH
 
 asm (
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 62f6b681999e..292cff2b3f5d 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -2,7 +2,9 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
+#endif
 
 extern void my_direct_func1(unsigned long ip);
 extern void my_direct_func2(unsigned long ip);
@@ -103,6 +105,44 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:"
+"	bti	c\n"
+"	sub	sp, sp, #32\n"
+"	stp	x9, x30, [sp]\n"
+"	str	x0, [sp, #16]\n"
+"	mov	x0, x30\n"
+"	bl	my_direct_func1\n"
+"	ldp	x30, x9, [sp]\n"
+"	ldr	x0, [sp, #16]\n"
+"	add	sp, sp, #32\n"
+"	ret	x9\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:"
+"	bti	c\n"
+"	sub	sp, sp, #32\n"
+"	stp	x9, x30, [sp]\n"
+"	str	x0, [sp, #16]\n"
+"	mov	x0, x30\n"
+"	bl	my_direct_func2\n"
+"	ldp	x30, x9, [sp]\n"
+"	ldr	x0, [sp, #16]\n"
+"	add	sp, sp, #32\n"
+"	ret	x9\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_ARM64 */
+
 #ifdef CONFIG_LOONGARCH
 #include <asm/asm.h>
 
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 5482cf616b43..b4391e08c913 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -4,7 +4,9 @@
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
 #include <linux/sched/stat.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
+#endif
 
 extern void my_direct_func(unsigned long ip);
 
@@ -66,6 +68,29 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	bti	c\n"
+"	sub	sp, sp, #32\n"
+"	stp	x9, x30, [sp]\n"
+"	str	x0, [sp, #16]\n"
+"	mov	x0, x30\n"
+"	bl	my_direct_func\n"
+"	ldp	x30, x9, [sp]\n"
+"	ldr	x0, [sp, #16]\n"
+"	add	sp, sp, #32\n"
+"	ret	x9\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_ARM64 */
+
 #ifdef CONFIG_LOONGARCH
 
 #include <asm/asm.h>
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index a05bc2cc2261..e9804c5307c0 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -3,16 +3,18 @@
 
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
+#endif
 
-extern void my_direct_func(struct vm_area_struct *vma,
-			   unsigned long address, unsigned int flags);
+extern void my_direct_func(struct vm_area_struct *vma, unsigned long address,
+			   unsigned int flags, struct pt_regs *regs);
 
-void my_direct_func(struct vm_area_struct *vma,
-			unsigned long address, unsigned int flags)
+void my_direct_func(struct vm_area_struct *vma, unsigned long address,
+		    unsigned int flags, struct pt_regs *regs)
 {
-	trace_printk("handle mm fault vma=%p address=%lx flags=%x\n",
-		     vma, address, flags);
+	trace_printk("handle mm fault vma=%p address=%lx flags=%x regs=%p\n",
+		     vma, address, flags, regs);
 }
 
 extern void my_tramp(void *);
@@ -34,7 +36,9 @@ asm (
 "	pushq %rdi\n"
 "	pushq %rsi\n"
 "	pushq %rdx\n"
+"	pushq %rcx\n"
 "	call my_direct_func\n"
+"	popq %rcx\n"
 "	popq %rdx\n"
 "	popq %rsi\n"
 "	popq %rdi\n"
@@ -70,6 +74,30 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	bti	c\n"
+"	sub	sp, sp, #48\n"
+"	stp	x9, x30, [sp]\n"
+"	stp	x0, x1, [sp, #16]\n"
+"	stp	x2, x3, [sp, #32]\n"
+"	bl	my_direct_func\n"
+"	ldp	x30, x9, [sp]\n"
+"	ldp	x0, x1, [sp, #16]\n"
+"	ldp	x2, x3, [sp, #32]\n"
+"	add	sp, sp, #48\n"
+"	ret	x9\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_ARM64 */
+
 #ifdef CONFIG_LOONGARCH
 
 asm (
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 06879bbd3399..20f4a7caa810 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -3,7 +3,9 @@
 
 #include <linux/sched.h> /* for wake_up_process() */
 #include <linux/ftrace.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
+#endif
 
 extern void my_direct_func(struct task_struct *p);
 
@@ -63,6 +65,28 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	bti	c\n"
+"	sub	sp, sp, #32\n"
+"	stp	x9, x30, [sp]\n"
+"	str	x0, [sp, #16]\n"
+"	bl	my_direct_func\n"
+"	ldp	x30, x9, [sp]\n"
+"	ldr	x0, [sp, #16]\n"
+"	add	sp, sp, #32\n"
+"	ret	x9\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_ARM64 */
+
 #ifdef CONFIG_LOONGARCH
 
 asm (
diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index d6979a48478f..91a4444ad42b 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -217,6 +217,18 @@ TEST_F(user, matching) {
 	/* Types don't match */
 	TEST_NMATCH("__test_event u64 a; u64 b",
 		    "__test_event u32 a; u32 b");
+
+	/* Struct name and size matches */
+	TEST_MATCH("__test_event struct my_struct a 20",
+		   "__test_event struct my_struct a 20");
+
+	/* Struct name don't match */
+	TEST_NMATCH("__test_event struct my_struct a 20",
+		    "__test_event struct my_struct b 20");
+
+	/* Struct size don't match */
+	TEST_NMATCH("__test_event struct my_struct a 20",
+		    "__test_event struct my_struct a 21");
 }
 
 int main(int argc, char **argv)
