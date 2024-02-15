Return-Path: <linux-kernel+bounces-66322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 390E1855A76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 301FEB225AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F32BA38;
	Thu, 15 Feb 2024 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WjNBhrru"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD01C02
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978759; cv=none; b=mSoNuDLJY/SbAke3SDEJUnuz4cBRfd6m1kAKBjhSYlxFN+E3qXaKZNcVsGyH4lw9cej8be41aES2HwuPmQHR8FLULkWbAg9BJOc16PpK4am30FFO1E7bWBbwGBNqXC3iihspAzaKnB1XCXtOxD85JeKD0Cu1uyxahcVgeQIjpEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978759; c=relaxed/simple;
	bh=QYgsrze2ItFZa7cOnhg+Cy2fQUPDqBnyOLxWMOv/dbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VseUj7rlmU/7+NO4jf0Mh6KtMCUpCO+SHOqVbq1GIljEiZZaoZdBQUPVqwiuofz18H6XI15yulsCiLBmXtk1aIUJmcwbUy4Z2TRMzbY9uTgBIeJoLgJ5cICRtkfm0OJ18TvpdMGtWGalwmORHC1iWjZSlVTy0/bMPpULk9CgLaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WjNBhrru; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Feb 2024 14:32:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707978754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QYgsrze2ItFZa7cOnhg+Cy2fQUPDqBnyOLxWMOv/dbA=;
	b=WjNBhrruJ37CnbDrPB/DQF+EHQIh+YeVP6uuJhMCtGcBqLgeKoifzgtvDXQAGPGuHJ3XlD
	PlHPu7w1cjEiqMVmDTlKZrbW81U3vgp1TrIyWvpdoS9tuMOFQQuMXaxxZs47Sf4GeLR8sO
	xji9sz4Fvy98M937HyjxU0rCkWKlqbY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>, Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ming Wang <wangming01@loongson.cn>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 0/4] perf parse-regs: Cleanup config and building
Message-ID: <20240215063224.GA99827@debian-dev>
References: <20240214113947.240957-1-leo.yan@linux.dev>
 <CAP-5=fXqdFrTDY2a2dXK1ehP2AbwPfPF8vYWXgeSMcKh4mS+ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXqdFrTDY2a2dXK1ehP2AbwPfPF8vYWXgeSMcKh4mS+ow@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 14, 2024 at 02:42:55PM -0800, Ian Rogers wrote:

[...]

> Thanks Leo, this is great cleanup! Series:
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks a lot for reviewing, Ian!

Leo

