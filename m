Return-Path: <linux-kernel+bounces-18561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC50825F63
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 974C0B20C0C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 12:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119816FAE;
	Sat,  6 Jan 2024 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiGhdiYG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C26FA1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 12:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A580EC433C8;
	Sat,  6 Jan 2024 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704542655;
	bh=PZMVTdiXRx8xTYwPS5q4JHkR6cGOewyIuP/6PhphI/M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kiGhdiYGImGuOSP86sFhnuYDqkFOpRUTP1xYzkuxSNYxdeAaqq4sJJYHPTTjFlN/L
	 uMicvscCEDFaT5F+CKB/ScrZuK+/44saiqNYm4+nXXNMjVQuqGcka4uFhel8ejSlmT
	 8gjjJ/1rclhz1mMrjOeFld/7SpZeSjS0njPZRqKnQHHLyxiyvVlmbKYjivIgNECXE0
	 BUPiH2fMZ5ni/JFSOaimhhg75JUSUh6uB3smHGBrREy40dKQT6JxgrrdLtlMd82wuQ
	 7AGk8iEiYQRdPVYn14TiGDrnOj4dQAoAyJ+xOyoZqiZClVGpfiiPwuu5vrzfJ90Uhl
	 mESNnH7RUUvAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 42F04CE0EDC; Sat,  6 Jan 2024 04:04:15 -0800 (PST)
Date: Sat, 6 Jan 2024 04:04:15 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Feng Tang <feng.tang@intel.com>
Cc: Jiri Wiesner <jwiesner@suse.de>, linux-kernel@vger.kernel.org,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, rui.zhang@intel.com
Subject: Re: [PATCH] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <14611f96-af33-456d-9a39-49970fd60ee8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240103112113.GA6108@incl>
 <5b8fd9ba-1622-4ec7-b3cc-2db3a78122f1@paulmck-laptop>
 <20240104163050.GC3303@incl>
 <dd62437f-b7a2-4844-89f6-94a88a08f227@paulmck-laptop>
 <ZZjBDaW9tqSEicNM@feng-clx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZjBDaW9tqSEicNM@feng-clx>

On Sat, Jan 06, 2024 at 10:55:09AM +0800, Feng Tang wrote:
> On Thu, Jan 04, 2024 at 11:19:56AM -0800, Paul E. McKenney wrote:
> > On Thu, Jan 04, 2024 at 05:30:50PM +0100, Jiri Wiesner wrote:
> > > On Wed, Jan 03, 2024 at 02:08:08PM -0800, Paul E. McKenney wrote:
> > > > I believe that there were concerns about a similar approach in the case
> > > > where the jiffies counter is the clocksource
> > > 
> > > I ran a few simple tests on a 2 NUMA node Intel machine and found nothing 
> > > so far. I tried booting with clocksource=jiffies and I changed the 
> > > "nr_online_nodes <= 4" check in tsc_clocksource_as_watchdog() to enable 
> > > the watchdog on my machine. I have a debugging module that monitors 
> > > clocksource and watchdog reads in clocksource_watchdog() with kprobes. I 
> > > see the cs/wd reads executed roughly every 0.5 second, as expected. When 
> > > the machine is idle the average watchdog interval is 501.61 milliseconds 
> > > (+-15.57 ms, with a minimum of 477.07 ms and a maximum of 517.93 ms). The 
> > > result is similar when the CPUs of the machine are fully saturated with 
> > > netperf processes. I also tried booting with clocksource=jiffies and 
> > > tsc=watchdog. The watchdog interval was similar to the previous test.
> > > 
> > > AFAIK, the jiffies clocksource does get checked by the watchdog itself. 
> > > And with that, I have run out of ideas.
> > 
> > If I recall correctly (ha!), the concern was that with the jiffies as
> > clocksource, we would be using jiffies (via timers) to check jiffies
> > (the clocksource), and that this could cause issues if the jiffies got
> > behind, then suddenly updated while the clocksource watchdog was running.
> 
> Yes, we also met problem when 'jiffies' was used as clocksource/watchdog,
> but don't know if it's the same problem you mentioned. Our problem
> ('jiffies' as watchdog marks clocksource TSC as unstable) only happens
> in early boot phase with serial earlyprintk enabled, that the updating
> of 'jiffies' relies on HW timer's periodic interrupt, but early printk
> will disable interrupt during printing and cause some timer interrupts
> lost, and hence big lagging in 'jiffies'. Rui once proposed a patch to
> prevent 'jiffies' from being a watchdog due to it unreliability [1].
> 
> And I think skipping the watchdog check one time when detecting some
> abnormal condition won't hurt the overall check much.

Works for me!

							Thanx, Paul

> [1]. https://lore.kernel.org/lkml/bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com/
> 
> Thanks,
> Feng
> 
> > Thoughts?
> > 
> > 							Thanx, Paul

