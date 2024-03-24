Return-Path: <linux-kernel+bounces-115988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9D2889733
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C3ACB2194B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EED23849C;
	Mon, 25 Mar 2024 03:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfGvufCu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044B15EFAB;
	Sun, 24 Mar 2024 23:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322321; cv=none; b=Wer3VwljP+SXwMBKjv2TWZdfX18xcFmIEfwl3ivELc5zU2riKevRcih+S/wg8ZM0P3+hjjnGuQaY41YJVVrCQmgGVgnOqH6jbX4ZwZJlTW1VGXl4jH4ccxHYqhb9z3iRHJZectGX067ksmUi1581WxQ8/7s/lWl86iGqUhaAugo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322321; c=relaxed/simple;
	bh=LIa3CnucbRpZxFAOU86S24JrIFII50Udgg9Zp6807Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL687weNatCX4UyAVMuJJLGUyizrcPjHUeHqQeGJVIkR2MYdqXst8ySyTGZ39m/2z4v+ozBxZmBlTrHHmxbzllwCvCb1jF5CAXQVFwvcf0bq1kIwuBkOSXhnv7VaYYIL2JjEHgXVvKKt/Hs9jTOux7aBehMnFeLbd1uHFUDAKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfGvufCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0531C433F1;
	Sun, 24 Mar 2024 23:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322320;
	bh=LIa3CnucbRpZxFAOU86S24JrIFII50Udgg9Zp6807Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfGvufCun9nzLGklFaLp29J+BNRiRaUa/+RRsbhdyfgmSyzgQtoW2bWyRaefssygL
	 z+kCUvPUthpSfZThbRIgnsfbecSri3QHQepVjBGfxSAqZvqLSFyj+YrBFVyBe/M6C3
	 ip7mphQUPXV1bEs4wyt994mK1sLl5/Jq0NG3SqLpmpB9aXOXlDh4Nxy4i6Q+F4moob
	 NLYfoZVICTJZ7IteoVvVDVh0k4B8dhPcbtAq+wve09ex5ONWjWvQ1p/oLGJMoIc6vf
	 ODhIjfnbLdFoj+DMPB4EuFNgyclzUMri7eIKVWBOO4Mb0PyfDabcIyns6f08yhFf7y
	 2HSXbNjhlxg8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 403/451] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
Date: Sun, 24 Mar 2024 19:11:19 -0400
Message-ID: <20240324231207.1351418-404-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 2a750d6a5b365265dbda33330a6188547ddb5c24 ]

syzkaller reported a warning of netns tracker [0] followed by KASAN
splat [1] and another ref tracker warning [1].

syzkaller could not find a repro, but in the log, the only suspicious
sequence was as follows:

  18:26:22 executing program 1:
  r0 = socket$inet6_mptcp(0xa, 0x1, 0x106)
  ...
  connect$inet6(r0, &(0x7f0000000080)={0xa, 0x4001, 0x0, @loopback}, 0x1c) (async)

The notable thing here is 0x4001 in connect(), which is RDS_TCP_PORT.

So, the scenario would be:

  1. unshare(CLONE_NEWNET) creates a per netns tcp listener in
      rds_tcp_listen_init().
  2. syz-executor connect()s to it and creates a reqsk.
  3. syz-executor exit()s immediately.
  4. netns is dismantled.  [0]
  5. reqsk timer is fired, and UAF happens while freeing reqsk.  [1]
  6. listener is freed after RCU grace period.  [2]

Basically, reqsk assumes that the listener guarantees netns safety
until all reqsk timers are expired by holding the listener's refcount.
However, this was not the case for kernel sockets.

Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
inet_twsk_purge()") fixed this issue only for per-netns ehash.

Let's apply the same fix for the global ehash.

[0]:
ref_tracker: net notrefcnt@0000000065449cc3 has 1/1 users at
     sk_alloc (./include/net/net_namespace.h:337 net/core/sock.c:2146)
     inet6_create (net/ipv6/af_inet6.c:192 net/ipv6/af_inet6.c:119)
     __sock_create (net/socket.c:1572)
     rds_tcp_listen_init (net/rds/tcp_listen.c:279)
     rds_tcp_init_net (net/rds/tcp.c:577)
     ops_init (net/core/net_namespace.c:137)
     setup_net (net/core/net_namespace.c:340)
     copy_net_ns (net/core/net_namespace.c:497)
     create_new_namespaces (kernel/nsproxy.c:110)
     unshare_nsproxy_namespaces (kernel/nsproxy.c:228 (discriminator 4))
     ksys_unshare (kernel/fork.c:3429)
     __x64_sys_unshare (kernel/fork.c:3496)
     do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
