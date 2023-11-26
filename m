Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981D47F93C4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 17:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjKZQ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 11:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZQ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 11:27:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F13BD3;
        Sun, 26 Nov 2023 08:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701016068; x=1732552068;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=aI1kuUAX1aIYfPW4zBmDRxcAyohGsXeNpLue5KrlY18=;
  b=VoujsxvKXZuNtu/GUQKL/N4435i/He82sl/2TOrvQYLuTsTbi3HMjuIC
   ExmFEXl6vCMCIHtzHr7Diw+JeFLdkUw9HEknycxGUyg+IBzsQCfCVM9GF
   ugW2F3hnG15d+CbcC+Yz110TH7Tc0MkslGWGWrXUkPpa3io1HBkHllCHn
   WSdsL8xgoJgHH5Oan3+cveGwD8gYrOrH+bkrFM/A9kniDyf3/bMYxGiHI
   PtxmUrhn83tEbOvYgjEDhGbwtD7hYueHkZOcFGlTNsrt8PfqNivpUICsJ
   SGmRCZ0seW2G6IrIBiAiAOq9oZOjVwyGKD7IMhUh2XsaT6Whpd/KBPEh4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="377624197"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="377624197"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 08:27:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="9406610"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.124.112.56])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 26 Nov 2023 08:27:43 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mkoutny@suse.com" <mkoutny@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "Huang, Kai" <kai.huang@intel.com>
Cc:     "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-10-haitao.huang@linux.intel.com>
 <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
Date:   Mon, 27 Nov 2023 00:27:39 +0800
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 11:45:46 +0800, Huang, Kai <kai.huang@intel.com> wrote:

> On Mon, 2023-10-30 at 11:20 -0700, Haitao Huang wrote:
>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>
>> To prepare for per-cgroup reclamation, separate the top-level reclaim
>> function, sgx_reclaim_epc_pages(), into two separate functions:
>>
>> - sgx_isolate_epc_pages() scans and isolates reclaimable pages from a  
>> given LRU list.
>> - sgx_do_epc_reclamation() performs the real reclamation for the  
>> already isolated pages.
>>
>> Create a new function, sgx_reclaim_epc_pages_global(), calling those two
>> in succession, to replace the original sgx_reclaim_epc_pages(). The
>> above two functions will serve as building blocks for the reclamation
>> flows in later EPC cgroup implementation.
>>
>> sgx_do_epc_reclamation() returns the number of reclaimed pages. The EPC
>> cgroup will use the result to track reclaiming progress.
>>
>> sgx_isolate_epc_pages() returns the additional number of pages to scan
>> for current epoch of reclamation. The EPC cgroup will use the result to
>> determine if more scanning to be done in LRUs in its children groups.
>
> This changelog says nothing about "why", but only mentions the  
> "implementation".
>
> For instance, assuming we need to reclaim @npages_to_reclaim from the
> @epc_cgrp_to_reclaim and its descendants, why cannot we do:
>
> 	for_each_cgroup_and_descendants(&epc_cgrp_to_reclaim, &epc_cgrp) {
> 		if (npages_to_reclaim <= 0)
> 			return;
>
> 		npages_to_reclaim -= sgx_reclaim_pages_lru(&epc_cgrp->lru,
> 					npages_to_reclaim);
> 	}
>
> Is there any difference to have "isolate" + "reclaim"?
>

This is to optimize "reclaim". See how etrack was done in sgx_encl_ewb.
Here we just follow the same design as ksgxd for each reclamation cycle.

>>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Cc: Sean Christopherson <seanjc@google.com>
>> ---
>>
>
> [...]
>
>> +/**
>> + * sgx_do_epc_reclamation() - Perform reclamation for isolated EPC  
>> pages.
>> + * @iso:		List of isolated pages for reclamation
>> + *
>> + * Take a list of EPC pages and reclaim them to the enclave's private  
>> shmem files.  Do not
>> + * reclaim the pages that have been accessed since the last scan, and  
>> move each of those pages
>> + * to the tail of its tracking LRU list.
>> + *
>> + * Limit the number of pages to be processed up to SGX_NR_TO_SCAN_MAX  
>> per call in order to
>> + * degrade amount of IPI's and ETRACK's potentially required.  
>> sgx_encl_ewb() does degrade a bit
>> + * among the HW threads with three stage EWB pipeline (EWB, ETRACK +  
>> EWB and IPI + EWB) but not
>> + * sufficiently. Reclaiming one page at a time would also be  
>> problematic as it would increase
>> + * the lock contention too much, which would halt forward progress.
>
> This is kinda optimization, correct?  Is there any real performance data  
> to
> justify this?

The above sentences were there originally. This optimization was justified.

> If this optimization is useful, shouldn't we bring this
> optimization to the current sgx_reclaim_pages() instead, e.g., just  
> increase
> SGX_NR_TO_SCAN (16) to SGX_NR_TO_SCAN_MAX (32)?
>

SGX_NR_TO_SCAN_MAX might be designed earlier for other reasons I don't  
know. Currently it is really the buffer size allocated in  
sgx_reclaim_pages(). Both cgroup and ksgxd scan 16 pages a time.Maybe we  
should just use SGX_NR_TO_SCAN. No _MAX needed. The point was to batch  
reclamation to certain number to minimize impact of EWB pipeline. 16 was  
the original design.

Thanks
Haitao
