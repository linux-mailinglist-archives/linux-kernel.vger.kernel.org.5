Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D387E914A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjKLPAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLPAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:00:51 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3562D57;
        Sun, 12 Nov 2023 07:00:47 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc921a4632so32174815ad.1;
        Sun, 12 Nov 2023 07:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699801245; x=1700406045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zVX7qXJ/1UNSsp24Eao/LKK7Tfj8DYCmTw98S9n23hk=;
        b=k8nSsw4oJA1zZdAZ91WBJXyPleW+ERhIGB+Le8N2LEWQ7zYDbvMEeVfFdVJe0bklFI
         hxH+IVyMTBsVOxXYmA6X6tRtoKwvExynAbhWzQMZBa1M+Nj/Cy0XaEqlgAFf/GZaYGr+
         7KJG+0cOS1Oz9rGzVm4ekGioXeMM8nAKX9k/eCKiyrWhSrBHOcKdnYp8iU9cI/E07mLM
         7v5ZB77GeX6tgevRVNuOp46BtFpd+qr6iLcuB/EKFnH9vyJmBokZIbmY5aL8K2IXzpZL
         FFtlHdxuQIORyO/eWpbAXsrGSHM4iZ+s/VRoBTW+6P5JKTIRn4sypC/0tCQFvnIMDzFa
         6fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699801245; x=1700406045;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVX7qXJ/1UNSsp24Eao/LKK7Tfj8DYCmTw98S9n23hk=;
        b=FiWqPGihugauzuYr+p/EFYxFgOwP9rSjV04T7uP8vkcRfpQd4q4Qo7shZRb/DgvOaX
         vDskDci21xM7KLYu0WEy7C51laMqijjkpllynzfYGIsC0FCmlnE9d/jO9MmBdvxg0AMX
         FUrJUhaThDxgpLGumjoIDgQlO+LhQNRPd/+LSpPeHgjI+CK29ifbQZciUj6mQHapH+v+
         MmLJaP2uSZZjf84nY6aG/lCeWP+kp+QKHeOSFxG+jQvg0i5TXzVn/wtjoDrmjdowIjhQ
         4D980amclNsdBEz09JrnOcYeuhmriVseaPaGwt2F/pNk+8ua0rMIlKNCFvAY2tXXKuNu
         MaSA==
X-Gm-Message-State: AOJu0YyEsNuPHCBwnuFa2gR7105nxsTkaPOoFQvLGY0K0zyWyen0xHJN
        GYLcpj+C3VaiPmFHxepwMn6PktMrIAaswK8X
X-Google-Smtp-Source: AGHT+IFPJ0tH8yuHBYyKkI9XP26p2LtV9hKJsgfeIgAKCWvyUJZkGbzCLffBPMNbcTP/KntMYR/GqA==
X-Received: by 2002:a17:903:24f:b0:1c3:6d97:e89e with SMTP id j15-20020a170903024f00b001c36d97e89emr6414948plh.58.1699801245030;
        Sun, 12 Nov 2023 07:00:45 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902ec8300b001c73f3a9b88sm2653175plg.110.2023.11.12.07.00.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Nov 2023 07:00:44 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        linux-trace-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH] tracing: fix UAF caused by memory ordering issue
Date:   Sun, 12 Nov 2023 23:00:30 +0800
Message-ID: <20231112150030.84609-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.42.0
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

Following kernel panic was observed when doing ftrace stress test:

Unable to handle kernel paging request at virtual address 9699b0f8ece28240
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[9699b0f8ece28240] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] SMP
Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core rfkill vfat fat loop fuse nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables ext4 mbcache jbd2 sr_mod cdrom crct10dif_ce ghash_ce sha2_ce virtio_gpu virtio_dma_buf drm_shmem_helper virtio_blk drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops virtio_console sha256_arm64 sha1_ce drm virtio_scsi i2c_core virtio_net net_failover failover virtio_mmio dm_multipath dm_mod autofs4 [last unloaded: ipmi_msghandler]
CPU: 0 PID: 499719 Comm: sh Kdump: loaded Not tainted 6.1.61+ #2
Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __kmem_cache_alloc_node+0x1dc/0x2e4
lr : __kmem_cache_alloc_node+0xac/0x2e4
sp : ffff80000ad23aa0
x29: ffff80000ad23ab0 x28: 00000004052b8000 x27: ffffc513863b0000
x26: 0000000000000040 x25: ffffc51384f21ca4 x24: 00000000ffffffff
x23: d615521430b1b1a5 x22: ffffc51386044770 x21: 0000000000000000
x20: 0000000000000cc0 x19: ffff0000c0001200 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaae65e1630
x14: 0000000000000004 x13: ffffc513863e67a0 x12: ffffc513863af6d8
x11: 0000000000000001 x10: ffff80000ad23aa0 x9 : ffffc51385058078
x8 : 0000000000000018 x7 : 0000000000000001 x6 : 0000000000000010
x5 : ffff0000c09c2280 x4 : ffffc51384f21ca4 x3 : 0000000000000040
x2 : 9699b0f8ece28240 x1 : ffff0000c09c2280 x0 : 9699b0f8ece28200
Call trace:
 __kmem_cache_alloc_node+0x1dc/0x2e4
 __kmalloc+0x6c/0x1c0
 func_add+0x1a4/0x200
 tracepoint_add_func+0x70/0x230
 tracepoint_probe_register+0x6c/0xb4
 trace_event_reg+0x8c/0xa0
 __ftrace_event_enable_disable+0x17c/0x440
 __ftrace_set_clr_event_nolock+0xe0/0x150
 system_enable_write+0xe0/0x114
 vfs_write+0xd0/0x2dc
 ksys_write+0x78/0x110
 __arm64_sys_write+0x24/0x30
 invoke_syscall.constprop.0+0x58/0xf0
 el0_svc_common.constprop.0+0x54/0x160
 do_el0_svc+0x2c/0x60
 el0_svc+0x40/0x1ac
 el0t_64_sync_handler+0xf4/0x120
 el0t_64_sync+0x19c/0x1a0
