Return-Path: <linux-kernel+bounces-162657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6E88B5E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7D6280A80
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7690984D2A;
	Mon, 29 Apr 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LaO4fbIP"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A02E84D09
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406945; cv=none; b=k4wesf53uk78tQyzV/z/3XhuwhTkCg7PE/1FVf7PO8oAYpuX0Lq9DshjE6BMQqERqLnwxWijzOsjQzr74Bn+xFphXUGjwse1571DAYZ/Cj54qIOUcogLqCjWsbnVDeMTvMBT0vY3d1QOE/tv1uCBU4REiBlZKzwq+WKVAxj8c9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406945; c=relaxed/simple;
	bh=LvzBqbAY1PY61gk+aLDFCJmwIukkaJLn2toM9RxYtM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFOJ5uF0YJw9TlL3f6w8+8nP8XvGKdWNOJD6YQogLEWQA+C/4P3C+KAMZ4OzsdaBfGtpLCKDLsOzzTKCaRUDbEJnKU9i1rd6y4ypkeNQxQXiwr5RFuAJfqu1O5+H94ZpRznG7qxHXsrahL3G1k6zh59vrAjJ2eg/HLBDDTjhIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LaO4fbIP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6effe9c852eso4156320b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714406943; x=1715011743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IE3rlUY5ZNOgD78vlbB6mub+aH2K438H3LXk2XH2tAY=;
        b=LaO4fbIPmfT6nvC0mTvUJoFHlZZMn9gXyuJSKWzff0UsoGZ7IrSqZIr+nrk+joaHdW
         WsQIVgT01MCjYncOReKtqG7ZVEKaHjz8gr/nT7xTO2KUB5FLWnFaB74A6aMRdGiUkNTO
         h5uRFuuFFR0NyWrxprzPGDkYpfWOwRu2KUhd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406943; x=1715011743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IE3rlUY5ZNOgD78vlbB6mub+aH2K438H3LXk2XH2tAY=;
        b=RH3E2xAMoO2hMxuUfsK3qj7hdUlXxmvTGLhQBaXMd3Sz++Ton9KMYMIsdq/ZC9baTm
         8LRhsB7g1FXZnrsSUcWmgaa4yMKctOAR5Uxhl94+xndommcbn4X4tNp+DDrCNUorjt3t
         +9tda5PCX1Tr3jStIWTRrhwzqshBjGEh4H6tn+0UIPwqnlpxFIOfTU8XbLf2HtTWnBVx
         vMjzv5gmmkDMKUNiBsfm0qDPwky6KJlO6hkvRIBEyutLM/2eyvvtRoocXesM5XHGCHlq
         6o7qxj9XCC3nhx6DmHmI8YP69AkzSle8GjeeXhhglcJVe/rqNmz8rNfg7KzNLvJUYLMu
         829w==
X-Forwarded-Encrypted: i=1; AJvYcCUzr4Li0jpfArKFi7QdL8zR6ePynuiPXAx40siDcBD6XdcTa6r6ItNwkL6sFxNOpWvViFo8BslxAmdNLAJ8j3c2nU3mIqcxNsn+0S6D
X-Gm-Message-State: AOJu0YyjiE034mny6RFrUP7TMQcsPE+A8iykiv51d+sM+sZTuLmo0aJk
	HuZ2FOJpVN3Cbc8FT8gGc68aLL5xwMiSRppXGbjanzVBBGhWzwoKpSopzMjp3A==
X-Google-Smtp-Source: AGHT+IH5UTtmcsjJwAjt4syow41XjYpcA67edkoZZwv/qSEHCP5kBXIZ2zphlJc0aEN3lfYB1glkXg==
X-Received: by 2002:a05:6a00:4b09:b0:6ed:cc76:3f9f with SMTP id kq9-20020a056a004b0900b006edcc763f9fmr11952173pfb.13.1714406943541;
        Mon, 29 Apr 2024 09:09:03 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g21-20020a056a000b9500b006e6b2ba1577sm19370838pfj.138.2024.04.29.09.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 09:09:02 -0700 (PDT)
Date: Mon, 29 Apr 2024 09:09:02 -0700
From: Kees Cook <keescook@chromium.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xin Li <xin@zytor.com>, Andrew Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: x86: dynamic pt_regs pointer and kernel stack randomization
Message-ID: <202404290859.99763AA1@keescook>
References: <a793c733-267d-4930-8ee2-0fc0f24c3538@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a793c733-267d-4930-8ee2-0fc0f24c3538@zytor.com>

On Sun, Apr 28, 2024 at 03:28:44PM -0700, H. Peter Anvin wrote:
> So the issue of having an explicit pointer to the user space pt_regs
> structure has come up in the context of future FRED extensions, which may
> increase the size of the exception stack frame under some circumstances,
> which may not be constant in the first place.
> 
> It struck me that this can be combined with kernel stack randomization in
> such a way that it mostly amortizes the cost of both.

I've tried to go get up to speed with what FRED changes in x86, and IIUC
it effectively redefines the interrupt handling? Does it also change
syscall entry? (I got the impression it does not, but the mention of
syscalls later in your email make me think I've gotten this wrong.)

I think currently kstack randomization isn't applied to interrupts (but
it should be), so I'm all for finding a way to make this happen.

> Downside: for best performance, it should be pushed into assembly entry/exit
> code, although that is technically not *required* (and it is of course
> possible to do it in C on IDT but in the one single assembly entry stub for
> FRED.)
> 
> In the FRED code it would look like [simplified]:
> 
> asm_fred_entrypoint_user:
> 	/* Current code */
> 	/* ... */
> 	movq %rsp,%rdi		/* part of FRED_ENTER */
> 
> 	/* New code */
> 	movq %rdi,PER_CPU_VAR(user_pt_regs_ptr)	/* [1] */
> #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> 	subq PER_CPU_VAR(kstack_offset),%rsp	/* [2] */
> #endif
> 	/* CFI annotation */
> 
> 	/* Current code */
> 	call fred_entry_from_user
> 
> asm_fred_exit_uTser:
> 	/* New code */
> 	movq PER_CPU_VAR(user_pt_regs_ptr),%rsp
> 	/* CFI annotation */
> 
> 	/* Current code */
> 	/* ... */
> 	ERETU

If I'm understanding FRED correctly, I think this exit path
would need to call choose_random_kstack_offset() as well. (For
syscalls, add_random_kstack_offset() is used on entry and
choose_random_kstack_offset() is used on exit, so I think we'd want the
same pattern for interrupt handling.)

> [1] - This instruction can be pushed into the C code in
> fred_entry_from_user() without changing the functionality in any way.
> 
> [2] - This is the ONLY instruction in this sequence that would be specific
> to CONFIG_RANDOMIZE_KSTACK_OFFSET, and it probably isn't even worth patching
> out.
> 
> This requires a 64-bit premasked value to be generated byc
> choose_random_kstack_offset() which would seem to be a better option for
> performance, especially since there is already arithmetic done at that time.
> Otherwise it requires three instructions. This means the randomness
> accumulator ends up being in a separate variable from the premasked value.
> This could be further very slightly optimized by adding the actual stack
> location and making this a movq, but then that value has to be
> context-switched; this is probably not all that useful.

Yeah, having a pre-masked value ready to go seems fine to me. It's
simply a space trade-off.

> The masking needs to consider alignment, which the current code doesn't;
> that by itself adds additional code to the current code sequences.
> 
> 
> That is literally *all* the code that is needed to replace
> add_random_kstack_offset(). It doesn't block tailcall optimization anywhere.
> If user_pt_regs_ptr and kstack_offset share a cache line it becomes even
> cheaper.
> 
> Note that at least in the FRED case this code would be invoked even on
> events other than system calls, some of which may be controllable by the
> user, like page faults. I am guessing that this is actually a plus.

Yeah, I'd like greater coverage for ring 3->0 transitions. We do want to
double-check the original design choices, though. I *think* they still
stand (see the comments for choose_random_kstack_offset() about entropy
location (per-cpu area), and lifetime (across userspace execution).

-Kees

-- 
Kees Cook

