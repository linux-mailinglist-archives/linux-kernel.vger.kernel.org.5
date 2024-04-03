Return-Path: <linux-kernel+bounces-130398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB49897788
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996BF28E8E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053FF1552E4;
	Wed,  3 Apr 2024 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G9l9VRhW"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C101C33
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166954; cv=none; b=ZHK5UtXQAmhehdNBHdER/9WE4eVWJy98QSVQ01oCuuozwrUrzpD6hfOXAdY63/3mbp17iDfFHHPQtLmodQtTQCrS4Vo0Qn+4a9CS7besqw4C0fS+N7ssCyR5iE0y0Ag6PMjTnn6ucVQEB+x23N1ehpoDfNe4ZDoBIxVL9YwF0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166954; c=relaxed/simple;
	bh=xwvMlP4tMnKyr3gploL4BrqBVe0RNoEpflcqTvAshnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=cbdBQvFA8F4N0li2ymxN5pt+bv9nP0CcccL6QUQwXKOk7xw8zpmZQY8PTjNK9S0zwcOCTc+CdlBeRxMtmFydLP6aky06SRYe2TyrN3LxIsgQLJRY/QqWJtTJMwTLndwnOlvVJM2kGmXMcajyaphGW5mLkUXJmmb28tc83/KgGNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G9l9VRhW; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <754174bc-9741-447e-aa3e-368e10091359@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712166950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GSA9lwSTKPKamFNjAQqvIE7CLAGnQkYXmuPofCwMKC0=;
	b=G9l9VRhW3EudHVXvIqKndkMUU7o7mFEB0z/Dk/SqO6bMa3xIU5FFgiolPO2YVSf5mO8unY
	TS4KDffcH1V8iAeWa0RypMuCYJyglHjpXh1ymzkEJFPAnVe5Xgh3QSg8uW0gxaFcb+g+6l
	qZfBJHdqfYYj3GQGVKCwy/w2v29nQV4=
Date: Wed, 3 Apr 2024 10:55:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in
 percpu_array_map_lookup_percpu_elem
To: syzbot <syzbot+aca389a8a7da35c070ce@syzkaller.appspotmail.com>
References: <00000000000069edc606152059d4@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
In-Reply-To: <00000000000069edc606152059d4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/2/24 10:22 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    39cd87c4eb2b Linux 6.9-rc2
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13891cc5180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5112b3f484393436
> dashboard link: https://syzkaller.appspot.com/bug?extid=aca389a8a7da35c070ce
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11629a19180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169e86e5180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/dba7eac545d2/disk-39cd87c4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ddf1c8e07b17/vmlinux-39cd87c4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/808527761eab/bzImage-39cd87c4.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+aca389a8a7da35c070ce@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in percpu_array_map_lookup_percpu_elem+0x1cb/0x200 kernel/bpf/arraymap.c:257
>   percpu_array_map_lookup_percpu_elem+0x1cb/0x200 kernel/bpf/arraymap.c:257
>   ____bpf_map_lookup_percpu_elem kernel/bpf/helpers.c:133 [inline]
>   bpf_map_lookup_percpu_elem+0x67/0x90 kernel/bpf/helpers.c:130
>   ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
>   __bpf_prog_run288+0xb5/0xe0 kernel/bpf/core.c:2237
>   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>   __bpf_prog_run include/linux/filter.h:657 [inline]
>   bpf_prog_run include/linux/filter.h:664 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>   bpf_trace_run8+0x1bd/0x3a0 kernel/trace/bpf_trace.c:2426
>   __bpf_trace_jbd2_handle_stats+0x51/0x70 include/trace/events/jbd2.h:210
>   trace_jbd2_handle_stats include/trace/events/jbd2.h:210 [inline]
>   jbd2_journal_stop+0x1157/0x12c0 fs/jbd2/transaction.c:1869
>   __ext4_journal_stop+0x115/0x310 fs/ext4/ext4_jbd2.c:134
>   ext4_do_writepages+0x1c3c/0x62e0 fs/ext4/inode.c:2692
>   ext4_writepages+0x312/0x830 fs/ext4/inode.c:2768
>   do_writepages+0x427/0xc30 mm/page-writeback.c:2612
>   __writeback_single_inode+0x10d/0x12c0 fs/fs-writeback.c:1650
>   writeback_sb_inodes+0xb48/0x1be0 fs/fs-writeback.c:1941
>   __writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2012
>   wb_writeback+0x4da/0xdf0 fs/fs-writeback.c:2119
>   wb_check_old_data_flush fs/fs-writeback.c:2223 [inline]
>   wb_do_writeback fs/fs-writeback.c:2276 [inline]
>   wb_workfn+0x110c/0x1940 fs/fs-writeback.c:2304
>   process_one_work kernel/workqueue.c:3254 [inline]
>   process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3335
>   worker_thread+0xea5/0x1560 kernel/workqueue.c:3416
>   kthread+0x3e2/0x540 kernel/kthread.c:388
>   ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> 
> Local variable stack created at:
>   __bpf_prog_run288+0x45/0xe0 kernel/bpf/core.c:2237
>   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>   __bpf_prog_run include/linux/filter.h:657 [inline]
>   bpf_prog_run include/linux/filter.h:664 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>   bpf_trace_run8+0x1bd/0x3a0 kernel/trace/bpf_trace.c:2426
> 
> CPU: 1 PID: 1070 Comm: kworker/u8:7 Not tainted 6.9.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Workqueue: writeback wb_workfn (flush-8:0)
> =====================================================

#syz dup: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem


