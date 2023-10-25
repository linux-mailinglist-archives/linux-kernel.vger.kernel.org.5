Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2137D72FC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJYSKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjJYSKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:10:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E2E9D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698257430; x=1729793430;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=A+etPYQceCpdWRP7TF2CMo0X5NnJJlNK94iG1g88DXk=;
  b=V+1E0oZ2WRTo1/fhtIpet0aghiebBHY0eLsODEQWCQplPvK5+QZMOU1h
   ZJUZYGbYsdprG69u4cYNc2c83HSZT/JA36Aow6HYFPaXpukF2q2dovXWZ
   9Ki9i6unHW3vaU69ezzJ1IJz0Gx6Js8fQ/RjhZaGvadhKqhf0H5Pb1yVL
   Ce2XQNbPCCUq5wm5anrsb8US4elssDp9iJVKAN/abOdJQ+kLsCnB+ao90
   9qKS9Qg44nJEz01DPMVUx148+OBAeDPGd+9ak1BJ7+RctsHjjNlpSPUc9
   fPtY605kzrSPHql40rW687Mp6NebTSgAyG5J+Qlcue6gveXXW1Fwz3TyX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="384578742"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="384578742"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="762539551"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="762539551"
Received: from jhanbaba-mobl.amr.corp.intel.com (HELO [10.212.160.197]) ([10.212.160.197])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:10:27 -0700
Message-ID: <e30560cf-cb88-45de-963f-f99f9b06db75@linux.intel.com>
Date:   Wed, 25 Oct 2023 11:10:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        elena.reshetova@intel.com, isaku.yamahata@intel.com,
        seanjc@google.com, Michael Kelley <mikelley@microsoft.com>,
        thomas.lendacky@amd.com, decui@microsoft.com,
        linux-kernel@vger.kernel.org
References: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2023 4:48 PM, Rick Edgecombe wrote:
> On TDX it is possible for the untrusted host to cause
> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to take
> care to handle these errors to avoid returning decrypted (shared) memory to
> the page allocator, which could lead to functional or security issues.
> 
> Such errors may herald future system instability, but are temporarily
> survivable with proper handling in the caller. The kernel traditionally
> makes every effort to keep running, but it is expected that some coco
> guests may prefer to play it safe security-wise, and panic in this case.
> To accommodate both cases, warn when the arch breakouts for converting
> memory at the VMM layer return an error to CPA. Security focused users
> can rely on panic_on_warn to defend against bugs in the callers.
> 
> Since the arch breakouts host the logic for handling coco implementation
> specific errors, an error returned from them means that the set_memory()
> call is out of options for handling the error internally. Make this the
> condition to warn about.
> 
> It is possible that very rarely these functions could fail due to guest
> memory pressure (in the case of failing to allocate a huge page when
> splitting a page table). Don't warn in this case because it is a lot less
> likely to indicate an attack by the host and it is not clear which
> set_memory() calls should get the same treatment. That corner should be
> addressed by future work that considers the more general problem and not
> just papers over a single set_memory() variant.
> 
> Suggested-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> This is a followup to the "Handle set_memory_XXcrypted() errors"
> series[0].
> 
> Previously[1] I attempted to create a useful helper to both simplify the
> callers and provide an official example of how to handle conversion
> errors. Dave pointed out that there wasn't actually any code savings in
> the callers using it. It also required a whole additional patch to make
> set_memory_XXcrypted() more robust.
> 
> I tried to create some more sensible helper, but in the end gave up. My
> current plan is to just add a warning for VMM failures around this. And
> then shortly after, pursue open coded fixes for the callers that are
> problems for TDX. There are some SEV and SME specifics callers, that I am
> not sure on. But I'm under the impression that as long as that side
> terminates the guest on error, they should be harmless.
> 
> [0] https://lore.kernel.org/lkml/20231017202505.340906-1-rick.p.edgecombe@intel.com/
> [1] https://lore.kernel.org/lkml/20231017202505.340906-2-rick.p.edgecombe@intel.com/
> ---
>  arch/x86/mm/pat/set_memory.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index bda9f129835e..dade281f449b 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2153,7 +2153,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  
>  	/* Notify hypervisor that we are about to set/clr encryption attribute. */
>  	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
> -		return -EIO;
> +		goto vmm_fail;
>  
>  	ret = __change_page_attr_set_clr(&cpa, 1);
>  
> @@ -2167,12 +2167,20 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  	cpa_flush(&cpa, 0);
>  
>  	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
> -	if (!ret) {
> -		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> -			ret = -EIO;
> -	}
> +	if (ret)
> +		goto out;

IMO, you can avoid "out" label with (!ret && !x86_platform....) check. But it is upto
you.

>  
> +	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> +		goto vmm_fail;
> +
> +out:
>  	return ret;
> +
> +vmm_fail:
> +	WARN_ONCE(1, "CPA VMM failure to convert memory (addr=%p, numpages=%d) to %s.\n",
> +		  (void *)addr, numpages, enc ? "private" : "shared");
> +
> +	return -EIO;
>  }
>  
>  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
