Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB147D54B0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjJXPI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJXPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:08:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 446B9BA;
        Tue, 24 Oct 2023 08:08:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91BA32F4;
        Tue, 24 Oct 2023 08:09:02 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.29.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD0633F762;
        Tue, 24 Oct 2023 08:08:18 -0700 (PDT)
Date:   Tue, 24 Oct 2023 16:08:12 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "wuqiang . matt" <wuqiang.matt@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/atomic: sh: Use generic_cmpxchg_local for
 arch_cmpxchg_local()
Message-ID: <ZTfd3A3Unz6SWFD3@FVFF77S0Q05N.cambridge.arm.com>
References: <169815917362.8695.13904684741526725648.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169815917362.8695.13904684741526725648.stgit@devnote2>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:52:54PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Use generic_cmpxchg_local() for arch_cmpxchg_local() implementation
> in SH architecture because it does not implement arch_cmpxchg_local().

I do not think this is correct.

The implementation in <asm-generic/cmpxchg-local.h> is UP-only (and it only
disables interrupts), whereas arch/sh can be built SMP. We should probably add
some guards into <asm-generic/cmpxchg-local.h> for that as we have in
<asm-generic/cmpxchg.h>.

I think the right thing to do here is to define arch_cmpxchg_local() in terms
of arch_cmpxchg(), i.e. at the bottom of arch/sh's <asm/cmpxchg.h> add:

#define arch_cmpxchg_local              arch_cmpxchg

Mark.

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/sh/include/asm/cmpxchg.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
> index 288f6f38d98f..e920e61fb817 100644
> --- a/arch/sh/include/asm/cmpxchg.h
> +++ b/arch/sh/include/asm/cmpxchg.h
> @@ -71,4 +71,6 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
>  				    (unsigned long)_n_, sizeof(*(ptr))); \
>    })
>  
> +#include <asm-generic/cmpxchg-local.h>
> +
>  #endif /* __ASM_SH_CMPXCHG_H */
> 
