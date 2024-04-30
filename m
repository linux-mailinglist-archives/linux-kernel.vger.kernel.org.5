Return-Path: <linux-kernel+bounces-163285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 881598B6846
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282261F21FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B885910A0C;
	Tue, 30 Apr 2024 03:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuZn1koE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C0B101C4;
	Tue, 30 Apr 2024 03:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447130; cv=none; b=lsJWxasPZmOt2/kUSKVfihAShJsy1lER5c3so+Q4/IDw0H9GvYmCt/hvBjQ8QBJwPdNITTJcjvAj7K1uwtA9dTyHv0eAeoj6hCoLJo9oBlLCYKo8SbVtS5jV9o4vD8ZAAc2rioUjcDcVAjbYp0SQttSm0spiFFofErv3EVdeweU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447130; c=relaxed/simple;
	bh=jFpDU0vcTXdr0AsLdbKUE/E45SonMzpHUKonO6iy2VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcOCacOUXWJDp/lylfLpuxEP61BBiSZAXdleUPgum8kaMQZg+aEzoO4RFPxdwe099Qbat/ayaC3RWlWXObwifRpQbQYGwgjuhKoE1SCyLvLGcFAeOgcNLVTMhPkjM9h8MSVB7RIMCx4o/IlJnedqS7Wn9XCutsuyTl7JC0lUQp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuZn1koE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D4DC116B1;
	Tue, 30 Apr 2024 03:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447129;
	bh=jFpDU0vcTXdr0AsLdbKUE/E45SonMzpHUKonO6iy2VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuZn1koErWxms/QDZXsWzaiYu3CyBpxnfB20cadUDPZLM9t+h+1Ngvt3b5rKhR3am
	 0WSEoHBI+Ig9nHB1XRPaKn561cAT+rtiu8qKd1q5G+7h6kSjeyD2BSwCjWpqMOfooc
	 xi2wvmcs4d81xgpdNGnYLg1tGoGAhA2thgiKSpT24DQp6qYM98KWj8jnDzGARIACg0
	 KIImSkzb+CSGg9vnS5tE5U3QWIRGngkFCPknmHlVwPGjMVFNfa1rS3aU8vYdkRfJLk
	 iE4M3cSQHjSgek3+F79vE3WtJbndjMJVmYYyN2UYO/z1PwmFaP7iTossxxI1obtT8x
	 yVjoiGGSlev/g==
Date: Mon, 29 Apr 2024 20:18:47 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] crypto: passing configuration parameters to comp algos
Message-ID: <20240430031847.GB10165@sol.localdomain>
References: <20240430030447.GE14947@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430030447.GE14947@google.com>

On Tue, Apr 30, 2024 at 12:04:47PM +0900, Sergey Senozhatsky wrote:
> Hi,
> 
> 	We'd like to be able to pass algorithm-specific parameters to
> comp backends. As of this moment, crypto usees hard-coded default
> values and does not permit any run-time algorithm configuration,
> which in some cases simply disables the most interesting functionality.
> E.g. zstd can be configured to use a pre-trained (in the user-space)
> compression dictionary, which significantly changes algorithms
> characteristics. Another, obvious and trivial example, is algorithms
> compression level.
> 
> The problem is that we need to pass params to cra_init() function,
> because for some algorithms that's the only place where configuration
> can take place (e.g. zstd). Changing cra_init() to accept additional
> `struct crypto_comp_params` looks to be a little intrusive so before
> I write any patches I'd like to hear your thoughts.
> 

Have you considered just using the zstd library (<linux/zstd.h>) directly?

Which kernel subsystem are you working on that uses compression?

- Eric

