Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C2758616
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGRUcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGRUcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:32:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA84EC;
        Tue, 18 Jul 2023 13:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689712331; x=1721248331;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=YPS/oZy/ScoJeBSomzCuk23OOMOLqO/WMB9bvX6bl+s=;
  b=cv3e4zUOwxtzH8Y6aYGUYP4OH88bxe8O/hdKOc78CpjHQtFj0QMZoC54
   jurutkgpdH0xMRQzH5A5AmMmfyK2ZxyjKkZ1ESYuJbGV0QVWWWtc6a60Y
   7oKM/vI7avyw/bJ/fecN5DpHNMTR09uR4W3RyADIg9MURN7q1qekFJQ/p
   umSaAaR7MOOdrI7f+GBTMVAJPPQuzy72STWAw1INcjjf8n6cmAeuMMD9T
   WgscXvBJE8RicEEfawye7+goIbnBIb3Voat1CcqKw/OXF7niqrUWfgCbX
   AM4xbBAtyoKKa2pmcyz7wxmtFU3IGfex8fLKwsmUzLF28daxX034qoFaM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="369865095"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="369865095"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 13:32:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="793756187"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="793756187"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 18 Jul 2023 13:32:08 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@intel.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        kristen@linux.intel.com, seanjc@google.com, stable@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
 <20230717202938.94989-1-haitao.huang@linux.intel.com>
 <dfb1f233-aebd-50cf-8704-e83b91ee110a@intel.com>
 <op.18ah5mn3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <b5779418-e2a4-ca7a-866f-97e49cd272cb@intel.com>
Date:   Tue, 18 Jul 2023 15:32:07 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18aontlmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <b5779418-e2a4-ca7a-866f-97e49cd272cb@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 13:53:47 -0500, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 7/18/23 11:11, Haitao Huang wrote:
>> On Tue, 18 Jul 2023 09:27:49 -0500, Dave Hansen <dave.hansen@intel.com>
>> wrote:
>>
>>> On 7/17/23 13:29, Haitao Huang wrote:
>>>> Under heavy load, the SGX EPC reclaimers (current ksgxd or future EPC
>>>> cgroup worker) may reclaim the SECS EPC page for an enclave and set
>>>> encl->secs.epc_page to NULL. But the SECS EPC page is used for EAUG in
>>>> the SGX #PF handler without checking for NULL and reloading.
>>>>
>>>> Fix this by checking if SECS is loaded before EAUG and load it if it  
>>>> was
>>>> reclaimed.
>>>
>>> It would be nice to see a _bit_ more theory of the bug in here.
>>>
>>> What is an SECS page and why is it special in a reclaim context?  Why  
>>> is
>>> this so hard to hit?  What led you to discover this issue now?  What is
>>> EAUG?
>>
>> Let me know if this clarify things.
>>
>> The SECS page holds global states of an enclave, and all reclaimable
>> pages tracked by the SGX EPC reclaimer (ksgxd) are considered 'child'
>> pages of the SECS page corresponding to that enclave.  The reclaimer
>> only reclaims the SECS page when all its children are reclaimed. That
>> can happen on system under high EPC pressure where multiple large
>> enclaves demanding much more EPC page than physically available. In a
>> rare case, the reclaimer may reclaim all EPC pages of an enclave and it
>> SECS page, setting encl->secs.epc_page to NULL, right before the #PF
>> handler get the chance to handle a #PF for that enclave. In that case,
>> if that #PF happens to require kernel to invoke the EAUG instruction to
>> add a new EPC page for the enclave, then a NULL pointer results as
>> current code does not check if encl->secs.epc_page is NULL before using  
>> it.
>
> Better, but that's *REALLY* verbose and really imprecise.  It doesn't
> _require_ "high pressure".  It could literally happen at very, very low
> pressures over a long period of time.

I don't quite get this part. In low pressure scenario, the reclaimer never  
need to reclaim all children of SECs. So it would not reclaim SECS no  
matter how long you run?

Ignore VA pages for now. Say for a system with 10 page EPC, 2 enclaves,  
each needs 5 pages non-SECS so total demand would be 12 pages. The ksgxd  
would only need to swap out 2 pages at the most to get one enclave fully  
loaded with 6 pages, and the other one with 4 pages. There is no chance  
the ksgxd would swap any one of two SECS pages.

We would need at least one enclave A of 10 pages total to squeeze out the  
other B completely. For that to happen B pretty much has to be sleeping  
all the time so the LRU based reclaiming would hit it but not pages of A.  
So no chance to hit #PF on pages of B still.

So some minimal pressure is needed to ensure SECS swapped. The higher the  
pressure the higher the chance to hit #PF while SECS is swapped.

> Please stick to the facts and
> it'll actually simplify the description.
>
> 	The SECS page holds global enclave metadata.  It can only be
> 	reclaimed when there are no other enclave pages remaining.  At
> 	that point, virtually nothing can be done with the enclave until
> 	the SECS page is paged back in.
>
> 	An enclave can not run nor generate page faults without without
> 	a resident SECS page.  But it is still possible for a #PF for a
> 	non-SECS page to race with paging out the SECS page.
>
> 	Hitting this bug requires triggering that race.
>
Thanks for the suggestion. I agree on those.

>> The bug is easier to reproduce with the EPC cgroup implementation when a
>> low EPC limit is set for a group of enclave hosting processes. Without
>> the EPC cgroup it's hard to trigger the reclaimer to reclaim all child
>> pages of an SECS page. And it'd also require a machine configured with
>> large RAM relative to EPC so no OOM killer triggered before this  
>> happens.
>
> Isn't this the _normal_ case?  EPC is relatively tiny compared to RAM
> normally.

I don't know what is perceived as normal here. But for this to happen, the  
swapping space should be able to hold content much bigger than EPC, if my  
reasoning above for high pressure required is correct. I tried 70  
concurrent sgx selftests instances on a server with 4G EPC, 512G RAM and  
no disk swapping, and encountered OOM first. Those selftests instance each  
demand about 8G EPC.

Thanks
Haitao
