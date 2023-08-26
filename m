Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45785789643
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 13:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjHZLYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 07:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjHZLYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 07:24:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFFE19A0;
        Sat, 26 Aug 2023 04:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDDB861881;
        Sat, 26 Aug 2023 11:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4D2C433C8;
        Sat, 26 Aug 2023 11:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693049077;
        bh=4xY2yHBfvVm2yFqr0cbJeko4G4N9NujIbsiZ5iVIA8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FdnT6nQ5e9blAjttL1iEm2EJFXxQNLkgNeqmOdGQ81kXjnoTTuqODc38tkDI8GRL0
         qn2FGzMRg7UCWnjAiQexrgKE2CoebJNZDB7USDd39s01vqLX/PSY4I65EBZvaOXfZV
         WbLVDvSg8sY8Sv8fp9f8E1lRxNYEF1NLS/6gdLfo=
Date:   Sat, 26 Aug 2023 13:24:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, keescook@chromium.org,
        elver@google.com, dvyukov@google.com, glider@google.com
Subject: Re: [BUG] missing return thunk: __ret+0x5/0x7e-__ret+0x0/0x7e: e9 f6
 ff ff ff
Message-ID: <2023082618-pulse-wildcat-6746@gregkh>
References: <4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop>
 <20230816181720.GNZN0SsKi/B4eCsZHu@fat_crate.local>
 <2023082458-vividness-habitable-cbc8@gregkh>
 <20230825232657.psb7c7x2tdgzciqw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825232657.psb7c7x2tdgzciqw@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 04:26:57PM -0700, Josh Poimboeuf wrote:
> On Thu, Aug 24, 2023 at 03:52:56PM +0200, Greg KH wrote:
> > On Wed, Aug 16, 2023 at 08:17:20PM +0200, Borislav Petkov wrote:
> > > Hey Paul,
> > > 
> > > On Wed, Aug 16, 2023 at 10:54:09AM -0700, Paul E. McKenney wrote:
> > > > I hit the splat at the end of this message in recent mainline, and has
> > > > appeared some time since v6.5-rc1.  Should I be worried?
> > > 
> > > does it go away if you try the latest tip:x86/urgent branch?
> > 
> > Note, this problem is showing up in the 6.1.y branch right now, due to
> > one objtool patch not being able to be backported there easily (i.e. I
> > tried and gave up.)
> > 
> > 4ae68b26c3ab ("objtool/x86: Fix SRSO mess") being the commit that I
> > can't seem to get to work properly, my attempt can be seen here:
> > 	https://lore.kernel.org/r/2023082212-pregnant-lizard-80e0@gregkh
> 
> > --- a/tools/objtool/arch/x86/decode.c
> > +++ b/tools/objtool/arch/x86/decode.c
> > @@ -796,8 +796,11 @@ bool arch_is_retpoline(struct symbol *sy
> >  
> >  bool arch_is_rethunk(struct symbol *sym)
> >  {
> > -	return !strcmp(sym->name, "__x86_return_thunk") ||
> > -	       !strcmp(sym->name, "srso_untrain_ret") ||
> > -	       !strcmp(sym->name, "srso_safe_ret") ||
> > -	       !strcmp(sym->name, "retbleed_return_thunk");
> > +	return !strcmp(sym->name, "__x86_return_thunk");
> > +}
> > +
> > +bool arch_is_embedded_insn(struct symbol *sym)
> > +{
> > +	return !strcmp(sym->name, "retbleed_return_thunk") ||
> > +	       !strcmp(sym->name, "srso_safe_ret");
> 
> This wouldn't work with the current 6.1.y branch, I assume you had some
> other patches applied before this.  e.g., the patch renaming __ret to
> retbleed_return_thunk.

Yes, I did.

> >  }
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -418,7 +418,7 @@ static int decode_instructions(struct ob
> >  		}
> >  
> >  		list_for_each_entry(func, &sec->symbol_list, list) {
> > -			if (func->type != STT_FUNC || func->alias != func)
> > +			if (func->embedded_insn || func->alias != func)
> >  				continue;
> 
> This hunk looks like a bug.  This might be the source of your problems.

Ah, I guessed wrong on that change, my fault :(

> The below patch seems to work on stock 6.1.47.  Or if you have other
> SRSO patches pending, point me to them and I can look at porting this
> one to fit.

I got this to apply on top of the latest series (-rc) and it passes
test-builds here.  I'll do a release now without it and then queue this
up, along with some other fixes for reported problems in previous
releases, and release it so that the CI systems can go at it.

Many thanks for this!

greg k-h
