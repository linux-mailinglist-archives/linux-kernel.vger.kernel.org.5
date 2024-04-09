Return-Path: <linux-kernel+bounces-136260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6326789D207
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C24C2B23F8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FC56BB20;
	Tue,  9 Apr 2024 05:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rt5oiIvf"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506A29CE0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 05:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712641056; cv=none; b=jsrrLzAurUCg4RgSFTBpVeozzncQJM6Esxqtv2VS7ncUeouGDWhKn2NRi7s9cZlgBncOp4ZA4agCnle/5a9OPJLflebwRC03vIx+ZhgIxWEVMuk+ZC+N8JNyuQ9Er7HsOULvu7FL9YQ8WJ/bk7GsfXt6RVUPyGDEyXLNYxK+2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712641056; c=relaxed/simple;
	bh=rAbRGgpUqpqC5AoI01CmDtL5z+AL13jZdTSG3M/3s6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=d+FZNQSbkx4qDyvfWr9MwvgKPSm6dBWQ4t04ZsjZy2vB5bwMX9ubvEv0zZ9N/JtyNjr6s9ZTBKguK96m0D+cI7Nr0QkDBZZkq87F8dg2G99mHWIJHlKnJsFB26xUoBCLc5ZZk6XoyBIri8MS6qagvLASej/yGtX5HbZ+0LW7z04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rt5oiIvf; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fb458efd-0bc9-4a9d-aff1-e979b7abc710@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712641052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXLr+E8y8RLJnLQzg5QVmlMDEV9DDDPeZaSPPyLguZs=;
	b=rt5oiIvfOpVjBLA9Sk9FPRs6XJ7dAlN7cHzEdwfCEsZnyv4GanAUjxMtgEKKuq7Wl2IzVA
	ItFHwIx5i4BKPKAVOFaWCwxP2BLt6R+S0JBAIHZ+xmW+bnDOby3ZgOWDAMXPDrRKdPg5ve
	46cCvwrfVv0GO/fOupJbns/F1VekUTQ=
Date: Mon, 8 Apr 2024 22:37:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in
 percpu_array_map_lookup_elem
To: syzbot <syzbot+5e23b0df3b12b8b215b7@syzkaller.appspotmail.com>
References: <0000000000004139c80614076a2c@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
In-Reply-To: <0000000000004139c80614076a2c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/19/24 11:12 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14e351c9180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aa3d79b689f321c8
> dashboard link: https://syzkaller.appspot.com/bug?extid=5e23b0df3b12b8b215b7
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14498006180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e4d769180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/eaca555a0446/disk-e5eb28f6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4fbf90fa0d23/vmlinux-e5eb28f6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bbae0627aafd/bzImage-e5eb28f6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5e23b0df3b12b8b215b7@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in percpu_array_map_lookup_elem+0x142/0x160 kernel/bpf/arraymap.c:243
>   percpu_array_map_lookup_elem+0x142/0x160 kernel/bpf/arraymap.c:243
>   ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
>   bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
>   ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
>   __bpf_prog_run64+0xb5/0xe0 kernel/bpf/core.c:2236

#syz dup: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem

>   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>   __bpf_prog_run include/linux/filter.h:657 [inline]
>   bpf_prog_run include/linux/filter.h:664 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>   bpf_trace_run3+0x132/0x320 kernel/trace/bpf_trace.c:2421
>   __bpf_trace_ext4_es_insert_delayed_block+0x34/0x50 include/trace/events/ext4.h:2481
>   trace_ext4_es_insert_delayed_block include/trace/events/ext4.h:2481 [inline]
>   ext4_es_insert_delayed_block+0x11e1/0x1290 fs/ext4/extents_status.c:2082
>   ext4_insert_delayed_block fs/ext4/inode.c:1676 [inline]
>   ext4_da_map_blocks fs/ext4/inode.c:1777 [inline]
>   ext4_da_get_block_prep+0x1714/0x1d30 fs/ext4/inode.c:1817
>   ext4_block_write_begin+0x749/0x1df0 fs/ext4/inode.c:1055
>   ext4_da_write_begin+0x889/0xec0 fs/ext4/inode.c:2894
>   generic_perform_write+0x400/0xc60 mm/filemap.c:3974
>   ext4_buffered_write_iter+0x564/0xaa0 fs/ext4/file.c:299
>   ext4_file_write_iter+0x208/0x3450
>   call_write_iter include/linux/fs.h:2108 [inline]
>   new_sync_write fs/read_write.c:497 [inline]
>   vfs_write+0xb63/0x1520 fs/read_write.c:590
>   ksys_write+0x20f/0x4c0 fs/read_write.c:643
>   __do_sys_write fs/read_write.c:655 [inline]
>   __se_sys_write fs/read_write.c:652 [inline]
>   __x64_sys_write+0x93/0xe0 fs/read_write.c:652
>   do_syscall_64+0xd5/0x1f0
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> Local variable stack created at:
>   __bpf_prog_run64+0x45/0xe0 kernel/bpf/core.c:2236
>   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>   __bpf_prog_run include/linux/filter.h:657 [inline]
>   bpf_prog_run include/linux/filter.h:664 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>   bpf_trace_run3+0x132/0x320 kernel/trace/bpf_trace.c:2421
> 
> CPU: 1 PID: 5001 Comm: syz-executor118 Not tainted 6.8.0-syzkaller-09791-ge5eb28f6d1af #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> =====================================================


