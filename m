Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982DB76E973
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbjHCNGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbjHCNGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:06:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39FD4C17;
        Thu,  3 Aug 2023 06:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8DD761DAF;
        Thu,  3 Aug 2023 13:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ECFC433C8;
        Thu,  3 Aug 2023 13:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691067868;
        bh=JzZuwBQiE/YN2pWMNz9QL6Mq5TiFoRcCrBAJJKHCtlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIz4HRMdKHHJ/owctmM2fQivXcBSac/htwVXwvulnCJxM+sE0naxU0m/sIuMSuj9U
         /P9u59g4qENogATtzWNKix3GmPId6+z0glG7wSUO8ybEY98CFuke4BQ17+e+r3mNJV
         mmi9VhAPS1g5DIUqihT5zCF20kbkJgRBLQ+w8b20XzD6kQ5DA6on4Tj0VZlMSsiqXY
         M51GjzxDf0BEhymdJWn11Gz6SsCBdqxzepPyBsLhhvpfxmnMDJ0maWehiPzjR1OvQp
         nG36vsxFP0RFYZne2iYu5h0PUudNFdpBWDe6YEM1gi7dX1u2sT48YUpZcXuWT/iNzj
         GGmesbFJSFghw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen Lin <chen.lin5@zte.com.cn>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>, mhiramat@kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 4/4] ring-buffer: Do not swap cpu_buffer during resize process
Date:   Thu,  3 Aug 2023 09:04:18 -0400
Message-Id: <20230803130419.641865-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803130419.641865-1-sashal@kernel.org>
References: <20230803130419.641865-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Lin <chen.lin5@zte.com.cn>

[ Upstream commit 8a96c0288d0737ad77882024974c075345c72011 ]

When ring_buffer_swap_cpu was called during resize process,
the cpu buffer was swapped in the middle, resulting in incorrect state.
Continuing to run in the wrong state will result in oops.

This issue can be easily reproduced using the following two scripts:
/tmp # cat test1.sh
//#! /bin/sh
for i in `seq 0 100000`
do
         echo 2000 > /sys/kernel/debug/tracing/buffer_size_kb
         sleep 0.5
         echo 5000 > /sys/kernel/debug/tracing/buffer_size_kb
         sleep 0.5
done
/tmp # cat test2.sh
//#! /bin/sh
for i in `seq 0 100000`
do
        echo irqsoff > /sys/kernel/debug/tracing/current_tracer
        sleep 1
        echo nop > /sys/kernel/debug/tracing/current_tracer
        sleep 1
done
/tmp # ./test1.sh &
/tmp # ./test2.sh &

A typical oops log is as follows, sometimes with other different oops logs.

[  231.711293] WARNING: CPU: 0 PID: 9 at kernel/trace/ring_buffer.c:2026 rb_update_pages+0x378/0x3f8
[  231.713375] Modules linked in:
[  231.714735] CPU: 0 PID: 9 Comm: kworker/0:1 Tainted: G        W          6.5.0-rc1-00276-g20edcec23f92 #15
[  231.716750] Hardware name: linux,dummy-virt (DT)
[  231.718152] Workqueue: events update_pages_handler
[  231.719714] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  231.721171] pc : rb_update_pages+0x378/0x3f8
[  231.722212] lr : rb_update_pages+0x25c/0x3f8
[  231.723248] sp : ffff800082b9bd50
[  231.724169] x29: ffff800082b9bd50 x28: ffff8000825f7000 x27: 0000000000000000
[  231.726102] x26: 0000000000000001 x25: fffffffffffff010 x24: 0000000000000ff0
[  231.728122] x23: ffff0000c3a0b600 x22: ffff0000c3a0b5c0 x21: fffffffffffffe0a
[  231.730203] x20: ffff0000c3a0b600 x19: ffff0000c0102400 x18: 0000000000000000
[  231.732329] x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffe7aa8510
[  231.734212] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000002
[  231.736291] x11: ffff8000826998a8 x10: ffff800082b9baf0 x9 : ffff800081137558
[  231.738195] x8 : fffffc00030e82c8 x7 : 0000000000000000 x6 : 0000000000000001
[  231.740192] x5 : ffff0000ffbafe00 x4 : 0000000000000000 x3 : 0000000000000000
[  231.742118] x2 : 00000000000006aa x1 : 0000000000000001 x0 : ffff0000c0007208
[  231.744196] Call trace:
[  231.744892]  rb_update_pages+0x378/0x3f8
[  231.745893]  update_pages_handler+0x1c/0x38
[  231.746893]  process_one_work+0x1f0/0x468
[  231.747852]  worker_thread+0x54/0x410
[  231.748737]  kthread+0x124/0x138
[  231.749549]  ret_from_fork+0x10/0x20
[  231.750434] ---[ end trace 0000000000000000 ]---
[  233.720486] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[  233.721696] Mem abort info:
[  233.721935]   ESR = 0x0000000096000004
[  233.722283]   EC = 0x25: DABT (current EL), IL = 32 bits
[  233.722596]   SET = 0, FnV = 0
[  233.722805]   EA = 0, S1PTW = 0
[  233.723026]   FSC = 0x04: level 0 translation fault
[  233.723458] Data abort info:
[  233.723734]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  233.724176]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  233.724589]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  233.725075] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000104943000
[  233.725592] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  233.726231] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  233.726720] Modules linked in:
[  233.727007] CPU: 0 PID: 9 Comm: kworker/0:1 Tainted: G        W          6.5.0-rc1-00276-g20edcec23f92 #15
[  233.727777] Hardware name: linux,dummy-virt (DT)
[  233.728225] Workqueue: events update_pages_handler
[  233.728655] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  233.729054] pc : rb_update_pages+0x1a8/0x3f8
[  233.729334] lr : rb_update_pages+0x154/0x3f8
[  233.729592] sp : ffff800082b9bd50
[  233.729792] x29: ffff800082b9bd50 x28: ffff8000825f7000 x27: 0000000000000000
[  233.730220] x26: 0000000000000000 x25: ffff800082a8b840 x24: ffff0000c0102418
[  233.730653] x23: 0000000000000000 x22: fffffc000304c880 x21: 0000000000000003
[  233.731105] x20: 00000000000001f4 x19: ffff0000c0102400 x18: ffff800082fcbc58
[  233.731727] x17: 0000000000000000 x16: 0000000000000001 x15: 0000000000000001
[  233.732282] x14: ffff8000825fe0c8 x13: 0000000000000001 x12: 0000000000000000
[  233.732709] x11: ffff8000826998a8 x10: 0000000000000ae0 x9 : ffff8000801b760c
[  233.733148] x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffff0000c03298c0
[  233.733553] x5 : 0000000000000002 x4 : 0000000000000000 x3 : 0000000000000000
[  233.733972] x2 : ffff0000c3a0b600 x1 : 0000000000000000 x0 : 0000000000000000
[  233.734418] Call trace:
[  233.734593]  rb_update_pages+0x1a8/0x3f8
[  233.734853]  update_pages_handler+0x1c/0x38
[  233.735148]  process_one_work+0x1f0/0x468
[  233.735525]  worker_thread+0x54/0x410
[  233.735852]  kthread+0x124/0x138
[  233.736064]  ret_from_fork+0x10/0x20
[  233.736387] Code: 92400000 910006b5 aa000021 aa0303f7 (f9400060)
[  233.736959] ---[ end trace 0000000000000000 ]---

