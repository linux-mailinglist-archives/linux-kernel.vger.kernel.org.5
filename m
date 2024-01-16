Return-Path: <linux-kernel+bounces-27051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4990A82E9C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD4A8B2305C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1A910A24;
	Tue, 16 Jan 2024 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJAzYh9q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E551D11181;
	Tue, 16 Jan 2024 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705388535; x=1736924535;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l77E4YgBgyvd0pSOaDBIh2Qs/NWQYKT4yc/7wy9bI7c=;
  b=gJAzYh9qSERmpPg+fytFsTtkjqktopH3nsNSSNUwtFQ4q6/4J8ag7G9e
   HH/cVFnTw3muLotOCfpuVj9/XK0Ttl2XxNaSuznF3DUsZ36/azQQlf9gH
   yHgWIyOVVqhNFKzX5Bi7ypDC2cF99KjQ1E1Tp9vPpcXTzRr959q6Y7kcU
   5DuOdjE2Z2IhfUainwNn6T/PuHX5MD/R2edfTZpUcubD50in3VrP6iTkI
   Sh/ia5ZJujcXOCM1wyE7JxtVJmrE1KWYg3l/J80rRv87hngRMetbYK7VX
   I3+FeFfOyI2ARUobUEL52EsCMmzZazlJE2uM1Ue/acr+g9ncFj2WXOqTL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="18370739"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="18370739"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 23:02:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="818067712"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="818067712"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.159])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 23:01:35 -0800
Message-ID: <c9a3f5b7-4f81-4d24-835b-c365d7d61995@intel.com>
Date: Tue, 16 Jan 2024 09:01:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/42] arch/x86/events/core: Convert snprintf to
 sysfs_emit
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
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-2-lizhijian@fujitsu.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240116045151.3940401-2-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/24 06:51, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
>> ./arch/x86/events/core.c:1895:11-19: WARNING: please use sysfs_emit
>> ./arch/x86/events/core.c:2542:8-16: WARNING: please use sysfs_emit
>> ./arch/x86/events/core.c:2600:8-16: WARNING: please use sysfs_emit
> 
> No functional change intended
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
> ---
>  arch/x86/events/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 40ad1425ffa2..52e5707be03b 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1892,7 +1892,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
>  		if (x86_pmu.hybrid_pmu[i].pmu_type & pmu->pmu_type) {
>  			next_str = strchr(str, ';');
>  			if (next_str)
> -				return snprintf(page, next_str - str + 1, "%s", str);
> +				return sysfs_emit(page, "%s", str);

The intention seems to be to print only up to, and not including, the next ';',
but sysfs_emit() is not going to do that.

>  			else
>  				return sprintf(page, "%s", str);
>  		}
> @@ -2539,7 +2539,7 @@ static ssize_t get_attr_rdpmc(struct device *cdev,
>  			      struct device_attribute *attr,
>  			      char *buf)
>  {
> -	return snprintf(buf, 40, "%d\n", x86_pmu.attr_rdpmc);
> +	return sysfs_emit(buf, "%d\n", x86_pmu.attr_rdpmc);
>  }
>  
>  static ssize_t set_attr_rdpmc(struct device *cdev,
> @@ -2597,7 +2597,7 @@ static ssize_t max_precise_show(struct device *cdev,
>  				  struct device_attribute *attr,
>  				  char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise());
> +	return sysfs_emit(buf, "%d\n", x86_pmu_max_precise());
>  }
>  
>  static DEVICE_ATTR_RO(max_precise);


