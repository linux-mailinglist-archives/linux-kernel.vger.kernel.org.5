Return-Path: <linux-kernel+bounces-145968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087E68A5DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68ADEB21D06
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0F6157A5C;
	Mon, 15 Apr 2024 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XQgDpiY/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766FC25601
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713219310; cv=none; b=YVrQ5ZTzYdufwePsdudLNOhKQ4mipnGXDs0WADBXn8GtKwdvPl059dTB26RB8bfRlVFfHE6pUXQPNGay/LaqT+tIqFmWPijOTZ6niVHeayimY7zIMwSATA+YxbPxSLC+fXwPAxE/irmww1r1aaEt1e+JwNYXTzdynSbDnh/N1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713219310; c=relaxed/simple;
	bh=PY44UZjjjuhrlz20AyxwSiMqoFKLANo/z/GnBHE0Uj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGIwT4fSrCXr2Q4gOx3UK9/OGNk1ypfxH+ViaIzxnrkbsYjp7yILRkyGnrhb7Cr5dv47hVU6XP2tAqA9vpx1ekgbp4EU2mq4V1FE+DGTKeg5/5Ib5Ap6M/jWbKMdBpbuVaJMkzhnpQi1+s1CN/SIq5XiAWLEIm9EariKkw6kURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XQgDpiY/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=anUTzNn+XCSh5szgQ2VdZfjbgbKcul8tT9KISExHK4I=; b=XQgDpiY/ZLRUxbAWj8QHZRpuce
	4fLm0z3rwhAL7vNnOmZs49/ktsbPbNe/bfVJ+gLne6S0NkdmxIwWHOLW1fnQ6qVdQqsricx07yIbl
	24ODbemxB4zUtxJQPL2MJ6GbdF1hxMR+NO1F2enzLcA0YLx1ZLepzUVK9BhHq17WoJ6bmt1vKgQvT
	U+qjyCIv9JwQUFvXfWbGDinewWPPPZzfrs5phOhykyIwxY2tTJGsDKJdDf86xbl7WP+Si2OfOOI6K
	GDTk08AtsfpucR24DmB2SdfWRdCtdc96FmIfUYPzHTEAR/EV6qhZShIgxi3hsVF6o2YmF0rfh1YnE
	tB/VKGeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwUbP-0000000GbxN-28TT;
	Mon, 15 Apr 2024 22:15:03 +0000
Date: Mon, 15 Apr 2024 23:15:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vishal Moola <vishal.moola@gmail.com>
Cc: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in
 __vma_reservation_common
Message-ID: <Zh2m5_MfZ45Uk-vD@casper.infradead.org>
References: <000000000000daf1e10615e64dcb@google.com>
 <000000000000ae5d410615fea3bf@google.com>
 <Zh2kuFX9BWOGN1Mo@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh2kuFX9BWOGN1Mo@fedora>

On Mon, Apr 15, 2024 at 03:05:44PM -0700, Vishal Moola wrote:
> Commit 9acad7ba3e25 ("hugetlb: use vmf_anon_prepare() instead of
> anon_vma_prepare()") may bailout after allocating a folio if we do not
> hold the mmap lock. When this occurs, vmf_anon_prepare() will release the
> vma lock. Hugetlb then attempts to call restore_reserve_on_error(),
> which depends on the vma lock being held.
> 
> We can move vmf_anon_prepare() prior to the folio allocation in order to
> avoid calling restore_reserve_on_error() without the vma lock.

But now you're calling vmf_anon_prepare() in the wrong place -- before
we've determined that we need an anon folio.  So we'll create an
anon_vma even when we don't need one for this vma.

This is definitely a pre-existing bug which you've exposed by making it
happen more easily.  Needs a different fix though.


