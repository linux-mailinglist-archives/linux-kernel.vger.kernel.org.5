Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E417DDE8B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjKAJh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKAJh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:37:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C9CDA;
        Wed,  1 Nov 2023 02:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698831441; x=1730367441;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qfbTbqFe+jHJjnHjeC4C2puWu2l4GMjxnP8YJ6YZt4A=;
  b=gI3b3JBtqOpzmIKbAPc/P4BwyNmTkYUA1uomfo2bnxnvskx/WpYw0Szk
   dTbrYNAcdCGg4zXHSHAIh8ID7DRZYJ7z2IkCLSVtpUyFZYukgED2WkuC6
   HrMGgemUY8RS99EF+SBbO98K2NJGVtxOeYJS2cwrAfPQwzN556HyUALjw
   H3uhkE0KL4daQsyRJbOJz7pRPfNv9oQaAfBJPOUb4TeqN5TeXVkqoimDp
   ZpzRX5Dc8vkyn8AQ8AvSqWuUW7t+kP2J3kmeyL571mGVab+EjefAYaA8B
   UIt2w2txCOOjH0rspAvwGB4IZwrLLGyleAt57uDePe3sy74L2acARsqka
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="388286177"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="388286177"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="934381027"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="934381027"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.93.12.33]) ([10.93.12.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:37:18 -0700
Message-ID: <05116375-f22c-4bc8-a766-d64b54b06da0@linux.intel.com>
Date:   Wed, 1 Nov 2023 17:37:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] KVM: x86/pmu: Clean up emulated PMC event handling
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        Roman Kagan <rkagan@amazon.de>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <like.xu.linux@gmail.com>
References: <20231023234000.2499267-1-seanjc@google.com>
From:   "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20231023234000.2499267-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/24/2023 7:39 AM, Sean Christopherson wrote:
> The ultimate goal of this series is to track emulated counter events using
> a dedicated variable instead of trying to track the previous counter value.
> Tracking the previous counter value is flawed as it takes a snapshot at
> every emulated event, but only checks for overflow prior to VM-Enter, i.e.
> KVM could miss an overflow if KVM ever supports emulating event types that
> can occur multiple times in a single VM-Exit.
>
> Patches 1-5 are (some loosely, some tightly) related fixes and cleanups to
> simplify the emulated counter approach implementation.  The fixes are
> tagged for stable as usersepace could cause some weirdness around perf
> events, but I doubt any real world VMM is actually affected.
>
> Sean Christopherson (6):
>    KVM: x86/pmu: Move PMU reset logic to common x86 code
>    KVM: x86/pmu: Reset the PMU, i.e. stop counters, before refreshing
>    KVM: x86/pmu: Stop calling kvm_pmu_reset() at RESET (it's redundant)
>    KVM: x86/pmu: Remove manual clearing of fields in kvm_pmu_init()
>    KVM: x86/pmu: Update sample period in pmc_write_counter()
>    KVM: x86/pmu: Track emulated counter events instead of previous
>      counter
>
>   arch/x86/include/asm/kvm-x86-pmu-ops.h |   2 +-
>   arch/x86/include/asm/kvm_host.h        |  17 +++-
>   arch/x86/kvm/pmu.c                     | 128 +++++++++++++++++++++----
>   arch/x86/kvm/pmu.h                     |  47 +--------
>   arch/x86/kvm/svm/pmu.c                 |  17 ----
>   arch/x86/kvm/vmx/pmu_intel.c           |  22 -----
>   arch/x86/kvm/x86.c                     |   1 -
>   7 files changed, 127 insertions(+), 107 deletions(-)
>
>
> base-commit: ec2f1daad460c6201338dae606466220ccaa96d5

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

