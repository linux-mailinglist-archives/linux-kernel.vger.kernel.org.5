Return-Path: <linux-kernel+bounces-35044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D56838AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34DDCB2561F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1009F59B77;
	Tue, 23 Jan 2024 09:54:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9975A0E1;
	Tue, 23 Jan 2024 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003639; cv=none; b=OvVOB1odNxO/5IUqezOw9M7kPmhZrtKnekQ95T6WWvhhxAjEncIqPZ734JJeXfQXILKtHtN4rrb2Ike+8euv2Nz6OT1MABXRHQXUHf7r4WY9ciiOsWAJdbYVMWYJrp2asXyF93kr14PTvulN9CqlOBuFRUbktSqIWJlFUneRMVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003639; c=relaxed/simple;
	bh=6I1RyUH8EJbIPoPIXyA3hEnC5RVsu6NE5fOFPtUVz70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ6qmX1QDvlebCm/o9ZjJt70giMBhDXfWHK+SdQf9VC6WCk5iyoh419hGUabLZhbxzTsL/GogNdHl/HlUjBkJk7mRylF/Uxz8qj0t0HVTtLfBcweotXRMl3q8G0uqtmQFkVTTu2gbTpHxj5vv7hz+72w+F0MBaUyonpCLj2LRnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15AEB1FB;
	Tue, 23 Jan 2024 01:54:41 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.48.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E68F13F5A1;
	Tue, 23 Jan 2024 01:53:53 -0800 (PST)
Date: Tue, 23 Jan 2024 09:53:51 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/82] arm64: atomics: lse: Silence intentional wrapping
 addition
Message-ID: <Za-Mr7YFhS9iXiPW@FVFF77S0Q05N>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-11-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-11-keescook@chromium.org>

On Mon, Jan 22, 2024 at 04:26:46PM -0800, Kees Cook wrote:
> Annotate atomic_add_return() and atomic_sub_return() to avoid signed
> overflow instrumentation. They are expected to wrap around.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/include/asm/atomic_lse.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> index 87f568a94e55..30572458d702 100644
> --- a/arch/arm64/include/asm/atomic_lse.h
> +++ b/arch/arm64/include/asm/atomic_lse.h
> @@ -79,13 +79,13 @@ ATOMIC_FETCH_OP_SUB(        )
>  #undef ATOMIC_FETCH_OP_SUB
>  
>  #define ATOMIC_OP_ADD_SUB_RETURN(name)					\
> -static __always_inline int						\
> +static __always_inline __signed_wrap int				\
>  __lse_atomic_add_return##name(int i, atomic_t *v)			\
>  {									\
>  	return __lse_atomic_fetch_add##name(i, v) + i;			\
>  }									\

I'd strongly prefer using add_wrap() rather than annotating the function, i.e.
make this:

  static __always_inline int						\
  __lse_atomic_add_return##name(int i, atomic_t *v)			\
  {									\
  	return add_wrap(__lse_atomic_fetch_add##name(i, v), i);		\
  }									\

Likewise for the other instances below.

With that, this looks fine to me.

Mark.

>  									\
> -static __always_inline int						\
> +static __always_inline __signed_wrap int				\
>  __lse_atomic_sub_return##name(int i, atomic_t *v)			\
>  {									\
>  	return __lse_atomic_fetch_sub(i, v) - i;			\
> @@ -186,13 +186,13 @@ ATOMIC64_FETCH_OP_SUB(        )
>  #undef ATOMIC64_FETCH_OP_SUB
>  
>  #define ATOMIC64_OP_ADD_SUB_RETURN(name)				\
> -static __always_inline long						\
> +static __always_inline __signed_wrap long				\
>  __lse_atomic64_add_return##name(s64 i, atomic64_t *v)			\
>  {									\
>  	return __lse_atomic64_fetch_add##name(i, v) + i;		\
>  }									\
>  									\
> -static __always_inline long						\
> +static __always_inline __signed_wrap long				\
>  __lse_atomic64_sub_return##name(s64 i, atomic64_t *v)			\
>  {									\
>  	return __lse_atomic64_fetch_sub##name(i, v) - i;		\
> -- 
> 2.34.1
> 

