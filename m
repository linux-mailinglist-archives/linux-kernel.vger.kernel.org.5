Return-Path: <linux-kernel+bounces-40496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E80083E1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63A5B21C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DCF2231A;
	Fri, 26 Jan 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UwcRX1yS"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ACC22301
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294100; cv=none; b=JmuhGthS7uciqlJFaS3LYfbktDXGQPhiIV8scN6d0xfgAIR/4wTVBrgRbzV2X/B4soJyrJGz4p1cssuhEEGcW633fo2Gca+hHrhn+TN1JpCfsreSGoAvhqYKqX6cu7KZrEiKMO1lqScEiJxyg2vtCmcbvXmMV9xDyjd+/8gDqKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294100; c=relaxed/simple;
	bh=preSX0quXvFKX+sSbZN+zc+SigzkAHZEJzhFhllCae8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/mEaUcucl0l+iDtXDQC1TtB3zaBVS8nkiWmoj2bDqEJBbkKk+hkFUZsAKSOCvPa1+4RHPeTrdghpSZRN3xYzZaLaj1G5Gcg3QPNfk3LxRp511iIb06GxTpARn9aC8iuD2Yfl2efX8wwUnSHDQu4RdWW/Cblovbo5FmsHXtzOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UwcRX1yS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g8fiwmPSySU4eNFj55g0a5/9A7qTajzirLf5GX98rOs=; b=UwcRX1ySFi1nbOK5g7PfabK6sw
	7qXUH+5DP3RGvhMrBAH0NjHlQc18EsMIs0fBXguuVmmtNX0wzGAfNlnMvUje8wBU+WjtdLUhB6iCQ
	KJvKSPFA5F09x4naLxMx5rOD5iMJe3KtPiYgA63p5KOPhRVXY4UK8gFkb027dTcs41tTiYN5HacPQ
	/PHL4ZkTZ66AOtgPszGnjv6LLLcWfD80omFft65a3af/c+r+fX6ndJzRJg95EBB7bLI0VUSd+CbB+
	i4dfFnte4jYPjSFzzvcNgfJYY7OcnwAkjC41ojscIBOG/Soct19joxB42DElNMezqgtaRpc6DRmgu
	qXHqzJyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTR2U-0000000EUM5-3YYE;
	Fri, 26 Jan 2024 18:34:55 +0000
Date: Fri, 26 Jan 2024 18:34:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	Zijie Zhao <zzjas98@gmail.com>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [Linux Kernel Bug][mm/gup] 3 Warning Crashes: kmalloc bug in
 gup_test_ioctl, is_valid_gup_args, pin_user_pages_fast
Message-ID: <ZbP7ThrtxhIBJChT@casper.infradead.org>
References: <CALGdzuqqU1PJ3BZ2PRtCHXyrsZ2xtzk38abB0=K7V-kOCYgHfA@mail.gmail.com>
 <ZbPnsnwnVKvI1rQ4@casper.infradead.org>
 <CALGdzuo7V-3-US9U+rjyBfmZD=d-gUfAxJejsTUsmnSZNDnh5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALGdzuo7V-3-US9U+rjyBfmZD=d-gUfAxJejsTUsmnSZNDnh5A@mail.gmail.com>

On Fri, Jan 26, 2024 at 11:31:26AM -0600, Chenyuan Yang wrote:
> In this context, I would like to seek your valued opinion. Do you
> believe it would be more prudent to avoid fuzz testing the
> `gup_test_ioctl`, or are the warnings in `gup_test_ioctl` an
> anticipated outcome?

It seems like a waste of time.  Debian certainly disables it, so
unless you can find a distro who enables it, I wouldn't bother.

> It seems that `gup_test_ioctl` can indeed be exposed in the kernel by
> accessing /sys/kernel/debug/gup_test.

If someone wants to fix these things, they can, but it just doesn't
seem worth doing.  Part of the art of fuzz testing is finding things
that are worth testing.

