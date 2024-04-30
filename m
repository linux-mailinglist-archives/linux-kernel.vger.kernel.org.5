Return-Path: <linux-kernel+bounces-163541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888458B6CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9D04B2268B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DBD4207D;
	Tue, 30 Apr 2024 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="c7vHXTZa"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD153EA73
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465992; cv=none; b=mQYaWp0HQoKbQUCKEWZLxQhvoUUHPdNFYiVixXkLXAD5jR+yN3xuA4DrRlN/xpQxbHbF/hz1vxOHqciPCP28ZA49gv/5BxRj5mXzKkMy1LV6AUeDgVJFjy8N4Q+zNkleUt+a+dHalzpIMPjT8BPchIeKJiQ/3txyoafr78Ktb+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465992; c=relaxed/simple;
	bh=6KYcdaW5AJOuKrCAbQiANDQ3oufjExknfaTGdAiLQTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POf8w/NNwNybsg0U0Fyd5AwxNHkeM0w8BpYNbtNcCJd+m6IkyCFmdgoIeOZbYlIXXOCHznGNcpDd58iN4i2VRMfbDBYGrbF4B1TCDZIumkeerf2qRF7xkysqbO4smXXGT8DyhUTITmMOB9xoObQBFvpnxGqElQqd04dv3/JgjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c7vHXTZa; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a587831809eso641301666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714465988; x=1715070788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPkVFP7Lh42TFOUAbrSl+hJmc87Aue0/QUNIQ8XD5Q0=;
        b=c7vHXTZarX9VW3hDPVf/5rvryI+zxhvz09DvZk7jFZ6k6WE4eKDCdAQGtLWuyzXyes
         kGl9SxHdIS/lDtGP35tWHekQ2le/8sbNAB1OzmpKiA+Hc8p98yQUhN2exU+TAzNS12o0
         cwUduZkz/KAv9hrZw5M/6j31lgwmLYz4gMF910lFvrqcIYauaxggDagREfHXX+QasNak
         yswmjkPqSOV0nNV8mzX7CEeRc8wls1/0gek450I60zkGJwdJOx2jULxOIxmipAbWj5lp
         Kg2YRpqHIYDuAIJcuitLWInJi7yO6IuKcpSxfmxg+yU8xTQxZPezBpfXM9nyexlNBWJQ
         6GCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714465988; x=1715070788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPkVFP7Lh42TFOUAbrSl+hJmc87Aue0/QUNIQ8XD5Q0=;
        b=XgrvtW+cADD3PaWDcLpJU5Boxk393PzPxb8DfbKTkDR2rTUDRVyXM0UiieWr0Nex3G
         TJACh1efLa4QK42n+YNnpiZekDwMmu5nPpxZ8AEtndrd4zVBZ+M31+VXBfWsecEHAeBn
         FjO/WNCCAX0P0lrH35ZNNAzm84iPbFr04GzN1qXuRlGH7qxn36HPeFSNF9GNM5WrL+Jl
         vJGU54TWwu14mpRaj7/P7tIpUCxH6ZBeWAt+Z2h0AROwAdb/6LRU3SBwTis4wud8X6iz
         XI9KWIxYBDXYqiQ2yJPm8jyBQ/X+5+j/1998LlnQDegblKy279+3D0KD/RjMqwDhp5EI
         OKCA==
X-Forwarded-Encrypted: i=1; AJvYcCVDEXFucA5VMsesANH9/LxB4VKihHhONH2a0o6olbzWGAMbPvRTRwoW0j/sUV+6ug7TC/YniK0JFr4Tpx6Z0bjWxueGSFiBWyZqE0n7
X-Gm-Message-State: AOJu0YxHYGaaY2M3S1B9mUsi1fp19QtXRMpXusEMDsYpnAeRKF/OimX8
	dPCFQTQMtZHxZCkZztOwez5zomGaXUICjxNbC3G5AlPYe6RlHaUgpDkPNjNeVD0SGmYrsYwjP2r
	MpMuSfFmwT3B12vf44p3jPwPejTRCp32LDFur
