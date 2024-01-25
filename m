Return-Path: <linux-kernel+bounces-38494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CD583C09F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8FA289A06
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31B82D630;
	Thu, 25 Jan 2024 11:15:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DECD28DC4;
	Thu, 25 Jan 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706181354; cv=none; b=tzATanpQmsuccSM/S+JRGSaVC+9/T4DHUSrwiGHalmrG5OBARKV2HdiwlvwZeSs8LPUKQ+OZWZgt5Jtq4OhYVSy8VXz9DPvgWz/DOjhSxVwSkX6pnqcjH/GQUDVc4oqBmxFEwGjcptxrACEbhrlaJ+YLKXh0X4eiT9foCA01ENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706181354; c=relaxed/simple;
	bh=LoZQkUCiJrTcqIGsEcCsADbEl/lrWM+ebsBNPEVB6YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHHM13aHvkuZEDvfxCwHoHzWj++QPQSWF4Q2T2WjeCNLV2wn1T/jqyCt1wD/0RaykUxXcg9uyzhBs5osJvgPgmKFmp6zMOcW6ROKNzsngYJUyNqmBrbWu/c5afLnCrecGHq7DURgI4VtpfHcvqyZn51c/wVb8ROAQljRX/zsuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF1841FB;
	Thu, 25 Jan 2024 03:16:35 -0800 (PST)
Received: from bogus (unknown [10.57.78.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A5E73F73F;
	Thu, 25 Jan 2024 03:15:47 -0800 (PST)
Date: Thu, 25 Jan 2024 11:15:44 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
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
Message-ID: <20240125111544.xhiomitgeazxm7cw@bogus>
References: <20231212222519.12834-1-ricardo.neri-calderon@linux.intel.com>
 <20231212222519.12834-2-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212222519.12834-2-ricardo.neri-calderon@linux.intel.com>

On Tue, Dec 12, 2023 at 02:25:16PM -0800, Ricardo Neri wrote:
> Before determining the validity of the last-level cache info, ensure that
> it has been allocated. Simply checking for non-zero cache_leaves() is not
> sufficient, as some architectures (e.g., Intel processors) have non-zero
> cache_leaves() before allocation.
> 
> Dereferencing NULL cacheinfo can occur in update_per_cpu_data_slice_size().
> This function iterates over all online CPUs. However, a CPU may have come
> online recently, but its cacheinfo may not have been allocated yet.
> 
> Cc: Andreas Herrmann <aherrmann@suse.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Radu Rendec <rrendec@redhat.com>
> Cc: Pierre Gondois <Pierre.Gondois@arm.com>
> Cc: Pu Wen <puwen@hygon.cn>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

If you respin, you can address the below minor nit. I am fine as is as
well.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

[...]

> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index f1e79263fe61..967c5cf3fb1d 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -61,6 +61,9 @@ bool last_level_cache_is_valid(unsigned int cpu)
>  	if (!cache_leaves(cpu))
>  		return false;
>  
> +	if (!per_cpu_cacheinfo(cpu))
> +		return false;
> +

[nit] You can even combine this with above if condition.

-- 
Regards,
Sudeep

