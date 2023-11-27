Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6037FA430
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjK0PNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjK0PND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:13:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23718AA;
        Mon, 27 Nov 2023 07:13:09 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D08521B1E;
        Mon, 27 Nov 2023 15:13:07 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81A671367B;
        Mon, 27 Nov 2023 15:13:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id iBsVHwOyZGXEPgAAD6G6ig
        (envelope-from <petr.pavlu@suse.com>); Mon, 27 Nov 2023 15:13:07 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 1/2] tracing: Simplify and fix "buffered event" synchronization
Date:   Mon, 27 Nov 2023 16:12:47 +0100
Message-Id: <20231127151248.7232-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127151248.7232-1-petr.pavlu@suse.com>
References: <20231127151248.7232-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out1.suse.de: domain of petr.pavlu@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=petr.pavlu@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         BROKEN_CONTENT_TYPE(1.50)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 9D08521B1E
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following warning appears when using buffered events:
[  203.556451] WARNING: CPU: 53 PID: 10220 at kernel/trace/ring_buffer.c:3912 ring_buffer_discard_commit+0x2eb/0x420
[...]
[  203.670690] CPU: 53 PID: 10220 Comm: stress-ng-sysin Tainted: G            E      6.7.0-rc2-default #4 56e6d0fcf5581e6e51eaaecbdaec2a2338c80f3a
[  203.670704] Hardware name: Intel Corp. GROVEPORT/GROVEPORT, BIOS GVPRCRB1.86B.0016.D04.1705030402 05/03/2017
[  203.670709] RIP: 0010:ring_buffer_discard_commit+0x2eb/0x420
[  203.735721] Code: 4c 8b 4a 50 48 8b 42 48 49 39 c1 0f 84 b3 00 00 00 49 83 e8 01 75 b1 48 8b 42 10 f0 ff 40 08 0f 0b e9 fc fe ff ff f0 ff 47 08 <0f> 0b e9 77 fd ff ff 48 8b 42 10 f0 ff 40 08 0f 0b e9 f5 fe ff ff
[  203.735734] RSP: 0018:ffffb4ae4f7b7d80 EFLAGS: 00010202
[  203.735745] RAX: 0000000000000000 RBX: ffffb4ae4f7b7de0 RCX: ffff8ac10662c000
[  203.735754] RDX: ffff8ac0c750be00 RSI: ffff8ac10662c000 RDI: ffff8ac0c004d400
[  203.781832] RBP: ffff8ac0c039cea0 R08: 0000000000000000 R09: 0000000000000000
[  203.781839] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  203.781842] R13: ffff8ac10662c000 R14: ffff8ac0c004d400 R15: ffff8ac10662c008
[  203.781846] FS:  00007f4cd8a67740(0000) GS:ffff8ad798880000(0000) knlGS:0000000000000000
[  203.781851] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  203.781855] CR2: 0000559766a74028 CR3: 00000001804c4000 CR4: 00000000001506f0
[  203.781862] Call Trace:
[  203.781870]  <TASK>
[  203.851949]  trace_event_buffer_commit+0x1ea/0x250
[  203.851967]  trace_event_raw_event_sys_enter+0x83/0xe0
[  203.851983]  syscall_trace_enter.isra.0+0x182/0x1a0
[  203.851990]  do_syscall_64+0x3a/0xe0
[  203.852075]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  203.852090] RIP: 0033:0x7f4cd870fa77
[  203.982920] Code: 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 b8 89 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 43 0e 00 f7 d8 64 89 01 48
[  203.982932] RSP: 002b:00007fff99717dd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
[  203.982942] RAX: ffffffffffffffda RBX: 0000558ea1d7b6f0 RCX: 00007f4cd870fa77
[  203.982948] RDX: 0000000000000000 RSI: 00007fff99717de0 RDI: 0000558ea1d7b6f0
[  203.982957] RBP: 00007fff99717de0 R08: 00007fff997180e0 R09: 00007fff997180e0
[  203.982962] R10: 00007fff997180e0 R11: 0000000000000246 R12: 00007fff99717f40
[  204.049239] R13: 00007fff99718590 R14: 0000558e9f2127a8 R15: 00007fff997180b0
[  204.049256]  </TASK>

For instance, it can be triggered by running these two commands in
parallel:
$ while true; do
    echo hist:key=id.syscall:val=hitcount > \
      /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger;
  done
