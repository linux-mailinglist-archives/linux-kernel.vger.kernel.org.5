Return-Path: <linux-kernel+bounces-40147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C627383DB34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822C328E441
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08331B95B;
	Fri, 26 Jan 2024 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QINdN9B5"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F11B943
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277228; cv=none; b=FaV7D4PZ/3bizsdo1PiqqP4uUbztTEBcS2RTzHAuTWxwMi68UZnwjZJL9RcUntT5XpTjl1QGyf24ol1DojASuyqTRd+v3ojcasZXnGui5ULvL2VwOfe0a995YL6CTu2o5xpGUzw/h3IUtMHSGCyNybUn56YkJqijq8SYMiXU9Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277228; c=relaxed/simple;
	bh=9QLCMYdSDg56PB4jhgtUKPidWzlGfB8PBIuvdsq8zZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcTnQXqz617TdMWpvv9oOxs969IbLA9YM0mY3PFgwmVNNTnrBdJMLR3FozXddyeqwcMlTimiJVIKLqo8Y5pmAXfwIyJmNYkJToFUAOFeTSWjWNFpixpA8qQzohCK9eqynxle8ntNR4EJhnYQh356W7X4flNaL61aHW4LBkz/KJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QINdN9B5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XxSk9Xjv1L8fIDK7yqbqV24ThJunhw8ONOqeFPoB0kU=; b=QINdN9B5u/bXXbU/IOYFbmNxGK
	8w5m+DZTQmdpidDw89k3WnUnK4Ucv0Ov+o7voooVVZLhzWqqQbrDaEgTxtsP/z51C5agMn2ffCZJB
	2zq5NUJ7S6uTwTDMmpMYD522Ng8pzjp14laKMZ/gHl5W/Alb9IuGtA1+ntNQozgqyBzRvJYQpD9of
	n5xiWKdMjbUmi7XNv6RZFmnesoqv7yGZcuYiw2DI68VUVFKVhqYD+ASQ7fEbXghdx5Ac/w8dC9Urx
	kZpGrNR6cFRQ0PVq0xdT1S9wrmxgFzMDzwwsFqJKPTNSqpserY3qTnaGnVyfDk+/mLc9xpsmYTy6M
	VLJkGOLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTMeQ-00000004Ftt-0Mff;
	Fri, 26 Jan 2024 13:53:46 +0000
Date: Fri, 26 Jan 2024 05:53:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scs: add CONFIG_MMU dependency for vfree_atomic()
Message-ID: <ZbO5ag2fBt4KIgn9@infradead.org>
References: <20240122175204.2371009-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122175204.2371009-1-samuel.holland@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 22, 2024 at 09:52:01AM -0800, Samuel Holland wrote:
> The shadow call stack implementation fails to build without CONFIG_MMU:
> 
>   ld.lld: error: undefined symbol: vfree_atomic
>   >>> referenced by scs.c
>   >>>               kernel/scs.o:(scs_free) in archive vmlinux.a

Well, please just provide vfree_atomic for nommu then.  vfree maps
to kfree which can be called from atomic context, so vfree_atomic
can do the same.

