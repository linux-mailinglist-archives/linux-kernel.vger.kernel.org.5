Return-Path: <linux-kernel+bounces-88058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A970086DCD7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14AB1C23D20
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F071869D31;
	Fri,  1 Mar 2024 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHmii60F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196051C2A;
	Fri,  1 Mar 2024 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281020; cv=none; b=amrxZsswbORHWHFhDByOABmrrNKXOb8YGX3ulYqROhNeIfQ7d+u4LPzZnRwjGjq+fylw5fSAKl9OoGpndYSd/CbnJyilAYdv517LqJTOtPjFR0jLB4yJo0bTk3xbpbuY4Rj8/fN/lWfqQUzHsDE1WdwZ0/UqM+lrPQjjlMEz/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281020; c=relaxed/simple;
	bh=u1iHu4eIaiptVr+p3li5vHjKU06YVZVzQkaU1uqK2qs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EyDOeYFhvigqivS00EMpJ+Qm6uEWSUkoUIEIhoYkn8ASxZb5bQbsrnUGWgFE/cCM28aiGtyhmK5PgxLBq3yo9p0mR9RmTr2p36t9kZlhezXfSVCrY2VTAcZO/YLFTLrKYFkveZ9DH9GfYeojNzAxZMMaiDk2FNzD2JQD+TrIefM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHmii60F; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709281018; x=1740817018;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=u1iHu4eIaiptVr+p3li5vHjKU06YVZVzQkaU1uqK2qs=;
  b=AHmii60FQmiWdb52l1QN2y1NzzfgF63KjIxaZp1jMVuo0aCpmSyqlUU0
   g0TRiMwYBKLujr0v9zfj4iB88swssErnDTCeYLNGrNkCfZf4n09ZcEL3s
   scSyyjYfpeLViVngEINaHusRopBVfSf5Ldn7+kjV5kssZN50Ekwoa8Nbu
   Z80iC32RiawBnapRBmhKuzNYodChMyUiVTd218dw9P8urQ9SYmGCCIpBO
   Haw9yAVn7jJnPesKH9mBN2LMwfXeq+UfjmNMuw3TlSiwNl5ii4YouXr4Q
   Gns7t7/Xjq+T9T/OkgKAmvruxZGAv8syMNlto1BqcqQTy6vxsGfUBNK6R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3733834"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="3733834"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:16:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8063103"
Received: from eseresrx-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.228])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:16:53 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Kees Cook <keescook@chromium.org>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>
Cc: Kees Cook <keescook@chromium.org>, "Gustavo A . R . Silva"
 <gustavoars@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 David Laight <David.Laight@aculab.com>, Nick Desaulniers
 <ndesaulniers@google.com>, Martin Uecker
 <Martin.Uecker@med.uni-goettingen.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] compiler.h: Explain how __is_constexpr() works
In-Reply-To: <20240301044428.work.411-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240301044428.work.411-kees@kernel.org>
Date: Fri, 01 Mar 2024 10:16:47 +0200
Message-ID: <87zfvi5pu8.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 29 Feb 2024, Kees Cook <keescook@chromium.org> wrote:
> The __is_constexpr() macro is dark magic. Shed some light on it with
> a comment to explain how and why it works.

Hey, it was a fun little puzzle to figure out using the C standard. Now
you're ruining it for everyone! ;)

The description matches my recollection of how it works. Especially the
meaning of the first 8 threw me off way back when. And looks like I've
replied to that effect for v1.

FWIW,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

but I'm sure there are more pedantic reviewers for all the minor
details.

>
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: David Laight <David.Laight@aculab.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> v2: *thread necromancy* rewrite based on feedback to v1
> v1: https://lore.kernel.org/all/20220131204357.1133674-1-keescook@chromium.org/
> ---
>  include/linux/compiler.h | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index bb1339c7057b..38cd9f3c8f6a 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -231,6 +231,45 @@ static inline void *offset_to_ptr(const int *off)
>   * This returns a constant expression while determining if an argument is
>   * a constant expression, most importantly without evaluating the argument.
>   * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> + *
> + * Details:
> + * - sizeof() return an integer constant expression, and does not evaluate
> + *   the value of its operand; it only examines the type of its operand.
> + * - The results of comparing two integer constant expressions is also
> + *   an integer constant expression.
> + * - The first literal "8" isn't important. It could be any literal value.
> + * - The second literal "8" is to avoid warnings about unaligned pointers;
> + *   this could otherwise just be "1".
> + * - (long)(x) is used to avoid warnings about 64-bit types on 32-bit
> + *   architectures.
> + * - The C Standard defines "null pointer constant", "(void *)0", as
> + *   distinct from other void pointers.
> + * - If (x) is an integer constant expression, then the "* 0l" resolves
> + *   it into an integer constant expression of value 0. Since it is cast to
> + *   "void *", this makes the second operand a null pointer constant.
> + * - If (x) is not an integer constant expression, then the second operand
> + *   resolves to a void pointer (but not a null pointer constant: the value
> + *   is not an integer constant 0).
> + * - The conditional operator's third operand, "(int *)8", is an object
> + *   pointer (to type "int").
> + * - The behavior (including the return type) of the conditional operator
> + *   ("operand1 ? operand2 : operand3") depends on the kind of expressions
> + *   given for the second and third operands. This is the central mechanism
> + *   of the macro:
> + *   - When one operand is a null pointer constant (i.e. when x is an integer
> + *     constant expression) and the other is an object pointer (i.e. our
> + *     third operand), the conditional operator returns the type of the
> + *     object pointer operand (i.e. "int *). Here, within the sizeof(), we
> + *     would then get:
> + *       sizeof(*((int *)(...))  == sizeof(int)  == 4
> + *   - When one operand is a void pointer (i.e. when x is not an integer
> + *     constant expression) and the other is an object pointer (i.e. our
> + *     third operand), the conditional operator returns a "void *" type.
> + *     Here, within the sizeof(), we would then get:
> + *       sizeof(*((void *)(...)) == sizeof(void) == 1
> + * - The equality comparison to "sizeof(int)" therefore depends on (x):
> + *     sizeof(int) == sizeof(int)     (x) was a constant expression
> + *     sizeof(int) != sizeof(void)    (x) was not a constant expression
>   */
>  #define __is_constexpr(x) \
>  	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))

-- 
Jani Nikula, Intel

