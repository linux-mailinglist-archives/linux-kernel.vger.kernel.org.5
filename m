Return-Path: <linux-kernel+bounces-58740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CFA84EAE1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD7E1F260B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7F84F601;
	Thu,  8 Feb 2024 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loMuMepI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39954C618;
	Thu,  8 Feb 2024 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429180; cv=none; b=GKQvSTQWE0iBO5sbGzNkaMs99gOcnaZV4N69wE8vijbaBgYLFIjcRs814wr2fZcN8L5EWFqI+5W0RJS3qB4ZTl5ryt3XPUUqjISyq6sqLdzIrr1AtSShdRd+7S8G7+HTsNvUf6DbexR+S7h3RNqKxZIHyYIh8JSc3HPL/ssULeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429180; c=relaxed/simple;
	bh=8QAG6Cro55Jx09o5dkxYkDEqva+UxRXkLO1iDXdFo4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsZiZvn8mwnYbpe7SK7Rxs1264iPFWctS2FEvCgx1QMsaZ/jzaTMJ11TO8Tl9JMNAjupjzlNn5C9KEJonTWAPoj9hKjrxAjFocI1hS9DimRQvkqpMKRFGOd+tqqr4MqZI0LHPPvT3y5ezXTWfMWn31kVkp7nOeoiK/GAUlErY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loMuMepI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707429179; x=1738965179;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8QAG6Cro55Jx09o5dkxYkDEqva+UxRXkLO1iDXdFo4E=;
  b=loMuMepIm4AeedvYTNBnJKXvN8XfFA7xY8szT2hweg5LKdDkHKO5Mmur
   ZjT57FnYA7ZkEqeEPDU1lpxLGTx5OVMuqrm7i+dLV9zuclaLVQ5QyKwHa
   xx3V1LucyAzKKfioRX+0TaLcQ4iHlE8EvLPlXOS0jla1PAA+DwdhHnG3W
   Y5jHT0pjaBgQb2Sg8BSVN+fQ+W2AdT4dG3pFnbGxzgNYi1rD2MnCc7rxD
   FNZSt09w3PwUKP4uD7tOFteqxC/MP9hVLyLK+exn/PCTrroobJF7BbrLu
   LZdub05J4iBosWSOj2o9rY+qRCm1qc52VYq7nCZsyT06NarNQw4Y+XtbT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1623333"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1623333"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:52:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6389144"
Received: from millermi-mobl1.amr.corp.intel.com (HELO [10.255.229.182]) ([10.255.229.182])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:52:57 -0800
Message-ID: <273bac88-db72-4282-861d-e9886d32ca7f@linux.intel.com>
Date: Thu, 8 Feb 2024 13:52:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] platform/x86/intel/sdsi: Add header file
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>, netdev@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
 <20240201010747.471141-4-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240201010747.471141-4-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/31/24 5:07 PM, David E. Box wrote:
> In preparation for new source files, move common structures to a new
> header flie.

Add some detail about why you adding new source files.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  MAINTAINERS                       |  1 +
>  drivers/platform/x86/intel/sdsi.c | 23 +----------------------
>  drivers/platform/x86/intel/sdsi.h | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 22 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/sdsi.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..09ef8497e48a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11042,6 +11042,7 @@ INTEL SDSI DRIVER
>  M:	David E. Box <david.e.box@linux.intel.com>
>  S:	Supported
>  F:	drivers/platform/x86/intel/sdsi.c
> +F:	drivers/platform/x86/intel/sdsi.h
>  F:	tools/arch/x86/intel_sdsi/
>  F:	tools/testing/selftests/drivers/sdsi/
>  
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
> index 05a35f2f85b6..d48bb648f0b2 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -22,24 +22,16 @@
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  
> +#include "sdsi.h"
>  #include "vsec.h"
>  
>  #define ACCESS_TYPE_BARID		2
>  #define ACCESS_TYPE_LOCAL		3
>  
>  #define SDSI_MIN_SIZE_DWORDS		276
> -#define SDSI_SIZE_MAILBOX		1024
>  #define SDSI_SIZE_REGS			80
>  #define SDSI_SIZE_CMD			sizeof(u64)
>  
> -/*
> - * Write messages are currently up to the size of the mailbox
> - * while read messages are up to 4 times the size of the
> - * mailbox, sent in packets
> - */
> -#define SDSI_SIZE_WRITE_MSG		SDSI_SIZE_MAILBOX
> -#define SDSI_SIZE_READ_MSG		(SDSI_SIZE_MAILBOX * 4)
> -
>  #define SDSI_ENABLED_FEATURES_OFFSET	16
>  #define SDSI_FEATURE_SDSI		BIT(3)
>  #define SDSI_FEATURE_METERING		BIT(26)
> @@ -103,19 +95,6 @@ struct disc_table {
>  	u32	offset;
>  };
>  
> -struct sdsi_priv {
> -	struct mutex		mb_lock;	/* Mailbox access lock */
> -	struct device		*dev;
> -	void __iomem		*control_addr;
> -	void __iomem		*mbox_addr;
> -	void __iomem		*regs_addr;
> -	int			control_size;
> -	int			maibox_size;
> -	int			registers_size;
> -	u32			guid;
> -	u32			features;
> -};
> -
>  /* SDSi mailbox operations must be performed using 64bit mov instructions */
>  static __always_inline void
>  sdsi_memcpy64_toio(u64 __iomem *to, const u64 *from, size_t count_bytes)
> diff --git a/drivers/platform/x86/intel/sdsi.h b/drivers/platform/x86/intel/sdsi.h
> new file mode 100644
> index 000000000000..d0d7450c7b2b
> --- /dev/null
> +++ b/drivers/platform/x86/intel/sdsi.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PDx86_SDSI_H_
> +#define __PDx86_SDSI_H_
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +#define SDSI_SIZE_MAILBOX		1024
> +
> +/*
> + * Write messages are currently up to the size of the mailbox
> + * while read messages are up to 4 times the size of the
> + * mailbox, sent in packets
> + */
> +#define SDSI_SIZE_WRITE_MSG		SDSI_SIZE_MAILBOX
> +#define SDSI_SIZE_READ_MSG		(SDSI_SIZE_MAILBOX * 4)
> +
> +struct device;
> +
> +struct sdsi_priv {
> +	struct mutex			mb_lock;	/* Mailbox access lock */
> +	struct device			*dev;
> +	void __iomem			*control_addr;
> +	void __iomem			*mbox_addr;
> +	void __iomem			*regs_addr;
> +	int				control_size;
> +	int				maibox_size;
> +	int				registers_size;
> +	u32				guid;
> +	u32				features;
> +};
> +#endif

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


