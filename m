Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DEE75453E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 01:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGNXCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 19:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGNXCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 19:02:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063B810EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689375722; x=1720911722;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nv6bsv4lCKNQWU9REWk6rzqQGdzh6aOrDtuaCZCPwwo=;
  b=lU4mQDaJq90BR9z9vYGAcxtYU3MY3LQmmOSbfDlDbhaNiocQD7JXjp38
   C4J8z4Pos2qqIrctzE+puDjLzTxFnI2Oei+G2R9OWCBxl9F6nQZGh0xG1
   Chl2Tc1KEEiUsNjvZ23RGpNX+hRlQa83W3bnoAj42OjE5GygZUqNrrv6E
   rjOrpYRCVkg4Q12HWVEQfJ2t2XYL/ArHSyRWQySg8G6HgBAukzl4xJaat
   0Qhi/YvgfkvTTMR3xoEqGjYQwA48Ys9l68lD2kXpoaoefLi8Ee/2/Khxe
   tZa/NDd5RFUrYHOLTLX7IbnUpdPooqNjRxTzHLnfacOwZznE/4Ay1rugI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="396412698"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="396412698"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 16:02:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="699854728"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="699854728"
Received: from jdvande1-mobl1.amr.corp.intel.com (HELO [10.255.228.32]) ([10.255.228.32])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 16:01:59 -0700
Message-ID: <92462889-16e9-5c7b-a524-fe53859f93c1@intel.com>
Date:   Fri, 14 Jul 2023 16:01:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/mm: Remove "INVPCID single" feature tracking
Content-Language: en-US
To:     andrew.cooper3@citrix.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, jannh@google.com, x86@kernel.org,
        luto@kernel.org, peterz@infradead.org
References: <20230714183555.7DD052F4@davehans-spike.ostc.intel.com>
 <df0750e0-dd6f-7418-53bd-64a9ad1e0086@citrix.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <df0750e0-dd6f-7418-53bd-64a9ad1e0086@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 13:27, andrew.cooper3@citrix.com wrote:
>> +	/* If PTI is off there is no user PCID and nothing to flush. */
>>  	if (!static_cpu_has(X86_FEATURE_PTI))
>>  		return;
> 
> As a minor observation, the common case is for the function to exit
> here, but you've got both this_cpu_read()'s ahead of a full compiler
> memory barrier.
> 
> If you move them here, you'll drop the reads from the common case.
> But...

That's a good point.  I was depending on the generosity of the compiler
but the invlpg throws that out the window.  I'll move them around.

>>  	/*
>> -	 * Some platforms #GP if we call invpcid(type=1/2) before CR4.PCIDE=1.
>> -	 * Just use invalidate_user_asid() in case we are called early.
>> +	 * invpcid_flush_one(pcid>0) will #GP if CR4.PCIDE==0.  Check
>> +	 * 'cpu_pcide' to ensure that *this* CPU will not trigger those
>> +	 * #GP's even if called before CR4.PCIDE has been initialized.
>>  	 */
>> -	if (!this_cpu_has(X86_FEATURE_INVPCID_SINGLE))
>> -		invalidate_user_asid(loaded_mm_asid);
>> -	else
>> +	if (boot_cpu_has(X86_FEATURE_INVPCID) && cpu_pcide)
> ... why can't this just be && loaded_mm_asid ?
> 
> There's no plausible way the asid can be nonzero here without CR4.PCIDE
> being set, and that avoids looking at cr4 directly.

Except that 0 is a valid, normal 'loaded_mm_asid' value.  It would be
quite possible to have loaded_mm_asid==0 during normal runtime which
would drop down into the invalidate_user_asid() case.  It would work,
but it would be unnecessarily destructive to the TLB.

I guess we _could_ adjust the asids to go from 1=>TLB_NR_DYN_ASIDS
instead of 0=>TLB_NR_DYN_ASIDS-1.  *But*, PTI is slow path code these
days.  I'd rather read one more (presumably) cache hot variable that's
logically clear than go messing with the ASID allocation code making
ASID 0 even more special.
