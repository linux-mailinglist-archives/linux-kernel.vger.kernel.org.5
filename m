Return-Path: <linux-kernel+bounces-43760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9C384189E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF92287554
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E574C36AE4;
	Tue, 30 Jan 2024 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTSAGQbd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6636AE5;
	Tue, 30 Jan 2024 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579059; cv=none; b=VfkAUtyG81KixPtn7NzwibELDSGA0DfQLvl32lDYLV8+WNXQM6IbBDBVbirIR+tT72D1cI07hdCx0iebGLmZF9U6HsPPkTxMRT5BQ7ma6DPzPmgyJmRtuNxI0lKzvgosRFmAowIkadjQYyPPaJPcauT60cQMO3Ufz5FkxC7bt/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579059; c=relaxed/simple;
	bh=o3f4/zVkFpKEvn4qbUAfnKptnNUY7pSxrpQ8qjYJXUA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cieAT/RXJQSaB3snUKhYI6+8BWudrC0lQDNtE7zDFqkdULNIncWs9GtreAZi07u9Al1J8rZkePvhz0LUjapJQKNQm05x4hQlb3tHNvsW63B9E8kzm0wY+Xa3ZkvQm0Tig6szz/mwTP+0GdTTHF/7NIqQDpJ/F8UJko5f4oVy1y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTSAGQbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAF5C433F1;
	Tue, 30 Jan 2024 01:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706579058;
	bh=o3f4/zVkFpKEvn4qbUAfnKptnNUY7pSxrpQ8qjYJXUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uTSAGQbd2lRJoto0hbST+cQdZaFy5RxboCGBciJZe37km4HKniIhjk+Bw/M3S5ofH
	 JUSUXlwE2kCJ8gpEGzALGbf5yO+o0xLwna9rNdMiOJ7doO8iMfnXaDi7v5KnEfy/Md
	 E9W+Fm5xubUvQKhzI1tOoye1CqD/iolAVZwBQ9YwxqkgNIt9xXW52uPsF5VQly3T7Q
	 4nJXeJS+bxblVQYP485Q9Zu0VzzJR3in3P+ZW6PIzpv5a9WrlBULmqqKSbi60mL/fW
	 MomzbxXl9kUljwRFz5HKErE9TYQJ6sFkzrIfy13yd2L9X8E34fOCha10VGOHvTS46S
	 4VfO5kzwNAROw==
Date: Tue, 30 Jan 2024 10:44:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] x86/kprobes: Prohibit kprobing on INT and UD
Message-Id: <20240130104414.4548b70ada33ea3180047423@kernel.org>
In-Reply-To: <8c29d66d-b17d-4185-988c-de078566d0da@illinois.edu>
References: <20240127044124.57594-1-jinghao7@illinois.edu>
	<20240127044124.57594-2-jinghao7@illinois.edu>
	<20240128101912.5ad6717347bd66089ecea03a@kernel.org>
	<8c29d66d-b17d-4185-988c-de078566d0da@illinois.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 15:25:59 -0600
Jinghao Jia <jinghao7@illinois.edu> wrote:

> >>  /* Check if paddr is at an instruction boundary */
> >>  static int can_probe(unsigned long paddr)
> >>  {
> >> @@ -294,6 +310,16 @@ static int can_probe(unsigned long paddr)
> >>  #endif
> >>  		addr += insn.length;
> >>  	}
> >> +	__addr = recover_probed_instruction(buf, addr);
> >> +	if (!__addr)
> >> +		return 0;
> >> +
> >> +	if (insn_decode_kernel(&insn, (void *)__addr) < 0)
> >> +		return 0;
> >> +
> >> +	if (is_exception_insn(&insn))
> >> +		return 0;
> >> +
> > 
> > Please don't put this outside of decoding loop. You should put these in
> > the loop which decodes the instruction from the beginning of the function.
> > Since the x86 instrcution is variable length, can_probe() needs to check
> > whether that the address is instruction boundary and decodable.
> > 
> > Thank you,
> 
> If my understanding is correct then this is trying to decode the kprobe
> target instruction, given that it is after the main decoding loop.  Here I
> hoisted the decoding logic out of the if(IS_ENABLED(CONFIG_CFI_CLANG))
> block so that we do not need to decode the same instruction twice.  I left
> the main decoding loop unchanged so it is still decoding the function from
> the start and should handle instruction boundaries. Are there any caveats
> that I missed?

Ah, sorry I misread the patch. You're correct!
This is a good place to do that.

But hmm, I think we should add another patch to check the addr == paddr
soon after the loop so that we will avoid decoding.

Thank you,

> 
> --Jinghao
> 
> > 
> >>  	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
> >>  		/*
> >>  		 * The compiler generates the following instruction sequence
> >> @@ -308,13 +334,6 @@ static int can_probe(unsigned long paddr)
> >>  		 * Also, these movl and addl are used for showing expected
> >>  		 * type. So those must not be touched.
> >>  		 */
> >> -		__addr = recover_probed_instruction(buf, addr);
> >> -		if (!__addr)
> >> -			return 0;
> >> -
> >> -		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
> >> -			return 0;
> >> -
> >>  		if (insn.opcode.value == 0xBA)
> >>  			offset = 12;
> >>  		else if (insn.opcode.value == 0x3)
> >> -- 
> >> 2.43.0
> >>
> > 
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

