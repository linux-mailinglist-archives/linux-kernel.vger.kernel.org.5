Return-Path: <linux-kernel+bounces-109113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA308814CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B4AB22942
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB0352F7D;
	Wed, 20 Mar 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPerTb4M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0912053E0A;
	Wed, 20 Mar 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949306; cv=none; b=BM/sLxcOoGkBGhPkOFyCyAbda0zniaXcAY1U2O/nxZ0bJ1pfuK7oQgkncK4txBFNPx/iNeX1HcHKQG4aSUQyVt9RQLag7Cbr+Ilw8ozuBhHmteQglyrzGbF0Ru7fHxF+Bv4mVK5AzzFf2RdfBl83uiBZyv3ktifo4aDFoUtUd/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949306; c=relaxed/simple;
	bh=AKA5aivXwC/9oh5dXjuszQ2kQ6AwoUeoUA12p1+5Sqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P63VobXtypvjCYEEd2g6b1/U+D4zlvpye4e2xFb/+VC5dPQaSE31L30lYhGekRGDW6R0HSDI/jnzPHgOlvANw2Xaw0PplQV86qkS26GgVgoEQXPw7ux66kaAnIEdKo1Jii0Y8TucdfGWyZDSviBmjrJROBgsraVDslGTmA7wzZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPerTb4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F772C433C7;
	Wed, 20 Mar 2024 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710949305;
	bh=AKA5aivXwC/9oh5dXjuszQ2kQ6AwoUeoUA12p1+5Sqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jPerTb4MS8ibZqUx3wp26TmdRXgv+gna2YizPUfUYbxWfutR/xajNU9kpkhIGm51p
	 D2wRhIFet6PV0CoiRE3fFMOm/i/ivjwdqC7gqOL3mWO+WpOCHTL8d7VxJ/bpEKnEGM
	 mB0b2O6zDXBaeWemziX8TecGuVmiLlWZlC/6s/TUYTjhn9+c5LcSBpb5iietzlDARD
	 nS0fPcxLndn8z+PTaFpI7xZpbuPS8gfDIS4W2Soj4DFkiR4hQ777eWnvpwGh4DMSzr
	 N/wHC1kPiC7f0t+Z4705kpRGXp15d4bujrVuz/Ju9xhUsZw6xf7ta9J/kNtVezf7pe
	 1nNEEgaVp1jpA==
Date: Wed, 20 Mar 2024 12:41:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: Suggest inbuilt commands for unknown command
Message-ID: <ZfsDtr5ejAwGySOR@x1>
References: <20240301201306.2680986-1-irogers@google.com>
 <Zfr4jX_b8FCOG_x_@x1>
 <Zfr5__Ej3-0C8sJj@x1>
 <CAP-5=fXXrJRH=Dto2ajD_TUDE1YmkkJZO5Ey2pq5YB0wbVAzeg@mail.gmail.com>
 <Zfr-sQJPbZzbtk8K@x1>
 <ZfsBopALY3whsst5@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfsBopALY3whsst5@x1>

On Wed, Mar 20, 2024 at 12:32:50PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Mar 20, 2024 at 12:20:20PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Mar 20, 2024 at 08:12:56AM -0700, Ian Rogers wrote:
> > > Ah, the change:
> > > 
> > > -               static int done_help;
> > > +               int done_help;
> > > 
> > > created an uninitialized use. Compiler warning/sanitizers? Anyway,
> > > done_help needs hoisting out of the loop and initializing to zero, or
> > > being made static again (ugh).
> > 
> > ⬢[acme@toolbox perf-tools-next]$ git diff
> > diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> > index c719e6ccd9e27778..f9532b20e87cbf05 100644
> > --- a/tools/perf/perf.c
> > +++ b/tools/perf/perf.c
> > @@ -459,7 +459,7 @@ static int libperf_print(enum libperf_print_level level,
> >  
> >  int main(int argc, const char **argv)
> >  {
> > -       int err;
> > +       int err, done_help = 0;
> >         const char *cmd;
> >         char sbuf[STRERR_BUFSIZE];
> >  
> > @@ -558,8 +558,6 @@ int main(int argc, const char **argv)
> >         pthread__block_sigwinch();
> >  
> >         while (1) {
> > -               int done_help;
> > -
> >                 run_argv(&argc, &argv);
> >  
> >                 if (errno != ENOENT)
> > ⬢[acme@toolbox perf-tools-next]$ perf raccord
> >   Fatal: Out of memory, realloc failed
> > ⬢[acme@toolbox perf-tools-next]$
> > 
> > Then:
> > 
> > diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> > index c719e6ccd9e27778..54f62aa6612bc290 100644
> > --- a/tools/perf/perf.c
> > +++ b/tools/perf/perf.c
> > @@ -558,7 +558,7 @@ int main(int argc, const char **argv)
> >         pthread__block_sigwinch();
> >  
> >         while (1) {
> > -               int done_help;
> > +               static int done_help;
> >  
> >                 run_argv(&argc, &argv);
> >  
> > ⬢[acme@toolbox perf-tools-next]$ perf raccord
> >   Fatal: Out of memory, realloc failed
> > ⬢[acme@toolbox perf-tools-next]$
> 
> That main_cmds variable is uninitialized, which ends up making
> add_cmdname() to explode, are you sure this is working on your side?
> 
> Further clarifying, this is without considering the second patch, I
> haven't got to it yet, from what I recall from the description it
> shouldn't matter tho.
> 
> - Arnaldo
> 
> ⬢[acme@toolbox perf-tools-next]$ git diff
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index c719e6ccd9e27778..164b3c78baff4204 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -558,7 +558,7 @@ int main(int argc, const char **argv)
>         pthread__block_sigwinch();
>  
>         while (1) {
> -               int done_help;
> +               static int done_help;
>  
>                 run_argv(&argc, &argv);
>  
> @@ -566,7 +566,7 @@ int main(int argc, const char **argv)
>                         break;
>  
>                 if (!done_help) {
> -                       struct cmdnames main_cmds;
> +                       struct cmdnames main_cmds = { 0, };
>  
>                         for (unsigned int i = 0; i < ARRAY_SIZE(commands); i++) {
>                                 add_cmdname(&main_cmds,
> ⬢[acme@toolbox perf-tools-next]$ perf raccord
> perf: 'raccord' is not a perf-command. See 'perf --help'.
> ⬢[acme@toolbox perf-tools-next]$ 

But:

⬢[acme@toolbox perf-tools-next]$ perf raccord
perf: 'raccord' is not a perf-command. See 'perf --help'.
⬢[acme@toolbox perf-tools-next]$ perf ricord
perf: 'ricord' is not a perf-command. See 'perf --help'.

Did you mean this?
	record
⬢[acme@toolbox perf-tools-next]$ perf ricord
perf: 'ricord' is not a perf-command. See 'perf --help'.

Did you mean this?
	record
⬢[acme@toolbox perf-tools-next]$

So I'll add that and go on from there.

- Arnaldo

