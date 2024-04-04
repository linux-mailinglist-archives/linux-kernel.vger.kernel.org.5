Return-Path: <linux-kernel+bounces-131897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E41898D61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CFA1C26BD0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D47F12CD9C;
	Thu,  4 Apr 2024 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2YHbv1R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47BE848A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252341; cv=none; b=lZUmSFYoY2KzrYGIYiYX5uFt3nTSput7eVzYuF48FM8NR7bZvRZjTY9iE37oDDXLyxLc+RE4Fz/74M6rURRSqwg7Y6Jc0DbGxjs0Y84u50miu30R4EfpB5tk6qOBP+AOWLdx3apTHTI8qZNzlw1woB63p4V3A/0juRXmAKbO7pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252341; c=relaxed/simple;
	bh=Gwc7Mbp5isXbI0Uoz22ItrePrRCxrLBZd8oPSQyBVUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd7jYpxqPnVNdLYeN4Ov7ASnHbLCL+3xerEOzohgnkkhqhkKFqIFslwU1vhcU7owzrqXIVKWZY7goaulM6LTSaXWntb1ak3kZSPuQONQTkThGTvnnDjxs4HCQlCvxGEhs7WAVJjz1A6UEO3ONJQrrxhXDcd/8kdi7Ih694nt2jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2YHbv1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA41C433C7;
	Thu,  4 Apr 2024 17:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712252341;
	bh=Gwc7Mbp5isXbI0Uoz22ItrePrRCxrLBZd8oPSQyBVUs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=i2YHbv1RudOFgqsTfPM2H/xiYgpmhLNKeOCiYaHUVbS8Thh+oPjPFRclhGhP9dFYR
	 CaKv3+/UhGRnH0EtkJRr1jfEAbyS+L5eCMwzV66O8lKcJUOS2uccQUKmmx0BZ+CaCu
	 v/xhGvT/HVnH11lcEm6nzY37205VS5vuiQ8LzT8Syro3jyZ1CmDtuZrxv0Hf3g5+/z
	 VzO6HZLo+P31NH6PZyAU5Qa3DDR78rOVQlhECw1pvmk1KppseAbGxakOXjX/0ejZ/k
	 xki8JF+RRslLEp7MrgWuxBUjNZvcVcuqteXbchRzurFaVwDtjWTcJFMChmafAYXC+k
	 fLiw1HHye88CA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D6F42CE0D0C; Thu,  4 Apr 2024 10:39:00 -0700 (PDT)
Date: Thu, 4 Apr 2024 10:39:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Feng Tang <feng.tang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Zhengxu Chen <zhxchen17@meta.com>,
	Danielle Costantino <dcostantino@meta.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, John Stultz <jstultz@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH RFC v2 tsc] Check for sockets instead of CPUs to make
 code match comment
Message-ID: <4b6724fb-2fb7-4081-ba1d-0797d746d9b8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <62a0a0cd-3103-4e8f-b4c8-a91f12121e92@paulmck-laptop>
 <Zg416EXHJa9CdI9L@feng-clx.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg416EXHJa9CdI9L@feng-clx.sh.intel.com>

On Thu, Apr 04, 2024 at 01:08:56PM +0800, Feng Tang wrote:
> On Wed, Apr 03, 2024 at 12:10:41PM -0700, Paul E. McKenney wrote:
> > The unsynchronized_tsc() eventually checks num_possible_cpus(), and
> > if the system is non-Intel and the number of possible CPUs is greater
> > than one, assumes that TSCs are unsynchronized.  This despite the
> > comment saying "assume multi socket systems are not synchronized",
> > that is, socket rather than CPU.  This behavior was preserved by
> > commit 8fbbc4b45ce3 ("x86: merge tsc_init and clocksource code") and
> > by the previous relevant commit 7e69f2b1ead2 ("clocksource: Remove the
> > update callback").
> > 
> > The clocksource drivers were added by commit 5d0cf410e94b ("Time: i386
> > Clocksource Drivers") back in 2006, and the comment still said "socket"
> > rather than "CPU".
> > 
> > Therefore, bravely (and perhaps foolishly) make the code match the
> > comment.
> > 
> > Note that it is possible to bypass both code and comment by booting
> > with tsc=reliable, but this also disables the clocksource watchdog,
> > which is undesirable when trust in the TSC is strictly limited.
> > 
> > Changes since v1:
> > 
> > o	Forward-port to v6.9-rc1.
> > 
> > Reported-by: Zhengxu Chen <zhxchen17@meta.com>
> > Reported-by: Danielle Costantino <dcostantino@meta.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Feng Tang <feng.tang@intel.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: John Stultz <jstultz@google.com>
> > Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > Cc: <x86@kernel.org>
> > 
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 5a69a49acc963..e938b990bea19 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1289,7 +1289,7 @@ int unsynchronized_tsc(void)
> >  	 */
> >  	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
> >  		/* assume multi socket systems are not synchronized: */
> > -		if (num_possible_cpus() > 1)
> > +		if (nr_online_nodes > 1)
> 
> Regarding package/socket number, Thomas' topology refactoring patchset
> (merged in 6.9-rc1) makes topology_max_packages() more accurate than
> nr_online_nodes(), more details in https://lore.kernel.org/lkml/20240327025105.2861341-1-feng.tang@intel.com/

Thank you, and updated with attribution.

							Thanx, Paul

