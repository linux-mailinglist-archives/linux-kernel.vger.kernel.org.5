Return-Path: <linux-kernel+bounces-159031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65508B2870
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72101C212AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3597614E2CC;
	Thu, 25 Apr 2024 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPL6F28K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0912C559;
	Thu, 25 Apr 2024 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070856; cv=none; b=cOv3mz0uBiguF7BMdDLgr/fux3GlwW1vbY3uxaXOOV5GY+N1H+fKxOFc4Oh7zG11Pp2e4NqTsNJfPcdcW200SiBSHx1580juHOVCk0aLIy/fMK7VejQSMNf9XrwOg2PK0kJeM7sc61WJyIf5Bb2n05QP1/6l/gOpAqjqNOyOcKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070856; c=relaxed/simple;
	bh=9RQpj8HeT4x95CTnJF7C+mOAuNgta4jz9NDCabC2ZQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+e/nsZ3J7y2xNhlZ2oqEzqE7ZeJqYy+NeNIx1fkHtAZ2G9E+qD97i1W45kUSyhfbaPRw/lL7dAQyceKkwoGL4fJ3lG44WJNhjYY3TD2uQD2Yx9cW9lTffhlw77LrAxEj5rg2RuLS8mAmpmO+McBJMDsPZGYZJ37/OCANkZOca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPL6F28K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372E6C113CE;
	Thu, 25 Apr 2024 18:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714070856;
	bh=9RQpj8HeT4x95CTnJF7C+mOAuNgta4jz9NDCabC2ZQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPL6F28KPCdhnmMh7lLejgetWyzuBnBOh4tuEc4AsT3h1DPMcDIMU18cvUWazsv3j
	 Ze5RGZdgBlZv1MB0ko/WSjEiVyOOIvIS5PBShxjGg6rKwiCn1yjdwky4H/kpccmJxw
	 dMrZu1dcST2q2VGAyJczFgdRw4WXy89YyVZRXoNpFW5qmwI4wcaNSg8FPWVgmw6Odn
	 SyccbHx0F7xbthkth2Uv9YdhcqPaSsCcFjAtxikM/QNrp6FOo48+rqmIhMcFU5+s5w
	 Zdfzd5j8xwh1GIfOFtz6Fq2JwKUO5zmVnwwlwlq0kF+dcq9kliq8IVpUSAUdX26901
	 9UosIGoTwo4vQ==
Date: Thu, 25 Apr 2024 15:47:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf build: Pretend scandirat is missing with msan
Message-ID: <ZiqlRO9FvCwBaw9j@x1>
References: <20240320163244.1287780-1-irogers@google.com>
 <CAP-5=fUVtGgaLgVhoSa3SZdSceifFWs_v1rMnEANj3N=VdpC_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUVtGgaLgVhoSa3SZdSceifFWs_v1rMnEANj3N=VdpC_A@mail.gmail.com>

On Wed, Mar 20, 2024 at 09:36:19AM -0700, Ian Rogers wrote:
> On Wed, Mar 20, 2024 at 9:32 AM Ian Rogers <irogers@google.com> wrote:
> >
> > Memory sanitizer lacks an interceptor for scandirat, reporting all
> > memory it allocates as uninitialized. Memory sanitizer has a scandir
> > interceptor so use the fallback function in this case. This allows
> > perf test to run under memory sanitizer.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Note, as msan needs to instrument memory allocations libraries need to
> be compiled with it. I lacked the msan built libraries and so built
> with:
> ```
> $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g
> -fno-omit-frame-pointer -fsanitize=memory
> -fsanitize-memory-track-origins" CC=clang CXX=clang++ HOSTCC=clang
> NO_LIBTRACEEVENT=1 NO_LIBELF=1 BUILD_BPF_SKEL=0 NO_LIBPFM=1
> ```
> oh, I disabled libbpf here as the bpf system call also lacks msan interceptors.

I added the above notes to the cset message.

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/Makefile.config | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 1fe8df97fe88..74e0b17050b5 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -486,7 +486,10 @@ ifdef NO_DWARF
> >  endif
> >
> >  ifeq ($(feature-scandirat), 1)
> > -  CFLAGS += -DHAVE_SCANDIRAT_SUPPORT
> > +  # Ignore having scandirat with memory sanitizer that lacks an interceptor.
> > +  ifeq ($(filter s% -fsanitize=memory%,$(EXTRA_CFLAGS),),)
> > +    CFLAGS += -DHAVE_SCANDIRAT_SUPPORT
> > +  endif
> >  endif
> >
> >  ifeq ($(feature-sched_getcpu), 1)
> > --
> > 2.44.0.291.gc1ea87d7ee-goog
> >

