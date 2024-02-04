Return-Path: <linux-kernel+bounces-51364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77229848A2F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D2EB25733
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E2E1C13;
	Sun,  4 Feb 2024 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbARLzE5"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605E217E9
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707010109; cv=none; b=LGRHluEHKbZq57HuEtu47UhgCjaW5877j/zPjH5ISavRB9264LaSEhoXr3e8beEbBWQTtNFzOR6ZOc4ReE90YHlNFN2h088mlZHnIMhsRXQ3ofdKJTYSgmsAHVlqW91LQ0O2nmm+J8vnYpGKusuJyI2y6IqBuggegkpW2TpCclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707010109; c=relaxed/simple;
	bh=WwSxQs8n5//n7nFEtjE1GgmwbfV5MUMXvIpQhUaNgzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdXf41HTBLgcdrc78qbCXomzGYdv8koEp0tNjye5ixq3tQhu5pA3+X07X5tUmX/ZRWOVlXF9hhgaMhvJe9luAr2633D96sTsf+74tMcqncM6Cj1QTb5/Ecfz9Vxt6Cwe5Q075switB0vs6Cl2c/qB37TBLQjBWT8+RSgvKlqrmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbARLzE5; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7bee8858a8aso142358039f.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 17:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707010106; x=1707614906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZWtCxYIJXOOGKJwY425mDDi5jZklVEOxVPwuWfQVdg=;
        b=IbARLzE5NeFGa+p0/bx228njJL37QjcSaIZjHwOvZmCyA39bEB0KYatZhpNj+0yet8
         J8wEy3e3jNzLNH94smr4v5j0Qb86JtRfETZpQaesXa8yJVenCngEXYxOVKe1ErhuZgzJ
         kv6idNhmXDzW99PVI73gn3a+C7o2bHCyeP3Cs+LOoqdONy8NcY9DR6YRusSO6Q7bhd6x
         0A2xw5LbGUP+jukjESYuF9LmA34cKOWB88mJuwlqPxieR/5skBRgSzdA/+Vlo80EZPZ5
         vCSKrtQkKy3e6RbvzHIF7a+KQntkYl6Z36la/F8qdhJoEfn6k6ztM9oEYAIbxKMe6Z0K
         jYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707010106; x=1707614906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZWtCxYIJXOOGKJwY425mDDi5jZklVEOxVPwuWfQVdg=;
        b=hXljmye9H5VtGWryEqIsjj7wM5fsNgZ6VTrESYUhjlRp6u965wwE2K4qjqw1kq03YD
         3maN5eL7Qdh8Vz2jJLW1zZ71iXjVELB7CEKwB0BUR/ZK/0ShTMwtYtCst4gz8IwV0yzw
         vnqIhP7XVVEYZ3F7CxdAe8RXpBZupBZj1rUwoUDoT0gA3JxeNHMeufel4k0jD4iIWDWL
         naJDmnf9zcdHtb/g1b726dLPBP16bBfHW8kvnnLLgiFp8x3PRTP6EFtV9DE1vdICKJi+
         lfcCI3DZmMJcjNgIXOtQg59pEuC7ZEWYTOoa4/rIBGAdQlxNJyk7R2R+B+9QcxDE+KvF
         oeOA==
X-Gm-Message-State: AOJu0YzvFC5aCPMDAe0RO1TNexB7cJXZ/Xn3u/xIoRmVjZl0Jv7FIY8h
	UxFjSMfSWvA+Kfx+nFEZVTvboLZVD2vrJxoBKH84FiYtHrTAgNLf10+uLB4hgGp6cDD4+wk2bAV
	QtDKMY9SS5UUWUb08Pj+LTCML43N3C8gGygNLqg==
X-Google-Smtp-Source: AGHT+IHr6Gh2Pc3uFac2HWdjrlYK7uWPlwX1dEAMCnNJgz0be3UwaWSK3nZeFgHrMe0K46+mXKUOI8oDlit+LUrsGks=
X-Received: by 2002:a05:6602:2d8b:b0:7bf:cfce:34ab with SMTP id
 k11-20020a0566022d8b00b007bfcfce34abmr17845376iow.19.1707010106381; Sat, 03
 Feb 2024 17:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000ae47f90610803260@google.com>