$ stress-ng --sysinfo $(nproc)

The warning indicates that the current ring_buffer_per_cpu is not in the
committing state. It happens because the active ring_buffer_event
doesn't actually come from the ring_buffer_per_cpu but is allocated from
trace_buffered_event.

The bug is in function trace_buffered_event_disable() where the
following normally happens:
* The code invokes disable_trace_buffered_event() via
  smp_call_function_many() and follows it by synchronize_rcu(). This
  increments the per-CPU variable trace_buffered_event_cnt on each
  target CPU and grants trace_buffered_event_disable() the exclusive
  access to the per-CPU variable trace_buffered_event.
* Maintenance is performed on trace_buffered_event, all per-CPU event
  buffers get freed.
* The code invokes enable_trace_buffered_event() via
  smp_call_function_many(). This decrements trace_buffered_event_cnt and
  releases the access to trace_buffered_event.

A problem is that smp_call_function_many() runs a given function on all
target CPUs except on the current one. The following can then occur:
* Task X executing trace_buffered_event_disable() runs on CPU A.
* The control reaches synchronize_rcu() and the task gets rescheduled on
  another CPU B.
* The RCU synchronization finishes. At this point,
  trace_buffered_event_disable() has the exclusive access to all
  trace_buffered_event variables except trace_buffered_event[A] because
  trace_buffered_event_cnt[A] is never incremented and if the buffer is
  currently unused, remains set to 0.
* A different task Y is scheduled on CPU A and hits a trace event. The
  code in trace_event_buffer_lock_reserve() sees that
  trace_buffered_event_cnt[A] is set to 0 and decides the use the buffer
  provided by trace_buffered_event[A].
* Task X continues its execution in trace_buffered_event_disable(). The
  code incorrectly frees the event buffer pointed by
  trace_buffered_event[A] and resets the variable to NULL.
* Task Y writes event data to the now freed buffer and later detects the
  created inconsistency.

