Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2D6797408
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344573AbjIGPd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjIGPbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:31:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E9DCC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:31:20 -0700 (PDT)
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D84BF1EC0513;
        Thu,  7 Sep 2023 17:30:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1694100631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fg3i3jCKljWbSDssbMBvjSG8emVpUH3Gn/QKCyx+iQE=;
        b=NnPWPmIXliQc9jKtSGQXNxAHQPD2/9uu8Z00Mf7IEDlHZtTB/6T1Oo77YieR/Ircfj6cxH
        kOxHLMAKmAJIoIUn3REo6cIHrIzkO3kPa4FdBj2QSeLLujmWcZRQsb2wTVXyaFFxJJ2kXp
        dRM5ahHeVUADN66fXtsiaeq0gByRe0g=
Date:   Thu, 7 Sep 2023 17:30:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
References: <20230814114426.057251214@infradead.org>
 <20230814121149.176244760@infradead.org>
 <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
 <20230907110917.GA10955@noisy.programming.kicks-ass.net>
 <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 05:06:32PM +0200, Borislav Petkov wrote:
> >       # ALT: oldnstr
> > 661:
> >       # ALT: oldnstr 
> > 661:
> 
> I'll keep on playing with this.

Ok, below's what I've been thinking. It looks ok but I'll keep staring
at it for a while to make sure I'm not missing an angle.

We simply pass a number to the ALTERNATIVE macro, starting from 0. 0 is
the innermost invocation, 1 is the outer and so on. And then the labels
are unique and the sizes are correct. And we hardcode 0 to mean the
innermost macro invocation and use that for sizing of orig instr.

But I might be missing something so lemme poke at it more. Below is
a userspace program which makes this a lot easier to experiment with:

---
#include <stdio.h>

#define __stringify_1(x...)	#x
#define __stringify(x...)	__stringify_1(x)

#define alt_slen		"662b-6610b"
#define alt_total_slen		"663b-661b"
#define alt_rlen		"665f-664f"

#define OLDINSTR(oldinstr, n)						\
	"# ALT: oldnstr\n"						\
	"661" #n ":\n\t" oldinstr "\n662:\n"					\
	"# ALT: padding\n"						\
	".skip -(((" alt_rlen ")-(" alt_slen ")) > 0) * "		\
		"((" alt_rlen ")-(" alt_slen ")),0x90\n"		\
	"663:\n"

#define ALTINSTR_ENTRY(ft_flags)					      \
	".pushsection .altinstructions,\"a\"\n"				      \
	" .long 6610b - .\n"				/* label           */ \
	" .long 664f - .\n"				/* new instruction */ \
	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
	" .byte " alt_total_slen "\n"			/* source len      */ \
	" .byte " alt_rlen "\n"				/* replacement len */ \
	".popsection\n"

#define ALTINSTR_REPLACEMENT(newinstr)			/* replacement */	\
	".pushsection .altinstr_replacement, \"ax\"\n"				\
	"# ALT: replacement \n"							\
	"664:\n\t" newinstr "\n 665:\n"						\
	".popsection\n"

/*
 * Define an alternative between two instructions. If @ft_flags is
 * present, early code in apply_alternatives() replaces @oldinstr with
 * @newinstr. ".skip" directive takes care of proper instruction padding
 * in case @newinstr is longer than @oldinstr.
 *
 * Notably: @oldinstr may be an ALTERNATIVE() itself, also see
 *          apply_alternatives()
 */
#define __ALTERNATIVE(oldinstr, newinstr, ft_flags, n)			\
	OLDINSTR(oldinstr, n)						\
	ALTINSTR_ENTRY(ft_flags)					\
	ALTINSTR_REPLACEMENT(newinstr)

#define ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
	__ALTERNATIVE(oldinstr, newinstr, ft_flags, 0)

#define ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)	\
	__ALTERNATIVE(__ALTERNATIVE(oldinst, newinst1, flag1, 0),		\
		    newinst2, flag2, 1)

#define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
	asm __inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")

int main(void)
{
	alternative_2("", "pop %%rax", 1, "call main", 1);
	return 0;
}



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
