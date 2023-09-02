Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656E57907D6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 14:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352159AbjIBMis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 08:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352121AbjIBMis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 08:38:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E95E10E4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 05:38:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A92E9CE23EE
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 12:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC5BC433C8;
        Sat,  2 Sep 2023 12:38:39 +0000 (UTC)
Date:   Sat, 2 Sep 2023 08:38:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Brian Foster <bfoster@redhat.com>,
        Levi Yun <ppbuk5246@gmail.com>,
        Mikhail Kobuk <m.kobuk@ispras.ru>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yu Liao <liaoyu15@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [GIT PULL] tracing: Minor fixes and clean ups for 6.6
Message-ID: <20230902083849.06a23d21@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This is based on the merge commit of the trace-v6.6 tag, as it includes
fixes for both the new code and previous code.

Tracing fixes and clean ups for 6.6:

 - Replace strlcpy() with strscpy()

 - Initialize the pipe cpumask to zero on allocation

 - Use within_module() instead of open coding it

 - Remove extra space in hwlat_detectory/mode output

 - Use LIST_HEAD() instead of open coding it

 - A bunch of clean ups and fixes for the cpumask filter

 - Set local da_mon_##name to static

 - Fix race in snapshot buffer between cpu write and swap


Please pull the latest trace-v6.6-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.6-2

Tag SHA1: 1b18c15b15361394f492e3dfea85ad6e06855ddf
Head SHA1: cbb557ba92f08b945e2cb20b7ab37ef49ab53cdd


Azeem Shaikh (1):
      tracing: Replace strlcpy with strscpy in trace/events/task.h

Brian Foster (1):
      tracing: Zero the pipe cpumask on alloc to avoid spurious -EBUSY

Levi Yun (1):
      ftrace: Use within_module to check rec->ip within specified module.

Mikhail Kobuk (1):
      tracing: Remove extra space at the end of hwlat_detector/mode

Ruan Jinjie (1):
      ftrace: Use LIST_HEAD to initialize clear_hash

Valentin Schneider (4):
      tracing/filters: Fix error-handling of cpulist parsing buffer
      tracing/filters: Fix double-free of struct filter_pred.mask
      tracing/filters: Change parse_pred() cpulist ternary into an if block
      tracing/filters: Fix coding style issues

Yu Liao (1):
      rv: Set variable 'da_mon_##name' to static

Zheng Yejian (1):
      tracing: Fix race issue between cpu buffer write and swap

----
 include/rv/da_monitor.h            |  2 +-
 include/trace/events/task.h        |  2 +-
 kernel/trace/ftrace.c              | 10 +++-------
 kernel/trace/trace.c               | 21 ++++++++++++++-------
 kernel/trace/trace_events_filter.c | 25 +++++++++++++++++++------
 kernel/trace/trace_hwlat.c         |  2 +-
 6 files changed, 39 insertions(+), 23 deletions(-)
---------------------------
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 9eb75683e012..9705b2a98e49 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -262,7 +262,7 @@ static inline void da_monitor_destroy_##name(void)						\
 /*												\
  * per-cpu monitor variables									\
  */												\
