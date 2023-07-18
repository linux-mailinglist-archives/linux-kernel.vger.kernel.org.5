Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0743875824E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjGRQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjGRQkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:40:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94362171C;
        Tue, 18 Jul 2023 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689698409; x=1721234409;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=UD4tx2ko1Ntid4p2qUjYdfLq2O8toM+6lgpiCZu5QuE=;
  b=PAIMvxwwyrULQCWvkXKiUzmDKJM86RRoFTRhDfxmz838paZdN7Rjs8J9
   m+rQH2AGJzIF1VzW8aEc4ra4aNbYrk4usrQGDEMy6U5rOMwnotk+S/dD6
   i7EHPO0xsrTGY1Cqr/FeBCufs1OZdg0U3mn5xBjZBGAJSzGXy22HTopcF
   aA1mOkD/8J5g8GIwZw9ROOO+MloCxXvzUJVneKfLrPEHgfs7hLyJCNiQN
   HM25LEQKzlLPbI2BQpIlfNyqzY05ZCzkT2NzgZhKNTtYlx4/DwuFg0Mik
   XQhLRoYuOwNJH2RLEXlTp04y5HtsI0kn/P0x221JSALFL+ehzZVUlBgcq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="397096521"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="397096521"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 09:40:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="700975518"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="700975518"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 18 Jul 2023 09:39:57 -0700
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
 <95371eef-73ec-5541-ad97-829954cfb848@intel.com>
Date:   Tue, 18 Jul 2023 11:39:56 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18adwup7wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <95371eef-73ec-5541-ad97-829954cfb848@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 09:30:11 -0500, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 7/17/23 13:29, Haitao Huang wrote:
> ...
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
>> +		goto err_out_unlock;
>> +	}
>
> Whenever I see one of these "make sure it isn't NULL", I always jump to
> asking what *keeps* it from becoming NULL again.  In both cases here, I
> think that's encl->lock.
>
Yes, encl->lock protects all enclave states, the xarray holding  
encl_pages, SECS, VAs, etc.

> A comment would be really nice here, maybe on sgx_encl_load_secs().   
> Maybe:
>
> /*
>  * Ensure the SECS page is not swapped out.  Must be called with
>  * encl->lock to protect _____ and ensure the SECS page is not
>  * swapped out again.
>  */
>
Thanks for the suggestion. Lock should be held for the duration of SECS  
usage.
So something like this?
/*
  * Ensure the SECS page is not swapped out.  Must be called with
  * encl->lock to protect the enclave states including SECS and
  * ensure the SECS page is not swapped out again while being used.
  */


>> diff --git a/arch/x86/kernel/cpu/sgx/main.c  
>> b/arch/x86/kernel/cpu/sgx/main.c
>> index 166692f2d501..4662a364ce62 100644
>> --- a/arch/x86/kernel/cpu/sgx/main.c
>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>> @@ -257,6 +257,10 @@ static void sgx_reclaimer_write(struct  
>> sgx_epc_page *epc_page,
>>
>>  	mutex_lock(&encl->lock);
>>
>> +	/* Should not be possible */
>> +	if (WARN_ON(!(encl->secs.epc_page)))
>> +		goto out;
>
> That comment isn't super helpful.  We generally don't WARN_ON() things
> that should happen.  *Why* is it not possible?
>

When this part of code is reached, the reclaimer is holding at least one  
reclaimable EPC page to reclaim for the enclave and the code below only  
reclaims SECS when no reclaimable EPCs (number of SECS children being  
zero) of the enclave left. So it should not be possible.
I'll remove this change because this is really not needed for fixing the  
bug as Kai pointed out.

I added this for sanity check when implementing multiple EPC tracking  
lists for cgroups. At one point there were list corruption issues if  
moving EPCs between lists not managed well. With those straightened out,  
and clear definitions of EPC states for moving them from one list to  
another, I no longer see much value to keep this even in later cgroup  
patches.

Thanks
Haitao
