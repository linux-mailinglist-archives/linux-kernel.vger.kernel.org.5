Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE297EAFF0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjKNMiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjKNMh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:37:59 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E43130
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:37:56 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 08B4140E0032;
        Tue, 14 Nov 2023 12:37:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AgP-2sgolYPu; Tue, 14 Nov 2023 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1699965472; bh=ff3CyeqbM/34ceji11Oxk6J4DwZtHSO93zu+0wpNhVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qp7AkT8Dpcw7M1+7H+8+RyGxtzH1S4vOLDgk439rFhkelIw7sg7DaWvGGnSqts9tp
         pq3ipISceieOt7sca1ei9leDDO00RzpzIm/dTzfcgy5EF4JtxsVmTdEZBF3qeSMs19
         EGzYvIS+kKemrd/clF0yI/1inC2tTUajANs1LehLNnCmTtP5mfLAqY36ygUNvHmxkY
         g8zP4DcP0m2POCeNtBZOgk+RmF2rvLoSBGZePOY/fixBMc8OGSIObKl1F7Zb4blt4e
         e6ptPgzr/GJ+4IlnZyhVXYEnMLA/c1MeS+wzH/k8sLwzjbqY8Kq790RauVMZfSoYhF
         dP5AkT0lGTMOWcoynTXyoYUQCiWBeDmkAS5S2dgRYELEsYGtUMaP7UHawu/omXKvjS
         j9dchlLN+nEUUKeeMndNsv/DjZedbF/vJmlhr7Ux+yq/XXUer6TNum5ouhk/kZeXho
         Mzrl4kXHLQCviFM8zqbTy4QA/m65tsQxHbCa6aQPEVQuLuOCjAEaPQx2N4Z0191avX
         nMMTLyw1gPtZXrg4blSU4ezMLAZnbg3CIVvIpX4XjzFxO3ZizJTwbkhBsCckYJOUJr
         nH9E/T5FRddUeoSDcxDkmcl6+RpxeP/3w0MyfaOZv4YE2jAxDmF6PSqvbr79cDuz5U
         DtWMu1S9TACy7BxMbkDwgQZc=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB06B40E0030;
        Tue, 14 Nov 2023 12:37:43 +0000 (UTC)
Date:   Tue, 14 Nov 2023 13:37:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 2/5] x86/alternative: add indirect call patching
Message-ID: <20231114123737.GBZVNqEXKgt+6P1Wiv@fat_crate.local>
References: <20231030142508.1407-1-jgross@suse.com>
 <20231030142508.1407-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030142508.1407-3-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 03:25:05PM +0100, Juergen Gross wrote:
> + * Rewrite the "call BUG_func" replacement to point to the target of the
> + * indirect pv_ops call "call *disp(%ip)".
> + */
> +static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
> +{
> +	void *target, *bug = &BUG_func;
> +
> +	if (a->replacementlen != 5 || insn_buff[0] != CALL_INSN_OPCODE) {
> +		pr_err("Alternative: ALT_FLAG_CALL set for a non-call replacement instruction\n");

No need for the printk prefix.

> +		pr_err("  Ignoring the flag for the instruction at %pS (%px)\n", instr, instr);

No ignoring - BUG

> +		return 5;
> +	}
> +
> +	if (a->instrlen != 6 || instr[0] != 0xff || instr[1] != 0x15) {
> +		pr_err("Alternative: ALT_FLAG_CALL set for unrecognized indirect call\n");
> +		pr_err("  Not replacing the instruction at %pS (%px)\n", instr, instr);
> +		return -1;

Ditto.

> +	}
> +
> +#ifdef CONFIG_X86_64
> +	/* ff 15 00 00 00 00   call   *0x0(%rip) */
> +	target = *(void **)(instr + a->instrlen + *(s32 *)(instr + 2));
> +#else
> +	/* ff 15 00 00 00 00   call   *0x0 */
> +	target = *(void **)(*(s32 *)(instr + 2));
> +#endif
> +	if (!target)
> +		target = bug;
> +
> +	/* (BUG_func - .) + (target - BUG_func) := target - . */
> +	*(s32 *)(insn_buff + 1) += target - bug;

If I squint hard enough, this looks like it is replacing one call with
another. We have a C macro alternative_call() which does exactly that.
Why can't you define an asm version ALTERNATIVE_CALL and use it
instead of using adding a new flag? We have 16 possible ones in total.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
