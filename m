Return-Path: <linux-kernel+bounces-56110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDB284C60C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA2D28866E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60BD200CD;
	Wed,  7 Feb 2024 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkbHQodi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF7208C4;
	Wed,  7 Feb 2024 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293508; cv=none; b=bYWTwoZ12MxYWSGIF3aou1ZJZWK7HYU18UmatR/6RY/hh+hSSn/tfi5a10YUPSQt0jdprJ/+V6Mwdb8yUsrr/PDpi/Z0HX+Ncm50vurwJYvzERETRoz7eXE+sRZYj3zOonPJMRp1BBMr1jjy7FZDjfdUssXqg9trSFeouudLLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293508; c=relaxed/simple;
	bh=Wuu/2bXsqEnbj15BImmH4AnU7E32dLuoyv691c7JwMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/7MrXHbBEhLtKUUHa3j54TvfmK23rleE6WPmU95AIS4gitxSAl5lAFMQGEi2QenNqM5IH3fTmPyZ3BBpXgc+a1V7zHLHnuRYiEztRcVVxe+Qs0xGGg0W5zhEONx0hrSBQFgdJIKCAUKWjoIobvqrDSHvgz3t86xolE33CAd2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkbHQodi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707293507; x=1738829507;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wuu/2bXsqEnbj15BImmH4AnU7E32dLuoyv691c7JwMw=;
  b=JkbHQodikqXxWdpR5r9ei4OXPUjN8WF3u/BZyWNozXw86HaJlJebbix0
   LBks7WsJr9VMMdBlJKmU79mPkqmfiSSOta8Tqb+wU/nLa55uzmSURgSoQ
   rRWJ32I/TRvs/toJbCGKlSV9T8K+MImPEVfnyYNamWgVb9nVAj7v5cXck
   h/9QsWiWsGIbsh/Xm+ivNaVR8/EeSnD5TefOx3HnbQ6LiyW1oVXvF2bQm
   ZZhG0cixffcyh8U/X6PJZL+kcGqxeBXGocH1CnGWn5JVYs4naK07GCBdA
   amzfoG7OBb4JQ0qHHtGVCYBt/VieuhaB5kOKPvdp+DcqKOcSAHI6jvBnL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23414102"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="23414102"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 00:11:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="24486521"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.151])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 00:11:41 -0800
Message-ID: <855fdeec-c590-4fef-b917-ced3ec39ab3a@intel.com>
Date: Wed, 7 Feb 2024 10:11:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arch/x86/events/core: use scnprintf to print
 sub-string
Content-Language: en-US
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org
References: <20240126061319.245901-1-lizhijian@fujitsu.com>
 <20240126061319.245901-3-lizhijian@fujitsu.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240126061319.245901-3-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/24 08:13, Li Zhijian wrote:
> sysfs_emit is not suitable to to print a substring, convert it to scnprintf

'to to' -> 'to'

> to make coccicheck happy.
> 
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Arnaldo Carvalho de Melo <acme@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> CC: Jiri Olsa <jolsa@kernel.org>
> CC: Namhyung Kim <namhyung@kernel.org>
> CC: Ian Rogers <irogers@google.com>
> CC: Adrian Hunter <adrian.hunter@intel.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Borislav Petkov <bp@alien8.de>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: x86@kernel.org
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: linux-perf-users@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> V2: new patch address coccinelle warning
> ---
>  arch/x86/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 20d963196e4c..5ed2ba16c6c0 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1892,7 +1892,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
>  		if (x86_pmu.hybrid_pmu[i].pmu_type & pmu->pmu_type) {
>  			next_str = strchr(str, ';');
>  			if (next_str)
> -				return snprintf(page, next_str - str + 1, "%s", str);
> +				return scnprintf(page, next_str - str + 1, "%s", str);
>  			else
>  				return sysfs_emit(page, "%s", str);
>  		}


