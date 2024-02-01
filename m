Return-Path: <linux-kernel+bounces-48476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D16D845C8A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB4C1C2BED6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2346DD0B;
	Thu,  1 Feb 2024 16:10:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE2626C3;
	Thu,  1 Feb 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803828; cv=none; b=Gh1PfOy0VcU1Mk5OU6KT7refl8XXlZVAv0FHhlcV3l9cRZwHJf0tv1wAM86cObrKfPE0QqIy6Ioxh3QOSUoPoCUyBYSvvAo6TVe2E3O/Dsnq+0uVGfY3iv2a+AWDJuAK/YDlRhTSQ8o8IfwL6DJULEOd3MXEh+Rn6Zys7cu+YEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803828; c=relaxed/simple;
	bh=/ZG0ehtuMNnNxihYcBVpjgZFD86ewUhnPYNdeA/+8/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axZVAJBaD2gIKoXtbyIIabHb38csX/I9luUtQZ/XLFf25lrLgsumpsKfo4gZB66fjuDqkkMCrufQO04wBN5hZpIh7y6wi6N+m9zFVsMGJjyo6Y/m9DdOGUaYx7QhE3CR/mBnCNZJu1SFJzCau43YyA9Fj9ZjbOP6QXC/+2dYrJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06273C433F1;
	Thu,  1 Feb 2024 16:10:26 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:10:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] tracing/timerlat: Move hrtimer_init to timerlat_fd
 open()
Message-ID: <20240201111043.3213bf7c@gandalf.local.home>
In-Reply-To: <05c12163-d348-4615-a9e3-f36787629e0e@kernel.org>
References: <7324dd3fc0035658c99b825204a66049389c56e3.1706798888.git.bristot@kernel.org>
	<2024020109-duffel-finally-4f0b@gregkh>
	<05c12163-d348-4615-a9e3-f36787629e0e@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 17:02:56 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> On 2/1/24 16:44, Greg KH wrote:
