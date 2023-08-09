Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B87776172
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjHINmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjHINmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:42:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69872109
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 590206142F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CFBC433CA;
        Wed,  9 Aug 2023 13:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691588556;
        bh=xAM5cbDEceRUuoZMODlCtXOM7qxWnZ3O9nGjDOMESN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/WUROH54ZbR3Keotjw7V77+DSErg/wUvpH7FQ0ydHttf/8AoMRFwYD/tO3yu+bzO
         sHUVK8pn3hrOPFYHEXgymUSQilDzHzOD1waNqeo+yYTbww3/lQChpzScB6xqaPM/c+
         pwZU2S/HTCyCcLniT/SH4vepWoqb6ObFPFg12a2ytCmSw1ntg1bpB0rxxP96er6UpK
         S1Y3cOLS9vjdpFfPeZai7a5VMstpdiC7jFde6/657sp77GkStdCAWtBEsJfHDUYbk1
         F2p0+vd3433CYezEQe12rhrasI1xxZOnXCGxihZyEOKu8TiEZu2+EYhwQ6ishPwJgc
         E5LYnHvcKWglw==
Date:   Wed, 9 Aug 2023 09:42:33 -0400
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Message-ID: <20230809134233.d7hlutglk2j3f4w3@treble>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809072200.850338672@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:12:24AM +0200, Peter Zijlstra wrote:
>  static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
> @@ -796,6 +802,10 @@ static int __init retbleed_parse_cmdline
>  			retbleed_cmd = RETBLEED_CMD_AUTO;
>  		} else if (!strcmp(str, "unret")) {
>  			retbleed_cmd = RETBLEED_CMD_UNRET;
> +		} else if (!strcmp(str, "srso")) {
> +			retbleed_cmd = RETBLEED_CMD_UNRET_SRSO;
> +		} else if (!strcmp(str, "srso_alias")) {
> +			retbleed_cmd = RETBLEED_CMD_UNRET_SRSO_ALIAS;

It doesn't make sense for "srso_alias" to be a separate cmdline option,
as that option is a model-dependent variant of the SRSO mitigation.

> +	if (boot_cpu_has_bug(X86_BUG_SRSO)) {
> +		has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) || cpu_has_ibpb_brtype_microcode();
> +		if (!has_microcode) {
> +			pr_warn("IBPB-extending microcode not applied!\n");
> +			pr_warn(RETBLEED_SRSO_NOTICE);
> +		} else {
> +			/*
> +			 * Enable the synthetic (even if in a real CPUID leaf)
> +			 * flags for guests.
> +			 */
> +			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
> +			setup_force_cpu_cap(X86_FEATURE_SBPB);
> +
> +			/*
> +			 * Zen1/2 with SMT off aren't vulnerable after the right
> +			 * IBPB microcode has been applied.
> +			 */
> +			if ((boot_cpu_data.x86 < 0x19) &&
> +			    (cpu_smt_control == CPU_SMT_DISABLED))
> +				setup_force_cpu_cap(X86_FEATURE_SRSO_NO);

The rumor I heard was that SMT had to be disabled specifically by BIOS
for this condition to be true.  Can somebody from AMD confirm?

The above check doesn't even remotely do that, in fact it does the
opposite.  Regardless, at the very least it should be checking
cpu_smt_possible().  I guess that would be a separate patch as it's a
bug fix.

> @@ -870,8 +915,17 @@ static void __init retbleed_select_mitig
>  	default:
>  		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>  		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> -			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY))
> -				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
> +			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY)) {
> +				if (boot_cpu_has_bug(X86_BUG_RETBLEED))
> +					retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
> +
> +				if (boot_cpu_has_bug(X86_BUG_SRSO) && !boot_cpu_has(X86_FEATURE_SRSO_NO)) {
> +					if (boot_cpu_data.x86 == 0x19)
> +						retbleed_mitigation = RETBLEED_MITIGATION_UNRET_SRSO_ALIAS;
> +					else
> +						retbleed_mitigation = RETBLEED_MITIGATION_UNRET_SRSO;

It would be great to get confirmation from somebody at AMD that the SRSO
mitigations supersede the Retbleed one, i.e., that the SRSO mitigations
also fix Retbleed.

Yes, the original patches might imply that, but they also seem confused
since they do the double untraining for both Retbleed and SRSO.  And I
was given conflicting information.

Even better, we could really use some official AMD documentation for
this mitigation, since right now it all feels very unofficial and
ubsubstantiated.

> +				}
> +			}
>  			else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY) && boot_cpu_has(X86_FEATURE_IBPB))
>  				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;

Here should have the microcode check too:

				if (boot_cpu_has_bug(X86_BUG_SRSO) && !has_microcode)
					pr_err("IBPB-extending microcode not applied; SRSO NOT mitigated\n");


-- 
Josh
