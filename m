Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90787BF837
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjJJKLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjJJKLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:11:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2052893;
        Tue, 10 Oct 2023 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oj1axhxOjginGEELIsLjRAtpZ1XYE8QEYtnImm9KFkM=; b=gYdO8iqarQxLHjF7YnORu/ND3n
        P8Gxkb0rRc1yB37HNKOontKt/9J1jFpVLPPKbEh8Fo31wpLqgJgonUdDmliPmWek0TAKzExJy0pEF
        5+BXZCjaTVlX/CwrnMr7nYJ2ZTe7pqq09H8khWEzMP1ob1y57ZotrnJWyYaH1haO5lesiBo95gcED
        bLNR5ra69pGgy3tbU6IoomsDUHVQCIErONjFJRzX17lUk36DVty7sCzUjpdyjC7HkGE6zM2fVrOwY
        sZvCBJPxkTQX8xY9qBpODLXVuEEkgcwwgiZfYVswiFF1UqaRAVEjrwt5jxYOLLQJCTz2Lz+wViC21
        MGvlPphg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qq9hY-0040qP-NX; Tue, 10 Oct 2023 10:10:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63DD1300392; Tue, 10 Oct 2023 12:10:56 +0200 (CEST)
Date:   Tue, 10 Oct 2023 12:10:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Message-ID: <20231010101056.GF377@noisy.programming.kicks-ass.net>
References: <20231010053716.2481-1-kirill.shutemov@linux.intel.com>
 <20231010081938.GBZSUJGlSvEkFIDnES@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010081938.GBZSUJGlSvEkFIDnES@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
> 
> > It seems that KASAN gets confused when apply_alternatives() patches the
> 
> It seems?
> 
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

somewhere along the line __asan_loadN() gets tripped, this then ends up
in kasan_check_range() -> check_region_inline() -> addr_has_metadata().

This latter has: kasan_shadow_to_mem() which is compared against
KASAN_SHADOW_START, which includes, as Kirill says __VIRTUAL_MASK_SHIFT.

Now, obviously you really don't want boot_cpu_has() in
__VIRTUAL_MASK_SHIFT, that would be really bad (Linus recently
complained about how horrible the code-gen is around this already, must
not make it far worse).


Anyway, being half-way through patching X86_FEATURE_LA57 thing *are*
inconsistent and I really can't blame things for going sideways.

That said, I don't particularly like the patch, I think it should, at
the veyr least, cover all of apply_alternatives, not just
text_poke_early().