In-Reply-To: <000000000000ae47f90610803260@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 3 Feb 2024 17:28:14 -0800
Message-ID: <CAKEwX=O1xg=BuLMbmv=n3L_mNRwhrumZ-ig4Y5N4JJ4Mu=d4Hg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in zswap_folio_swapin
To: syzbot <syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 12:37=E2=80=AFPM syzbot
<syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    861c0981648f Merge tag 'jfs-6.8-rc3' of github.com:kleika=
m..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D174537bbe8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db168fa511db3c=
a08
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D17a611d10af7d18=
a7092
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
bc7510fe41f/non_bootable_disk-861c0981.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b2b204c7b4a0/vmlinu=
x-861c0981.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/170ec316e557/b=
zImage-861c0981.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com
>
>  kcov_ioctl+0x4f/0x720 kernel/kcov.c:704
>  __do_compat_sys_ioctl+0x2bf/0x330 fs/ioctl.c:971
>  do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>  __do_fast_syscall_32+0x79/0x110 arch/x86/entry/common.c:321
> page has been migrated, last migrate reason: compaction
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 5104 at include/linux/memcontrol.h:775 folio_lruvec =
include/linux/memcontrol.h:775 [inline]
> WARNING: CPU: 2 PID: 5104 at include/linux/memcontrol.h:775 zswap_folio_s=
wapin+0x47d/0x5a0 mm/zswap.c:381
> Modules linked in:
> CPU: 2 PID: 5104 Comm: syz-fuzzer Not tainted 6.8.0-rc2-syzkaller-00031-g=
861c0981648f #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.=
16.2-1 04/01/2014
> RIP: 0010:folio_lruvec include/linux/memcontrol.h:775 [inline]

Hmm looks like it's this line:
VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled(), folio);

Looks like memcg was cleared from the folio. Haven't looked too
closely yet, but this (and the "page has been migrated" line above)
suggests maybe there is some migration business going on -
mem_cgroup_migrate() clears the old folio's memcg_data (via
old->memcg_data =3D 0).

Here's my theory (which could be wrong - someone please fact-check
me): swap_read_folio(), which precedes zswap_folio_swapin(), unlocks
the folio. Could this be sufficient to allow for migration? If this is
the case, all we need to do is move this to above swap_read_folio(),
while the folio is still locked. __read_swap_cache_async() already
charges the folio to an memcg, so no need to wait till after
swap_read_page() anyway.

> RIP: 0010:zswap_folio_swapin+0x47d/0x5a0 mm/zswap.c:381
> Code: e8 d8 9f ae ff 45 84 e4 0f 85 e7 fc ff ff e8 9a a4 ae ff 48 c7 c6 2=
0 9a da 8a 48 89 df e8 2b 1a ee ff c6 05 d1 8f 4b 0d 01 90 <0f> 0b 90 e9 c3=
 fc ff ff e8 76 a4 ae ff 48 c7 c6 60 99 da 8a 48 89
> RSP: 0018:ffffc9000397f8c0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffea0000a74300 RCX: ffffc9000397f720
> RDX: ffff88801a064800 RSI: ffffffff81d98145 RDI: ffffffff8b2fdc00
> RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1e76002
> R10: ffffffff8f3b0017 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 00000000000069a1 R15: 0000000000000003
> FS:  000000c000056490(0000) GS:ffff88802c800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000030623000 CR3: 000000001c68c000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  swap_cluster_readahead+0x4fb/0x710 mm/swap_state.c:685
>  swapin_readahead+0x132/0xe60 mm/swap_state.c:886
>  do_swap_page+0x4a6/0x30f0 mm/memory.c:3898
>  handle_pte_fault mm/memory.c:5147 [inline]
>  __handle_mm_fault+0x13a0/0x4900 mm/memory.c:5285
>  handle_mm_fault+0x47a/0xa10 mm/memory.c:5450
>  do_user_addr_fault+0x30b/0x1030 arch/x86/mm/fault.c:1364
>  handle_page_fault arch/x86/mm/fault.c:1507 [inline]
>  exc_page_fault+0x5d/0xc0 arch/x86/mm/fault.c:1563
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> RIP: 0033:0x46d3b9
> Code: fe 7f 44 1f 80 c5 f8 77 c3 80 3d 84 7c c7 01 01 75 0d c5 f9 ef c0 4=
8 81 fb 00 00 00 02 73 13 48 89 d9 48 c1 e9 03 48 83 e3 07 <f3> 48 ab e9 65=
 fe ff ff c5 fe 7f 07 48 89 fe 48 83 c7 20 48 83 e7
> RSP: 002b:000000c00108b700 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000000400
> RDX: 000000c00258f002 RSI: 00000000222172b0 RDI: 000000c00258fffa
> RBP: 000000c00108b758 R08: 0000000000000000 R09: 000000000000a000
> R10: 000000c002588000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000040 R14: 000000c000508ea0 R15: 000000c000056400
>  </TASK>
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

