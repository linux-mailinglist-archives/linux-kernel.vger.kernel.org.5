Return-Path: <linux-kernel+bounces-44512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 782E9842312
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D591F2B30B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B6266B54;
	Tue, 30 Jan 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gr01gI3J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D040F66B2B;
	Tue, 30 Jan 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614233; cv=none; b=j7o2QEinwUDrY2YIWp+Oe4x35h/EVR8D8rr8O8/EKFB6m1r/RKkKvAnb1yZb2zZcqUIYEAOKdiWM43TEWJtTeTFMFIPvP097QWfz3FxGMB+j/L3DAi+3fTxePrJbku9g2DXUoeFpVCCOJEqg8Qys8Rs42Jwwn3Kj6kqqNM/KoX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614233; c=relaxed/simple;
	bh=9OMcTfbqDWp8yh7PIGJwzemNavrPJGabvoRiA7Mzr1k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pP4yqHbH0fONMdH5EesPSFQF1qCuXntzyyCgtt72ilW4IahPwLIsAcjpUNYFXnG6jHvR08/mf9JccxwO/hUFtRz9SqK42yAxJY43Qa6YUoQl3jWG6c6/eTPlFADOOITNbgDNCzg46XDw0kAo0aR6ayIvHPb/6ac9X9ZfIpf/kK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gr01gI3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5C0C433C7;
	Tue, 30 Jan 2024 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706614233;
	bh=9OMcTfbqDWp8yh7PIGJwzemNavrPJGabvoRiA7Mzr1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gr01gI3JYz5XYMk4rbnDzVsmBHGKnjEHBYvPqo8B+5nZqzZSKrbGfOKTKEzQuMhGz
	 RSc+XS/krLBGGYIQxZyQXkLT/CgY6zkI98Ed9xqcU3qbnq4+bWN/rZMRTcm5bpMntN
	 VdEvzFm+FI15md6QaQWi1EXJVNw/yfUGmMQlap5TCJSJTqwucriUu+QYxZtO0RI8Zg
	 wlQkNaq0RR6cfMM9JKYmWH5q6yqzunbxmCRnU5r0EpyXN2x2VMcH0/G4Vn+nw2bYQZ
	 U1eFQuBjYLM1jp2MRZxIF0FgSpE4RFKKnbxOIT58vNQWuR0b3XVphSMojOjsn9qVP6
	 E9MhggPfj+M2w==
Date: Tue, 30 Jan 2024 20:30:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] x86/kprobes: Prohibit kprobing on INT and UD
Message-Id: <20240130203028.320df28af0bcaf9ce8c91d4d@kernel.org>
In-Reply-To: <15690bf4-a803-4ce0-87bc-ec21727fa38e@illinois.edu>
References: <20240127044124.57594-1-jinghao7@illinois.edu>
	<20240127044124.57594-2-jinghao7@illinois.edu>
	<20240128101912.5ad6717347bd66089ecea03a@kernel.org>
	<8c29d66d-b17d-4185-988c-de078566d0da@illinois.edu>
	<20240130104414.4548b70ada33ea3180047423@kernel.org>
	<15690bf4-a803-4ce0-87bc-ec21727fa38e@illinois.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 20:50:39 -0600
Jinghao Jia <jinghao7@illinois.edu> wrote:

> On 1/29/24 19:44, Masami Hiramatsu (Google) wrote:
> > On Sun, 28 Jan 2024 15:25:59 -0600
> > Jinghao Jia <jinghao7@illinois.edu> wrote:
> > 
> >>>>  /* Check if paddr is at an instruction boundary */
> >>>>  static int can_probe(unsigned long paddr)
> >>>>  {
> >>>> @@ -294,6 +310,16 @@ static int can_probe(unsigned long paddr)
> >>>>  #endif
> >>>>  		addr += insn.length;
> >>>>  	}
> >>>> +	__addr = recover_probed_instruction(buf, addr);
> >>>> +	if (!__addr)
> >>>> +		return 0;
> >>>> +
> >>>> +	if (insn_decode_kernel(&insn, (void *)__addr) < 0)
> >>>> +		return 0;
> >>>> +
> >>>> +	if (is_exception_insn(&insn))
> >>>> +		return 0;
> >>>> +
> >>>
> >>> Please don't put this outside of decoding loop. You should put these in
> >>> the loop which decodes the instruction from the beginning of the function.
> >>> Since the x86 instrcution is variable length, can_probe() needs to check
> >>> whether that the address is instruction boundary and decodable.
> >>>
> >>> Thank you,
> >>
> >> If my understanding is correct then this is trying to decode the kprobe
> >> target instruction, given that it is after the main decoding loop.  Here I
> >> hoisted the decoding logic out of the if(IS_ENABLED(CONFIG_CFI_CLANG))
> >> block so that we do not need to decode the same instruction twice.  I left
> >> the main decoding loop unchanged so it is still decoding the function from
> >> the start and should handle instruction boundaries. Are there any caveats
> >> that I missed?
> > 
> > Ah, sorry I misread the patch. You're correct!
> > This is a good place to do that.
> > 
> > But hmm, I think we should add another patch to check the addr == paddr
> > soon after the loop so that we will avoid decoding.
> > 
> > Thank you,
> > 
> 
> Yes, that makes sense to me. At the same time, I'm also thinking about
> changing the return type of can_probe() to bool, since we are just using
> int as bool in this context.

Yes, that is also a good change :)

Thank you,

> 
> --Jinghao
> 
> >>
> >> --Jinghao
> >>
> >>>
> >>>>  	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
> >>>>  		/*
> >>>>  		 * The compiler generates the following instruction sequence
> >>>> @@ -308,13 +334,6 @@ static int can_probe(unsigned long paddr)
> >>>>  		 * Also, these movl and addl are used for showing expected
> >>>>  		 * type. So those must not be touched.
> >>>>  		 */
> >>>> -		__addr = recover_probed_instruction(buf, addr);
> >>>> -		if (!__addr)
> >>>> -			return 0;
> >>>> -
> >>>> -		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
> >>>> -			return 0;
> >>>> -
> >>>>  		if (insn.opcode.value == 0xBA)
> >>>>  			offset = 12;
> >>>>  		else if (insn.opcode.value == 0x3)
> >>>> -- 
> >>>> 2.43.0
> >>>>
> >>>
> >>>
> > 
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

