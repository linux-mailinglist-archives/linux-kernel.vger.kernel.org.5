Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA29775E4C0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 22:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjGWULu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 16:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGWULs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 16:11:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DE0DD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 13:11:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 158ED60E99
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 20:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6E2C433C7;
        Sun, 23 Jul 2023 20:11:41 +0000 (UTC)
Date:   Sun, 23 Jul 2023 16:11:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen Lin <chen.lin5@zte.com.cn>,
        Mohamed Khalfella <mkhalfella@purestorage.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [GIT PULL]  tracing: Fixes for 6.5-rc2
Message-ID: <20230723161139.6cb7cf27@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

Tracing fixes for 6.5-rc2:

- Swapping the ring buffer for snapshotting (for things like irqsoff)
  can crash if the ring buffer is being resized. Disable swapping
  when this happens. The missed swap will be reported to the tracer.

- Report error if the histogram fails to be created due to an error in
  adding a histogram variable, in event_hist_trigger_parse().

- Remove unused declaration of tracing_map_set_field_descr().

Chen Lin (1):
      ring-buffer: Do not swap cpu_buffer during resize process

Mohamed Khalfella (1):
      tracing/histograms: Return an error if we fail to add histogram to hist_vars list

YueHaibing (1):
      tracing: Remove unused extern declaration tracing_map_set_field_descr()


Please pull the latest trace-v6.5-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.5-rc2

Tag SHA1: 218beaa268ad6d7a398e8d0bde08a33ea280da3d
Head SHA1: 4b8b3905165ef98386a3c06f196c85d21292d029


Chen Lin (1):
      ring-buffer: Do not swap cpu_buffer during resize process

Mohamed Khalfella (1):
      tracing/histograms: Return an error if we fail to add histogram to hist_vars list

YueHaibing (1):
      tracing: Remove unused extern declaration tracing_map_set_field_descr()

----
 kernel/trace/ring_buffer.c       | 14 +++++++++++++-
 kernel/trace/trace.c             |  3 ++-
 kernel/trace/trace_events_hist.c |  3 ++-
 kernel/trace/tracing_map.h       |  4 ----
 4 files changed, 17 insertions(+), 7 deletions(-)
---------------------------
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 14d8001140c8..de061dd47313 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -536,6 +536,7 @@ struct trace_buffer {
 	unsigned			flags;
 	int				cpus;
 	atomic_t			record_disabled;
+	atomic_t			resizing;
 	cpumask_var_t			cpumask;
 
 	struct lock_class_key		*reader_lock_key;
@@ -2167,7 +2168,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 
 	/* prevent another thread from changing buffer sizes */
 	mutex_lock(&buffer->mutex);
-
+	atomic_inc(&buffer->resizing);
 
 	if (cpu_id == RING_BUFFER_ALL_CPUS) {
 		/*
@@ -2322,6 +2323,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		atomic_dec(&buffer->record_disabled);
 	}
 
+	atomic_dec(&buffer->resizing);
 	mutex_unlock(&buffer->mutex);
 	return 0;
 
@@ -2342,6 +2344,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		}
 	}
  out_err_unlock:
+	atomic_dec(&buffer->resizing);
 	mutex_unlock(&buffer->mutex);
 	return err;
 }
@@ -5541,6 +5544,15 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	if (local_read(&cpu_buffer_b->committing))
 		goto out_dec;
 
+	/*
+	 * When resize is in progress, we cannot swap it because
+	 * it will mess the state of the cpu buffer.
+	 */
+	if (atomic_read(&buffer_a->resizing))
+		goto out_dec;
+	if (atomic_read(&buffer_b->resizing))
+		goto out_dec;
+
 	buffer_a->buffers[cpu] = cpu_buffer_b;
 	buffer_b->buffers[cpu] = cpu_buffer_a;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index be847d45d81c..b8870078ef58 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1928,9 +1928,10 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 		 * place on this CPU. We fail to record, but we reset
 		 * the max trace buffer (no one writes directly to it)
 		 * and flag that it failed.
+		 * Another reason is resize is in progress.
 		 */
 		trace_array_printk_buf(tr->max_buffer.buffer, _THIS_IP_,
-			"Failed to swap buffers due to commit in progress\n");
+			"Failed to swap buffers due to commit or resize in progress\n");
 	}
 
 	WARN_ON_ONCE(ret && ret != -EAGAIN && ret != -EBUSY);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c8c61381eba4..d06938ae0717 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6668,7 +6668,8 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		goto out_unreg;
 
 	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
-		if (save_hist_vars(hist_data))
+		ret = save_hist_vars(hist_data);
+		if (ret)
 			goto out_unreg;
 	}
 
diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index 2c765ee2a4d4..99c37eeebc16 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -272,10 +272,6 @@ extern u64 tracing_map_read_sum(struct tracing_map_elt *elt, unsigned int i);
 extern u64 tracing_map_read_var(struct tracing_map_elt *elt, unsigned int i);
 extern u64 tracing_map_read_var_once(struct tracing_map_elt *elt, unsigned int i);
 
-extern void tracing_map_set_field_descr(struct tracing_map *map,
-					unsigned int i,
-					unsigned int key_offset,
-					tracing_map_cmp_fn_t cmp_fn);
 extern int
 tracing_map_sort_entries(struct tracing_map *map,
 			 struct tracing_map_sort_key *sort_keys,
