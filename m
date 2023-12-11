Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AAC80C0BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjLKFjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKFjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:39:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CCDD9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 21:39:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDEDC433C7;
        Mon, 11 Dec 2023 05:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702273195;
        bh=pXkGuPEWqJcgOs6ijfV32w7ZZV3pIr0foEoCn6cP/+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rZ4neWCTUFGh1Y+953GYlVN2hnNOeL71TAYRdsHCd7Jk+zhyeZRMkMX4QL4UlFjPa
         DU8eBc8rFP8uMdvg0IoEazbkZS8MIFjx2HeskY6O2qS21h5tlb/PWQdo0rvmP1+7t7
         ObHCEOH/35CFjFP0DL+z8Lnh6be/Jmsf2g5Q7Hng329CKXKqZsGR9PwBgkCaqRh8KC
         KrpZKo4SLGo25yHGtRKqk//4MuoszNSOYv77wubakdw41SGYJ3m3brJf7jMPrvO50M
         UIefKNDhmr4bhUu8zjWSGJ1Rql78fOVBKwdnFvBAFwCIIzONdg8LahcFp6d814eX2F
         Lgh4qWviAbKPA==
Date:   Mon, 11 Dec 2023 14:39:50 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Naveen N Rao <naveen@kernel.org>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 5/9] powerpc/kprobes: Use ftrace to determine if a
 probe is at function entry
Message-Id: <20231211143950.980b4ab4e11b71de04332540@kernel.org>
In-Reply-To: <15f0b3a2e72326423cfb4ce4e89afff540042245.1702045299.git.naveen@kernel.org>
References: <cover.1702045299.git.naveen@kernel.org>
        <15f0b3a2e72326423cfb4ce4e89afff540042245.1702045299.git.naveen@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Dec 2023 22:00:44 +0530
Naveen N Rao <naveen@kernel.org> wrote:

> Rather than hard-coding the offset into a function to be used to
> determine if a kprobe is at function entry, use ftrace_location() to
> determine the ftrace location within the function and categorize all
> instructions till that offset to be function entry.
> 
> For functions that cannot be traced, we fall back to using a fixed
> offset of 8 (two instructions) to categorize a probe as being at
> function entry for 64-bit elfv2.
> 

OK, so this can cover both KPROBES_ON_FTRACE=y/n cases and the function
is traced by ftrace or not.

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
>  arch/powerpc/kernel/kprobes.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index b20ee72e873a..42665dfab59e 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -105,24 +105,22 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
>  	return addr;
>  }
>  
> -static bool arch_kprobe_on_func_entry(unsigned long offset)
> +static bool arch_kprobe_on_func_entry(unsigned long addr, unsigned long offset)
>  {
> -#ifdef CONFIG_PPC64_ELF_ABI_V2
> -#ifdef CONFIG_KPROBES_ON_FTRACE
> -	return offset <= 16;
> -#else
> -	return offset <= 8;
> -#endif
> -#else
> +	unsigned long ip = ftrace_location(addr);
> +
> +	if (ip)
> +		return offset <= (ip - addr);
> +	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
> +		return offset <= 8;
>  	return !offset;
> -#endif
>  }
>  
>  /* XXX try and fold the magic of kprobe_lookup_name() in this */
>  kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
>  					 bool *on_func_entry)
>  {
> -	*on_func_entry = arch_kprobe_on_func_entry(offset);
> +	*on_func_entry = arch_kprobe_on_func_entry(addr, offset);
>  	return (kprobe_opcode_t *)(addr + offset);
>  }
>  
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
