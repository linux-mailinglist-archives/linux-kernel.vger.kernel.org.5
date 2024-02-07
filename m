Return-Path: <linux-kernel+bounces-56107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0005A84C608
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68335B245B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594802030B;
	Wed,  7 Feb 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neznKzr5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA0200AD;
	Wed,  7 Feb 2024 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293461; cv=none; b=VopBhpiPnm0h6FNoXqhHVujjsJ96wSD1I80twHI1QE/g9ZeNqgQ7y4yIMoR8FuO8YcaJmgQOizwpwa66iopF3+lOEF4a/VcxZSS4LMrd9ZMg2hpUpTaspYT5b9xHMI3cLqYh4QaDsDN/eq6UuDidsSp61GMQqQuPj3zjSP8rc8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293461; c=relaxed/simple;
	bh=WWW+c5tu4S/MBXxMtlC14ZlKqLEhduiv8dwYZ1sxo7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtndNjj8+n8LLWiWOg5bxWBHYDR4HnTU4b6cbjjpInjHMcGaXZGaB/26iuZVKs2BCwG7puzYLyIb2Pkg6+ZQ/8GItH9lVX1/JAoelnG5G8jF4W8MT9h7w1qKZfgrmBnGLcLKrE530Gbh2bCHrL7S2rE1/vtbm6BsVjMf1C2QhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neznKzr5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707293460; x=1738829460;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WWW+c5tu4S/MBXxMtlC14ZlKqLEhduiv8dwYZ1sxo7Y=;
  b=neznKzr5cA8MUDSqErgu2OVeK+9RmP/Cfno09IdEPerugUq4J/BTDv3B
   YVwmGNXSxt3gVAm2XLt5s6IXnYee91gYWs8G9O47Bt7JVT1SDxNtbAtiq
   gecjUSRiSjQtdkJH+o5zyhe/3ZEFunNOSnpmKq5WtsqlEz2C6vnSV8CEz
   szF5KzEoXf9tD2mM255SxNkrC+7lhwJjvdUIw7oi2wq/OGUw9IX540IHG
   LeYtaeC54GQApAA0TQQK15cJZHcv/P04Nt6Wpkk9Yx+OTBYYChXTmSkfC
   NE/BWnUhFGW+Xck0c3ZdHCF0x78dLPvbUmSC6UDmaECJ7wfjM23/JCWWV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23413966"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="23413966"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 00:10:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="24486370"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.151])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 00:10:53 -0800
Message-ID: <1b1a8514-e74f-439f-a3ab-ad19dda49c22@intel.com>
Date: Wed, 7 Feb 2024 10:10:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arch/x86/events/core: Convert sprintf/snprintf to
 sysfs_emit
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
 <20240126061319.245901-2-lizhijian@fujitsu.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240126061319.245901-2-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/24 08:13, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
>> ./arch/x86/events/core.c:1895:11-19: WARNING: please use sysfs_emit
>                            ^^^^^ this one cannot convert to sysfs_emit
>                                  where it intends to print a sub-string.
> 
>> ./arch/x86/events/core.c:2542:8-16: WARNING: please use sysfs_emit
>> ./arch/x86/events/core.c:2600:8-16: WARNING: please use sysfs_emit
> 
> Most of this patch is generated by:
> $ make coccicheck MODE=patch COCCI=scripts/coccinelle/api/device_attr_show.cocci M=arch/x86/events/core.c | sed -n '6,$p' | patch -p1
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

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> V2:
> - Address Adrian's comment:
>   leave "snprintf(page, next_str - str + 1, "%s", str)" alone, it
>   intends to print a sub-string, that cannot covert to sysfs_emit simply.
> -
> V2: extract patch from the patch set[1] so that maintainer accept it separately.
> [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  arch/x86/events/core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 09050641ce5d..20d963196e4c 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1832,7 +1832,7 @@ ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr, cha
>  
>  	/* string trumps id */
>  	if (pmu_attr->event_str)
> -		return sprintf(page, "%s\n", pmu_attr->event_str);
> +		return sysfs_emit(page, "%s\n", pmu_attr->event_str);
>  
>  	return x86_pmu.events_sysfs_show(page, config);
>  }
> @@ -1855,7 +1855,7 @@ ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
>  	 * if they are owned by some other guest.  The user tool
>  	 * has to re-read when a thread sibling gets onlined later.
>  	 */
> -	return sprintf(page, "%s",
> +	return sysfs_emit(page, "%s",
>  			topology_max_smt_threads() > 1 ?
>  			pmu_attr->event_str_ht :
>  			pmu_attr->event_str_noht);
> @@ -1872,7 +1872,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
>  	int i;
>  
>  	if (hweight64(pmu_attr->pmu_type) == 1)
> -		return sprintf(page, "%s", pmu_attr->event_str);
> +		return sysfs_emit(page, "%s", pmu_attr->event_str);
>  
>  	/*
>  	 * Hybrid PMUs may support the same event name, but with different
> @@ -1894,7 +1894,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
>  			if (next_str)
>  				return snprintf(page, next_str - str + 1, "%s", str);
>  			else
> -				return sprintf(page, "%s", str);
> +				return sysfs_emit(page, "%s", str);
>  		}
>  		str = strchr(str, ';');
>  		str++;
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