After analysis, the seq of the error is as follows [1-5]:

int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
			int cpu_id)
{
	for_each_buffer_cpu(buffer, cpu) {
		cpu_buffer = buffer->buffers[cpu];
		//1. get cpu_buffer, aka cpu_buffer(A)
		...
		...
		schedule_work_on(cpu,
		 &cpu_buffer->update_pages_work);
		//2. 'update_pages_work' is queue on 'cpu', cpu_buffer(A) is passed to
		// update_pages_handler, do the update process, set 'update_done' in
		// complete(&cpu_buffer->update_done) and to wakeup resize process.
	//---->
		//3. Just at this moment, ring_buffer_swap_cpu is triggered,
		//cpu_buffer(A) be swaped to cpu_buffer(B), the max_buffer.
		//ring_buffer_swap_cpu is called as the 'Call trace' below.

		Call trace:
		 dump_backtrace+0x0/0x2f8
		 show_stack+0x18/0x28
		 dump_stack+0x12c/0x188
		 ring_buffer_swap_cpu+0x2f8/0x328
		 update_max_tr_single+0x180/0x210
		 check_critical_timing+0x2b4/0x2c8
		 tracer_hardirqs_on+0x1c0/0x200
		 trace_hardirqs_on+0xec/0x378
		 el0_svc_common+0x64/0x260
		 do_el0_svc+0x90/0xf8
		 el0_svc+0x20/0x30
		 el0_sync_handler+0xb0/0xb8
		 el0_sync+0x180/0x1c0
	//<----

	/* wait for all the updates to complete */
	for_each_buffer_cpu(buffer, cpu) {
		cpu_buffer = buffer->buffers[cpu];
		//4. get cpu_buffer, cpu_buffer(B) is used in the following process,
		//the state of cpu_buffer(A) and cpu_buffer(B) is totally wrong.
		//for example, cpu_buffer(A)->update_done will leave be set 1, and will
		//not 'wait_for_completion' at the next resize round.
		  if (!cpu_buffer->nr_pages_to_update)
			continue;

		if (cpu_online(cpu))
			wait_for_completion(&cpu_buffer->update_done);
		cpu_buffer->nr_pages_to_update = 0;
	}
	...
}
	//5. the state of cpu_buffer(A) and cpu_buffer(B) is totally wrong,
	//Continuing to run in the wrong state, then oops occurs.

Link: https://lore.kernel.org/linux-trace-kernel/202307191558478409990@zte.com.cn

Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 14 +++++++++++++-
 kernel/trace/trace.c       |  3 ++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 14d8001140c82..de061dd473132 100644
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
index c80ff6f5b2cc1..fd051f85efd4b 100644
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
-- 
2.40.1

