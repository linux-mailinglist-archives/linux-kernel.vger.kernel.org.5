Return-Path: <linux-kernel+bounces-89057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B5886EA0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BE728904F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFCC3C494;
	Fri,  1 Mar 2024 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A3CNMZt8"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E23BB51
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709323482; cv=none; b=fntGbDFNCmIHOuORz9FdMbLftALFxZCSxtNqcWImo7GSKzB9q4HgAYHB7LHgofqHSc7lyVJE1D4uYK1HD1r81VqsERiraOn/sIDxURs4m2V+Lw1TTFQSDG796rdAooMJSWlTzCniTomeN3VSec2eN1bX5TKy0Wz82lbRHeoscv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709323482; c=relaxed/simple;
	bh=f14nCfAkRhWaq3IBXlAwLE7i8TCJBeF4+IGty/g53bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlFPn71WTBLWcmXtrAEm41YdTLKpTp/5hAysk3YhK013ZYXViUsxExWSumIchQMclu/N847KNMgFTNrSzIFi8tO3pvEijodf9ADhZlaQH32OSo0TR9Dxy/tKTZSHXWzjLIAh2jsx8aC7SmBqTLid7Ezn3MLPJFUo5eykiQBCWvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A3CNMZt8; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 1 Mar 2024 15:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709323478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ul6pAsiH3Cf2VNyIM/Eaw82KrFx/wNv6iML+Aou3/Pg=;
	b=A3CNMZt8ut4JztwS+Y5BGVeJ949fLchBZBLX+LjjOB9qhCB37l3Kv4Ia1etW8FyEJCLtbY
	FJSRMeGGOUTJ7Aicne+l2al3woE36zN1vkYYx6T/1gep55J7tlVJOzBCBgCtnG9kQWE6CI
	d6DCw1va/+qdTPCdgDZyZryyqthecmE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, djwong@kernel.org, mcgrof@kernel.org, 
	linux-mm@kvack.org, hare@suse.de, david@fromorbit.com, akpm@linux-foundation.org, 
	gost.dev@samsung.com, linux-kernel@vger.kernel.org, chandan.babu@oracle.com, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 03/13] filemap: align the index to mapping_min_order
 in the page cache
Message-ID: <c5rw63nyg2tdkgeuvriu74jjv2vszy2luorhmv3gb4uz2z4msz@2ktshazjwc2n>
References: <20240301164444.3799288-1-kernel@pankajraghav.com>
 <20240301164444.3799288-4-kernel@pankajraghav.com>
 <ZeIr_2fiEpWLgmsv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeIr_2fiEpWLgmsv@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 01, 2024 at 07:26:55PM +0000, Matthew Wilcox wrote:
> On Fri, Mar 01, 2024 at 05:44:34PM +0100, Pankaj Raghav (Samsung) wrote:
> > +#define DEFINE_READAHEAD_ALIGNED(ractl, f, r, m, i)			\
> > +	struct readahead_control ractl = {				\
> > +		.file = f,						\
> > +		.mapping = m,						\
> > +		.ra = r,						\
> > +		._index = mapping_align_start_index(m, i),		\
> > +	}
> 
> My point was that you didn't need to do any of this.
> 
> Look, I've tried to give constructive review, but I feel like I'm going
> to have to be blunt.  There is no evidence of design or understanding
> in these patches or their commit messages.  You don't have a coherent
> message about "These things have to be aligned; these things can be at
> arbitrary alignment".  If you have thought about it, it doesn't show.

Don't you think you might be going off a bit much? I looked over these
patches after we talked privately, and they looked pretty sensible to
me...

Yes, we _always_ want more thorough commit messages that properly
explain the motivations for changes, but in my experience that's the
thing that takes the longest to learn how to do well as an engineer...
ease up abit.

> So, let's start off: Is the index in ractl aligned or not, and why do
> you believe that's the right approach?  And review each of the patches
> in this series with the answer to that question in mind because you are
> currently inconsistent.

^ this is a real point though, DEFINE_READAHEAD_ALIGNED() feels off to
me.

