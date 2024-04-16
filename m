Return-Path: <linux-kernel+bounces-146230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F088A6276
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735352835E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB4617554;
	Tue, 16 Apr 2024 04:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dWZHFX+9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD31E53A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242155; cv=none; b=Iw2drTjlq+lbo0wu+maip4sYTxVKBtm47/zZRGjGVbzFZIsqbLhQGYeOqYOCBlFOz/qjvX1qxnbIizPhjINoFphoJOqcrABgrjofz8d8JNeoF4oIMt1xn0+NnRbQVNNYucTqzncqOdbNo8rABSSBE/nIuTSSlZik7qZOxLPNqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242155; c=relaxed/simple;
	bh=rLUQL0Q6AoIyYHgQy5JyiMrJ9GqKGQXJZrP3QqVCS+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiBzhKzeipV/llbQNnwTogvZRr2CNfcIrPQP2ZkzvjFGa7rMx0ktVSLGLzw4TrOQ78gdo4Ef9QY1YZMiGKwbDbWauMHhN+CjALljG6CNqziknvQiX6k7n7Vhjrwl82C+ccCJuRoH4Ug5KZ/F2As31hyteXm5isQEzX4+2Nmuky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dWZHFX+9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=y4OQjG/SQObAypZdOJmY4oLcZqFzZ75jK2QHH/IhD6I=; b=dWZHFX+9nkrpBo6cOqeNwr/T4n
	sOBtxyh8FEbubvkmTZgBr6/vA9tGQiFanRwgth+sOeXonRCq4QfGvgrCy/0qpOQKsqJIowfypJ/Ae
	rgIxh9n6zPup9xadU4Jvz6eRe6MR6VrASk5fbilYhTVOdRAfAr8yXO8gA80OZ+bvOk3UdowvBUmrB
	jjlrja4LlipBzMN3yYufhNDsW9ICmnNqIBk34nANY5yvb2wK6BeoHkcw0xdIMIvWEM34a1gvloFWu
	FbavR9iTCatx/3s7N6XhjFmorIdgd56yRIFOzn8JA5ruLm3eDT8f1cJdN32he9F8v9NPuQXafIAA1
	/vuIDmDA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwaXu-0000000HETq-2Pis;
	Tue, 16 Apr 2024 04:35:50 +0000
Date: Tue, 16 Apr 2024 05:35:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vishal Moola <vishal.moola@gmail.com>
Cc: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in
 __vma_reservation_common
Message-ID: <Zh4AJiHFQBkD1J_F@casper.infradead.org>
References: <000000000000daf1e10615e64dcb@google.com>
 <000000000000ae5d410615fea3bf@google.com>
 <Zh2kuFX9BWOGN1Mo@fedora>
 <Zh2m5_MfZ45Uk-vD@casper.infradead.org>
 <CAOzc2pzFSkwo21Uba3ys5u8=okYbtA2ptyc5bQJwHoS=H_UMtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOzc2pzFSkwo21Uba3ys5u8=okYbtA2ptyc5bQJwHoS=H_UMtA@mail.gmail.com>

On Mon, Apr 15, 2024 at 04:02:48PM -0700, Vishal Moola wrote:
> On Mon, Apr 15, 2024 at 3:15 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Apr 15, 2024 at 03:05:44PM -0700, Vishal Moola wrote:
> > > Commit 9acad7ba3e25 ("hugetlb: use vmf_anon_prepare() instead of
> > > anon_vma_prepare()") may bailout after allocating a folio if we do not
> > > hold the mmap lock. When this occurs, vmf_anon_prepare() will release the
> > > vma lock. Hugetlb then attempts to call restore_reserve_on_error(),
> > > which depends on the vma lock being held.
> > >
> > > We can move vmf_anon_prepare() prior to the folio allocation in order to
> > > avoid calling restore_reserve_on_error() without the vma lock.
> >
> > But now you're calling vmf_anon_prepare() in the wrong place -- before
> > we've determined that we need an anon folio.  So we'll create an
> > anon_vma even when we don't need one for this vma.
> 
> That's true. Though that can be addressed through something like:
> 
> if (!(vma->vm_flags & VM_MAYSHARE)) {
>                        ret = vmf_anon_prepare(vmf);
>                        if (unlikely(ret))
>                                goto out;
> }

Why does hugetlbfs use VM_MAYSHARE while regular faults use VM_SHARED?