X-Google-Smtp-Source: AGHT+IEPhiQHehjJBW+klsUM22MQCZFXx0ThaEn6Qq/yxxtdIPTrErrC2XqydQUnCNSM8OgbWyEQjR+3aViK6Pq1OaI=
X-Received: by 2002:a17:906:f20e:b0:a58:fabc:4a02 with SMTP id
 gt14-20020a170906f20e00b00a58fabc4a02mr4671803ejb.39.1714465988245; Tue, 30
 Apr 2024 01:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000002ecbdb06174a1d9a@google.com>
In-Reply-To: <0000000000002ecbdb06174a1d9a@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 30 Apr 2024 01:32:30 -0700
Message-ID: <CAJD7tkYrRAK7rjfyArbdq8=Y6CV-T_YbL+SvBEGU8_MV3opbqg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KMSAN: uninit-value in zswap_rb_insert
To: syzbot <syzbot+9c9d60f1b20b22ce218a@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:02=E2=80=AFPM syzbot
<syzbot+9c9d60f1b20b22ce218a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e33c4963bf53 Merge tag 'nfsd-6.9-5' of git://git.kernel.o=
r..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D123d5a0f18000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D776c05250f36d=
55c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D9c9d60f1b20b22c=
e218a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a10175188ebb/dis=
k-e33c4963.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/abe743417d16/vmlinu=
x-e33c4963.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fb10cccc9909/b=
zImage-e33c4963.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+9c9d60f1b20b22ce218a@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in zswap_rb_insert+0x1e9/0x330 mm/zswap.c:842

I am not sure how this could happen. The report is complaining about
the access in the loop condition AFAICT:

while (*link) { /* here */
.
}

*link should start as root->rb_node (which should be NULL as it is
static data), then be updated to point at a zswap_entry->rbnode as
entries get added. *link should keep then be updated to values at
zswap_entry->rbnode->{left/right}.

Although entry->rbnode->{left/right} are not initialized when
allocated by zswap_entry_cache_alloc() as the report mentions, they
are initialized in zswap_rb_insert()->rb_link_node() when they are
added to the tree.

Also, this code is removed with the xarray conversion anyway.

