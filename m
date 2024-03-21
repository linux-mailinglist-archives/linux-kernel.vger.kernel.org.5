Return-Path: <linux-kernel+bounces-109866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B249C8856D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00841C218AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA60554F86;
	Thu, 21 Mar 2024 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oTzrDoD/"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9D51C2A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014633; cv=none; b=XdUJHpPifGtof2s3vbHyC07jJ+0YB9fGuf8hAV+CNL11xgPxNb/+ZDUUiIKwOmY+x87OG7tuk2NUoybJbT05PEx5r47X0ABDOdQX8Nb0ccoRtHYOhmZlvUJ4hiyDT5KRX7QSN+pBf9VPMnQ3lBzLpOBWCcFlQbiJr/tLxutQOCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014633; c=relaxed/simple;
	bh=zGGpvMe3eltmRKcpki98L+oWOLVlMnMsygSfjmN34nw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BIHH04+M3z6iSneqwWV8QHR+Qs0yzGrZfN/Y8H1rvdc3v42Lc5T8yY0Vssfi/dKR2yef/6dp8zyCP/U1d3K/aNeQSkcee1Z0rtoqydozR8hUD1TYeYsEL2EXiFPxJAXPntOEOQuzyPgvI0YnETAwZE/+ZL2X5OR7loIHaJcmeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oTzrDoD/; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711014627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ubvW1+2eGkzbPZ23NkqUHfCv3LLz8BWMOTyyBMul+E=;
	b=oTzrDoD/CLpLAWLSYuvlshHt+JysOxT1VXNlXZzSanqg9Kk8UA+HF1l7gOeZUehfnn/oba
	b0it+gSwHDMvhjdMJMLBZnAbjLbDrI913Ab4yvJ9GToT/LhRvBdGt/MUlXLHV9hu43CnDh
	VhJQe9JhFeTTbvIaFvAr/T3A3o858wk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <0000000000006cfe98061423cde7@google.com>
Date: Thu, 21 Mar 2024 17:49:49 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <812E97E8-668F-414D-9480-1D284834A034@linux.dev>
References: <0000000000006cfe98061423cde7@google.com>
To: syzbot <syzbot+3b9148f91b7869120e81@syzkaller.appspotmail.com>,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>
X-Migadu-Flow: FLOW_OUT



> On Mar 21, 2024, at 12:04, syzbot =
<syzbot+3b9148f91b7869120e81@syzkaller.appspotmail.com> wrote:
>=20
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    78c3925c048c Merge tag 'soc-late-6.9' of =
git://git.kernel...
> git tree:       upstream
> console output: =
https://syzkaller.appspot.com/x/log.txt?x=3D1267d879180000
> kernel config:  =
https://syzkaller.appspot.com/x/.config?x=3Df3c2635ded15fbc9
> dashboard link: =
https://syzkaller.appspot.com/bug?extid=3D3b9148f91b7869120e81
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils =
for Debian) 2.40
> userspace arch: i386
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20
> Downloadable assets:
> disk image (non-bootable): =
https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_dis=
k-78c3925c.raw.xz
> vmlinux: =
https://storage.googleapis.com/syzbot-assets/cf2bceeccde3/vmlinux-78c3925c=
xz
> kernel image: =
https://storage.googleapis.com/syzbot-assets/fc938dfaea6d/bzImage-78c3925c=
xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> Reported-by: syzbot+3b9148f91b7869120e81@syzkaller.appspotmail.com
>=20
> veth_newlink+0x627/0xa10 drivers/net/veth.c:1895
> rtnl_newlink_create net/core/rtnetlink.c:3494 [inline]
> __rtnl_newlink+0x119c/0x1960 net/core/rtnetlink.c:3714
> rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3727
> rtnetlink_rcv_msg+0x3c7/0xe60 net/core/rtnetlink.c:6595
> ------------[ cut here ]------------
> kernel BUG at include/linux/page-flags.h:315!

There are some more page dumping information from console:

