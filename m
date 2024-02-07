Return-Path: <linux-kernel+bounces-56111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A41784C60E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22084289E72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBFE200C7;
	Wed,  7 Feb 2024 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqXkiUHM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3561F208A0;
	Wed,  7 Feb 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293550; cv=none; b=oD7m6LUDPHzSyh6I9v2kgh7EA3/d4UgfShX5vREz2iVTmgTdYX61/wvtAJD+heH8PfM45a1EaHRGEYDmaaQzX/BXUoei4nx08sIx4S8a6yOU+lfIibbaKzDkv0Z8vupa3Uyypi6xDpmnxbv1V2fGfvs0Q12fOYmV4b8a/eoaYHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293550; c=relaxed/simple;
	bh=AAdXzGEYYLS3WCf+pmRelwyAZdDJfCvbli26C3mRFp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlMXViHhK/d8/7CtyD3UvzACk7/rildT5s2MsUUOANq6cyDvH0we2hAULFmRM3MMgq1707f9MR+TLex2NPQ7iHW9IosIdvRQfrY+JjODxEBntEAkE8eXTm/LF02z/BAHXWa5ftrrk1+45cCFN6e4SBGT9xIPAM2VZNqTt20/+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqXkiUHM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707293549; x=1738829549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AAdXzGEYYLS3WCf+pmRelwyAZdDJfCvbli26C3mRFp4=;
  b=aqXkiUHMtRqKwbvraPVX/0J1OAhcJJ5v+1ZwEyd93QPvtMPOvBYYlrsk
   rrbCOUN3P6kJberDIFh8yUFEzIV5s4+/kPV6EWpOBy6flCwFDn9gXFyII
   3+uT+zx0BYPgGpYSyM3ZbmrNli3SeyIjO6aIQwV4vioT6iuY12aXqeqss
   2NpDn6XCJ5RG/2K7zAt1rKudpi9EfOeUMwYkhs6G3bAYiOsF1UmLHGJSQ
   IA2p95b7NtLnrGazeMKpaFGzoTHS1nxHyLZdodrBwInvJ50JyXEsSvYVH
   mCKigzGjMeF7IRQUMC/NE1cjvdDDk/zjoY1mm6KhCrM6tns3err2ffE/d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23414274"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="23414274"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 00:12:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="24486640"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.151])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 00:12:23 -0800
Message-ID: <89127bd6-9ee1-4f19-9e02-f8c138295a3f@intel.com>
Date: Wed, 7 Feb 2024 10:12:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arch/x86/events/intel: Convert snprintf/sprintf to
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
 <20240126061319.245901-4-lizhijian@fujitsu.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240126061319.245901-4-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/24 08:13, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
