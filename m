Return-Path: <linux-kernel+bounces-98109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D703F87753E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 04:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2821F21CCC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 03:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1653214A84;
	Sun, 10 Mar 2024 03:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WI5O7dor"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6712F13AC0
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 03:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710042975; cv=none; b=jsFmZFhQ5CKg0HxcrnSzCvx3SIojnjT1Wk7FOpig9PPa5mo4kKNnNYnF95yCUnj2dQdhvtnfURik2PAYvOAqj2g++I6ApiyT5Nw0lMWKv39/xX0h03seA3pL5Or+VQttEom9RS2TxvMeojD9uma3j5U/jUUoAsbJ6hDrKOJLxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710042975; c=relaxed/simple;
	bh=urx6qSaUobpEfgmflt0mR3zGUlajfE+WZMxiq7Kf6MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyXB/GjwYEOPIcl4v1upD5TapA+9lqFHP/W43mrHyQsh8PUjbiS2B3spyLQw479E2EyXxxusEqq2hqZo7/h4sZsLIwXv+4ocqT37uWGPySXJpj161eX/bJx5pCU7T7xrUUwBYNv10DkVcoHrjmXz3CPL+sOHJHID/SgJFch4C9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WI5O7dor; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710042974; x=1741578974;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=urx6qSaUobpEfgmflt0mR3zGUlajfE+WZMxiq7Kf6MQ=;
  b=WI5O7dorT5C2ZerDRQy7kixbUY3i02z1p8z0hhnjVq/X9qwDWGHTEQLe
   1drguZTaIW73QmpgQybITDmgYuuwkCPxB1smtiiSjBJWy80uOFAb3thYo
   kBiTI4/qGrC+O8i/IwRrne0oSdf7dzDMLZ1OMS6KSm8uy8M7m6SlhzteQ
   9tI4w4tzJN+h+caKB9zK2yx4hoJvpumoi7MCiSnRuGMSrvIq5+l99ysDX
   Nu8/1FS0VjTs/VOGxBHod5wSvwndgVzByRK8G29vVgnXhTdYsBpy3vsMv
   oz+o2hn6lsajywOlKPT85KEB+hpWaTaz1weLehracyqqpE8X96qSo2QU/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="27200167"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="27200167"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 19:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="41762842"
Received: from chengyin-mobl.amr.corp.intel.com (HELO [10.209.27.224]) ([10.209.27.224])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 19:56:12 -0800
Message-ID: <95ba9bb3-7c48-4d99-b05e-5a45a796af3c@linux.intel.com>
Date: Sat, 9 Mar 2024 19:56:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] x86/tdx: Enable ENUM_TOPOLOGY
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com
Cc: hpa@zytor.com, seanjc@google.com, ele.reshetova@intel.com,
 rick.p.edgecombe@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240309210230.239045-1-kirill.shutemov@linux.intel.com>
 <20240309210230.239045-5-kirill.shutemov@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240309210230.239045-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/9/24 1:02 PM, Kirill A. Shutemov wrote:
> TDX 1.0 generates a #VE when accessing topology-related CPUID leafs
> (0xB and 0x1F) and the X2APIC_APICID MSR. The kernel returns all
> zeros on CPUID #VEs. In practice, this means that the kernel can only
> boot with a plain topology. Any complications will cause problems.

Is this issue only for TDX 1.0? What about TDX > 1.0?

>
> The ENUM_TOPOLOGY feature allows the VMM to provide topology
> information to the guest in a safe manner. Enabling the feature
> eliminates topology-related #VEs: the TDX module virtualizes
> accesses to the CPUID leafs and the MSR.
>
> Enable ENUM_TOPOLOGY if it is available.

I cant find the ENUM_TOPOLOGY in ABI spec (https://cdrdv2.intel.com/v1/dl/getContent/795381).

Can you point me to the correct document?

>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/coco/tdx/tdx.c           | 20 ++++++++++++++++++++
>  arch/x86/include/asm/shared/tdx.h |  3 +++
>  2 files changed, 23 insertions(+)
>
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index d9ea82f8772d..291e45db8d54 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -280,6 +280,26 @@ static void tdx_setup(u64 *cc_mask)
>  		else
>  			tdx_panic(msg);
>  	}
> +
> +	/*
> +	 * TDX 1.0 generates a #VE when accessing topology-related CPUID leafs
> +	 * (0xB and 0x1F) and the X2APIC_APICID MSR. The kernel returns all
> +	 * zeros on CPUID #VEs. In practice, this means that the kernel can only
> +	 * boot with a plain topology. Any complications will cause problems.
> +	 *
> +	 * The ENUM_TOPOLOGY feature allows the VMM to provide topology
> +	 * information to the guest in a safe manner. Enabling the feature
> +	 * eliminates topology-related #VEs: the TDX module virtualizes
> +	 * accesses to the CPUID leafs and the MSR.
> +	 *
> +	 * Enable ENUM_TOPOLOGY if it is available.
> +	 */

Why are we overriding it in guest? Why can't this by done by TDX Module
or QEMU during initialization?

> +	if ((features & TDX_FEATURES0_ENUM_TOPOLOGY) &&
> +	    tdg_vm_rd(TDCS_TOPOLOGY_ENUM_CONFIGURED)) {
> +		tdg_vm_wr(TDCS_TD_CTLS,
> +			  TD_CTLS_ENUM_TOPOLOGY,
> +			  TD_CTLS_ENUM_TOPOLOGY);
> +	}
>  }
>  
>  /*
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index 29a61c72e4dd..2964c506b241 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -27,15 +27,18 @@
>  #define TDCS_CONFIG_FLAGS		0x1110000300000016
>  #define TDCS_TD_CTLS			0x1110000300000017
>  #define TDCS_NOTIFY_ENABLES		0x9100000000000010
> +#define TDCS_TOPOLOGY_ENUM_CONFIGURED	0x9100000000000019
>  
>  /* TDCS_TDX_FEATURES0 bits */
>  #define TDX_FEATURES0_PENDING_EPT_VIOLATION_V2	BIT_ULL(16)
> +#define TDX_FEATURES0_ENUM_TOPOLOGY		BIT_ULL(20)
>  
>  /* TDCS_CONFIG_FLAGS bits */
>  #define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
>  
>  /* TDCS_TD_CTLS bits */
>  #define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
> +#define TD_CTLS_ENUM_TOPOLOGY		BIT_ULL(1)
>  
>  /* TDX hypercall Leaf IDs */
>  #define TDVMCALL_MAP_GPA		0x10001

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


