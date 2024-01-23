Return-Path: <linux-kernel+bounces-34668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B8A8385EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A651F272B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3145615C6;
	Tue, 23 Jan 2024 03:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/LJqaXd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D307F4;
	Tue, 23 Jan 2024 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705979268; cv=none; b=E3hlSDjAN3r07Tc93UxchS1f0f82qKGfmbpaE0+eSFnWCUAd4P3ANiEuvmXqwevBUSLI1cO7XhbsNgCEcNMs0MaImlojfZVLHOKPG5AesVATq8npHF777Y1CBfzlaBh0ZAt0U9a38kTh1NTAlbh7/U0AwGAaI29VVfG1h4jxYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705979268; c=relaxed/simple;
	bh=o4wTotc931zqVVQlDr2E4b8Ny4E6Hx8p/g/DAAJBb9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBPAKeFZnMEbzs4iJT4F8/54PXOxRKYJIi+9ynUDFOW3YK2moNdHS9zP7H8u6owo6WAg/QPFSH/RjW2V9Gpg1iMnfZHoN4QhYvV5lrhfSP9r4AK5/Bh/59UbXe2kkU2idub1qviDu1zd9wbQuhWDR4Nbr+tnI0NNdRg/qUuEa7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/LJqaXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760F9C433C7;
	Tue, 23 Jan 2024 03:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705979267;
	bh=o4wTotc931zqVVQlDr2E4b8Ny4E6Hx8p/g/DAAJBb9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/LJqaXdzPXABiAWTSqIS779zZTu8NmVFjM1fkdYsmWH5Mrxz1yddNFbG7k6on1Jb
	 Ua/9gtKCbGRNsRDzUJl9Tat56LWaHbw4oB0YXKKmEAWpDqsriwxBO29KMh2bPn3R4Y
	 7SQ46EnkfgjAF00rMBJMLkRGDVFhDwA43LPBlKshGbH/Lb4FSYI1/XcRNze1RYII3c
	 uYvxOQSQJNTQCt4euBud8FdXe+NZpk3ta92vlzAR+IZpVPmebK9t5BIWGqqwQYZlH+
	 aWZ50n1R4CzLWBB5KF/dsATrTjQcLG5iBtYsqLzyy+AZIaWtpyfzqqtcbT2ojE+Tx+
	 Xp6KjzQg1YKDg==
Date: Mon, 22 Jan 2024 19:07:45 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Aditya Srivastava <yashsri421@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-crypto@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 46/82] crypto: Refactor intentional wrap-around test
Message-ID: <20240123030745.GA1097@sol.localdomain>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-46-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-46-keescook@chromium.org>

On Mon, Jan 22, 2024 at 04:27:21PM -0800, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
> 
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Aditya Srivastava <yashsri421@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-crypto@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  crypto/adiantum.c                   | 2 +-
>  drivers/crypto/amcc/crypto4xx_alg.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/adiantum.c b/crypto/adiantum.c
> index 60f3883b736a..c2f62ca455af 100644
> --- a/crypto/adiantum.c
> +++ b/crypto/adiantum.c
> @@ -190,7 +190,7 @@ static inline void le128_add(le128 *r, const le128 *v1, const le128 *v2)
>  
>  	r->b = cpu_to_le64(x + y);
>  	r->a = cpu_to_le64(le64_to_cpu(v1->a) + le64_to_cpu(v2->a) +
> -			   (x + y < x));
> +			   (add_would_overflow(x, y)));
>  }
>  
>  /* Subtraction in Z/(2^{128}Z) */
> diff --git a/drivers/crypto/amcc/crypto4xx_alg.c b/drivers/crypto/amcc/crypto4xx_alg.c
> index e0af611a95d8..33f73234ddd9 100644
> --- a/drivers/crypto/amcc/crypto4xx_alg.c
> +++ b/drivers/crypto/amcc/crypto4xx_alg.c
> @@ -251,7 +251,7 @@ crypto4xx_ctr_crypt(struct skcipher_request *req, bool encrypt)
>  	 * the whole IV is a counter.  So fallback if the counter is going to
>  	 * overlow.
>  	 */
> -	if (counter + nblks < counter) {
> +	if (add_would_overflow(counter, nblks)) {
>  		SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, ctx->sw_cipher.cipher);
>  		int ret;

Just to double check, you really intend to forbid *unsigned* integer wraparound?
This patch's commit message focuses on signed, and barely mentions unsigned.
The actual code changes in this patch only deals with unsigned.

Also, what's the motivation for addressing the 'x + y < x' case but not other
cases in the same file?  For example, the le128_add() function which this patch
modifies has two other intentional wraparounds, which this patch doesn't touch.
Also, the le128_sub() function just below le128_add() is very similar but does
wraparound in the other direction.  That's 6 cases in 20 lines of code, but this
patch only addresses 1.  And of course, lots of other crypto code relies on
unsigned wraparounds too, which this patch overlooks.  So I'm a bit confused
about the point of this patch.  If we really wanted to explicitly annotate all
the intentional wraparounds in a particular piece of code, so that the code can
be run with the corresponding sanitizer enabled, wouldn't it be necessary to
actually test the code with that sanitizer enabled to find all the cases?

- Eric

