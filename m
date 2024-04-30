Return-Path: <linux-kernel+bounces-163281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB618B682B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED61282A97
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E878BF4EB;
	Tue, 30 Apr 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re6D8+PL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E06ADDA6;
	Tue, 30 Apr 2024 03:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714446668; cv=none; b=PKsxUIerL//b2LCDWb32S3Z2EF2gdBxcpoyO/UMqn2RBhPbxP42HDQxlZ10V3PEDGwtgg51LPgQKtFnNZMp7OXSDQ0G8dotQPNfNgNVqmMCVl9FabcuGC9exDzSP2ggjqWzpAX9wsOSJ3vMYRzndpdlQPZq2DqHnMGOd9C0G7zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714446668; c=relaxed/simple;
	bh=yT3MMoBO2F4LiKz7W0TmFqgNagQSndlMM+rjLP8IxtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM4TfvnRfPsjzxQ9Ylvyl1fITdiPK078jw+gykSXGAzWl/vYQiRMXlv1eUKI/AV+rpY6DZuQYaoNF4qfrJqyVPUyCFlAOAmXEGMau0/aFZOnhc4rH3A/XiziwbzUq44Tfr6IO/9IpxYahXe+ISJc83XCvwjwhZSz3RmebyWEpq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re6D8+PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E8DC116B1;
	Tue, 30 Apr 2024 03:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714446667;
	bh=yT3MMoBO2F4LiKz7W0TmFqgNagQSndlMM+rjLP8IxtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Re6D8+PL3acp6LaiFk05Wz2mtAprPWxzLIsCu5lX90BsYBFgsg1TRYT/mXb3VsFzo
	 NTpdjcYS6qjf6nITOR9b5XIq5D35rDuGd1GrAvug9YzPDhsLSW0elLpDVVAjaUE293
	 uSCcDgqwGOYB0Nb9uEPoowC9XbfPZSWzc6/FnWgftSGPqYTutguJCblXqT3y7Z6vh7
	 XfX5hR4/fgMIIIxvIYZdtrNSUwo3Plv2BhG0lW/mo5gm5AuQzoWWlJ4iVAEh9qBb60
	 rg/SGR14PbEeRsfJGy7/h2xCeo1pS2CxXZ1pI+b9qjIIMNliLKC47/PU+8SEtLaGbl
	 g79v8l51MyZ+w==
Date: Mon, 29 Apr 2024 20:11:05 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Aaron Toponce <aaron.toponce@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: add chacha8_block and swtich the rng to it
Message-ID: <20240430031105.GA10165@sol.localdomain>
References: <20240429134942.2873253-1-aaron.toponce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429134942.2873253-1-aaron.toponce@gmail.com>

On Mon, Apr 29, 2024 at 07:48:49AM -0600, Aaron Toponce wrote:
> According to Jean-Philippe Aumasson in his paper "Too Much Crypto" [1]:
> 
> > "The best result on ChaCha is a key recovery attack on the 7-round version
> > with 2^237.7 time complexity using output data from 2^96 instances of ChaCha,
> > that is, 2^105 bytes of data."
> 
> He then proposes that ChaCha use 8 rounds instead of 20, providing a 2.5x
> speed-up. As such, this patch adds chacha8_block and chacha12_block and switches
> the RNG from ChaCha20 to ChaCha8 to take advantage of that efficiency without
> sacrificing security.
> 

I don't think there is consensus on ChaCha8 being recommended.  Adiantum uses
ChaCha12, but even that received some pushback.

The Linux RNG is also usually used only for small amounts of data, and its
security (and the perception of its security) is extremely important.

So just staying with ChaCha20 seems appropriate.

Note also that currently the Linux RNG is using a portable C implementation of
ChaCha20.  If there is actually a desire to accelerate large reads (which again,
aren't the main use case of the Linux RNG), it would be possible to use a SIMD
implementation of ChaCha20, which already exists in the kernel.  That would
speed up ChaCha20 by roughly 2-5x depending on the CPU.

- Eric

