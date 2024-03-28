Return-Path: <linux-kernel+bounces-123486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90BB890953
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649F9295C98
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881B4138493;
	Thu, 28 Mar 2024 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KOhyPkwf"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05DEED8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654609; cv=none; b=h9amnHM4TYIi0WioY/OTdYMTm32ppxkYL48dpSP0tG9G9ZHxr4WgmIm1d1DKCHcOTMS4EnU8c+1jz2UGBUiVPR+BNvArCGDRwWF/bPK3bWYTM+ise/O71d3roeQ3ucxwQXeq6TUV4+klgVb/HNrI9c1GbEJziPahoy4LaddXzzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654609; c=relaxed/simple;
	bh=2FLzu1dWVnL6eeRL8aogSm6p9EQ+MDPgpTqdW2EFenY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtMaUh+WvK9zM1uP9fBgWjO+SFSCFyfVrbLTcJJeib7lZ6bG5+miLhyDgVTHSS8BC29qKfX+zGKqjYeXcdSwEgZ2E/P3kslILEyAMTKw+1bKIdd7QYaHSFRIi2ICjmYa21D65QMbDZd6S2Ampm6h6PKRaK9zwQdEqHdLRG7BbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KOhyPkwf; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 28 Mar 2024 15:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711654605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJhQSNC8P3FZAcQGH5MKGoCL/i0YWNxW5QJiOdjoIKM=;
	b=KOhyPkwfh4AJ36P0Wk23YQd+c5nTMsS/2IeCJZwGRwbyr4H3icT9wa2oQctiIVfamv3ID3
	rwogfybHV3A+T2luKtMCILW//22chCuSXNtDsyM+mNsd13FxEYD55966GAPPnHdClx/unU
	/4uAXkz4S8Vxr2E+UpUEFv8P9ZtTg6k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, willy@infradead.org, 
	jack@suse.cz, bfoster@redhat.com, tj@kernel.org, dsterba@suse.com, 
	mjguzik@gmail.com, dhowells@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <ybnwzlrn56wsnpxmfh6xt6ucv442ws5l3auq3ruvjl6zguq4rf@m3tzglm3kpm5>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <20240327104010.73d1180fbabe586f9e3f7bd2@linux-foundation.org>
 <kind5tn6ythzjca3r5wrshjyveawm7il7ng4n6zyfwctafmqwo@eldoiinbwtbn>
 <20240328122352.a001a56aed97b01ac5931998@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328122352.a001a56aed97b01ac5931998@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 28, 2024 at 12:23:52PM -0700, Andrew Morton wrote:
> On Thu, 28 Mar 2024 15:15:03 -0400 Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > On Wed, Mar 27, 2024 at 10:40:10AM -0700, Andrew Morton wrote:
> > > On Wed, 27 Mar 2024 23:57:45 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> > > 
> > > > This series tries to improve visilibity of writeback.
> > > 
> > > Well...  why?  Is anyone usefully using the existing instrumentation? 
> > > What is to be gained by expanding it further?  What is the case for
> > > adding this code?
> > > 
> > > I don't recall hearing of anyone using the existing debug
> > > instrumentation so perhaps we should remove it!
> > 
> > Remove debug instrumentation!? Surely you just?
> 
> Absolutely not.  Any code in the kernel should have ongoing
> justification for remaining there.  If no such justification exists,
> out it goes.

Certainly, but this isn't remotely a case where I'd expect to be getting
that kind of feedback. Debugging instrumentation is very much a case
where no one notices it 99% of the time, but when you need it you
_really_ need it.

Not having it can turn a 10 minute "oh, that thing is acting wonky -
it's because your system is overloaded/your drive is wonky/x subsystem
sucks, we know about it and we're working on it" into a weeklong
bughunt, burning up expensive engineer time pointlessly.

To debug complex systems efficiently, in production, in the wild, we
need to be able to see what's going on - we need more of this stuff.

Not to say that this couldn't use more work - perhaps additional focus
on what kinds of issues we expect to need to debug with this, what the
numbers mean and are useful for, documentation on how this relates to
writeback internals, etc.

