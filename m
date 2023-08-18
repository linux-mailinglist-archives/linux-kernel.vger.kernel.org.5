Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD70780F28
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378156AbjHRP0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378199AbjHRP0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:26:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C00422B;
        Fri, 18 Aug 2023 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692372371; x=1723908371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7PNoo+g0W57IvA5Twn9qix2zfjGR5PvEa19G/W9fi1g=;
  b=jfPGIuYNIFvYEHeKR1QMV5okXOb9BB9AJt5pUiJoZRKS23f0dcx+FFub
   yPD+o0KpHHWgqVwHFG/yV5Zi3NvMUX7wHMC1ABvZi6ku0WPMNf8ehb7XP
   EEvlEyKW7RefDwusbcapKMeTouirMt7OF05bZuQBOahZRJMm7hNSskK+m
   2PcrjXoXxaQZRJDW6T0YhNm+9UbbEaI8czDjvhWLYNgSINGIkp8sb3iEO
   MufjsdgwBpikx0yipfnGpIuDBmJtLU67L29gCy+/vnTYBY64wKiwPB2AT
   zkOaXPGxbxM5+NGSpzdPkr0BXzZ4PcUYa30GCVvi/Zs6lCBIOxeDHdsdW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="459477321"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="459477321"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 08:26:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="858728349"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="858728349"
Received: from nneal-mobl.amr.corp.intel.com (HELO [10.209.28.16]) ([10.209.28.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 08:26:09 -0700
Message-ID: <b908433c-0924-fbf7-f555-532e438ff050@intel.com>
Date:   Fri, 18 Aug 2023 08:26:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tee: amdtee: add support for use of cma region
Content-Language: en-US
To:     Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        SivaSangeetha SK <SivaSangeetha.SK@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Cc:     Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>
References: <7531423fcb3b18ff78737ae5eabc84b0e3cb2909.1692369704.git.Devaraj.Rangasamy@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <7531423fcb3b18ff78737ae5eabc84b0e3cb2909.1692369704.git.Devaraj.Rangasamy@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/23 07:42, Devaraj Rangasamy wrote:
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1223,6 +1223,8 @@ void __init setup_arch(char **cmdline_p)
>  	initmem_init();
>  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>  
> +	amdtee_cma_reserve();
> +
>  	if (boot_cpu_has(X86_FEATURE_GBPAGES))
>  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);

Right now, we have *A* global CMA pool set up in
dma_contiguous_reserve() that everyone shares.

Why does this *one* driver deserve to be a special snowflake and get its
own private CMA area and own command-line options?

It seems to me like you should just tell users to set
CONFIG_CMA_SIZE_MBYTES or use cma=size on the command-line and just use
the global pool.  If you want to make it a special snowflake, there's a
much higher bar to clear, and there's zero justification for that right now.

Oh, and this:

>  static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
>  			 size_t size, size_t align)
>  {
>  	unsigned int order = get_order(size);
>  	unsigned long va;
>  	int rc;
>  
>  	/*
>  	 * Ignore alignment since this is already going to be page aligned
>  	 * and there's no need for any larger alignment.
>  	 */
> 	va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);

is goofy.  It either only needs powers-of-2 and can take "order" as an
argument instead of 'size', or it should be using alloc_pages_exact() to
avoid wasting memory.
