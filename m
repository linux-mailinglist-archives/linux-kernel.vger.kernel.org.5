Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F4F754463
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGNVp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjGNVpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:45:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567ED35A6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689371123; x=1720907123;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hin/ZSPOlmippguNJSSMcjUnsOREXi7smCJb0j/RT5g=;
  b=lP6pVxXxclAzrQUEaLYkqvbjdGvdaHA5xTOb4IqHfIizg4ZNXfnLQsV0
   tPKLdxCqToBLhEZBzr4qtaYAyfh4V2okJ0Lso5kd5w+HdQ1J1Ttb4Iu6/
   5oDOMWV+UEc4tmWU8ueX3eXaS86fvKecXbzguiD9xVMM77AiEpNsVG9we
   NLmkwpT1pevDl3qoktr7NJhXKXLTE0krPYJXkyuAhxkIJJ46Gk6ZMzn01
   5FI/2vVDDci+EHdMcGhCqiZ0Na3w0NKL33WWPymM34kv4Nvc46owkEwH/
   ugJuT5Y88gNjtMPYI3fmh1Ek1LPMYh8A2t86J4H5L7YdwQa4nUA4Jm8rP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="345894228"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="345894228"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 14:45:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="752189014"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="752189014"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.251.9.164]) ([10.251.9.164])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 14:45:22 -0700
Message-ID: <ab419bb9-1065-5200-5b22-32f36b0426a8@linux.intel.com>
Date:   Fri, 14 Jul 2023 14:45:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc:     Bruno Goncalves <bgoncalv@redhat.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
 <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
 <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
 <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
 <20230711132553.GN3062772@hirez.programming.kicks-ass.net>
 <0837a34c-f66e-aa04-d4a7-b032d3dbab7a@intel.com>
 <20230714211021.GB3275140@hirez.programming.kicks-ass.net>
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20230714211021.GB3275140@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/2023 2:10 PM, Peter Zijlstra wrote:
> On Tue, Jul 11, 2023 at 08:37:51PM +0200, Wysocki, Rafael J wrote:
> 
>>> Rafael, can we please just pull these patches and try again later?
>>
>> I think you mean "revert"?
> 
> Yes, revert. The whole premise with the unparsable changelog that
> babbles about TLB invalidates without any performance data-so-ever
> should've been a red-flag.
> 
> That whole TLB angle is nonsense. We have paravirt TLB invalidation for
> this.

for kvm and hyperv. not for vmware etc.

