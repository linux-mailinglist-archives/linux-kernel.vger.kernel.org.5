Return-Path: <linux-kernel+bounces-162832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC18B612C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2F3EB21C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E154412A158;
	Mon, 29 Apr 2024 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DknZsuwz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4883CBA;
	Mon, 29 Apr 2024 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415675; cv=none; b=WMpnFF4Pr5FWNisy3Xrk9udVT/1sI+9NDsp0VtwwmAmN7BbEXYsZfQX/nTgSjuQQ20AzkM0TVL8kqR5JKDvEfWx5P1Y30ekgdH7tS36m9sto9XNWOVW5exjQ4L++/rNRGG+R0Sbq5ASnUKudUI7kHaI74oxc55cEHBoW553YjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415675; c=relaxed/simple;
	bh=lDZGWAziRokGy+VN6nOa0Kj92phXfS5Zq58Fyuy6tQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQtf2rmE4wLLgcSiiflfAQTJ72zl+NAWtkBLEcwMmw8IOgeeGqmsUMB+IeLJBaduHDVvgNHlcZm0H9RvZSoDigLmVhTMAx4sOtTLQANTzrRgMTWx0X53Me2Mc9UAw9ZAAoZNJ1B65eYvvUCOTqdwD9DKgLpyxzUr8e6I6RMqKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DknZsuwz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jC6bSyr5oonwWrDWbGBbEJAkPCiv04wjoLO2Q3L5KgU=; b=DknZsuwzHHHEgR7uIz155aKKoP
	muMbKntDvFIhGVgxlwB1C3G37ruqpiueUsgPiHrKoEhreK3riyfPmzgWGNjgs1wFl0IlCa0vfZnM1
	jTsbtPZUkATj20Fw7uE3hFa/uzFsAEXNYsvL6WZiAl+WgFMN8urqS1pj73wY2OXulo4c2jbFpI8z0
	eeLeLq8GYnZG1TqcwORanP2M47MM59gYy1PSaHDKRPnl0ObM8dH3IYSbvW8dAdfcgVVjhADuAU6g9
	ZMUqox2L5PCr3y+RdssQKDID7ATf7KF/C4zvM6HwGrKKZrBAZvUr0jQVWnn3JXZBHWJHZKggn+1F7
	6t/VgbWw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1VpY-0000000D53Q-3aYH;
	Mon, 29 Apr 2024 18:34:24 +0000
Date: Mon, 29 Apr 2024 19:34:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] mm/slab: make __free(kfree) accept error pointers
Message-ID: <Zi_oMFn7HxwC1by4@casper.infradead.org>
References: <285fee25-b447-47a1-9e00-3deb8f9af53e@moroto.mountain>
 <Zi8N66yehahl6D59@casper.infradead.org>
 <571761df-fe50-49e8-8d56-65fbdec9a185@moroto.mountain>
 <6406512f-12de-1ab6-05c9-4583c0cb01e6@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6406512f-12de-1ab6-05c9-4583c0cb01e6@linux.com>

On Mon, Apr 29, 2024 at 09:29:58AM -0700, Christoph Lameter (Ampere) wrote:
> On Mon, 29 Apr 2024, Dan Carpenter wrote:
> 
> > I've always thought freeing pointers that have not been allocated is
> > sloppy so I like that kfree() doesn't allow error pointers.  We always
> > catch it before it reaches production and that teaches people better
> > habbits.  Personally, I like how free_netdev() only accepts valid
> > pointers.
> 
> kfree() already checks for NULL and ZERO pointers. We should add these
> checks in *one* location.
> 
> Maybe issue a WARN_ONCE() and simply treat it as a NULL pointer if an error
> code is passed?

Did you even read the initial patch?  The point is that this new automatic
destructor path can pass error pointers to the destructor for completely
valid code.  Warning would completely defeat the purpose of this exercise.

