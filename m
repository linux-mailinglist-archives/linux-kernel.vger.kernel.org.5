Return-Path: <linux-kernel+bounces-140305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306AA8A127C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77CDB23295
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40151474CA;
	Thu, 11 Apr 2024 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZxhiMJ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41AD1448EF;
	Thu, 11 Apr 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833500; cv=none; b=CJJyJ+78MBbMwLM5MkPOgwNtzfhVSUIoeZe8H+7sVRLTC5m+C7cB/AK1H/12oPBULXGzhu2H3cms0/fyhtSuAk3N5rKIgn4lHKeW7QqviWHrxiYzfSRh6v1bQYsBwkA+xRPvXTydfyWnK3hJmlpUZZ8miMmoGLcjemHvWiJvmmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833500; c=relaxed/simple;
	bh=++UYlsK6YPiWRvXsuUgKSwshDBZosFmb7aPsHR3zRDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSjIp/hMGiCvlHJFCewcFZVWLi8Zu52TML9osKipMXHkTHayD0fPf8KqbGDuUVXfV4e85Z4YeQIZnBovpC/hIu1/IzQMTmt/LFG96K69ZQhH7lUf3QwiLeZbSrFxHbOGVB0DiSku3juA9i15eiqpdi1Q/y/7SC90bY34iI1noq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZxhiMJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14247C433F1;
	Thu, 11 Apr 2024 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712833499;
	bh=++UYlsK6YPiWRvXsuUgKSwshDBZosFmb7aPsHR3zRDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZxhiMJ+eLMVTcFDC68n4ifgZZ4PnuVocSFbYFl0BqyFErcqStEkXyY1rMvmuKv3o
	 bFfaVilritrINt9Cx6hbI0PlZHYKarZGAHoNZPyjWBr2petu4SQ7na4jcuoTWyAawn
	 FH1SW7NtQOkfH1J/cMIQJnqHajcuRLMpVFVf9BoHmuKhTZuton9enz15ydSps2eka0
	 yTeUM8LZF+CRa13cULssbZGj2xH1H6knWQDFzyiLNiVrwgWQAcsq3RRowR8jDMqy9t
	 fHUZGfV6BUmUBcbPCYFuGuScyOX79TiDgdFEd8lGFmnJqJeZW+x24g9t8GfY8G1L9b
	 dwlc4bsJf/Uqw==
Date: Thu, 11 Apr 2024 08:04:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Konstantin Kharlamov <Hi-Angel@yandex.ru>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf annotate: Skip DSOs not found
Message-ID: <ZhfD2PZvjTpVstT3@x1>
References: <20240410185117.1987239-1-namhyung@kernel.org>
 <CAP-5=fXeM32=wnkMnp49wLYDS1PWwhKtK9UiKyAa=XvJz9kANg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXeM32=wnkMnp49wLYDS1PWwhKtK9UiKyAa=XvJz9kANg@mail.gmail.com>

On Wed, Apr 10, 2024 at 12:14:37PM -0700, Ian Rogers wrote:
> On Wed, Apr 10, 2024 at 11:51 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > In some data file, I see the following messages repeated.  It seems it
> > doesn't have DSOs in the system and the dso->binary_type is set to
> > DSO_BINARY_TYPE__NOT_FOUND.  Let's skip them to avoid the followings.
> >
> >   No output from objdump  --start-address=0x0000000000000000 --stop-address=0x00000000000000d4  -d --no-show-raw-insn       -C "$1"
> >   Error running objdump  --start-address=0x0000000000000000 --stop-address=0x0000000000000631  -d --no-show-raw-insn       -C "$1"
> >   ...
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Perhaps: Closes:
> https://lore.kernel.org/linux-perf-users/15e1a2847b8cebab4de57fc68e033086aa6980ce.camel@yandex.ru/

I added:

Closes: https://lore.kernel.org/linux-perf-users/15e1a2847b8cebab4de57fc68e033086aa6980ce.camel@yandex.ru/
Reported-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>

> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,

- Arnaldo

