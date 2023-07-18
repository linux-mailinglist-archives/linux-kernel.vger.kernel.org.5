Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9039D7586C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjGRVWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGRVWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:22:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEF79D;
        Tue, 18 Jul 2023 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689715369; x=1721251369;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=pjVJw6GiD8De53zFr+sIXnTzakqEin8Mim8XJ1OncwA=;
  b=OW7mKFiYpq7WXHOZlkqsG5JOgEhafpqVPmYIYji4/PwtesncsI9hiG1I
   Fj0gFMl380KI+Z9HFsu9pzketsZJlxPjKEzOXGy9K2yYEr4/5Vrhn1kCw
   FhSC1IENGNFiO003OmLAY9j9XlrgBW4utfgRaC0Q4/sEbsKv+f0qxVxFU
   7shRCjdsCS0OtMeDcz+SLIcNN6ba/Nrfp+mCWlPB+2ZuOCIzyUlCRcHW5
   Zpj56QTApSbNT3cuvRvyJEg3G9VwewU3Wxmt5b3wlS0WgNoqY/+Wr988F
   IZKJXg2u/3h1xTxT4k/mJa+BYk4zBlELvm16tMpAgDGUVq6bNGfPleZMW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="363774372"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="363774372"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:22:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847837663"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="847837663"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 18 Jul 2023 14:22:46 -0700
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
 <op.18aontlmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <eb1aea6f-3688-f871-2335-ff911a51ef52@intel.com>
Date:   Tue, 18 Jul 2023 16:22:45 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18aqz7sbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <eb1aea6f-3688-f871-2335-ff911a51ef52@intel.com>
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

On Tue, 18 Jul 2023 15:56:27 -0500, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 7/18/23 13:32, Haitao Huang wrote:
> ...
>> Ignore VA pages for now. Say for a system with 10 page EPC, 2 enclaves,
>> each needs 5 pages non-SECS so total demand would be 12 pages. The ksgxd
>> would only need to swap out 2 pages at the most to get one enclave fully
>> loaded with 6 pages, and the other one with 4 pages. There is no chance
>> the ksgxd would swap any one of two SECS pages.
>>
>> We would need at least one enclave A of 10 pages total to squeeze out
>> the other B completely. For that to happen B pretty much has to be
>> sleeping all the time so the LRU based reclaiming would hit it but not
>> pages of A. So no chance to hit #PF on pages of B still.
>>
>> So some minimal pressure is needed to ensure SECS swapped. The higher
>> the pressure the higher the chance to hit #PF while SECS is swapped.
>
> What would the second-to-last non-SECS page be?  A thread control page?
> VA page?
>
> As long as *that* page can generate a page fault, then you only need two
> pages for this scenario to happen:
>
> 1. Reclaimer takes encl->lock
> 2. #PF occurs from another thread, blocks on encl->lock
> 3. SECS is reclaimed
> 4. encl->lock released
> 5. #PF sees reclaimed SECS
>
>
I agree this is the race. But for this to happen, that is at #1 you have  
only one non-SECS page left so #3 can happen. That means it is already  
high pressure because reclaimer has swapped all other non-SECS.
In my example of two enclaves of 5 non-EPC pages. #3 won't happen because  
you don't reach #1 with only one non-SECS left.

Thanks
Haitao
