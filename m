Return-Path: <linux-kernel+bounces-60012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BA584FE85
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D77C285EA6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035BD3613E;
	Fri,  9 Feb 2024 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Us0Uyhor"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED851C34;
	Fri,  9 Feb 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513032; cv=none; b=ixV9qDLuCjAh4Ks8g+uiQQvIx6f6acaLpeyHubC+AY/rm3/NMEb0Q1hyx06lq4Cce6P/AqSdDbM3h92/SsZdYtV+baNlzI3X43JlYulsXVzMELh7K8VG7t4lYo34rcCwbiZgYH7ZNPGi02P/Lh+Tv1JulJN7BpIpz63Tb/JiSLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513032; c=relaxed/simple;
	bh=UTi0h2ycj+oFBZj+dMWCDX4ZHwh89gcGHMCf1OfIwwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFAYFjl3oCw7wQ2YBCY0cVPM1Q+If9r6WQyVvvArzbfhtNkShWEe/Oy0kppZXQ6veIbFxG6cRNpP3xF2PhLNMsDaAi6ZmlRO8NYuJx1X3cM6LQHKq6MpfdAcpsVbXK/fW8Gercym32OQXNjspew3sFxONnyCoRvdR44tBYmWaiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Us0Uyhor; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707513031; x=1739049031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTi0h2ycj+oFBZj+dMWCDX4ZHwh89gcGHMCf1OfIwwQ=;
  b=Us0UyhorttjtXQAMO2KBkcHZttCuECcABMSaUEpKfJUvicdrVJL59EUh
   IE83Wz2yQhKQW5uoUF9iNJJJTUiUuli13wkD/sSj4qrJt5a2L3iP5jq7G
   5OQdiVgzETlzQ/JrVXvPg8qp9MkCKnKjnjFyv1HfidntAf6joLujFHw3P
   ZNatMb0DDRMvafaltImVBYHuoDZ4nsZkItkCHcGTlPlyT/uBtTjuhVBuC
   1Ia8lZJsJq2fnSfHCQQr7hDs0ZgetQ8p/uWl2p1whmH/yNGpuqR3geYTo
   d0bfnDwTCvr5e6O0JdtW30GQCsUBsQT4P8+30ryEVLk3GcgSLhNwiX9Dx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1382166"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1382166"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 13:10:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2243886"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 13:10:28 -0800
Date: Fri, 9 Feb 2024 13:10:27 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V5 01/12] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Message-ID: <ZcaUw4xQT0VcC7IO@tassilo>
References: <20240208113127.22216-1-adrian.hunter@intel.com>
 <20240208113127.22216-2-adrian.hunter@intel.com>
 <ZcVuK1nnxG18ps-a@tassilo>
 <d53ef26d-a7e6-4b3b-b593-be75425c0e77@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d53ef26d-a7e6-4b3b-b593-be75425c0e77@intel.com>

> The writes to rb->aux_in_pause_resume must be done
> only once.  It might be possible to get away without
> WRITE_ONCE(), but really the compiler should be informed
> not to make assumptions.

What stops the NMI from firing here?

> >> +  if (READ_ONCE(rb->aux_in_pause_resume))
> >> +	/* Guard against NMI, NMI loses here */
> >> +          goto out_restore;
<----------------------- NMI
> >> +  WRITE_ONCE(rb->aux_in_pause_resume, 1);


Even if it isn't racy it needs a clear comment.

-Andi



