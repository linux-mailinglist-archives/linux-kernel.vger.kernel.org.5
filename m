Return-Path: <linux-kernel+bounces-37284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A865883ADB8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5302B28AAC9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842767C0B2;
	Wed, 24 Jan 2024 15:48:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFD777F3E;
	Wed, 24 Jan 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111331; cv=none; b=bQpds1k8Izu7V21CJlRCedpH0O53hf5vVkZ16W/M7LdnvqxLEKEU7qENn6Yhk+mEVb1cdTjJlCMc8mKDQ68Q1KvrKSBOUAyrkfCAKWNFrYoIzpbzVX6vdBbY2ZYmaeZ/dCpI6isPTgKLkRP/Lo894ce7bM7nxJkJiqWw294HZ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111331; c=relaxed/simple;
	bh=aUNqEoEAYqI/8Lxk5111nq5eRH+q4dBA7OcQnIDAc7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMyaq/dvPcYTrKSIRz8k7dpLWpaizWCvOlalBq5cHj/oOAbyQwLjti5QBHpcYqOQAfEFOCkvdxHah6kW9KBZRI2OFnZpdMA1aLEqMUOfxL/FLGebssXXkFVIHPqAfBIdGMHLzymVklkTMXcEFJRHk96CoWSSu1uOk3/qicIAc/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 842341FB;
	Wed, 24 Jan 2024 07:49:33 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51303F762;
	Wed, 24 Jan 2024 07:48:46 -0800 (PST)
Date: Wed, 24 Jan 2024 15:48:38 +0000
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
Message-ID: <ZbExVmM5902LuTnL@FVFF77S0Q05N.cambridge.arm.com>
References: <20240116170348.463479-1-mark.rutland@arm.com>
 <CAP-5=fVABSBZnsmtRn1uF-k-G1GWM-L5SgiinhPTfHbQsKXb_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVABSBZnsmtRn1uF-k-G1GWM-L5SgiinhPTfHbQsKXb_g@mail.gmail.com>

On Sat, Jan 20, 2024 at 10:27:33AM -0800, Ian Rogers wrote:
> On Tue, Jan 16, 2024 at 9:04 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Currently the perf tool doesn't deteect support for extneded event types
> 
> nit: s/deteect/detect/
> nit: s/extneded/extended/

> > Thus is_event_supported() will fail to detect support for any events
> > targetting an Apple M1/M2 PMU, even where events would be supported with
> 
> nit: s/targetting/targeting/

> > This patch updates is_event_supported() to additionally try opening
> > events with perf_event_attr::exclude_guest set, allowing support for
> > events to be detected on Apple M1/M2 systems. I beleive that this is
> 
> nit: s/beleive/believe/

Whoops; I've fixed those in my local tree now.

[...]

> > Hector, Marc, I'd appreciate if either of you could give this a spin on
> > your M1/M2 machines. I've given it local testing with the arm_pmuv3
> > driver modified to behave the same as the apple_m1_pmu driver (requiring
> > exclude_guest, having a 'cycles' event in sysfs), but that might not
> > perfectly replicate your setup.
> >
> > The patch is based on the 'perf-tools-for-v6.8-1-2024-01-09' tag in the
> > perf-tools tree:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/
> >
> > ... and I've pushed it out to the 'perf-tools/event-supported-filters'
> > branch in my tree:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/
> >
> > This patch *should* make it possible to do:
> >
> >         perf stat -e cycles ./workload
> >         perf stat -e instructions ./workload
> >
> > ... with those 'cycles' and 'instructions' events being automatically
> > expanded and reported as separate events per-PMU, which is a nice
> > quality-of-life improvement.
> >
> > Comparing before and after this patch:
> >
> > | # ./perf-before stat -e cycles true
> > |
> > |  Performance counter stats for 'true':
> > |
> > |      <not counted>      cycles                                                                  (0.00%)
> > |
> > |        0.000990250 seconds time elapsed
> > |
> > |        0.000934000 seconds user
> > |        0.000000000 seconds sys
> > |
> > | # ./perf-after stat -e cycles true
> > |
> > |  Performance counter stats for 'true':
> > |
> > |             965175      armv8_pmuv3_0/cycles/
> > |      <not counted>      armv8_pmuv3_1/cycles/                                                   (0.00%)
> > |      <not counted>      armv8_pmuv3_2/cycles/                                                   (0.00%)
> > |      <not counted>      armv8_pmuv3_3/cycles/                                                   (0.00%)
> > |
> > |        0.000836555 seconds time elapsed
> > |
> > |        0.000884000 seconds user
> > |        0.000000000 seconds sys
> 
> Just to check, this is the expected expansion of cycles? I'm unclear
> why 4 core PMUs.

