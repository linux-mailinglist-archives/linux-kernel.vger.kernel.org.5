Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE637F1988
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjKTRPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjKTRPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:15:34 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40211CF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:15:29 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 47EF040E01E3;
        Mon, 20 Nov 2023 17:15:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xaSCVYJ0f5QL; Mon, 20 Nov 2023 17:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700500522; bh=fdWOmTLSf43i6ShLExgvRSvrIeZq2RHpM/h9jmmkNZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=daxxyimAXN57KctBefPhYIwyK4snLXUgmDClLS+QVbmGWRaAzUfsvIsJv1wE0Dkpw
         mw64wujRNjuqM997QZBwY9CswEzpzif3IYD+OOVqamQVHv8bDpXpFY+twI7IbdjNJr
         jZfzoioSKsa8VwcOZ28X5Ro8jS9itjs+A7Kk4YwM8P0243lB0dZ5Xz0Acvc3o2HeYv
         pz5QiCLBjgCgfxcDnvLnnkldWB7sIHbtan+7PsuSzNsm1PgbrVWot5Zo1sD7EaqWcq
         D5+JNiTsvh3sfP/qjniAhsQTaI6rxSZU5L2W2VZNSFllsdsb3O0CPwoqFVOhb+fdtO
         9B+xaXtX3/9ObIPrnFgiIDitUGonYXujWom4mEYGu7jO0pJVEGOaVSj9kKXLzWOZDR
         hIaPN3/74iTqOUljBHGyWfQinRpOERXZFp7C+vwMYkCpNNNHw4BYCddap7XdeZvpXN
         yhOKwmSUqzGpytN96CNox0E1VTJRGSyKFDASTmNtBDO5p6dtnVkO2RmihtxxmRQFni
         IUxmp2/3FjmWcV9i8eCeH544YdZ54SJjBQ3VyhnLQRzXIvC5X1tSj7nNtwuhGBol4Y
         Z0AyMOR1uRIXY4X/1/tMA/7/kFpk8S0JZXocpA1Hq/R9wEiBfktPHt7GK2OFNn1lb0
         mA2nfZHTxlYV/d3g1pHpiJ0U=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3B2C340E0197;
        Mon, 20 Nov 2023 17:15:12 +0000 (UTC)
Date:   Mon, 20 Nov 2023 18:15:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/mm/encrypt: Use %a asm operand modifier to obtain
 %rip-relative address
Message-ID: <20231120171507.GGZVuUG9aSLyF52jHd@fat_crate.local>
References: <20231120153419.3045-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231120153419.3045-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 04:33:50PM +0100, Uros Bizjak wrote:
> The "a" asm operand modifier substitutes a memory reference, with the
> actual operand treated as address.  For x86_64, when a symbol is
> provided, the "a" modifier emits "sym(%rip)" instead of "sym".
> 
> Clang allows only "i" and "r" operand constraints with an "a" modifier,
> so the patch normalizes the modifier/constraint pair to "a"/"i"

s/the patch normalizes/normalize/

> which is consistent between both compilers.
> 
> No functional change intended.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  arch/x86/mm/mem_encrypt_identity.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index d73aeb16417f..6a351fdd1b39 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -346,9 +346,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>  	 * We're running identity mapped, so we must obtain the address to the
>  	 * SME encryption workarea using rip-relative addressing.
>  	 */
> -	asm ("lea sme_workarea(%%rip), %0"
> -	     : "=r" (workarea_start)
> -	     : "p" (sme_workarea));
> +	asm ("lea %a1, %0" : "=r" (workarea_start) : "i" (sme_workarea));

Yeah, I saw that particular subthread today.

Are you sure this "a" modifier DTRT with all gcc version we support?

I.e., from 5.1 onwards...

Just making sure.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
