Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F8B7571E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjGRCmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGRCmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:42:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F0113E;
        Mon, 17 Jul 2023 19:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689648150; x=1721184150;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=N1Z945a7kwVdmkZax5QRo2WNdPFX0UIjF1glFDN7Be8=;
  b=eJu0SE3DcHjl6rt/skVYJOR87nhUJVrWf5VHDQAsYZdnW+tzRqIcf1iP
   n/DBqPC4C/SIVFHrBUOX0gOYwDuyv8//R29xOZ1hZ59OsmEvKDa/SpJzP
   sMEs8U8LbZ/d3CxRW2IwDpUbDM5fXqma2/mGKlCvyGSPr3jNhkUel38nP
   fnKI/m9bnBqFoonlXefttSxvZOUdEkYXpmpvAlgEpFeuNozP25PiW3pg7
   9pnES+1LG/U6eDRD4dBFy2dGc+69nw7RTuR3NgBkn/qc7YPRPJqybPor+
   SGOa0L9p6vurxGJkDN/q4b119bWMBFpD8tIP8C094b4E9vxit2HEiiNBO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="346388869"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="346388869"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 19:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="717430933"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="717430933"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 17 Jul 2023 19:42:24 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
References: <38deca3161bd4c5f1698fd7b6c43aa3c7b94d3da.camel@intel.com>
 <20230718004529.16404-1-haitao.huang@linux.intel.com>
 <a0dbb519550bae23c2bd02cd9c5940f4e9b2a38a.camel@intel.com>
Date:   Mon, 17 Jul 2023 21:42:23 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.179a4xs0wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <a0dbb519550bae23c2bd02cd9c5940f4e9b2a38a.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
On Mon, 17 Jul 2023 20:39:31 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Mon, 2023-07-17 at 17:45 -0700, Haitao Huang wrote:
>> Under heavy load, the SGX EPC reclaimer (ksgxd) may reclaim the SECS EPC
>> page for an enclave and set encl->secs.epc_page to NULL. But the SECS
>> EPC page is used for EAUG in the SGX #PF handler without checking for
>> NULL and reloading.
>>
>> Fix this by checking if SECS is loaded before EAUG and loading it if it  
>> was
>> reclaimed.
>
> Nit:
>
> Looks the sentence break of the second paragraph isn't consistent with  
> the first
> paragraph, i.e., looks the first line is too long and the "was" should  
> be broken
> to the second line.
>
Yeah, I think I forgot to reformat this line after revising.

> And I think even for this simple patch, you are sending too frequently.   
> The
> patch subject should contain the version number too so people can  
> distinguish it
> from the previous one.  Even better, please use "--base=auto" when  
> generating
> the patch so people can know the base commit to apply to.

I'll send the next one as V2 and start a separate email thread.

>>
>> Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an  
>> initialized enclave")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> ---
>>  arch/x86/kernel/cpu/sgx/encl.c | 25 ++++++++++++++++++++-----
>>  1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/encl.c  
>> b/arch/x86/kernel/cpu/sgx/encl.c
>> index 2a0e90fe2abc..2ab544da1664 100644
>> --- a/arch/x86/kernel/cpu/sgx/encl.c
>> +++ b/arch/x86/kernel/cpu/sgx/encl.c
>> @@ -235,6 +235,16 @@ static struct sgx_epc_page *sgx_encl_eldu(struct  
>> sgx_encl_page *encl_page,
>>  	return epc_page;
>>  }
>>
>> +static struct sgx_epc_page *sgx_encl_load_secs(struct sgx_encl *encl)
>> +{
>> +	struct sgx_epc_page *epc_page = encl->secs.epc_page;
>> +
>> +	if (!epc_page)
>> +		epc_page = sgx_encl_eldu(&encl->secs, NULL);
>> +
>> +	return epc_page;
>> +}
>> +
>>  static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl  
>> *encl,
>>  						  struct sgx_encl_page *entry)
>>  {
>> @@ -248,11 +258,9 @@ static struct sgx_encl_page  
>> *__sgx_encl_load_page(struct sgx_encl *encl,
>>  		return entry;
>>  	}
>>
>> -	if (!(encl->secs.epc_page)) {
>> -		epc_page = sgx_encl_eldu(&encl->secs, NULL);
>> -		if (IS_ERR(epc_page))
>> -			return ERR_CAST(epc_page);
>> -	}
>> +	epc_page = sgx_encl_load_secs(encl);
>> +	if (IS_ERR(epc_page))
>> +		return ERR_CAST(epc_page);
>>
>>  	epc_page = sgx_encl_eldu(entry, encl->secs.epc_page);
>>  	if (IS_ERR(epc_page))
>> @@ -339,6 +347,13 @@ static vm_fault_t sgx_encl_eaug_page(struct  
>> vm_area_struct *vma,
>>
>>  	mutex_lock(&encl->lock);
>>
>> +	epc_page = sgx_encl_load_secs(encl);
>> +	if (IS_ERR(epc_page)) {
>> +		if (PTR_ERR(epc_page) == -EBUSY)
>> +			vmret =  VM_FAULT_NOPAGE;
> 				^
> Nit: two spaces here (yeah you copied from the existing code, and sorry  
> forgot
> to point out in the previous version).
>
Sure. will fix in V2.

Thanks
Haitao
