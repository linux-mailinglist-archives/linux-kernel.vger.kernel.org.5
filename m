Return-Path: <linux-kernel+bounces-37404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AE983AF50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A601F24A14
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9217F7D8;
	Wed, 24 Jan 2024 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TULLLDgB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2BD7E795
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116332; cv=none; b=N34hCPIRFxQlRguxd1Cen5PHc498F2fhcFtoQA25hS3OAsaeh66FnMrbnOPUegTwMUEk4fMJNdOAoIKgEAjAvbFdbT++L2LY2gRiqDdlCRHvf1CdnOLrNMSyKNRSsQm3+LUWh1sAXzIlOlHgKdNfRfcOTDyeUk4Q+sDbayJYZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116332; c=relaxed/simple;
	bh=Oaza5IVgRe39ZJc3EEbe7VFK4k2+2HENytXXpvcr6fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H87q81dpdgDmbUEw1uCZjCgiQgCF3aDBnQlTOfFKfmIG/2cafZlTviE2wHiD7rVOj4QDiv/kZZwqD1lbdn5PV6pe/RsEoMIkuVAN1Qn1rJG2o11RwYk4DJgmd5wzqDxYiHDEyo//X7EW1sa/Z6sgCwP/lQoHMgIitgBxQi5yZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TULLLDgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9A4C433F1;
	Wed, 24 Jan 2024 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706116331;
	bh=Oaza5IVgRe39ZJc3EEbe7VFK4k2+2HENytXXpvcr6fM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TULLLDgBs83XXgF7VXjMnixZ/zssNRjrxnns+DXuK9awYVGemG6ku3IoS2YoM8PhD
	 Rc4GkQECuU3XFGv6wmKNEXMlqdpqb5uGrnbdm0EosWsTUZTDyDyDYwh7253hEZTA6A
	 +q/qZ/WN1uSzUYOi0tA/TwYscWfqlnXGgrYDAO6+uQWAoMBxvDCrc07BYuUzyJmzeY
	 jIiRBRjObqwEtD4Y3VPvww62RamIx6jdTaI/PgAY3ooxnXKYoBDIRj+s4CexM9nNpE
	 WCgDK7f/pnmf2J1YRyV2kFcM5PYQVQbjh94sErbMZdEQ+8M+LPIWQG6qI4cIu3AIvt
	 r6PaD79eK7HxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 664BCCE145A; Wed, 24 Jan 2024 09:12:11 -0800 (PST)
Date: Wed, 24 Jan 2024 09:12:11 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jiri Wiesner <jwiesner@suse.de>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v3] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <b437c9c7-b2e6-432d-89c1-eb2497bc742a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240122172350.GA740@incl>
 <616658ba-0e69-447b-8b52-5051a5aa9bc0@paulmck-laptop>
 <20240124164803.GN3303@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124164803.GN3303@incl>

On Wed, Jan 24, 2024 at 05:48:03PM +0100, Jiri Wiesner wrote:
> On Wed, Jan 24, 2024 at 08:03:42AM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 22, 2024 at 06:23:50PM +0100, Jiri Wiesner wrote:
> > > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > > index c108ed8a9804..3052b1f1168e 100644
> > > --- a/kernel/time/clocksource.c
> > > +++ b/kernel/time/clocksource.c
> > > @@ -99,6 +99,7 @@ static u64 suspend_start;
> > >   * Interval: 0.5sec.
> > >   */
> > >  #define WATCHDOG_INTERVAL (HZ >> 1)
> > > +#define WATCHDOG_INTERVAL_MAX_NS ((2 * WATCHDOG_INTERVAL) * (NSEC_PER_SEC / HZ))
> > 
> > We need something here to force 64-bit arithmetic on 32-bit systems
> > correct?
> 
> I think it is not strictly necessary because
> (2 * HZ / 2) * (NSEC_PER_SEC / HZ) = HZ * (NSEC_PER_SEC / HZ)
> so even a 32-bit integer would not overflow when NSEC_PER_SEC / HZ is 
> bracketed. But I could make a change to:
> +#define WATCHDOG_INTERVAL_MAX_NS ((int64_t)(2ULL * WATCHDOG_INTERVAL * NSEC_PER_SEC / HZ))
> to make it explicit and remove the risk of overflow if the constant was 
> increased (for testing purposes for instance).

Good point, and this is just a timeout, so roundoff error from doing the
division first is not a problem.  This should be good as it is, thank you!

I will pull in your v3 for testing and further review, and if it passes
testing, send it along to -next.

							Thanx, Paul

