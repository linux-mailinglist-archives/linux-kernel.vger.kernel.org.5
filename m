Return-Path: <linux-kernel+bounces-136966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A57089DA67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE93B2346F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C61B130E39;
	Tue,  9 Apr 2024 13:33:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4306C130E2D;
	Tue,  9 Apr 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669606; cv=none; b=Wpe2jkL/t+cpz/5iBW9dvljuLuxv8MwG5mDokY4sxykaFuHKCwQE5CK/lAuwEYGofiw63cZAwyLMwY+PHR/0fnUsyJJzwyg9gl2Q9eReAmDJVafSnphrEKin4W1l9fffDE1E/PFzHWHxq9dnLaNh2qXyRMcvIbZMUdTOBXZIdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669606; c=relaxed/simple;
	bh=u4FR5Y+UEiIgK8eplC+h87f4MqY4iTWX06FqasbSRuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/zY7ejd/cE4Fodulanb2z4WtCOUCu+zd9LyrzSTDm1B6L3dBmrKUtPxhZlssiumIh+cvcwssn1+wUl5WDb7qlU6hleS6SRN4nf3WGhqeYt6SLHyH73MYaB9w0wsPg+8w7ZWRkBixtKbUawOFkjOPqgIMlWc1KhF+7dluygHNpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C409139F;
	Tue,  9 Apr 2024 06:33:53 -0700 (PDT)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A97F3F766;
	Tue,  9 Apr 2024 06:33:19 -0700 (PDT)
Message-ID: <3df74a0a-6778-43c4-a8c2-70d71c324f6a@arm.com>
Date: Tue, 9 Apr 2024 14:33:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events arm64: AmpereOne/AmpereOneX: Mark
 L1D_CACHE_INVAL impacted by errata
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
References: <20240408214022.541839-1-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240408214022.541839-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/04/2024 22:40, Ilkka Koskinen wrote:
> L1D_CACHE_INVAL overcounts in certain situations. See AC03_CPU_41 and
> AC04_CPU_1 for more details. Mark the event impacted by the errata.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json  | 4 +++-
>  tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> index 7a2b7b200f14..ac75f12e27bf 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> @@ -9,7 +9,9 @@
>          "ArchStdEvent": "L1D_CACHE_REFILL_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_INVAL"
> +        "ArchStdEvent": "L1D_CACHE_INVAL",
> +        "Errata": "Errata AC03_CPU_41",
> +        "BriefDescription": "L1D cache invalidate. Impacted by errata -"
>      },
>      {
>          "ArchStdEvent": "L1D_TLB_REFILL_RD"
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json
> index c50d8e930b05..f4bfe7083a6b 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json
> @@ -9,7 +9,9 @@
>          "ArchStdEvent": "L1D_CACHE_REFILL_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_INVAL"
> +        "ArchStdEvent": "L1D_CACHE_INVAL",
> +        "Errata": "Errata AC04_CPU_1",
> +        "BriefDescription": "L1D cache invalidate. Impacted by errata -"
>      },
>      {
>          "ArchStdEvent": "L1D_TLB_REFILL_RD"

Reviewed-by: James Clark <james.clark@arm.com>

