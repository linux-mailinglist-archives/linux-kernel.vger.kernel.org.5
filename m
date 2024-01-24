Return-Path: <linux-kernel+bounces-37288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B04283ADC3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDE328563D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61837C0BB;
	Wed, 24 Jan 2024 15:51:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA4640C1B;
	Wed, 24 Jan 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111473; cv=none; b=WnD5oJp8BcGBY38ubjSTLty49EdS10bhcBBcsZy6tU1nUxSKxfb4an29lIE1M1vWHF5yNFia0Q45QfA3PbVCRjfYVs70vP93094izruBCV4eY9Jg2YQNSMvGmLauxi6owaquypRwdpK1SzVpAMYyUbuXYOvKpoFtvLZZ3UrI8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111473; c=relaxed/simple;
	bh=IDco1jSbZDkfu0yOrE7OiSthlGxb7LFfyQTuQ5j9LLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0JY9UddYUOdgKtfytpX42NFTLaWZsRMXKSHdm01hQGzP+Pn916Fw0JWWbLsxOc7ZosRfXM+u+lw+2Dy1mnazvfzvEsSyhLxO8gFScB4JF/8wxmr7KhLAEHsHgvgeC/nQjvLKt4IF+oorYSGyiuNuHsC7o/KlTFLOjstFnR3ev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F6B31FB;
	Wed, 24 Jan 2024 07:51:55 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6547C3F762;
	Wed, 24 Jan 2024 07:51:08 -0800 (PST)
Date: Wed, 24 Jan 2024 15:51:05 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
	Marc Zyngier <maz@kernel.org>, acme@redhat.com, james.clark@arm.com,
	john.g.garry@oracle.com, leo.yan@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, mike.leach@linaro.org,
	namhyung@kernel.org, suzuki.poulose@arm.com, tmricht@linux.ibm.com,
	will@kernel.org
Subject: Re: [PATCH] perf print-events: make is_event_supported() more robust
Message-ID: <ZbEx6f720aZ0XV_Q@FVFF77S0Q05N.cambridge.arm.com>
References: <20240116170348.463479-1-mark.rutland@arm.com>
 <CAP-5=fVABSBZnsmtRn1uF-k-G1GWM-L5SgiinhPTfHbQsKXb_g@mail.gmail.com>
 <CAP-5=fXtbhX8qx=B+8QTm00WhCPAQNxH-=NSrEfOVo8wz8yd6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXtbhX8qx=B+8QTm00WhCPAQNxH-=NSrEfOVo8wz8yd6A@mail.gmail.com>

On Sat, Jan 20, 2024 at 10:29:54AM -0800, Ian Rogers wrote:
> On Sat, Jan 20, 2024 at 10:27 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, Jan 16, 2024 at 9:04 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > Currently the perf tool doesn't deteect support for extneded event types
> >
> > nit: s/deteect/detect/
> > nit: s/extneded/extended/
> >
> > > on Apple M1/M2 systems, and will not auto-expand plain PERF_EVENT_TYPE
> > > hardware events into per-PMU events. This is due to the detection of
> > > extended event types not handling mandatory filters required by the
> > > M1/M2 PMU driver.
> > >
> > > PMU drivers and the core perf_events code can require that
> > > perf_event_attr::exclude_* filters are configured in a specific way and
> > > may reject certain configurations of filters, for example:
> > >
> > > (a) Many PMUs lack support for any event filtering, and require all
> > >     perf_event_attr::exclude_* bits to be clear. This includes Alpha's
> > >     CPU PMU, and ARM CPU PMUs prior to the introduction of PMUv2 in
> > >     ARMv7,
> > >
> > > (b) When /proc/sys/kernel/perf_event_paranoid >= 2, the perf core
> > >     requires that perf_event_attr::exclude_kernel is set.
> > >
> > > (c) The Apple M1/M2 PMU requires that perf_event_attr::exclude_guest is
> > >     set as the hardware PMU does not count while a guest is running (but
> > >     might be extended in future to do so).
> > >
> > > In is_event_supported(), we try to account for cases (a) and (b), first
> > > attempting to open an event without any filters, and if this fails,
> > > retrying with perf_event_attr::exclude_kernel set. We do not account for
> > > case (c), or any other filters that drivers could theoretically require
> > > to be set.
> > >
> > > Thus is_event_supported() will fail to detect support for any events
> > > targetting an Apple M1/M2 PMU, even where events would be supported with
> >
> > nit: s/targetting/targeting/
> >
> > > perf_event_attr:::exclude_guest set.
> > >
> > > Since commit:
> > >
> > >   82fe2e45cdb00de4 ("perf pmus: Check if we can encode the PMU number in perf_event_attr.type")
> > >
> > > ... we use is_event_supported() to detect support for extended types,
> > > with the PMU ID encoded into the perf_event_attr::type. As above, on an
> > > Apple M1/M2 system this will always fail to detect that the event is
> > > supported, and consequently we fail to detect support for extended types
> > > even when these are supported, as they have been since commit:
> > >
> > >   5c816728651ae425 ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability")
> > >
> > > Due to this, the perf tool will not automatically expand plain
> > > PERF_TYPE_HARDWARE events into per-PMU events, even when all the
> > > necessary kernel support is present.
> > >
> > > This patch updates is_event_supported() to additionally try opening
> > > events with perf_event_attr::exclude_guest set, allowing support for
> > > events to be detected on Apple M1/M2 systems. I beleive that this is
> >
> > nit: s/beleive/believe/
> >
> > > sufficient for all contemporary CPU PMU drivers, though in future it may
> > > be necessary to check for other combinations of filter bits.
> > >
> > > I've deliberately changed the check to not expect a specific error code
> > > for missing filters, as today ;the kernel may return a number of
> > > different error codes for missing filters (e.g. -EACCESS, -EINVAL, or
> > > -EOPNOTSUPP) depending on why and where the filter configuration is
> > > rejected, and retrying for any error is more robust.
> > >
> > > Note that this does not remove the need for commit:
> > >
> > >   a24d9d9dc096fc0d ("perf parse-events: Make legacy events lower priority than sysfs/JSON")
> > >
> > > ... which is still necessary so that named-pmu/event/ events work on
> > > kernels without extended type support, even if the event name happens to
> > > be the same as a PERF_EVENT_TYPE_HARDWARE event (e.g. as is the case for
> > > the M1/M2 PMU's 'cycles' and 'instructions' events).
> > >
> > > Fixes: 82fe2e45cdb00de4 ("perf pmus: Check if we can encode the PMU number in perf_event_attr.type")
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Cc: Hector Martin <marcan@marcan.st>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: James Clark <james.clark@arm.com>
> > > Cc: John Garry <john.g.garry@oracle.com>
> > > Cc: Leo Yan <leo.yan@linaro.org>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Mike Leach <mike.leach@linaro.org>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > Cc: Thomas Richter <tmricht@linux.ibm.com>
> > > Cc: Will Deacon <will@kernel.org>
> 
> Also:
> Tested-by: Ian Rogers <irogers@google.com>
> 
> No regressions on Alderlake except a pre-existing problem I noted here:
> https://lore.kernel.org/lkml/CAP-5=fWVQ-7ijjK3-w1q+k2WYVNHbAcejb-xY0ptbjRw476VKA@mail.gmail.com/

Cheers; I've folded that tag in along with the typo fixes.

I'll send a v2 tomorrow assuming there's nothing else that crops up.

Mark.

