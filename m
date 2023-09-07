Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A64797388
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbjIGP0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241420AbjIGPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:25:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F30170E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:25:03 -0700 (PDT)
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8132D1EC0513;
        Thu,  7 Sep 2023 17:06:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1694099190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ge1IQDq1JvnTEAM/MidB0daQSkz6y0NbUvHmMjQT8jU=;
        b=jssZumBzvCN8jHsr0NYxwaF6c5U5a6XnotcHYcshS2I8r9NKQzDyaxhKpq1BVdRXfMYF5n
        N4Hptgzj56xhxj4PFwq3bDtHuDwi5JsRcygiKq518cP2yCYOQNO8ryhzTy5US5UxqNGvK+
        OJnnnKHrg9zSKGytdSmdUb0ZUKdRbDY=
Date:   Thu, 7 Sep 2023 17:06:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
References: <20230814114426.057251214@infradead.org>
 <20230814121149.176244760@infradead.org>
 <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
 <20230907110917.GA10955@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907110917.GA10955@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 01:09:17PM +0200, Peter Zijlstra wrote:
> If you flip the 3 and 2 byte instructions the result is the same. No
> extra padding.
>
> And no, I had not actually tested this before, because clearly this is
> all obvious ;-)

IKR.

So I take that extra padding thing back - we actually *must* have that
padding so that it actually works correctly. I just did a silly example
but nothing says one cannot do one like that today:

		alternative_2("", "pop %%rax", X86_FEATURE_ALWAYS,
			      "call clear_page_orig", X86_FEATURE_ALWAYS);

An order of insns which grows in size: 0, then 1, then 5.

It turns into:

> # arch/x86/mm/init.c:163: 		alternative_2("", "pop %%rax", X86_FEATURE_ALWAYS,
> # 163 "arch/x86/mm/init.c" 1
> 	# ALT: oldnstr
> 661:
> 	# ALT: oldnstr
> 661:
> 	
> 662:
> # ALT: padding
> .skip -(((665f-664f)-(662b-661b)) > 0) * ((665f-664f)-(662b-661b)),0x90

IINM, this turns into:

.skip 1 * (1 - 0) = 1.

because "pop %rax" is one byte. The original insn is of size 0.

So we end up with a 0x90 here.

> 663:
> .pushsection .altinstructions,"a"
>  .long 661b - .
>  .long 664f - .
>  .4byte ( 3*32+21)
>  .byte 663b-661b
>  .byte 665f-664f
> .popsection
> .pushsection .altinstr_replacement, "ax"
> # ALT: replacement 
> 664:
> 	pop %rax
>  665:
> .popsection
> 
> 662:

<--- X

> # ALT: padding
> .skip -(((665f-664f)-(662b-661b)) > 0) * ((665f-664f)-(662b-661b)),0x90

Now the second guy comes in. That turns into:

.skip 1 * (5 - 1) = 4

Because, IINM, the 662 label above is the *second* one at marker X (we
go backwards) and the 661 is the second one too.

So between those two labels you have the 0x90 - one byte padding from
the first .skip.

And now it adds 4 more bytes to accomodate the CALL.

So we need to have that padding back-to-back in case the second
replacement is longer.

Ok, I guess the only thing that's bothering me is:

>       # ALT: oldnstr
> 661:
>       # ALT: oldnstr 
> 661:

I'll keep on playing with this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
