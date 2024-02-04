Return-Path: <linux-kernel+bounces-51622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8980848D61
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563A4B214E9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301E12232B;
	Sun,  4 Feb 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRao9gSa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B122301;
	Sun,  4 Feb 2024 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048644; cv=none; b=UDGgzjtW8KjMewN9ETg1O/e0mOpFv31Fm0GilxeKf7O8AxT/wzfSTZFXISsqRXjWR4MEr2aXFktqL8X1EhY4PmvcP6fLk+fazXqy/qv2EeF4IY6Hxsn129qr1iLdQTBfjqYcnIPZOSH7sCoYCFtATvA0UvLiiOkExs3BGGSNOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048644; c=relaxed/simple;
	bh=BPvniN+Hg8+5cTPrOXORgWsgaqCcTcXAzzzx/u9z9S0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bm0p4pnnVRPi9BrgzH5xvQGa4eB1xJs7djutj05zjH110FMnKBmPhYWiBmZuE1tg+xZSFKgRsJuY4swFA22tMJh9VMddDiO6uJe0k/+CDZdAiuYgkcLk2PBnSU1LXn/V+g9HqSvh7U85uBOHzR0/tuOGfORkKg/HpZdmCu3jPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRao9gSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901AFC433C7;
	Sun,  4 Feb 2024 12:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707048643;
	bh=BPvniN+Hg8+5cTPrOXORgWsgaqCcTcXAzzzx/u9z9S0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cRao9gSaIOUwiCe2WoH9sCCjRtGmayGOzXtdAcQwDwak+pKUAlOQG1+EFBcP2MNJC
	 7NAT4cEgk2BJkpj5CPSccc2bl46PUdHyENq4/9j+IsooGuJCbsLZ6ZW+ta+7LqQKAE
	 s4tyzd1KMvyjPYQd92CQsncf856qdedOmmrhn0q7gNMU+MQc8C27daNZh3ZAYZU3Ry
	 Kp1R14wDAT9Ki4wfB9HPCfvbyLn7w3fs4h3N1lXZPReY2Wn0F6Ih+UsYcAi72+h0uk
	 G6aLcg1dzwxk2g2d3gaCtp6fr4l+a3GZemGz5qyTVFyAoPFk+eJV3UiJPk6hyotEDN
	 IHwOpz1vOvGPA==
Date: Sun, 4 Feb 2024 21:10:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, Xin Li <xin@zytor.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/kprobes: Refactor can_{probe,boost} return
 type to bool
Message-Id: <20240204211039.9cb7f773e778869503c12692@kernel.org>
In-Reply-To: <20240204031300.830475-2-jinghao7@illinois.edu>
References: <20240204031300.830475-1-jinghao7@illinois.edu>
	<20240204031300.830475-2-jinghao7@illinois.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Feb 2024 21:12:58 -0600
Jinghao Jia <jinghao7@illinois.edu> wrote:

> Both can_probe and can_boost have int return type but are using int as
> boolean in their context.
> 
> Refactor both functions to make them actually return boolean.
> 

This and next one looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Let me pick those.

> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> ---
>  arch/x86/kernel/kprobes/common.h |  2 +-
>  arch/x86/kernel/kprobes/core.c   | 33 +++++++++++++++-----------------
>  2 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/common.h b/arch/x86/kernel/kprobes/common.h
> index c993521d4933..e772276f5aa9 100644
> --- a/arch/x86/kernel/kprobes/common.h
> +++ b/arch/x86/kernel/kprobes/common.h
> @@ -78,7 +78,7 @@
>  #endif
>  
>  /* Ensure if the instruction can be boostable */
> -extern int can_boost(struct insn *insn, void *orig_addr);
> +extern bool can_boost(struct insn *insn, void *orig_addr);
>  /* Recover instruction if given address is probed */
>  extern unsigned long recover_probed_instruction(kprobe_opcode_t *buf,
>  					 unsigned long addr);
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index e8babebad7b8..644d416441fb 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -137,14 +137,14 @@ NOKPROBE_SYMBOL(synthesize_relcall);
>   * Returns non-zero if INSN is boostable.
>   * RIP relative instructions are adjusted at copying time in 64 bits mode
>   */
> -int can_boost(struct insn *insn, void *addr)
> +bool can_boost(struct insn *insn, void *addr)
>  {
>  	kprobe_opcode_t opcode;
>  	insn_byte_t prefix;
>  	int i;
>  
>  	if (search_exception_tables((unsigned long)addr))
> -		return 0;	/* Page fault may occur on this address. */
> +		return false;	/* Page fault may occur on this address. */
>  
>  	/* 2nd-byte opcode */
>  	if (insn->opcode.nbytes == 2)
> @@ -152,7 +152,7 @@ int can_boost(struct insn *insn, void *addr)
>  				(unsigned long *)twobyte_is_boostable);
>  
>  	if (insn->opcode.nbytes != 1)
> -		return 0;
> +		return false;
>  
>  	for_each_insn_prefix(insn, i, prefix) {
>  		insn_attr_t attr;
> @@ -160,7 +160,7 @@ int can_boost(struct insn *insn, void *addr)
>  		attr = inat_get_opcode_attribute(prefix);
>  		/* Can't boost Address-size override prefix and CS override prefix */
>  		if (prefix == 0x2e || inat_is_address_size_prefix(attr))
> -			return 0;
> +			return false;
>  	}
>  
>  	opcode = insn->opcode.bytes[0];
> @@ -181,12 +181,12 @@ int can_boost(struct insn *insn, void *addr)
>  	case 0xf6 ... 0xf7:	/* Grp3 */
>  	case 0xfe:		/* Grp4 */
>  		/* ... are not boostable */
> -		return 0;
> +		return false;
>  	case 0xff:		/* Grp5 */
>  		/* Only indirect jmp is boostable */
>  		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
>  	default:
> -		return 1;
> +		return true;
>  	}
>  }
>  
> @@ -253,20 +253,18 @@ unsigned long recover_probed_instruction(kprobe_opcode_t *buf, unsigned long add
>  }
>  
>  /* Check if paddr is at an instruction boundary */
> -static int can_probe(unsigned long paddr)
> +static bool can_probe(unsigned long paddr)
>  {
>  	unsigned long addr, __addr, offset = 0;
>  	struct insn insn;
>  	kprobe_opcode_t buf[MAX_INSN_SIZE];
>  
>  	if (!kallsyms_lookup_size_offset(paddr, NULL, &offset))
> -		return 0;
> +		return false;
>  
>  	/* Decode instructions */
>  	addr = paddr - offset;
>  	while (addr < paddr) {
> -		int ret;
> -
>  		/*
>  		 * Check if the instruction has been modified by another
>  		 * kprobe, in which case we replace the breakpoint by the
> @@ -277,11 +275,10 @@ static int can_probe(unsigned long paddr)
>  		 */
>  		__addr = recover_probed_instruction(buf, addr);
>  		if (!__addr)
> -			return 0;
> +			return false;
>  
> -		ret = insn_decode_kernel(&insn, (void *)__addr);
> -		if (ret < 0)
> -			return 0;
> +		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
> +			return false;
>  
>  #ifdef CONFIG_KGDB
>  		/*
> @@ -290,7 +287,7 @@ static int can_probe(unsigned long paddr)
>  		 */
>  		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE &&
>  		    kgdb_has_hit_break(addr))
> -			return 0;
> +			return false;
>  #endif
>  		addr += insn.length;
>  	}
> @@ -310,10 +307,10 @@ static int can_probe(unsigned long paddr)
>  		 */
>  		__addr = recover_probed_instruction(buf, addr);
>  		if (!__addr)
> -			return 0;
> +			return false;
>  
>  		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
> -			return 0;
> +			return false;
>  
>  		if (insn.opcode.value == 0xBA)
>  			offset = 12;
> @@ -324,7 +321,7 @@ static int can_probe(unsigned long paddr)
>  
>  		/* This movl/addl is used for decoding CFI. */
>  		if (is_cfi_trap(addr + offset))
> -			return 0;
> +			return false;
>  	}
>  
>  out:
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