..
WARNING: CPU: 0 PID: 27 at lib/ref_tracker.c:179 ref_tracker_dir_exit (lib/ref_tracker.c:179)

[1]:
BUG: KASAN: slab-use-after-free in inet_csk_reqsk_queue_drop (./include/net/inet_hashtables.h:180 net/ipv4/inet_connection_sock.c:952 net/ipv4/inet_connection_sock.c:966)
Read of size 8 at addr ffff88801b370400 by task swapper/0/0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
 print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
 kasan_report (mm/kasan/report.c:603)
 inet_csk_reqsk_queue_drop (./include/net/inet_hashtables.h:180 net/ipv4/inet_connection_sock.c:952 net/ipv4/inet_connection_sock.c:966)
 reqsk_timer_handler (net/ipv4/inet_connection_sock.c:979 net/ipv4/inet_connection_sock.c:1092)
 call_timer_fn (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/timer.h:127 kernel/time/timer.c:1701)
 __run_timers.part.0 (kernel/time/timer.c:1752 kernel/time/timer.c:2038)
 run_timer_softirq (kernel/time/timer.c:2053)
 __do_softirq (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:554)
 irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:644)
 sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076 (discriminator 14))
 </IRQ>

Allocated by task 258 on cpu 0 at 83.612050s:
 kasan_save_stack (mm/kasan/common.c:48)
 kasan_save_track (mm/kasan/common.c:68)
 __kasan_slab_alloc (mm/kasan/common.c:343)
 kmem_cache_alloc (mm/slub.c:3813 mm/slub.c:3860 mm/slub.c:3867)
 copy_net_ns (./include/linux/slab.h:701 net/core/net_namespace.c:421 net/core/net_namespace.c:480)
 create_new_namespaces (kernel/nsproxy.c:110)
 unshare_nsproxy_namespaces (kernel/nsproxy.c:228 (discriminator 4))
 ksys_unshare (kernel/fork.c:3429)
 __x64_sys_unshare (kernel/fork.c:3496)
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)

Freed by task 27 on cpu 0 at 329.158864s:
 kasan_save_stack (mm/kasan/common.c:48)
 kasan_save_track (mm/kasan/common.c:68)
 kasan_save_free_info (mm/kasan/generic.c:643)
 __kasan_slab_free (mm/kasan/common.c:265)
 kmem_cache_free (mm/slub.c:4299 mm/slub.c:4363)
 cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:446 net/core/net_namespace.c:639)
 process_one_work (kernel/workqueue.c:2638)
 worker_thread (kernel/workqueue.c:2700 kernel/workqueue.c:2787)
 kthread (kernel/kthread.c:388)
 ret_from_fork (arch/x86/kernel/process.c:153)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250)

The buggy address belongs to the object at ffff88801b370000
 which belongs to the cache net_namespace of size 4352
The buggy address is located 1024 bytes inside of
 freed 4352-byte region [ffff88801b370000, ffff88801b371100)

[2]:
WARNING: CPU: 0 PID: 95 at lib/ref_tracker.c:228 ref_tracker_free (lib/ref_tracker.c:228 (discriminator 1))
Modules linked in:
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:ref_tracker_free (lib/ref_tracker.c:228 (discriminator 1))
..
Call Trace:
<IRQ>
 __sk_destruct (./include/net/net_namespace.h:353 net/core/sock.c:2204)
 rcu_core (./arch/x86/include/asm/preempt.h:26 kernel/rcu/tree.c:2165 kernel/rcu/tree.c:2433)
 __do_softirq (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:554)
 irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:644)
 sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076 (discriminator 14))
</IRQ>

Reported-by: syzkaller <syzkaller@googlegroups.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: 467fa15356ac ("RDS-TCP: Support multiple RDS-TCP listen endpoints, one per netns.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240308200122.64357-3-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_minisocks.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 42844d20da020..b3bfa1a09df68 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -357,10 +357,6 @@ void tcp_twsk_purge(struct list_head *net_exit_list, int family)
 			/* Even if tw_refcount == 1, we must clean up kernel reqsk */
 			inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo, family);
 		} else if (!purged_once) {
-			/* The last refcount is decremented in tcp_sk_exit_batch() */
-			if (refcount_read(&net->ipv4.tcp_death_row.tw_refcount) == 1)
-				continue;
-
 			inet_twsk_purge(&tcp_hashinfo, family);
 			purged_once = true;
 		}
-- 
2.43.0


