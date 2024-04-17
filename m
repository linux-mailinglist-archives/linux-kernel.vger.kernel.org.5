Return-Path: <linux-kernel+bounces-148853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094B08A8827
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A101F2444C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FF31487DC;
	Wed, 17 Apr 2024 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8956/kW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287A11482E0;
	Wed, 17 Apr 2024 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369109; cv=none; b=NpfTrVVyLSDIeaXtNAR2LA6BD1Amw4ClrWO9koOBAWj9MXBYdm8WQlSZCOWRVwraq4dyW5T4sX7Skozr3lYO32drrS90ZB1FFdUqvFJE2bDHquOl+8VAfWBat9dTOlPm/eBmGndCYHmuEkZ+g3jlJeHSczzjtio6EdnOd23Hp7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369109; c=relaxed/simple;
	bh=WLarpyYIWWkkchcEU9ZfUR3cQ8pEaw4tJ/8AER+TFKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us/NL64U7tti9TK2hA/YwhExcItP0Q9IziJNWWq7UNlR5NPE3wvmXznqSFYnCBEsCVAejLvrWTDfCPemc3BBwLQekp0lzZQ2kxrrTU/sajvyFGlXspjm9cxbSjSFMwlQzzLiZVyav28fDaJ/mfIjc36Yt9p9yyFv4TseIgHKpvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8956/kW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF1FC072AA;
	Wed, 17 Apr 2024 15:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713369108;
	bh=WLarpyYIWWkkchcEU9ZfUR3cQ8pEaw4tJ/8AER+TFKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X8956/kWgEy3matkA3uhP5tLIBv/of2FydJ4VmB+tierc5whIG7Oqb4ZHSb3jiu8j
	 Ag7bo6Fumapa1dMDJdWiZpoUmdF/Le46cewurhe3QgMnGsxbOF23lDEYecDp7wNxQe
	 ptZfPNxcR6yBm7Aq7oyCK/tLT62TUupFkYgPaiYW1bDe/FnFAk/sRE7Cafe0mkhrYb
	 7LEkgwmhQsO41Y3o8zyCQJDDhZVKG5GkSyWk5d+VL5oqUgdQqjKYQOhqYDu0h+P0Vk
	 nbqazQrKW+CB+/eBjA554zLLXTHe4ZLVHVeRk8JmVxcZ31NTEq08LxCHOB7WWEkuQH
	 MM6fhU3TGfqEQ==
Date: Wed, 17 Apr 2024 12:51:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf vendor events arm64: AmpereOne/AmpereOneX: Mark
 L1D_CACHE_INVAL impacted by errata
Message-ID: <Zh_wEU6bdshoD2aO@x1>
References: <20240408214022.541839-1-ilkka@os.amperecomputing.com>
 <3df74a0a-6778-43c4-a8c2-70d71c324f6a@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3df74a0a-6778-43c4-a8c2-70d71c324f6a@arm.com>

On Tue, Apr 09, 2024 at 02:33:18PM +0100, James Clark wrote:
> On 08/04/2024 22:40, Ilkka Koskinen wrote:
> > L1D_CACHE_INVAL overcounts in certain situations. See AC03_CPU_41 and
> > AC04_CPU_1 for more details. Mark the event impacted by the errata.
> > 
> > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > ---
> >  tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json  | 4 +++-
> >  tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json | 4 +++-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> > index 7a2b7b200f14..ac75f12e27bf 100644
> > --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> > +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> > @@ -9,7 +9,9 @@
> >          "ArchStdEvent": "L1D_CACHE_REFILL_RD"
> >      },
> >      {
> > -        "ArchStdEvent": "L1D_CACHE_INVAL"
> > +        "ArchStdEvent": "L1D_CACHE_INVAL",
> > +        "Errata": "Errata AC03_CPU_41",
> > +        "BriefDescription": "L1D cache invalidate. Impacted by errata -"
> >      },
> >      {
> >          "ArchStdEvent": "L1D_TLB_REFILL_RD"
> > diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json
> > index c50d8e930b05..f4bfe7083a6b 100644
> > --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json
> > +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json
> > @@ -9,7 +9,9 @@
> >          "ArchStdEvent": "L1D_CACHE_REFILL_RD"
> >      },
> >      {
> > -        "ArchStdEvent": "L1D_CACHE_INVAL"
> > +        "ArchStdEvent": "L1D_CACHE_INVAL",
> > +        "Errata": "Errata AC04_CPU_1",
> > +        "BriefDescription": "L1D cache invalidate. Impacted by errata -"
> >      },
> >      {
> >          "ArchStdEvent": "L1D_TLB_REFILL_RD"
 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied to perf-tools-next,

- Arnaldo

