Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA6A80B520
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 16:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjLIPxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 10:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIPxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 10:53:22 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C82511D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 07:53:27 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 40A2440E00C6;
        Sat,  9 Dec 2023 15:53:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L_W332d421Kv; Sat,  9 Dec 2023 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702137203; bh=qhSGLo6zfbqVux9UuSymY8RoBkm95Qk9cJChfFpjjCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DM5r/W4w+r/FsHCXBhKQZKT6HFhdm/S+3Hobz2S91IFLGhLqXCOgAndRROWPOQEe3
         1jRMqzRRtq5koU0kreSeu4DJ31hnlok90zW2IK4QwXc7K/jwDMsvjqe8i60MMtN2L2
         tCB03kDkq7MIWMk7JastpvAZ/HQ4OIRLNzucPP5qTUxJRIvorHlDx1sGaGNW5Fpl4J
         aesREE3zUfBcbQZ861Udry577F+Ul8LIzUbFZVj7xQpsQHN3Mxo26CLKcZZ5tXTrph
         ernsxI0Cv3vcejlYvPm76YTa2Ml2zvsubv0UYdHuJ9OkQc6502UEFz2CAI7K1lsTGz
         c6/peqNlBnuH8jwrcY2dCInNL80RLD8962kc09M/pjPcN5ELSZLmxFP4tDnHwxYyPb
         HCrV5OR9N8OPpGtldhccruwM/Xo/RlwDTfOOyis6lk7EcWsXncp7qRiqWzNt8x7dsU
         H3NNSI7xfl0xhVglOGP1sake82ZBAUSH7kSpCRr/VPLHhq03AGOcQB9gytDU1lE0PX
         My/7ZayUq6Pz3o1qVYzYdhfvhHPBtDJRcEm26dyk2pbP3vvyEUZWW0yqepTeA9BQqM
         NXjCVQqXNrATgTRgsndTF4/rEy4DjbJ9P3L/K5WG1NACKcZFrZjnwB8+4R6Nh3qvU9
         kWFHwPBWt99x6WtjeqQo9UEw=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 218B140E00C5;
        Sat,  9 Dec 2023 15:53:14 +0000 (UTC)
Date:   Sat, 9 Dec 2023 16:53:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michal Luczaj <mhal@rbox.co>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, shuah@kernel.org, luto@kernel.org,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] x86: UMIP emulation leaking kernel addresses
Message-ID: <20231209155308.GAZXSNZB9PPlcHBI4W@fat_crate.local>
References: <20231206004654.2986026-1-mhal@rbox.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231206004654.2986026-1-mhal@rbox.co>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 01:43:43AM +0100, Michal Luczaj wrote:
> Introducing a DPL check in insn_get_seg_base(), or even in get_desc(),
> seems enough to prevent the decoder from disclosing data.
> 
> diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> index 558a605929db..4c1eea736519 100644
> --- a/arch/x86/lib/insn-eval.c
> +++ b/arch/x86/lib/insn-eval.c
> @@ -725,6 +725,18 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
>  	if (!get_desc(&desc, sel))
>  		return -1L;
>  
> +	/*
> +	 * Some segment selectors coming from @regs do not necessarily reflect
> +	 * the state of CPU; see get_segment_selector(). Their values might
> +	 * have been altered by ptrace. Thus, the instruction decoder can be
> +	 * tricked into "dereferencing" a segment descriptor that would
> +	 * otherwise cause a CPU exception -- for example due to mismatched
> +	 * privilege levels. This opens up the possibility to expose kernel
> +	 * space base address of DPL=0 segments.
> +	 */
> +	if (desc.dpl < (regs->cs & SEGMENT_RPL_MASK))
> +		return -1L;
> +
>  	return get_desc_base(&desc);
>  }
>  
> That said, I guess instead of trying to harden the decoder,

Well, here's what my CPU manual says:

"4.10.1 Accessing Data Segments

...

The processor compares the effective privilege level with the DPL in the
descriptor-table entry referenced by the segment selector. If the
effective privilege level is greater than or equal to (numerically
lower-than or equal-to) the DPL, then the processor loads the segment
register with the data-segment selector. 

If the effective privilege level is lower than (numerically
greater-than) the DPL, a general-protection exception (#GP) occurs and
the segment register is not loaded.

...

4.10.2 Accessing Stack Segments

The processor compares the CPL with the DPL in the descriptor-table
entry referenced by the segment selector. The two values must be equal.
If they are not equal, a #GP occurs and the SS register is not loaded."

So *actually* doing those checks in the insn decoder is the proper thing
to do, IMNSVHO.

> Now, I'm far from being competent, but here's an idea I've tried: tell
> the #GP handler that UMIP-related exceptions come only as #GP(0):
> 
>  	if (static_cpu_has(X86_FEATURE_UMIP)) {
> -		if (user_mode(regs) && fixup_umip_exception(regs))
> +		if (user_mode(regs) && !error_code && fixup_umip_exception(regs))
>  			goto exit;
>  	}

And yap, as you've realized, that alone doesn't fix the leaking.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
