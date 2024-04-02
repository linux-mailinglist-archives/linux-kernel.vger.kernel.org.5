Return-Path: <linux-kernel+bounces-128603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B688895CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4B11C22E75
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D2715CD62;
	Tue,  2 Apr 2024 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pq+Sa8v/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC69815B96D;
	Tue,  2 Apr 2024 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087112; cv=none; b=n2adZTUyBOAQlRF0051efpj9KPj19ngk+QoGK5IYQM/Z+X+ppv1IF2QMSTH/T4ul2mXL2HlXFwz/hNKx9xbVZ/U3GlVaS1RO5LNVt/VUJtIYNcOhTAGIOQ3gDtX4/hE7Iv1lSbtPr9GXvsF+5B44xd/W+WeE5+LIe6MbWumgnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087112; c=relaxed/simple;
	bh=OCkiz1fFVyxFYnxJmcfbd3VtR/LccfvnaYWq2AE25E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUuiEAVDGNOytrbFBA50Ss4LqNb/E3dhpeaR8xJez0tF0+QAGXkdaOJ7XXdU5+ElI7nPstqH/ElC6+tEo4yIbG76qB56RuyIdIaTS3mPFamlrdxgvx/J9H1vCQcHPUE+5ibUojpOV8XSlNRxzwnCSBgXUbwFIzexkTswwWSYYqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pq+Sa8v/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8386C433C7;
	Tue,  2 Apr 2024 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712087112;
	bh=OCkiz1fFVyxFYnxJmcfbd3VtR/LccfvnaYWq2AE25E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pq+Sa8v/DZFRLpo5wOB3lzgRngffOG2bIbOh96A2ODu1+da25MmvhPBO34uhfsVsM
	 yJYT2wB3bq4zAFqeC26/SdFNxlsH3wnJ8FoPydgNKfxWzlXXgJenzC0ZexzbT6uydI
	 FKHfBZl2I6dqtw8+H3CetnSSgYIq2FcvwLmxw/eLuGBagSIEZwUoL4alZILofWacta
	 8zIuY9GYp+C9VdfSEFSkoe+vTcZoiVD14HHSU/H5iZcGD8iVeuEQGDUxmHLYg/6cJZ
	 MapXSCNQqzPtI9iFd63z3oDcz+caakNpuFSFrcx4lAaB7URl8tH86P52mQX7pZYjhA
	 s2N6k8upcAA5w==
Date: Tue, 2 Apr 2024 16:45:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH] perf lock contention: Add a missing NULL check
Message-ID: <ZgxgRJdFlwfESwKF@x1>
References: <20240402184543.898923-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402184543.898923-1-namhyung@kernel.org>

On Tue, Apr 02, 2024 at 11:45:43AM -0700, Namhyung Kim wrote:
> I got a report for a failure in BPF verifier on a recent kernel with
> perf lock contention command.  It checks task->sighand->siglock without
> checking if sighand is NULL or not.  Let's add one.
> 
>   ; if (&curr->sighand->siglock == (void *)lock)
>   265: (79) r1 = *(u64 *)(r0 +2624)     ; frame1: R0_w=trusted_ptr_task_struct(off=0,imm=0) R1_w=rcu_ptr_or_null_sighand_struct(off=0,imm=0)
>   266: (b7) r2 = 0                      ; frame1: R2_w=0
>   267: (0f) r1 += r2
>   R1 pointer arithmetic on rcu_ptr_or_null_ prohibited, null-check it first
>   processed 164 insns (limit 1000000) max_states_per_insn 1 total_states 15 peak_states 15 mark_read 5
>   -- END PROG LOAD LOG --
>   libbpf: prog 'contention_end': failed to load: -13
>   libbpf: failed to load object 'lock_contention_bpf'
>   libbpf: failed to load BPF skeleton 'lock_contention_bpf': -13
>   Failed to load lock-contention BPF skeleton
>   lock contention BPF setup failed
>   lock contention did not detect any lock contention
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Are you going to have this merged into perf-tools?

A Fixes: tag isn't perhaps needed as it worked in the past?

- Arnaldo

> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index fb54bd38e7d0..4e5914d7eeaa 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -305,7 +305,7 @@ static inline __u32 check_lock_type(__u64 lock, __u32 flags)
>  		break;
>  	case LCB_F_SPIN:  /* spinlock */
>  		curr = bpf_get_current_task_btf();
> -		if (&curr->sighand->siglock == (void *)lock)
> +		if (curr->sighand && &curr->sighand->siglock == (void *)lock)
>  			return LCD_F_SIGHAND_LOCK;
>  		break;
>  	default:
> -- 
> 2.44.0.478.gd926399ef9-goog

