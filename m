Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AFB757F79
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjGROaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGROaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:30:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8039E;
        Tue, 18 Jul 2023 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689690613; x=1721226613;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VJrp3IJhInZ+SzZ0nDfPX4wCUgu4MkTGZuFgcyrPrfc=;
  b=gHzc7/xrpK0tLHIRXishGPZQTr5yYnrYO0EB0D/tZvjT3hPEePBrHr2A
   J3jjgEIjRz0GCrAeTQj8YE9NoISF3HYP7Npkg8HxQEdDwCmJNWaB8HBap
   afqNXGZ2098ptGMd2N6gtPKWSdjiDBbKYa7ozXTG1v12iJLY8WAV6ktgI
   0PNRWIj4NJFQSvEK2NdnjxGMbKjn2mLDXUQtRcTy9dvxYAs9RZBIz5r2Y
   TmqXkNYUnJnGVdr0+DueUsD00Ra9tKTaNSmW8JqzAz8wisne6ETZ2er76
   MoFLdD2hSxL91FkQXmjiiVJQHXc3IN0olRV+qa5gRuRsq94mA7Z6TqmqP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="368863511"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="368863511"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 07:30:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="700928252"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="700928252"
Received: from pkarurmo-mobl.amr.corp.intel.com (HELO [10.209.37.195]) ([10.209.37.195])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 07:30:11 -0700
Message-ID: <95371eef-73ec-5541-ad97-829954cfb848@intel.com>
Date:   Tue, 18 Jul 2023 07:30:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
Content-Language: en-US
To:     Haitao Huang <haitao.huang@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        kristen@linux.intel.com, seanjc@google.com, stable@vger.kernel.org
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
 <20230717202938.94989-1-haitao.huang@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230717202938.94989-1-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 13:29, Haitao Huang wrote:
...
> @@ -248,11 +258,9 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
>  		return entry;
>  	}
>  
> -	if (!(encl->secs.epc_page)) {
> -		epc_page = sgx_encl_eldu(&encl->secs, NULL);
> -		if (IS_ERR(epc_page))
> -			return ERR_CAST(epc_page);
> -	}
> +	epc_page = sgx_encl_load_secs(encl);
> +	if (IS_ERR(epc_page))
> +		return ERR_CAST(epc_page);
>  
>  	epc_page = sgx_encl_eldu(entry, encl->secs.epc_page);
>  	if (IS_ERR(epc_page))
> @@ -339,6 +347,13 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
>  
>  	mutex_lock(&encl->lock);
>  
> +	epc_page = sgx_encl_load_secs(encl);
> +	if (IS_ERR(epc_page)) {
> +		if (PTR_ERR(epc_page) == -EBUSY)
> +			vmret =  VM_FAULT_NOPAGE;
> +		goto err_out_unlock;
> +	}

Whenever I see one of these "make sure it isn't NULL", I always jump to
asking what *keeps* it from becoming NULL again.  In both cases here, I
think that's encl->lock.

A comment would be really nice here, maybe on sgx_encl_load_secs().  Maybe:

/*
 * Ensure the SECS page is not swapped out.  Must be called with
 * encl->lock to protect _____ and ensure the SECS page is not
 * swapped out again.
 */

> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 166692f2d501..4662a364ce62 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -257,6 +257,10 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
>  
>  	mutex_lock(&encl->lock);
>  
> +	/* Should not be possible */
> +	if (WARN_ON(!(encl->secs.epc_page)))
> +		goto out;

That comment isn't super helpful.  We generally don't WARN_ON() things
that should happen.  *Why* is it not possible?

