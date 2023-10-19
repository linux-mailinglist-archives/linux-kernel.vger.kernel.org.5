Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAE87CF08C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjJSG7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJSG7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:59:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084BC11D;
        Wed, 18 Oct 2023 23:59:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E466C433C7;
        Thu, 19 Oct 2023 06:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697698770;
        bh=jgNes3/dT6qKmEnlevXgPZqbntb+vPAwbcCbjHyY8U4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kwygLwJO3XbLTgcbM9Qz1EB1Wt/1qOltdOvDGM5b2r1Gf0HaD4XTjQk6RhIvrcbCO
         eK7dvRvk/XI7cSTt7+poHJAClNnlXwJsedpE5dBc6pNADJ0s8YugOl+08Sku5cfRCX
         OWX0LwKsJLIUipsDV4ji9lpDrSTC10JfdCoFhl8CqmJ4YdppbxSdhPhM1aqEf8BUDF
         kkuWwSmFT8oYCII8p8pLYENo6KY/803ZadNY09ofr8vZfdK9ux1au6Zm/Zynt0SMzg
         ZzcuzJ7ffBAzU+SUNb5ADzavmldv25vtEqkkXW1YYpG3lMLJ7iuXz2/jFStOTbvE+H
         0BmiU7GhRwY5g==
Date:   Wed, 18 Oct 2023 23:59:28 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231019065928.mrvhtfaya22p2uzw@treble>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <20231018203747.GJZTBCG7mv5HL4w6CC@fat_crate.local>
 <20231019063527.iwgyioxi2gznnshp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019063527.iwgyioxi2gznnshp@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:35:30PM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 18, 2023 at 10:37:47PM +0200, Borislav Petkov wrote:
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -748,14 +748,20 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
> >                         continue;
> >  
> >                 op = insn.opcode.bytes[0];
> > -               if (op == JMP32_INSN_OPCODE)
> > +               if (op == JMP32_INSN_OPCODE || op == JMP8_INSN_OPCODE)
> >                         dest = addr + insn.length + insn.immediate.value;
> 
> I can recreate (with my GCC 12) by disabling CONFIG_CALL_DEPTH_TRACKING
> and CONFIG_CPU_SRSO, which puts __x86_return_thunk() close enough to the
> retpolines to enable the two-byte JMP in the last retpoline.  And then
> booting with spectre_v2=retpoline.
> 
> (Then to force two-byte JMPs for more retpolines, I cheated and just
> moved __x86_return_thunk() to right after the retpolines.)
> 
> Your WARN patch didn't seem to fix the no-output hang for me, maybe due
> to recursive warnings?
> 
> I was able to get more output by changing the WARN to (ahem) WARN_ONCE,
> but it's still getting into some kind of stack corruption.  Full output
> below.  I haven't had a chance to look further, but it's worrisome that
> even the WARN_ONCE isn't being recovered from.
> 
> Regardless of if we revert e92626af3234 ("x86/retpoline: Remove
> .text..__x86.return_thunk section"), or do the above patch, we still
> need to figure out why even WARN_ONCE() would be borking things.
> 
> Off to bed...

One last idea, since the return thunk is used everywhere (even non-ABI
compliant functions) it might be possible the "call check_thunks" (and
its call to warn_printk) is clobbering some registers which some code
(exception handling entry code?) doesn't appreciate.

FWIW, I changed to a WARN_ON_ONCE and it booted fine.

-- 
Josh
