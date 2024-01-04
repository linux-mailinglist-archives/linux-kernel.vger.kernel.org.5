Return-Path: <linux-kernel+bounces-17148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D504C8248E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167ADB20D0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5112C694;
	Thu,  4 Jan 2024 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dda83Mqf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1FF2C68C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60E9C433C8;
	Thu,  4 Jan 2024 19:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704395996;
	bh=edaUvHjWU6iYWkUwFTqdLrkW4WvxE2h+anopOjfjoQw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Dda83MqfeoLl8Y8yNGu+H/QOncGyiBIqMrFs2qt1ZZLHaAVkjZjjH5ra8bmwaCNP+
	 dJWFqyT3NC2HBNxXXP4fWGExrOxEGjEC0t4i+/eSgy0TNXKU/vINVFoaMrfW5Gjg46
	 X2FAb1vl6PsDivFonJVsR5cKqE2ItVeQtj7JUifRmdp3mOzgKapoEZpDT6S0VL3hJF
	 gRYJ8N0o6iZAz4rKBCJTBeCD0h6606w2ckf0f8TC1rwVuSqy6dqNQbB8b2siGX58RT
	 +bE0uScI3rZ8Vrpg6u4Jrophx4Y6PwC4CY5ZDg+4SqeVIefVRdUwTtFd4XQbJpz9f0
	 CIICs4rLBOKnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5A3E8CE06FA; Thu,  4 Jan 2024 11:19:56 -0800 (PST)
Date: Thu, 4 Jan 2024 11:19:56 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jiri Wiesner <jwiesner@suse.de>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <dd62437f-b7a2-4844-89f6-94a88a08f227@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240103112113.GA6108@incl>
 <5b8fd9ba-1622-4ec7-b3cc-2db3a78122f1@paulmck-laptop>
 <20240104163050.GC3303@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104163050.GC3303@incl>

On Thu, Jan 04, 2024 at 05:30:50PM +0100, Jiri Wiesner wrote:
> On Wed, Jan 03, 2024 at 02:08:08PM -0800, Paul E. McKenney wrote:
> > I believe that there were concerns about a similar approach in the case
> > where the jiffies counter is the clocksource
> 
> I ran a few simple tests on a 2 NUMA node Intel machine and found nothing 
> so far. I tried booting with clocksource=jiffies and I changed the 
> "nr_online_nodes <= 4" check in tsc_clocksource_as_watchdog() to enable 
> the watchdog on my machine. I have a debugging module that monitors 
> clocksource and watchdog reads in clocksource_watchdog() with kprobes. I 
> see the cs/wd reads executed roughly every 0.5 second, as expected. When 
> the machine is idle the average watchdog interval is 501.61 milliseconds 
> (+-15.57 ms, with a minimum of 477.07 ms and a maximum of 517.93 ms). The 
> result is similar when the CPUs of the machine are fully saturated with 
> netperf processes. I also tried booting with clocksource=jiffies and 
> tsc=watchdog. The watchdog interval was similar to the previous test.
> 
> AFAIK, the jiffies clocksource does get checked by the watchdog itself. 
> And with that, I have run out of ideas.

If I recall correctly (ha!), the concern was that with the jiffies as
clocksource, we would be using jiffies (via timers) to check jiffies
(the clocksource), and that this could cause issues if the jiffies got
behind, then suddenly updated while the clocksource watchdog was running.

Thoughts?

							Thanx, Paul

