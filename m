Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7578235D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjHUGEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjHUGEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:04:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137F583
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:04:18 -0700 (PDT)
Received: from nazgul.tnic (dynamic-089-015-236-044.89.15.236.pool.telefonica.de [89.15.236.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 358941EC04DF;
        Mon, 21 Aug 2023 08:04:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692597850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=J3t+WupPuFpi1ykY1T90OAXE+HLKmdvRc7OoFanc990=;
        b=UuSeWwJ0Yjz/wCGh79w8XjGud1UiQj8YoqSScL13FIfEKJE5kcAXSG8fwySRB7rQukv1J9
        sTpvtgI+hTkKto5k0AOzkVcct4YfcnQEUAtzkkdZW8uvZqqvNNMWaw9QRdLMROmnsNKRuI
        zX9ILf/QVNzhsjnQ/3ugslHabkGXhj0=
Date:   Mon, 21 Aug 2023 08:04:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/22] x86/srso: Fix srso_show_state() side effect
Message-ID: <20230821060416.GBZOL+YJeVj4tbkT78@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <fc64c4e5749d10b398c86b60902d6f9394eb5012.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc64c4e5749d10b398c86b60902d6f9394eb5012.1692580085.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 06:18:58PM -0700, Josh Poimboeuf wrote:
> Reading the 'spec_rstack_overflow' sysfs file can trigger an unnecessary
> MSR write, and possibly even a (handled) exception if the microcode
> hasn't been updated.
> 
> Avoid all that by just checking X86_FEATURE_IBPB_BRTYPE instead, which
> gets set by srso_select_mitigation() if the updated microcode exists.
> 
> Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/kernel/cpu/bugs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index f081d26616ac..bdd3e296f72b 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2717,7 +2717,7 @@ static ssize_t srso_show_state(char *buf)
>

Please put here a comment - something along the lines of:

"X86_FEATURE_IBPB_BRTYPE gets set as a result of the presence of the
needed microcode so checking that is equivalent."

so that it is clear why it is ok to check this feature bit.

>  	return sysfs_emit(buf, "%s%s\n",
>  			  srso_strings[srso_mitigation],
> -			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
> +			  boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) ? "" : ", no microcode");
>  }
>  
>  static ssize_t gds_show_state(char *buf)
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
