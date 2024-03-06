Return-Path: <linux-kernel+bounces-94645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20A087429F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62718281CB5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7DB1BC4B;
	Wed,  6 Mar 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8awcRI+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2041C1BC22;
	Wed,  6 Mar 2024 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763721; cv=none; b=lnQz80WiaLpGxe9HbH3QnEHL6ilUnSLRyoEBmV3WOaue7ovylkRTpdSU1vqWCLSETPhQ7vpcBh+zKP62Z7e9bMZV234jiPgraF1WyDmmkqC8dj42OFeloifqEiJreDiPl3/IpF+UB//M3IHXpWc28O90xCuSow9HtTa3Ava1xAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763721; c=relaxed/simple;
	bh=MlQq2QOH4T5O53iSAeAQzQexenXuj0qdDakJrAMFRSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOezdhvDjMZl5cfADo0W3sPEautFxyQQixsNAkkvLQWZTaqActZ4C/uw+cPERFK9VVbNF8eT6Y3jwKKcyT3BRlBrC/ZV5Gx+fJ9zIPLthB1RMFsthLlJlcJqb3CvusMNymMAeHOCAeUqul0K68OQUMfnJleIxPS7i9KQwH3uBHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8awcRI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A63C433C7;
	Wed,  6 Mar 2024 22:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709763720;
	bh=MlQq2QOH4T5O53iSAeAQzQexenXuj0qdDakJrAMFRSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8awcRI+cbOQJ4rFYl4bBiukwg9eMMOOdqzZW0bvoWx/Km8dBtRKxJbmMAEjBD0eA
	 cHZh292AmDPfCHHSfp/bsFgKO3w8qo1JDn8FE10B6L3u5QJxD5Ki9sNyuZCe+fqwlm
	 TF/8wHBLxGibSw7vZCFZoibS1J6y2wciUYeMf5jWB/EZFqToWqor3YDfefnSKLJSF1
	 Sp7ZBhJ+hijF9j8mdyDS930GGC9UpabGJlkRruygLYXfvk2M+O3ArV65KDGUC1+w/Z
	 wTpkVQG/6NzWxcwDLAsmxePOXzQAxwmkEeHHShKaWrmg5LyY9VHesY+c4PiHKH+na1
	 g3S7Abgc9IMOg==
Date: Wed, 6 Mar 2024 19:21:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 0/4] perf annotate: Improve memory usage for symbol
 histogram
Message-ID: <ZejshUg8XiQz5YGa@x1>
References: <20240304230815.1440583-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304230815.1440583-1-namhyung@kernel.org>

On Mon, Mar 04, 2024 at 03:08:11PM -0800, Namhyung Kim wrote:
> Hello,
> 
> This is another series of memory optimization in perf annotate.
> 
> v2 changes:
>  * fix a bug when offset is bigger than 16 bits
> 
> 
> When perf annotate (or perf report/top with TUI) processes samples, it
> needs to save the sample period (overhead) at instruction level.  For
> now, it allocates an array to do that for the whole symbol when it
> hits any new symbol.  This comes with a lot of waste since samples can
> be very few and instructions span to multiple bytes.
> 
> For example, when a sample hits symbol 'foo' that has size of 100 and
> that's the only sample falls into the symbol.  Then it needs to
> allocate a symbol histogram (sym_hist) and the its size would be
> 
>   16 (header) + 16 (sym_hist_entry) * 100 (symbol_size) = 1616
> 
> But actually it just needs 32 (header + sym_hist_entry) bytes.  Things
> get worse if the symbol size is bigger (and it doesn't have many
> samples in different places).  Also note that it needs a separate
> histogram for each event.
> 
> Let's split the sym_hist_entry and have it in a hash table so that it
> can allocate only necessary entries.
> 
> No functional change intended.
> 
> Thanks,
> Namhyung

No difference before/after on that 'perf annotate --stdio2' for all
binaries in a perf record of building perf using the default binutils
objdump disassembler, etc.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> 
> Namhyung Kim (4):
>   perf annotate: Add a hashmap for symbol histogram
>   perf annotate: Calculate instruction overhead using hashmap
>   perf annotate: Remove sym_hist.addr[] array
>   perf annotate: Add comments in the data structures
> 
>  tools/perf/ui/gtk/annotate.c |  14 ++++-
>  tools/perf/util/annotate.c   | 116 ++++++++++++++++++++++-------------
>  tools/perf/util/annotate.h   |  86 +++++++++++++++++++++++---
>  3 files changed, 159 insertions(+), 57 deletions(-)
> 
> -- 
> 2.44.0.rc1.240.g4c46232300-goog

