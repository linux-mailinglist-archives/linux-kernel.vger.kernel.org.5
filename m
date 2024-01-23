Return-Path: <linux-kernel+bounces-34630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95E6838566
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701051F27E93
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88F76D39;
	Tue, 23 Jan 2024 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xK++tvpq"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8BA525A;
	Tue, 23 Jan 2024 02:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705976540; cv=none; b=d/J0dWmWaIogFvVp6cwXpwE0SmJChac4KItL+B3NQWGRQ3bnApNZHdyFh97LJNRjOrtufgojaMVNaLQnFC7y6cc3EZGloSWb8VL1IXxOBwpSiiLMKFt8AnafpIfDJEp5d8sfuk0m+FU4fai826V6/LjWVo8iwxYqPHCENM0vUJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705976540; c=relaxed/simple;
	bh=bZQqGV+tVhTYkP1ZSDB5Uu7PAmM00usg2bGknYPkfhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usAIOGkGnSjgPWd5SPUHZsMtTvqitHK6w+/r4y2A+7/jxrHN6noGwMi0jRYMeCfJHHaeTl8Rzqcb+ADBvJis1oEf4aMFBJh0RlLTROOlUU/LNDpgpFypSByqTiv3eD17rZdGHNxPqN/Km+ALjVLjnJKSogmy9Kxk6HHWl+gxRDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xK++tvpq; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Jan 2024 21:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705976536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CZnREvVNBc8M76lu16TSPPTvEq0KborxNGxOPOEyHDU=;
	b=xK++tvpqch9wd7Rfu8Ts7SrVgbzEQgygY3sLnhCtdGH7aYI/28H9t/wPltEqTz3xXfZz+s
	1xddsnZpsmHTw6KitJbw+dKXL9vCQhXg/5CYgxnJb89NFxV10tLbSmLs17Kv+GW4BEXzKs
	/zWGDLpgA01M3CGpQrVNeUv0jVRNeeQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/82] overflow: Refactor open-coded arithmetic
 wrap-around
Message-ID: <337u2jcp3s2vrvotj4jppgpr7zas5fod6k3mhe263ghpux7s5x@knz6eibm2jis>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 22, 2024 at 04:26:35PM -0800, Kees Cook wrote:
> Hi,
> 
> In our continuing effort to eliminate root causes of flaws in the kernel,
> this series is the start to providing a way to have sensible coverage
> for catching unexpected arithmetic wrap-around.
> 
> A quick word on language: while discussing[1] the finer details of
> the C standard's view on arithmetic, I was disabused of using the term
> "overflow" when what I really mean is "wrap-around". When describing
> security vulnerabilities, "overflow" is the common term and often used
> interchangeably with "wrap-around". Strictly speaking, though, "overflow"
> applies only to signed[2] and pointer[3] types, and "wrap-around" is for
> unsigned[4]. An arithmetic "overflow" is considered undefined behavior,
> which has caused our builds pain in the past, since "impossible"
> conditions might get elided by the compiler. As a result, we build
> with -fno-strict-overflow which coverts all "overflow" conditions into
> "wrap-around" (i.e. 2s complement), regardless of type.
> 
> All this is to say I am discussing arithmetic wrap-around, which is
> the condition where the value exceeds a type's maximum value (or goes
> below its minimum value) and wraps around. I'm not interested in the
> narrow definition of "undefined behavior" -- we need to stamp out the
> _unexpected_ behavior, where the kernel operates on a pathological value
> that wrapped around without the code author's intent.
> 
> As always, this is about being able disambiguate the intent of arithmetic
> in the kernel. We intentionally use wrapping arithmetic in all kinds of
> places, but we need to be able to annotate it as such going forward so
> the compiler can distinguish when it needs to perform instrumentation
> (when such instrumentation is enabled).
> 
> Getting back to my earlier mention of -fno-strict-overflow, the bulk of
> the series is refactoring for a common code pattern in the kernel where
> to test for potentially overflowing addition, the addition is performed,
> and wrap-around is tested for. This is what originally[5] caused us to
> enable -fno-strict-overflow:
> 
> 	var + offset < var
> 
> For these cases we can use either check_add_overflow() or
> add_would_overflow(). These helpers will not trip the wrap-around
> instrumentation, and do not depend on the whims of the compiler options.
> (Note that I have no intention of removing -fno-strict-overflow any
> time soon, if ever. As with all these kinds of changes, we need to
> evolve our support for it, and we can't introduce undefined behavior
> into the kernel.)
> 
> This series is mainly 3 parts:

This all seems fine, but... Rust already has this at the type system
level....

I know you're not one of the people bringing bickering into the Rust
threads, so I'm wondering if perhaps your secret plan is to annoy the
die hard "I want everything to be fast with razor blades everywhere" C
programmers enough to finally get onboard the "let's just switch to a
language with less razor wire" train.

