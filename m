Return-Path: <linux-kernel+bounces-102482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3A787B2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CC528E5C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ED34D9ED;
	Wed, 13 Mar 2024 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obGjoR6B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E920DDB;
	Wed, 13 Mar 2024 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360868; cv=none; b=QdxsyLoh55idINbHZBIz32RgYkIbQkvvOweRXXu0swlgymigysefpsCwQieJgof3/URZON7+18wM+N4QuxxwPWafgkm4exPnYHv7AX/OCx5wiixNg8mBfRQmseT9WId6fHq4A/RQIX1LZTaGXsumS+8WvTEaixbVo9LdolwjLek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360868; c=relaxed/simple;
	bh=oXOjkxjCY1EERAdvIUEGSViGaQO6PEQsL/XDFPsslKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rp0ybqj7IbxOobFhVrj6LyOAIxwJ3arI5OizeE2u7LB3AhF6a/jzeB4oZ3APM/vAYZCOv+ph0L2RJdtSLQ1G6mVbVN1rbDZZSsUajmB7aCzAtev8TNGYh14jl6rAhnsZ4/PXTbg55iqYpVG4IYZqEF2IFtwDXscetTP+xuBwHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obGjoR6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ABEC433C7;
	Wed, 13 Mar 2024 20:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710360868;
	bh=oXOjkxjCY1EERAdvIUEGSViGaQO6PEQsL/XDFPsslKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=obGjoR6BxJZzkcBNmz80kedIvmY/VgxroDPPwvwz23s96S3zXAS9NYxfqPmFVpv7i
	 qlDiRBSEnT+G2ia5i8ApD29HYoI0xZQNkHKGqEIr+Wrhh7Rmeaves5JfU42kyxfXf2
	 wpnacT/EHzZsINrZvsGk3OLNV1teeC6e21fc+bqia7nM+G985prgKXRmEF4U8mmbk0
	 NKmTG2SNoM4pZRTTcpg7INB2TmkK6+pedDjXI+5dk0WToNjKn7+2f910vSeDQtxkFv
	 m7wrQovvNHygIN8S0+cptJmAnVgMUselDCs4o1uarJ2i0ob5uzFE5MA63Jt5+MngGY
	 N9yl8QXgfDyxw==
Date: Wed, 13 Mar 2024 17:14:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marco Elver <elver@google.com>, Vince Weaver <vincent.weaver@maine.edu>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <ZfIJIfqeI9tWnnS5@x1>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
 <CANpmjNMYGa46pRQUOfzTa_FRvftOGqg+UDeD_B-tbZgYw-MWww@mail.gmail.com>
 <ZfHE9Ev5T3Lq7o34@x1>
 <ZfHtBB5_-3RByE8p@x1>
 <ZfHw3J5PY6qy4mXn@x1>
 <ZfIIqcmRlrxwUFTn@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfIIqcmRlrxwUFTn@x1>

On Wed, Mar 13, 2024 at 05:12:25PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Mar 13, 2024 at 03:30:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Mar 13, 2024 at 03:14:28PM -0300, Arnaldo Carvalho de Melo wrote:
> > > 'perf test' doesn't show any regression, now I'm running Vince Weaver's
> > > https://github.com/deater/perf_event_tests, storing the results with
> > > this patchset and then without, to do a diff, lets see...

> > So things improved! I'll re-run to see if these results are stable...
 
> tldr; No dmesg activity, no kernel splats, most tests passed, nothing
> noticeable when running with/without the patch with Vince's regression
> tests. So:
 
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Too quick, now I'm testing it on top of torvalds/master, no PREEMPT_RT.

- Arnaldo
 
