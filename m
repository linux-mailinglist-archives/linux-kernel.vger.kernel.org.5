Return-Path: <linux-kernel+bounces-159046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884798B2897
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449B1286271
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C35014F13A;
	Thu, 25 Apr 2024 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+CVexLB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7B639AFD;
	Thu, 25 Apr 2024 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071439; cv=none; b=BXn2EhJTO01WQBcChD7mdITFNdJjaqNSuxFXk0r9SyLp/CsHGfAYRxPcuCDWypdrm+5OJ0nYO8QXiIin/mGekfxTdaTvQ7rPJ8I0xmxFxXS5YwizG1MAv3SJrDZtAFqJK606WG3GjmEIJ7w18VOkxIde0LGvlPxTnlioO8Bt42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071439; c=relaxed/simple;
	bh=DR/cNmaTWBltOT5kSocGhLsohmj7ZxNGmrgCEc8e2ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy0Av0TflRK78KaxrPEmco1isfj7TIyDY0iIuvYJocXxq+HWm/vu2KWUQi4EaujefdZDT+ioSsJATsd3/xtlgc0YVwWBCfy8mjOwgGlw8wybmTWQXhL5X7JO2o51cM5NLkoxHbSvoanUIL7jERYTuW3yRJwNpe2jEB8sMeQHdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+CVexLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7C4C113CC;
	Thu, 25 Apr 2024 18:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714071439;
	bh=DR/cNmaTWBltOT5kSocGhLsohmj7ZxNGmrgCEc8e2ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+CVexLBzIXepUF2cGGvJqSDrARB1iAyGZW7ZfZd4HBNreDUXh60lT3NsafiSn75X
	 2//Gr4iMmguzeQRs57Ni3WfDTy3+TyJGPdgZvSBblBtt0Zd3ytxOT5/V1mQvXgj+kV
	 w8nGvSqd1fOihnuIIbosiRLvKTjk1N7xnkyOSjYZ0LpdOZRzI9r7B2ITS2cmT4Qvmg
	 r6hgm10pgOovokfWrFvOuQ6OdPUZ47WghX+GZ6kqLwYkxVIe1kmBblkvY7bMWhpRZ8
	 eNz9IV/UaPRExnsQuCcSC/XSylLn73sIT4LtUYIz+m+lwY+BMPhLExO/IkxQ3MPgzo
	 3wLJm1P7JCIkg==
Date: Thu, 25 Apr 2024 15:57:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf annotate: Fix data type profiling on stdio
Message-ID: <ZiqniieOFsFkwhAx@x1>
References: <20240423020643.740029-1-namhyung@kernel.org>
 <CAP-5=fUjDdy1GQCq_Z96x=bMXrxmqKojnysYsOnjBvO_nufjsQ@mail.gmail.com>
 <CAM9d7cgDSnd_kZu5LRkNF-UgDX9L-3Po4f9idAYhmqtb8MhEdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgDSnd_kZu5LRkNF-UgDX9L-3Po4f9idAYhmqtb8MhEdw@mail.gmail.com>

On Tue, Apr 23, 2024 at 04:07:08PM -0700, Namhyung Kim wrote:
> On Tue, Apr 23, 2024 at 9:57 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Apr 22, 2024 at 7:06 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > The loop in hists__find_annotations() never set the 'nd' pointer to NULL
> > > and it makes stdio output repeating the last element forever.  I think
> > > it doesn't set to NULL for TUI to prevent it from exiting unexpectedly.
> > > But it should just set on stdio mode.
> > >
> > > Fixes: d001c7a7f473 ("perf annotate-data: Add hist_entry__annotate_data_tui()")
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks for your review!

Thanks, applied to perf-tools-next,

- Arnaldo
 
> >
> > Should we have a test to cover things like this?
> 
> Ok, I'll try to add one for perf annotate.
> 
> Thanks,
> Namhyung

