Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065017F12FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjKTMQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjKTMQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:16:37 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0949BD0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:16:34 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b6d88dbaa3so2872320b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700482593; x=1701087393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3fCBYSHZbpUaMJUXbkBILsJwmjQ6x2DpigieEwhFYMg=;
        b=AoGDn6LEk5AxCE3+28JNhOs5/bka6xp68y/THjsyMShfQtQMmhLBJZeBveebQoFXnJ
         /son3oYCN0SlLTIW+nmM4qgKdiFM/GFQBryEsTM9yBI9MTLjFjBOBDt3YMZ6kCh5oTlJ
         nDsFxej4x0qNwjXdSZi2ZiRQ2aNQFX201EQMVt3IaSZrztjC7xr6XXpfzRWJ3HXpq54p
         62ubOzcqQVi5NRKUQN0c5bTZYuxphrXL2Hamwb5jL5X4Hlq+AITPAl70uoUTCXQu4WYj
         /NxAra6bti9sQ6uWkodYPAi34vwJDXEOSX0CAGAPisSgVdMwtK5+7pX91VEPu/D3R4oc
         DhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700482593; x=1701087393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fCBYSHZbpUaMJUXbkBILsJwmjQ6x2DpigieEwhFYMg=;
        b=lgfL7iqyDQ9Y3WMnbEaibfr7N9Z1DMwC1uytinDb/g7Zz70XInkC8OX4+X5Htmzc3Z
         TSJfyUn6ZpRVSjx4D8h1KO+dAU8CUdkXbu4FpoE7XVuQUk8vh5wxaSBToRyJRKIJJURf
         oEgv6bfjbqvzRrsGAxkgUR3df8sNiwcjffMlxIIgQsGA7Q+e80zAD+l8kIiT2mtgGlFb
         S2G/QL9lFD7KWWhQCB9Xy5bCKEet+p78ZRnFPQj/+Chnq2yX4JDo5rIEkfq6Zp6kH1K6
         mduQI1t3s9CKgnTUyVe+3E+kppI4bBxfXgZ71HyH26RWJYL7rd2ne5Eg/+3XvVkGvmuF
         f/UA==
X-Gm-Message-State: AOJu0YzjAI8cnLKcViQJMzao63LMBIL1sR3fRElJIIWNWFh7mByqI9tA
        g6fLn6CbZb8oIJSAoXoD8NPkZeiMFB4tkmNqKUMFjA==
X-Google-Smtp-Source: AGHT+IHpCFldHYYPiBWZufGWQwslXN9fXnCSBWIWzy0D8N52GnT17RVDur7y3qLF48D0ybp1T/Kasg==
X-Received: by 2002:a05:6808:1b13:b0:3b2:c242:aaee with SMTP id bx19-20020a0568081b1300b003b2c242aaeemr9994868oib.42.1700482593264;
        Mon, 20 Nov 2023 04:16:33 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id p18-20020a63fe12000000b0058988954686sm5786369pgh.90.2023.11.20.04.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 04:16:32 -0800 (PST)
From:   Yong He <zhuangel570@gmail.com>
X-Google-Original-From: Yong He <alexyonghe@tencent.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: fix invalid cpu in kick_pool
Date:   Mon, 20 Nov 2023 20:16:23 +0800
Message-Id: <20231120121623.119780-1-alexyonghe@tencent.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yong He <alexyonghe@tencent.com>

