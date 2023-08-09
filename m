Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5D776440
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjHIPnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjHIPno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:43:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF892111
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:43:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5D1E63F21
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDDAC433C8;
        Wed,  9 Aug 2023 15:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691595822;
        bh=owZwYwW2VW0NBdG4add789CofMmXS+4VLAnGOSnWVuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yr21UdnccEa+bTcf30vPIHBsDhdqTppanBjjrtEAHc53p//q/vc9goFOHI1v+DsTU
         2M62dvH8fPZFP4PzE/zNyItt3aBuLQI0lLB4GlCJ4GJTvXigDH3IPqXrnfUHnA6LQ1
         UgeCp5FODK4bdyHNkv7Gyefdj6uR/AXEH4NPkgJQZVFursm+ni8hbtWK9bYAIKMO1R
         DFPUoV9wLiaeQiehZZ99mg1dpdLcAVzO4gtmJ4Z4WwLZXjD2Bb+1rOI1Ze9/dycQ8Z
         0tz45GtLvpL5VtkoZOKw4qYwbRqMcsX3mXKomiYSxNw3IO/mfFq7ii4+z+iUreSAgC
         JCcWs1GeKomyw==
Date:   Wed, 9 Aug 2023 11:43:38 -0400
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Message-ID: <20230809154338.utm2eyxaluietp42@treble>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
 <20230809134233.d7hlutglk2j3f4w3@treble>
 <20230809140603.GO212435@hirez.programming.kicks-ass.net>
 <20230809142847.3prfwo6cclbydfep@treble>
 <20230809150852.GS212435@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809150852.GS212435@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 05:08:52PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 09, 2023 at 10:28:47AM -0400, Josh Poimboeuf wrote:
> > On Wed, Aug 09, 2023 at 04:06:03PM +0200, Peter Zijlstra wrote:
> > > On Wed, Aug 09, 2023 at 09:42:33AM -0400, Josh Poimboeuf wrote:
> > > > On Wed, Aug 09, 2023 at 09:12:24AM +0200, Peter Zijlstra wrote:
> > > > >  static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
> > > > > @@ -796,6 +802,10 @@ static int __init retbleed_parse_cmdline
> > > > >  			retbleed_cmd = RETBLEED_CMD_AUTO;
> > > > >  		} else if (!strcmp(str, "unret")) {
> > > > >  			retbleed_cmd = RETBLEED_CMD_UNRET;
> > > > > +		} else if (!strcmp(str, "srso")) {
> > > > > +			retbleed_cmd = RETBLEED_CMD_UNRET_SRSO;
> > > > > +		} else if (!strcmp(str, "srso_alias")) {
> > > > > +			retbleed_cmd = RETBLEED_CMD_UNRET_SRSO_ALIAS;
> > > > 
> > > > It doesn't make sense for "srso_alias" to be a separate cmdline option,
> > > > as that option is a model-dependent variant of the SRSO mitigation.
> > > 
> > > so what I did with retbleed, and what should be fixed here too (I
> > > forgot) is run with:
> > > 
> > >   retbleed=force,unret
> > > 
> > > on any random machine (typically Intel, because I have a distinct lack
> > > of AMD machines :-() and look at the life kernel image to see if all the
> > > patching worked.
> > > 
> > > I suppose I should add:
> > > 
> > >   setup_force_cpu_bug(X86_BUG_SRSO);
> > > 
> > > to the 'force' option, then:
> > > 
> > >   retbleed=force,srso_alias
> > > 
> > > should function the same, irrespective of the hardware.
> > > 
> > > I'm also of the opinion that the kernel should do as told, even if it
> > > doesn't make sense. If you tell it nonsense, you get to keep the pieces.
> > > 
> > > So in that light, yes I think we should have separate options.
> > 
> > What if I want the SRSO mitigation regardless of CPU model?
> 
> You mean, you want to say 'any of the SRSO things, you pick the right
> version?'
> 
> Which means the user has an AMD machine, but can't be arsed to figure
> out which and somehow doesn't want to use AUTO?

Well, nobody's going to use any of these options anyway so it doesn't
matter regardless.

> > > They should, the discussions we had back then explained the Zen1/2
> > > retbleed case in quite some detail and the srso case matches that
> > > exactly with the movabs. A larger instruction is used because we need a
> > > larger embedded sequence of instructions, but otherwise it is identical.
> > > 
> > > The comments provided for srso_alias state the BTB is untrained using
> > > the explicit aliasing.
> > > 
> > > That is to say, AFAIU any of this, yes both srso options untrain the BTB
> > > and mitigate the earlier retbleed thing.
> > > 
> > > SRSO then goes one step further with the RAP/RSB clobber.
> > 
> > Ah, nice.  Please add that information somewhere (e.g., one of the
> > commit logs).
> 
> The comment above zen_untrain_ret (or retbleed_untrain_ret as you've
> christened it) not clear enough?
> 
> /*
>  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
>  * 1) The RET at retbleed_return_thunk must be on a 64 byte boundary, for
>  *    alignment within the BTB.
>  * 2) The instruction at retbleed_untrain_ret must contain, and not
>  *    end with, the 0xc3 byte of the RET.
>  * 3) STIBP must be enabled, or SMT disabled, to prevent the sibling thread
>  *    from re-poisioning the BTB prediction.
>  */

To me, it's only clear now that you connected the dots.

> Hmm, when compared to:
> 
> 	.align 64
> 	.skip 64 - (srso_safe_ret - srso_untrain_ret), 0xcc
> SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
> ANNOTATE_NOENDBR
> 	.byte 0x48, 0xb8
> 
> SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
> 	add $8, %_ASM_SP
> 	ret
> 	int3
> 	int3
> 	int3
> 	/* end of movabs */
> 	lfence
> 	jmp srso_return_thunk
> 	int3
> SYM_CODE_END(srso_safe_ret)
> SYM_FUNC_END(srso_untrain_ret)
> 
> Then we match 2, srso_safe_ret is strictly *inside* the movabs, that is,
> it is not the first nor the last byte of the outer instruction.
> 
> However, we fail at 1, 'add $8, %rsp' sits at the boundary, not ret.
> 
> Anybody, help ?

Um... yeah, doesn't look right.

-- 
Josh
