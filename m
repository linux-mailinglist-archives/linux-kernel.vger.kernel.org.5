Return-Path: <linux-kernel+bounces-77139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D06860196
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BDD1C24936
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D1012D205;
	Thu, 22 Feb 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OpFf+2VA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27196E61C;
	Thu, 22 Feb 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626459; cv=none; b=DTAu/TIVce5VfzL8KoJSHUt8PeAp/FOd++TjX0+OiwoB+vQjdgWFieMt3IyQAK+l/KnsakSJIGpoKjDqBJ05Rceouw029xBbqV9woVAQlL4+Up5PghHGkyfLM4dOvllB31plTb0WMQPOyl08yoSZ18odI7h3R+B9/6vEKNkCgWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626459; c=relaxed/simple;
	bh=xM/QGOiRYmmtfXJfmB0d8tNDu2LXbkjtP1X6XvDL9RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0XTaXcgSZ5K6gNrf91f+VwVrUSICFW28lAiMhuxlSMM8qa5L2RUi8/HNdx3zMm8i4X3CH8Eafm9AZGmnEvpbcMEFiEpsCanoK6SrGsdSaxWHbim/sABTLwe+1ExSdbtowZkSWoADBJfnu6bedQ0Q3vpgCHRzs6OKfGk+YBsU4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OpFf+2VA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708626458; x=1740162458;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xM/QGOiRYmmtfXJfmB0d8tNDu2LXbkjtP1X6XvDL9RM=;
  b=OpFf+2VAFtINfUB28rfoiacXPE7CqLCfTHTpJHWStwC+yk8edRBCgdMN
   7CagJQ86Xz7IGl5RWN+rXLc7Y2yEqs4TI4DsEos81513YSts4eJDYmJ4G
   5+G7y33H8bVXrizQiixVVpkMgyh6+MBV2QdeCuS6n9dSkeHrUMJxICJZW
   7NgfLwUnUZCgfDw26bdzF1T7pGFTGClgM9dfOky+FMcnCl2V2nrwGjFvk
   +3aOiJYe5w5GCPiZr+oi7PuVSAk5MWgF9iEH5+Sj2EzMZcxDsLmUxFus1
   I6WLRSJBEAVPYkRy7QrRES7zJchM1eiq6xcDrQpO7ckaI0RmXkk3PYwn+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6697326"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6697326"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:27:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5552216"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.114.198]) ([10.246.114.198])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:27:36 -0800
Message-ID: <fa47fa0a-288b-46e2-b03f-6d4061ab0fd2@intel.com>
Date: Thu, 22 Feb 2024 11:27:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3 v5] cxl/memdev: Use cond_guard() in
 cxl_inject_poison()
Content-Language: en-US
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>
References: <20240217105904.1912368-1-fabio.maria.de.francesco@linux.intel.com>
 <20240217105904.1912368-4-fabio.maria.de.francesco@linux.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240217105904.1912368-4-fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/24 3:59 AM, Fabio M. De Francesco wrote:
> Use cond_guard() in cxl_inject_poison() to not open code two up_write()
> in an 'out' block. If the down_read_interruptible() fail, the statements
> passed as the second argument of cond_guard() return -EINTR.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index dae8802ecdb0..bd97eea65bb0 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -331,19 +331,13 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	rc = down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> +	cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);
>  
> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
> -	if (rc) {
> -		up_read(&cxl_region_rwsem);
> -		return rc;
> -	}
> +	cond_guard(rwsem_read_intr, return -EINTR, &cxl_dpa_rwsem);
>  
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> -		goto out;
> +		return rc;
>  
>  	inject.address = cpu_to_le64(dpa);
>  	mbox_cmd = (struct cxl_mbox_cmd) {
> @@ -353,7 +347,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	};
>  	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>  	if (rc)
> -		goto out;
> +		return rc;
>  
>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>  	if (cxlr)
> @@ -366,11 +360,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		.length = cpu_to_le32(1),
>  	};
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
> -out:
> -	up_read(&cxl_dpa_rwsem);
> -	up_read(&cxl_region_rwsem);
>  
> -	return rc;
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
>  

