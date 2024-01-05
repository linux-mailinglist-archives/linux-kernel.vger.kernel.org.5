Return-Path: <linux-kernel+bounces-18094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A938258D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC712840B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AA831A9A;
	Fri,  5 Jan 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T3VQ268l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC7569F;
	Fri,  5 Jan 2024 17:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564E7C433C7;
	Fri,  5 Jan 2024 17:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1704474273;
	bh=4oS5Gy7nNk2JT05LPHZuOQhXnfsquv2G9IeGUiXfG8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T3VQ268lo+UMgWIzGusHAGV8Nip+Io8OVCphfoB21H2v6BeKrMLuo8zCiu8N3MBZA
	 VOrbdKCiM4+7O02lZq3nEB4BYYuhAzp6xJ8nAJhxAMZsko6S4814E/krliNA7DuBQN
	 lKtP27pY2fMEuQjpu8jkQculySO3eavtmwGMeHpo=
Date: Fri, 5 Jan 2024 09:04:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Yin, Fengwei" <fengwei.yin@intel.com>
Cc: David Hildenbrand <david@redhat.com>, syzbot
 <syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <ryan.roberts@arm.com>, <syzkaller-bugs@googlegroups.com>, Matthew Wilcox
 <willy@infradead.org>, netdev@vger.kernel.org
Subject: Re: [syzbot] [mm?] WARNING in __folio_rmap_sanity_checks
Message-Id: <20240105090432.041a6f40b4402f0ee00ecc57@linux-foundation.org>
In-Reply-To: <3feecbd6-b3bd-440c-a4f9-2a7dba3ff8f1@intel.com>
References: <000000000000014174060e09316e@google.com>
	<c4e2e700-2d26-492f-8eb2-eb3ab14bc07a@redhat.com>
	<3feecbd6-b3bd-440c-a4f9-2a7dba3ff8f1@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

(cc netdev)

On Wed, 3 Jan 2024 22:16:13 +0800 "Yin, Fengwei" <fengwei.yin@intel.com> wr=
ote:

>=20
>=20
> On 1/3/2024 8:13 PM, David Hildenbrand wrote:
> > On 03.01.24 12:48, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:=A0=A0=A0 ab0b3e6ef50d Add linux-next specific files for 2=
0240102
> >> git tree:=A0=A0=A0=A0=A0=A0 linux-next
> >> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D17be3e09e8=
0000
> >> kernel config: =20
> >> https://syzkaller.appspot.com/x/.config?x=3Da14a6350374945f9
> >> dashboard link:=20
> >> https://syzkaller.appspot.com/bug?extid=3D50ef73537bbc393a25bb
> >> compiler:=A0=A0=A0=A0=A0=A0 gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU=
 Binutils=20
