Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B612F7BF889
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjJJKZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjJJKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:25:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD4C9E;
        Tue, 10 Oct 2023 03:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696933545; x=1728469545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=COjCuI9TuEZ6uSUI7QPwTqfgG6Zb6CVhJUegfpL9UNY=;
  b=aluJaAQBT7YjlIbzmzq+19kmCsuOyAGanrRWSwBe/EEEGDK1ylGHT2kx
   yuaCZjea1l0/O3UiqoS7vy6CzEcx2y0CjGc4uA+kpHa2mqORptR6PUG6O
   70UrqbXa+QzonZ/Cp3XflU0iCs3C/BqRdslvrdnWtuoYH7p7It5ci7b1m
   avh0epFolSG/05Mnfg8juWEbNe0uRVdGZmx4WeB3L42c9hiVqOB9yhh6O
   nI1iHRnU+I31Qs+1rmgNMzytXJOiK+TDXIw5Z26QrWkWVdmIxTyXzj9Bk
   HVENrv6Jty6V8R+lpuOzKt3ugRd5YekNA5JY1XsyI6cJYMZGPLy+4bB1g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="383235950"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="383235950"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:25:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869633637"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="869633637"
Received: from albertmo-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.38])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:25:40 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id EBD8410989E; Tue, 10 Oct 2023 13:25:37 +0300 (+03)
Date:   Tue, 10 Oct 2023 13:25:37 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
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
Message-ID: <20231010102537.qkrfcna2fwfkzgir@box.shutemov.name>
References: <20231010053716.2481-1-kirill.shutemov@linux.intel.com>
 <20231010081938.GBZSUJGlSvEkFIDnES@fat_crate.local>
 <20231010101056.GF377@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010101056.GF377@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:10:56PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 10, 2023 at 10:19:38AM +0200, Borislav Petkov wrote:
> > On Tue, Oct 10, 2023 at 08:37:16AM +0300, Kirill A. Shutemov wrote:
> > > On machines with 5-level paging, cpu_feature_enabled(X86_FEATURE_LA57)
> > > got patched. It includes KASAN code, where KASAN_SHADOW_START depends on
> > > __VIRTUAL_MASK_SHIFT, which is defined with the cpu_feature_enabled().
> > 
> > So use boot_cpu_has(X86_FEATURE_LA57).
> > 
> > > It seems that KASAN gets confused when apply_alternatives() patches the
> > 
> > It seems?
> > 
> > > KASAN_SHADOW_START users. A test patch that makes KASAN_SHADOW_START
> > > static, by replacing __VIRTUAL_MASK_SHIFT with 56, fixes the issue.
> > > 
> > > During text_poke_early() in apply_alternatives(), KASAN should be
> > > disabled. KASAN is already disabled in non-_early() text_poke().
> > > 
> > > It is unclear why the issue was not reported earlier. Bisecting does not
> > > help. Older kernels trigger the issue less frequently, but it still
> > > occurs. In the absence of any other clear offenders, the initial dynamic
> > > 5-level paging support is to blame.
> > 
> > This whole thing sounds like it is still not really clear what is
> > actually happening...
> 
> somewhere along the line __asan_loadN() gets tripped, this then ends up
> in kasan_check_range() -> check_region_inline() -> addr_has_metadata().
> 
> This latter has: kasan_shadow_to_mem() which is compared against
> KASAN_SHADOW_START, which includes, as Kirill says __VIRTUAL_MASK_SHIFT.
> 
> Now, obviously you really don't want boot_cpu_has() in
> __VIRTUAL_MASK_SHIFT, that would be really bad (Linus recently
> complained about how horrible the code-gen is around this already, must
> not make it far worse).
> 
> 
> Anyway, being half-way through patching X86_FEATURE_LA57 thing *are*
> inconsistent and I really can't blame things for going sideways.
> 
> That said, I don't particularly like the patch, I think it should, at
> the veyr least, cover all of apply_alternatives, not just
> text_poke_early().

I can do this, if it is the only stopper.

Do you want it disabled on caller side or inside apply_alternatives()?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
