Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D39754472
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjGNVrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjGNVrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:47:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D12B3A86
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689371246; x=1720907246;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U9IYjXe1hVbKh6J8z4uLxx2x7zmV/SMrJyKMB29SNcw=;
  b=OdynOHxOsm6+NDAeWFIKlGRGlFOrUYVa0dX16KJbQx44AkAN0vUJ1aRQ
   oY9sXEZk7vkjxTgx/ruK3NCTsFWYO9lVBK/WOocUGgFIpdNgCvD02PKK7
   ZZ45OO0ss2spUwbEwpE4BgQxp7N0D2LQI0xYBOChMCOb/2AtV4U9q/6j/
   ZJI8Yr/OuPJAT4E86N8MD8GcAE3nEdgc24gVVydw3U0xwTvPYdkH2HBaT
   qptChdVLHG2ptSHiSMwbeB3xOsSu3lMeGjnGPg6Ijz0gxLyGporBwVZ1k
   /nOm4MS6Ywv4bkaXDDh5FHm8p+mpeyL/62yQwGlfeXJT7Omu3WdzdMYCZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="365623674"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="365623674"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 14:47:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="792552670"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="792552670"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.251.9.164]) ([10.251.9.164])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 14:47:25 -0700
Message-ID: <6ce7c4d8-3320-7712-a562-a43224c2602b@linux.intel.com>
Date:   Fri, 14 Jul 2023 14:47:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bruno Goncalves <bgoncalv@redhat.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
 <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
 <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
 <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
 <20230711132553.GN3062772@hirez.programming.kicks-ass.net>
 <0837a34c-f66e-aa04-d4a7-b032d3dbab7a@intel.com>
 <b672c500-5f2f-d60c-84da-80269b8b420f@linux.intel.com>
 <20230714211109.GC3275140@hirez.programming.kicks-ass.net>
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20230714211109.GC3275140@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/2023 2:11 PM, Peter Zijlstra wrote:
> On Tue, Jul 11, 2023 at 11:39:53AM -0700, Arjan van de Ven wrote:
>> On
>>> I think you mean "revert"?
>>>
>>> That can be done, but maybe it can be fixed instead?
>>
>> this specific issue I will fix shortly (together with the RDMSR thing)
> 
> I still don't know why this needs to be in intel_idle.

we can do a seperate idle driver; it'll still be x86 specific (since idle really is arch specific)...
and then the umwait parts of this will be Intel specific.. as well any future idle methods ..
and I'm not sure the AMD folks would even want it used .... at which point it ends up Intel
specific fully and we now have 2 Intel idle drivers.
I don't see how that makes sense.



