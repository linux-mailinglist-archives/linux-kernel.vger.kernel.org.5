Return-Path: <linux-kernel+bounces-72129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C343C85AFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713CD1F22516
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880E856774;
	Mon, 19 Feb 2024 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EaJ+0C/c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC954F94;
	Mon, 19 Feb 2024 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708384960; cv=none; b=QYmM1jNmTs+ZnZoxF6erwbjl1w69152O+VGs6EVXR6qAPUyrfF4SsGVEm5DFprsA2m70nvQ3c6HXwID0U1LvhzxHYqpc/twBcuw6fO/GL9/4VxpsWSBvAhig13vQ7pB1GVW2D3+mCPx6ho/Lb2LqCIKV0b4bAE9EkS0XB24/ol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708384960; c=relaxed/simple;
	bh=FWpOBCkODHabkJO/2Ou8aa2AzNh5BEcl7n0oV56Fg6I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HIVEvNOMnskm0UkSQZV/Gk2qfohFIQP3yClvo6OxDTJllozA/0MEvvnd9gfwbZSZADlLOTe3QL09ra2oynHLJTbIh1jZnFBgmJkIz+glTwsCJNkOJ2zoS5Wooj/VLsj/3RarNoLnQKXPXUMEdE3nTSX2RhrCPGeI4d9OoGyRnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EaJ+0C/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7CCC433F1;
	Mon, 19 Feb 2024 23:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708384960;
	bh=FWpOBCkODHabkJO/2Ou8aa2AzNh5BEcl7n0oV56Fg6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EaJ+0C/cEo6UVze4RUQGwKFJgNpO8UmXvSGW6lbK+7OHYWMujxiCpHYry3kLZrm7R
	 /qv5sNQdPs+ftbGleMvMDWz30WC8x5xjzyROERVRnVce32Sk1lEBFPcnhKg18tQmZt
	 FU4nutJtr81rBgvMzuJ3pOv9yUmRjneixVpyBw0Y=
Date: Mon, 19 Feb 2024 15:22:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: syzbot <syzbot+6f3c38e8a6a0297caa5a@syzkaller.appspotmail.com>,
 jasowang@redhat.com, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, sfr@canb.auug.org.au,
 syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com, linux-mm@kvack.org
Subject: Re: [syzbot] [virtualization?] linux-next boot error: WARNING:
 refcount bug in __free_pages_ok
Message-Id: <20240219152239.e281ca98f06cb71276db7791@linux-foundation.org>
In-Reply-To: <20240219022853-mutt-send-email-mst@kernel.org>
References: <000000000000d305050611b50d09@google.com>
	<20240219022853-mutt-send-email-mst@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 02:35:20 -0500 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Sun, Feb 18, 2024 at 09:06:18PM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    d37e1e4c52bc Add linux-next specific files for 20240216
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=171ca652180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4bc446d42a7d56c0
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6f3c38e8a6a0297caa5a
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/14d0894504b9/disk-d37e1e4c.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6cda61e084ee/vmlinux-d37e1e4c.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/720c85283c05/bzImage-d37e1e4c.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+6f3c38e8a6a0297caa5a@syzkaller.appspotmail.com
> > 
>
> ...
>
> > usbcore: registered new interface driver port100
> > usbcore: registered new interface driver nfcmrvl
> > Loading iSCSI transport class v2.0-870.
> > virtio_scsi virtio0: 1/0/0 default/read/poll queues
> > ------------[ cut here ]------------
> > refcount_t: decrement hit 0; leaking memory.
> > WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
> > Modules linked in:
> > CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-next-20240216-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> > RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
> > Code: b2 00 00 00 e8 b7 94 f0 fc 5b 5d c3 cc cc cc cc e8 ab 94 f0 fc c6 05 c6 16 ce 0a 01 90 48 c7 c7 a0 5a fe 8b e8 67 69 b4 fc 90 <0f> 0b 90 90 eb d9 e8 8b 94 f0 fc c6 05 a3 16 ce 0a 01 90 48 c7 c7
> > RSP: 0000:ffffc90000066e10 EFLAGS: 00010246
> > RAX: 15c2c224c9b50400 RBX: ffff888020827d2c RCX: ffff8880162d8000
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 0000000000000004 R08: ffffffff8157b942 R09: fffffbfff1bf95cc
> > R10: dffffc0000000000 R11: fffffbfff1bf95cc R12: ffffea000502fdc0
> > R13: ffffea000502fdc8 R14: 1ffffd4000a05fb9 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffff88823ffff000 CR3: 000000000df32000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  reset_page_owner include/linux/page_owner.h:24 [inline]
> >  free_pages_prepare mm/page_alloc.c:1140 [inline]
> >  __free_pages_ok+0xc42/0xd70 mm/page_alloc.c:1269
> >  make_alloc_exact+0xc4/0x140 mm/page_alloc.c:4847
> >  vring_alloc_queue drivers/virtio/virtio_ring.c:319 [inline]
> 
> Wow this seems to be breakage deep in mm/ - all virtio does is
> call alloc_pages_exact and that corrupts the refcounts?
> 

Will the bot be performing a bisection?  If not, can one please be
performed?

