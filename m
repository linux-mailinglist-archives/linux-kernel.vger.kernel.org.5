Return-Path: <linux-kernel+bounces-130601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9734897A58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16CAD1C217EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EE615664A;
	Wed,  3 Apr 2024 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTFRA8wC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0614C5B3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178236; cv=none; b=sMIkrJnr5nzwilvoeU5BTljOcuDhl4rFftheSD7RTaM0q2NJdIraEp49cjDuVUY4QTK020sNkfVeXGHwjoVgi6Sfk6hnYYwDT8g8vLgUYBwg8KP9YWuiq+KXw0pWYmvVdUPLeqnEiSTKxdgYsRPaDzy2O5U3xKKme1+tUcO6des=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178236; c=relaxed/simple;
	bh=2nXvlcysOJppAiAzRe5dRfX+OiQFH1nMTizntZ0g8qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYmiPrvITkMdtLQkKk8Fmf49Z3gm5NiZTmOQEhWIELephdUIQ/SVsQQ2B7tfogovlGJr4h7Q08DesSG+IxAWUdnF/tMGBGfycdZe+vVmyYuI36bIkaSliW/12IglqDfmIkv0O2iCroklK3pecWtocAi0s/jW2/tcITpbZz5/yRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTFRA8wC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804F1C43390;
	Wed,  3 Apr 2024 21:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712178236;
	bh=2nXvlcysOJppAiAzRe5dRfX+OiQFH1nMTizntZ0g8qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTFRA8wCT+yBFtsOhYovAhWVriVq2017qU3+2eJmvWk6YL1oi/9AWW8P89MUISr8H
	 A1kdnXKnYYKHyTBAjgr7iSVqWRdI6/DJEJW3rapiJ4+lbHvCJTCc3/cRHla3dXQwOu
	 DWNjih7q/G1rZiXNxpGIIlK3+iBmiHWtgsMLy1ZfVtPyfVlInPRcjjXWzaDrztrZw2
	 V2FpkBzaAMXJPCTCaV7hx+5Ufj0YYI2DGX500uQ4xo4ujoxXtqkkWD0VZq6nQUAWoV
	 xV4RISDoMkyDTqLFESk3zOqoGRLPXAwEIx0RffQYKGQ90IgFztfDoM2lOeBdbuDTko
	 v6fFmaZmRRh7A==
Date: Wed, 3 Apr 2024 18:03:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf annotate: Initialize 'arch' variable not to
 trip some -Werror=maybe-uninitialized
Message-ID: <Zg3EOP7ovDge_F-I@x1>
References: <Zg1ywF7uRsfXYfYS@x1>
 <CAP-5=fUqtjxAsmdGrnkjhUTLHs-JvV10TtxyocpYDJK_+LYTiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUqtjxAsmdGrnkjhUTLHs-JvV10TtxyocpYDJK_+LYTiQ@mail.gmail.com>

On Wed, Apr 03, 2024 at 09:01:56AM -0700, Ian Rogers wrote:
> On Wed, Apr 3, 2024 at 8:16 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > In some older distros the build is failing due to
> > -Werror=maybe-uninitialized, in this case we know that this isn't the
> > case because 'arch' gets initialized by evsel__get_arch(), so just init
> > it to NULL to silence those cases.
> >
> > E.g.:
> >
> >     32    17.12 opensuse:15.5                 : FAIL gcc version 7.5.0 (SUSE Linux)
> >         util/annotate.c: In function 'hist_entry__get_data_type':
> >     util/annotate.c:2269:15: error: 'arch' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >       struct arch *arch;
> >                    ^~~~
> >     cc1: all warnings being treated as errors
> >
> >       43     7.30 ubuntu:18.04-x-powerpc64el    : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
> >     util/annotate.c: In function 'hist_entry__get_data_type':
> >     util/annotate.c:2351:36: error: 'arch' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >        if (map__dso(ms->map)->kernel && arch__is(arch, "x86") &&
> >                                         ^~~~~~~~~~~~~~~~~~~~~
> >     cc1: all warnings being treated as errors
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> This looks fine but I couldn't line up the errors with code in the
> tree. I was curious why the "maybe-uninitialized" was failing. Perhaps
> evsel__get_arch should set the out argument to NULL when an error
> occurs. This fix is also good but may potentially need repeating for
> other evsel__get_arch cases, so a fix in evsel__get_arch may be
> preferable.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Yeah, your suggestion is better and I just tested, satisfies the
compilers that were emitting this warning.

I stamped a:

Suggested-by: Ian Rogers <irogers@google.com>

and kept your Reviewed-by, ok?

- Arnaldo

