Return-Path: <linux-kernel+bounces-73235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA5D85BFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7581F282A36
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BA1762F4;
	Tue, 20 Feb 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVOSjA5T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282CB762C0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442668; cv=none; b=Rqvk/2qlKOJFv1mG4Iqk8EA+kwCljfYQ4qLQi7Sx1vJq0u5R+C+N2Q4ZGM4Z3p77wmUm4BF/XPSi9j0h5lOzPix9Kz6QT4jRgQWaxivR+GSb0KhsfU4yaNrLIE6PPkW6l96nGxMVJ9PTc+12JfFMpodIi8dF0IUfxTtg3OlbHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442668; c=relaxed/simple;
	bh=I39SMvyeoy5GuZYooWccYn7jsz0Je7bnyUlzPSNDv9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT7f5CB1cvsdPM9XjpWJWHarF18u/H+xoxgaAtAk4/v5JE/rm1MAqDY0zOSxD/qtMN32m1RbVc/Bg1PzHMsHotKAFI5GqDkqqhj+FuESrecJedYSMHyGB1oG8dWcfuccSOyQwPC0VlxfxABRRphGRnHO5M2Sp0SulBahDrdJRXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVOSjA5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7230BC433F1;
	Tue, 20 Feb 2024 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708442667;
	bh=I39SMvyeoy5GuZYooWccYn7jsz0Je7bnyUlzPSNDv9s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WVOSjA5TaQlyoXDrybiLMrdo/Zi6dJ4asvUVFKQutpuJqICOLFstsc4lh/bxXrxZu
	 Mq1TBm8hPMTu2Lg2tv0ndWyBdkCi3n7Dw/5W6c1brEJr67GOaFJe71u1duVnUdxn2e
	 3HQjzbIMMevewJjPoQBqqG5pCYda5fg0lF3r+ouocihRuG+7M+f4L/k79hf25m56oo
	 BN2kSjsMwsJKrmxIH7BAuNK0Et9Q3K0q+m8RxtzeC4DM7rPCAeGNN5nuBTZ3RjNWuq
	 shdgQnzLa6wO0dTU+tePCNokj+4lPSn6If6GmsK0DfK4Vd8WoMUQquMDDF7SMEEW8S
	 9/bJ++fe+LJxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2244BCE109C; Tue, 20 Feb 2024 07:24:27 -0800 (PST)
Date: Tue, 20 Feb 2024 07:24:27 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Feng Tang <feng.tang@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Jin Wang <jin1.wang@intel.com>
Subject: Re: [PATCH v3] clocksource: Scale the max retry number of watchdog
 read according to CPU numbers
Message-ID: <0b7833a4-75f3-43ba-9d87-6f83cf4faa5a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240129134505.961208-1-feng.tang@intel.com>
 <87msrwadvu.ffs@tglx>
 <ZdNnjdNTjtvpbGH0@feng-clx.sh.intel.com>
 <388686b2-5305-43d1-8edf-19ba66d52727@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <388686b2-5305-43d1-8edf-19ba66d52727@redhat.com>

On Mon, Feb 19, 2024 at 09:20:31PM -0500, Waiman Long wrote:
> 
> On 2/19/24 09:37, Feng Tang wrote:
> > Hi Thomas,
> > 
> > On Mon, Feb 19, 2024 at 12:32:05PM +0100, Thomas Gleixner wrote:
> > > On Mon, Jan 29 2024 at 21:45, Feng Tang wrote:
> > > > +static inline long clocksource_max_watchdog_read_retries(void)
> > > > +{
> > > > +	long max_retries = max_cswd_read_retries;
> > > > +
> > > > +	if (max_cswd_read_retries <= 0) {
> > > > +		/* santity check for user input value */
> > > > +		if (max_cswd_read_retries != -1)
> > > > +			pr_warn_once("max_cswd_read_retries was set with an invalid number: %ld\n",
> > > > +				max_cswd_read_retries);
> > > > +
> > > > +		max_retries = ilog2(num_online_cpus()) + 1;
> > > I'm getting tired of these knobs and the horrors behind them. Why not
> > > simply doing the obvious:
> > > 
> > >         retries = ilog2(num_online_cpus()) + 1;
> > > 
> > > and remove the knob alltogether?
> > Thanks for the suggestion! Yes, this makes sense to me. IIUC, the
> > 'max_cswd_read_retries' was introduced mainly to cover different
> > platforms' requirement, which could now be covered by the new
> > self-adaptive number.
> > 
> > If there is no concern from other developers, I will send a new
> > version in this direction.
> 
> I see no problem simplifying it.

My guess is that we will eventually end up with something like this:

	retries = ilog2(num_online_cpus()) / 2 + 1;

but I am not at all opposed to starting without the division by 2.

							Thanx, Paul

