Return-Path: <linux-kernel+bounces-120164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B79588D389
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305251F31411
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D0C1B94D;
	Wed, 27 Mar 2024 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XtoXeY09"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04618FBF3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711500844; cv=none; b=OUaAihZAyBlSiRlKu/Fn1sMySJZWLsDfZnmw8RzasVUrtxPT1sczWWvZJyD+cJ3poNPGkNIS/YmdLdosIagEGy3aoMX6K6OUcsKEmFvpnwfKae5nKSxFt+X6nzPWsPZQzEjB4EEuGCUegNrlwSZmxsSEHa1jTOHalR4EZZgCDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711500844; c=relaxed/simple;
	bh=1WqnUqENqtLDzPfSULJFlgoYt8LJn4Bwnw0VymQ2POQ=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:Cc:To:
	 In-Reply-To:Content-Type; b=nhI1doYFs2y1hAsOrH1UNKrzfbVSjtAHut2uZACBvYznslD+OReRdhoqlQU4mnLhyKh1mFr2n5NZaLafZmWoWsl4wWqCzOs+FWCtBaO1sBMP26N31Yi3JJohrSTBaiaGv349UJxCZC/cSH8PjTtk26oHxqnbE82wx/hFraUKgw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XtoXeY09; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a402206e-a9c9-40bd-bf78-710054506071@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711500839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsAzpIR5m4icJqztze3ObvV0i67LfQFqEEAl5UkK2p4=;
	b=XtoXeY09v906+vCrTnKypyV3mnIl1ql2vkYUZIKyIV+wLnWXsO5YLOdoFI/6NU9ykcRgXo
	iE38VMWP8VzNageQRp8MkVnxcxKWZyD+LFrd6gir7NKUo1jcGKbURK4XhkYnFpAeIop2U7
	Wz/Y3F+rV++Rvp2F2AplP9YGobj0di0=
Date: Tue, 26 Mar 2024 17:53:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem
Content-Language: en-US
References: <0000000000006f876b061478e878@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: syzbot <syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com>,
 bpf@vger.kernel.org, davem@davemloft.net, eddyz87@gmail.com,
 haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 yonghong.song@linux.dev
In-Reply-To: <0000000000006f876b061478e878@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/25/24 2:36 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5e74df2f8f15 Merge tag 'x86-urgent-2024-03-24' of git://gi..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=148872a5180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e6bd769cb793b98a
> dashboard link: https://syzkaller.appspot.com/bug?extid=1a3cf6f08d68868f9db3
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15921a6e180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e081f1180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1a82880723a7/disk-5e74df2f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fd3046ac43b9/vmlinux-5e74df2f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2097be59cbc1/bzImage-5e74df2f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in __dev_map_lookup_elem kernel/bpf/devmap.c:441 [inline]
> BUG: KMSAN: uninit-value in dev_map_lookup_elem+0xf3/0x170 kernel/bpf/devmap.c:796
>   __dev_map_lookup_elem kernel/bpf/devmap.c:441 [inline]
>   dev_map_lookup_elem+0xf3/0x170 kernel/bpf/devmap.c:796
>   ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
>   bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
>   ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
>   __bpf_prog_run256+0xb5/0xe0 kernel/bpf/core.c:2237

It should be in the interpreter mode.

The C reproducer is trying to run the following bpf prog:

    0: (18) r0 = 0x0
    2: (18) r1 = map[id:49]
    4: (b7) r8 = 16777216
    5: (7b) *(u64 *)(r10 -8) = r8
    6: (bf) r2 = r10
    7: (07) r2 += -229
            ^^^^^^^^^^

    8: (b7) r3 = 8
    9: (b7) r4 = 0
   10: (85) call dev_map_lookup_elem#1543472
   11: (95) exit

I think this KMSAN report (and a few others related to lookup/delete_elem) 
should only happen in the interpreter mode.

Does it worth to suppress it by always initializing the stack in the interpreter 
mode considering the interpreter is not very speed sensitive ?


>   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>   __bpf_prog_run include/linux/filter.h:657 [inline]
>   bpf_prog_run include/linux/filter.h:664 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>   bpf_trace_run5+0x16f/0x350 kernel/trace/bpf_trace.c:2423
>   __bpf_trace_ext4_remove_blocks+0x45/0x60 include/trace/events/ext4.h:1984
>   __traceiter_ext4_remove_blocks+0xb5/0x170 include/trace/events/ext4.h:1984
>   trace_ext4_remove_blocks include/trace/events/ext4.h:1984 [inline]
>   ext4_remove_blocks fs/ext4/extents.c:2463 [inline]
>   ext4_ext_rm_leaf fs/ext4/extents.c:2686 [inline]
>   ext4_ext_remove_space+0x4e30/0x7e00 fs/ext4/extents.c:2934
>   ext4_ext_truncate+0x1e3/0x390 fs/ext4/extents.c:4440
>   ext4_truncate+0x14c6/0x1e10 fs/ext4/inode.c:4146
>   ext4_evict_inode+0x1886/0x24d0 fs/ext4/inode.c:258
>   evict+0x3ae/0xa60 fs/inode.c:667
>   iput_final fs/inode.c:1741 [inline]
>   iput+0x9ca/0xe10 fs/inode.c:1767
>   d_delete_notify include/linux/fsnotify.h:307 [inline]
>   vfs_rmdir+0x53c/0x790 fs/namei.c:4222
>   do_rmdir+0x630/0x8b0 fs/namei.c:4268
>   __do_sys_rmdir fs/namei.c:4287 [inline]
>   __se_sys_rmdir fs/namei.c:4285 [inline]
>   __x64_sys_rmdir+0x78/0xb0 fs/namei.c:4285
>   do_syscall_64+0xd5/0x1f0
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> Local variable stack created at:
>   __bpf_prog_run256+0x45/0xe0 kernel/bpf/core.c:2237
>   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>   __bpf_prog_run include/linux/filter.h:657 [inline]
>   bpf_prog_run include/linux/filter.h:664 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>   bpf_trace_run5+0x16f/0x350 kernel/trace/bpf_trace.c:2423
> 
> CPU: 0 PID: 5017 Comm: syz-executor365 Not tainted 6.8.0-syzkaller-13236-g5e74df2f8f15 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> =====================================================

> 


