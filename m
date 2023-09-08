Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C70799230
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245143AbjIHWYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242626AbjIHWYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:24:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDE91FF5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 15:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694211857; x=1725747857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sGZGv+RYcnXgcRLIJ8mG6Ha5l1cozDqIW/cWfDvFWPo=;
  b=Q4WeDuNJcU/a5aC0qW43JxGmxfoEZSfQQC1LQiGAotbkRkhMgIzLUiSf
   t7fY8Zc069wbnm03yOXTCF0DkVNOGtgTbDulqHf1IESMJWmu40kkt4JUh
   /8aevCc1Nb0f3nrc6jgncOXAzYbxxfcymO9yQ1GRAOdMo6mAT8f5RX3Us
   Pz0CX8r5YZErIzdGPY8+VUzKiLo+YEptS0wwsMEksdF/BKf5troJYq3Qz
   oAhDwfjRo3v6Lb3sh44uagm3LYdyxhPPsmWa3MBulS+srOuokpSMANj42
   Ur8GJw0dVRcbN3NUrV4/50gCUTreF6D3cSIFwdb6pgbK6kIgzL7AP17Fp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="376669087"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="376669087"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 15:24:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="866262656"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="866262656"
Received: from fgilganx-mobl1.amr.corp.intel.com (HELO [10.209.17.195]) ([10.209.17.195])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 15:24:15 -0700
Message-ID: <fb81c0f4-5553-4c0d-89e3-3798405cdc7e@intel.com>
Date:   Fri, 8 Sep 2023 15:24:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] x86/tdx: Allow extended topology CPUID leafs to be
 emulated by hypercall
Content-Language: en-US
To:     Sagi Shahar <sagis@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230908175644.2478924-1-sagis@google.com>
 <d08303a4-321b-419c-5b3b-11f05e4286ae@intel.com>
 <CAAhR5DGUjeU=QoQdSXSLqaKiQ6U-Q8+sRQhnijHHtUtHfgh01Q@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAAhR5DGUjeU=QoQdSXSLqaKiQ6U-Q8+sRQhnijHHtUtHfgh01Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/23 12:25, Sagi Shahar wrote:
> On Fri, Sep 8, 2023 at 11:00 AM Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> On 9/8/23 10:56, Sagi Shahar wrote:
>>> The current TDX module does not handle extended topology leaves
>>> explicitly and will generate a #VE but the current #VE handler
>>> implementation blindly returns 0 for those CPUID leaves.
>>>
>>> This currently causes TDX guests to see 0 values when querying the numa
>>> topology leading to incorrect numa configurations.
>>>
>>> This patch fixes this behavior by emulating the extended topology leaves
>>> using the CPUID hypercall.
>>
>> ... and thus acquires the data from the untrusted VMM.  Right?
>>
>> What are the security implications of consuming this untrusted data?
> 
> The topology information is mostly used for performance optimizations
> on the guest side. I don't see any security implications if VMM passes
> incorrect values.

Oh, so I take it you did an audit and checked that no data structures
are sized or accessed based on this information.

Could you share some of your analysis, please?  I'd love to see it in
the changelog.

> Right now, the guest is already using the returned 0 values and gets
> an incorrect numa topology leading to odd behavior in the guest. If we
> allow guests to read these values from the untrusted VMM and VMM
> spoofs the values, the worst that can happen is a different incorrect
> numa topology instead of the incorrect one we already have today.

I'm going to have to disagree with this logic a wee bit.

The 0's have *KNOWN*, *FIXED* behavior.  It may stink, but it's known
and fixed and thoroughly unexploitable.  If it were somehow exploited,
we would change it to another value that we control.

The VMM values are fundamentally different.  They're dynamic and can be
maliciously crafted.

I'm actually not even sure how you're getting bad "NUMA" data out of
these leaves.  The check_extended_topology_leaf() checks should fail
because ecx will be all 0's and SMT_TYPE==1, so the (LEAFB_SUBTYPE(ecx)
!=  SMT_TYPE) condition will always hit.

I'm also not sure where the "numa topology" comment comes from.  There's
a _lot_ of topology information in these leaves that's at a much finer
granularity than NUMA nodes.  If you're getting errors on the console,
it would be spectacular to share those.

I have all kinds of guesses about what trouble this might be causing
you, but I'm a bad guesser.
