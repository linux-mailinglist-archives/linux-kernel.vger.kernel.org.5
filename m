Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2527B6B62
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbjJCOYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbjJCOYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:24:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4EEC9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696343038; x=1727879038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A61WT88VnkzMQHVjtx4hwP9zSYAWPhVnWpEue6pcglA=;
  b=dKo/UiqQlR+Ha/6wY6wUbHdcV4K5R8GL1rOP9nAeTBMHP/vWlG2GP/de
   O0Ix4bxjKVlHwO1SYgGDHNf8V/C3nSVfgbidwqDG/fzrlpfMOs/wyf9tX
   dPdjQiEb3I9q7090twWHXiRr+aBqiHH1p216fsOC32H1UzmXejlR0c9Mw
   8N+Qbq2y4UsF074Zn1zWYDA441SpJrOG9U7gHw67hx2XOg4XgVTfBGFsD
   FtF8X8hDG82Q/rMa1zrf526/y+Rew0Z5flR4qbLlsg39eDiVythTI7+it
   7y7QyPyx0rYWklelObqsNn3Ag4Q2EVd1SZkZV3+q9C5qT+xsu5h96eAeq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="469163465"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="469163465"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="866893090"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="866893090"
Received: from ddiaz-mobl4.amr.corp.intel.com (HELO [10.209.57.36]) ([10.209.57.36])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:23:56 -0700
Message-ID: <f972d59c-40dd-2a68-ff13-a2658513a25b@intel.com>
Date:   Tue, 3 Oct 2023 07:23:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86_64: test that userspace stack is in fact NX
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <4b78a714-5ac3-4783-8256-1dda4673db01@p183>
 <1d5223b8-0275-619d-db1c-e2aaaddb173e@intel.com>
 <d468d13c-6c4b-4d8d-8e2d-e4314b4bb1a7@p183>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <d468d13c-6c4b-4d8d-8e2d-e4314b4bb1a7@p183>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 06:00, Alexey Dobriyan wrote:
> On Mon, Oct 02, 2023 at 07:23:10AM -0700, Dave Hansen wrote:
>> Basically, could you spend a moment in the changelog to talk about:
>>
>> 1. 32-bit kernels on NX hardware
>> and
>> 2. 64-bit kernels on non-NX hardware
> 
> Sure. My logic whas that i386 is dead arch, but this test is easy to
> port to i386, only 2 simple functions.

I honestly don't feel strongly about it one way or the other.  But
whatever we do, let's explain it, please.

> I don't want to parse /proc/cpuinfo. If someone knows they're shipping
> NX-incapable hardware, just let them disable the test.

Other than clearcpuid=nx, I don't _think_ we have any way to clear the
X86_FEATURE_NX bit right now.  That should mean that you can use regular
old CPUID to see if the booted kernel supports NX.  Perhaps something
like what:

	tools/testing/selftests/x86/amx.c

does with CPUID_LEAF1_ECX_XSAVE_MASK.  That should be quite a bit easier
than parsing /proc/cpuinfo.

If someone does use clearcpuid, then I think it's perfectly reasonable
to fail the selftest.
