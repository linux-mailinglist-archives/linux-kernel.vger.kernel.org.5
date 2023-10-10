Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E087BF63B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjJJIlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjJJIkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:40:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B03A4;
        Tue, 10 Oct 2023 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696927250; x=1728463250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q/HQZfWfUh0bAp2HPigWMWS7Bdx/WkAzNBzfM90GuJU=;
  b=aGywAkpnWqe7PtgnuIWmGgcKcmCupCpoWwg+SpWRIVIp6CH9+SbgUZej
   R1Pc4iBygfltGOZGfIad5N2q/7K2NWSmFeBYA0v7v2yq38n8iGAFCrc7Q
   Tpd600NMIVEUQgetQDtt/dqBzozpFHB47fdB2gV8Ycc+NLDdl63Tv7DMy
   dkKEGnhNv7gPYw+c3oGQAl5Ixe4hvyfAQP7xQIiCLq0ParvdcNkSFeKzH
   vK04NDivZbBjKzYqvke9P5HiVBCofla4utM/tZezcBbKIRSPoAYeGo7C4
   udbDkmxyWzkCfo1AK2ddeiRjJ0+FCOBRXWKK4+/9YDKbv9G1dh4N9AKQW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="383220527"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="383220527"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="927059933"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="927059933"
Received: from albertmo-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.38])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:40:45 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CC6FC10A1A3; Tue, 10 Oct 2023 11:40:41 +0300 (+03)
Date:   Tue, 10 Oct 2023 11:40:41 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: Disable KASAN on text_poke_early() in
 apply_alternatives()
Message-ID: <20231010084041.ut5sshyrofh27yyx@box.shutemov.name>
References: <20231010053716.2481-1-kirill.shutemov@linux.intel.com>
 <20231010081938.GBZSUJGlSvEkFIDnES@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010081938.GBZSUJGlSvEkFIDnES@fat_crate.local>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:19:38AM +0200, Borislav Petkov wrote:
> On Tue, Oct 10, 2023 at 08:37:16AM +0300, Kirill A. Shutemov wrote:
> > On machines with 5-level paging, cpu_feature_enabled(X86_FEATURE_LA57)
> > got patched. It includes KASAN code, where KASAN_SHADOW_START depends on
> > __VIRTUAL_MASK_SHIFT, which is defined with the cpu_feature_enabled().
> 
> So use boot_cpu_has(X86_FEATURE_LA57).

__VIRTUAL_MASK_SHIFT used in many places. I don't think it is good idea to
give up on patching completely.

> > It seems that KASAN gets confused when apply_alternatives() patches the
> 
> It seems?

Admittedly, I don't understand KASAN well enough. I confirmed my idea
indirectly, by patching KASASN_SHADOW_START, as I mentioned.

> > KASAN_SHADOW_START users. A test patch that makes KASAN_SHADOW_START
> > static, by replacing __VIRTUAL_MASK_SHIFT with 56, fixes the issue.
> > 
> > During text_poke_early() in apply_alternatives(), KASAN should be
> > disabled. KASAN is already disabled in non-_early() text_poke().
> > 
> > It is unclear why the issue was not reported earlier. Bisecting does not
> > help. Older kernels trigger the issue less frequently, but it still
> > occurs. In the absence of any other clear offenders, the initial dynamic
> > 5-level paging support is to blame.
> 
> This whole thing sounds like it is still not really clear what is
> actually happening...

Maybe KASAN folks can help to understand the situation.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
