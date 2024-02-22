Return-Path: <linux-kernel+bounces-77140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38912860199
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F932881FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AEC137918;
	Thu, 22 Feb 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="POS1hNcW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7586AF85;
	Thu, 22 Feb 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626515; cv=none; b=FQEKKcsQIlW5Hrc+7V747V4BLhbTFURXoDEq17Xgk2MSx965TXNt+AvS6recBYQ14aL2qimkhUG/nhgrWJ9natrHZsmU81ytHoCTD0IKS1OZgxTtmk5dQUlorxWSYjSz79bYwJGO0xI5SFNHrW371DnMH1WodE2sdaJ2s751Tf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626515; c=relaxed/simple;
	bh=96hpAVVd+xDK8y/C86u/coOa7UxUdqcJBdcPH5BU3ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGMSq3tvwUd+ALJE5dbtIndXosbMC2puzCg1R/YycAziIIBM4Rh/inUkK3HjNNPqKCooh142XVoerMq2duFbe+5ej5bdKDgYbtq9XGWmADEjhjE5li/dB8kefwBR35f2iN6oPGmLpTQjJC+7rKaVi2ITRsVi6PMcib4x9fTYoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=POS1hNcW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708626514; x=1740162514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=96hpAVVd+xDK8y/C86u/coOa7UxUdqcJBdcPH5BU3ro=;
  b=POS1hNcWJqVAiasbvYg6kMJ7WvPzdZzimwynLOxRwovAb4QLx7qYCDg1
   XMvVidUUjHswnnZ8JPVZBtNnxe8ssxY5M8ynkg7UAj/xbJPcQnXJKMXay
   NBVV1knmxRno53/z2LDvGD/hxp6jjI57R31UdT0NX6BHpNhXlWNx5IrKe
   r8Xw78IhdW74KnRTIQhDem7Nc3+yD3CXqdFDa9bBO6/2yAnzu7IyfF0f2
   pofw7OHXw/b1rLCsPWtwdXo7Nb9vfg6duKCTt9gucz/DUnpLOJ4viTNcw
   Pdn8cNFJ7PKbQVjg8ubYFH4NUW5Gwb5YEnuHCrptwJ5zHbGi+yE4pPSSS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6697386"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6697386"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:28:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5552427"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.114.198]) ([10.246.114.198])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:28:32 -0800
Message-ID: <ecbd2aaa-6ddb-47a5-8422-67f906832c50@intel.com>
Date: Thu, 22 Feb 2024 11:28:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/trace: Fix uncorrectable macro spelling
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240221-fix-correctable-macro-v1-1-6e6ab8b8aa39@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240221-fix-correctable-macro-v1-1-6e6ab8b8aa39@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/21/24 9:52 PM, Ira Weiny wrote:
> Uncorrectable is spelled with two r's.
> 
> Fix the macro spelling.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/trace.h     | 4 ++--
>  tools/testing/cxl/test/mem.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index bdf117a33744..577a01954f71 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -267,11 +267,11 @@ TRACE_EVENT(cxl_generic_event,
>   * General Media Event Record - GMER
>   * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
>   */
> -#define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
> +#define CXL_GMER_EVT_DESC_UNCORRECTABLE_EVENT		BIT(0)
>  #define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
>  #define CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW		BIT(2)
>  #define show_event_desc_flags(flags)	__print_flags(flags, "|",		   \
> -	{ CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,		"UNCORRECTABLE_EVENT"	}, \
> +	{ CXL_GMER_EVT_DESC_UNCORRECTABLE_EVENT,	"UNCORRECTABLE_EVENT"	}, \
>  	{ CXL_GMER_EVT_DESC_THRESHOLD_EVENT,		"THRESHOLD_EVENT"	}, \
>  	{ CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW,	"POISON_LIST_OVERFLOW"	}  \
>  )
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 35ee41e435ab..c0c1e6b4db75 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -380,7 +380,7 @@ struct cxl_test_gen_media gen_media = {
>  			.related_handle = cpu_to_le16(0),
>  		},
>  		.phys_addr = cpu_to_le64(0x2000),
> -		.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
> +		.descriptor = CXL_GMER_EVT_DESC_UNCORRECTABLE_EVENT,
>  		.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
>  		.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
>  		/* .validity_flags = <set below> */
> 
> ---
> base-commit: a2cd3520e6085b0f9145d9c5e3d1bfa9cce4c3be
> change-id: 20240102-fix-correctable-macro-2847ce932c9c
> 
> Best regards,

