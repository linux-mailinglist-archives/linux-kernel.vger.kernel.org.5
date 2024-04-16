Return-Path: <linux-kernel+bounces-147457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C54F8A7476
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443E2281F13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B67D137C25;
	Tue, 16 Apr 2024 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pVdheGOo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0012137929;
	Tue, 16 Apr 2024 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295085; cv=none; b=mIDV8M1QnkUtqGLlavM/3AAGP450EnjgA0IhgR8+wsvFgHwvMZvfvW59+aUivlVweCVxp4LgpqOl+HFwOCduCrnffXvW9euXLzPot3JHvCmy1MDlOuH87hzB2C0w/fF6WLnTfsqX2ZB0Rgl0ylnm4OfJYm5DfOwxWx7+Rn7Q9i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295085; c=relaxed/simple;
	bh=qe83P9vvTKzKa5UvpEdn6fNXNpGNSmqGdNylsccrOPg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pm/ygnanzSTvIgIRYNRTp7DMeJCOTN7nTXcUUTsot72cHuLgJL9ymmeKZPoWBbezfsyXNWB7CraMTGwgcIfuv5W0VXZoughMOji3rKAKzPrm5Hgw67nr4fMJqvcoz2qFdI9zvb936fA3CM7rOv69Ky3ICtR0gc1OztwSj3gg/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pVdheGOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D88C113CE;
	Tue, 16 Apr 2024 19:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713295085;
	bh=qe83P9vvTKzKa5UvpEdn6fNXNpGNSmqGdNylsccrOPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pVdheGOoICvekvJn1ImFKQUiCCrvaWXTHv0NGii/S5H8qa4b/gMw7RUsRncLQGheH
	 QoQw8hNH+BtYx0X0PSDPk3yfINo8dnrUVtBOdlff6gODI3AzNz/FgYJ1jN9hI5cLh5
	 oR3RfafPTtgJoGL6I1VHhoa15sMYx824E9SFr3yk=
Date: Tue, 16 Apr 2024 12:18:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christian Heusel <christian@heusel.eu>
Cc: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
 Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Runge <dave@sleepmap.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Mark W <instruform@gmail.com>,
 regressions@lists.linux.dev, Johannes Weiner <hannes@cmpxchg.org>, Yosry
 Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, Chengming
 Zhou <chengming.zhou@linux.dev>
Subject: Re: [REGRESSION] Null pointer dereference while shrinking zswap
Message-Id: <20240416121804.a46c4174f6cec30ab51f18e5@linux-foundation.org>
In-Reply-To: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
References: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 14:19:24 +0200 Christian Heusel <christian@heusel.eu> wrote:

> Hello everyone,
> 
> while rebuilding a few packages in Arch Linux we have recently come
> across a regression in the linux kernel which was made visible by a test
> failure in libguestfs[0], where the booted kernel showed a Call Trace
> like the following one:
> 
> [  218.738568] CPU: 0 PID: 167 Comm: guestfsd Not tainted 6.7.0-rc4-1-mainline-00158-gb5ba474f3f51 #1 bf39861cf50acae7a79c534e25532f28afe4e593^M

(cc more zswap people)

Fairly old kernel.  We might have fixed it since then, but it would be
good to know what fixed this, for backporting reasons.

> [  218.739007] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.16.3-1-1 04/01/2014^M
> [  218.739787] RIP: 0010:memcg_page_state+0x9/0x30^M
> [  218.740299] Code: 0d b8 ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 <48> 8b 87 00 06 00 00 48 63 f6 31 d2 48 8b 04 f0 48 85 c0 48 0f 48^M
> [  218.740727] RSP: 0018:ffffb5fa808dfc10 EFLAGS: 00000202^M
> [  218.740862] RAX: 0000000000000000 RBX: ffffb5fa808dfce0 RCX: 0000000000000002^M
> [  218.741016] RDX: 0000000000000001 RSI: 0000000000000033 RDI: 0000000000000000^M
> [  218.741168] RBP: 0000000000000000 R08: ffff976681ff8000 R09: 0000000000000000^M
> [  218.741322] R10: 0000000000000001 R11: ffff9766833f9d00 R12: ffff9766ffffe780^M
> [  218.742167] R13: 0000000000000000 R14: ffff976680cc1800 R15: ffff976682204d80^M
> [  218.742376] FS:  00007f1479d9f540(0000) GS:ffff9766fbc00000(0000) knlGS:0000000000000000^M
> [  218.742569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> [  218.743256] CR2: 0000000000000600 CR3: 0000000103606000 CR4: 0000000000750ef0^M
> [  218.743494] PKRU: 55555554^M
> [  218.743593] Call Trace:^M
> [  218.743733]  <TASK>^M
> [  218.743847]  ? __die+0x23/0x70^M
> [  218.743957]  ? page_fault_oops+0x171/0x4e0^M
> [  218.744056]  ? free_unref_page+0xf6/0x180^M
> [  218.744458]  ? exc_page_fault+0x7f/0x180^M
> [  218.744551]  ? asm_exc_page_fault+0x26/0x30^M
> [  218.744684]  ? memcg_page_state+0x9/0x30^M
> [  218.744779]  zswap_shrinker_count+0x9d/0x110^M
> [  218.744896]  do_shrink_slab+0x3a/0x360^M
> [  218.744990]  shrink_slab+0xc7/0x3c0^M
> [  218.745609]  drop_slab+0x85/0x140^M
> [  218.745691]  drop_caches_sysctl_handler+0x7e/0xd0^M
> [  218.745799]  proc_sys_call_handler+0x1c0/0x2e0^M
> [  218.745912]  vfs_write+0x23d/0x400^M
> [  218.745998]  ksys_write+0x6f/0xf0^M
> [  218.746080]  do_syscall_64+0x64/0xe0^M
> [  218.746169]  ? exit_to_user_mode_prepare+0x132/0x1f0^M
> [  218.746873]  entry_SYSCALL_64_after_hwframe+0x6e/0x76^M
> 
> The regression is present in the mainline kernel and also was
> independently reported to the redhat bugtracker[1].
> 
> I have bisected (see log[2]) the regression between v6.9-rc4 and v6.6
> and have landed on the following results (removed unrelated test commit)
> as remainders since some of the commits were not buildable for me:
> - 7108cc3f765c ("mm: memcg: add per-memcg zswap writeback stat")
> - a65b0e7607cc ("zswap: make shrinking memcg-aware")
> - b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> 
> I have decided on good/bad commits with the relevant libguestfs tests,
> but I think the reproducer in the redhat bugzilla is simpler (although I
> only became aware of it during the bisection and therefore didn't test
> it myself):
> 
>   LIBGUESTFS_MEMSIZE=4096 LIBGUESTFS_DEBUG=1 LIBGUESTFS_TRACE=1 make -C /build/libguestfs/src/libguestfs-1.52.0/tests -k check TESTS=c-api/tests
> 
> I hope I have included everything needed to debug this further, if there
> is more to add I'm happy to provide more details!
> 
> Cheers,
> Christian
> 
> [0]: https://github.com/libguestfs/libguestfs/issues/139
> [1]: https://bugzilla.redhat.com/show_bug.cgi?id=2275252
> [2]: https://gist.github.com/christian-heusel/d5095c36b72ae90871e27dfed32ddc46

