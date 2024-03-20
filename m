Return-Path: <linux-kernel+bounces-109104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D563C8814A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D99028554D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D35C54662;
	Wed, 20 Mar 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIv0ooDJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBC353E14;
	Wed, 20 Mar 2024 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948774; cv=none; b=chmHMJoYNWcy+pJVGF2pPYm+CMcxXkjpsVYHTR7WD1S+FppjmSiSqBl7036ShKNThvC+HkJX3Qp1UL4LgiX0MpLHCJFolbNCgZ3VVpjjz/tHqf5LTU48fdY4y2AJvLX70fnUfl2UZLNoVNloMz6qxx7EH75GKp3NE0a208oG7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948774; c=relaxed/simple;
	bh=jXnepYnPUUQUuOFTV5avKiVLlnCRROuyiCpNkq1UfMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4Huoh78uo4V6x4gccQm9qRlmMqwuI26UkgEujy+bpyOeNFe3vrI2egFNGK6wJ+AEXEWdriFdDgd/9apjWpQeSjRVWifjvO9EbWig4nX+mtx6SuTpFW6ZVWSyNJYVm2760eHM9e6vStRXwpobJ9RV3jkbhyL0G2VRL96+w/FteE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIv0ooDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8811C43390;
	Wed, 20 Mar 2024 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710948774;
	bh=jXnepYnPUUQUuOFTV5avKiVLlnCRROuyiCpNkq1UfMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIv0ooDJZ71ZSc/Dwbb5OF/iiZubkD0MGkdRmCnfsN1RwF+oGbFywJYb3ZhFjft9q
	 dJrnBAjjQzWpdeNow+P8auLLHYdGnuLl86GeAyo/EFZY8EYLVIgvoRw5EsCYkRaREh
	 F7qhvfwBNOJWE/iz/bHu1qLo4aRbaPRvYj9qD8+uD01y2xPu/8ZCBJsjugiMtpGrYB
	 7d+xjmZHokc3zLfTtL8pKXivjJVCktF46JhQGc7xjtVlDXbHrEah4lgRP73YtnwAkq
	 XzllpHz7hn7eqKfEOx+jtgTZiL1b5jacYlibFMzBWTG+W96ZopZS8kb12CLp/zuOFp
	 M5yw55RLKsDbA==
Date: Wed, 20 Mar 2024 12:32:50 -0300
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
Message-ID: <ZfsBopALY3whsst5@x1>
References: <20240301201306.2680986-1-irogers@google.com>
 <Zfr4jX_b8FCOG_x_@x1>
 <Zfr5__Ej3-0C8sJj@x1>
 <CAP-5=fXXrJRH=Dto2ajD_TUDE1YmkkJZO5Ey2pq5YB0wbVAzeg@mail.gmail.com>
 <Zfr-sQJPbZzbtk8K@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zfr-sQJPbZzbtk8K@x1>

On Wed, Mar 20, 2024 at 12:20:20PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Mar 20, 2024 at 08:12:56AM -0700, Ian Rogers wrote:
> > Ah, the change:
> > 
> > -               static int done_help;
> > +               int done_help;
> > 
> > created an uninitialized use. Compiler warning/sanitizers? Anyway,
> > done_help needs hoisting out of the loop and initializing to zero, or
> > being made static again (ugh).
> 
> ⬢[acme@toolbox perf-tools-next]$ git diff
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index c719e6ccd9e27778..f9532b20e87cbf05 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -459,7 +459,7 @@ static int libperf_print(enum libperf_print_level level,
>  
>  int main(int argc, const char **argv)
>  {
> -       int err;
> +       int err, done_help = 0;
>         const char *cmd;
>         char sbuf[STRERR_BUFSIZE];
>  
> @@ -558,8 +558,6 @@ int main(int argc, const char **argv)
>         pthread__block_sigwinch();
>  
>         while (1) {
> -               int done_help;
> -
>                 run_argv(&argc, &argv);
>  
>                 if (errno != ENOENT)
> ⬢[acme@toolbox perf-tools-next]$ perf raccord
>   Fatal: Out of memory, realloc failed
> ⬢[acme@toolbox perf-tools-next]$
> 
> Then:
> 
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index c719e6ccd9e27778..54f62aa6612bc290 100644
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
> ⬢[acme@toolbox perf-tools-next]$ perf raccord
>   Fatal: Out of memory, realloc failed
> ⬢[acme@toolbox perf-tools-next]$

That main_cmds variable is uninitialized, which ends up making
add_cmdname() to explode, are you sure this is working on your side?

Further clarifying, this is without considering the second patch, I
haven't got to it yet, from what I recall from the description it
shouldn't matter tho.

- Arnaldo

⬢[acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index c719e6ccd9e27778..164b3c78baff4204 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -558,7 +558,7 @@ int main(int argc, const char **argv)
        pthread__block_sigwinch();
 
        while (1) {
-               int done_help;
+               static int done_help;
 
                run_argv(&argc, &argv);
 
@@ -566,7 +566,7 @@ int main(int argc, const char **argv)
                        break;
 
                if (!done_help) {
-                       struct cmdnames main_cmds;
+                       struct cmdnames main_cmds = { 0, };
 
                        for (unsigned int i = 0; i < ARRAY_SIZE(commands); i++) {
                                add_cmdname(&main_cmds,
⬢[acme@toolbox perf-tools-next]$ perf raccord
perf: 'raccord' is not a perf-command. See 'perf --help'.
⬢[acme@toolbox perf-tools-next]$ 

