Return-Path: <linux-kernel+bounces-56105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 174D384C604
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82E12879F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248582031D;
	Wed,  7 Feb 2024 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QsOol7db"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514F20316
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293424; cv=none; b=hjlf5MOHVndnF1vv0uQbS/dykbnsp2feh7Labq7woB8MjDwY8sOelybJ0B8wR9SRN79ckxwadvwWRyg1XM7j7Ne9tGHGsjXp+LlxpAFTS9fAGe0YUwICQpD2gMLZYB5iEm2sRQFC1u6ryIpp43uEKkY94I+teF+VbyE9M9TcODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293424; c=relaxed/simple;
	bh=7/lX6dIXaCLE51LE4HoUaSmAKTIFzVPPeiE+TB2kTYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAgIDMUC6Blr6t0IHJpeG8BR1Sxavsy/blhdGVSjVUTQN6d6SVWcspYdMJvdRI1pjeX72KH5rhvONgVn5F5VM/YOhjubCoyIgjiZ/Jwdl88bQQaROzldnSFnfhkSYV3IOE/rWluCMeMck7aIYLllid7ODjM/13WAN6I2jqvWp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QsOol7db; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707293423; x=1738829423;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7/lX6dIXaCLE51LE4HoUaSmAKTIFzVPPeiE+TB2kTYs=;
  b=QsOol7dbDPzW8phfdFpVcAO3/mvZidj5wCqem5ttymB31avLhGQGJWiC
   jyXra2X0ehizYvTBu5fHQwyYyIT+hj1eyZz+yMDGVK905T72QQ6wuyeDB
   RfTaLTG/VQTQS0toYZqWx+8KiCmW4LL4fY+hKTE2DdN74Sg3FvkKZZHlK
   szx3pSrxhG02fBA+dyY36/sFqo2lQSYhrfYwsSWjYpcxLpNz/UWL5mEmn
   FasKfk7TUvdAVFP9D0yK5IXmvpJOWPHwkR6pJ9Bv/CFRlF8SrfaAEBwLr
   /Iqm78PJ2lss0pZ8BhLIpQfX+nqsBsRgF3qNpqrO+x1UOnjntnEGAlU3+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23413902"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="23413902"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 00:10:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="24486216"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.151])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 00:10:15 -0800
Message-ID: <b58f11c0-b240-4cfb-ada1-37ab16b9c333@intel.com>
Date: Wed, 7 Feb 2024 10:10:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arch/x86/events/amd: Convert snprintf/sprintf to
 sysfs_emit
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20240126061319.245901-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240126061319.245901-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/24 08:13, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
>> ./arch/x86/events/amd/core.c:1282:8-16: WARNING: please use sysfs_emit
> 
> This patch is generated by
> $ make coccicheck MODE=patch COCCI=scripts/coccinelle/api/device_attr_show.cocci M=arch/x86/events/amd | sed -n '6,$p' | patch -p1
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
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> V2: extract patch from the patch set[1] so that maintainer can accept it separately.
> [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
> ---
>  arch/x86/events/amd/core.c  | 2 +-
>  arch/x86/events/amd/iommu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 81f6d8275b6b..0d520592010c 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -1279,7 +1279,7 @@ static ssize_t branches_show(struct device *cdev,
>  			      struct device_attribute *attr,
>  			      char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
> +	return sysfs_emit(buf, "%d\n", x86_pmu.lbr_nr);
>  }
>  
>  static DEVICE_ATTR_RO(branches);
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index b15f7b950d2e..1126bda96d8f 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
> @@ -89,7 +89,7 @@ static ssize_t _iommu_event_show(struct device *dev,
>  {
>  	struct amd_iommu_event_desc *event =
>  		container_of(attr, struct amd_iommu_event_desc, attr);
> -	return sprintf(buf, "%s\n", event->event);
> +	return sysfs_emit(buf, "%s\n", event->event);
>  }
>  
>  #define AMD_IOMMU_EVENT_DESC(_name, _event)			\


