Return-Path: <linux-kernel+bounces-73404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E385C210
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B02A1F22763
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E25076909;
	Tue, 20 Feb 2024 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn4cp/Dw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F05626C6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448993; cv=none; b=Vowle+0o+q2mPzd5jXmoYGnhYwpgXe9bPoTh4ZSCfBN23GlzU3eyB2LgkOPINJ8CCRnE/CGTJqkwFg/DgKbkJQmGcYBMBak4cyU2u41W7VqrqgeAI0Rbu0sSRMuewjxtO4jay8FIvKiRRl39IzU3YxFlzO7cELz+6XlChohRlCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448993; c=relaxed/simple;
	bh=IuYUnTcNI7A33LoTZwZRSGnYwOg8OpnlQpKw+Sz4gLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuYVodS8iQJSzhOZs0jeS9wxwbDQiINY0363xJVv4L5IIH3t/ZkXF0/Q+9jh5HatepEcXD16eqtYQRe2TBsGzRyzqwAAvViZTgOijCSS2rBHUhTvMVL2lcPr5KNblwsthzjgnPbmKJ6d98cfWzlIgdT4kxuVkxQCf535CvPhvnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn4cp/Dw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A714C433C7;
	Tue, 20 Feb 2024 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708448993;
	bh=IuYUnTcNI7A33LoTZwZRSGnYwOg8OpnlQpKw+Sz4gLg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mn4cp/Dw0jowoGmikQrA2F3nhmpJ8YzTR+Iiy8n9fA/zKEFg4TG0Yr3Bg87I+C4+1
	 kSDAN4LsND6HFPER4IhC2VwvDkL0N3WSMCMF8kvoBFCF6uvDDwtCDUI7rYC6ku7p8y
	 km54BEc8SB1xn+055ytuJ7gPH8kQ59DSv24fyRpZcV3uXmTozYu5z7yjhcT9cuSgHO
	 q9W0X9X/3OYX3AKjgo+nsa9d6vncbyWK+wRbcR5X49cM88dwqrmtt8atuIHejJbqF4
	 JuwjWmr1Qpl99bdNiH9rKQg39kGdnc7JwCVNjoS0P25mnex6QhcJ35lfFpvgMLAoIb
	 /icIstXx0psqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D90DCCE109C; Tue, 20 Feb 2024 09:09:52 -0800 (PST)
Date: Tue, 20 Feb 2024 09:09:52 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Feng Tang <feng.tang@intel.com>
Cc: Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Jin Wang <jin1.wang@intel.com>
Subject: Re: [PATCH v3] clocksource: Scale the max retry number of watchdog
 read according to CPU numbers
Message-ID: <d0517bce-6284-43b8-bcf8-c56ac83fb31f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240129134505.961208-1-feng.tang@intel.com>
 <87msrwadvu.ffs@tglx>
 <ZdNnjdNTjtvpbGH0@feng-clx.sh.intel.com>
 <388686b2-5305-43d1-8edf-19ba66d52727@redhat.com>
 <0b7833a4-75f3-43ba-9d87-6f83cf4faa5a@paulmck-laptop>
 <ZdTE2SzO1pZ0QjUn@feng-clx.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdTE2SzO1pZ0QjUn@feng-clx.sh.intel.com>

On Tue, Feb 20, 2024 at 11:27:21PM +0800, Feng Tang wrote:
> On Tue, Feb 20, 2024 at 07:24:27AM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 19, 2024 at 09:20:31PM -0500, Waiman Long wrote:
> > > 
> > > On 2/19/24 09:37, Feng Tang wrote:
> > > > Hi Thomas,
> > > > 
> > > > On Mon, Feb 19, 2024 at 12:32:05PM +0100, Thomas Gleixner wrote:
> > > > > On Mon, Jan 29 2024 at 21:45, Feng Tang wrote:
> > > > > > +static inline long clocksource_max_watchdog_read_retries(void)
> > > > > > +{
> > > > > > +	long max_retries = max_cswd_read_retries;
> > > > > > +
> > > > > > +	if (max_cswd_read_retries <= 0) {
> > > > > > +		/* santity check for user input value */
> > > > > > +		if (max_cswd_read_retries != -1)
> > > > > > +			pr_warn_once("max_cswd_read_retries was set with an invalid number: %ld\n",
> > > > > > +				max_cswd_read_retries);
> > > > > > +
> > > > > > +		max_retries = ilog2(num_online_cpus()) + 1;
> > > > > I'm getting tired of these knobs and the horrors behind them. Why not
> > > > > simply doing the obvious:
> > > > > 
> > > > >         retries = ilog2(num_online_cpus()) + 1;
> > > > > 
> > > > > and remove the knob alltogether?
> > > > Thanks for the suggestion! Yes, this makes sense to me. IIUC, the
> > > > 'max_cswd_read_retries' was introduced mainly to cover different
> > > > platforms' requirement, which could now be covered by the new
> > > > self-adaptive number.
> > > > 
> > > > If there is no concern from other developers, I will send a new
> > > > version in this direction.
> > > 
> > > I see no problem simplifying it.
> > 
> > My guess is that we will eventually end up with something like this:
> > 
> > 	retries = ilog2(num_online_cpus()) / 2 + 1;
> 
> Good point! Initially when writing the patch, I did try to search if
> there is a 'ilog4' api :) as the ilog2 of that 8-socket machine is
> about 10, which is more than enough.

I am also not averse to starting with the above, either.  ;-)

							Thanx, Paul

> Thanks,
> Feng
> 
> > 
> > but I am not at all opposed to starting without the division by 2.
> > 
> > 							Thanx, Paul