-DEFINE_PER_CPU(struct da_monitor, da_mon_##name);						\
+static DEFINE_PER_CPU(struct da_monitor, da_mon_##name);					\
 												\
 /*												\
  * da_get_monitor_##name - return current CPU monitor address					\
diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 64d160930b0d..47b527464d1a 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -47,7 +47,7 @@ TRACE_EVENT(task_rename,
 	TP_fast_assign(
 		__entry->pid = task->pid;
 		memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
-		strlcpy(entry->newcomm, comm, TASK_COMM_LEN);
+		strscpy(entry->newcomm, comm, TASK_COMM_LEN);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 05c0024815bf..8de8bec5f366 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6779,8 +6779,7 @@ void ftrace_release_mod(struct module *mod)
 	last_pg = &ftrace_pages_start;
 	for (pg = ftrace_pages_start; pg; pg = *last_pg) {
 		rec = &pg->records[0];
-		if (within_module_core(rec->ip, mod) ||
-		    within_module_init(rec->ip, mod)) {
+		if (within_module(rec->ip, mod)) {
 			/*
 			 * As core pages are first, the first
 			 * page should never be a module page.
@@ -6852,8 +6851,7 @@ void ftrace_module_enable(struct module *mod)
 		 * not part of this module, then skip this pg,
 		 * which the "break" will do.
 		 */
-		if (!within_module_core(rec->ip, mod) &&
-		    !within_module_init(rec->ip, mod))
+		if (!within_module(rec->ip, mod))
 			break;
 
 		/* Weak functions should still be ignored */
@@ -7142,9 +7140,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	struct dyn_ftrace key;
 	struct ftrace_mod_map *mod_map = NULL;
 	struct ftrace_init_func *func, *func_next;
-	struct list_head clear_hash;
-
-	INIT_LIST_HEAD(&clear_hash);
+	LIST_HEAD(clear_hash);
 
 	key.ip = start;
 	key.flags = end;	/* overload flags, as it is unsigned long */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3e55375f47e0..35783a7baf15 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7599,6 +7599,11 @@ static int tracing_snapshot_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+static void tracing_swap_cpu_buffer(void *tr)
+{
+	update_max_tr_single((struct trace_array *)tr, current, smp_processor_id());
+}
+
 static ssize_t
 tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		       loff_t *ppos)
@@ -7657,13 +7662,15 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			ret = tracing_alloc_snapshot_instance(tr);
 		if (ret < 0)
 			break;
-		local_irq_disable();
 		/* Now, we're going to swap */
-		if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
+		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
+			local_irq_disable();
 			update_max_tr(tr, current, smp_processor_id(), NULL);
-		else
-			update_max_tr_single(tr, current, iter->cpu_file);
-		local_irq_enable();
+			local_irq_enable();
+		} else {
+			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
+						 (void *)tr, 1);
+		}
 		break;
 	default:
 		if (tr->allocated_snapshot) {
@@ -9467,7 +9474,7 @@ static struct trace_array *trace_array_create(const char *name)
 	if (!alloc_cpumask_var(&tr->tracing_cpumask, GFP_KERNEL))
 		goto out_free_tr;
 
-	if (!alloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
 		goto out_free_tr;
 
 	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
@@ -10412,7 +10419,7 @@ __init static int tracer_alloc_buffers(void)
 	if (trace_create_savedcmd() < 0)
 		goto out_free_temp_buffer;
 
-	if (!alloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
 		goto out_free_savedcmd;
 
 	/* TODO: make the number of buffers hot pluggable with CPUS */
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 3a529214a21b..33264e510d16 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1360,7 +1360,7 @@ int filter_assign_type(const char *type)
 			return FILTER_DYN_STRING;
 		if (strstr(type, "cpumask_t"))
 			return FILTER_CPUMASK;
-		}
+	}
 
 	if (strstr(type, "__rel_loc") && strstr(type, "char"))
 		return FILTER_RDYN_STRING;
@@ -1731,7 +1731,9 @@ static int parse_pred(const char *str, void *data,
 		maskstart = i;
 
 		/* Walk the cpulist until closing } */
-		for (; str[i] && str[i] != '}'; i++);
+		for (; str[i] && str[i] != '}'; i++)
+			;
+
 		if (str[i] != '}') {
 			parse_error(pe, FILT_ERR_MISSING_BRACE_CLOSE, pos + i);
 			goto err_free;
@@ -1744,17 +1746,23 @@ static int parse_pred(const char *str, void *data,
 
 		/* Copy the cpulist between { and } */
 		tmp = kmalloc((i - maskstart) + 1, GFP_KERNEL);
-		strscpy(tmp, str + maskstart, (i - maskstart) + 1);
+		if (!tmp)
+			goto err_mem;
 
+		strscpy(tmp, str + maskstart, (i - maskstart) + 1);
 		pred->mask = kzalloc(cpumask_size(), GFP_KERNEL);
-		if (!pred->mask)
+		if (!pred->mask) {
+			kfree(tmp);
 			goto err_mem;
+		}
 
 		/* Now parse it */
 		if (cpulist_parse(tmp, pred->mask)) {
+			kfree(tmp);
 			parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + i);
 			goto err_free;
 		}
+		kfree(tmp);
 
 		/* Move along */
 		i++;
@@ -1767,6 +1775,7 @@ static int parse_pred(const char *str, void *data,
 		if (single) {
 			pred->val = cpumask_first(pred->mask);
 			kfree(pred->mask);
+			pred->mask = NULL;
 		}
 
 		if (field->filter_type == FILTER_CPUMASK) {
@@ -1775,13 +1784,17 @@ static int parse_pred(const char *str, void *data,
 				FILTER_PRED_FN_CPUMASK;
 		} else if (field->filter_type == FILTER_CPU) {
 			if (single) {
-				pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
+				if (pred->op == OP_BAND)
+					pred->op = OP_EQ;
+
 				pred->fn_num = FILTER_PRED_FN_CPU;
 			} else {
 				pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
 			}
 		} else if (single) {
-			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
+			if (pred->op == OP_BAND)
+				pred->op = OP_EQ;
+
 			pred->fn_num = select_comparison_fn(pred->op, field->size, false);
 			if (pred->op == OP_NE)
 				pred->not = 1;
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 2f37a6e68aa9..b791524a6536 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -635,7 +635,7 @@ static int s_mode_show(struct seq_file *s, void *v)
 	else
 		seq_printf(s, "%s", thread_mode_str[mode]);
 
-	if (mode != MODE_MAX)
+	if (mode < MODE_MAX - 1) /* if mode is any but last */
 		seq_puts(s, " ");
 
 	return 0;
