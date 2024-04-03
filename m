Return-Path: <linux-kernel+bounces-130097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EE0897412
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2D11F223FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5B614A4F0;
	Wed,  3 Apr 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl9dPTS9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CEA14A4C8;
	Wed,  3 Apr 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158407; cv=none; b=amTdQkjvVmrNS/hDxyNT6sd+Irfwfs6iaWoULZIKps/yA2Bs4NBKoUC7GwNrXS6zVD6tLt3XXdTR97MPI9TBtUWxVtyHgG1M4OJargTnTMaeS/3oamNt8A5/PWoueTqdelK7yVXq0xp4hrZNjyzviJicYiuRKBBB/w1lAeB47OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158407; c=relaxed/simple;
	bh=9KfcCS7D7DjPFMDq2QQ5xmLYUD9hfXeg8QO/vO8OgGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX7I5ReWSiIPTorXNYor878SKXIiPd8shbVxkgpPhOp70tTV74qZu6ufOIhDJT6aGhtxvMIiZ/PV/to8gXQ/8plasiz5vEHN1ByHbnFJDCExlxwJujxIpxOptnnpEMCgH6RGWGR+Nue2rcq1GVXfI1jZpvUxzkDFPtI9ARts5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl9dPTS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC34DC433F1;
	Wed,  3 Apr 2024 15:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712158407;
	bh=9KfcCS7D7DjPFMDq2QQ5xmLYUD9hfXeg8QO/vO8OgGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bl9dPTS9Ifzv+/IEXdTzsyizBHuvYXnJuM15/DFAEnKts7/Wqya6/+xQimW0Fcbzu
	 tHPy9M6iBjlfYaybYv5jWs39ZystLjywI5Axknv7K/TQSNUvmT3WxzZoKoP7pp3NkN
	 GcH6teFpQpQKstYnRzsFVQiQ7RprXGCpyb5sEg2zTMKLMuUQwLydXRDCiKqZ3Qw7/C
	 uEKzDRmUCtbDyn1nRpWNjRiapS+LSfmzOuCki9hQi7N4/vGfqPyVy9gQvwZu9ML3B/
	 7nUGvc9plYSmw3pO1lPVyAlLKmZ6EWqbB1dbmNwy1PZknN35R7s3452/C79RIDPPkI
	 VzGLV6ji/inGg==
Date: Wed, 3 Apr 2024 12:33:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Yang Jihong <yangjihong@bytedance.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	james.clark@arm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf beauty: Fix AT_EACCESS undeclared build error for
 system with kernel versions lower than v5.8
Message-ID: <Zg12xH_x_D3yq5ug@x1>
References: <20240403122558.1438841-1-yangjihong@bytedance.com>
 <Zg1l3RUMrzJaBYcP@x1>
 <CAP-5=fW36AauhRemyNah_a4bnLWisV2kxmVZadtSb2xHA8RfrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW36AauhRemyNah_a4bnLWisV2kxmVZadtSb2xHA8RfrA@mail.gmail.com>

On Wed, Apr 03, 2024 at 08:05:32AM -0700, Ian Rogers wrote:
> On Wed, Apr 3, 2024 at 7:21 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Wed, Apr 03, 2024 at 08:25:58PM +0800, Yang Jihong wrote:
> > > In the environment of ubuntu20.04 (the version of kernel headers is 5.4),
> > > there is an error in building perf:
> > >
> > >     CC      trace/beauty/fs_at_flags.o
> > >   trace/beauty/fs_at_flags.c: In function ‘faccessat2__scnprintf_flags’:
> > >   trace/beauty/fs_at_flags.c:35:14: error: ‘AT_EACCESS’ undeclared (first use in this function); did you mean ‘DN_ACCESS’?
> > >      35 |  if (flags & AT_EACCESS) {
> > >         |              ^~~~~~~~~~
> > >         |              DN_ACCESS
> > >   trace/beauty/fs_at_flags.c:35:14: note: each undeclared identifier is reported only once for each function it appears in
> > >
> > > commit 8a1ad4413519 ("tools headers: Remove now unused copies of
> > > uapi/{fcntl,openat2}.h and asm/fcntl.h") removes fcntl.h from tools
> > > headers directory, and fs_at_flags.c uses the 'AT_EACCESS' macro.
> > > This macro was introduced in the kernel version v5.8.
> > > For system with a kernel version older than this version,
> > > it will cause compilation to fail.
> >
> > Thanks, I test on it, but since I didn't found libtraceevent-devel
> > available there, then I have to build with NO_LIBTRACEEVENT=1 and thus
> > this doesn't get built :-\
> >
> > Thanks, applying.
> 
> Yang also wrote:
> https://lore.kernel.org/lkml/20240314063000.2139877-1-yangjihong@bytedance.com/
> that may have helped you with this.

Yeah, if I change my build container on distros that don't provide
libtraceevent-devel to build it from sources, and then point the perf
build to that directory, I'll try to do that.

And I just merged that patch, thanks for pointing it out.

- Arnaldo
 
> Thanks,
> Ian
> 
> > - Arnaldo
> >
> > > Fixes: 8a1ad4413519 ("tools headers: Remove now unused copies of uapi/{fcntl,openat2}.h and asm/fcntl.h")
> > > Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> > > ---
> > >  tools/perf/trace/beauty/fs_at_flags.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/tools/perf/trace/beauty/fs_at_flags.c b/tools/perf/trace/beauty/fs_at_flags.c
> > > index c1365e8f0b96..c200669cb944 100644
> > > --- a/tools/perf/trace/beauty/fs_at_flags.c
> > > +++ b/tools/perf/trace/beauty/fs_at_flags.c
> > > @@ -10,6 +10,14 @@
> > >  #include <linux/fcntl.h>
> > >  #include <linux/log2.h>
> > >
> > > +/*
> > > + * uapi/linux/fcntl.h does not keep a copy in tools headers directory,
> > > + * for system with kernel versions before v5.8, need to sync AT_EACCESS macro.
> > > + */
> > > +#ifndef AT_EACCESS
> > > +#define AT_EACCESS 0x200
> > > +#endif
> > > +
> > >  #include "trace/beauty/generated/fs_at_flags_array.c"
> > >  static DEFINE_STRARRAY(fs_at_flags, "AT_");
> > >
> > > --
> > > 2.25.1
> > >

