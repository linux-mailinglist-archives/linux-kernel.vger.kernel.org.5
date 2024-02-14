Return-Path: <linux-kernel+bounces-65166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AACBA8548CD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D702884CD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2DA1AAD8;
	Wed, 14 Feb 2024 11:57:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A3B1B966;
	Wed, 14 Feb 2024 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911856; cv=none; b=GXAdizk3rAJ9cpfDDlqGNG28BSXCUBYGQo0NuWUCUur5if6umP8RftWAdI1L2KhUWWv1Ot79KUp/2Qn3NB5t4Gsnezley40q8DYnZk3wRJ/IFmmtJrg4J5a4vTh0s/zKusp1ug5JO/gOTnQqb2xesUQudd7Mj7R2EgqeYZrPO5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911856; c=relaxed/simple;
	bh=eEzpK+PUlH5Zycl8Tv+fg8n4KmLU8OWgOW9U1EB0eB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/DznbwM1Z1C+ket6g69FQ9lWgRs3SnUE/Ps7eIhJtTijD0TsWJT0BG6U5I7lTaxJp0NlB+K8JedEBISLqoy3FScRTEhT3Bnch0m5ohMN5Xb8rVWnW3xadD3KGYvyUm+8b+3YrQvm3aJ0tZz5au8yF8FosmozWq1gtCZnXGdyH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFFC41FB;
	Wed, 14 Feb 2024 03:58:13 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.64.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 524983F5A1;
	Wed, 14 Feb 2024 03:57:31 -0800 (PST)
Date: Wed, 14 Feb 2024 11:57:28 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] overflow: Adjust check_*_overflow() kern-doc to
 reflect results
Message-ID: <ZcyqqN3wVrKwkzrs@FVFF77S0Q05N>
References: <20240213220844.it.345-kees@kernel.org>
 <20240213221100.3556356-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213221100.3556356-1-keescook@chromium.org>

On Tue, Feb 13, 2024 at 02:10:57PM -0800, Kees Cook wrote:
> The check_*_overflow() helpers will return results with potentially
> wrapped-around values. These values have always been checked by the
> selftests, so avoid the confusing language in the kern-doc. The idea of
> "safe for use" was relative to the expectation of whether or not the
> caller wants a wrapped value -- the calculation itself will always follow
> arithmetic wrapping rules.
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/overflow.h | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 7b5cf4a5cd19..4e741ebb8005 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -57,11 +57,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   * @b: second addend
>   * @d: pointer to store sum
>   *
> - * Returns 0 on success.
> + * Returns 0 on success, 1 on wrap-around.

Sorry for the last minute bikeshedding, but could we clarify 'success' here?
e.g. I think it'd be clearer to say:

  Returns true on wrap-around, false otherwise.

Note that also uses true/false since these all return bool (as do the
underlying __builtin_*_overflow() functions).

>   *
> - * *@d holds the results of the attempted addition, but is not considered
> - * "safe for use" on a non-zero return value, which indicates that the
> - * sum has overflowed or been truncated.
> + * *@d holds the results of the attempted addition, which may wrap-around.

How about:

  @d holds the results of the attempted addition, regardless of whether
  wrap-around occurred.

.. and likewise for the others below?

Mark.

>   */
>  #define check_add_overflow(a, b, d)	\
>  	__must_check_overflow(__builtin_add_overflow(a, b, d))
> @@ -72,11 +70,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   * @b: subtrahend; value to subtract from @a
>   * @d: pointer to store difference
>   *
> - * Returns 0 on success.
> + * Returns 0 on success, 1 on wrap-around.
>   *
> - * *@d holds the results of the attempted subtraction, but is not considered
> - * "safe for use" on a non-zero return value, which indicates that the
> - * difference has underflowed or been truncated.
> + * *@d holds the results of the attempted subtraction, which may wrap-around.
>   */
>  #define check_sub_overflow(a, b, d)	\
>  	__must_check_overflow(__builtin_sub_overflow(a, b, d))
> @@ -87,11 +83,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   * @b: second factor
>   * @d: pointer to store product
>   *
> - * Returns 0 on success.
> + * Returns 0 on success, 1 on wrap-around.
>   *
> - * *@d holds the results of the attempted multiplication, but is not
> - * considered "safe for use" on a non-zero return value, which indicates
> - * that the product has overflowed or been truncated.
> + * *@d holds the results of the attempted multiplication, which may wrap-around.
>   */
>  #define check_mul_overflow(a, b, d)	\
>  	__must_check_overflow(__builtin_mul_overflow(a, b, d))
> -- 
> 2.34.1
> 

