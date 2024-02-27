Return-Path: <linux-kernel+bounces-83668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD6E869D25
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1D1BB2520B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BC43F9C6;
	Tue, 27 Feb 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zwzw8Db3"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B82557F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053377; cv=none; b=EMRClSz4cphcKtgTXZQtRdxV5+dug2dg/M5ho9XZl42aNAMuX0V4wLfmSEp/0KHgzXRCUNmSOraxc1XiXIFNPD9nIPEwL1cfNKnEqT+ei0PjcNP9db8cbVeVLwvBKEDtBl7tT4Tu1nupGu6nRUY2zjxIum2Hm2LywWJi3xFHAqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053377; c=relaxed/simple;
	bh=fYmViQBsuq3KWkkQSjDassbD/MSa99mQLTE6HIwVoXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLPOV+0oAEsEvnkKxFN0kuTR1OZnc24SnOjje1rk1vTyj1c8o/4+yNQTo2amDpea3CACxx8PmigjDmVw3bgb7o+rQ5GtqYJp4L+lTAngG9BbelxO76oI8hUEQcu2gwiT220OxHSa9k4hRY4Ciie28okbc3UjG75rlZ4n/E3QJn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zwzw8Db3; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 12:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709053374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L7UKNUBGlTpDM+CMJiwE59d0Y/y96axVL+XtjpcRUAA=;
	b=Zwzw8Db3LDsRNenY3gGa6Tbi9kd/j+4+EG0yzxqltzcHBRhreGIzqWUegudphiZIy7OVqz
	eO//SmJ5XmyEQXUl1CgTYL41h6t2FLjxJGpkdi9zUiUudSS6P9f4h3G9UAmDgDo9owgxi7
	mkil4OFoWnUlRblZaE0G4d99LhmFBfA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, david@fromorbit.com, 
	chandan.babu@oracle.com, akpm@linux-foundation.org, mcgrof@kernel.org, ziy@nvidia.com, 
	hare@suse.de, djwong@kernel.org, gost.dev@samsung.com, linux-mm@kvack.org, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 03/13] filemap: align the index to mapping_min_order in
 the page cache
Message-ID: <na2k4nnvkseh2yh27eqkbfyouf7vnerd6i7pt4z7f7xsjsm6pu@ry5tvdcr2ggw>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-4-kernel@pankajraghav.com>
 <Zdyi6lFDAHXi8GPz@casper.infradead.org>
 <37kubwweih4zwvxzvjbhnhxunrafawdqaqggzcw6xayd6vtrfl@dllnk6n53akf>
 <hjrsbb34ghop4qbb6owmg3wqkxu4l42yrekshwfleeqattscqp@z2epeibc67lt>
 <aajarho6xwi4sphqirwvukofvqy3cl6llpe5fetomj5sz7rgzp@xo2iqdwingtf>
 <vsy43j4pwgh4thcqbhmotap7rgzg5dnet42gd5z6x4yt3zwnu4@5w4ousyue36m>
 <4zpsfvy3e4hkc4avvjjr34rgo7ggpd6hpflptmiauvxwm3dpvk@5wulihwpwbyp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4zpsfvy3e4hkc4avvjjr34rgo7ggpd6hpflptmiauvxwm3dpvk@5wulihwpwbyp>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 05:55:35PM +0100, Pankaj Raghav (Samsung) wrote:
> > > > 
> > > > you guys are both wrong, just use rounddown()
> > > 
> > > Umm, what do you mean just use rounddown? rounddown to ...?
> > > 
> > > We need to get index that are in PAGE units but aligned to min_order
> > > pages.
> > > 
> > > The original patch did this:
> > > 
> > > index = mapping_align_start_index(mapping, iocb->ki_pos >> PAGE_SHIFT);
> > > 
> > > Which is essentially a rounddown operation (probably this is what you
> > > are suggesting?).
> > > 
> > > So what willy is proposing will do the same. To me, what I proposed is
> > > less complicated but to willy it is the other way around.
> > 
> > Ok, I just found the code for mapping_align_start_index() - it is just a
> > round_down().
> > 
> > Never mind; patch looks fine (aside from perhaps some quibbling over
> > whether the round_down()) should be done before calling readahead or
> > within readahead; I think that might have been more what willy was
> > keying in on)
> 
> Yeah, exactly.
> 
> I have one question while I have you here. 
> 
> When we have this support in the page cache, do you think bcachefs can make
> use of this support to enable bs > ps in bcachefs as it already makes use 
> of large folios? 

Yes, of course.

> Do you think it is just a simple mapping_set_large_folios ->
> mapping_set_folio_min_order(.., block_size order) or it requires more
> effort?

I think that's all that would be required. There's very little in the
way of references to PAGE_SIZE in bcachefs.