Yep; I had a fake big.LITTLE setup with four distinct microarchitectures (one
per CPU), so the expansion above is expected. I had meant to explain that in
the notes along with the other driver modifications, but I forgot, sorry!

> > This *shouldn't* change the interpetation of named-pmu events, e.g.
> >
> >         perf stat -e apple_whichever_pmu/cycles/ ./workload
> >
> > ... should behave the same as without this patch
> >
> > Comparing before and after this patch:
> >
> > | # ./perf-before stat -e armv8_pmuv3_0/cycles/ -e armv8_pmuv3_1/cycles/ -e armv8_pmuv3_2/cycles/ -e armv8_pmuv3_3/cycles/ true
> > |
> > |  Performance counter stats for 'true':
> > |
> > |      <not counted>      armv8_pmuv3_0/cycles/                                                   (0.00%)
> > |      <not counted>      armv8_pmuv3_1/cycles/                                                   (0.00%)
> > |      <not counted>      armv8_pmuv3_2/cycles/                                                   (0.00%)
> > |             901415      armv8_pmuv3_3/cycles/
> > |
> > |        0.000756590 seconds time elapsed
> > |
> > |        0.000811000 seconds user
> > |        0.000000000 seconds sys
> > |
> > | # ./perf-after stat -e armv8_pmuv3_0/cycles/ -e armv8_pmuv3_1/cycles/ -e armv8_pmuv3_2/cycles/ -e armv8_pmuv3_3/cycles/ true
> > |
> > |  Performance counter stats for 'true':
> > |
> > |             923314      armv8_pmuv3_0/cycles/
> > |      <not counted>      armv8_pmuv3_1/cycles/                                                   (0.00%)
> > |      <not counted>      armv8_pmuv3_2/cycles/                                                   (0.00%)
> > |      <not counted>      armv8_pmuv3_3/cycles/                                                   (0.00%)
> > |
> > |        0.000782420 seconds time elapsed
> > |
> > |        0.000836000 seconds user
> > |        0.000000000 seconds sys
> >
> > One thing I'm still looing into is that this doesn't seem to do anything
> > for a default perf stat session, e.g.
> >
> >         perf stat ./workload
> >
> > ... doesn't automatically expand the implicitly-created events into per-pmu
> > events.
> 
> Ugh, weak symbols. x86 has overridden the default adding of attributes
> to do it for hybrid:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/util/evlist.c?h=perf-tools-next#n36
> I think we should lose the adding events via attributes and just go to
> using parse events for everything. I'll see if I can do some cleanup
> and that should resolve this - I also want to cleanup the default
> events/metrics and the detailed ones as we can drop the unsupported
> events, etc.

Ok; so IIUC we can treat that as a separate problem? I'm happy to test/review
patches there.

> > Comparing before and after this patch:
> >
> > | # ./perf-before stat true
> > |
> > |  Performance counter stats for 'true':
> > |
> > |               0.42 msec task-clock                       #    0.569 CPUs utilized
> > |                  0      context-switches                 #    0.000 /sec
> > |                  0      cpu-migrations                   #    0.000 /sec
> > |                 38      page-faults                      #   89.796 K/sec
> > |      <not counted>      cycles                                                                  (0.00%)
> > |      <not counted>      instructions                                                            (0.00%)
> > |      <not counted>      branches                                                                (0.00%)
> > |      <not counted>      branch-misses                                                           (0.00%)
> > |
> > |        0.000744185 seconds time elapsed
> > |
> > |        0.000795000 seconds user
> > |        0.000000000 seconds sys
> > |
> > | # ./perf-after stat true
> > |
> > |  Performance counter stats for 'true':
> > |
> > |               0.43 msec task-clock                       #    0.582 CPUs utilized
> > |                  0      context-switches                 #    0.000 /sec
> > |                  0      cpu-migrations                   #    0.000 /sec
> > |                 38      page-faults                      #   88.960 K/sec
> > |      <not counted>      cycles                                                                  (0.00%)
> > |      <not counted>      instructions                                                            (0.00%)
> > |      <not counted>      branches                                                                (0.00%)
> > |      <not counted>      branch-misses                                                           (0.00%)
> > |
> > |        0.000734120 seconds time elapsed
> > |
> > |        0.000786000 seconds user
> > |        0.000000000 seconds sys
> >
> > Ian, how does that behave on x86? Is that the same, or do the default
> > events get expanded?
> 
> The default events are expanded, the not counted is a feature of a
> fast binary (true here). I'm trying to remove custom code paths so
> that things like this don't happen, sorry that you've come across
> another instance but at least I can fix it.

Huh; I'm surprised that works with the named-pmu events, since that's the same
'true' binary.

Is there anything I should go look at for that?

Mark.

