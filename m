Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B5179970E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 11:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbjIIJ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 05:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjIIJ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 05:26:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1DC10F9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 02:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sziMsRgUyDAhc+ko55fvMP3AQqunNcm41IMcivKgVSY=; b=CmCt+OCabWt6bKVq6WK8LBnbc+
        DYWg8jazlDWDAMWdd2s0nbjK/sv+eOt2PZnzYu/3EnZ9z6dVop1o1bXWHB96CwFdzO4MXe++i8Jg1
        BIUFc94KVueX9s88B9bAgtbPehuO9/RtVKuKUmBqsTa6vxQyZxsd8BxjNZe3R8UB/UWH61kZ8DrlB
        G1QLv51Ogpi3JSCxCWW+JXzHDOW0BTJiavetLe91BrfN8/fX+Elk3WyFUnJjbdcQ6fmEuw67gJMpX
        gybBYLOI4t1EQbQQpRfdKHkznBdStyFOUO0VAJHiPuU0Lse2HF53aYlfAnPBn6T3F1E2ftX0bRXKM
        zKUyjG+Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeuDz-005QUQ-9D; Sat, 09 Sep 2023 09:25:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9C94300348; Sat,  9 Sep 2023 11:25:54 +0200 (CEST)
Date:   Sat, 9 Sep 2023 11:25:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230909092554.GC2771@noisy.programming.kicks-ass.net>
References: <20230814114426.057251214@infradead.org>
 <20230814121149.176244760@infradead.org>
 <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
 <20230907110917.GA10955@noisy.programming.kicks-ass.net>
 <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
 <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
 <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 09:50:09AM +0200, Borislav Petkov wrote:
> On Thu, Sep 07, 2023 at 05:30:36PM +0200, Borislav Petkov wrote:
> > But I might be missing something so lemme poke at it more.
> 
> So my guest boots with the below diff ontop of yours. That doesn't mean
> a whole lot but it looks like it DTRT. (Btw, the DPRINTK hunk is hoisted
> up only for debugging - not part of the change).
> 
> And I've backed out your handling of the additional padding because, as
> we've established, that's not really additional padding but the padding
> which is missing when a subsequent sequence is longer.
> 
> It all ends up being a single consecutive region of padding as it should
> be.
> 
> Building that says:
> 
> arch/x86/entry/entry_64.o: warning: objtool: entry_SYSCALL_64+0x91: weirdly overlapping alternative! 5 != 16
> arch/x86/entry/entry_64_compat.o: warning: objtool: entry_SYSENTER_compat+0x80: weirdly overlapping alternative! 5 != 16
> 
> but that warning is bogus because the code in question is the
> UNTRAIN_RET macro which has an empty orig insn, then two CALLs of size
> 5 and then the RESET_CALL_DEPTH sequence which is 16 bytes.
> 
> At build time it looks like this:
> 
> ffffffff81c000d1:       90                      nop
> ffffffff81c000d2:       90                      nop
> ffffffff81c000d3:       90                      nop
> ffffffff81c000d4:       90                      nop
> ffffffff81c000d5:       90                      nop
> ffffffff81c000d6:       90                      nop
> ffffffff81c000d7:       90                      nop
> ffffffff81c000d8:       90                      nop
> ffffffff81c000d9:       90                      nop
> ffffffff81c000da:       90                      nop
> ffffffff81c000db:       90                      nop
> ffffffff81c000dc:       90                      nop
> ffffffff81c000dd:       90                      nop
> ffffffff81c000de:       90                      nop
> ffffffff81c000df:       90                      nop
> ffffffff81c000e0:       90                      nop
> 
> and those are 16 contiguous NOPs of padding.
> 
> At boot time, it does:
> 
> [    0.679523] SMP alternatives: feat: 11*32+15, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 5), repl: (ffffffff833a362b, len: 5)
> [    0.683516] SMP alternatives: ffffffff81c000d1: [0:5) optimized NOPs: 0f 1f 44 00 00
> 
> That first one is X86_FEATURE_UNRET and the alt_instr descriptor simply
> says that the replacement is 5 bytes long, which is the CALL that can
> potentially be poked in. It doesn't care about the following 11 bytes of
> padding because it doesn't matter - it wants 5 bytes only for the CALL.
> 
> [    0.687514] SMP alternatives: feat: 11*32+10, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 5), repl: (ffffffff833a3630, len: 5)
> [    0.691521] SMP alternatives: ffffffff81c000d1: [0:5) optimized NOPs: 0f 1f 44 00 00
> 
> This is X86_FEATURE_ENTRY_IBPB. Same thing.
> 
> [    0.695515] SMP alternatives: feat: 11*32+19, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 16), repl: (ffffffff833a3635, len: 16)
> [    0.699516] SMP alternatives: ffffffff81c000d1: [0:16) optimized NOPs: eb 0e cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> 
> And this is X86_FEATURE_CALL_DEPTH and here the alt_instr descriptor has
> replacement length of 16 and that is all still ok as it starts at the
> same address and contains the first 5 bytes from the previous entries
> which overlap here.
> 
> So address-wise we're good, the alt_instr patching descriptors are
> correct and we should be good.
> 
> Thoughts?
> 
> ---
> 

