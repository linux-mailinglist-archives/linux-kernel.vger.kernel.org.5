Return-Path: <linux-kernel+bounces-28945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D81830501
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78182864C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238E21DFE4;
	Wed, 17 Jan 2024 12:12:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879AE1DFC7;
	Wed, 17 Jan 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493532; cv=none; b=Bl21fF2189kTKR0FseF7aRmCjBtDQhHJyKS0/4Vk9uipW2b2t+2+zHqio8Wfb9r6orOc+L0h5LhXTg21bLycksBOJWFxnLopHx1cBZ55Vg9UfZZlCmElVIOftMP1EH9Hx7yDkAtvD6XXheBrFaDisW2ArqZjoq20OZlcUkB8lTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493532; c=relaxed/simple;
	bh=+zNMd3dUbHss2EQOXbNle6Cu4g0DF1zxGNSVl8H+bjo=;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=MRjeZbnwkbEW1O1w5/oikGacWRXdqRt1OPmRaCEKUVBVyJPMXWkv8zQ3LKpX3Iwexu+CzXBzFDo7qYSvv/CwWBV2cExIVJBcjhENnGAk9UsuuEbbAPcHhRmhZ8ibcfpt3l3AYi2s8AHzncIHlMzj7WTK6tpwl0bm37ZThAjJUio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB1E611FB;
	Wed, 17 Jan 2024 04:12:55 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.37.172])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC5503F766;
	Wed, 17 Jan 2024 04:12:07 -0800 (PST)
Date: Wed, 17 Jan 2024 12:12:05 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
	Ian Rogers <irogers@google.com>, acme@redhat.com,
	james.clark@arm.com, john.g.garry@oracle.com, leo.yan@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, mike.leach@linaro.org,
	namhyung@kernel.org, suzuki.poulose@arm.com, tmricht@linux.ibm.com,
	will@kernel.org
Subject: Re: [PATCH] perf print-events: make is_event_supported() more robust
Message-ID: <ZafEFU7kwf6W0_Qx@FVFF77S0Q05N.cambridge.arm.com>
References: <20240116170348.463479-1-mark.rutland@arm.com>
 <8734uwxrca.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734uwxrca.wl-maz@kernel.org>

On Wed, Jan 17, 2024 at 09:05:25AM +0000, Marc Zyngier wrote:
> Hi Mark,
> 
> On Tue, 16 Jan 2024 17:03:48 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > Currently the perf tool doesn't deteect support for extneded event types
> > on Apple M1/M2 systems, and will not auto-expand plain PERF_EVENT_TYPE
> > hardware events into per-PMU events. This is due to the detection of
> > extended event types not handling mandatory filters required by the
> > M1/M2 PMU driver.
> 
> Thanks for looking into this.
> 
> I've given your patch a go on my M1 box, and it indeed makes things
> substantially better:
> 
> $ sudo ./perf stat -e cycles ~/hackbench 100 process 1000
> Running with 100*40 (== 4000) tasks.
> Time: 3.419
> 
>  Performance counter stats for '/home/maz/hackbench 100 process 1000':
> 
>    174,783,472,090      apple_firestorm_pmu/cycles/                                             (93.10%)
>     39,134,744,813      apple_icestorm_pmu/cycles/                                              (71.86%)
> 
>        3.568145595 seconds time elapsed
> 
>       12.203084000 seconds user
>       55.135271000 seconds sys

Thanks for giving that a spin!

> However, I'm seeing some slightly odd behaviours:
> 
> $ sudo ./perf stat -e cycles:k ~/hackbench 100 process 1000
> Running with 100*40 (== 4000) tasks.
> Time: 3.313
> 
>  Performance counter stats for '/home/maz/hackbench 100 process 1000':
> 
>    <not supported>      apple_firestorm_pmu/cycles:k/                                         
>    <not supported>      apple_icestorm_pmu/cycles:k/                                          
> 
>        3.467568841 seconds time elapsed
> 
>       13.080111000 seconds user
>       53.162099000 seconds sys
> 
> I would have expected it to count, but it didn't. For that to work, I
> have to add the 'H' modifier:

Ok, so that'll have something to do with the way the tool chooses which
perf_evant_attr::exclude_* bits to set. I thought that was the same for plain
events and pmu_name/event/ events, but I could be mistaken.

Is that something you had tried prior to this patch, and did that "just work"
with the explicit pmu_name/event/ syntax prior to this patch?

e.g. did something like:

	perf stat -e apple_firestorm_pmu/cycles/k -e apple_icestorm_pmu/cycles/k ./workload

.. happen to work withiout requiring the addition of 'H'?

If so, does that behave the same before/after this patch?

.. and could you run that with '-vvv' and dump the output for comparison?

Thanks,
Mark.

