Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62C67974B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjIGPkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345433AbjIGPgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:36:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A50F2111
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sbk7saseUCvdJ54dn8Vx4i/GWnU4glHuRcJO/prWqt4=; b=rRpHRnn9OZMvbiBLC6b8N81RAx
        D5tBXfgDmYiy9LDx3rcFw11nBqupunjrBQyljHty84UU66UEfltc9JCZwo81W1XGz01Kyube/JXiZ
        L32gqmMedEVZ8VM1Z4WTEyMYc6yzw5e9ajec5Lk8FbkHrtmiJTL1UGRjRr/cGUh9z+eMQPHV9GzIO
        7lNR8pJ4pvJ3iy+V+TzWYau6cBs0799jVrUAFmRjVV47gVCSPrCOEoFMcS9EM8VX4MzKpY6hxUh9E
        hg0H7uAdyUlXr5tdpp/PgLpqU3vAwcm1RcARllcXMuVBEaQOA19JmsNnTr6B/FlRRjCFNkM8SffVY
        zbULxvPg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qeCsv-001lOg-0N;
        Thu, 07 Sep 2023 11:09:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB17F300687; Thu,  7 Sep 2023 13:09:17 +0200 (CEST)
Date:   Thu, 7 Sep 2023 13:09:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230907110917.GA10955@noisy.programming.kicks-ass.net>
References: <20230814114426.057251214@infradead.org>
 <20230814121149.176244760@infradead.org>
 <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 10:31:58AM +0200, Borislav Petkov wrote:
> On Mon, Aug 14, 2023 at 01:44:36PM +0200, Peter Zijlstra wrote:
> > Instead of making increasingly complicated ALTERNATIVE_n()
> > implementations, use a nested alternative expression.
> > 
> > The only difference between:
> > 
> >   ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)
> > 
> > and
> > 
> >   ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),
> >               newinst2, flag2)
> 
> Hmm, one more problem I see with this. You're handling it, it seems, but
> the whole thing doesn't feel clean to me.
> 
> Here's an exemplary eval:
> 
> > #APP
> > # 53 "./arch/x86/include/asm/page_64.h" 1
> > 	# ALT: oldnstr
> > 661:
> > 	# ALT: oldnstr
> > 661:
> 
> <--- X
> 
> > 	call clear_page_orig	#
> > 662:
> > # ALT: padding
> > .skip -(((665f-664f)-(662b-661b)) > 0) * ((665f-664f)-(662b-661b)),0x90

665f-664f = 5 (rep)
662b-661b = 5 (orig)

5-5 > 0 = 0

so no padding

> > 663:
> > .pushsection .altinstructions,"a"
> >  .long 661b - .
> >  .long 664f - .
> >  .4byte ( 3*32+16)
> >  .byte 663b-661b
> >  .byte 665f-664f
> > .popsection
> > .pushsection .altinstr_replacement, "ax"
> > # ALT: replacement 
> > 664:
> > 	call clear_page_rep	#
> >  665:
> > .popsection
> > 
> > 662:
> > # ALT: padding
> > .skip -(((665f-664f)-(662b-661b)) > 0) * ((665f-664f)-(662b-661b)),0x90
> > 663:
> 
> <--- Z
> 
> So here it would add the padding again, unnecessarily.

665f-664f = 5 (erms)
662b-661b = 5 (orig + padding)

5-5 > 0 = 0

no padding, also since, as you note 661b is the first, we include all
previous padding, and the skip will only add additional padding if the
new sequence is longer still.

So, no I'm not seeing it. Doubly not with this example where all 3
variants are 5 bytes.

Notably, the following nonsense alternative with 1 2 and 3 bytes
instructions:

	asm volatile (
		ALTERNATIVE_2("push %rbp",
			"push %r12", X86_FEATURE_ALWAYS,
			"mov %rsp,%rbp", X86_FEATURE_ALWAYS));

ends up as:

0004  204:      55                      push   %rbp
0005  205:      90                      nop
0006  206:      90                      nop

If you flip the 3 and 2 byte instructions the result is the same. No
extra padding.

And no, I had not actually tested this before, because clearly this is
all obvious ;-)

Anyway, the 1,3,2 variant spelled out reads like:

#APP
# 1563 "../arch/x86/kernel/alternative.c" 1
# ALT: oldnstr
661:
# ALT: oldnstr
661:
push %rbp
662:
# ALT: padding
.skip -(((665f-664f)-(662b-661b)) > 0) * ((665f-664f)-(662b-661b)),0x90

 #   Which evaluates like:
 #     665f-664f = 3
 #     662b-661b = 1
 #     3-1 > 0 = -1
 #     --1 * (3-1) = 2
 #
 #   so two single byte nops get emitted here.

663:
.pushsection .altinstructions,"a"
.long 661b - .
.long 664f - .
.4byte ( 3*32+21)
.byte 663b-661b
.byte 665f-664f
.popsection
.pushsection .altinstr_replacement, "ax"
# ALT: replacement
664:
mov %rsp,%rbp
665:
.popsection

662:
# ALT: padding
.skip -(((665f-664f)-(662b-661b)) > 0) * ((665f-664f)-(662b-661b)),0x90

 #   And this evaluates to:
 #     665f-664f = 2
 #     662b-661b = 3 (because it includes the original 1 byte instruction and 2 bytes padding)
 #     3-1 > 0 = 0
 #     0 * (3-1) = 0
 #
 #   so no extra padding

663:
.pushsection .altinstructions,"a"
.long 661b - .
.long 664f - .
.4byte ( 3*32+21)
.byte 663b-661b
.byte 665f-664f
.popsection
.pushsection .altinstr_replacement, "ax"
# ALT: replacement
664:
push %r12
665:
.popsection

# 0 "" 2
# ../arch/x86/kernel/alternative.c:1569:        int3_selftest();
#NO_APP
