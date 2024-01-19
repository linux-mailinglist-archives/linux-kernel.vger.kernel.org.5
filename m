Return-Path: <linux-kernel+bounces-31221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F1832ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 369E0B246A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F482537EB;
	Fri, 19 Jan 2024 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B6plm6E5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929C52F70;
	Fri, 19 Jan 2024 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705672081; cv=none; b=EDNe9ISbFl75DFGoI3dU3zwTnRvZo7RXLcJ7Q8kH4Xl9uInkSOz8GpLc/4mlZ97LTUSsePorXwvRZZ01m7WfudGjy/5SdoxjOxsCB+8UFpkQ3tfstOryOFUb60ZVBMqy15oLkz+ol9UKz7MjKONioXgYsyt89ci27OCqD5j5Llk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705672081; c=relaxed/simple;
	bh=zhcvGV8kOfBbv0MXLR/plcj5YNvLUzwmPiQLHiPqLxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF7IR3vjHN5V9xJoAQmUm2W8byB7xxnKw0z+yb1SFwOiYf2knRi0x8/S09VADTnyev5fgm5qoeZS8aAaHxFb8FFHfOfpj/ad1rDnFSF7GMwMD7mm+aQfvW050bXT/6YXxvF0/Xyx9m3VCBB1egjgNsgWECGWw/UK9ZZ46FlgDGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B6plm6E5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GucoAa/6UVKHOL0VOQUVOB31wTkV3GnwfxCBx41qa2g=; b=B6plm6E5WlP8bYIr8d7xHzUlgR
	DR3fg0b/Q5kjY6EGocG+t2kvgDgwkC1zXRIkl1Pt9ExZojWE2fEp0WBXJkrSxXDFsvWA9YTsHS9QK
	Bb331SpxKTfTJyx8Ccdh/5E6LU9VOsV6RvJ3baIoPCEW660cxcHE5QW7pIHy1AXWGRi8r7FOjLwll
	C1enRTdmCt0qSVIvk7be7W7AN/5AjUlpSm3Is9c3c6bGmvMrwudHEc+UTwXK0SO0VcNjY0hM7fSTP
	ii/p4oK3Y+2HeQ3Zu/MAQ1XLEKetbm5QCOstQxH1Ln+81f7fhllPWJBpktLKaM0i2G+jsLN9wbekg
	pMqaBs1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQpDx-000000058Og-3N5Z;
	Fri, 19 Jan 2024 13:47:57 +0000
Date: Fri, 19 Jan 2024 13:47:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>,
	wzhmmmmm@gmail.com, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com, marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
Message-ID: <Zap9jfjNAb8JHNd4@casper.infradead.org>
References: <000000000000a135c0060a2260b3@google.com>
 <00000000000037f0f3060af9e763@google.com>
 <CACT4Y+YBGDYbhXvpEAo6iXS--QOSsUxXqkGZxOpUCuCd3CM3aQ@mail.gmail.com>
 <ZakvjMjMYK1HtYGt@casper.infradead.org>
 <CACT4Y+YT-Y=b_oSFNCQgTeh8igSqfYQ40JHGTad9w2+uZ_JvNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YT-Y=b_oSFNCQgTeh8igSqfYQ40JHGTad9w2+uZ_JvNg@mail.gmail.com>

On Fri, Jan 19, 2024 at 12:58:21PM +0100, Dmitry Vyukov wrote:
> On Thu, 18 Jan 2024 at 15:02, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Jan 18, 2024 at 11:21:34AM +0100, Dmitry Vyukov wrote:
> > > On Sat, 25 Nov 2023 at 14:18, syzbot
> > > <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com> wrote:
> > > >
> > > > syzbot has found a reproducer for the following issue on:
> > > >
> > > > HEAD commit:    8c9660f65153 Add linux-next specific files for 20231124
> > > > git tree:       linux-next
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1678a3cce80000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=51baee846ddab52d5230
> > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d54c08e80000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160ef1a4e80000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/345ed4af3a0d/disk-8c9660f6.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/191053c69d57/vmlinux-8c9660f6.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/aac7ee5e55e0/bzImage-8c9660f6.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com
> > > >
> > > > Bluetooth: hci0: hardware error 0x00
> > > > ==================================================================
> > > > BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> > > > BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
> > > > BUG: KASAN: null-ptr-deref in ida_free+0x218/0x2e0 lib/idr.c:511
> > > > Read of size 8 at addr 0000000000000078 by task kworker/u5:1/4455
> > > >
> > > > CPU: 1 PID: 4455 Comm: kworker/u5:1 Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> > > > Workqueue: hci0 hci_error_reset
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > >  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
> > > >  kasan_report+0xd9/0x110 mm/kasan/report.c:588
> > > >  check_region_inline mm/kasan/generic.c:182 [inline]
> > > >  kasan_check_range+0xef/0x190 mm/kasan/generic.c:188
> > > >  instrument_atomic_read include/linux/instrumented.h:68 [inline]
> > > >  _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
> > >
> > > Wonder if this is fixed with:
> > >
> > > ida: Fix crash in ida_free when the bitmap is empty
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af73483f4e8b6f5c68c9aa63257bdd929a9c194a
> > >
> > > ?
> >
> > Should be.  The backtrace below looks like it's the same bug that got
> > reported 3-4 weeks ago.
> 
> On second thought, perhaps the bluetooth stack shouldn't free invalid
> ids in the first place.
> It may even take these bogus ids from the wire, which would be pretty bad.

Oh, that was my first response.  Unfortunately, the original reporter was
all "I filed a CVE and this is S3CUR1+Y F!X" so none of that interaction
is public.

What my patch will do is convert this NULL pointer dereference into a
warning (which will still be noticed by syzbot).  The bluetooth stack
still needs to be fixed to not free invalid IDs.