Code: b9402a63 f9405e77 8b030002 d5384101 (f8636803)

Panic was caused by corrupted freelist pointer. After more debugging,
I found the root cause is UAF of slab allocated object in ftrace
introduced by commit eecb91b9f98d ("tracing: Fix memleak due to race
between current_tracer and trace"), and so far it's only reproducible
on some ARM64 machines, the UAF and free stack is:

UAF:
kasan_report+0xa8/0x1bc
__asan_report_load8_noabort+0x28/0x3c
print_graph_function_flags+0x524/0x5a0
print_graph_function_event+0x28/0x40
print_trace_line+0x5c4/0x1030
s_show+0xf0/0x460
seq_read_iter+0x930/0xf5c
seq_read+0x130/0x1d0
vfs_read+0x288/0x840
ksys_read+0x130/0x270
__arm64_sys_read+0x78/0xac
invoke_syscall.constprop.0+0x90/0x224
do_el0_svc+0x118/0x3dc
el0_svc+0x54/0x120
el0t_64_sync_handler+0xf4/0x120
el0t_64_sync+0x19c/0x1a0

Freed by:
kasan_save_free_info+0x38/0x5c
__kasan_slab_free+0xe8/0x154
slab_free_freelist_hook+0xfc/0x1e0
__kmem_cache_free+0x138/0x260
kfree+0xd0/0x1d0
graph_trace_close+0x60/0x90
s_start+0x610/0x910
seq_read_iter+0x274/0xf5c
seq_read+0x130/0x1d0
vfs_read+0x288/0x840
ksys_read+0x130/0x270
__arm64_sys_read+0x78/0xac
invoke_syscall.constprop.0+0x90/0x224
do_el0_svc+0x118/0x3dc
el0_svc+0x54/0x120
el0t_64_sync_handler+0xf4/0x120
el0t_64_sync+0x19c/0x1a0

Despite the s_start and s_show being serialized by seq_file mutex,
the tracer struct copy in s_start introduced by the commit mentioned
above is not atomic nor guarenteened to be seen by all CPUs. So
following seneriao is possible (and actually happened):

CPU 1                                     CPU 2
seq_read_iter                             seq_read_iter
  mutex_lock(&m->lock);
  s_start
    // iter->trace is graph_trace
    iter->trace->close(iter);
    graph_trace_close
      kfree(data) <- *** data released here ***
    // copy current_trace to iter->trace
    // but not synced to CPU 2
    *iter->trace = *tr->current_trace
  ... (goes on)
  mutex_unlock(&m->lock);
                                          mutex_lock(&m->lock);
                                          ... (s_start and other work)
                                          s_show
                                            print_trace_line(iter)
                                              // iter->trace is still
                                              // old value (graph_trace)
                                              iter->trace->print_line()
                                                print_graph_function_flags
                                                  data->cpu_data <- *** data UAF ***

The UAF corrupted the slab freelist and caused panic on another slab
allocation.

After applying the barrier, the problem is gone.

Fixes: eecb91b9f98d ("tracing: Fix memleak due to race between current_tracer and trace")
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 kernel/trace/trace.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9aebf904ff97..c377cdf3701b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4182,11 +4182,14 @@ static void *s_start(struct seq_file *m, loff_t *pos)
 	int cpu;
 
 	mutex_lock(&trace_types_lock);
-	if (unlikely(tr->current_trace != iter->trace)) {
-		/* Close iter->trace before switching to the new current tracer */
-		if (iter->trace->close)
-			iter->trace->close(iter);
-		iter->trace = tr->current_trace;
+	if (unlikely(tr->current_trace && iter->trace->name != tr->current_trace->name)) {
+		/* Switch to the new current tracer then close old tracer */
+		struct tracer *prev_trace = iter->trace;
+		*iter->trace = *tr->current_trace;
+		/* Make sure the switch is seen by all CPUs before closing */
+		smp_wmb();
+		if (prev_trace->close)
+			prev_trace->close(iter);
 		/* Reopen the new current tracer */
 		if (iter->trace->open)
 			iter->trace->open(iter);
-- 
2.42.0

