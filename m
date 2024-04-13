Return-Path: <linux-kernel+bounces-143915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4B28A3F82
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 00:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65EC281BAB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC708433D0;
	Sat, 13 Apr 2024 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TZHCcAQ2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7481361
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713048401; cv=none; b=q9jsqthh31YRCrpnHw6IX8rVV7R0zihpuXmb56+Ki6pqbZf8JYq00U9ZC55koq9dXk7bDwskyB7YVP3WPEaCoj5urDr8gOz0W0hDr4CudPo/XbURDDUeiP3LmnxtkdkQD1vPfYrUyQRJASM0/dc0Dx5Dpb0DlpyTU1xRERNhARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713048401; c=relaxed/simple;
	bh=bbgOjiLYoHx5VOhR91yyFL2ggglVIeeN4vTjkuQJnrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAQsjEmgpAhmVpFLqXkvdeQf2/+ZAkZhrdz2QGb6/Wzm6g2GInYiOrmo0AfI/OnrYhPbeu/xoOg6V+QQmdXjHiYo0mpxtlN1ej8JuUx+kF01DFdHUXFfs2TvFT9ktw/cAWOsF7YHT7w9KHJtL2HTUY2PLicxPMoGRt4c7m8loz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TZHCcAQ2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=upkPxeJULDIqVjxQGrFGBzCuYaSNuydHTzRPVCk4Ul4=; b=TZHCcAQ2iHu50QymwwhaQq1+68
	57ipOpLVh3k//iR8bRmORko79WByHr+cvPoCSCi+PAxXgDyLJW8pOC6skPf8AZeFTKI7ItjSXSPvW
	vPrOLAFoiS2UqemYQ1h0YweOILEood7Qo2hLf8HfqkXkUUZJzVrhRRT8hprGEpidge7B/WyXbVpkP
	tG4Rd5YLs9UCcPgavM9R7FHdGVg1usM0wegq+l76eVcfMWVg4dGqYRmmZbFbNkVVGiSP+Ua+H4i2g
	aq2ZTwHTSeAPqoynlVU1pOyprpqmwcqxF+4ZDDJklV9SBexz+H0DzAdL6+xCzRKAh5KjSzERBmbWM
	s1KJ8gWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvm8i-0000000CH5s-0y1Z;
	Sat, 13 Apr 2024 22:46:28 +0000
Date: Sat, 13 Apr 2024 23:46:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Xu <peterx@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhsLRIaQ7L-lHgF8@casper.infradead.org>
References: <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org>
 <ZhkrY5tkxgAsL1GF@x1n>
 <CAJuCfpG7YkQ2giKiv07TetTn=QHK9x723vnLaTjDCaQjUvAavw@mail.gmail.com>
 <ZhlCVOz7qaDtldfL@casper.infradead.org>
 <CAJuCfpGGUD6ev-KFhON2D2RqQRZSgjxFXvkNqeux-LrJw4L+iw@mail.gmail.com>
 <ZhlQ_4Ve0vYNbWbl@casper.infradead.org>
 <CAJuCfpEaVpuVUu0kwfpfBVQmOqbGwLkjKbXsiP=TxxmCTitukg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEaVpuVUu0kwfpfBVQmOqbGwLkjKbXsiP=TxxmCTitukg@mail.gmail.com>

On Sat, Apr 13, 2024 at 02:41:55PM -0700, Suren Baghdasaryan wrote:
> The patch looks good to me but I would like to run benchmark tests to
> see how it affects different workloads (both positive and negative
> effects). I'll try to do that in this coming week and will report if I
> find any considerable difference. For now:
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> 
> Also we should ensure that this patch goes together with the next one
> adjusting related code in uffd. It would be better to resend them as
> one patchset to avoid confusion.

I've put them here:

http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/vma-lock

0day has already run build tests, and I'm assured that they'll run perf
tests in the next few days.

