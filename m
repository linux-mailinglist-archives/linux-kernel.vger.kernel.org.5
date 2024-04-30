Return-Path: <linux-kernel+bounces-164705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345858B8160
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C491C24041
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196971A0B14;
	Tue, 30 Apr 2024 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uY7WAUIW"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA41A0B0E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714508822; cv=none; b=VJXreZPwBRWC6c8udXQMkAq9czSZnWY4RpOPNlT75pfHVC5kMoWhVT8Sxr0PILyjPb9svfWV8eAHnAfmdROjpdjXsxVsfXfrhqFhRHQOAgQFv8vgyXdtlOscIdZbUJESuHeo8WH7z/33f/LTdoS+mY7e3yW8UnEklfKgFY0W4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714508822; c=relaxed/simple;
	bh=O0dijEzBvtORi6qxxVsNfbPFj60dzy82Go7ZwEcpV80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEehPE4j6FTXvYe/wdudQnLWxGz04aXk5q/UzT8ZMfXkwbBy2t4yGGWGhPmBK3bCQDTDuRYd1qaajkY/e6+JInC5fCtGpz5OPN++UT7nwEz1IUF0JBNItX6ZerNg0WELDl5ANcvRDXfa8HxxD5NUKo80yumbvzn1BYyyV+ne4kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uY7WAUIW; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 May 2024 04:26:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714508818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBs0/PKerC5E91/aTpLb+GbSC+0huj5ORJCxMwxzVLs=;
	b=uY7WAUIWDf0+MAwCB2nxSOUXfZ1mt399RKX5YKsZlnTraZMsSNsV51693TtBg3H+3K+dnY
	J3O6mzN+XesTUUjlJo8Fs5h8wu8WDE0PrQsM1PIiGBUMnJDT5OP0XtsZaABwyx2B+Z3W9z
	Xvx3OUhz7U8D7ZqP03uCN35G4TiIwr4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"james.clark@arm.com" <james.clark@arm.com>,
	"mike.leach@linaro.org" <mike.leach@linaro.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>,
	"alisaidi@amazon.com" <alisaidi@amazon.com>,
	Vikram Sethi <vsethi@nvidia.com>, Rich Wiley <rwiley@nvidia.com>,
	Yifei Wan <YWan@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>, Sean Kelley <skelley@nvidia.com>
Subject: Re: [PATCH v1 0/3] arm64: Support Neoverse-V2 for Perf Arm SPE
Message-ID: <20240430202655.GF125@debian-dev>
References: <20240109192310.16234-1-bwicaksono@nvidia.com>
 <SJ0PR12MB5676F0DC2CFBBC96534CDD65A0092@SJ0PR12MB5676.namprd12.prod.outlook.com>
 <SJ0PR12MB56767ECAF499949C4689E91BA01A2@SJ0PR12MB5676.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR12MB56767ECAF499949C4689E91BA01A2@SJ0PR12MB5676.namprd12.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 30, 2024 at 05:50:40PM +0000, Besar Wicaksono wrote:
> Hi Arnaldo,
> 
> Could you take these changes for perf?
>   [2/3] tools headers arm64: Add Neoverse-V2 part
>   [3/3] perf arm-spe: Add Neoverse-V2 to neoverse list

Thanks for bringing up this.

I confirmed this patch series can be cleanly applied on the mainline
kernel, so the above two patches look good to me.

Thanks,
Leo

