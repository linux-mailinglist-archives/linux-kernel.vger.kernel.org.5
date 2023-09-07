Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459CE7978AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbjIGQvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbjIGQvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:51:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBF410FB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:51:24 -0700 (PDT)
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 846661EC056D;
        Thu,  7 Sep 2023 10:31:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1694075512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gVV9Abkk36f8Rr2PEM3s5ioOh4GkXNEL5LiIGXKL+N0=;
        b=qChbWOtdgGGzbSyNKM5l9aRGR1LqFqAqu0L6x0y0TZwa6wCrVwURQXkiluwZ618uIwW4r4
        9pAPz8ucqBEz/eytbAkgkW1Z7sHi1cIhGvr8qT7+uc6O3ljUREyT9YUUrXROeo1pEWedFg
        jWxl+E0HrbP621/YO2wazG2cZAOxCCc=
Date:   Thu, 7 Sep 2023 10:31:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
References: <20230814114426.057251214@infradead.org>
 <20230814121149.176244760@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814121149.176244760@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:44:36PM +0200, Peter Zijlstra wrote:
> Instead of making increasingly complicated ALTERNATIVE_n()
> implementations, use a nested alternative expression.
> 
> The only difference between:
> 
>   ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)
> 
> and
> 
>   ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),
>               newinst2, flag2)

Hmm, one more problem I see with this. You're handling it, it seems, but
the whole thing doesn't feel clean to me.

Here's an exemplary eval:

> #APP
> # 53 "./arch/x86/include/asm/page_64.h" 1
> 	# ALT: oldnstr
> 661:
> 	# ALT: oldnstr
> 661:

<--- X

> 	call clear_page_orig	#
> 662:
> # ALT: padding
> .skip -(((665f-664f)-(662b-661b)) > 0) * ((665f-664f)-(662b-661b)),0x90
> 663:
> .pushsection .altinstructions,"a"
>  .long 661b - .
>  .long 664f - .
>  .4byte ( 3*32+16)
>  .byte 663b-661b
>  .byte 665f-664f
> .popsection
> .pushsection .altinstr_replacement, "ax"
> # ALT: replacement 
> 664:
> 	call clear_page_rep	#
>  665:
> .popsection
> 
> 662:
> # ALT: padding
> .skip -(((665f-664f)-(662b-661b)) > 0) * ((665f-664f)-(662b-661b)),0x90
> 663:

<--- Z

So here it would add the padding again, unnecessarily.

> .pushsection .altinstructions,"a"
>  .long 661b - .

This refers to the 661 label, if you count backwards it would be the
second 661 label at my marker X above.

>  .long 664f - .

This is the 664 label at my marker Y below.

>  .4byte ( 9*32+ 9)
>  .byte 663b-661b

And here's where it gets interesting. That's source length. 663
backwards label is at marker Z which includes the second padding.

So if we do a lot of padding, that might grow vmlinux. Not a big deal
but still... Have you measured how much allyesconfig builds grow with
this patch?

>  .byte 665f-664f
> .popsection
> .pushsection .altinstr_replacement, "ax"
> # ALT: replacement 
> 664:

<--- Y

> 	call clear_page_erms	#
>  665:
> .popsection

In any case, I'd still like to solve this in a clean way, without the
fixup and unnecessary padding addition.

Lemme play some more with the preprocessor...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