The issue is observable since commit dea499781a11 ("tracing: Fix warning
in trace_buffered_event_disable()") which moved the call of
trace_buffered_event_disable() in __ftrace_event_enable_disable()
earlier, prior to invoking call->class->reg(.. TRACE_REG_UNREGISTER ..).
The underlying problem in trace_buffered_event_disable() is however
present since the original implementation in commit 0fc1b09ff1ff
("tracing: Use temp buffer when filtering events").

The bug is simply fixable by replacing smp_call_function_many() by
on_each_cpu_mask(), but the code has other issues as well:
* Function trace_event_buffer_lock_reserve() reads trace_buffered_event
  and trace_buffered_event_cnt in reverse order than they are written in
  trace_buffered_event_disable() and without any memory barrier. It
  could happen that trace_event_buffer_lock_reserve() still finds
  a valid pointer in trace_buffered_event which is being freed by
  trace_buffered_event_disable() but later already sees the decremented
  value of trace_buffered_event_cnt back to 0 and incorrectly decides to
  use the provided buffer.
* Function trace_buffered_event_enable() initializes memory of each
  allocated trace_buffered_event to zero but no memory barrier is
  present to ensure this operation is completed before publishing its
  pointer for use in trace_event_buffer_lock_reserve().
* Calling function trace_buffered_event_enable() normally requires
  pairing it with trace_buffered_event_disable(). However, the function
  has no error return code and in case of a failure decrements back
  trace_buffered_event_ref. This results in underflow of the counter
  when trace_buffered_event_disable() gets called later.

These problems can be addressed individually but it looks better to
rework the synchronization mechanism and simplify it in the first place.

Instead of using the per-CPU variable trace_buffered_event_cnt for the
exclusive access during the disable operation, introduce a new variable
trace_buffered_event_enabled to reflect the current state and
appropriately adjust the code. The variable indicates whether buffered
events are currently enabled and trace_buffered_event together with
trace_buffered_event_cnt are ok to use.

The updated synchronization mechanism fixes the mentioned problems and
avoids also sending IPIs across the system.

Fixes: 0fc1b09ff1ff ("tracing: Use temp buffer when filtering events")
Fixes: dea499781a11 ("tracing: Fix warning in trace_buffered_event_disable()")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/trace.c | 66 ++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9aebf904ff97..123acb9105dd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2741,6 +2741,7 @@ trace_buffer_lock_reserve(struct trace_buffer *buffer,
 DEFINE_PER_CPU(struct ring_buffer_event *, trace_buffered_event);
 DEFINE_PER_CPU(int, trace_buffered_event_cnt);
 static int trace_buffered_event_ref;
+static bool trace_buffered_event_enabled;
 
 /**
  * trace_buffered_event_enable - enable buffering events
@@ -2764,7 +2765,9 @@ void trace_buffered_event_enable(void)
 
 	WARN_ON_ONCE(!mutex_is_locked(&event_mutex));
 
-	if (trace_buffered_event_ref++)
+	trace_buffered_event_ref++;
+
+	if (trace_buffered_event_enabled)
 		return;
 
 	for_each_tracing_cpu(cpu) {
@@ -2777,30 +2780,21 @@ void trace_buffered_event_enable(void)
 		memset(event, 0, sizeof(*event));
 
 		per_cpu(trace_buffered_event, cpu) = event;
-
-		preempt_disable();
-		if (cpu == smp_processor_id() &&
-		    __this_cpu_read(trace_buffered_event) !=
-		    per_cpu(trace_buffered_event, cpu))
-			WARN_ON_ONCE(1);
-		preempt_enable();
 	}
 
+	/*
+	 * Ensure all initialization changes are visible and publish
+	 * availability of trace_buffered_event.
+	 */
+	smp_wmb();
+	WRITE_ONCE(trace_buffered_event_enabled, true);
 	return;
- failed:
-	trace_buffered_event_disable();
-}
 
-static void enable_trace_buffered_event(void *data)
-{
-	/* Probably not needed, but do it anyway */
-	smp_rmb();
-	this_cpu_dec(trace_buffered_event_cnt);
-}
-
-static void disable_trace_buffered_event(void *data)
-{
-	this_cpu_inc(trace_buffered_event_cnt);
+ failed:
+	for_each_tracing_cpu(cpu) {
+		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
+		per_cpu(trace_buffered_event, cpu) = NULL;
+	}
 }
 
 /**
@@ -2820,33 +2814,19 @@ void trace_buffered_event_disable(void)
 	if (WARN_ON_ONCE(!trace_buffered_event_ref))
 		return;
 
-	if (--trace_buffered_event_ref)
+	if (--trace_buffered_event_ref || !trace_buffered_event_enabled)
 		return;
 
-	preempt_disable();
-	/* For each CPU, set the buffer as used. */
-	smp_call_function_many(tracing_buffer_mask,
-			       disable_trace_buffered_event, NULL, 1);
-	preempt_enable();
+	WRITE_ONCE(trace_buffered_event_enabled, false);
 
 	/* Wait for all current users to finish */
 	synchronize_rcu();
 
 	for_each_tracing_cpu(cpu) {
+		WARN_ON_ONCE(per_cpu(trace_buffered_event_cnt, cpu) != 0);
 		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
 		per_cpu(trace_buffered_event, cpu) = NULL;
 	}
-	/*
-	 * Make sure trace_buffered_event is NULL before clearing
-	 * trace_buffered_event_cnt.
-	 */
-	smp_wmb();
-
-	preempt_disable();
-	/* Do the work on each cpu */
-	smp_call_function_many(tracing_buffer_mask,
-			       enable_trace_buffered_event, NULL, 1);
-	preempt_enable();
 }
 
 static struct trace_buffer *temp_buffer;
@@ -2883,9 +2863,16 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 		 * is still quicker than no copy on match, but having
 		 * to discard out of the ring buffer on a failed match.
 		 */
-		if ((entry = __this_cpu_read(trace_buffered_event))) {
+		if (READ_ONCE(trace_buffered_event_enabled)) {
 			int max_len = PAGE_SIZE - struct_size(entry, array, 1);
 
+			/*
+			 * Ensure per-CPU variables trace_buffered_event(_cnt)
+			 * are read after trace_buffered_event_enabled, pairs
+			 * with smp_wmb() in trace_buffered_event_enable().
+			 */
+			smp_rmb();
+
 			val = this_cpu_inc_return(trace_buffered_event_cnt);
 
 			/*
@@ -2906,6 +2893,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 			 * handle the failure in that case.
 			 */
 			if (val == 1 && likely(len <= max_len)) {
+				entry = __this_cpu_read(trace_buffered_event);
 				trace_event_setup(entry, type, trace_ctx);
 				entry->array[0] = len;
 				/* Return with preemption disabled */
-- 
2.35.3

