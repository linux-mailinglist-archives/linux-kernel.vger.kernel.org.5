Return-Path: <linux-kernel+bounces-53875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A9484A785
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39FF1C271F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227898562D;
	Mon,  5 Feb 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEIAfj6h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10B184A31;
	Mon,  5 Feb 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162803; cv=none; b=bk39IRTfa83CIb4G+RTsZ1bq7FhrXuLHqsesF/nGV1l2PMkkufGVPajGYga0knPApuzejzwVjrwFE6b22c9kliovilDxX9cYzOM/Sy4pg6z4lwDzxjHzsWa2cUQM8XQz67H4dp+0sX5x34A2gDWPZG9xjkSOxX28JVgUHWnH/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162803; c=relaxed/simple;
	bh=MKOiCSVybYFLlIPm81ntGadZ+pFtGxCUS8sJplhFQ4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pyv61cB96Qbl9FE2KMotAa7KjRw+aKEiDqvWA4K8GaKTWYsonzzpGClwunWf7dmQtUSU/4s8P5y9S/1+c6DmaxV9q7sQBng6MpwKpyyAy3+bGfB3HPEJMlditM+bUcuBlkUdTk7Ux88WSoc66lKo//tDsgGalJMyRwsfPPFE4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEIAfj6h; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707162802; x=1738698802;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MKOiCSVybYFLlIPm81ntGadZ+pFtGxCUS8sJplhFQ4A=;
  b=jEIAfj6hhgcvZzO07S/LNJzNgN8Do+HxA7dg5oiIG/7NXN0cutZdgu6N
   OuxeBbYtlOJ51rmUmciISZY6WQFpD2umhZstLzhXnYYUDA/XYf3xER6mY
   gSBeqE9CpNyJkXdtDP+fJJ1q7yVE10V6GZsNMo7EwK1To07eykl2pEcCm
   pLfkbenUJXG3jur2GIkzmLx6YfdEFOfGX5X+qiSY+Tbq8kKn3pACd7oJM
   yesogDiBZaPSz4GqyU9ETU1YQqqARhiU2usUSvQNoM2ncXnbjOvH/+5Pj
   li9uIfre8it29eQ87X46+96XoVvlVGo7NSBxmzFHRAYEZWdP7x07TvVQ3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4410907"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4410907"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:53:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="799661"
Received: from ckuuniff-mobl.amr.corp.intel.com (HELO [10.212.98.15]) ([10.212.98.15])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:53:21 -0800
Message-ID: <70c54f80-9fb1-4789-b371-eead597423f5@linux.intel.com>
Date: Mon, 5 Feb 2024 13:52:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] soundwire: intel_auxdevice: remove redundant
 assignment to variable link_flags
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240205182436.1843447-1-colin.i.king@gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240205182436.1843447-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for the clean-up!

> The variable link_flags is being initialized with a value that is never
> read, it is being re-assigned later on. The initialization is
> redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/soundwire/intel_auxdevice.c:624:2: warning: Value stored
> to 'link_flags' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/soundwire/intel_auxdevice.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
> index 93698532deac..95125cc2fc59 100644
> --- a/drivers/soundwire/intel_auxdevice.c
> +++ b/drivers/soundwire/intel_auxdevice.c
> @@ -621,8 +621,6 @@ static int __maybe_unused intel_resume(struct device *dev)
>  		return 0;
>  	}
>  
> -	link_flags = md_flags >> (bus->link_id * 8);
> -

this redundant line is 3+ years old now, added in a2d9c161db24
("soundwire: intel: pm_runtime idle scheduling")

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

>  	if (pm_runtime_suspended(dev)) {
>  		dev_dbg(dev, "pm_runtime status was suspended, forcing active\n");
>  

