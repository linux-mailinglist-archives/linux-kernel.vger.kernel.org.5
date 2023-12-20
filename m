Return-Path: <linux-kernel+bounces-7275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D48581A477
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6F01C24438
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799C241867;
	Wed, 20 Dec 2023 16:14:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE341862;
	Wed, 20 Dec 2023 16:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F102EC433C9;
	Wed, 20 Dec 2023 16:14:24 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:15:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alexander Graf <graf@amazon.com>, Tom
 Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing / synthetic: Disable events after testing in
 synth_event_gen_test_init()
Message-ID: <20231220111525.2f0f49b0@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The synth_event_gen_test module can be built in, if someone wants to run
the tests at boot up and not have to load them.

The synth_event_gen_test_init() function creates and enables the synthetic
events and runs its tests.

The synth_event_gen_test_exit() disables the events it created and
destroys the events.

If the module is builtin, the events are never disabled. The issue is, the
events should be disable after the tests are run. This could be an issue
if the rest of the boot up tests are enabled, as they expect the events to
be in a known state before testing. That known state happens to be
disabled.

When CONFIG_SYNTH_EVENT_GEN_TEST=y and CONFIG_EVENT_TRACE_STARTUP_TEST=y
a warning will trigger:

 Running tests on trace events:
 Testing event create_synth_test:
 Enabled event during self test!
 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 1 at kernel/trace/trace_events.c:4150 event_trace_self_tests+0x1c2/0x480
 Modules linked in:
 CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc2-test-00031-gb803d7c664d5-dirty #276
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
 RIP: 0010:event_trace_self_tests+0x1c2/0x480
 Code: bb e8 a2 ab 5d fc 48 8d 7b 48 e8 f9 3d 99 fc 48 8b 73 48 40 f6 c6 01 0f 84 d6 fe ff ff 48 c7 c7 20 b6 ad bb e8 7f ab 5d fc 90 <0f> 0b 90 48 89 df e8 d3 3d 99 fc 48 8b 1b 4c 39 f3 0f 85 2c ff ff
 RSP: 0000:ffffc9000001fdc0 EFLAGS: 00010246
 RAX: 0000000000000029 RBX: ffff88810399ca80 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffffffffb9f19478 RDI: ffff88823c734e64
 RBP: ffff88810399f300 R08: 0000000000000000 R09: fffffbfff79eb32a
 R10: ffffffffbcf59957 R11: 0000000000000001 R12: ffff888104068090
 R13: ffffffffbc89f0a0 R14: ffffffffbc8a0f08 R15: 0000000000000078
 FS:  0000000000000000(0000) GS:ffff88823c700000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 00000001f6282001 CR4: 0000000000170ef0
 Call Trace:
  <TASK>
  ? __warn+0xa5/0x200
  ? event_trace_self_tests+0x1c2/0x480
  ? report_bug+0x1f6/0x220
  ? handle_bug+0x6f/0x90
  ? exc_invalid_op+0x17/0x50
  ? asm_exc_invalid_op+0x1a/0x20
  ? tracer_preempt_on+0x78/0x1c0
  ? event_trace_self_tests+0x1c2/0x480
  ? __pfx_event_trace_self_tests_init+0x10/0x10
  event_trace_self_tests_init+0x27/0xe0
  do_one_initcall+0xd6/0x3c0
  ? __pfx_do_one_initcall+0x10/0x10
  ? kasan_set_track+0x25/0x30
  ? rcu_is_watching+0x38/0x60
  kernel_init_freeable+0x324/0x450
  ? __pfx_kernel_init+0x10/0x10
  kernel_init+0x1f/0x1e0
  ? _raw_spin_unlock_irq+0x33/0x50
  ret_from_fork+0x34/0x60
  ? __pfx_kernel_init+0x10/0x10
  ret_from_fork_asm+0x1b/0x30
  </TASK>

This is because the synth_event_gen_test_init() left the synthetic events
that it created enabled. By having it disable them after testing, the
other selftests will run fine.

Cc: stable@vger.kernel.org
Fixes: 9fe41efaca084 ("tracing: Add synth event generation test module")
Reported-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/synth_event_gen_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index 8dfe85499d4a..354c2117be43 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -477,6 +477,17 @@ static int __init synth_event_gen_test_init(void)
 
 	ret = test_trace_synth_event();
 	WARN_ON(ret);
+
+	/* Disable when done */
+	trace_array_set_clr_event(gen_synth_test->tr,
+				  "synthetic",
+				  "gen_synth_test", false);
+	trace_array_set_clr_event(empty_synth_test->tr,
+				  "synthetic",
+				  "empty_synth_test", false);
+	trace_array_set_clr_event(create_synth_test->tr,
+				  "synthetic",
+				  "create_synth_test", false);
  out:
 	return ret;
 }
-- 
2.42.0


