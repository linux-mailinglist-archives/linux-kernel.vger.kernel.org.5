Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4096A77620B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjHIOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjHIOGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:06:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718651FD7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0IZaTJNnvVnpyr3E9ePF+ZxGxFAzYQNU7oG5oyqTM8g=; b=TXlh0K6zkmILBOh6Cz6QVxsUli
        aUU0YtjLSs88wfnM0Z371RBE54i6ug3d1T+7Jroq8Hmb+meUUpkws9LhFklgBBr2V4/sSqkpask5I
        86zbPCxRezuEcLoi7DkDz84H5Kme2WQxCT9ADaEnRM0/33Bp7uvGuorZJqmKHH7I1vqZ3AGJjvjo0
        do1M/xSM606dVK2AREtbnuM2xmtb+9yTZHm85J5PuV95LeiVeACz5kiEYbxrdw3fIgvSlS46p3NL2
        syW0nO8wlGNZ8JUhabzVF+spKzfbGgv0hNDQ7ZjAK8hzA94/KduWcqP2HFmB+X9riJAtezC87DVAf
        3K+Y+EYg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTjp6-006ayA-AV; Wed, 09 Aug 2023 14:06:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2F5530003A;
        Wed,  9 Aug 2023 16:06:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D84932023C23F; Wed,  9 Aug 2023 16:06:03 +0200 (CEST)
Date:   Wed, 9 Aug 2023 16:06:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Message-ID: <20230809140603.GO212435@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
 <20230809134233.d7hlutglk2j3f4w3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809134233.d7hlutglk2j3f4w3@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:42:33AM -0400, Josh Poimboeuf wrote:
> On Wed, Aug 09, 2023 at 09:12:24AM +0200, Peter Zijlstra wrote:
> >  static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
> > @@ -796,6 +802,10 @@ static int __init retbleed_parse_cmdline
> >  			retbleed_cmd = RETBLEED_CMD_AUTO;
> >  		} else if (!strcmp(str, "unret")) {
> >  			retbleed_cmd = RETBLEED_CMD_UNRET;
> > +		} else if (!strcmp(str, "srso")) {
> > +			retbleed_cmd = RETBLEED_CMD_UNRET_SRSO;
> > +		} else if (!strcmp(str, "srso_alias")) {
> > +			retbleed_cmd = RETBLEED_CMD_UNRET_SRSO_ALIAS;
> 
> It doesn't make sense for "srso_alias" to be a separate cmdline option,
> as that option is a model-dependent variant of the SRSO mitigation.

so what I did with retbleed, and what should be fixed here too (I
forgot) is run with:

  retbleed=force,unret

on any random machine (typically Intel, because I have a distinct lack
of AMD machines :-() and look at the life kernel image to see if all the
patching worked.

I suppose I should add:

  setup_force_cpu_bug(X86_BUG_SRSO);

to the 'force' option, then:

  retbleed=force,srso_alias

should function the same, irrespective of the hardware.

I'm also of the opinion that the kernel should do as told, even if it
doesn't make sense. If you tell it nonsense, you get to keep the pieces.

So in that light, yes I think we should have separate options.

> > +	if (boot_cpu_has_bug(X86_BUG_SRSO)) {
> > +		has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) || cpu_has_ibpb_brtype_microcode();
> > +		if (!has_microcode) {
> > +			pr_warn("IBPB-extending microcode not applied!\n");
> > +			pr_warn(RETBLEED_SRSO_NOTICE);
> > +		} else {
> > +			/*
> > +			 * Enable the synthetic (even if in a real CPUID leaf)
> > +			 * flags for guests.
> > +			 */
> > +			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
> > +			setup_force_cpu_cap(X86_FEATURE_SBPB);
> > +
> > +			/*
> > +			 * Zen1/2 with SMT off aren't vulnerable after the right
> > +			 * IBPB microcode has been applied.
> > +			 */
> > +			if ((boot_cpu_data.x86 < 0x19) &&
> > +			    (cpu_smt_control == CPU_SMT_DISABLED))
> > +				setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
> 
> The rumor I heard was that SMT had to be disabled specifically by BIOS
> for this condition to be true.  Can somebody from AMD confirm?

David Kaplan is on Cc, I was hoping he would enlighten us -- once he's
back from PTO.

> The above check doesn't even remotely do that, in fact it does the
> opposite.  Regardless, at the very least it should be checking
> cpu_smt_possible().  I guess that would be a separate patch as it's a
> bug fix.
> 
> > @@ -870,8 +915,17 @@ static void __init retbleed_select_mitig
> >  	default:
> >  		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> >  		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> > -			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY))
> > -				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
> > +			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY)) {
> > +				if (boot_cpu_has_bug(X86_BUG_RETBLEED))
> > +					retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
> > +
> > +				if (boot_cpu_has_bug(X86_BUG_SRSO) && !boot_cpu_has(X86_FEATURE_SRSO_NO)) {
> > +					if (boot_cpu_data.x86 == 0x19)
> > +						retbleed_mitigation = RETBLEED_MITIGATION_UNRET_SRSO_ALIAS;
> > +					else
> > +						retbleed_mitigation = RETBLEED_MITIGATION_UNRET_SRSO;
> 
> It would be great to get confirmation from somebody at AMD that the SRSO
> mitigations supersede the Retbleed one, i.e., that the SRSO mitigations
> also fix Retbleed.

They should, the discussions we had back then explained the Zen1/2
retbleed case in quite some detail and the srso case matches that
exactly with the movabs. A larger instruction is used because we need a
larger embedded sequence of instructions, but otherwise it is identical.

The comments provided for srso_alias state the BTB is untrained using
the explicit aliasing.

That is to say, AFAIU any of this, yes both srso options untrain the BTB
and mitigate the earlier retbleed thing.

SRSO then goes one step further with the RAP/RSB clobber.

> Yes, the original patches might imply that, but they also seem confused
> since they do the double untraining for both Retbleed and SRSO.  And I
> was given conflicting information.

Which makes no bloody sense, since the double untrain is for another
address, which is not at all used.

> Even better, we could really use some official AMD documentation for
> this mitigation, since right now it all feels very unofficial and
> ubsubstantiated.

Seconded. David is there anything you can do to clarify this stuff?

> 
> > +				}
> > +			}
> >  			else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY) && boot_cpu_has(X86_FEATURE_IBPB))
> >  				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
> 
> Here should have the microcode check too:
> 
> 				if (boot_cpu_has_bug(X86_BUG_SRSO) && !has_microcode)
> 					pr_err("IBPB-extending microcode not applied; SRSO NOT mitigated\n");

That earlier printk is unconditional of the selected mitigation, you
really want it printed again?