Now unbound workqueue supports non-strict affinity scope after
commit 8639ecebc9b1 ("workqueue: Implement non-strict affinity scope for
unbound workqueues"), which allow the worker task to run out of the pod
to gain better performance, then use kick_pool() to migarate the worker
task back to the pod.

With incorrect unbound workqueue configurations, this may introduce kernel
panic, because cpumask_any_distribute() will not always return a valid cpu,
such as one set the 'isolcpus' and 'workqueue.unbound_cpus' into the same
cpuset, and this will make the @pool->attrs->__pod_cpumask an empty set,
then trigger panic like this:

 BUG: unable to handle page fault for address: ffffffff8305e9c0
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 2c31067 P4D 2c31067 PUD 2c32063 PMD 10a18d063 PTE 800ffffffcfa1062
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 39 PID: 1 Comm: systemd Not tainted 6.6.1-tlinux4-0011.1 #2
 Hardware name: Cloud Hypervisor cloud-hypervisor, BIOS 0
 RIP: 0010:available_idle_cpu+0x21/0x60
 RSP: 0018:ffffc90000013828 EFLAGS: 00010082
 RAX: 0000000000000000 RBX: 0000000000000028 RCX: 0000000000000008
 RDX: ffffffff8305e040 RSI: 0000000000000028 RDI: 0000000000000028
 RBP: ffffc90000013828 R08: 0000000000000027 R09: 00000000000000b0
 R10: 0000000000000000 R11: ffffffff82c64348 R12: 0000000000000028
 R13: ffff888100928000 R14: 0000000000000028 R15: 0000000000000000
 FS:  00007f0d6a5d39c0(0000) GS:ffff888c8ddc0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffffff8305e9c0 CR3: 0000000100074002 CR4: 0000000000770ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  select_idle_sibling+0x79/0xaf0
  select_task_rq_fair+0x1cb/0x7b0
  try_to_wake_up+0x29c/0x5c0
  wake_up_process+0x19/0x20
  kick_pool+0x5e/0xb0
  __queue_work+0x119/0x430
  queue_work_on+0x29/0x30
  driver_deferred_probe_trigger.part.15+0x8b/0x90
  driver_bound+0x8b/0xe0
  really_probe+0x2e6/0x3b0
  __driver_probe_device+0x85/0x170
  driver_probe_device+0x24/0x90
  __driver_attach+0xd5/0x170
  bus_for_each_dev+0x7a/0xd0
  driver_attach+0x22/0x30
  bus_add_driver+0x17c/0x230
  driver_register+0x5e/0x110
  ? 0xffffffffa021b000
  register_virtio_driver+0x24/0x40
  register_virtio_driver+0x24/0x40
  virtio_rng_driver_init+0x19/0x1000 [virtio_rng]
  do_one_initcall+0x54/0x220
  do_init_module+0x68/0x250
  load_module+0x1f21/0x2080
  init_module_from_file+0x99/0xd0
  idempotent_init_module+0x195/0x250
  __x64_sys_finit_module+0x68/0xc0
  do_syscall_64+0x40/0x90
  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: 8639ecebc9b1 ("workqueue: Implement non-strict affinity scope for unbound workqueues")
Signed-off-by: Yong He <alexyonghe@tencent.com>
---
 kernel/workqueue.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6e578f576a6f..0d20feded4e2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1106,6 +1106,7 @@ static bool kick_pool(struct worker_pool *pool)
 {
 	struct worker *worker = first_idle_worker(pool);
 	struct task_struct *p;
+	int cpu;
 
 	lockdep_assert_held(&pool->lock);
 
@@ -1133,10 +1134,13 @@ static bool kick_pool(struct worker_pool *pool)
 	 */
 	if (!pool->attrs->affn_strict &&
 	    !cpumask_test_cpu(p->wake_cpu, pool->attrs->__pod_cpumask)) {
-		struct work_struct *work = list_first_entry(&pool->worklist,
-						struct work_struct, entry);
-		p->wake_cpu = cpumask_any_distribute(pool->attrs->__pod_cpumask);
-		get_work_pwq(work)->stats[PWQ_STAT_REPATRIATED]++;
+		cpu = cpumask_any_distribute(pool->attrs->__pod_cpumask);
+		if (cpu < nr_cpu_ids) {
+			struct work_struct *work = list_first_entry(&pool->worklist,
+							struct work_struct, entry);
+			p->wake_cpu = cpu;
+			get_work_pwq(work)->stats[PWQ_STAT_REPATRIATED]++;
+		}
 	}
 #endif
 	wake_up_process(p);
-- 
2.31.1

