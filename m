Return-Path: <linux-kernel+bounces-30177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35B9831B07
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026C61C21311
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2C22576B;
	Thu, 18 Jan 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UhfCKUBK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8555325639;
	Thu, 18 Jan 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705586577; cv=none; b=HDkpsM8wzftoFipfJ3iDfB6OYotDiYRlqVSC97AyYmxaupj0fCTC4qV7R6vHJg8PxGJ0fwtST42aqvKcuhAt/s+jtDUbA6kY0NugqVNn6gg8gY8eCDiF/sZcHGoxqFglXsqb4zm3v28cUjYUZRYomaD1CyQvIB/X9iED4mg0ZMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705586577; c=relaxed/simple;
	bh=pu8uQu3Y4QnGdmhJ528b0uJK+cTzVQ4kRYVKyPEqQVA=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=inn1/xk3txAQVul1+sOL0uGOZAWb62WfxQWYIcWdnsPvc6tX17uXDZAjW1xceRBhFdV3K64uxgv+KDhy4M3a/NJyhYrHykFhMy0e7wvNJLKErcItz6IXsvMqn7YCf7jjCuPn0xWLWk+JF4XXBLNJ5F1U4/ggMPNoBQL8EVkq/9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UhfCKUBK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n48Z2k8UvQPTHeoA5BfUaJdkDjBjCutOjxNZxxGyZt4=; b=UhfCKUBKI3W/ojueUMXBr/ODPf
	dwHSRPhv/qYUasktJz62ugOn41F1G3OSgCi3u+B51ADF6TchvGsBPVxdffqtWNjY3ddSCXgWtTbki
	wck9wexfFJX5rBw5IMOfs5V6s1zJzZK06yNPqIzsjni74X0owVMDK4Ptfxnt8/9MJYnpFzjnb+y0Z
	pVKbI/rQJDoaP3ZXEWmcTJHywiAGxH0B4QtKYSRQNKzCCSAaSJYHijOzLqmAv0gvtU85JPwkYx5Sk
	J8xqoXbiJ/L43sU2SR+kJutXGKhkq96FjA6nEpLMYgD9TJHzA5Sny55s/LePHK5Zq1KyOM3d28rjt
	lDFhtW6A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQSyq-00000002KSu-437J;
	Thu, 18 Jan 2024 14:02:52 +0000
Date: Thu, 18 Jan 2024 14:02:52 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>,
	wzhmmmmm@gmail.com, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com, marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
Message-ID: <ZakvjMjMYK1HtYGt@casper.infradead.org>
References: <000000000000a135c0060a2260b3@google.com>
 <00000000000037f0f3060af9e763@google.com>
 <CACT4Y+YBGDYbhXvpEAo6iXS--QOSsUxXqkGZxOpUCuCd3CM3aQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YBGDYbhXvpEAo6iXS--QOSsUxXqkGZxOpUCuCd3CM3aQ@mail.gmail.com>

On Thu, Jan 18, 2024 at 11:21:34AM +0100, Dmitry Vyukov wrote:
> On Sat, 25 Nov 2023 at 14:18, syzbot
> <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    8c9660f65153 Add linux-next specific files for 20231124
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1678a3cce80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
> > dashboard link: https://syzkaller.appspot.com/bug?extid=51baee846ddab52d5230
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d54c08e80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160ef1a4e80000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/345ed4af3a0d/disk-8c9660f6.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/191053c69d57/vmlinux-8c9660f6.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/aac7ee5e55e0/bzImage-8c9660f6.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com
> >
> > Bluetooth: hci0: hardware error 0x00
> > ==================================================================
> > BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> > BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
> > BUG: KASAN: null-ptr-deref in ida_free+0x218/0x2e0 lib/idr.c:511
> > Read of size 8 at addr 0000000000000078 by task kworker/u5:1/4455
> >
> > CPU: 1 PID: 4455 Comm: kworker/u5:1 Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> > Workqueue: hci0 hci_error_reset
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
> >  kasan_report+0xd9/0x110 mm/kasan/report.c:588
> >  check_region_inline mm/kasan/generic.c:182 [inline]
> >  kasan_check_range+0xef/0x190 mm/kasan/generic.c:188
> >  instrument_atomic_read include/linux/instrumented.h:68 [inline]
> >  _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
> 
> Wonder if this is fixed with:
> 
> ida: Fix crash in ida_free when the bitmap is empty
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af73483f4e8b6f5c68c9aa63257bdd929a9c194a
> 
> ?

Should be.  The backtrace below looks like it's the same bug that got
reported 3-4 weeks ago.

> >  ida_free+0x218/0x2e0 lib/idr.c:511
> >  hci_conn_cleanup net/bluetooth/hci_conn.c:157 [inline]
> >  hci_conn_del+0x78c/0xe10 net/bluetooth/hci_conn.c:1183
> >  hci_conn_hash_flush+0x189/0x260 net/bluetooth/hci_conn.c:2643
> >  hci_dev_close_sync+0x5a7/0x1160 net/bluetooth/hci_sync.c:5021
> >  hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:554
> >  hci_error_reset+0xa6/0x190 net/bluetooth/hci_core.c:1059
> >  process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2633
> >  process_scheduled_works kernel/workqueue.c:2706 [inline]
> >  worker_thread+0x8b6/0x1290 kernel/workqueue.c:2787
> >  kthread+0x2c1/0x3a0 kernel/kthread.c:389
> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> >  </TASK>
> > ==================================================================
> >
> >
> > ---
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000037f0f3060af9e763%40google.com.

