Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3089A776273
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjHIO2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjHIO2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:28:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A00170B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:28:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9624063422
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A51EC433C7;
        Wed,  9 Aug 2023 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691591331;
        bh=sTMZ5ww1qIGz1lhvEVOD4pr1bzYqs6NfWACJ2GRhEfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W750R2F1rsrsUrhTtXPBO82gX2Mmt3nBZg9Kv/mKmn2y1b1BsmhDBGe+uG8sawudT
         /IA01sk7ecutdzHSyo6Wmtf392324G/Lr/GWD5JxvfNEyhqT5cQs6pvAto/tGnjHYY
         PLZ9dZrkG3/TbS3utzpDH7UyRGfVcjXdcHctBCRqc14Yhr59V5yY4eb83P52ZNtaPz
         KGChIHY7c25n328GRaacVodfHeWbo7tTInGNVkorVrzuv38psxrgRnrK3ZoH3e5kL5
         XaBr///W2556fhT/TVily1YM2/D1zUUmGgoWCgtW3Fwmyp/HlmnF9RbhOKrurcAZLJ
         cVEYzTy4vR9mA==
Date:   Wed, 9 Aug 2023 10:28:47 -0400
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Message-ID: <20230809142847.3prfwo6cclbydfep@treble>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
 <20230809134233.d7hlutglk2j3f4w3@treble>
 <20230809140603.GO212435@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809140603.GO212435@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 04:06:03PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 09, 2023 at 09:42:33AM -0400, Josh Poimboeuf wrote:
> > On Wed, Aug 09, 2023 at 09:12:24AM +0200, Peter Zijlstra wrote:
> > >  static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
> > > @@ -796,6 +802,10 @@ static int __init retbleed_parse_cmdline
> > >  			retbleed_cmd = RETBLEED_CMD_AUTO;
> > >  		} else if (!strcmp(str, "unret")) {
> > >  			retbleed_cmd = RETBLEED_CMD_UNRET;
> > > +		} else if (!strcmp(str, "srso")) {
> > > +			retbleed_cmd = RETBLEED_CMD_UNRET_SRSO;
> > > +		} else if (!strcmp(str, "srso_alias")) {
> > > +			retbleed_cmd = RETBLEED_CMD_UNRET_SRSO_ALIAS;
> > 
> > It doesn't make sense for "srso_alias" to be a separate cmdline option,
> > as that option is a model-dependent variant of the SRSO mitigation.
> 
> so what I did with retbleed, and what should be fixed here too (I
> forgot) is run with:
> 
>   retbleed=force,unret
> 
> on any random machine (typically Intel, because I have a distinct lack
> of AMD machines :-() and look at the life kernel image to see if all the
> patching worked.
> 
> I suppose I should add:
> 
>   setup_force_cpu_bug(X86_BUG_SRSO);
> 
> to the 'force' option, then:
> 
>   retbleed=force,srso_alias
> 
> should function the same, irrespective of the hardware.
> 
> I'm also of the opinion that the kernel should do as told, even if it
> doesn't make sense. If you tell it nonsense, you get to keep the pieces.
> 
> So in that light, yes I think we should have separate options.

What if I want the SRSO mitigation regardless of CPU model?

> > > @@ -870,8 +915,17 @@ static void __init retbleed_select_mitig
> > >  	default:
> > >  		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> > >  		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> > > -			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY))
> > > -				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
> > > +			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY)) {
> > > +				if (boot_cpu_has_bug(X86_BUG_RETBLEED))
> > > +					retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
> > > +
> > > +				if (boot_cpu_has_bug(X86_BUG_SRSO) && !boot_cpu_has(X86_FEATURE_SRSO_NO)) {
> > > +					if (boot_cpu_data.x86 == 0x19)
> > > +						retbleed_mitigation = RETBLEED_MITIGATION_UNRET_SRSO_ALIAS;
> > > +					else
> > > +						retbleed_mitigation = RETBLEED_MITIGATION_UNRET_SRSO;
> > 
> > It would be great to get confirmation from somebody at AMD that the SRSO
> > mitigations supersede the Retbleed one, i.e., that the SRSO mitigations
> > also fix Retbleed.
> 
> They should, the discussions we had back then explained the Zen1/2
> retbleed case in quite some detail and the srso case matches that
> exactly with the movabs. A larger instruction is used because we need a
> larger embedded sequence of instructions, but otherwise it is identical.
> 
> The comments provided for srso_alias state the BTB is untrained using
> the explicit aliasing.
> 
> That is to say, AFAIU any of this, yes both srso options untrain the BTB
> and mitigate the earlier retbleed thing.
> 
> SRSO then goes one step further with the RAP/RSB clobber.

Ah, nice.  Please add that information somewhere (e.g., one of the
commit logs).

> > > +				}
> > > +			}
> > >  			else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY) && boot_cpu_has(X86_FEATURE_IBPB))
> > >  				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
> > 
> > Here should have the microcode check too:
> > 
> > 				if (boot_cpu_has_bug(X86_BUG_SRSO) && !has_microcode)
> > 					pr_err("IBPB-extending microcode not applied; SRSO NOT mitigated\n");
> 
> That earlier printk is unconditional of the selected mitigation, you
> really want it printed again?

Hm, if you don't want it printed twice then remove it from the
RETBLEED_CMD_IBPB case too.

-- 
Josh
