Return-Path: <linux-kernel+bounces-68568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D014B857C92
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721E0286F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5AE78B66;
	Fri, 16 Feb 2024 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iVnoNw9Y"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D570077F2C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086562; cv=none; b=bb0oExPUqc9Cl3V5+JuoLy0e4F273bt513Cb9/Topx6kty6tnsEjrcH/LuqRcN8fVQMazGffVv5fh5/7t9ltP1R08QczkJSfjNM78DkrE6t3R8VoV2v1h0ue8x2QIqXzFis1hlvFuemd8HxdzevvVwJM+HviiKoFIqN/W6s1Crs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086562; c=relaxed/simple;
	bh=1DYP3Ta/AJJgh2KRQMfUYZ0/YFlLC7K+nMQvEkXKk8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jbw6VUSaeHrs6dz8O1Hodb0MxF/UJ2rQxxz1aDCYAjIpWnNTDEu8cgTaL0r4hNz+fRjU57Fvau8mplS4ANn/Chdc+iJXNb6F/eagO+792iPwJfK+EKx4jo3yY1HRHiWsoWtgZYWo5mRpVqMs0ea7U7SiUSHwsKM6OAk+ZfNUCg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iVnoNw9Y; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 16 Feb 2024 20:29:02 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708086556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0U/8nIGG34u2L2vQUrpTgUrGZed1ST7/cCFA2MX7hdo=;
	b=iVnoNw9YfjLtkG5WYC8Vss38AFwtIl189YvpdOcBILeWElZMw0zEmNmvFvmVO6sXlkqwGd
	3YWsUCR6VuARrrqWFFfXupO2nqdltIgZYZ5nxRqOh2NAEQaSDjkpCAcVWIbuZJEacjpt0n
	leJaOhfo8I2DkbGcWh6ofr4LQDVAZ/I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH] perf tools: Fixup module symbol end address properly
Message-ID: <20240216122902.GC99827@debian-dev>
References: <20240212233322.1855161-1-namhyung@kernel.org>
 <20240213033954.GB81405@debian-dev>
 <CAM9d7ciTwYAgry-nW9z+_VMj+BJ7ZNZnkKH_t_AHvV5joNuWQQ@mail.gmail.com>
 <20240214101420.GF81405@debian-dev>
 <CAM9d7cgWXyv1Uy=ZWsT6K=KaztgtszZp0BOxPAbgjuKuX6OzdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgWXyv1Uy=ZWsT6K=KaztgtszZp0BOxPAbgjuKuX6OzdQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 15, 2024 at 09:19:51PM -0800, Namhyung Kim wrote:

[...]

> > On the other hand, I am a bit concern
> > for a big function (e.g. its code size > 4KiB), we might fail to find
> > symbols in this case with the change above.
> 
> Yes, it's another problem.  But it cannot know the exact size
> so it just assumes it fits in a page.

Agreed.

> > > > If so, we should use a specific checking for eBPF program, e.g.:
> > > >
> > > >                         else if (prev_mod && strcmp(prev_mod, curr_mod) &&
> > > >                                  (!strcmp(prev->name, "bpf") ||
> > > >                                   !strcmp(curr->name, "bpf")))
> > >
> > > I suspect it can happen on any module boundary so better
> > > to handle it in a more general way.
> >
> > I don't want to introduce over complexity at here. We can apply
> > current patch as it is.
> 
> Good, can I get your Reviewed-by then? :)

Yes.

Reviewed-by: Leo Yan <leo.yan@linux.dev>

> > A side topic, when I saw the code is hard coded for 4096 as the page
> > size, this is not always true on Arm64 (the page size can be 4KiB,
> > 16KiB or 64KiB). We need to consider to extend the environment for
> > recording the system's page size.
> 
> Sounds good.  But until then, 4K would be the reasonable choice.

This is fine for me.

Thanks,
Leo

