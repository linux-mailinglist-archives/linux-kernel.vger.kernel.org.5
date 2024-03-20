Return-Path: <linux-kernel+bounces-109077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6E8881462
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612B41C217E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8962F50260;
	Wed, 20 Mar 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9M4499G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC75453E13;
	Wed, 20 Mar 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948020; cv=none; b=Wo31pBjy/RmHYVlKMJb8BkSwuBwywrglTbIgkAEutgydcNlPj/271a9Mw21CBBejC2OADhLMDgjfZPivR4P5NOkXWriZMImZKQ8VNh9evILeV/iFPwyW6nDKKr4Y+9RQjRfi4+n7+C7XUGlwEplyb6YdjIWb/ea6gmaGsP9dRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948020; c=relaxed/simple;
	bh=54Vizqm8R5gXNRXIjf4U1g4S2Pp7Ll+bTPE0UXhAVs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZ9x5+7F3ICeicCS8abkPxaM62n+Lg5j0h06QJaKh1Du1bljc4Hu1oRg0rpCN+OWt2RdchXncyf7xYs8OCizep/829gPTOrqVuQvZq7RpTU7iyil1PcD/hYdM/36HBWu1LsVaxr+KpGdVliTbDPkkE4ear1cX0lxOAbw6Wgi9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9M4499G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1E9C43394;
	Wed, 20 Mar 2024 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710948020;
	bh=54Vizqm8R5gXNRXIjf4U1g4S2Pp7Ll+bTPE0UXhAVs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9M4499G8L8fSW+AWLB+NZsES79L67qbQzHs6R7r8feFml+Kn8RMZFLFu0wZnk/1U
	 bUKQlpxWhCc5+IMUKK4ERoy94ujVQtQ+AkWOYSXsuModhGhLJJm1o10L/l8r0deX54
	 Zj5cKOutScBCNz6gfdfAsVKNhUfuUyYr/3ip7z1J5BME5t0CH/aBo5oLUxVNau2t8F
	 eFt0FS8odvPcSDXtEzyNaK9Bgr0GiEkkYHjedpdkyzZaRfV6FZBXcLTaxeIIjHuTwy
	 IJtEfFfCZ11nn0bXq0kgGDtwFic/3B9X+DhrKwsIiWag1owqhLPSByuncW+yshvQM+
	 GLbha148QQvyw==
Date: Wed, 20 Mar 2024 12:20:17 -0300
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
Message-ID: <Zfr-sQJPbZzbtk8K@x1>
References: <20240301201306.2680986-1-irogers@google.com>
 <Zfr4jX_b8FCOG_x_@x1>
 <Zfr5__Ej3-0C8sJj@x1>
 <CAP-5=fXXrJRH=Dto2ajD_TUDE1YmkkJZO5Ey2pq5YB0wbVAzeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXXrJRH=Dto2ajD_TUDE1YmkkJZO5Ey2pq5YB0wbVAzeg@mail.gmail.com>

On Wed, Mar 20, 2024 at 08:12:56AM -0700, Ian Rogers wrote:
> Ah, the change:
> 
> -               static int done_help;
> +               int done_help;
> 
> created an uninitialized use. Compiler warning/sanitizers? Anyway,
> done_help needs hoisting out of the loop and initializing to zero, or
> being made static again (ugh).

⬢[acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index c719e6ccd9e27778..f9532b20e87cbf05 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -459,7 +459,7 @@ static int libperf_print(enum libperf_print_level level,
 
 int main(int argc, const char **argv)
 {
-       int err;
+       int err, done_help = 0;
        const char *cmd;
        char sbuf[STRERR_BUFSIZE];
 
@@ -558,8 +558,6 @@ int main(int argc, const char **argv)
        pthread__block_sigwinch();
 
        while (1) {
-               int done_help;
-
                run_argv(&argc, &argv);
 
                if (errno != ENOENT)
⬢[acme@toolbox perf-tools-next]$ perf raccord
  Fatal: Out of memory, realloc failed
⬢[acme@toolbox perf-tools-next]$

Then:

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index c719e6ccd9e27778..54f62aa6612bc290 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -558,7 +558,7 @@ int main(int argc, const char **argv)
        pthread__block_sigwinch();
 
        while (1) {
-               int done_help;
+               static int done_help;
 
                run_argv(&argc, &argv);
 
⬢[acme@toolbox perf-tools-next]$ perf raccord
  Fatal: Out of memory, realloc failed
⬢[acme@toolbox perf-tools-next]$

- Arnaldo

