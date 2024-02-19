Return-Path: <linux-kernel+bounces-71708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F5585A950
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97E51C22015
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FB8405D3;
	Mon, 19 Feb 2024 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u19BYPk5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A440BEF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361474; cv=none; b=ju32Gkhoi9ikhVyhVhvmX3Icv66yIZWQI6y4sbZrTQdlRSPgYXxcSqvBnWKMDiVVEd93uv7mDkOi93+YO6GYON6G6SscsU3RR8box4IVl7OTz7F1RNSDBE3HzrFwGEJXa2tQUE+flihEIPv/8h0xlfSKgX4JOwdsOKW5oCSvt2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361474; c=relaxed/simple;
	bh=DdD3j5XhCn0EknIO/60FDYkuXpk4uDO0Md2NP1sph8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXeZlk+LQ1waDJ0b0OAk47y0FqIxCkdoH1NzIVcuR3IS4JCiZAoCFp1vIsII8tMF7Zxoq8AmSFTM94RLmTpZYiZ6cpOj1Yzrs//dDGLFdDEzJZuKPPAetcbZkGEnG6wS8nHpixhcDo4inIYTun2ZmZbaHvQbRAh5f0cPapRX7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u19BYPk5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i0E4eQpTOIwPHD4AY+ANWQYLzpqrYXlwWbKYvpZ1KIQ=; b=u19BYPk5u9c0pMjXJTYREC1I7o
	/e42Y6IuzK+u/EZSLfbcVb59UobsbB5xDL/1Vl6Z+w0ESAaGYDzzOXHoIPUmeZDGXW+OJdJAMfkLd
	A3QwVsJLULB9uHsyacx3pv0ET2dc1hbEq+6PGABRtG/8fXgyJfKFtWpkYBYx6d8m+jUtU2Igxh5Sq
	zd3EblFPpGBgAojJ2YRZN2KcddLs99hBq2L9U0lfpKPoZ4E2VsVE3MTYXp9ETwppxVqbIpiO4ydqM
	blid2wBl4QRukgIySrSbOUocpIJ2utO8GhtFMcxfm0kOiMQC1Rw0IBpyDG3er2njLH64pv7LVeSp2
	wA5CowFg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc6rD-0000000DIa6-1rTK;
	Mon, 19 Feb 2024 16:51:07 +0000
Date: Mon, 19 Feb 2024 16:51:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lipeifeng@oppo.com
Cc: akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Support kshrinkd
Message-ID: <ZdOG-135dLP0IeU8@casper.infradead.org>
References: <20240219141703.3851-1-lipeifeng@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219141703.3851-1-lipeifeng@oppo.com>

On Mon, Feb 19, 2024 at 10:17:01PM +0800, lipeifeng@oppo.com wrote:
> 'commit 6d4675e60135 ("mm: don't be stuck to rmap lock on reclaim path")'
> The above patch would avoid reclaim path to stuck rmap lock.
> But it would cause some folios in LRU not sorted by aging because
> the contended-folios in rmap_walk would be putbacked to the head of LRU
> during shrink_folio_list even if the folios are very cold.
> 
> The patchset setups new kthread:kshrinkd to reclaim the contended-folio
> in rmap_walk when shrink_folio_list, to avoid to break the rules of LRU.

Patch 1/2 didn't make it to my inbox or to lore.  But you should talk
about the real world consequences of this in the cover letter.  What do
we observe if this problem happens?  How much extra performance will we
gain by applying this patch?


