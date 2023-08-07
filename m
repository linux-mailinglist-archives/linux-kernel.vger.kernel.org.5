Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DD077302C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjHGULt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjHGULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:11:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBA210C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691439104; x=1722975104;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x8cR585u3FQ3zMVGSS9wRn+Vlf2HCVEnerMfJWVDqo8=;
  b=AzB4T0xEYiz7XgC9Z4XOyIbNv15wyU/Rk8tTSnAyX46dWp1cvnOn5PSA
   n54ZlX+4c0efycK+hEgHw72G3cS6raUA+pjOk3+//syAuEmmkfHk6u4xx
   eGFJwKaIXIWF8Pglqe3HgfCg2RC2681I8ngbgX3KZzpA96uqAZLB4veb0
   Tvn0hTC6zUSytsuis/U3KU2IeE1kJrX2L8Rvoe6hTWX2hBuEqajZDofu+
   LwDogszPoNgpczzUnznQz4VTetuxUcY6xhewS3nG6JK9ATlDanpZ33SBH
   Pnh1c/hf0OSLddtdD2uW7aymiWlRBS8Ou3tex5pGOcI0tnDemjMfInDT1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374314684"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="374314684"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 13:11:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="904935533"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="904935533"
Received: from nyamoah-mobl.amr.corp.intel.com (HELO [10.212.249.113]) ([10.212.249.113])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 13:11:43 -0700
Message-ID: <09100858-3be2-a9f2-e0af-b6cad67d760b@intel.com>
Date:   Mon, 7 Aug 2023 13:11:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch V3 26/60] x86/apic/32: Decrapify the def_bigsmp mechanism
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20230801103042.936020332@linutronix.de>
 <20230801103816.584394452@linutronix.de>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230801103816.584394452@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 03:47, Thomas Gleixner wrote:
...
> -void __init default_setup_apic_routing(void)
> +void __init x86_32_probe_bigsmp_early(void)
>  {
> -	int version = boot_cpu_apic_version;
> +	if (nr_cpu_ids <= 8 || xen_pv_domain())
> +		return;
...
> +void __init default_setup_apic_routing(void)
> +{
> +	if (nr_cpu_ids >= 8 && !xen_pv_domain())
> +		apic_bigsmp_force();

I thought bigsmp didn't come into play until 9 or more CPUs.  Won't this
do apic_bigsmp_force() at nr_cpu_ids==8?

Should this be:

	if (nr_cpu_ids > 8 && !xen_pv_domain())
		apic_bigsmp_force();

?
