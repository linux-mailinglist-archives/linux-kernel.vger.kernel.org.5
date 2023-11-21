Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7767F3660
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjKUSpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjKUSpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:45:34 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC65819E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:45:29 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6909E40E024E;
        Tue, 21 Nov 2023 18:45:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pi_TiCzc_9uo; Tue, 21 Nov 2023 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700592324; bh=tqZ7PE/4BcoxuBf+REmYnd/FNUTP77IUNBiOA3NqXBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yvb+fT8xOBlYmB1NUrqpC3Mb/10WG7VFOOAJz4QZSsDCmKLxCFpjKiX1skk93zTiY
         eSTSXLahx5mm2Oca86NGNual8iH6FvPH5iq3C095o+thk0le0J1dyNCc90D2qebDdC
         FOrmADp89eYbo88spCP2QobNt2l336LQDw3iskvBVygS+ULp8FSiXGaYI/Z9SkJA+T
         q3no1QuGnLJOKQiV770nNOqPzSnpHTGVZlmN6APprs4BuQJ7bouAGmadI2UKu7E0up
         8vegfPN5mRwSN/Hr8UUKG/F1sLZtI/M8WBMIjoHqfFoJ8jFTr64SuCSCTYFnVwmvTs
         mArRdB0qoh78AZwCJBnQnusH54nwN4+7Vc7Zf+dLWMA6csgYbSP1IGeb+APiFLvLno
         YoiBgRxOQfGBLxwduU04DKzS053c08h79YoAMX5jK6qiFlAWrRA8XK3U2Akt8YpCIr
         kEap2SwkIeaay7wDXDavjiM/1d4onDV3Wk5I/ufMXsl9btGbkOQUPxDpy2luI5byli
         G3HeiqVTMaXHtTBtl2t1x0zFqVInHMDWqEs6sZs5Eg/qnJ0D6IsUkatQmaAsX5P79B
         5d9fDNHIdRTFyU1/Zh0yuiedK14bfSYezJIkYZsNnd2iqlPx61XONR7HFb84FdoXTI
         E20JwR+QmYltMnxlWkqmDtWA=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 473AC40E0032;
        Tue, 21 Nov 2023 18:45:12 +0000 (UTC)
Date:   Tue, 21 Nov 2023 19:45:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 4/5] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Message-ID: <20231121184505.GGZVz6sc+4sP7/HFji@fat_crate.local>
References: <20231030142508.1407-1-jgross@suse.com>
 <20231030142508.1407-5-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030142508.1407-5-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 03:25:07PM +0100, Juergen Gross wrote:
> Instead of stacking alternative and paravirt patching, use the new
> ALT_FLAG_CALL flag to switch those mixed calls to pure alternative
> handling.
> 
> This eliminates the need to be careful regarding the sequence of
> alternative and paravirt patching.
> 
> For call depth tracking callthunks_setup() needs to be adapted to patch
> calls at alternative patching sites instead of paravirt calls.

Why is this important so that it is called out explicitly in the commit
message? Is callthunks_setup() special somehow?

> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/alternative.h    |  5 +++--
>  arch/x86/include/asm/paravirt.h       |  9 ++++++---
>  arch/x86/include/asm/paravirt_types.h | 26 +++++++++-----------------
>  arch/x86/kernel/callthunks.c          | 17 ++++++++---------
>  arch/x86/kernel/module.c              | 20 +++++---------------
>  5 files changed, 31 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 2a74a94bd569..07b17bc615a0 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -89,6 +89,8 @@ struct alt_instr {
>  	u8  replacementlen;	/* length of new instruction */
>  } __packed;
>  
> +extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
> +

arch/x86/include/asm/alternative.h:92:extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
arch/x86/kernel/alternative.c:163:extern struct alt_instr __alt_instructions[], __alt_instructions_end[];

Zap the declaration from the .c file pls.

>  /*
>   * Debug flag that can be tested to see whether alternative
>   * instructions were patched in already:
> @@ -104,11 +106,10 @@ extern void apply_fineibt(s32 *start_retpoline, s32 *end_retpoine,
>  			  s32 *start_cfi, s32 *end_cfi);
>  
>  struct module;
> -struct paravirt_patch_site;
>  
>  struct callthunk_sites {
>  	s32				*call_start, *call_end;
> -	struct paravirt_patch_site	*pv_start, *pv_end;
> +	struct alt_instr		*alt_start, *alt_end;
>  };
>  
>  #ifdef CONFIG_CALL_THUNKS
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 3749311d51c3..9c6c5cfa9fe2 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -740,20 +740,23 @@ void native_pv_lock_init(void) __init;
>  
>  #ifdef CONFIG_X86_64
>  #ifdef CONFIG_PARAVIRT_XXL
> +#ifdef CONFIG_DEBUG_ENTRY
>  
>  #define PARA_PATCH(off)		((off) / 8)
>  #define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
>  #define PARA_INDIRECT(addr)	*addr(%rip)
>  
> -#ifdef CONFIG_DEBUG_ENTRY
>  .macro PARA_IRQ_save_fl
>  	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),
>  		  ANNOTATE_RETPOLINE_SAFE;
>  		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);)
> +	ANNOTATE_RETPOLINE_SAFE;
> +	call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);
>  .endm
>  
> -#define SAVE_FLAGS	ALTERNATIVE "PARA_IRQ_save_fl;", "pushf; pop %rax;", \
> -				    ALT_NOT_XEN
> +#define SAVE_FLAGS ALTERNATIVE_2 "PARA_IRQ_save_fl;",			\
> +				 ALT_CALL_INSTR, ALT_CALL_ALWAYS,	\
> +				 "pushf; pop %rax;", ALT_NOT_XEN

How is that supposed to work?

At build time for a PARAVIRT_XXL build it'll have that PARA_IRQ_save_fl
macro in there which issues a .parainstructions section and an indirect
call to

	call *pv_ops+240(%rip);

then it'll always patch in "call BUG_func" due to X86_FEATURE_ALWAYS.

I guess this is your way of saying "this should always be patched, one
way or the other, depending on X86_FEATURE_XENPV, and this is a way to
catch unpatched locations...

Then on a pv build which doesn't set X86_FEATURE_XENPV during boot,
it'll replace the "call BUG_func" thing with the pushf;pop.

And if it does set X86_FEATURE_XENPV, it'll patch in the direct call to
.... /me greps tree ... pv_native_save_fl I guess.

If anything, how those ALT_CALL_ALWAYS things are supposed to work,
should be documented there, over the macro definition and what the
intent is.

Because otherwise we'll have to swap in the whole machinery back into
our L1s each time we need to touch it.

And btw, this whole patching stuff becomes insanely non-trivial slowly.

:-\

> diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
> index faa9f2299848..200ea8087ddb 100644
> --- a/arch/x86/kernel/callthunks.c
> +++ b/arch/x86/kernel/callthunks.c
> @@ -238,14 +238,13 @@ patch_call_sites(s32 *start, s32 *end, const struct core_text *ct)
>  }
>  
>  static __init_or_module void
> -patch_paravirt_call_sites(struct paravirt_patch_site *start,
> -			  struct paravirt_patch_site *end,
> -			  const struct core_text *ct)
> +patch_alt_call_sites(struct alt_instr *start, struct alt_instr *end,
> +		     const struct core_text *ct)
>  {
> -	struct paravirt_patch_site *p;
> +	struct alt_instr *a;
>  
> -	for (p = start; p < end; p++)
> -		patch_call(p->instr, ct);
> +	for (a = start; a < end; a++)
> +		patch_call((u8 *)&a->instr_offset + a->instr_offset, ct);

tip:x86/paravirt has:

5c22c4726e4a ("x86/paravirt: Use relative reference for the original instruction offset")

Perhaps redo yours ontop of tip/master:

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 57e5c2e75c2a..76414aba116d 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -233,14 +233,18 @@ patch_call_sites(s32 *start, s32 *end, const struct core_text *ct)
 }
 
 static __init_or_module void
-patch_paravirt_call_sites(struct paravirt_patch_site *start,
-                         struct paravirt_patch_site *end,
-                         const struct core_text *ct)
+patch_alt_call_sites(struct alt_instr *start, struct alt_instr *end,
+                    const struct core_text *ct)
 {
-       struct paravirt_patch_site *p;
+       struct alt_instr *a;
 
+<<<<<<<
        for (p = start; p < end; p++)
                patch_call((void *)&p->instr_offset + p->instr_offset, ct);
+=======
+       for (a = start; a < end; a++)
+               patch_call((u8 *)&a->instr_offset + a->instr_offset, ct);
+>>>>>>>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
