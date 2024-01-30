Return-Path: <linux-kernel+bounces-44877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A284286A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF98EB29C46
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C311086122;
	Tue, 30 Jan 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2lSZ7GN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C588613E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629846; cv=none; b=fVaHh4c9YYipMJvztZU2HlLTZDVSFrkikj4JRjFd0hzEcLMFCsRyH6VU7eYV6on4J/peGx8B9cRcH8xMDjeTTHuKSczpZj9ei2bfDt96dxKnTdR6rtMVYFowVMdGRHdvfXFzcMvFnbAy6sGLr8rbG9TzO/yDYj8aO5CnqJV1ERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629846; c=relaxed/simple;
	bh=uKm+UW/Vo4GQhTpv3sxOiaQtBenqWb70/6yWKJn8914=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOh4ph1mzl0WSpbmpOi/M6QuFFXfH7Xy68YlftJE3dBbJgm/hv9UH73Al8SQSTIXbAP7yk9ZUZ0OmzbA5J+7kSdzWyNHOXLBHSNaeGD1gMENFQHoC2A0jLmrgM3UMp1PiTBf9LdxzNCxpVRiXfMvxoRrV3ohPZdN+E8tnD8qlYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2lSZ7GN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706629843; x=1738165843;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uKm+UW/Vo4GQhTpv3sxOiaQtBenqWb70/6yWKJn8914=;
  b=i2lSZ7GNx0KrR1gu3mTwRBo6qsHJ2R8O08guq24ceuffrBDKrcbtac8e
   +LRsD6v9ZfrqhSSX0F+SB21KZnAa3YnyIypf6tsdIPVD7kgSBo7golygV
   14RBojHe6Y8OtnNwp/3sbaL+3x5MaW3yOs+L27WwhA4czhYAjgv6b3miF
   VE6qLsHXxBv4QQoMg3I2kwx2KcX2KyczvCe0fKHMRHYoggEsc2wyAcxL4
   rTEem05iS34u7mbi5lxO/KsguAqz0GCtcifAcIv1h/ss9R7+EA1X3t7u4
   Att0suSAZ71dZSGy/gd43XLozwNB0+s4UXnfNXi2Z0/PO/XxWIc7G2oXm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10064935"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10064935"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:50:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="737811733"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="737811733"
Received: from pangchin-mobl3.amr.corp.intel.com (HELO [10.209.54.246]) ([10.209.54.246])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:50:41 -0800
Message-ID: <deecae79-625f-4f57-a764-67d01d7f264c@linux.intel.com>
Date: Tue, 30 Jan 2024 07:50:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>,
 Sean Christopherson <seanjc@google.com>, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/30/24 12:30 AM, Kirill A. Shutemov wrote:
> RDRAND and RDSEED instructions rarely fail. Ten retries should be
> sufficient to account for occasional failures.
>
> If the instruction fails more than ten times, it is likely that the
> hardware is broken or someone is attempting to exceed the rate at which
> the random number generator hardware can provide random numbers.
>
> Issue a warning if ten retries were not enough.

Did you come across a case where it fails? Wondering why add this
warning now?

>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/archrandom.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
> index 918c5880de9e..fc8d837fb3b9 100644
> --- a/arch/x86/include/asm/archrandom.h
> +++ b/arch/x86/include/asm/archrandom.h
> @@ -13,6 +13,12 @@
>  #include <asm/processor.h>
>  #include <asm/cpufeature.h>
>  
> +#ifdef KASLR_COMPRESSED_BOOT
> +#define rd_warn(msg) warn(msg)

Why not use warn_once in both cases?

> +#else
> +#define rd_warn(msg) WARN_ONCE(1, msg)
> +#endif
> +
>  #define RDRAND_RETRY_LOOPS	10
>  
>  /* Unconditional execution of RDRAND and RDSEED */
> @@ -28,6 +34,9 @@ static inline bool __must_check rdrand_long(unsigned long *v)
>  		if (ok)
>  			return true;
>  	} while (--retry);
> +
> +	rd_warn("RDRAND failed\n");
> +
>  	return false;
>  }
>  
> @@ -45,6 +54,8 @@ static inline bool __must_check rdseed_long(unsigned long *v)
>  			return true;
>  	} while (--retry);
>  
> +	rd_warn("RDSEED failed\n");
> +
>  	return false;
>  }
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


