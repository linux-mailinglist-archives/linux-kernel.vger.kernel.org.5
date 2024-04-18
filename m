Return-Path: <linux-kernel+bounces-149872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A9B8A972C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BFDB21362
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FFD15B572;
	Thu, 18 Apr 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWuezpAM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A91815B57F;
	Thu, 18 Apr 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435652; cv=none; b=lFiqHJzo/YQ0NsbPGY6T+wTcrdAOmCHBNpLCu+1kuTKX/wxo8v5l1ewwhJwR3XTI7fknRM9BPV21DXQCkj3KvcXbh2hdz5RoYb2sxlH6uTFTQbn3B1j4xXoHDVD9/dY3vLdY1x2mSqvDoPVwQII3GyAzCN2K2XZGQ8FCxLb2b8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435652; c=relaxed/simple;
	bh=3Y5JB/WtfH5WH9bHCRUJuJuoNEPscNNjUmD2/T+wdHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gR51nVNuf9wxhK1T8dCAFuWsM3ogAdMdn7bVMNpLDQoislzyCRc9IQ2HkV4wUCZLkhtgKiPv+BLTa6N7JB3jXvsg6Fn6tixesNXPwuqlLqFTdPLZM899ta5nR3u+Sdnw3ZRMtacuUoN2vlkaLOtVg2MoaTDs0uVgTqBZIpwLEEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWuezpAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53522C32781;
	Thu, 18 Apr 2024 10:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713435652;
	bh=3Y5JB/WtfH5WH9bHCRUJuJuoNEPscNNjUmD2/T+wdHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWuezpAM/tvSVnMHw6t+mTnV7HMoCkz2/7R497QatvoCRl6upJfXlF3JX5sTzMGKr
	 l+LRH8aD3fi1IJ3nHAHbT8VkXrUqj1AL0bAglqnMIvrWFf5stfdYy05e+8YhQsGED6
	 LRiT88aIl6g1mm4sQUnD64X2iB2cDgHByJxUt1mdaKRjEQpmOIzqMfOw/9Dpnwgcd4
	 1W6HAeWJx3Edaaj9EMH/+AhznhRelVOaE1QHUak77k625eSIQ5Qo4fiOusynMdfeZ7
	 T1U9ZTRLnwF03YWxG4DQLEHk35/+u5J0b0YobKfs20Epbobh88Hn9GEH8ervAGmdDb
	 j8zU4M3TMCNzQ==
Date: Thu, 18 Apr 2024 11:20:46 +0100
From: Lee Jones <lee@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org,
	Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] binder: check offset alignment in binder_get_object()
Message-ID: <20240418102046.GA2329396@google.com>
References: <20240330190115.1877819-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240330190115.1877819-1-cmllamas@google.com>

On Sat, 30 Mar 2024, Carlos Llamas wrote:

> Commit 6d98eb95b450 ("binder: avoid potential data leakage when copying
> txn") introduced changes to how binder objects are copied. In doing so,
> it unintentionally removed an offset alignment check done through calls
> to binder_alloc_copy_from_buffer() -> check_buffer().
> 
> These calls were replaced in binder_get_object() with copy_from_user(),
> so now an explicit offset alignment check is needed here. This avoids
> later complications when unwinding the objects gets harder.
> 
> It is worth noting this check existed prior to commit 7a67a39320df
> ("binder: add function to copy binder object from buffer"), likely
> removed due to redundancy at the time.
> 
> Fixes: 6d98eb95b450 ("binder: avoid potential data leakage when copying txn")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks for chasing this one down Carlos.

Reviewed-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

