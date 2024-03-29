Return-Path: <linux-kernel+bounces-124350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C9D891611
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5DB1F22D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B524F20C;
	Fri, 29 Mar 2024 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq6iCQ5z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC8A4F5E6;
	Fri, 29 Mar 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704695; cv=none; b=DJmThGbAIA4mcuBsDR1LJC+L0BZp1oFHY7pA+SfFC6Q1cpeXGkEzkKCay15wQc6tYcATsZMTGWQh4P8lzox1UJR3vUilPjX62sWPDUAEBOgyQ8A4ap8h4LptWy8qnCGQLckACtjW8qxlCXBul+EhOMQSM06mMvhRmPIHNedjUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704695; c=relaxed/simple;
	bh=22g7mmTzwyhTsP+0wGXlDY7nA4zn4oruXJTUzUq+dRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3EDa6PlgdvizTekpI+Sj1nXzfr2pzXZUdB0VT1L7VWoBqYfXPTKNag/VoH8bQ84rmbSnVgp3uvYSoODQ9XSwRhhq2ARmFFq+4ejoQmgVHPwcikZxvcO1dy7gWfzrcKcAaRjZXDKIl+/mOm2o5wqU0k/XW9KIaz09u3Fba6l/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq6iCQ5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D97C433C7;
	Fri, 29 Mar 2024 09:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711704694;
	bh=22g7mmTzwyhTsP+0wGXlDY7nA4zn4oruXJTUzUq+dRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jq6iCQ5znoerRWqIp7rCQTKYh9nrasdXnhphKKBvFgJM+XGHhgofkct75A0ZslnV9
	 HieVjvWr0eISQ1l21D8eGPxRSLZu0zEPjArajBlO02hekmm9u/ptD/cjO87u0PRJ8m
	 qEnkSjLsI42+GmcMnMc9zXwIKz/gGDVa7XFjNmGh0DtEjAnUQfh3FKdzsdXDkJUn+0
	 gx1hLCfMMjV28kUkxIeoUKJBzAYKHS7x1QQ38zY2CpAGGmLdYow28MYuPgbXhegEv/
	 3Szpmx5OOzYZ8DtlgiK8s+VyzlfA8+2XAZLrbBlbir6b2J2i1tSLtbelbi9kefoQk7
	 7FVvMwIDs6KIA==
Date: Fri, 29 Mar 2024 02:31:30 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v2 0/6] Faster AES-XTS on modern x86_64 CPUs
Message-ID: <20240329093130.GA65937@sol.localdomain>
References: <20240329080355.2871-1-ebiggers@kernel.org>
 <CAMj1kXEupfkpe98PdtbxQbtx1z5J_fZFPzT7wJ2tsJnCT9uaxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEupfkpe98PdtbxQbtx1z5J_fZFPzT7wJ2tsJnCT9uaxA@mail.gmail.com>

On Fri, Mar 29, 2024 at 11:03:07AM +0200, Ard Biesheuvel wrote:
> 
> Retested this v2:
> 
> Tested-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Hopefully, the AES-KL keylocker implementation can be based on this
> template as well.

As-is, it would be a bit ugly to add keylocker support to my template because my
template always processes 4 registers of AES blocks per iteration of the main
loop (like the existing aes-xts-aesni), whereas the keylocker instructions are
hardcoded to operate on 8 AES blocks at a time in xmm0-xmm7, presumably to
reduce the overhead of unwrapping the key.

I did try an 8-wide version briefly.  There are some older CPUs on which it
helps.  (On newer CPUs, AES latency is lower, and the width increases by moving
to ymm or zmm registers anyway.)  But it didn't seem too attractive to me.  It
causes registers to spill, and it becomes a bit awkward to unroll the AES rounds
when the code size is twice as large, so it may need to be re-rolled.  I should
take a closer look, but I decided to just stay with a 4-wide version for now.

So I *think* AES-KL is best kept separate for now.  I do wonder if the AES-KL
code should adopt the idea of using VEX-coded instructions, though --- surely
it's the case that in practice, any CPU with AES-KL also supports AVX.

> I wouldn't mind retiring the existing xts(aesni)
> code entirely, and using the xts() wrapper around ecb-aes-aesni on
> 32-bit and on non-AVX uarchs with AES-NI.

Yes, it will need to be benchmarked, but that probably makes sense.  If
Wikipedia is to be trusted, on the Intel side only Westmere (from 2010) has
AES-NI but not AVX, and on the AMD side all CPUs with AES-NI have AVX...

- Eric

