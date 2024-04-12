Return-Path: <linux-kernel+bounces-142105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C428A2798
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C086EB23935
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E7151C27;
	Fri, 12 Apr 2024 07:04:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B151346426;
	Fri, 12 Apr 2024 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905465; cv=none; b=ZJrYrn9q8eRtbdMEF1rpq9krfPNfgRC5ypoB1TIZe8RRCKEs711N8PrVv001E42F65iC+WfaepSOeJxxXwMYSFqLL1rEMeNmfsxpYY4wv6Tu+GRI6JDffREuWSM1sipqqnKB/p0PFq2j0dcLYpGfqr9P9FavbdO6c/K8D2B0J38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905465; c=relaxed/simple;
	bh=NPk6rgF1oswR1NiTdymp30Tk9veSCrq0VLLrUxJTn2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aserABi8FgURGrvNVooGfcNHwghciR4BYBGgvN68ew1w6s6v5rOFvQBAv71rsY/KrMt2kO/fOxEMl271rsvRhpTMAwSUtLI1c+PF3+u02HQxf/eU2pDfGVI2Pi5VnDH9RG5Ho8nargOdQZO/1J6HqFARapgfqyVNUb4n2l8up88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E534B339;
	Fri, 12 Apr 2024 00:04:49 -0700 (PDT)
Received: from [10.162.42.6] (a077893.blr.arm.com [10.162.42.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9CF63F6C4;
	Fri, 12 Apr 2024 00:04:15 -0700 (PDT)
Message-ID: <5a4023aa-af9b-48d2-84f3-a0b9b30dc54e@arm.com>
Date: Fri, 12 Apr 2024 12:34:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Increase buffer size for Coresight basic tests
Content-Language: en-US
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org
Cc: Mike Leach <mike.leach@linaro.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240326113749.257250-1-james.clark@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240326113749.257250-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/26/24 17:07, James Clark wrote:
> These tests record in a mode that includes kernel trace but look for
> samples of a userspace process. This makes them sensitive to any kernel
> compilation options that increase the amount of time spent in the
> kernel. If the trace buffer is completely filled before userspace is
> reached then the test will fail. Double the buffer size to fix this.

This is a valid concern to address, but just wondering how did we arrive
at the conclusion that doubling the buffer size i.e making that 8M will
solve the problem positively for vast number of kerne build scenarios ?

> 
> The other tests in the same file aren't sensitive to this for various
> reasons, for example the iterate devices test filters by userspace
> trace only. But in order to keep coverage of all the modes, increase the
> buffer size rather than filtering by userspace for the basic tests.
> 
> Fixes: d1efa4a0a696 ("perf cs-etm: Add separate decode paths for timeless and per-thread modes")
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> index 65dd85207125..3302ea0b9672 100755
> --- a/tools/perf/tests/shell/test_arm_coresight.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -188,7 +188,7 @@ arm_cs_etm_snapshot_test() {
>  
>  arm_cs_etm_basic_test() {
>  	echo "Recording trace with '$*'"
> -	perf record -o ${perfdata} "$@" -- ls > /dev/null 2>&1
> +	perf record -o ${perfdata} "$@" -m,8M -- ls > /dev/null 2>&1
>  
>  	perf_script_branch_samples ls &&
>  	perf_report_branch_samples ls &&

