Return-Path: <linux-kernel+bounces-107634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97B987FF6F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A823B235DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42088175B;
	Tue, 19 Mar 2024 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIZVVBoQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F598120F;
	Tue, 19 Mar 2024 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710857871; cv=none; b=cF8FWpbyHBx/BHNysVddXFPqJV8MnNwbz4LQGRC/s7u0JgD6yb4AFqEV61FUvmbc5q3muMct41uH7Eb6e1/hGZeHFn1MIxBTJpv3TnQ6/l/BcFruuhTH2a9dHvtjs+O9GpCws09Gmsf5n3/ngohq+O4f/5EH7cMaGXXNqEP4+P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710857871; c=relaxed/simple;
	bh=Zeo3xa6Wim1i5dx56lNMKn/G39IRFtRUarZC1toA82Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE1oBYAQFI9jaxJRmIVAqMzIrO2ZQQsvtQ3/b5xj7+ZRHwf8kI1cu4JxltKgXGZ2xwb0pSYLygpnIFzvTMUI/i0rRodZ7IAEyHmcXNd9t+3RndNXBblERGXX7WMMnhpUPmRrgfEl22QtxkZ7fFryApM6+Y/fYRvAKZw+fWppYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIZVVBoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C50C433F1;
	Tue, 19 Mar 2024 14:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710857870;
	bh=Zeo3xa6Wim1i5dx56lNMKn/G39IRFtRUarZC1toA82Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIZVVBoQjbOsNuSe0G0TNLGcHJm6Z3LqNpfGMO1P/y7lwEy6lGeSBWmY03jmX+7lm
	 0cy+AKCrU+5l/B0NJh36lcYaKDz4ojAJTXXTM/S3mPwe+k8Axc5a65Cc0qiniVygUO
	 UlGBDZT3hWfuvuYOtlt2wcFsQnVU+SlTiMu9zjiZrnVxithqjAMgUFVoFIuf+YkNwB
	 +d+4zV/+wCapNo0jVBF2kvNWlGiABNgxYrvbKAeAmB74anzvGBfimmnz5ndrD2rMtN
	 nZ61uu716aoZEX/DGBpihDOOBV4aIV90RKobi0xqZIwJOPaebfxo0GQUwHPmyVltX2
	 IarcXfqEDtysg==
Date: Tue, 19 Mar 2024 11:17:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org,
	Ben Woodard <woodard@redhat.com>, Joe Mario <jmario@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	David Blaikie <blaikie@google.com>, Xu Liu <xliuprof@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Wielaard <mark@klomp.org>, Jason Merrill <jason@redhat.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	William Huang <williamjhuang@google.com>
Subject: Re: [PATCHSET 00/23] Remaining bits of data type profiling (v7)
Message-ID: <ZfmeiyKSM7gfqXL4@x1>
References: <20240319055115.4063940-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319055115.4063940-1-namhyung@kernel.org>

On Mon, Mar 18, 2024 at 10:50:52PM -0700, Namhyung Kim wrote:
> 
> Hello,
> 
> This is the last part of the data type profiling series.
> So far we added the basic pointer variable support, and direct access to
> global/local variables.  Now it's time to add instruction tracking. :)
> 
> For the history and background, you can refer to the previous version
> [1] and the LWN article [2].

Most of my comments are minor and can be addressed later, I've applied
in my local repo, will go thru the usual build tests and then I'll do
further usage tests.

Thanks,

- Arnaldo

