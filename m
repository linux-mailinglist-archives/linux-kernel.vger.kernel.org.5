Return-Path: <linux-kernel+bounces-45243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B20842D80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978B71C22257
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E618871B47;
	Tue, 30 Jan 2024 20:07:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B0A71B35;
	Tue, 30 Jan 2024 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645241; cv=none; b=T3htb0XMs2uzYDKOxsDpRyc6/dyCoe4+l499gblkvSz2wyiOpBglN4r0RRYdV6o+x1rIejuPXwX7onSHnwT0KU/4G8ehSB/LzAHkg5wo7PRYpOW03W7javTf8IQ9KIeDFYKirgdrenOZXAconFmBkiC5TLO4F8EoZVQsNW089oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645241; c=relaxed/simple;
	bh=oIduqgREuG9ns22E1DbTWFEB3RjCn8ZZkVF9cCIgxTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/UVmGqASS9J/2Wo+M9jDfKrDxnFF1qOcBwg3lFkHJwqflU3gWC6WxA5so2SGfH/FjR6okCSCvJOFNipi7R4aiHShE+po/mTnJnp+BJIGInh5oDPBI1K9NqJ3pSy3lh6hPWNNmOo4B2SBWbGzT1JCFadKeFgRgsNP5IUqbaYFzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80F2FDA7;
	Tue, 30 Jan 2024 12:07:58 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6770B3F762;
	Tue, 30 Jan 2024 12:07:13 -0800 (PST)
Date: Tue, 30 Jan 2024 20:07:02 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] pmdomain: arm: Fix NULL dereference on scmi_perf_domain
 removal
Message-ID: <ZblW5rt4UtK6KMJD@pluto>
References: <20240125191756.868860-1-cristian.marussi@arm.com>
 <CAPDyKFpqZf15DFWa8K6RRzSTX70chEVTV8zRgnJ3VStSq_d9UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpqZf15DFWa8K6RRzSTX70chEVTV8zRgnJ3VStSq_d9UQ@mail.gmail.com>

On Tue, Jan 30, 2024 at 02:09:20PM +0100, Ulf Hansson wrote:
> On Thu, 25 Jan 2024 at 20:18, Cristian Marussi <cristian.marussi@arm.com> wrote:
> >
> > On unloading of the scmi_perf_domain module got the below splat, when in
> > the DT provided to the system under test the '#power-domain-cells' property
> > was missing.
> > Indeed, this particular setup causes the probe to bail out early without
> > giving any error, so that, then, the removal code is run on unload, but
> > without all the expected initialized structures in place.
> >
> > Add a check and bail out early on remove too.
> 
> Thanks for spotting this!
> 
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> > Mem abort info:
> >    ESR = 0x0000000096000004
> >    EC = 0x25: DABT (current EL), IL = 32 bits
> >    SET = 0, FnV = 0
> >    EA = 0, S1PTW = 0
> >    FSC = 0x04: level 0 translation fault
> >  Data abort info:
> >    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> >    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> >    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> >  user pgtable: 4k pages, 48-bit VAs, pgdp=00000001076e5000
> >  [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
> >  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> >  Modules linked in: scmi_perf_domain(-) scmi_module scmi_core
> >  CPU: 0 PID: 231 Comm: rmmod Not tainted 6.7.0-00084-gb4b1f27d3b83-dirty #15
> >  Hardware name: linux,dummy-virt (DT)
> >  pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> >  pc : scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
> >  lr : scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
> >  sp : ffff80008393bc10
> >  x29: ffff80008393bc10 x28: ffff0000875a8000 x27: 0000000000000000
> >  x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> >  x23: ffff00008030c090 x22: ffff00008032d490 x21: ffff80007b287050
> >  x20: 0000000000000000 x19: ffff00008032d410 x18: 0000000000000000
> >  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> >  x14: 8ba0696d05013a2f x13: 0000000000000000 x12: 0000000000000002
> >  x11: 0101010101010101 x10: ffff00008510cff8 x9 : ffff800080a6797c
> >  x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : fefefeff6364626d
> >  x5 : 8080808000000000 x4 : 0000000000000020 x3 : 00000000553a3dc1
> >  x2 : ffff0000875a8000 x1 : ffff0000875a8000 x0 : ffff800082ffa048
> >  Call trace:
> >   scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
> >   scmi_dev_remove+0x28/0x40 [scmi_core]
> >   device_remove+0x54/0x90
> >   device_release_driver_internal+0x1dc/0x240
> >   driver_detach+0x58/0xa8
> >   bus_remove_driver+0x78/0x108
> >   driver_unregister+0x38/0x70
> >   scmi_driver_unregister+0x28/0x180 [scmi_core]
> >   scmi_perf_domain_driver_exit+0x18/0xb78 [scmi_perf_domain]
> >   __arm64_sys_delete_module+0x1a8/0x2c0
> >   invoke_syscall+0x50/0x128
> >   el0_svc_common.constprop.0+0x48/0xf0
> >   do_el0_svc+0x24/0x38
> >   el0_svc+0x34/0xb8
> >   el0t_64_sync_handler+0x100/0x130
> >   el0t_64_sync+0x190/0x198
> >  Code: a90153f3 f9403c14 f9414800 955f8a05 (b9400a80)
> >  ---[ end trace 0000000000000000 ]---
> >
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Fixes: 2af23ceb8624 ("pmdomain: arm: Add the SCMI performance domain")
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > I suppose the probe does NOT bail out with an error because this DT config has
> > to be supported, right ?
> 
> Actually, no. It's a mistake by me, the probe should bail out with an
> error code.
>

Ok. I suppose any old platform like JUNO that missed this will have to
update their DT to use the new scmi_perf_domain...well it should have
anyway really, it is just that now it is silently failing.

> In fact, there is also one additional similar problem in probe, when
> the number of perf-domains are zero. In that case, we should also
> return an error code, rather than returning 0.
> 
> Would you mind updating the patch to cover both problems - or if you
> are too busy, just let me know and I can help out.

No problem, I can do it next week, but regarding the zero domain case,
I remember I used to do the same on regulator/voltage driver and bail out
when no domains were found, but we were asked by some customer to support
instead the very useless and funny case of zero domains for some of their
testing setup scenarios .. i.e. allowing the driver to load with zero domains
(and do nothing) and then unload cleanly avoiding harms while unloading ...)

Thoughts about this ? Can fix as you prefer .

Thanks,
Cristian


