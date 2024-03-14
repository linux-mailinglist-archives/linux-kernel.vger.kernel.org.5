Return-Path: <linux-kernel+bounces-103464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F6B87BFAF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 099CBB2237B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BB27175B;
	Thu, 14 Mar 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0DtOrxi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C258F58104;
	Thu, 14 Mar 2024 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429324; cv=none; b=JRvmmOSbvsk6Z0JAGj1aom0j01EUN1MlYMlhJFCQWbyQU756NtrwPvADxqHzpiqvvkT1TjS9OkB2Dcoo+K/QJ9jG8yrheUF2LHBrCZDXINKky/VqjAB16SVjJNGzJDF3FUCBzzwP/VQg+ecpnV4RpARxIeFTk7awCQiga3IUGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429324; c=relaxed/simple;
	bh=ZxVhf7czTfeiIIUCkLOelycvbKvtdDaeA2logwPvH8M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tbaU9g2pz0X3YHGksxZjfM9SoNsHzot8Ma7ofZuu5OiN7/S/IRlpGIPGtOWCh5AYwDCmJdfyd8Z50Ut/7o30p0dLN01sOTHVoWAEKo5MOfWDqMq04ZrPoojO381FqXjBJwNQwbWu97dSpjUS9o83+nv+BqxRc8qESWw/gSSCE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0DtOrxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D4EC433C7;
	Thu, 14 Mar 2024 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710429324;
	bh=ZxVhf7czTfeiIIUCkLOelycvbKvtdDaeA2logwPvH8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L0DtOrxiHEt/uKIMrK3T71EWdY/UpXsz6R8Jwa9cWxbjbFQz9fJpT0eGbi0fwRuuc
	 Grdl6w/NzfW9ac/iEncj7nd2Q6Xy8tuxK9CFc/kp1w37pwtnG55FQJxAc/tu8FXp6B
	 zO8TBFR2qzuyKneSTMHcNycVFk92XPIKcyGn3Y41rYEAYI+gMgKJvJ9yBB3jtvDFhj
	 ZXUvWSvaxef9aEebsuqeOY7pbTl4KJXvNgNuzx7zAMUVfjYLiGdKKboabMRUS89CFj
	 vB89Q3h6YDYEhdp7yzn5PKJKwa/nEhWJ+lpbHfJ+9SSujinJUodJyIxl5eiMEkx7uA
	 esJbJy584qkxg==
Date: Fri, 15 Mar 2024 00:15:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Qiang
 Zhang <zzqq0103.hey@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Jinghao
 Jia <jinghao7@illinois.edu>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org
Subject: Re: [PATCH] kprobes/x86: Use copy_from_kernel_nofault() to read
 from unsafe address
Message-Id: <20240315001518.d2ecb849b2c951722dd01f9a@kernel.org>
In-Reply-To: <171042914997.151113.2962249725455796854.stgit@devnote2>
References: <20240315000753.a448251fce0291e041f76c13@kernel.org>
	<171042914997.151113.2962249725455796854.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Mar 2024 00:12:30 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Read from an unsafe address with copy_from_kernel_nofault() in
> arch_adjust_kprobe_addr() because this function is used before checking
> the address is in text or not. Syzcaller bot found a bug and reported
> the case if user specifies inaccessible data area,
> arch_adjust_kprobe_addr() will cause a kernel panic.
> 
> 
> Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>
> Closes: https://lore.kernel.org/all/CAKHoSAs2rof6vQVBw_Lg_j3QNku0CANZR2qmy4eT7R5Lo8MFbg@mail.gmail.com/
> Fixes: cc66bb914578 ("x86/ibt,kprobes: Cure sym+0 equals fentry woes")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/x86/kernel/kprobes/core.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index a0ce46c0a2d8..a885eea3bd34 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -335,7 +335,16 @@ static int can_probe(unsigned long paddr)
>  kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
>  					 bool *on_func_entry)
>  {
> -	if (is_endbr(*(u32 *)addr)) {
> +	u32 insn;
> +
> +	/*
> +	 * Since addr is not guaranteed to be safely accessed yet, use
> +	 * copy_from_kernel_nofault() to get the instruction.
> +	 */
> +	if (copy_from_kernel_nofault(&insn, (void *)addr, sizeof(u32)))
> +		return 0;

Oops, it should be NULL.

> +
> +	if (is_endbr(insn)) {
>  		*on_func_entry = !offset || offset == 4;
>  		if (*on_func_entry)
>  			offset = 4;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

