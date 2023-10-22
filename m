Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A297D24A8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjJVQvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVQvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:51:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2155CFB
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697993503; x=1729529503;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2h1MLsEUAKWtQrKuqZMPzdZyua2XzLtNlrV8BMgQOg4=;
  b=BlCXXu4uxFhn/1jmAnyliXqLI0Y3BJRfzaeQ4ZzEbdPZlu791Y9SHiX2
   SrKoHEYOch2LGMxw0GwOeDYeCrQkh0kIDbO59Yhif3Ng9wHXQWnnT7kT3
   y238I9UaTIovuNkUu1oB/nGL/MgnUnuUAvgC1cHDLBTtPpOGeiiZDVKyt
   lHZF33PESUQSbrscZC6pyW04S1XeuxRD+UiTDtaTOSIL+X2KmOoNMzs/b
   SCDq9k0mzogbYRPTSvuMkA3n3ER7EGVqHKxBxi2Nfx6eimzzHaKZfQnTK
   U/T+hMo1Pd5QyPY8qyK1malcKDuL8e4c64JYLIDJe/7AD1sRfVtEx7+Y0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="371786930"
X-IronPort-AV: E=Sophos;i="6.03,243,1694761200"; 
   d="scan'208";a="371786930"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 09:51:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="823750225"
X-IronPort-AV: E=Sophos;i="6.03,243,1694761200"; 
   d="scan'208";a="823750225"
Received: from mozdogan-mobl1.amr.corp.intel.com (HELO [10.209.73.165]) ([10.209.73.165])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 09:51:41 -0700
Message-ID: <cbc7d064-d6ef-4453-ba4c-4d4e9ca58aa6@linux.intel.com>
Date:   Sun, 22 Oct 2023 09:51:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] x86/tdx: Dump TDX Version During TD Bootup
To:     Yi Sun <yi.sun@intel.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
        x86@kernel.org
Cc:     kirill.shutemov@linux.intel.com, kai.huang@intel.com,
        nik.borisov@suse.com, linux-kernel@vger.kernel.org,
        heng.su@intel.com, yi.sun@linux.intel.com,
        Dongcheng Yan <dongcheng.yan@intel.com>
