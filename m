Return-Path: <linux-kernel+bounces-23404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D4E82AC5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C128451A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4416114F62;
	Thu, 11 Jan 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oNYmXVP6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27C14AB5;
	Thu, 11 Jan 2024 10:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B9EC433C7;
	Thu, 11 Jan 2024 10:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704969843;
	bh=wTvyF0pAfwwWQaTolfICOUFyt2Pv4Lpw/gdxqRFsfWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNYmXVP6XsJgYWhj+lLirQKLMoSsJw0R2XQkt7T9zPMH0QkQ5uhQvXNq4XB9D1Aos
	 pYCmvd6sknJrgT/Dav66vHkENYCFegEWjNOqKV+7mQhxz2NZWa1I4vKzNIb9XK9jKC
	 QHkQA08uU6nLc0TEMbJ7jg2wpdM+2jZClmFDDyGU=
Date: Thu, 11 Jan 2024 11:44:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Lieven Hey <lieven.hey@kdab.com>
Subject: Re: [PATCH for-5.15] perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
Message-ID: <2024011155-fragrance-perfected-2183@gregkh>
References: <2024010711-skeletal-material-15e8@gregkh>
 <20240109214955.451513-1-namhyung@kernel.org>
 <2024011043-unearned-manned-12b7@gregkh>
 <CAM9d7cj3fdaKVehz+E3Fd_Zf91hy31z19goM84qq+cc8WZe7RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cj3fdaKVehz+E3Fd_Zf91hy31z19goM84qq+cc8WZe7RQ@mail.gmail.com>

On Wed, Jan 10, 2024 at 09:53:17AM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Jan 9, 2024 at 11:59 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jan 09, 2024 at 01:49:55PM -0800, Namhyung Kim wrote:
> > > From: Adrian Hunter <adrian.hunter@intel.com>
> > >
> > > When a program header was added, it moved the text section but
> > > GEN_ELF_TEXT_OFFSET was not updated.
> > >
> > > Fix by adding the program header size and aligning.
> > >
> > > Fixes: babd04386b1df8c3 ("perf jit: Include program header in ELF files")
> > > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Lieven Hey <lieven.hey@kdab.com>
> > > Link: https://lore.kernel.org/r/20221014170905.64069-7-adrian.hunter@intel.com
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > [namhyung: use "linux/kernel.h" instead to avoid build failure]
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/genelf.h | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > What is the git commit id of this change in Linus's tree?
> 
> Sorry I forgot to add that.  It's 89b15d00527b7825ff19130ed83478e80e3fae99

Thanks, now queued up.

greg k-h

