Return-Path: <linux-kernel+bounces-143376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D64168A37CD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743061F22036
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC02E15216A;
	Fri, 12 Apr 2024 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvClbgIK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F81494A1;
	Fri, 12 Apr 2024 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956900; cv=none; b=oiTKoB6+uSF0WE17n5dPGZO9sP/ESqmg2H/kvVR21NolZT5rZAnFXCybA64kby80ZESl9rbNPSFR3v5jwdOlGuIiev1rzxuu6bZPJdrVv5/gwjnIFDKMpAMm3atxLk3e91dtspWUi/8lcFnZkTyYlb7ua6+HqU85KrgEWwjsK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956900; c=relaxed/simple;
	bh=BZz4CCyUCnZ0/06uL3h2AQjRd0Le7U9Oer2B28nM9wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubG8gGuCdJbsou6Ii0IlUoIcDLn+qcwR5+FrqKjS7UgWYlx36M5hr/LhCf84jcK07+JvfiYyLeEEjpwYoZCGGQG5SgmvOo1DZOV2ZgBUjCUNEuZYzO92by5k1OS1RTQva84f4GWo9aLbocx947jNjzkTgoM0wZKRjR2IWWVrNPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvClbgIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579C2C113CC;
	Fri, 12 Apr 2024 21:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956899;
	bh=BZz4CCyUCnZ0/06uL3h2AQjRd0Le7U9Oer2B28nM9wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvClbgIKLYDiTT2Osk8I4Mc/vrMi7c/Sa+nAEpwcf5MctT8X6PzsV+nS93exiHVdY
	 2vPpt7xoeYs6DU7X+C1XW/vaNhbBo9kAK2LnqWQemFZRdbTIJXoLbe7QUguXr+eY7L
	 B186099umoeSpWzBRdkBSoB3rcNZ/mUMwGQszkIcXTrjTwhbQmQpZ5lM3caVwQPZwi
	 +SD9YPgwv49fLeprSVHDewmfPCd0x9fQ2CteSfnE5Lj2UudDNTCvCzNn7bgmTvDGOh
	 6/SRKyppP6Ow6mIH5s9lNXE+su+8TiEJfSr+KGX6CPK6yqeILt0DbuHker4iznVdeg
	 D4RzAjUpSTGiw==
Date: Fri, 12 Apr 2024 14:21:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Lin Ma <linma@zju.edu.cn>,
	Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Tobias Brunner <tobias@strongswan.org>,
	Raed Salem <raeds@nvidia.com>, Netdev <netdev@vger.kernel.org>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [RFC] xfrm: work around a clang-19 fortifiy-string
 false-positive
Message-ID: <20240412212136.GD2252629@dev-arch.thelio-3990X>
References: <20240216202657.2493685-1-arnd@kernel.org>
 <202402161301.BBFA14EE@keescook>
 <763214eb-20eb-4627-8d4b-2e7f29db829a@app.fastmail.com>
 <20240409161517.GA3219862@dev-arch.thelio-3990X>
 <f94c6943-eb93-4533-8e4d-3645ef38b990@app.fastmail.com>
 <20240410174540.GB3649628@dev-arch.thelio-3990X>
 <773febee-ace3-4ad6-8ff6-04563dbbb759@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <773febee-ace3-4ad6-8ff6-04563dbbb759@app.fastmail.com>

On Thu, Apr 11, 2024 at 01:35:05PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 10, 2024, at 19:45, Nathan Chancellor wrote:
> 
> > Unfortunately, I have no idea why it is complaining nor why your patch
> > resolves it but the combination of FORTIFY_SOURCE and KASAN certainly
> > seems like a reasonable place to start looking. I will see if I can come
> > up with a smaller reproducer to see if it becomes more obvious why this
> > code triggers this warning.
> 
> I know at least why my patch avoids the warning -- it removes the
> call to memset() that contains the check.

Yeah duh... :/ I should have realized that before I sent that message
heh.

> Unfortunately that still doesn't explain what caused it.

Right, I'll see if I can cvise something out now that we have a more
isolated set of conditions. I guess the only question will be if I can
build a file preprocessed with CONFIG_KASAN=y will build with and
without '-fsanitize=kernel-address'...

Cheers,
Nathan

