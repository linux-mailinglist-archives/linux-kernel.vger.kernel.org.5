Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110397BFE12
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjJJNk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjJJNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:40:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C45D53
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696945162; x=1728481162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jFQ77hdf5zEKB0qNpCTju/j74KsLB6t/D+R9NA4ih+U=;
  b=K34F7/IGHen9tHyq8Jd68rPqQB9MiHna3Xk87pp4LWU3xjp2TEADQA+n
   MqZyED+GhqMj97eMy61MQNBeugTc7RC5aLzvhP0sy+T/zKzA575thdgaD
   O/9/n2p6l2sVebELd0i2ez1KoNrARivai9WMMtZ8ZhXJYHyk6Hhsb60Y8
   CKlOCKPR+n+Tn8DWFtodQaxnRx9/gX+zLblR3Md86ahM6zsn7vHLscE9M
   mS+LCxiFhd+Wi2iE3Z+8DtKpZk5/4Zjsgq1RDoLmCH1OXpLlnU9prQC+m
   LmfeiKESi1BnKgGU8ak5ufH9js0NkgmKpAp5CEUa8YRX1siJ9TNpsSOmQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="384251674"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="384251674"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="747072743"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="747072743"
Received: from patinira-mobl.amr.corp.intel.com (HELO [10.212.128.216]) ([10.212.128.216])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:39:20 -0700
Message-ID: <f9e8de5e-56a6-4209-a78a-6997dac489a0@linux.intel.com>
Date:   Tue, 10 Oct 2023 06:39:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] cpu/hotplug, x86/acpi: Disable CPU hotplug for ACPI
 MADT wakeup
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-4-kirill.shutemov@linux.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231005131402.14611-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 6:13 AM, Kirill A. Shutemov wrote:
> ACPI MADT doesn't allow to offline CPU after it got woke up.
> 

I think you can use the term "CPU hotplug" instead of just offline.

> Currently hotplug prevented based on the confidential computing
> attribute which is set for Intel TDX. But TDX is not the only possible
> user of the wake up method.
> 
> Mark CPU hotplug as "not supported" on ACPI MADT wakeup enumeration.

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/coco/core.c               |  1 -
>  arch/x86/kernel/acpi/madt_wakeup.c |  4 ++++
>  include/linux/cc_platform.h        | 10 ----------
>  kernel/cpu.c                       |  2 +-
>  4 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index eeec9986570e..f07c3bb7deab 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -20,7 +20,6 @@ static bool noinstr intel_cc_platform_has(enum cc_attr attr)
>  {
>  	switch (attr) {
>  	case CC_ATTR_GUEST_UNROLL_STRING_IO:
> -	case CC_ATTR_HOTPLUG_DISABLED:
>  	case CC_ATTR_GUEST_MEM_ENCRYPT:
>  	case CC_ATTR_MEM_ENCRYPT:
>  		return true;
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index 1b9747bfd5b9..15bdf10b1393 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -1,4 +1,5 @@
>  #include <linux/acpi.h>
> +#include <linux/cpu.h>
>  #include <asm/apic.h>
>  
>  /* Physical address of the Multiprocessor Wakeup Structure mailbox */
> @@ -74,6 +75,9 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  
>  	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
>  
> +	/* Disable CPU onlining/offlining */
> +	cpu_hotplug_not_supported();
> +
>  	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
>  
>  	return 0;
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> index cb0d6cd1c12f..d08dd65b5c43 100644
> --- a/include/linux/cc_platform.h
> +++ b/include/linux/cc_platform.h
> @@ -80,16 +80,6 @@ enum cc_attr {
>  	 * using AMD SEV-SNP features.
>  	 */
>  	CC_ATTR_GUEST_SEV_SNP,
> -
> -	/**
> -	 * @CC_ATTR_HOTPLUG_DISABLED: Hotplug is not supported or disabled.
> -	 *
> -	 * The platform/OS is running as a guest/virtual machine does not
> -	 * support CPU hotplug feature.
> -	 *
> -	 * Examples include TDX Guest.
> -	 */
> -	CC_ATTR_HOTPLUG_DISABLED,
>  };
>  
>  #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index cf536fe1a88a..9d4279476b40 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1522,7 +1522,7 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>  	 * If the platform does not support hotplug, report it explicitly to
>  	 * differentiate it from a transient offlining failure.
>  	 */
> -	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) || !cpu_hotplug_supported)
> +	if (!cpu_hotplug_supported)
>  		return -EOPNOTSUPP;
>  	if (cpu_hotplug_disabled)
>  		return -EBUSY;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
