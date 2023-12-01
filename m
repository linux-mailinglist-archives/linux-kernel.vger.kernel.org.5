Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB3280133C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379300AbjLAS6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAS6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:58:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879F4F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701457137; x=1732993137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KdH8rNr6rIsUowxaWpyxPet7eTNgskqdmoDetyism0A=;
  b=CngWbAAsr8ztQIs32cXXFsW1t1JwSPCVHxy5MlI0WAIXbWduvQZ2RNpd
   xIrPxOz4cPhq/meLtVS1mj3v3Hy8/6uABmaVR2Hl5g9l5FsNM0v66E+1B
   P+Dxgz6UZk8RrWq7N0IuW3xEAF++fhyu5Z+R/DUy3jjKOhgArNfCk6KTJ
   uxzQNDdWEf6LJJr0h6PXQGT4NF3You+TLMnqBaQGGFoxKOF/3QJKswLPC
   Z6E2IN6DVNBe9HXeWVEtmbVnJ5We3UyZt3PSURydqXtUb3ErrT5mxeTJq
   AzwOGZAQYeiGE6oAKAEszXVpONw0nOpfG8IEz4n44lnhOZnmRjSjf9p1a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="457861895"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="457861895"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 10:58:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="835852530"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="835852530"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 10:58:56 -0800
Date:   Fri, 1 Dec 2023 10:58:55 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Filippo Sironi <sironi@amazon.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-edac@vkeg.kernel.org, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com
Subject: Re: [PATCH] x86/MCE: Get microcode revision from cpu_data instead of
 boot_cpu_data
Message-ID: <ZWos70EKhlAl2VPb@agluck-desk3>
References: <20231201112327.42319-1-sironi@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201112327.42319-1-sironi@amazon.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 11:23:27AM +0000, Filippo Sironi wrote:
> Commit fa94d0c6e0f3 ("x86/MCE: Save microcode revision in machine check
> records") extended MCE entries to report the microcode revision taken
> from boot_cpu_data. Unfortunately, boot_cpu_data isn't updated on late
> microcode loading, thus making MCE entries slightly incorrect.  Use

This code in intel.c:apply_microcode_late() looks like it tries to update
boot_cpu_data:

466         cpu_data(cpu).microcode  = uci->cpu_sig.rev;
467         if (!cpu)
468                 boot_cpu_data.microcode = uci->cpu_sig.rev;

Is that not working for some reason?

> cpu_data instead, which is updated on late microcode loading. This also
> fixes the corner case in which the microcode revision isn't coherent
> across CPUs (which may happen on late microcode loading failure).

But this does seem a worthwhile change to help diagnose things if late
load is somehow only applied to some subset of CPUs.
> 
> Signed-off-by: Filippo Sironi <sironi@amazon.de>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 7b397370b4d6..e1b033298db0 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -127,7 +127,7 @@ void mce_setup(struct mce *m)
>  	m->apicid = cpu_data(m->extcpu).topo.initial_apicid;
>  	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
>  	m->ppin = cpu_data(m->extcpu).ppin;
> -	m->microcode = boot_cpu_data.microcode;
> +	m->microcode = cpu_data(m->extcpu).microcode;
>  }
>  
>  DEFINE_PER_CPU(struct mce, injectm);
> -- 
> 2.33.0

-Tony