[ 61.367144][ T42] page: refcount:0 mapcount:0 mapping:0000000000000000 =
index:0xffff888028132880 pfn:0x28130
[ 61.371430][ T42] flags: =
0xfff80000000000(node=3D0|zone=3D1|lastcpupid=3D0xfff)
[ 61.374455][ T42] page_type: 0xffffffff()
[ 61.376096][ T42] raw: 00fff80000000000 ffff888015ecd540 =
dead000000000100 0000000000000000
[ 61.379994][ T42] raw: ffff888028132880 0000000000190000 =
00000000ffffffff 0000000000000000

Alright, the page is freed (with a refcount of 0).

> invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 PID: 42 Comm: kcompactd0 Not tainted =
6.8.0-syzkaller-11725-g78c3925c048c #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS =
1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:const_folio_flags+0x1bd/0x1f0 include/linux/page-flags.h:315

The RIP is in const_folio_flags() (called from folio_test_hugetlb()):

	VM_BUG_ON_PGFLAGS(n > 0 && !test_bit(PG_head, &page->flags), =
page);

It is reasonable to WARN because the page is freed (PG_head is not set
in this case).

The comments from folio_test_hugetlb() says "Caller should have a
reference on the folio", so the caller of PageHuge() should grab
a refcount before calling folio_test_hugetlb() since commit
9c5ccf2db04b. But it does not mean that the @page must be a HugeTLB page
even if PageHuge(@page) returns true when the user does not hold
a extra refcount on the @page. Seems the WARN could be acceptable, so
should we remove this WARN? I am not sure. Cc more experts.

Thanks.

> Code: 41 83 e4 01 44 89 e6 e8 b1 e6 a9 ff 45 84 e4 0f 85 c4 fe ff ff =
e8 23 ec a9 ff 48 c7 c6 e0 07 1b 8b 48 89 ef e8 34 2e ed ff 90 <0f> 0b =
e8 8c 6b 06 00 e9 66 fe ff ff 48 89 ef e8 7f 6b 06 00 eb b6
> RSP: 0018:ffffc9000068f7f0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc9000068f698
> RDX: ffff88801744c880 RSI: ffffffff81e4265c RDI: ffffffff8b6f0060
> RBP: ffffea0000a04c00 R08: 0000000000000000 R09: fffffbfff1f3deca
> R10: ffffffff8f9ef657 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffea0000a04dc0 R14: 0000000000028137 R15: ffffc9000068fbe8
> FS:  0000000000000000(0000) GS:ffff88802c300000(0000) =
knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffe623b9138 CR3: 000000001c22c000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> folio_test_hugetlb include/linux/page-flags.h:875 [inline]
> PageHuge+0x219/0x2b0 mm/hugetlb.c:2174
> isolate_migratepages_block+0x4a0/0x5110 mm/compaction.c:1004
> isolate_migratepages mm/compaction.c:2182 [inline]
> compact_zone+0x1a5c/0x4280 mm/compaction.c:2629
> kcompactd_do_work+0x340/0x720 mm/compaction.c:3100
> kcompactd+0x8d7/0xde0 mm/compaction.c:3199
> kthread+0x2c1/0x3a0 kernel/kthread.c:388
> ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:const_folio_flags+0x1bd/0x1f0 include/linux/page-flags.h:315
> Code: 41 83 e4 01 44 89 e6 e8 b1 e6 a9 ff 45 84 e4 0f 85 c4 fe ff ff =
e8 23 ec a9 ff 48 c7 c6 e0 07 1b 8b 48 89 ef e8 34 2e ed ff 90 <0f> 0b =
e8 8c 6b 06 00 e9 66 fe ff ff 48 89 ef e8 7f 6b 06 00 eb b6
> RSP: 0018:ffffc9000068f7f0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc9000068f698
> RDX: ffff88801744c880 RSI: ffffffff81e4265c RDI: ffffffff8b6f0060
> RBP: ffffea0000a04c00 R08: 0000000000000000 R09: fffffbfff1f3deca
> R10: ffffffff8f9ef657 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffea0000a04dc0 R14: 0000000000028137 R15: ffffc9000068fbe8
> FS:  0000000000000000(0000) GS:ffff88802c300000(0000) =
knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffe623b9138 CR3: 000000001c22c000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup


