Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8AB760E66
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjGYJVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjGYJUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:20:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ADE1FE2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:20:10 -0700 (PDT)
Received: from nazgul.tnic (unknown [193.118.249.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F28C1EC09F1;
        Tue, 25 Jul 2023 11:20:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690276809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kRCYMYHCn+/rcymTFozYB+zVeZAOhN1wAF3axD4N0ec=;
        b=DTodZjQ0CEbZdlzJDqE30r/GYILSTB5cDRhLPtuKVmHLfF5pER7en+iOkQNm2FPC5CaC5n
        cix35f4hAikD/sohTa3yhlT6lRzepKwG3p0wi9LAm8Eiy1bIYpvDsYMiDA6JQXk62SKrHL
        JZXwHS8ymhlyP1l/e1gAKEq39tJGLMU=
Date:   Tue, 25 Jul 2023 11:20:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Fix amd_check_microcode() declaration
Message-ID: <20230725092046.GAZL+T7ln/TKBOuihi@fat_crate.local>
References: <20230725082638.956675-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230725082638.956675-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:26:13AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added amd_check_microcode() function has two conflicting definitions
> if CONFIG_CPU_SUP_AMD is enabled and CONFIG_MICROCODE_AMD is disabled. Since
> the header with the stub definition is not included in cpu/amd.c, this only
> causes a -Wmissing-prototype warning with W=1

Can we please promote -Wmissing-prototype to default or is it too noisy
yet?

> diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
> index 9675c621c1ca4..6a860d40b0411 100644
> --- a/arch/x86/include/asm/microcode_amd.h
> +++ b/arch/x86/include/asm/microcode_amd.h
> @@ -48,13 +48,18 @@ extern void __init load_ucode_amd_bsp(unsigned int family);
>  extern void load_ucode_amd_ap(unsigned int family);
>  extern int __init save_microcode_in_initrd_amd(unsigned int family);
>  void reload_ucode_amd(unsigned int cpu);
> -extern void amd_check_microcode(void);
>  #else
>  static inline void __init load_ucode_amd_bsp(unsigned int family) {}
>  static inline void load_ucode_amd_ap(unsigned int family) {}
>  static inline int __init
>  save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
>  static inline void reload_ucode_amd(unsigned int cpu) {}
> +#endif
> +
> +#ifdef CONFIG_CPU_SUP_AMD
> +extern void amd_check_microcode(void);
> +#else
>  static inline void amd_check_microcode(void) {}
>  #endif
> +
>  #endif /* _ASM_X86_MICROCODE_AMD_H */

Considering how cpu/amd.c provides the function implementation, that
header gunk should not be in microcode_amd.h but in ...asm/processor.h,
I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
