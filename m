Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92127C556C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346731AbjJKN1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbjJKN12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:27:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8554FA7;
        Wed, 11 Oct 2023 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697030846; x=1728566846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZHyLjPxJ1mR4uC3cntVpwvMSEvJUP/rV/lx58B5OooE=;
  b=XQ2th9DpXbsK+KjyDerDrSAN2kKNrPDhrrsEU8Sp4uSM+LTjgteHTsW/
   coY+pthL7Uay2QqFbkLHdY4DnEFxlG0zMGG+ioEMEqN5mWlXhfVYjNT6f
   w4ikhqiylJ5bxirq8JVEuEdBiOoYlMVXBnSkSh6byQMK00dY63qTwnYqU
   HzBmnymX4TxTTWeF9CzPMiiunxMLCH/ByOurFwl5L1Fr2J2Oi4TtHG5Lo
   +W12r7O3QxBnflZKzjt9KphEKgXxFSeQ4WbRD6zrfAb2L7cOdYUAPZWZw
   aA7Wfw57zN3TMMAMRJT+tuArzOPAYfNJU0AqEcWzSHJQi5CIk/BpO6gK3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3249908"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="3249908"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="897624429"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="897624429"
Received: from laptop-dan-intel.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.56.166])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:25:21 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 29011109FB5; Wed, 11 Oct 2023 16:27:03 +0300 (+03)
Date:   Wed, 11 Oct 2023 16:27:03 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2] x86/alternatives: Disable KASAN in apply_alternatives()
Message-ID: <20231011132703.3evo4ieradgyvgc2@box.shutemov.name>
References: <20231011065849.19075-1-kirill.shutemov@linux.intel.com>
 <20231011074616.GL14330@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011074616.GL14330@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:46:16AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 11, 2023 at 09:58:49AM +0300, Kirill A. Shutemov wrote:
> > Fei has reported that KASAN triggers during apply_alternatives() on
> > 5-level paging machine:
> > 
> 
> Urgh @ KASAN splat, can't we summarize that?

What about this?

	BUG: KASAN: out-of-bounds in rcu_is_watching
	Read of size 4 at addr ff110003ee6419a0 by task swapper/0/0
	...
	__asan_load4
	rcu_is_watching
	? text_poke_early
	trace_hardirqs_on
	? __asan_load4
	text_poke_early
	apply_alternatives
	...

Is it enough details or I overdid summarization?

> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 517ee01503be..b4cc4d7c0825 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -403,6 +403,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
> >  	u8 insn_buff[MAX_PATCH_LEN];
> >  
> >  	DPRINTK(ALT, "alt table %px, -> %px", start, end);
> > +
> > +	/*
> > +	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
> > +	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
> > +	 * During the process, KASAN becomes confused and triggers
> 
> 	because of partial LA57 convertion ..
> 
> > +	 * a false-positive out-of-bound report.
> > +	 *
> > +	 * Disable KASAN until the patching is complete.
> > +	 */
> > +	kasan_disable_current();
> > +
> >  	/*

	/*
	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
	 * During the process, KASAN becomes confused seeing partial LA57
	 * conversion and triggers a false-positive out-of-bound report.
	 *
	 * Disable KASAN until the patching is complete.
	 */

Looks good?

If yes, I will submit v3 with your Ack.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
