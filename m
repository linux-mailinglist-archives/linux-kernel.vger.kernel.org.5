Return-Path: <linux-kernel+bounces-166869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FE68BA11B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BEF61C20FE1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CD517BB1E;
	Thu,  2 May 2024 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNTV1uS8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429117BA0;
	Thu,  2 May 2024 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714678767; cv=none; b=RdJy7geOuqFaGO+ysPJLoVqCkRMQ1bzfkGn4mjm2dq9PAXEExzU9MMLBzs68WXPOktzXBJTBdsRPmEh1Kko9jts5dVR/g/2jrcoPeNCnsjl37jc8AFk7fvnNvsSbCZvKwo2ya0gOn+AOujpNZ5+PXIZ/56t78pSn4c4tparqjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714678767; c=relaxed/simple;
	bh=JsVdQSR88vIGJ/32DmR5jle3XfAotEofYnypCmvfJrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1DTNOcW6BDmte9yQdukVfe7fnwiFDDoSZpRieIyF6HndlF/2MNdXQPI5bkoUX0z8WGtHa4pvFGuNKrFXeUeVhmenE6crfO9xYArtMzndqGhwMPj+tghrBNxzRsLNpMDItDqabdTCYgAHt/Q2Bqyt39N1ALWVQ/8f1Pzwa0y+e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNTV1uS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89595C113CC;
	Thu,  2 May 2024 19:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714678766;
	bh=JsVdQSR88vIGJ/32DmR5jle3XfAotEofYnypCmvfJrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNTV1uS8YgYJtg3/KHDnznPQGzshJLpPohlxoZ1nkZmtzhgmtgwQUZwr7wzpHcXJZ
	 5i3KGoA7GWjC958p8J0QgFz51QuUQ8pvYKrhmJNaLPDDT3EVSOK/gjSRCXmxAAJWJA
	 BND8ZMVtXlX8bkLOE4l0RFfBC+30AWL6PAkPfpWYoH5MpaOKCTG3m5W5p17zznnFPb
	 TLEZdgHrrZfjd1VyhJxKyUuysvFcW4LNHRHE1Fn8eL5x1AB1dz9JYv89A9gvowx/Ev
	 s/QQT8yaTUcpr987qQD7OV7+nFk4aGgT0MmT/jLs8hp4w1rRGPYvffOr+YRXPWs464
	 og/7malu7HnqA==
Date: Thu, 2 May 2024 16:38:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf maps: Remove check_invariants() from maps__lock()
Message-ID: <ZjPrpnX1XqyOHQku@x1>
References: <20240429225738.1491791-1-namhyung@kernel.org>
 <CAP-5=fWeFyihQNMEJ2BQpm6hmNBmPuwFk3rGgVh+jV0mKd7myg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWeFyihQNMEJ2BQpm6hmNBmPuwFk3rGgVh+jV0mKd7myg@mail.gmail.com>

On Mon, Apr 29, 2024 at 07:09:54PM -0700, Ian Rogers wrote:
> On Mon, Apr 29, 2024 at 3:57 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I found that the debug build was a lot slowed down by the maps lock code
> > since it checks the invariants whenever it gets the pointer to the lock.
> > This means it checks twice the invariants before and after the access.
> >
> > Instead, let's move the checking code within the lock area but after any
> > modification and remove it from the read paths.  This would remove (more
> > than) the half of the maps lock overhead.
> >
> > The time for perf report with a huge data file (200k+ of MMAP2 events).
> >
> >   Non-debug     Before      After
> >   ---------   --------   --------
> >      2m 43s     6m 45s     4m 21s

Yeah, I had a debug build to check the size of 'struct hist_entry' with
pahole and noticed that invariant checking in 'perf top'.

> Thanks Namhyung, I think the change makes sense. There is an issue
> that a user of a map may mutate it in a way that breaks the maps
> sorting, symbol code would be a likely culprit of such a thing. A fix
> for such a breakage would be to just set the unsorted flag on maps.
> We'd be less likely to spot such an issue after this change, but it is
> simple enough to add the function call when needed. Another option
> would be to add another make flag like PARSER_DEBUG for these kind of,
> "be paranoid," type things. Anyway, let's try to fix those problems
> when they exist.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo

