Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62467655B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjG0OQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjG0OQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:16:38 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6E230C0;
        Thu, 27 Jul 2023 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690467397; x=1722003397;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=e7XwQAboRx8pLj3NqJweHiC0cjRxIvvy1IBoJET32ao=;
  b=di8mEmeBD8LIrdhhuD+T9w/zX//4O38J2yP7pPpGXdqy9KPPAnBRJpOq
   ANrO1Q3sGqn4RH3a1wuaZFhDyFgzivzW2PC8g+FDUTTtqZlIQBbece7Gn
   Z3zig57xh0CuMzJWR+XJ7rn4T4GsIRsnSzEogezAQzDA3VsdveJv3Xm+x
   O4usIlFxsaJliDMhSTAm5PdRaGEi+JtHErgs4Qe8vIQan047ZVoiphhVY
   IC4lrZ0JKeYzSGd9qjgC/X1rtINXlFfdxAsiutRhCycELM7X0gS5v/JZv
   1FlP4Cbfjf/HFgvrQoC2/EAfAEpPMk6MdcqHcJUz9dbkqgeLZDtEldxQp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="368337269"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="368337269"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 07:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="704177600"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="704177600"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 27 Jul 2023 07:16:10 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: Re: [PATCH v5] x86/sgx: Resolves SECS reclaim vs. page fault for EAUG
 race
References: <20230727010212.26406-1-haitao.huang@linux.intel.com>
 <c57d8cc4e4bfbef028a1f226ec2c4691a7c100fe.camel@intel.com>
Date:   Thu, 27 Jul 2023 09:16:06 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18qu84gewjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <c57d8cc4e4bfbef028a1f226ec2c4691a7c100fe.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 21:50:02 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Wed, 2023-07-26 at 18:02 -0700, Haitao Huang wrote:
>> Under heavy load, the SGX EPC reclaimer (ksgxd) may reclaim the SECS EPC
>
> If I read correctly, Dave suggested to not use "high" (heavy in this  
> sentence)
> or "low" pressure:
>
> https://lore.kernel.org/lkml/op.179a4xs0wjvjmi@hhuan26-mobl.amr.corp.intel.com/T/#m9120eac6a4a94daa7c9fcc47709f241cd181e5dc
>
> And I agree.  For instance, consider this happens to one extremely  
> "small"
> enclave, while there's a new "big" enclave starts to run.  I don't think  
> we
> should say this is "under heavy load".  Just stick to the fact that the
> reclaimer may reclaim the SECS page.
>
Mybe I have some confusion here but I did not think Dave had issues with  
'heavy load'. When this happens, the last page causing #PF (page A below)  
should be the the "youngest" in PTE and it got paged out together with the  
SECS before the #PF is even handled. Based on that the ksgxd moves 'young'  
pages to the back of the queue for reclaiming, for that to happen, almost  
all EPC pages must be paged out for all enclaves at that time, so it means  
heavy load to me.  And that's also consistent with my tests.

>> page for an enclave and set encl->secs.epc_page to NULL. But the SECS
>> EPC page is used for EAUG in the SGX page fault handler without checking
>> for NULL and reloading.
>>
>> Fix this by checking if SECS is loaded before EAUG and loading it if it
>> was reclaimed.
>>
>> The SECS page holds global enclave metadata. It can only be reclaimed
>> when there are no other enclave pages remaining. At that point,
>> virtually nothing can be done with the enclave until the SECS page is
>> paged back in.
...
>> But it is still possible for a #PF for a non-SECS page to race
>> with paging out the SECS page: when the last resident non-SECS page A
>> triggers a #PF in a non-resident page B, and then page A and the SECS
>> both are paged out before the #PF on B is handled.
>>
>> Hitting this bug requires that race triggered with a #PF for EAUG.
>
> The above race can happen for the normal ELDU path too, thus I suppose  
> it will
> be better to mention why the normal ELDU path doesn't have this issue: it
> already does what this fix does.
>
Should we focus on the bug and fix itself instead of explaining a non-bug  
case?
And the simple changes in this patch clearly show that too if people look  
for that.

Thanks
Haitao