>  zswap_rb_insert+0x1e9/0x330 mm/zswap.c:842
>  zswap_store+0x22f2/0x2ca0 mm/zswap.c:1591
>  swap_writepage+0x126/0x4c0 mm/page_io.c:198
>  pageout mm/vmscan.c:660 [inline]
>  shrink_folio_list+0x4a55/0x7910 mm/vmscan.c:1323
>  evict_folios+0x9d7f/0xcc20 mm/vmscan.c:4537
>  try_to_shrink_lruvec+0x160e/0x1a50 mm/vmscan.c:4733
>  shrink_one+0x66f/0xd40 mm/vmscan.c:4772
>  shrink_many mm/vmscan.c:4835 [inline]
>  lru_gen_shrink_node mm/vmscan.c:4935 [inline]
>  shrink_node+0x4856/0x55f0 mm/vmscan.c:5894
>  shrink_zones mm/vmscan.c:6152 [inline]
>  do_try_to_free_pages+0x820/0x2570 mm/vmscan.c:6214
>  try_to_free_pages+0xb7b/0x1820 mm/vmscan.c:6449
>  __perform_reclaim mm/page_alloc.c:3774 [inline]
>  __alloc_pages_direct_reclaim mm/page_alloc.c:3796 [inline]
>  __alloc_pages_slowpath+0x1035/0x31a0 mm/page_alloc.c:4202
>  __alloc_pages+0xacf/0xe70 mm/page_alloc.c:4588
>  alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
>  vma_alloc_folio+0x418/0x680 mm/mempolicy.c:2303
>  do_cow_fault mm/memory.c:4918 [inline]
>  do_fault mm/memory.c:5026 [inline]
>  do_pte_missing mm/memory.c:3880 [inline]
>  handle_pte_fault mm/memory.c:5300 [inline]
>  __handle_mm_fault mm/memory.c:5441 [inline]
>  handle_mm_fault+0x4f2f/0xce00 mm/memory.c:5606
>  do_user_addr_fault arch/x86/mm/fault.c:1413 [inline]
>  handle_page_fault arch/x86/mm/fault.c:1505 [inline]
>  exc_page_fault+0x2a0/0x730 arch/x86/mm/fault.c:1563
>  asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:623
>  rep_stos_alternative+0x40/0x80 arch/x86/lib/clear_page_64.S:92
>  load_elf_binary+0x212e/0x4d30 fs/binfmt_elf.c:1132
>  search_binary_handler fs/exec.c:1778 [inline]
>  exec_binprm fs/exec.c:1820 [inline]
>  bprm_execve+0xc57/0x21c0 fs/exec.c:1872
>  do_execveat_common+0xceb/0xd70 fs/exec.c:1979
>  do_execve fs/exec.c:2053 [inline]
>  __do_sys_execve fs/exec.c:2129 [inline]
>  __se_sys_execve fs/exec.c:2124 [inline]
>  __x64_sys_execve+0xf4/0x130 fs/exec.c:2124
>  x64_sys_call+0x1612/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:=
60
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
>  __alloc_pages_node include/linux/gfp.h:238 [inline]
>  alloc_pages_node include/linux/gfp.h:261 [inline]
>  alloc_slab_page mm/slub.c:2175 [inline]
>  allocate_slab mm/slub.c:2338 [inline]
>  new_slab+0x2de/0x1400 mm/slub.c:2391
>  ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
>  __slab_alloc mm/slub.c:3610 [inline]
>  __slab_alloc_node mm/slub.c:3663 [inline]
>  slab_alloc_node mm/slub.c:3835 [inline]
>  kmem_cache_alloc_node+0x6ea/0xc50 mm/slub.c:3888
>  zswap_entry_cache_alloc mm/zswap.c:874 [inline]
>  zswap_store+0xb26/0x2ca0 mm/zswap.c:1535
>  swap_writepage+0x126/0x4c0 mm/page_io.c:198
>  pageout mm/vmscan.c:660 [inline]
>  shrink_folio_list+0x4a55/0x7910 mm/vmscan.c:1323
>  evict_folios+0x9d7f/0xcc20 mm/vmscan.c:4537
>  try_to_shrink_lruvec+0x160e/0x1a50 mm/vmscan.c:4733
>  shrink_one+0x66f/0xd40 mm/vmscan.c:4772
>  shrink_many mm/vmscan.c:4835 [inline]
>  lru_gen_shrink_node mm/vmscan.c:4935 [inline]
>  shrink_node+0x4856/0x55f0 mm/vmscan.c:5894
>  shrink_zones mm/vmscan.c:6152 [inline]
>  do_try_to_free_pages+0x820/0x2570 mm/vmscan.c:6214
>  try_to_free_pages+0xb7b/0x1820 mm/vmscan.c:6449
>  __perform_reclaim mm/page_alloc.c:3774 [inline]
>  __alloc_pages_direct_reclaim mm/page_alloc.c:3796 [inline]
>  __alloc_pages_slowpath+0x1035/0x31a0 mm/page_alloc.c:4202
>  __alloc_pages+0xacf/0xe70 mm/page_alloc.c:4588
>  alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
>  alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
>  vm_area_alloc_pages mm/vmalloc.c:3561 [inline]
>  __vmalloc_area_node mm/vmalloc.c:3637 [inline]
>  __vmalloc_node_range+0x100a/0x28b0 mm/vmalloc.c:3818
>  vmalloc_user+0x90/0xb0 mm/vmalloc.c:3972
>  kcov_ioctl+0x5d/0x660 kernel/kcov.c:704
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:904 [inline]
>  __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
>  __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
>  x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:=
17
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> CPU: 0 PID: 5281 Comm: dhcpcd-run-hook Not tainted 6.9.0-rc5-syzkaller-00=
053-ge33c4963bf53 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

