Return-Path: <linux-kernel+bounces-37298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFE283ADF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC773B27E51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCEE7CF34;
	Wed, 24 Jan 2024 16:05:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279D67C0B5;
	Wed, 24 Jan 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112321; cv=none; b=E00/0VIrWvdKApo0WAmb/9nmBqYpIIy43encKnAkP9iNSlFx864CKidu3lQb1Bz/xIVrJ8f5UJJArxJWand33YccQ/PFwDJ8xu0sYOGrKnvafhsxPFsLNq1Efsdff+val8R+C3d44mq0TDESCcc+GC2KNSoOAok3izqyORj+T8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112321; c=relaxed/simple;
	bh=xR+eAowDFzR1npV7eV+Jm86dpVDcurED+9TbIgQEPvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joyc6FvkBdjPylgCqwZaNIqp6G+B3d1g0tuONkqDfE5ZkjL6zMGJ93p+RFN4q04UB/rjW2p0b1/ljmAl65eDLtjB3nt6kHNQHwLUwl/jBf7qGDeJYmXUJKqW+wwco8ni69AtD38CbJWM3YZCjBGXnYNssbbrXGrQeTiPM+flJb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D2DD1FB;
	Wed, 24 Jan 2024 08:06:03 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63B9C3F762;
	Wed, 24 Jan 2024 08:05:16 -0800 (PST)
Date: Wed, 24 Jan 2024 16:05:13 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>, Ian Rogers <irogers@google.com>,
	acme@redhat.com, james.clark@arm.com, john.g.garry@oracle.com,
	leo.yan@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, mike.leach@linaro.org,
	suzuki.poulose@arm.com, tmricht@linux.ibm.com, will@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH] perf print-events: make is_event_supported() more robust
Message-ID: <ZbE1OawXbQbqcdaV@FVFF77S0Q05N.cambridge.arm.com>
References: <20240116170348.463479-1-mark.rutland@arm.com>
 <8734uwxrca.wl-maz@kernel.org>
 <ZafEFU7kwf6W0_Qx@FVFF77S0Q05N.cambridge.arm.com>
 <CAM9d7ciYEzX1EQ2tXT-FFK2z6Nid9vM6WgSYDFm-rzx=AWsxOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciYEzX1EQ2tXT-FFK2z6Nid9vM6WgSYDFm-rzx=AWsxOA@mail.gmail.com>

On Thu, Jan 18, 2024 at 09:57:32PM -0800, Namhyung Kim wrote:
> Hello,
> 
> Adding Ravi to CC.
> 
> On Wed, Jan 17, 2024 at 4:12 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Wed, Jan 17, 2024 at 09:05:25AM +0000, Marc Zyngier wrote:
> > > Hi Mark,
> > >
> > > On Tue, 16 Jan 2024 17:03:48 +0000,
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > Currently the perf tool doesn't deteect support for extneded event types
> > > > on Apple M1/M2 systems, and will not auto-expand plain PERF_EVENT_TYPE
> > > > hardware events into per-PMU events. This is due to the detection of
> > > > extended event types not handling mandatory filters required by the
> > > > M1/M2 PMU driver.
> > >
> > > Thanks for looking into this.
> > >
> > > I've given your patch a go on my M1 box, and it indeed makes things
> > > substantially better:
> > >
> > > $ sudo ./perf stat -e cycles ~/hackbench 100 process 1000
> > > Running with 100*40 (== 4000) tasks.
> > > Time: 3.419
> > >
> > >  Performance counter stats for '/home/maz/hackbench 100 process 1000':
> > >
> > >    174,783,472,090      apple_firestorm_pmu/cycles/                                             (93.10%)
> > >     39,134,744,813      apple_icestorm_pmu/cycles/                                              (71.86%)
> > >
> > >        3.568145595 seconds time elapsed
> > >
> > >       12.203084000 seconds user
> > >       55.135271000 seconds sys
> >
> > Thanks for giving that a spin!
> >
> > > However, I'm seeing some slightly odd behaviours:
> > >
> > > $ sudo ./perf stat -e cycles:k ~/hackbench 100 process 1000
> > > Running with 100*40 (== 4000) tasks.
> > > Time: 3.313
> > >
> > >  Performance counter stats for '/home/maz/hackbench 100 process 1000':
> > >
> > >    <not supported>      apple_firestorm_pmu/cycles:k/
> > >    <not supported>      apple_icestorm_pmu/cycles:k/
> 
> Hmm.. I guess this should look like apple_firestorm_pmu/cycles/k.

Yeah, the ":k" within the slashes isn't right, and I suspect that's due to the
way the event gets expanded.

Ian, is that something you're aware of already?

> IIRC there was a thread for this, right?

I'm not aware of a thread for the way filters get applied to expanded events.

> > >
> > >        3.467568841 seconds time elapsed
> > >
> > >       13.080111000 seconds user
> > >       53.162099000 seconds sys
> > >
> > > I would have expected it to count, but it didn't. For that to work, I
> > > have to add the 'H' modifier:
> >
> > Ok, so that'll have something to do with the way the tool chooses which
> > perf_evant_attr::exclude_* bits to set. I thought that was the same for plain
> > events and pmu_name/event/ events, but I could be mistaken.
> 
> I think it sets the attr.exclude_guest by event_attr_init().  Maybe
> it's deleted during the missing feature detection logic.  But IIUC
> it should work on each PMU separately.

I'll try to look into this a bit more.

> By the way, I really hope the kernel exports caps/exclude_bits
> for PMUs so that tools can see which bits are supported.  For
> example AMD IBS has CAP_NO_EXCLUDE so setting exclude_guest
> will fail to open.  Then it disables the new features added after
> that in the missing feature detection logic.

I'm ok in principle with exposing some info on the supported exclude_*
configuration, but it's worth noting that event where a PMU supports specific
filters, it might not support all combinations of filters for all events. For
example, s390 doesn't support exclude_* filters on RAW events, and doesn't
support kernel-only counters. Given that, I'm not sure how we can expose that
in a useful way.

Mark.

> If we know if it doesn't support any exclude bits, then tools can try other
> features after removing the bit first.
> 
> Thanks,
> Namhyung
> 
> >
> > Is that something you had tried prior to this patch, and did that "just work"
> > with the explicit pmu_name/event/ syntax prior to this patch?
> >
> > e.g. did something like:
> >
> >         perf stat -e apple_firestorm_pmu/cycles/k -e apple_icestorm_pmu/cycles/k ./workload
> >
> > ... happen to work withiout requiring the addition of 'H'?
> >
> > If so, does that behave the same before/after this patch?
> >
> > ... and could you run that with '-vvv' and dump the output for comparison?
> >
> > Thanks,
> > Mark.

