Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D197D707B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344288AbjJYPNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjJYPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:13:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B5613A;
        Wed, 25 Oct 2023 08:13:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF80C4339A;
        Wed, 25 Oct 2023 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698246782;
        bh=lhZy4Nj6dgXfSnBnyvATK18+Fp1f1bpHUcPYkcig8jg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SeG4g2xv+0dvT68JEZGixpW8/+VeI2+sQrDkqamfK7fWH4bNOKBcVZChWlI9AN2qy
         ULjeMCdc5MEzLGO5++ZYliOjhK5Ro2Qp/gKWAPIHJew+dvjVsARKGzKT0yDl79pxJK
         YNAjk1/NGflq8XwBeCLsTmZWU+LiLlj4JiVPRPG6wQGs2R67RorUAwOZi8cij3wWIR
         V1evpNEA5Z1fqp696aozakmXXwVruBief4jTHatcWo6iE56WiigF4466YTJfs3mnv8
         +nu1GGEa1ccNWkrhf/d4si60D8B0OsMfG8jxKgn8qb8vCSZtdE0ygLABn2odDfO0x1
         SyGbBjq6jVYoQ==
Date:   Thu, 26 Oct 2023 00:12:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [External] [PATCH] locking/atomic: sh: Use
 generic_cmpxchg_local for arch_cmpxchg_local()
Message-Id: <20231026001257.7685ba787c5a53b1c4db029a@kernel.org>
In-Reply-To: <560f1066-cefa-2ed9-e4f6-992096e11fda@bytedance.com>
References: <169815917362.8695.13904684741526725648.stgit@devnote2>
        <560f1066-cefa-2ed9-e4f6-992096e11fda@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 19:26:37 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> On 2023/10/24 22:52, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Use generic_cmpxchg_local() for arch_cmpxchg_local() implementation
> > in SH architecture because it does not implement arch_cmpxchg_local().
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com/
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >   arch/sh/include/asm/cmpxchg.h |    2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
> > index 288f6f38d98f..e920e61fb817 100644
> > --- a/arch/sh/include/asm/cmpxchg.h
> > +++ b/arch/sh/include/asm/cmpxchg.h
> > @@ -71,4 +71,6 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
> >   				    (unsigned long)_n_, sizeof(*(ptr))); \
> >     })
> >   
> > +#include <asm-generic/cmpxchg-local.h>
> > +
> 
> asm-generic/cmpxchg-local.h defines only 2 routines: __generic_cmpxchg_local
> and __generic_cmpxchg64_local.

Thanks Wuqiang, I found how I can fix that from your message.

> 
> Shall add the definition of arch_cmpxchg_local into 
> arch/sh/include/asm/cmpxchg.h, or group arch_cmpxchg_local and 
> arch_cmpxchg64_local into
> asm-generic/cmpxchg-local.h ?

No, maybe it depends on the arch that which __generic function need to use.

Thank you,

> 
> >   #endif /* __ASM_SH_CMPXCHG_H */
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
