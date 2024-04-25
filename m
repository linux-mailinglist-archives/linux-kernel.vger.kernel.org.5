Return-Path: <linux-kernel+bounces-158627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A748B2336
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69911F228C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8566B149DE9;
	Thu, 25 Apr 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAHC/YKX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59D5149C73;
	Thu, 25 Apr 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053326; cv=none; b=tp+xp4ShrOgCoQpwiwmSNcxWbUL/33IhjMSRJmGKLf0bW+Ke4TrQhUOijWq85rMqfz0cAO+PbEB/E6Jm+vNlTBAoAA0qqKgxLCS5elG3782378oVY05qW3CVy7K6xaOTZFfF85s5Bz+uEtu/BELjOQWBC34e4d9OG4ZRSAfONHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053326; c=relaxed/simple;
	bh=ROcqMnqV+nJjqsheF2ChPdHkQI544tNby/JjgpSEVnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NixoBE66+d9T1YZX6qq8RcgnRp/MLJkym1SoKE+mkj4/cVzpk+5rZUxk6CeW3+yrZQbqqaepFIbUt6AZMTCQ9ez5FYSrug/nBZ2L7ha6cgBMehWxRNZ1IkwUUN/IJ7kFILL1KZuR6rtKgqeFTuHmc63UbqD6D0scgqI9cN2YNdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAHC/YKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9259C113CC;
	Thu, 25 Apr 2024 13:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714053326;
	bh=ROcqMnqV+nJjqsheF2ChPdHkQI544tNby/JjgpSEVnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAHC/YKXdszQWpk+AGicRh+U1+NA/JtcnXwFQYxP1li1wiNiU4fxtEP2aFyz7zqSY
	 0DHATOxyPvNBk+a3ZYsXFL3dSDGGWxdYKuQuB+SX051vZEfu7q8x2yZxK1/hOKiaTW
	 0DdemU0F4vtjgr4+f42XWspN7B4k+vPKHSYbGnBouUeG1ylqYgsg4P/UZB5AKblgiV
	 ViUdqlw6wLxKBnO9U/w8HAJq9lPWy9M/9k9xn9ff5IP8T7FJTr9vhhA+lO+poGc8DU
	 ZHvURwcC/yGPyE0yzCWUfoJUUsVtIJUoDg0vdBjmkhb0AkhmBbJ2NVC2IR/Ufdg6rN
	 rQDFhWRKG4YwQ==
Date: Thu, 25 Apr 2024 10:55:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf annotate-data: Check annotation on perf report TUI
Message-ID: <ZipgyUwHjjujlHsO@x1>
References: <20240424230015.1054013-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424230015.1054013-1-namhyung@kernel.org>

On Wed, Apr 24, 2024 at 04:00:15PM -0700, Namhyung Kim wrote:
> As it removed the sample accounting for code when no symbol sort key is
> given for perf report TUI, it might not allocate the annotated_source
> yet.  Let's check if it's NULL first.
> 
> Fixes: 6cdd977ec24e1 ("perf report: Do not collect sample histogram unnecessarily")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Picking it up into perf-tools-next:

⬢[acme@toolbox perf-tools-next]$ git log torvalds/master.. perf-tools-next | grep 6cdd977ec24e1
commit 6cdd977ec24e1538b35a08bde823a74b69e829f2
⬢[acme@toolbox perf-tools-next]$ 

- Arnaldo

> ---
>  tools/perf/util/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index dca2c08ab8c5..f5b6b5e5e757 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -906,7 +906,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
>  	if (parch)
>  		*parch = arch;
>  
> -	if (!list_empty(&notes->src->source))
> +	if (notes->src && !list_empty(&notes->src->source))
>  		return 0;
>  
>  	args.arch = arch;
> -- 
> 2.44.0.769.g3c40516874-goog