> >> for Debian) 2.40
> >> syz repro:     =20
> >> https://syzkaller.appspot.com/x/repro.syz?x=3D14e2256ee80000
> >> C reproducer:=A0=A0 https://syzkaller.appspot.com/x/repro.c?x=3D17b57d=
b5e80000
> >>
> >> Downloadable assets:
> >> disk image:=20
> >> https://storage.googleapis.com/syzbot-assets/4e6376fe5764/disk-ab0b3e6=
e.raw.xz
> >> vmlinux:=20
> >> https://storage.googleapis.com/syzbot-assets/7cb9ecbaf001/vmlinux-ab0b=
3e6e.xz
> >> kernel image:=20
> >> https://storage.googleapis.com/syzbot-assets/2c1a9a6d424f/bzImage-ab0b=
3e6e.xz
> >>
> >> The issue was bisected to:
> >>
> >> commit 68f0320824fa59c5429cbc811e6c46e7a30ea32c
> >> Author: David Hildenbrand <david@redhat.com>
> >> Date:=A0=A0 Wed Dec 20 22:44:31 2023 +0000
> >>
> >> =A0=A0=A0=A0 mm/rmap: convert folio_add_file_rmap_range() into=20
> >> folio_add_file_rmap_[pte|ptes|pmd]()
> >>
> >> bisection log: =20
> >> https://syzkaller.appspot.com/x/bisect.txt?x=3D10b9e1b1e80000
> >> final oops:    =20
> >> https://syzkaller.appspot.com/x/report.txt?x=3D12b9e1b1e80000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14b9e1b1e8=
0000
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the=20
> >> commit:
> >> Reported-by: syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com
> >> Fixes: 68f0320824fa ("mm/rmap: convert folio_add_file_rmap_range()=20
> >> into folio_add_file_rmap_[pte|ptes|pmd]()")
> >>
> >> =A0 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:283
> >> =A0 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:324
> >> =A0 kasan_slab_alloc include/linux/kasan.h:201 [inline]
> >> =A0 slab_post_alloc_hook mm/slub.c:3813 [inline]
> >> =A0 slab_alloc_node mm/slub.c:3860 [inline]
> >> =A0 kmem_cache_alloc+0x136/0x320 mm/slub.c:3867
> >> =A0 vm_area_alloc+0x1f/0x220 kernel/fork.c:465
> >> =A0 mmap_region+0x3ae/0x2a90 mm/mmap.c:2804
> >> =A0 do_mmap+0x890/0xef0 mm/mmap.c:1379
> >> =A0 vm_mmap_pgoff+0x1a7/0x3c0 mm/util.c:573
> >> =A0 ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1425
> >> =A0 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
> >> =A0 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
> >> =A0 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
> >> =A0 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >> =A0 do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
> >> =A0 entry_SYSCALL_64_after_hwframe+0x62/0x6a
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 1 PID: 5059 at include/linux/rmap.h:202=20
> >> __folio_rmap_sanity_checks+0x4d5/0x630 include/linux/rmap.h:202
> >> Modules linked in:
> >> CPU: 1 PID: 5059 Comm: syz-executor115 Not tainted=20
> >> 6.7.0-rc8-next-20240102-syzkaller #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine,=20
> >> BIOS Google 11/17/2023
> >> RIP: 0010:__folio_rmap_sanity_checks+0x4d5/0x630 include/linux/rmap.h:=
202
> >> Code: 41 83 e4 01 44 89 e6 e8 79 bc b7 ff 45 84 e4 0f 85 08 fc ff ff=20
> >> e8 3b c1 b7 ff 48 c7 c6 e0 b5 d9 8a 48 89 df e8 5c 12 f7 ff 90 <0f> 0b=
=20
> >> 90 e9 eb fb ff ff e8 1e c1 b7 ff be 01 00 00 00 48 89 df e8
> >> RSP: 0018:ffffc900038df978 EFLAGS: 00010293
> >> RAX: 0000000000000000 RBX: ffffea00008cde00 RCX: ffffffff81687419
> >> RDX: ffff88807becbb80 RSI: ffffffff81d06104 RDI: 0000000000000000
> >> RBP: ffffea00008cde00 R08: 0000000000000000 R09: fffffbfff1e75f6a
> >> R10: ffffffff8f3afb57 R11: 0000000000000001 R12: 0000000000000000
> >> R13: 0000000000000001 R14: 0000000000000000 R15: dffffc0000000000
> >> FS:=A0 0000555556508380(0000) GS:ffff8880b9900000(0000)=20
> >> knlGS:0000000000000000
> >> CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00000000200000c0 CR3: 0000000079000000 CR4: 00000000003506f0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >> =A0 <TASK>
> >> =A0 __folio_add_rmap mm/rmap.c:1167 [inline]
> >> =A0 __folio_add_file_rmap mm/rmap.c:1452 [inline]
> >> =A0 folio_add_file_rmap_ptes+0x8e/0x2c0 mm/rmap.c:1478
> >> =A0 insert_page_into_pte_locked.isra.0+0x34d/0x960 mm/memory.c:1874
> >> =A0 insert_page mm/memory.c:1900 [inline]
> >> =A0 vm_insert_page+0x62c/0x8c0 mm/memory.c:2053
> >> =A0 packet_mmap+0x314/0x570 net/packet/af_packet.c:4594
> >> =A0 call_mmap include/linux/fs.h:2090 [inline]
> >> =A0 mmap_region+0x745/0x2a90 mm/mmap.c:2819
> >> =A0 do_mmap+0x890/0xef0 mm/mmap.c:1379
> >> =A0 vm_mmap_pgoff+0x1a7/0x3c0 mm/util.c:573
> >> =A0 ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1425
> >> =A0 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
> >> =A0 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
> >> =A0 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
> >> =A0 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >> =A0 do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
> >> =A0 entry_SYSCALL_64_after_hwframe+0x62/0x6a
> >=20
> > If I am not wrong, that triggers:
> >=20
> > VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> >  =A0=A0=A0=A0=A0=A0=A0=A0 !folio_test_large_rmappable(folio), folio);
> >=20
> > So we are trying to rmap a large folio that did not go through=20
> > folio_prep_large_rmappable().
> >=20
> > net/packet/af_packet.c calls vm_insert_page() on some pages/folios stoe=
d=20
> > in the "struct packet_ring_buffer". No idea where that comes from, but =
I=20
> > suspect it's simply some compound allocation.
> Looks like:
>   alloc_pg_vec
>     alloc_one_pg_vec_page
>          gfp_t gfp_flags =3D GFP_KERNEL | __GFP_COMP |
>                            __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
>=20
>          buffer =3D (char *) __get_free_pages(gfp_flags, order);
> So you are right here... :).

Can we suggest what af_packet should be doing to avoid this?

