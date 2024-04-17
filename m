Return-Path: <linux-kernel+bounces-149259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9C38A8DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706201C2131E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315876A8DB;
	Wed, 17 Apr 2024 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qc1llDWP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612EC8F4A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713389474; cv=none; b=lpNnz+BcT9S8258eBo1rjKMT8OBehCinijWy8lh5HS2wGXM3ztMYJFDqgUmwEHMOCfHY6mF8oa6D0F3Cy4DkXsf3fvwVM6ZaAwnoVYXkY7ONugloA4QdF3DOkKof/5S/IUVtFCnZ4z/VaK26NVsN9Sgr1qA0aF+kL+BFuodXEag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713389474; c=relaxed/simple;
	bh=BUvNBDN8ASj+mIKXlPKJ5UdnbvlyYutLvYoQLGXc4wI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Eiv+cUGaHSc1gixF4nIpLuw5CkR5xZyZeNVmA5HFf40IGMEDgi/OxnFyp+DMvKlQUihORK0gMhDxh6eS7aELCTVjrhd4fqWA0wKMSh6Og1vDGk3Ing3IN2nsNu1VLCT9G3BnOTOfVJ+YIvJPH+A3h0F1HfwKPU9jT8oNMvAdjtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qc1llDWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB04CC072AA;
	Wed, 17 Apr 2024 21:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713389474;
	bh=BUvNBDN8ASj+mIKXlPKJ5UdnbvlyYutLvYoQLGXc4wI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qc1llDWPkmmexlecR7t7m9hPyzRNjGUKegtPtvV4t9OU3Ki6bf4DrCbOH0jCC/mK+
	 UQle3IettyM3nCBs/5FdGl2w/O1IoWdHveaggrY8f93h1L0/S8s65M/9EwCnCeXnXI
	 XrDjuB/yJlPn6jyJDDP/kHDTVxh39Zq94hXfvUsE=
Date: Wed, 17 Apr 2024 14:31:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, Vishal Moola
 <vishal.moola@gmail.com>, syzbot
 <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in
 __vma_reservation_common
Message-Id: <20240417143113.23df96102dcdd2b0c3805329@linux-foundation.org>
In-Reply-To: <Zh4zKy-4Wv5bbR5n@localhost.localdomain>
References: <000000000000daf1e10615e64dcb@google.com>
	<000000000000ae5d410615fea3bf@google.com>
	<Zh2kuFX9BWOGN1Mo@fedora>
	<Zh2m5_MfZ45Uk-vD@casper.infradead.org>
	<Zh4zKy-4Wv5bbR5n@localhost.localdomain>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 10:13:31 +0200 Oscar Salvador <osalvador@suse.de> wrote:

> On Mon, Apr 15, 2024 at 11:15:03PM +0100, Matthew Wilcox wrote:
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
> > 
> > This is definitely a pre-existing bug which you've exposed by making it
> > happen more easily.  Needs a different fix though.
> 
> I do not think this is a pre-existing bug.
> Prior to 'commit: 7c43a553792a ("hugetlb: allow faults to be handled under
> the VMA lock"), we would just bail out if we had FAULT_FLAG_VMA_LOCK.
> So there was no danger in calling functions that fiddle with vmas like
> restore_reserve_on_error() does.
> After that, we allow it but vmf_anon_prepare() releases the lock and returns
> VM_FAULT_RETRY if we really need to allocate an anon_vma.
> The problem is that now restore_reserve_on_error() will re-adjust the
> reservations without the vma lock, completely unsafe.
> 
> I think the safest way to tackle this is just as Vishal did, call
> vmf_anon_prepare() upfront only for non VM_MAYSHARE faults.

Thanks.  I didn't apply anything at this stage, because this patch
appears to be against linux-next/mm-unstable whereas for a -stable
backportable thing it would best be against current -linus.

So can we please sort out a suitable Fixes:, redo the patch against
current mainline, add the cc:stable and await further input from
Matthew?