>> ./arch/x86/events/intel/core.c:5614:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
>> ./arch/x86/events/intel/core.c:5623:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
>> ./arch/x86/events/intel/core.c:5605:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
>> ./arch/x86/events/intel/core.c:5651:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
>> ./arch/x86/events/intel/core.c:5571:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
> 
> Most of this patch is generated by:
> $ make coccicheck MODE=patch COCCI=scripts/coccinelle/api/device_attr_show.cocci M=arch/x86/events/intel | sed -n '6,$p' | patch -p1
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
> - Rebase to v6.8-rc1(Fix 2 newly introduced abused cases)
> - Extract patch from the patch set[1] so that maintainer accept it separately.
>  [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  arch/x86/events/intel/core.c         | 12 ++++++------
>  arch/x86/events/intel/pt.c           | 10 +++++-----
>  arch/x86/events/intel/uncore.c       |  2 +-
>  arch/x86/events/intel/uncore_snbep.c |  2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 3804f21ab049..7effb715dfaa 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5517,7 +5517,7 @@ static ssize_t freeze_on_smi_show(struct device *cdev,
>  				  struct device_attribute *attr,
>  				  char *buf)
>  {
> -	return sprintf(buf, "%lu\n", x86_pmu.attr_freeze_on_smi);
> +	return sysfs_emit(buf, "%lu\n", x86_pmu.attr_freeze_on_smi);
>  }
>  
>  static DEFINE_MUTEX(freeze_on_smi_mutex);
> @@ -5568,7 +5568,7 @@ static ssize_t show_sysctl_tfa(struct device *cdev,
>  			      struct device_attribute *attr,
>  			      char *buf)
>  {
> -	return snprintf(buf, 40, "%d\n", allow_tsx_force_abort);
> +	return sysfs_emit(buf, "%d\n", allow_tsx_force_abort);
>  }
>  
>  static ssize_t set_sysctl_tfa(struct device *cdev,
> @@ -5602,7 +5602,7 @@ static ssize_t branches_show(struct device *cdev,
>  			     struct device_attribute *attr,
>  			     char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
> +	return sysfs_emit(buf, "%d\n", x86_pmu.lbr_nr);
>  }
>  
>  static DEVICE_ATTR_RO(branches);
> @@ -5611,7 +5611,7 @@ static ssize_t branch_counter_nr_show(struct device *cdev,
>  				      struct device_attribute *attr,
>  				      char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%d\n", fls(x86_pmu.lbr_counters));
> +	return sysfs_emit(buf, "%d\n", fls(x86_pmu.lbr_counters));
>  }
>  
>  static DEVICE_ATTR_RO(branch_counter_nr);
> @@ -5620,7 +5620,7 @@ static ssize_t branch_counter_width_show(struct device *cdev,
>  					 struct device_attribute *attr,
>  					 char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%d\n", LBR_INFO_BR_CNTR_BITS);
> +	return sysfs_emit(buf, "%d\n", LBR_INFO_BR_CNTR_BITS);
>  }
>  
>  static DEVICE_ATTR_RO(branch_counter_width);
> @@ -5648,7 +5648,7 @@ static ssize_t pmu_name_show(struct device *cdev,
>  			     struct device_attribute *attr,
>  			     char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%s\n", pmu_name_str);
> +	return sysfs_emit(buf, "%s\n", pmu_name_str);
>  }
>  
>  static DEVICE_ATTR_RO(pmu_name);
> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index 8e2a12235e62..178238d096cd 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -96,7 +96,7 @@ static ssize_t pt_cap_show(struct device *cdev,
>  		container_of(attr, struct dev_ext_attribute, attr);
>  	enum pt_capabilities cap = (long)ea->var;
>  
> -	return snprintf(buf, PAGE_SIZE, "%x\n", intel_pt_validate_hw_cap(cap));
> +	return sysfs_emit(buf, "%x\n", intel_pt_validate_hw_cap(cap));
>  }
>  
>  static struct attribute_group pt_cap_group __ro_after_init = {
> @@ -150,11 +150,11 @@ pt_timing_attr_show(struct device *dev, struct device_attribute *attr,
>  
>  	switch (pmu_attr->id) {
>  	case 0:
> -		return sprintf(page, "%lu\n", pt_pmu.max_nonturbo_ratio);
> +		return sysfs_emit(page, "%lu\n", pt_pmu.max_nonturbo_ratio);
>  	case 1:
> -		return sprintf(page, "%u:%u\n",
> -			       pt_pmu.tsc_art_num,
> -			       pt_pmu.tsc_art_den);
> +		return sysfs_emit(page, "%u:%u\n",
> +				  pt_pmu.tsc_art_num,
> +				  pt_pmu.tsc_art_den);
>  	default:
>  		break;
>  	}
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 7927c0b832fa..b6bb3aa286fe 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -131,7 +131,7 @@ ssize_t uncore_event_show(struct device *dev,
>  {
>  	struct uncore_event_desc *event =
>  		container_of(attr, struct uncore_event_desc, attr);
> -	return sprintf(buf, "%s", event->config);
> +	return sysfs_emit(buf, "%s", event->config);
>  }
>  
>  struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index a96496bef678..553ba9422677 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3754,7 +3754,7 @@ static ssize_t skx_iio_mapping_show(struct device *dev,
>  	long die = (long)ea->var;
>  	struct intel_uncore_topology *pmut = pmu_topology(pmu, die);
>  
> -	return sprintf(buf, "%04x:%02x\n", pmut ? pmut->iio->segment : 0,
> +	return sysfs_emit(buf, "%04x:%02x\n", pmut ? pmut->iio->segment : 0,
>  					   pmut ? pmut->iio->pci_bus_no : 0);
>  }
>  


