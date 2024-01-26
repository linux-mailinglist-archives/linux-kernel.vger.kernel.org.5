Return-Path: <linux-kernel+bounces-40332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D00383DEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6F81B24179
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0031DA30;
	Fri, 26 Jan 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRuSvS9x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F11D6BE;
	Fri, 26 Jan 2024 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286334; cv=none; b=OUJ2FvgUKOXKetThMK4zRtYeEntbIPNJUBwwg8FEAhYWhFw0TCKeq25jCEk1hxg+FkLk/y7/E2AFdrIrzMG8MrYR57V2/RDmSytjyx8Dek6dkWFKpFr3T1y+vraU6QiVXxm8Q5XT4mEWxnr7X0G9TiMMB1YrquF/aHxjPh5I7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286334; c=relaxed/simple;
	bh=DfiRLIgoHi+38BtPH3e3fTQLMA+gmNR/PlVDe0aSLE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTI0AH1ZP3dqVGFczwixgKwgdvNIj+BsEEeZstqxXCHv2zskG6byjrYlHa16ZeOtfR6izvZAGDSe4dNSxWjLAxfRGciBgVYFXS9e1tEqFLV/hhI13GOvEZrwnIL4VkRbWiY/Ql4z13wKy2OS6ozen09/4d71BMOljAU89UNZEi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRuSvS9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9C7C43399;
	Fri, 26 Jan 2024 16:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706286333;
	bh=DfiRLIgoHi+38BtPH3e3fTQLMA+gmNR/PlVDe0aSLE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRuSvS9x/ormIZak+Jk7Smge4qyqYrGWGsPT0Ssq3xD6YwTLemD861CFKeMhfaelk
	 +H10YzOrhQvtRuLzeW2TcV1LEwRSHqZGhd9TQa1tY7UJBsZ4upPSPCjQ/N1nnLRxcD
	 YN+U8pdtHDroTkuz7dwXN4YPQcHDTcWoKzuX95U2wcuQUmO9otv7s7TYlw3LjW9OgO
	 jlNjoXkb+dBZHGJ0uMwlYqIpFJSm3MneJbQ1mYpHWXQ1psJNpm/x0Q3rqNGV23qNHo
	 Jj1Oss9R5C/VC/KfaQbXYqneahf5tQ9ahmcxBnT2bPS+taGXdqqsL4EenHmuGpxjFx
	 oNwAb33+MyIjg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 23DFE40441; Fri, 26 Jan 2024 13:25:31 -0300 (-03)
Date: Fri, 26 Jan 2024 13:25:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
	irogers@google.com, kan.liang@linux.intel.com, mark.rutland@arm.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Changbin Du <changbin.du@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf evlist: Fix evlist__new_default() for > 1 core
 PMU
Message-ID: <ZbPc-1sqFgb7dJlF@kernel.org>
References: <20240123102728.239147-1-james.clark@arm.com>
 <20240123103918.241423-1-james.clark@arm.com>
 <CAM9d7ciSY25Jf-MG24NWJu3aKJWXT2GN43qrV5WCuohLNZn1iw@mail.gmail.com>
 <ea054381-6ba2-d2f6-8de4-978a78a2ed8b@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea054381-6ba2-d2f6-8de4-978a78a2ed8b@arm.com>
X-Url: http://acmel.wordpress.com

Em Wed, Jan 24, 2024 at 09:03:57AM +0000, James Clark escreveu:
> On 24/01/2024 00:46, Namhyung Kim wrote:
> > On Tue, Jan 23, 2024 at 2:39 AM James Clark <james.clark@arm.com> wrote:
> >> +++ b/tools/perf/util/evlist.c
> >> @@ -106,6 +106,13 @@ struct evlist *evlist__new_default(void)
> >>                 evlist = NULL;
> >>         }

> >> +       if (evlist->core.nr_entries > 1) {

> > I think you need a NULL check for evlist here.
 
> Oops yes. Or just return on the error above.

Was there a v4? I'm assuming this is for perf-tools, i.e. for v6.8-rc,
right?

- Arnaldo

