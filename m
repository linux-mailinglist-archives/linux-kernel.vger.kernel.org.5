Return-Path: <linux-kernel+bounces-141374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 373158A1D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA39C1F228C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870FF1DB53B;
	Thu, 11 Apr 2024 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3c/3Xf8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DBD1DB521;
	Thu, 11 Apr 2024 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855138; cv=none; b=sKH0akbDohbdGYQOA5RbwTRZVT4zDwyed8ni19vbGPTH/0SGbWXvv9XqA99JJSZAy5WP65+ifnaDYbe9U3aNUH2a7N/8+hysYnhPeQFsTIymIIKPQTf9cij+3pMzfCvagwBwLBOIuC3Y9mReQxf/+TXOx25u4urx+K1PU8ADba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855138; c=relaxed/simple;
	bh=qRbDYCO3oRevMWE+vCYosIfTjbPVcc1sCyqnY5bGFes=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3MEJFSIO2cp4HdLGGkcW3KnalKDrV0nDC8Hkq3TweIDhW1eoioI3Vxb+CmsjVjoFYlyqH2Pfw1EJWBfs+AgllYz5cCVcAX9AL5EV0iXRjlTAO9hAitm1MuWhEx5BiT+8fDYOGz84a9jWyLGFj/Tf+572ejLRiwYYIfTLM0onpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3c/3Xf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F08C072AA;
	Thu, 11 Apr 2024 17:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712855138;
	bh=qRbDYCO3oRevMWE+vCYosIfTjbPVcc1sCyqnY5bGFes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i3c/3Xf8wlZEWWUjQ+7XxDeRg3RvblBL2IvG7rAVeRtjnPKG31AMGRQfg5QFL/vBx
	 57+wz6pbnv97oqURL0Myi0grhw06EoBwX6LUnC1T2qjhHvqKXHIRFJXd7HOhjXOUY/
	 KBTbqRZ1DgtpUNI5Zp86GtqEbw2dk/zY01iwHJ6rQqA5SKUGJwhogH2GP+Nln/Y/lh
	 CviW7OSCxU4T/Hmi9UjOoSNN48rPz0ibimvyN0DJChKqC8Q+FAQO3L4LwOWN0mnndn
	 csJy0IKamY2F/uXB0BCPKlYiFfUFuA3G6FryLWa2KptebnN02MtHgNAKAFfxPZ18B8
	 V6zZWkqicctmg==
Date: Thu, 11 Apr 2024 10:05:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, mleitner@redhat.com, David Ahern
 <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 1/1] tcp/dcpp: Un-pin tw_timer
Message-ID: <20240411100536.224fa1e7@kernel.org>
In-Reply-To: <20240411120535.2494067-2-vschneid@redhat.com>
References: <20240411120535.2494067-1-vschneid@redhat.com>
	<20240411120535.2494067-2-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 14:05:35 +0200 Valentin Schneider wrote:
> The TCP timewait timer is proving to be problematic for setups where scheduler
> CPU isolation is achieved at runtime via cpusets (as opposed to statically via
> isolcpus=domains).
> 
> What happens there is a CPU goes through tcp_time_wait(), arming the time_wait
> timer, then gets isolated. TCP_TIMEWAIT_LEN later, the timer fires, causing
> interference for the now-isolated CPU. This is conceptually similar to the issue
> described in
>   e02b93124855 ("workqueue: Unbind kworkers before sending them to exit()")
> 
> Move inet_twsk_schedule() to within inet_twsk_hashdance(), with the ehash
> lock held. Expand the lock's critical section from inet_twsk_kill() to
> inet_twsk_deschedule_put(), serializing the scheduling vs descheduling of
> the timer. IOW, this prevents the following race:
> 
> 			     tcp_time_wait()
> 			       inet_twsk_hashdance()
>   inet_twsk_deschedule_put()
>     del_timer_sync()
> 			       inet_twsk_schedule()
> 
> This partially reverts
>   ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait hashdance")
> 
> This also reinstores a comment from
>   ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait hashdance")
> as inet_twsk_hashdance() had a "Step 1" and "Step 3" comment, but the "Step
> 2" had gone missing.
> 
> Thanks to Paolo for suggesting to leverage the ehash lock.
> 
> Link: https://lore.kernel.org/all/ZPhpfMjSiHVjQkTk@localhost.localdomain/
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Some new crashes started appearing this morning on our testing branch,
quick look at the splats makes me suspect this change:

[   44.056729][  T367] netem: version 1.3
[  111.328727][ T1205] mptcp_connect (1205) used greatest stack depth: 23728 bytes left
[  516.501105][   T10] 
[  516.501208][   T10] ======================================================
[  516.501365][   T10] WARNING: possible circular locking dependency detected
[  516.501519][   T10] 6.9.0-rc2-virtme #1 Not tainted
[  516.501654][   T10] ------------------------------------------------------
[  516.501812][   T10] kworker/u16:0/10 is trying to acquire lock:
[  516.501970][   T10] ffff88800fe20400 ((&tw->tw_timer)){+.-.}-{0:0}, at: __timer_delete_sync+0xd3/0x110
[  516.502203][   T10] 
[  516.502203][   T10] but task is already holding lock:
[  516.502383][   T10] ffff888003c0b998 (&hashinfo->ehash_locks[i]){+.-.}-{2:2}, at: inet_twsk_deschedule_put+0xe0/0x150
[  516.502638][   T10] 
[  516.502638][   T10] which lock already depends on the new lock.
[  516.502638][   T10] 
[  516.502875][   T10] 
[  516.502875][   T10] the existing dependency chain (in reverse order) is:
[  516.503087][   T10] 
[  516.503087][   T10] -> #1 (&hashinfo->ehash_locks[i]){+.-.}-{2:2}:
[  516.503282][   T10]        __lock_acquire+0xaf0/0x1570
[  516.503410][   T10]        lock_acquire.part.0+0xeb/0x330
[  516.503533][   T10]        _raw_spin_lock+0x30/0x40
[  516.503659][   T10]        tw_timer_handler+0xe9/0x130
[  516.503780][   T10]        call_timer_fn+0x13b/0x230
[  516.503903][   T10]        __run_timers+0x545/0x810
[  516.504028][   T10]        run_timer_softirq+0x7a/0x1b0
[  516.504152][   T10]        __do_softirq+0x1f8/0x5df
[  516.504277][   T10]        irq_exit_rcu+0x97/0xc0
[  516.504401][   T10]        sysvec_apic_timer_interrupt+0x75/0x80
[  516.504555][   T10]        asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  516.504707][   T10]        kasan_report+0x28/0xf0
[  516.504832][   T10]        memchr_inv+0x23d/0x260
[  516.504955][   T10]        check_bytes_and_report+0x5d/0x150
[  516.505111][   T10]        check_object+0x2b9/0x370
[  516.505236][   T10]        alloc_debug_processing+0xa5/0x1b0
[  516.505391][   T10]        ___slab_alloc+0x92e/0x10a0
[  516.505516][   T10]        __kmalloc+0x34c/0x3c0
[  516.505641][   T10]        p9_fcall_init+0x7d/0x1b0
[  516.505767][   T10]        p9_tag_alloc+0x138/0x700
[  516.505889][   T10]        p9_client_prepare_req+0xe6/0x290
[  516.506019][   T10]        p9_client_rpc+0x18d/0x930
[  516.506142][   T10]        p9_client_clunk+0x74/0xe0
[  516.506265][   T10]        v9fs_dentry_release+0xb9/0x140
[  516.506389][   T10]        __dentry_kill+0x1d9/0x4f0
[  516.506512][   T10]        dput.part.0+0x333/0x6c0
[  516.506636][   T10]        walk_component+0x199/0x4f0
[  516.506768][   T10]        link_path_walk.part.0.constprop.0+0x494/0x9f0
[  516.506919][   T10]        path_openat+0x1be/0x440
[  516.507040][   T10]        do_filp_open+0x1b3/0x3e0
[  516.507161][   T10]        do_sys_openat2+0x122/0x160
[  516.507284][   T10]        __x64_sys_openat+0x123/0x1e0
[  516.507406][   T10]        do_syscall_64+0xc6/0x1e0
[  516.507531][   T10]        entry_SYSCALL_64_after_hwframe+0x72/0x7a
[  516.507687][   T10] 
[  516.507687][   T10] -> #0 ((&tw->tw_timer)){+.-.}-{0:0}:
[  516.507876][   T10]        check_prev_add+0x182/0xce0
[  516.508001][   T10]        validate_chain+0x71d/0x9b0
[  516.508124][   T10]        __lock_acquire+0xaf0/0x1570
[  516.508248][   T10]        lock_acquire.part.0+0xeb/0x330
[  516.508371][   T10]        __timer_delete_sync+0xe1/0x110
[  516.508494][   T10]        inet_twsk_deschedule_put+0xec/0x150
[  516.508646][   T10]        inet_twsk_purge+0x4c8/0x660
[  516.508772][   T10]        tcp_twsk_purge+0x112/0x160
[  516.508895][   T10]        tcp_sk_exit_batch+0x17/0x120
[  516.509022][   T10]        cleanup_net+0x4f3/0xa20
[  516.509146][   T10]        process_one_work+0xe2c/0x1730
[  516.509270][   T10]        worker_thread+0x587/0xd30
[  516.509392][   T10]        kthread+0x28a/0x350
[  516.509515][   T10]        ret_from_fork+0x31/0x70
[  516.509640][   T10]        ret_from_fork_asm+0x1a/0x30
[  516.509766][   T10] 
[  516.509766][   T10] other info that might help us debug this:
[  516.509766][   T10] 
[  516.510004][   T10]  Possible unsafe locking scenario:
[  516.510004][   T10] 
[  516.510185][   T10]        CPU0                    CPU1
[  516.510307][   T10]        ----                    ----
[  516.510428][   T10]   lock(&hashinfo->ehash_locks[i]);
[  516.510551][   T10]                                lock((&tw->tw_timer));
[  516.510705][   T10]                                lock(&hashinfo->ehash_locks[i]);
[  516.510888][   T10]   lock((&tw->tw_timer));
[  516.511013][   T10] 
[  516.511013][   T10]  *** DEADLOCK ***
[  516.511013][   T10] 
[  516.511190][   T10] 4 locks held by kworker/u16:0/10:
[  516.511313][   T10]  #0: ffff8880018fa948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0xda6/0x1730
[  516.511567][   T10]  #1: ffffc900000afda0 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0xde2/0x1730
[  516.511783][   T10]  #2: ffffffff9799de50 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xbc/0xa20
[  516.512002][   T10]  #3: ffff888003c0b998 (&hashinfo->ehash_locks[i]){+.-.}-{2:2}, at: inet_twsk_deschedule_put+0xe0/0x150
[  516.512319][   T10] 
[  516.512319][   T10] stack backtrace:
[  516.512472][   T10] CPU: 2 PID: 10 Comm: kworker/u16:0 Not tainted 6.9.0-rc2-virtme #1
[  516.512656][   T10] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  516.512923][   T10] Workqueue: netns cleanup_net
[  516.513052][   T10] Call Trace:
[  516.513212][   T10]  <TASK>
[  516.513276][   T10]  dump_stack_lvl+0x82/0xd0
[  516.513400][   T10]  check_noncircular+0x2f9/0x3e0
[  516.513521][   T10]  ? __pfx_check_noncircular+0x10/0x10
[  516.513648][   T10]  ? __pfx_stack_trace_save+0x10/0x10
[  516.513837][   T10]  ? alloc_chain_hlocks+0x4e0/0x720
[  516.513959][   T10]  check_prev_add+0x182/0xce0
[  516.514082][   T10]  validate_chain+0x71d/0x9b0
[  516.514205][   T10]  ? __pfx_validate_chain+0x10/0x10
[  516.514391][   T10]  ? hlock_class+0x4e/0x130
[  516.514512][   T10]  ? mark_lock+0x38/0x3e0
[  516.514604][   T10]  __lock_acquire+0xaf0/0x1570
[  516.514728][   T10]  ? __lock_acquire+0xa40/0x1570
[  516.514851][   T10]  ? __timer_delete_sync+0xd3/0x110
[  516.515038][   T10]  lock_acquire.part.0+0xeb/0x330
[  516.515159][   T10]  ? __timer_delete_sync+0xd3/0x110
[  516.515279][   T10]  ? inet_twsk_deschedule_put+0xe0/0x150
[  516.515400][   T10]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  516.515651][   T10]  ? trace_lock_acquire+0x135/0x1c0
[  516.515775][   T10]  ? __timer_delete_sync+0xd3/0x110
[  516.515895][   T10]  ? lock_acquire+0x32/0xc0
[  516.516020][   T10]  ? __timer_delete_sync+0xd3/0x110
[  516.516214][   T10]  __timer_delete_sync+0xe1/0x110
[  516.516334][   T10]  ? __timer_delete_sync+0xd3/0x110
[  516.516453][   T10]  inet_twsk_deschedule_put+0xec/0x150
[  516.516572][   T10]  ? inet_twsk_purge+0x412/0x660
[  516.516692][   T10]  inet_twsk_purge+0x4c8/0x660
[  516.516879][   T10]  ? inet_twsk_purge+0x126/0x660
[  516.516999][   T10]  ? __pfx_inet_twsk_purge+0x10/0x10
[  516.517118][   T10]  ? mark_lock+0x38/0x3e0
[  516.517212][   T10]  tcp_twsk_purge+0x112/0x160
[  516.517399][   T10]  tcp_sk_exit_batch+0x17/0x120
[  516.517520][   T10]  cleanup_net+0x4f3/0xa20
[  516.517640][   T10]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  516.517762][   T10]  ? __pfx_cleanup_net+0x10/0x10
[  516.517947][   T10]  ? trace_lock_acquire+0x135/0x1c0
[  516.518071][   T10]  ? process_one_work+0xde2/0x1730
[  516.518192][   T10]  ? lock_acquire+0x32/0xc0
[  516.518313][   T10]  ? process_one_work+0xde2/0x1730
[  516.518435][   T10]  process_one_work+0xe2c/0x1730
[  516.518621][   T10]  ? __pfx___lock_release+0x10/0x10
[  516.518741][   T10]  ? __pfx_process_one_work+0x10/0x10
[  516.518865][   T10]  ? assign_work+0x16c/0x240
[  516.518987][   T10]  worker_thread+0x587/0xd30
[  516.519178][   T10]  ? __pfx_worker_thread+0x10/0x10
[  516.519299][   T10]  kthread+0x28a/0x350
[  516.519392][   T10]  ? __pfx_kthread+0x10/0x10
[  516.519514][   T10]  ret_from_fork+0x31/0x70
[  516.519698][   T10]  ? __pfx_kthread+0x10/0x10
[  516.519819][   T10]  ret_from_fork_asm+0x1a/0x30
[  516.519942][   T10]  </TASK>

https://netdev-3.bots.linux.dev/vmksft-mptcp-dbg/results/547461/2-mptcp-connect-sh/stderr
-- 
pw-bot: cr