> - Arnaldo
> 
> Further details:
> 
> Without the patch:
> 
> [root@nine perf_event_tests]# ./run_tests.sh | tee results.$(uname -r).new ; diff -u results.$(uname -r) results.$(uname -r).new
> --- results.6.8.0-rc7-rt6	2024-03-13 15:26:37.923323518 -0300
> +++ results.6.8.0-rc7-rt6.new	2024-03-13 15:32:43.983245095 -0300
> @@ -296,7 +296,7 @@
>    + tests/rdpmc/rdpmc_validation
>      Testing if userspace rdpmc reads give expected results...  PASSED
>    + tests/rdpmc/rdpmc_multiplexing
> -    Testing if userspace rdpmc multiplexing works...           PASSED
> +    Testing if userspace rdpmc multiplexing works...           FAILED
>    + tests/rdpmc/rdpmc_reset
>      Testing if resetting while using rdpmc works...            PASSED
>    + tests/rdpmc/rdpmc_group
> @@ -304,15 +304,15 @@
>    + tests/rdpmc/rdpmc_attach
>      Testing if rdpmc attach works...                           PASSED
>    + tests/rdpmc/rdpmc_attach_cpu
> -    Running on CPU 4
> +    Running on CPU 0
>  Testing if rdpmc behavior on attach CPU...                 PASSED
>    + tests/rdpmc/rdpmc_attach_global_cpu
> -    Running on CPU 6
> +    Running on CPU 3
>  Testing if rdpmc behavior on attach all procs on other CPU... FAILED
>    + tests/rdpmc/rdpmc_attach_other_cpu
> -    Measuring on CPU 5
> -Running on CPU 6
> -Measuring on CPU 5
> +    Measuring on CPU 0
> +Running on CPU 3
> +Measuring on CPU 0
>  Testing if rdpmc behavior on attach other CPU...           FAILED
>    + tests/rdpmc/rdpmc_multiattach
>      Testing if rdpmc multi-attach works...                     PASSED
> 
> A test flipped results.
> 
> Trying again with a more compact output:
> 
> [root@nine perf_event_tests]# ./run_tests.sh | tee results.$(uname -r).new ; diff -u results.$(uname -r) results.$(uname -r).new | grep ^[+-]
> --- results.6.8.0-rc7-rt6	2024-03-13 15:26:37.923323518 -0300
> +++ results.6.8.0-rc7-rt6.new	2024-03-13 17:06:34.944149451 -0300
> -    Running on CPU 4
> -Testing if rdpmc behavior on attach CPU...                 PASSED
> -  + tests/rdpmc/rdpmc_attach_global_cpu
> +Testing if rdpmc behavior on attach CPU...                 FAILED
> +  + tests/rdpmc/rdpmc_attach_global_cpu
> +    Running on CPU 0
> -    Measuring on CPU 5
> -Running on CPU 6
> -Measuring on CPU 5
> +    Measuring on CPU 7
> +Running on CPU 1
> +Measuring on CPU 7
> [root@nine perf_event_tests]#
> 
> Since its that rdpmc that is now always failing without this patch
> series, lets try using that .new as the new baseline:
> 
> [root@nine perf_event_tests]# ./run_tests.sh | tee results.$(uname -r).new2 ; diff -u results.$(uname -r).new results.$(uname -r).new2 | grep ^[+-]
> --- results.6.8.0-rc7-rt6.new	2024-03-13 17:06:34.944149451 -0300
> +++ results.6.8.0-rc7-rt6.new2	2024-03-13 17:08:41.438282558 -0300
> -    Testing "branch-misses" generalized event...               FAILED
> +    Testing "branch-misses" generalized event...               PASSED
> -    Testing if userspace rdpmc multiplexing works...           PASSED
> +    Testing if userspace rdpmc multiplexing works...           FAILED
> -    Running on CPU 6
> -Testing if rdpmc behavior on attach CPU...                 FAILED
> +    Running on CPU 2
> +Testing if rdpmc behavior on attach CPU...                 PASSED
> -    Running on CPU 0
> +    Running on CPU 2
> -    Measuring on CPU 7
> -Running on CPU 1
> -Measuring on CPU 7
> +    Measuring on CPU 2
> +Running on CPU 0
> +Measuring on CPU 2
> [root@nine perf_event_tests]#

