Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1087D6883
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjJYKad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjJYKa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:30:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B44D4BB;
        Wed, 25 Oct 2023 03:30:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED2332F4;
        Wed, 25 Oct 2023 03:31:07 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.69.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F31B23F738;
        Wed, 25 Oct 2023 03:30:24 -0700 (PDT)
Date:   Wed, 25 Oct 2023 11:30:20 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "wuqiang . matt" <wuqiang.matt@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/atomic: sh: Use generic_cmpxchg_local for
 arch_cmpxchg_local()
Message-ID: <ZTjuH074CJuLh7Zw@FVFF77S0Q05N>
References: <169815917362.8695.13904684741526725648.stgit@devnote2>
 <ZTfd3A3Unz6SWFD3@FVFF77S0Q05N.cambridge.arm.com>
 <20231025084255.bc70b9d0e5af9f6f3d2d4735@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025084255.bc70b9d0e5af9f6f3d2d4735@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 08:42:55AM +0900, Masami Hiramatsu wrote:
> On Tue, 24 Oct 2023 16:08:12 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Tue, Oct 24, 2023 at 11:52:54PM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Use generic_cmpxchg_local() for arch_cmpxchg_local() implementation
> > > in SH architecture because it does not implement arch_cmpxchg_local().
> > 
> > I do not think this is correct.
> > 
> > The implementation in <asm-generic/cmpxchg-local.h> is UP-only (and it only
> > disables interrupts), whereas arch/sh can be built SMP. We should probably add
> > some guards into <asm-generic/cmpxchg-local.h> for that as we have in
> > <asm-generic/cmpxchg.h>.
> 
> Isn't cmpxchg_local for the data which only needs to ensure to do cmpxchg
> on local CPU?
> So I think it doesn't care about the other CPUs (IOW, it should not touched by
> other CPUs), so it only considers UP case. E.g. on x86, arch_cmpxchg_local() is
> defined as raw "cmpxchg" without lock prefix.
> 
> #define __cmpxchg_local(ptr, old, new, size)                            \
>         __raw_cmpxchg((ptr), (old), (new), (size), "")
> 

Yes, you're right; sorry for the noise.

For your original patch:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> Thank you,
> 
> 
> > 
> > I think the right thing to do here is to define arch_cmpxchg_local() in terms
> > of arch_cmpxchg(), i.e. at the bottom of arch/sh's <asm/cmpxchg.h> add:
> > 
> > #define arch_cmpxchg_local              arch_cmpxchg
> > 
> > Mark.
> > 
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com/
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > ---
> > >  arch/sh/include/asm/cmpxchg.h |    2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
> > > index 288f6f38d98f..e920e61fb817 100644
> > > --- a/arch/sh/include/asm/cmpxchg.h
> > > +++ b/arch/sh/include/asm/cmpxchg.h
> > > @@ -71,4 +71,6 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
> > >  				    (unsigned long)_n_, sizeof(*(ptr))); \
> > >    })
> > >  
> > > +#include <asm-generic/cmpxchg-local.h>
> > > +
> > >  #endif /* __ASM_SH_CMPXCHG_H */
> > > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
