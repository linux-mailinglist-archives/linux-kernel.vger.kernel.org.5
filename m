Return-Path: <linux-kernel+bounces-34990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2716E838A36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6B3B22499
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8021B59B4A;
	Tue, 23 Jan 2024 09:23:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFE858ABB;
	Tue, 23 Jan 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001782; cv=none; b=meZKR57//HU1dEJ+j8XeLPBzGAak7wArPQGq+WcoLzvE9JNWckU511DRaaImolMyYLw13isMMJJUSY2ZQl8yEaUAYRBXzVMgMXsfoDNbmLjDzMRAOrRvYBH5feEVq/zRzpJALFa+gM62EOtb/K7ysiUtBbUyb4jAchwVgEUPv9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001782; c=relaxed/simple;
	bh=Ycn2L8knKsuG25PqceFwwkyWPC3fzjbd37VkNDIYcn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUNRA0xvFZAJx5CyWzTUZchggYZORnwBL6Ar7p4NgnNvQD8HPfCXp+kCYTrj1AKI5q4neK9VNVxgvGT9PPAeq49BAmUSRyUJdXhdDjDaOS0ev4Hs3aotm4GiICtugDRFQ2Tl9gReMVlZFZuqzXZYJS4uyYHZXBGA4sX9Ga3NNJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F213F1FB;
	Tue, 23 Jan 2024 01:23:44 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.48.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76FAE3F5A1;
	Tue, 23 Jan 2024 01:22:58 -0800 (PST)
Date: Tue, 23 Jan 2024 09:22:52 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/82] overflow: Introduce add_wrap()
Message-ID: <Za-FbFE7slBpwrbq@FVFF77S0Q05N>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-3-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-3-keescook@chromium.org>

On Mon, Jan 22, 2024 at 04:26:38PM -0800, Kees Cook wrote:
> Provide a helper that will perform wrapping addition without tripping
> the arithmetic wrap-around sanitizers.
> 
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/overflow.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index ac088f73e0fd..30779905a77a 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -124,6 +124,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  		check_add_overflow(a, b, &__result);\
>  	}))
>  
> +/**
> + * add_wrap() - Intentionally perform a wrapping addition
> + * @a: first addend
> + * @b: second addend
> + *
> + * Return the potentially wrapped-around addition without
> + * tripping any overflow sanitizers that may be enabled.
> + */
> +#define add_wrap(a, b)					\
> +	({						\
> +		typeof(a) __sum;			\
> +		if (check_add_overflow(a, b, &__sum))	\
> +			/* do nothing */;		\
> +		__sum;					\
> +	})

It's really difficult to see the semicolon for the empty statement here; could
we make that part:

		if ((check_add_overflow(a, b, &__sum)) {	\
			/* do nothing */			\
		}						\

.. to be a little clearer (and less at risk of breakage in a refactoring)?

I realise coding style says not to use braces for a single statement, but IMO
it's far clearer in this instance with the braces.

Mark.

> +
>  /**
>   * check_sub_overflow() - Calculate subtraction with overflow checking
>   * @a: minuend; value to subtract from
> -- 
> 2.34.1
> 
> 

