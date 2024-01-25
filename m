Return-Path: <linux-kernel+bounces-38728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C4883C4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C488E1C2475B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904636E2B9;
	Thu, 25 Jan 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrhpNdaS"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669A6E2D0;
	Thu, 25 Jan 2024 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193267; cv=none; b=JZ9YUbgUxGe5MI9STRcHpC3R+TeQK1/weoykaWX04QWNawaACaxKk8S0Ge5ofvCsJM/rdRoe7Xy0M4rsdfP4NevmFLFgXHvrXnhCJjVjp7nUgvetH7zJCScebvT+rXUz3jzQ6cqO6P6HlHBbh961v02skTwXUvWqg1+75Mf4sIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193267; c=relaxed/simple;
	bh=Vd0x1kY54QPZtj97cg5M3RjCoccZzQjOZTpbb5617AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAa+X+sUvKdhgwulp16miSqGoagGETelPa+XLWP/i+TxgMVHT8DQawpRDHn17mLpcPx+/hWG9x6Uxgz8VbEG5TfNF8SUDsS/5HVoLPykEZD/80LZn9D6/+XiSS5N5ZAngrN1fW1YOHSH1S+dk4vNVz97VRG99qI8BnIVpwOMTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrhpNdaS; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706193266; x=1737729266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vd0x1kY54QPZtj97cg5M3RjCoccZzQjOZTpbb5617AI=;
  b=VrhpNdaSorJ8OHKvOJVZajF8hNHN/HM/2UDqEcSYEp7FsnaznTDXiFEG
   Pqk5rFV2k3m52g8pq2Pgu6e2fC+MIiTgc/jg6cOecJCIdlBAK53BPJUyy
   NzMBEwX2InpxHwlVTQV8ygLxMwoPoIcDqGZAf8dvjSPmf5l0WPuQLdiHb
   R0U6aLLW3DKl0dCaGXxB0bIDkEWOvYhdhVRQ9T+GhqDHw8BVoVcgprVuv
   9xgXYs1D+Cc6bOnq9HREwdkLepr/dLvcitNVd/TsxT2LEbXMuuPSRlIWl
   EYnLdlFU5/hVQFUwT6Xu8v9wIWHSUwcspgMngyPEJOWEvheYQbi04s/zs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401827557"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401827557"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 06:34:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2438122"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 06:34:08 -0800
Date: Thu, 25 Jan 2024 06:35:33 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] cacheinfo: Check for null last-level cache info
Message-ID: <20240125143533.GA16226@ranerica-svr.sc.intel.com>
References: <20231212222519.12834-1-ricardo.neri-calderon@linux.intel.com>
 <20231212222519.12834-2-ricardo.neri-calderon@linux.intel.com>
 <20240125111544.xhiomitgeazxm7cw@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125111544.xhiomitgeazxm7cw@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Jan 25, 2024 at 11:15:44AM +0000, Sudeep Holla wrote:
> On Tue, Dec 12, 2023 at 02:25:16PM -0800, Ricardo Neri wrote:
> > Before determining the validity of the last-level cache info, ensure that
> > it has been allocated. Simply checking for non-zero cache_leaves() is not
> > sufficient, as some architectures (e.g., Intel processors) have non-zero
> > cache_leaves() before allocation.
> > 
> > Dereferencing NULL cacheinfo can occur in update_per_cpu_data_slice_size().
> > This function iterates over all online CPUs. However, a CPU may have come
> > online recently, but its cacheinfo may not have been allocated yet.
> > 
> > Cc: Andreas Herrmann <aherrmann@suse.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Chen Yu <yu.c.chen@intel.com>
> > Cc: Huang Ying <ying.huang@intel.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Radu Rendec <rrendec@redhat.com>
> > Cc: Pierre Gondois <Pierre.Gondois@arm.com>
> > Cc: Pu Wen <puwen@hygon.cn>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> 
> If you respin, you can address the below minor nit. I am fine as is as
> well.
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Thank you for your review Sudeep!

> 
> [...]
> 
> > diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> > index f1e79263fe61..967c5cf3fb1d 100644
> > --- a/drivers/base/cacheinfo.c
> > +++ b/drivers/base/cacheinfo.c
> > @@ -61,6 +61,9 @@ bool last_level_cache_is_valid(unsigned int cpu)
> >  	if (!cache_leaves(cpu))
> >  		return false;
> >  
> > +	if (!per_cpu_cacheinfo(cpu))
> > +		return false;
> > +
> 
> [nit] You can even combine this with above if condition.

Sure, I can take care of this if a new version is needed as per feedback
from the x86 maintainers.