References: <20231022063122.2812190-1-yi.sun@intel.com>
Content-Language: en-US
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231022063122.2812190-1-yi.sun@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/2023 11:31 PM, Yi Sun wrote:
> Different versions of TDX have significant differences, as stated in the
> "Intel® TDX Module Incompatibilities between v1.0 and v1.5" reference.
> 
> It would be useful for TD users to be aware of the vendor and version of
> the current TDX in use. Users could expect different results when checking
> CPIUD or reading MSR in the user space, depending on the TDX version.
> Additionally, refer to the TDX version when reporting issues.
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Co-developed-by: Dongcheng Yan <dongcheng.yan@intel.com>
> Signed-off-by: Dongcheng Yan <dongcheng.yan@intel.com>
> Signed-off-by: Yi Sun <yi.sun@intel.com>
> 
> ---
> V5 -> V6:
> 	- Remove random warnings at each step. Print the error details and
> 	presumed TDX version in common code. (Dave Hansen)
> 
> 	- Remove useless assignment and cast. Re-zeroed the input args
> 	between tdcalls. Refine the comments. (Dave Hansen)
> 
> V4 -> V5:
> 	- Print the version info inside the function detect_tdx_version, but
> 	not tdx_early_init(). Remove the structure tdg_sys_info, but have 3
> 	local variables instead. (Huang, Kai)
> 
> V3 -> V4: 
> 	- Rebase the patch on top of the latest tip tree. (Huang, Kai)
> 	- Change the return value of function tdg_get_sysinfo as void, and
> 	zero out tdg_sys_info when error occurs. (Kuppuswamy Sathyanarayanan)
> 
> V2 -> V3: 
> 	- Move the allocation of struct tdg_sys_info on stack inside
> 	tdx_early_init() and pass down to tdg_get_sysinfo() to fill.
> 	(Kirill Shutemov)
> 
> V1 -> V2: 
> 	- Move the defination of field IDs and the struct tdg_sys_info to tdx.c.
> 	(Kuppuswamy Sathyanarayanan)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 3e6dbd2199cf..20e911241e56 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -37,6 +37,15 @@
>  
>  #define TDREPORT_SUBTYPE_0	0
>  
> +/*
> + * TDX metadata base field id, used by TDCALL TDG.SYS.RD
> + * See TDX ABI Spec Global Metadata Fields
> + */
> +#define TDX_SYS_VENDOR_ID_FID		0x0800000200000000ULL
> +#define TDX_SYS_MINOR_FID		0x0800000100000003ULL
> +#define TDX_SYS_MAJOR_FID		0x0800000100000004ULL
> +#define TDX_VENDOR_INTEL		0x8086
> +
>  /* Called from __tdx_hypercall() for unrecoverable failure */
>  noinstr void __noreturn __tdx_hypercall_failed(void)
>  {
> @@ -800,6 +809,56 @@ static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
>  	return true;
>  }
>  
> +/*
> + * Detect TDX Module version info from TDG.SYS.RD TDCALL
> + */
> +static void detect_tdx_version(void)
> +{
> +	struct tdx_module_args args = {};
> +	u16 major_version = 0;
> +	u16 minor_version = 0;
> +	u32 vendor_id = 0;
> +	u64 ret = 0;

Since you overwrite all above values, I think you can skip initialization.

> +
> +	args.rdx = TDX_SYS_VENDOR_ID_FID;
> +	ret = __tdcall_ret(TDG_SYS_RD, &args);
> +	if (ret)
> +		goto err_out;
> +
> +	vendor_id = args.r8;
> +
> +	memset(&args, 0, sizeof(args));
> +	args.rdx = TDX_SYS_MAJOR_FID;
> +	ret = __tdcall_ret(TDG_SYS_RD, &args);
> +	if (ret)
> +		goto err_out;
> +
> +	major_version = args.r8;
> +
> +	memset(&args, 0, sizeof(args));
> +	args.rdx = TDX_SYS_MINOR_FID;
> +	ret = __tdcall_ret(TDG_SYS_RD, &args);
> +	if (ret)
> +		goto err_out;
> +
> +	minor_version = args.r8;
> +
> +	pr_info("TDX detected. TDX version:%u.%u VendorID:%x\n",
> +		major_version, minor_version, vendor_id);

Since TDX prefix is part of pr_info, you can just use "Guest detected. version:..."

> +
> +	return;
> +
> +err_out:
> +	if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
> +		pr_info("TDG.SYS.RD not available\n");
> +	else
> +		pr_info("TDG.SYS.RD unknown error (%llu), reading field %llu\n",
> +			ret, args.rdx);
> +
> +	pr_info("Assuming TDX version:1.x (x<5) VendorID:%x\n",
> +		TDX_VENDOR_INTEL);
> +}
> +
>  void __init tdx_early_init(void)
>  {
>  	struct tdx_module_args args = {
> @@ -867,5 +926,5 @@ void __init tdx_early_init(void)
>  	 */
>  	x86_cpuinit.parallel_bringup = false;
>  
> -	pr_info("Guest detected\n");
> +	detect_tdx_version();
>  }
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index f74695dea217..10b6c61e835e 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -17,6 +17,8 @@
>  #define TDG_MR_REPORT			4
>  #define TDG_MEM_PAGE_ACCEPT		6
>  #define TDG_VM_WR			8
> +/* The TDCALL TDG.SYS.RD originates from TDX version 1.5 */
> +#define TDG_SYS_RD			11
>  
>  /* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
>  #define TDCS_NOTIFY_ENABLES		0x9100000000000010

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
