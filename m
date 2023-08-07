Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF64773060
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjHGUhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjHGUhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:37:03 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A01B83
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:37:02 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2B0D09200C0; Mon,  7 Aug 2023 22:37:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 25ACC9200BF;
        Mon,  7 Aug 2023 21:37:00 +0100 (BST)
Date:   Mon, 7 Aug 2023 21:37:00 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Borislav Petkov <bp@alien8.de>
cc:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/5] [RESEND] x86: avoid unneeded __div64_32 function
 definition
In-Reply-To: <20230802172030.GEZMqQXmeb98Tm+Qhg@fat_crate.local>
Message-ID: <alpine.DEB.2.21.2308072124320.38537@angie.orcam.me.uk>
References: <20230725134837.1534228-1-arnd@kernel.org> <20230725134837.1534228-3-arnd@kernel.org> <20230801170315.GGZMk60zojZOeuUwX7@fat_crate.local> <baf750f4-a42c-453a-91dc-7fd457bc1e80@app.fastmail.com>
 <20230802172030.GEZMqQXmeb98Tm+Qhg@fat_crate.local>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023, Borislav Petkov wrote:

> > --- a/arch/x86/include/asm/div64.h
> > +++ b/arch/x86/include/asm/div64.h
> > @@ -71,6 +71,11 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
> >  }
> >  #define mul_u32_u32 mul_u32_u32
> >  
> > +/*
> > + * __div64_32() is never called on x86, so prevent the
> > + * generic definition from getting built.
> > + */
> > +#define __div64_32
> >  
> >  #else
> >  # include <asm-generic/div64.h>
> 
> Yap.

 Hmm, shouldn't this be something like:

#define __div64_32(n, base) BUILD_BUG()

instead?

 Otherwise you risk `__div64_32(n, base)' getting expanded to `(n, base)', 
if the macro does get called mistakenly for some reason, and the expansion 
is a valid expression which may not produce a warning even, depending on 
usage.

  Maciej
