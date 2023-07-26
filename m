Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524C4762938
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjGZDXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjGZDXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9D126A5;
        Tue, 25 Jul 2023 20:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 306C9611B1;
        Wed, 26 Jul 2023 03:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE84C433C9;
        Wed, 26 Jul 2023 03:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690341802;
        bh=8R4nb7sZtOiJ7QLCgtoyNB8CYCZmCnMHzcUaqu+0Exo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AM64JEDMNgTbAVJDKPZpbskhxv23h0B6z/naDOyMSJ89K1+TxkbSSxPi8Xyt3vlLa
         pe3tug470BN9avOE1oMQxtJdBloKyTxPj6gKOA7PhR16vswmThQzc1qLlAJoptCgTS
         TtxKkmAp04mdR3wPTelTjoElxul9FI5OvqWZ8ZlOQt5Jp6XH9RZKrsI0B45fVlu9fv
         pkcb38N+jzxycuqRpZNyWSvbbqOvK+52mHxYB5pObVnhuZoZ25FcjuachercgJ43X0
         6K7PMkQWdjm68Z9MoZ7CZ66yXB8wmMQkPj3I9/N7mSZig9X0Xa+xDjSoi66iJfnp7v
         M5m3Wejk4YUtA==
Date:   Wed, 26 Jul 2023 12:23:17 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/kprobes: Prohibit probing on compiler
 generated CFI checking code
Message-Id: <20230726122317.9058a6bed272835f0c1a3b29@kernel.org>
In-Reply-To: <168904025785.116016.12766408611437534723.stgit@devnote2>
References: <168904023542.116016.10540228903086100726.stgit@devnote2>
        <168904025785.116016.12766408611437534723.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 10:50:58 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Prohibit probing on the compiler generated CFI typeid checking code
> because it is used for decoding typeid when CFI error happens.
> 
> The compiler generates the following instruction sequence for indirect
> call checks on x86;
> 
>    movl    -<id>, %r10d       ; 6 bytes
>    addl    -4(%reg), %r10d    ; 4 bytes
>    je      .Ltmp1             ; 2 bytes
>    ud2                        ; <- regs->ip
> 
> And handle_cfi_failure() decodes these instructions (movl and addl)
> for the typeid and the target address. Thus if we put a kprobe on
> those instructions, the decode will fail and report a wrong typeid
> and target address.
> 
> 

Hi Peter,

Can I pick this to probes/fixes branch ?

Thank you,

> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/kprobes/core.c |   34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index f7f6042eb7e6..fa8c2b41cbaf 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -54,6 +54,7 @@
>  #include <asm/insn.h>
>  #include <asm/debugreg.h>
>  #include <asm/ibt.h>
> +#include <asm/cfi.h>
>  
>  #include "common.h"
>  
> @@ -293,7 +294,40 @@ static int can_probe(unsigned long paddr)
>  #endif
>  		addr += insn.length;
>  	}
> +	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
> +		/*
> +		 * The compiler generates the following instruction sequence
> +		 * for indirect call checks and cfi.c decodes this;
> +		 *
> +		 *   movl    -<id>, %r10d       ; 6 bytes
> +		 *   addl    -4(%reg), %r10d    ; 4 bytes
> +		 *   je      .Ltmp1             ; 2 bytes
> +		 *   ud2                        ; <- regs->ip
> +		 *   .Ltmp1:
> +		 *
> +		 * Also, these movl and addl are used for showing expected
> +		 * type. So those must not be touched.
> +		 */
> +		__addr = recover_probed_instruction(buf, addr);
> +		if (!__addr)
> +			return 0;
> +
> +		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
> +			return 0;
> +
> +		if (insn.opcode.value == 0xBA)
> +			offset = 12;
> +		else if (insn.opcode.value == 0x3)
> +			offset = 6;
> +		else
> +			goto out;
> +
> +		/* This movl/addl is used for decoding CFI. */
> +		if (is_cfi_trap(addr + offset))
> +			return 0;
> +	}
>  
> +out:
>  	return (addr == paddr);
>  }
>  
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
