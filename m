Return-Path: <linux-kernel+bounces-20137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1B6827A6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217B31F23B7D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7745645F;
	Mon,  8 Jan 2024 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GEryDEc2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13D156442
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-211.bstnma.fios.verizon.net [173.48.82.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 408LoGoG030961
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 16:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704750618; bh=612ipWyEhKJegLXqd+Wv1tXsAocoWKzwt4l/qt5KWOc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GEryDEc2+r+b/4FWZamYw8Ak3ferM42W+3Xb7lXL5U8Z3OZeMHMIVp4ip09B065Yl
	 irSrORJP9Trn3jLf6lQxC7I4uApte1cQ+F2durCJdCYizT6v4wSw1JcDyB/d2rh53m
	 PMZEQ7HfJc7sHkMnovirorCVTy9SwUNBgws1qj0HqEwAiYX0i/Lp67Qj7agDOeFDIB
	 2XLtMrGNmbQshQHFQ+bRGGlyNQvEMUh6ISHSdfo96xO7JKuhu/dHTCo/8luzEqGwAl
	 3GI7r1erdvfrbZBLoaOTorGS7XNWY9ODyWgDPxiCcacHWwCXwtOrckdPTNAvIxNijm
	 RyGr91A4jBTBw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D978A15C0276; Mon,  8 Jan 2024 16:50:15 -0500 (EST)
Date: Mon, 8 Jan 2024 16:50:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Stevens <stevensd@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: REGRESSION: lockdep warning triggered by 15b9ce7ecd: virtio_balloon:
 stay awake while adjusting balloon
Message-ID: <20240108215015.GA599905@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, while doing final testing before sending a pull request, I merged
in linux-next, and commit 5b9ce7ecd7: virtio_balloon: stay awake while
adjusting balloon seems to be causing a lockdep warning (see attached)
when running gce-xfstests on a Google Compute Engine e2 VM.  I was not
able to trigger it using kvm-xfstests, but the following command:
"gce-xfstests -C 10 ext4/4k generic/476) was sufficient to triger the
problem.   For more information please see [1] and [2].

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md
[2] https://thunk.org/gce-xfstests

I found it by looking at the git logs, and this commit aroused my
suspicions, and I further testing showed that the lockdep warning was
reproducible with this commit, but not when testing with the
immediately preceeding commit (15b9ce7ecd^).

Cheers,

						- Ted


root: ext4/4k run xfstest generic/476
systemd[1]: Started fstests-generic-476.scope - /usr/bin/bash -c test -w /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj; exec ./tests/generic/476.
kernel: [  399.361181] EXT4-fs (dm-1): mounted filesystem 840e25bd-f650-4819-8562-7eded85ef370 r/w with ordered data mode. Quota mode: none.
systemd[1]: fstests-generic-476.scope: Deactivated successfully.
systemd[1]: fstests-generic-476.scope: Consumed 3min 1.966s CPU time.
systemd[1]: xt\x2dvdb.mount: Deactivated successfully.
kernel: [  537.085404] EXT4-fs (dm-0): unmounting filesystem d3d7a675-f7b6-4384-abec-2e60d885b6da.
systemd[1]: xt\x2dvdc.mount: Deactivated successfully.
kernel: [  540.565870] 
kernel: [  540.567523] ================================
kernel: [  540.572007] WARNING: inconsistent lock state
kernel: [  540.576407] 6.7.0-rc3-xfstests-lockdep-00012-g5b9ce7ecd715 #318 Not tainted
kernel: [  540.583532] --------------------------------
kernel: [  540.587928] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
kernel: [  540.594326] kworker/0:3/329 [HC0[0]:SC0[0]:HE1:SE1] takes:
kernel: [  540.599955] ffff90b280a548c0 (&vb->adjustment_lock){?...}-{2:2}, at: update_balloon_size_func+0x33/0x190
kernel: [  540.609926] {IN-HARDIRQ-W} state was registered at:
kernel: [  540.614935]   __lock_acquire+0x3f2/0xb30
kernel: [  540.618992]   lock_acquire+0xbf/0x2b0
kernel: [  540.622786]   _raw_spin_lock_irqsave+0x43/0x90
kernel: [  540.627366]   virtballoon_changed+0x51/0xd0
kernel: [  540.631947]   virtio_config_changed+0x5a/0x70
kernel: [  540.636437]   vp_config_changed+0x11/0x20
kernel: [  540.640576]   __handle_irq_event_percpu+0x88/0x230
kernel: [  540.645500]   handle_irq_event+0x38/0x80
kernel: [  540.649558]   handle_edge_irq+0x8f/0x1f0
kernel: [  540.653791]   __common_interrupt+0x47/0xf0
kernel: [  540.658106]   common_interrupt+0x79/0xa0
kernel: [  540.661672] EXT4-fs (dm-1): unmounting filesystem 840e25bd-f650-4819-8562-7eded85ef370.
kernel: [  540.663183]   asm_common_interrupt+0x26/0x40
kernel: [  540.663190]   acpi_safe_halt+0x1b/0x30
kernel: [  540.663196]   acpi_idle_enter+0x7b/0xd0
kernel: [  540.663199]   cpuidle_enter_state+0x90/0x4f0
kernel: [  540.688723]   cpuidle_enter+0x2d/0x40
kernel: [  540.692516]   cpuidle_idle_call+0xe4/0x120
kernel: [  540.697036]   do_idle+0x84/0xd0
kernel: [  540.700393]   cpu_startup_entry+0x2a/0x30
kernel: [  540.704588]   rest_init+0xe9/0x180
kernel: [  540.708118]   arch_call_rest_init+0xe/0x30
kernel: [  540.712426]   start_kernel+0x41c/0x4b0
kernel: [  540.716310]   x86_64_start_reservations+0x18/0x30
kernel: [  540.721164]   x86_64_start_kernel+0x8c/0x90
kernel: [  540.725737]   secondary_startup_64_no_verify+0x178/0x17b
kernel: [  540.731432] irq event stamp: 22681
kernel: [  540.734956] hardirqs last  enabled at (22681): [<ffffffff8b4b5158>] _raw_spin_unlock_irq+0x28/0x50
kernel: [  540.744564] hardirqs last disabled at (22680): [<ffffffff8b4b4ded>] _raw_spin_lock_irq+0x5d/0x90
kernel: [  540.753475] softirqs last  enabled at (22076): [<ffffffff8a58cfa1>] srcu_invoke_callbacks+0x101/0x1c0
kernel: [  540.762904] softirqs last disabled at (22072): [<ffffffff8a58cfa1>] srcu_invoke_callbacks+0x101/0x1c0
kernel: [  540.773298] 
kernel: [  540.773298] other info that might help us debug this:
kernel: [  540.780207]  Possible unsafe locking scenario:
kernel: [  540.780207] 
kernel: [  540.786438]        CPU0
kernel: [  540.789007]        ----
kernel: [  540.791766]   lock(&vb->adjustment_lock);
kernel: [  540.796014]   <Interrupt>
kernel: [  540.798778]     lock(&vb->adjustment_lock);
kernel: [  540.803605] 
kernel: [  540.803605]  *** DEADLOCK ***
kernel: [  540.803605] 
kernel: [  540.809840] 2 locks held by kworker/0:3/329:
kernel: [  540.814259]  #0: ffff90b280079148 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_one_work+0x1a6/0x500
kernel: [  540.824952]  #1: ffff9e3b40d1fe50 ((work_completion)(&vb->update_balloon_size_work)){+.+.}-{0:0}, at: process_one_work+0x1a6/0x500
kernel: [  540.837088] 
kernel: [  540.837088] stack backtrace:
kernel: [  540.841584] CPU: 0 PID: 329 Comm: kworker/0:3 Not tainted 6.7.0-rc3-xfstests-lockdep-00012-g5b9ce7ecd715 #318
kernel: [  540.851632] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
kernel: [  540.861148] Workqueue: events_freezable update_balloon_size_func
kernel: [  540.867306] Call Trace:
kernel: [  540.869914]  <TASK>
kernel: [  540.872136]  dump_stack_lvl+0x4a/0x80
kernel: [  540.876012]  mark_lock_irq+0x3a5/0x5a0
kernel: [  540.879973]  ? stack_trace_save+0x55/0x80
kernel: [  540.884105]  ? save_trace+0x66/0x200
kernel: [  540.887894]  mark_lock+0x1f3/0x3f0
kernel: [  540.891417]  mark_usage+0xe1/0x140
kernel: [  540.895060]  __lock_acquire+0x3f2/0xb30
kernel: [  540.899020]  lock_acquire+0xbf/0x2b0
kernel: [  540.902722]  ? update_balloon_size_func+0x33/0x190
kernel: [  540.908073]  ? lock_acquire+0xbf/0x2b0
kernel: [  540.912059]  ? process_one_work+0x1a6/0x500
kernel: [  540.916388]  ? process_one_work+0x1a6/0x500
kernel: [  540.920808]  _raw_spin_lock+0x34/0x80
kernel: [  540.924646]  ? update_balloon_size_func+0x33/0x190
kernel: [  540.929677]  update_balloon_size_func+0x33/0x190
kernel: [  540.934510]  ? process_one_work+0x1a6/0x500
kernel: [  540.939000]  process_one_work+0x20f/0x500
kernel: [  540.943383]  worker_thread+0x1e1/0x3d0
kernel: [  540.947391]  ? __pfx_worker_thread+0x10/0x10
kernel: [  540.952103]  kthread+0xf5/0x130
kernel: [  540.955392]  ? __pfx_kthread+0x10/0x10
kernel: [  540.959290]  ret_from_fork+0x31/0x50
kernel: [  540.963193]  ? __pfx_kthread+0x10/0x10
kernel: [  540.967157]  ret_from_fork_asm+0x1b/0x30
kernel: [  540.971205]  </TASK>
kernel: [  550.008710] EXT4-fs (dm-1): mounted filesystem 840e25bd-f650-4819-8562-7eded85ef370 r/w with ordered data mode. Quota mode: none.
systemd[1]: xt\x2dvdc.mount: Deactivated successfully.
kernel: [  550.033770] EXT4-fs (dm-1): unmounting filesystem 840e25bd-f650-4819-8562-7eded85ef370.
root: gce-xfstests: checking for hook post-xfstests
root: gce-xfstests: checking for hook pre-xfstests

