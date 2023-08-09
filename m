Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A114E776361
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjHIPJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjHIPJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:09:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C25A2111
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GXuDgIHyPhdy+gjJMcYr23QFt5bd2eQvo9Kj7fMeS04=; b=WHD2/X3liWNPwuNLkXMi5X3cHl
        15lQQb5VeM3y9hGPi2xkTkf825a4qhvafUY1fPh8pJkv4wsq4f6Sgls7JaSzB3xiCVgX8nWBq24M6
        ywHKcU/DTNu7xalIrIrcC6jEPlupienoFevO8xKvuKsuqF5nEzqPElErsy+EPPFFKIk60XbdjvcOT
        tx+u4ywVENGxD+GH5UI8SxJJnG/9RoP+iy5WgEK8gjb09cNmW8b4Thj1jA3g2avWLFe/0N03RE42A
        EoB5ulbPnyXVVsEEjlVQmwykWEJAUcg34rsJ1ipiwyb7I6FOXZ3sJnaMTAhwFyDzcDEtgU6e36MZI
        uN1/5zLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTkns-005iwI-2z;
        Wed, 09 Aug 2023 15:08:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7697F30003A;
        Wed,  9 Aug 2023 17:08:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58BC22023C23F; Wed,  9 Aug 2023 17:08:52 +0200 (CEST)
Date:   Wed, 9 Aug 2023 17:08:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Message-ID: <20230809150852.GS212435@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
 <20230809134233.d7hlutglk2j3f4w3@treble>
 <20230809140603.GO212435@hirez.programming.kicks-ass.net>
 <20230809142847.3prfwo6cclbydfep@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809142847.3prfwo6cclbydfep@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 10:28:47AM -0400, Josh Poimboeuf wrote:
> On Wed, Aug 09, 2023 at 04:06:03PM +0200, Peter Zijlstra wrote:
> > On Wed, Aug 09, 2023 at 09:42:33AM -0400, Josh Poimboeuf wrote:
> > > On Wed, Aug 09, 2023 at 09:12:24AM +0200, Peter Zijlstra wrote:
> > > >  static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
> > > > @@ -796,6 +802,10 @@ static int __init retbleed_parse_cmdline
> > > >  			retbleed_cmd = RETBLEED_CMD_AUTO;
> > > >  		} else if (!strcmp(str, "unret")) {
> > > >  			retbleed_cmd = RETBLEED_CMD_UNRET;
> > > > +		} else if (!strcmp(str, "srso")) {
> > > > +			retbleed_cmd = RETBLEED_CMD_UNRET_SRSO;
> > > > +		} else if (!strcmp(str, "srso_alias")) {
> > > > +			retbleed_cmd = RETBLEED_CMD_UNRET_SRSO_ALIAS;
> > > 
> > > It doesn't make sense for "srso_alias" to be a separate cmdline option,
> > > as that option is a model-dependent variant of the SRSO mitigation.
> > 
> > so what I did with retbleed, and what should be fixed here too (I
> > forgot) is run with:
> > 
> >   retbleed=force,unret
> > 
> > on any random machine (typically Intel, because I have a distinct lack
> > of AMD machines :-() and look at the life kernel image to see if all the
> > patching worked.
> > 
> > I suppose I should add:
> > 
> >   setup_force_cpu_bug(X86_BUG_SRSO);
> > 
> > to the 'force' option, then:
> > 
> >   retbleed=force,srso_alias
> > 
> > should function the same, irrespective of the hardware.
> > 
> > I'm also of the opinion that the kernel should do as told, even if it
> > doesn't make sense. If you tell it nonsense, you get to keep the pieces.
> > 
> > So in that light, yes I think we should have separate options.
> 
> What if I want the SRSO mitigation regardless of CPU model?

You mean, you want to say 'any of the SRSO things, you pick the right
version?'

Which means the user has an AMD machine, but can't be arsed to figure
out which and somehow doesn't want to use AUTO?




> > They should, the discussions we had back then explained the Zen1/2
> > retbleed case in quite some detail and the srso case matches that
> > exactly with the movabs. A larger instruction is used because we need a
> > larger embedded sequence of instructions, but otherwise it is identical.
> > 
> > The comments provided for srso_alias state the BTB is untrained using
> > the explicit aliasing.
> > 
> > That is to say, AFAIU any of this, yes both srso options untrain the BTB
> > and mitigate the earlier retbleed thing.
> > 
> > SRSO then goes one step further with the RAP/RSB clobber.
> 
> Ah, nice.  Please add that information somewhere (e.g., one of the
> commit logs).

The comment above zen_untrain_ret (or retbleed_untrain_ret as you've
christened it) not clear enough?

/*
 * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
 * 1) The RET at retbleed_return_thunk must be on a 64 byte boundary, for
 *    alignment within the BTB.
 * 2) The instruction at retbleed_untrain_ret must contain, and not
 *    end with, the 0xc3 byte of the RET.
 * 3) STIBP must be enabled, or SMT disabled, to prevent the sibling thread
 *    from re-poisioning the BTB prediction.
 */


Hmm, when compared to:

	.align 64
	.skip 64 - (srso_safe_ret - srso_untrain_ret), 0xcc
SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
ANNOTATE_NOENDBR
	.byte 0x48, 0xb8

SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
	add $8, %_ASM_SP
	ret
	int3
	int3
	int3
	/* end of movabs */
	lfence
	jmp srso_return_thunk
	int3
SYM_CODE_END(srso_safe_ret)
SYM_FUNC_END(srso_untrain_ret)

Then we match 2, srso_safe_ret is strictly *inside* the movabs, that is,
it is not the first nor the last byte of the outer instruction.

However, we fail at 1, 'add $8, %rsp' sits at the boundary, not ret.

Anybody, help ?
