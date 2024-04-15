Return-Path: <linux-kernel+bounces-145527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 662618A576C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFE11F23874
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CD4811E0;
	Mon, 15 Apr 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QvzD4Ed8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A983CA3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197622; cv=none; b=BtDL8M6ejAHxvonxvx0Id000fEcfocoUOACUCpBJQkJ0EZaFRVS7Omlo8AjMkvoUfd+FFau20O9xL5LYqOvoGogvcNwet1ZPlugFZ7Pycc8+Y7SJxz8T3nxno+nwc9xOl/pIhE+tdrlrbWtiCbk6VUFB4CPzkSUKxjpmNRHKres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197622; c=relaxed/simple;
	bh=mCtIHA1LTE9G3LpB5/RUpWQ2ODFbnnTQSX6/5fhGGKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdCRY3QoO6o22YntRtUIeW5n4EDK7i2mPd7oHxM+baPSUREF6e8QqL6h+KdCqhcGl6ij07i7eeBQjqprvmumQ9GPwqtZZm1sUqNSPW49aOgqkR0+ePh402+kUTp7PMcZXPdw0Qa9Bi2wjRRQdjYu1Z3PQozJiALc7YtHQtR3JMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QvzD4Ed8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ToKN62Q4GRJ7E8YeKAya0yUnhTdusOG3jL+WvWPRhf0=; b=QvzD4Ed83WoTy91rCtph5mP5cd
	PnmU/2eX9kih8oIA/e9N3SEwKXVFZUV7j2gg4xBemcc5NFhmPkK4P+LczOHZeWgx7azYWsdsIyOtr
	CXwxOawZhCOvSP3pO8gc0nHijUCNdUcezi0MUtrwAJuKVAqQwWu4KC1PoVyICvaC9HgXi00/NBYfa
	YWZ6VHRRO/vsehnGmGSNfTOESwgatnNt5FQbm6h1LY6OI/KjYWaPzL5I5ng0QsWcTQaHWR6Vp3DRW
	ReEgxuPxIwbF8N0BfUmCDlw1zXTDgU6a/EpKXieX8MyWMmcoGY89Oh38GKHBHnMO+keqjJGMIJPU2
	vZfz98DQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwOxc-0000000G2ku-37Np;
	Mon, 15 Apr 2024 16:13:36 +0000
Date: Mon, 15 Apr 2024 17:13:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Xu <peterx@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <Zh1SMHdN9xK9N2U_@casper.infradead.org>
References: <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org>
 <ZhkrY5tkxgAsL1GF@x1n>
 <CAJuCfpG7YkQ2giKiv07TetTn=QHK9x723vnLaTjDCaQjUvAavw@mail.gmail.com>
 <ZhlCVOz7qaDtldfL@casper.infradead.org>
 <CAJuCfpGGUD6ev-KFhON2D2RqQRZSgjxFXvkNqeux-LrJw4L+iw@mail.gmail.com>
 <ZhlQ_4Ve0vYNbWbl@casper.infradead.org>
 <CAJuCfpH3sKvczqRix6Q6QX9L4FsHQbmnyFXetvY+TzVUk38soA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH3sKvczqRix6Q6QX9L4FsHQbmnyFXetvY+TzVUk38soA@mail.gmail.com>

On Mon, Apr 15, 2024 at 08:58:28AM -0700, Suren Baghdasaryan wrote:
> On Fri, Apr 12, 2024 at 8:19 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Apr 12, 2024 at 09:53:29AM -0500, Suren Baghdasaryan wrote:
> > > Unless vmf_anon_prepare() already explains why vma->anon_vma poses a
> > > problem for per-vma locks, we should have an explanation there. This
> > > comment would serve that purpose IMO.
> >
> > I'll do you one better; here's some nice kernel-doc for
> > vmd_anon_prepare():
> 
> I was looking at the find_tcp_vma(), which seems to be the only other
> place where lock_vma_under_rcu() is currently used. I think it's used
> there only for file-backed pages, so I don't think your change affects
> that usecase but this makes me think that we should have some kind of
> a warning for lock_vma_under_rcu() future users... Maybe your addition
> of mmap_assert_locked() inside __anon_vma_prepare() is enough. Please
> don't forget to include that assertion into your final patch.

That's patch 1/3 on the git branch I pointed you to.

The tcp vma is not file backed, but I'm pretty sure that COW is not
something they want, so there's never an anon_vma.  It's for pages
that contain received TCP packets; ie it's mmaped TCP.

