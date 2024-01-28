Return-Path: <linux-kernel+bounces-41490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5364183F2B3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB87284A0C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8DF1378;
	Sun, 28 Jan 2024 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeSr2jMd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655910F4;
	Sun, 28 Jan 2024 01:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706404757; cv=none; b=lRDOOVxoNt0dkYXxDzGDTbQflKGN+66yxXQJr4FOhhvjoQiec2LEaveW1y5Qp7Hdsvk75dFofI/9c9/sqjd/ZvspJe5QtP8JclRSIjrbE0ji3nmEgMyVqeuhKpVi7rO+g8+83OUIJhTkgmc6DiZmo9MmqDMwKnJAgwk/quUJvR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706404757; c=relaxed/simple;
	bh=4vN+Wp5R3Xg7vb/yOU6Y+a5jTOevSrMskJGWjb3v2Y0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bwrQnQozfqe8N3pb3wKIV4Jr5pwzjsrEvcWv3iqqmrrrLFcBC/4ja9EN4MUth6kC+/3Oz1oiwBdWn3XTHHUX0xiPQJjZMTebDBYid8C+otzbruuPEyYJf6KOeTho+4NPriMQQlh7fMrezAaIyfXlR64OcNadD/oToQ6r/tzcuyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeSr2jMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0CDC433C7;
	Sun, 28 Jan 2024 01:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706404756;
	bh=4vN+Wp5R3Xg7vb/yOU6Y+a5jTOevSrMskJGWjb3v2Y0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FeSr2jMd/GLT9e1K3PGk6edrX1iMnsKOR2ww2aB0wC+6/U79exBGgoWgHMVYx6IcA
	 wIz3qsSJfba/SpH+UHDrvbIqBpI0UVLpaHJ8iawunE/7+2M7MPGEA6eh5znmIoSm5T
	 22I3XJQJiKNdKXbECqilLFH7lKnvSBXPkO8DEnpCVRX81FCNxz4Sx/CLzTvvVCPqeD
	 krl8UXCTYKb3KxxhPv0AFk0pVTliGUlqiQNnfHdWFp1XxWbRf0F+SpcoJ1BBfrQvs1
	 NTQxYEAs70vo1QcWo2tmn5i7Vjg+QjIVKdXV4Ly+BIn1yoGIq4YNIcAU/R3PhACoVD
	 +kbep/BXwHBFQ==
Date: Sun, 28 Jan 2024 10:19:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] x86/kprobes: Prohibit kprobing on INT and UD
Message-Id: <20240128101912.5ad6717347bd66089ecea03a@kernel.org>
In-Reply-To: <20240127044124.57594-2-jinghao7@illinois.edu>
References: <20240127044124.57594-1-jinghao7@illinois.edu>
	<20240127044124.57594-2-jinghao7@illinois.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 22:41:23 -0600
Jinghao Jia <jinghao7@illinois.edu> wrote:

> Both INTs (INT n, INT1, INT3, INTO) and UDs (UD0, UD1, UD2) serve
> special purposes in the kernel, e.g., INT3 is used by KGDB and UD2 is
> involved in LLVM-KCFI instrumentation. At the same time, attaching
> kprobes on these instructions (particularly UDs) will pollute the stack
> trace dumped in the kernel ring buffer, since the exception is triggered
> in the copy buffer rather than the original location.
> 
> Check for INTs and UDs in can_probe and reject any kprobes trying to
> attach to these instructions.
> 

Thanks for implement this check!


> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> ---
>  arch/x86/kernel/kprobes/core.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index e8babebad7b8..792b38d22126 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -252,6 +252,22 @@ unsigned long recover_probed_instruction(kprobe_opcode_t *buf, unsigned long add
>  	return __recover_probed_insn(buf, addr);
>  }
>  
> +static inline int is_exception_insn(struct insn *insn)
> +{
> +	if (insn->opcode.bytes[0] == 0x0f) {
> +		/* UD0 / UD1 / UD2 */
> +		return insn->opcode.bytes[1] == 0xff ||
> +		       insn->opcode.bytes[1] == 0xb9 ||
> +		       insn->opcode.bytes[1] == 0x0b;
> +	} else {

If "else" block just return, you don't need this "else".

bool func()
{
	if (cond)
		return ...

	return ...
}

Is preferrable because this puts "return val" always at the end of non-void
function.

> +		/* INT3 / INT n / INTO / INT1 */
> +		return insn->opcode.bytes[0] == 0xcc ||
> +		       insn->opcode.bytes[0] == 0xcd ||
> +		       insn->opcode.bytes[0] == 0xce ||
> +		       insn->opcode.bytes[0] == 0xf1;
> +	}
> +}
> +
>  /* Check if paddr is at an instruction boundary */
>  static int can_probe(unsigned long paddr)
>  {
> @@ -294,6 +310,16 @@ static int can_probe(unsigned long paddr)
>  #endif
>  		addr += insn.length;
>  	}
> +	__addr = recover_probed_instruction(buf, addr);
> +	if (!__addr)
> +		return 0;
> +
> +	if (insn_decode_kernel(&insn, (void *)__addr) < 0)
> +		return 0;
> +
> +	if (is_exception_insn(&insn))
> +		return 0;
> +

Please don't put this outside of decoding loop. You should put these in
the loop which decodes the instruction from the beginning of the function.
Since the x86 instrcution is variable length, can_probe() needs to check
whether that the address is instruction boundary and decodable.

Thank you,

>  	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
>  		/*
>  		 * The compiler generates the following instruction sequence
> @@ -308,13 +334,6 @@ static int can_probe(unsigned long paddr)
>  		 * Also, these movl and addl are used for showing expected
>  		 * type. So those must not be touched.
>  		 */
> -		__addr = recover_probed_instruction(buf, addr);
> -		if (!__addr)
> -			return 0;
> -
> -		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
> -			return 0;
> -
>  		if (insn.opcode.value == 0xBA)
>  			offset = 12;
>  		else if (insn.opcode.value == 0x3)
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