> > On Thu, Feb 01, 2024 at 04:13:39PM +0100, Daniel Bristot de Oliveira wrote:  
> >> Currently, the timerlat's hrtimer is initialized at the first read of
> >> timerlat_fd, and destroyed at close(). It works, but it causes an error
> >> if the user program open() and close() the file without reading.  
> > 
> > What error exactly happens?  Userspace, or the kernel crashes?  
> 
> sorry, kernel crash:
> 
> # echo NO_OSNOISE_WORKLOAD > /sys/kernel/debug/tracing/osnoise/options
> # echo timerlat > /sys/kernel/debug/tracing/current_tracer
> 
> # cat ./timerlat_load.py
> #!/usr/bin/env python3
> 
> timerlat_fd = open("/sys/kernel/tracing/osnoise/per_cpu/cpu0/timerlat_fd", 'r')
> timerlat_fd.close();
> 
> # ./taskset -c 0 ./timerlat_load.py
> <BOOM>
> 
> [ 6401.611374] BUG: kernel NULL pointer dereference, address: 0000000000000010
> [ 6401.611786] #PF: supervisor read access in kernel mode
> [ 6401.612081] #PF: error_code(0x0000) - not-present page
> [ 6401.612376] PGD 0 P4D 0
> [ 6401.612495] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [ 6401.612690] CPU: 1 PID: 2673 Comm: python3 Not tainted 6.6.13-200.fc39.x86_64 #1
> [ 6401.613011] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39 04/01/2014
> [ 6401.613379] RIP: 0010:hrtimer_active+0xd/0x50
> [ 6401.613577] Code: 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 57 30 <8b> 42 10 a8 01 74 09 f3 90 8b 42 10 a8 01 75 f7 80 7f 38 00 75 1d
> [ 6401.614374] RSP: 0018:ffffb031009b7e10 EFLAGS: 00010286
> [ 6401.614604] RAX: 000000000002db00 RBX: ffff9118f786db08 RCX: 0000000000000000
> [ 6401.614914] RDX: 0000000000000000 RSI: ffff9117a0e64400 RDI: ffff9118f786db08
> [ 6401.615225] RBP: ffff9118f786db80 R08: ffff9117a0ddd420 R09: ffff9117804d4f70
> [ 6401.615534] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9118f786db08
> [ 6401.615846] R13: ffff91178fdd5e20 R14: ffff9117840978c0 R15: 0000000000000000
> [ 6401.616157] FS:  00007f2ffbab1740(0000) GS:ffff9118f7840000(0000) knlGS:0000000000000000
> [ 6401.616508] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6401.616765] CR2: 0000000000000010 CR3: 00000001b402e000 CR4: 0000000000750ee0
> [ 6401.617075] PKRU: 55555554
> [ 6401.617197] Call Trace:
> [ 6401.617309]  <TASK>
> [ 6401.617407]  ? __die+0x23/0x70
> [ 6401.617548]  ? page_fault_oops+0x171/0x4e0
> [ 6401.617983]  ? srso_alias_return_thunk+0x5/0x7f
> [ 6401.618389]  ? avc_has_extended_perms+0x237/0x520
> [ 6401.618800]  ? exc_page_fault+0x7f/0x180
> [ 6401.619176]  ? asm_exc_page_fault+0x26/0x30
> [ 6401.619563]  ? hrtimer_active+0xd/0x50
> [ 6401.619926]  hrtimer_cancel+0x15/0x40
> [ 6401.620286]  timerlat_fd_release+0x48/0xe0
> [ 6401.620666]  __fput+0xf5/0x290
> [ 6401.621004]  __x64_sys_close+0x3d/0x80
> [ 6401.621370]  do_syscall_64+0x60/0x90
> [ 6401.621730]  ? srso_alias_return_thunk+0x5/0x7f
> [ 6401.622129]  ? __x64_sys_ioctl+0x72/0xd0
> [ 6401.622503]  ? srso_alias_return_thunk+0x5/0x7f
> [ 6401.622902]  ? syscall_exit_to_user_mode+0x2b/0x40
> [ 6401.623309]  ? srso_alias_return_thunk+0x5/0x7f
> [ 6401.623703]  ? do_syscall_64+0x6c/0x90
> [ 6401.624063]  ? srso_alias_return_thunk+0x5/0x7f
> [ 6401.624457]  ? exit_to_user_mode_prepare+0x142/0x1f0
> [ 6401.624868]  ? srso_alias_return_thunk+0x5/0x7f
> [ 6401.625262]  ? syscall_exit_to_user_mode+0x2b/0x40
> [ 6401.625663]  ? srso_alias_return_thunk+0x5/0x7f
> [ 6401.626051]  ? do_syscall_64+0x6c/0x90
> [ 6401.626404]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 6401.626810] RIP: 0033:0x7f2ffb321594
> [ 6401.627164] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d d5 cd 0d 00 00 74 13 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 48 89 e5 48 83 ec 10 89 7d
> [ 6401.628345] RSP: 002b:00007ffe8d8eef18 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> [ 6401.628867] RAX: ffffffffffffffda RBX: 00007f2ffba4e668 RCX: 00007f2ffb321594
> [ 6401.629372] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> [ 6401.629879] RBP: 00007ffe8d8eef40 R08: 0000000000000000 R09: 0000000000000000
> [ 6401.630384] R10: 55c926e3167eae79 R11: 0000000000000202 R12: 0000000000000003
> [ 6401.630889] R13: 00007ffe8d8ef030 R14: 0000000000000000 R15: 00007f2ffba4e668
> [ 6401.631394]  </TASK>
> [ 6401.631691] Modules linked in: tls nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink qrtr sunrpc pktcdvd intel_rapl_msr snd_hda_codec_generic intel_rapl_common ledtrig_audio snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_hwdep snd_pcm kvm_amd iTCO_wdt snd_timer intel_pmc_bxt ccp joydev iTCO_vendor_support kvm irqbypass i2c_i801 snd i2c_smbus soundcore lpc_ich virtio_balloon loop zram crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 virtio_net virtio_gpu virtio_console virtio_blk net_failover failover virtio_dma_buf serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua fuse dm_multipath qemu_fw_cfg
> [ 6401.636126] CR2: 0000000000000010
> [ 6401.636482] ---[ end trace 0000000000000000 ]---
> [ 6401.636891] RIP: 0010:hrtimer_active+0xd/0x50
> [ 6401.637288] Code: 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 57 30 <8b> 42 10 a8 01 74 09 f3 90 8b 42 10 a8 01 75 f7 80 7f 38 00 75 1d
> [ 6401.638507] RSP: 0018:ffffb031009b7e10 EFLAGS: 00010286
> [ 6401.638951] RAX: 000000000002db00 RBX: ffff9118f786db08 RCX: 0000000000000000
> [ 6401.639478] RDX: 0000000000000000 RSI: ffff9117a0e64400 RDI: ffff9118f786db08
> [ 6401.640005] RBP: ffff9118f786db80 R08: ffff9117a0ddd420 R09: ffff9117804d4f70
> [ 6401.640535] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9118f786db08
> [ 6401.641067] R13: ffff91178fdd5e20 R14: ffff9117840978c0 R15: 0000000000000000
> [ 6401.641601] FS:  00007f2ffbab1740(0000) GS:ffff9118f7840000(0000) knlGS:0000000000000000
> [ 6401.642174] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6401.642653] CR2: 0000000000000010 CR3: 00000001b402e000 CR4: 0000000000750ee0
> [ 6401.643193] PKRU: 55555554
> [ 6401.643548] note: python3[2673] exited with irqs disabled
> 

I usually include crash data like the above in the change log too. But
clean it up a little. At least strip the timestamps. (Note, I do that with
emacs, by cut and pasting the dump in a scratch buffer and then using
vertical cut with "Ctrl-X r-k").

-- Steve