> @@ -415,22 +415,18 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>  	for (a = start; a < end; a++) {
>  		int insn_buff_sz = 0;
>  
> -		/*
> -		 * In case of nested ALTERNATIVE()s the outer alternative might
> -		 * add more padding. To ensure consistent patching find the max
> -		 * padding for all alt_instr entries for this site (nested
> -		 * alternatives result in consecutive entries).
> -		 */
> -		for (b = a+1; b < end && b->instr_offset == a->instr_offset; b++) {
> -			u8 len = max(a->instrlen, b->instrlen);
> -			a->instrlen = b->instrlen = len;
> -		}
> -
>  		instr = (u8 *)&a->instr_offset + a->instr_offset;
>  		replacement = (u8 *)&a->repl_offset + a->repl_offset;
>  		BUG_ON(a->instrlen > sizeof(insn_buff));
>  		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
>  

> diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
> index 7145920a7aba..29e949579ede 100644
> --- a/tools/objtool/arch/x86/special.c
> +++ b/tools/objtool/arch/x86/special.c
> @@ -9,29 +9,6 @@
>  
>  void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
>  {
> -	static struct special_alt *group, *prev;
> -
> -	/*
> -	 * Recompute orig_len for nested ALTERNATIVE()s.
> -	 */
> -	if (group && group->orig_sec == alt->orig_sec &&
> -	             group->orig_off == alt->orig_off) {
> -
> -		struct special_alt *iter = group;
> -		for (;;) {
> -			unsigned int len = max(iter->orig_len, alt->orig_len);
> -			iter->orig_len = alt->orig_len = len;
> -
> -			if (iter == prev)
> -				break;
> -
> -			iter = list_next_entry(iter, list);
> -		}
> -
> -	} else group = alt;
> -
> -	prev = alt;
> -
>  	switch (feature) {
>  	case X86_FEATURE_SMAP:
>  		/*

Yeah, that wasn't optional.

So what you end up with is:

661:
  "one byte orig insn"
  "one nop because alt1 is 2 bytes"
  "one nop because alt2 is 3 bytes"

right?

But your alt_instr are:

  alt_instr1 = {
 	.instr_offset = 661b-.; /* .text location */
	.repl_offset = 664f-.;  /* .altinstr_replacement location */

	/* .ft_flags */

	.instrlen = 2;
	.replacementlen = 2;
  }

  alt_instr2 = {
  	.instr_offset = 661b-.;
	.repl_offset = 664f-.;

	/* .ft_flags */

	.instrlen = 3;
	.replacementlen = 3;
  }


So if you patch alt2, you will only patch 2 bytes of the original text,
even though that has 3 bytes of 'space'.


This becomes more of a problem with your example above where the
respective lengths are 0, 5, 16. In that case, when you patch 5, you'll
leave 11 single nops in there.

So what that code you deleted does is look for all alternatives that
start at the same point and computes the max replacementlen, because
that is the amount of bytes in the source text that has been reserved
for this alternative.

That is not optional.
