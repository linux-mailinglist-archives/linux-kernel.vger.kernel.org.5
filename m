Return-Path: <linux-kernel+bounces-151338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E708AAD30
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D33282BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1AB8005E;
	Fri, 19 Apr 2024 11:00:37 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD47F7CE;
	Fri, 19 Apr 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524436; cv=none; b=bEJgR4xBzv2teXEQzJDfWb1tbb8ao8vGCfIrexpQ758wJWzgw9rJTSwTVG5yQ+KKgF0FgZbucqPnDnFXI52HoA2tWECi3JuHkXq9HE7zrONswwKP9GaXaZUKSIsMWJGA86Iqo9RUsTp3fjI+OJRvDWiLIYAupJ5ZOBAdLdZRMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524436; c=relaxed/simple;
	bh=Ljysuy28IuFPteXKcTgItG3QPpPt7DZGBgR/dfJp0ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MdZetlc0HCwz1z8VFQhWpRVLYx3pK67mtnFYndYva7WggnBfoF0nWjN2hTFdUKIgg39lgwKed5OFPwOM/NYukPoB8m1SIRuyI6J7iZM3evPRBgwr81Gq4XrwC01n3T+ZlnAZ8hB1WQSbuDg6YFRwp6kxbbnzLUgpmKZ8HYL30pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rxlyn-003sTB-CK; Fri, 19 Apr 2024 19:00:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Apr 2024 19:00:47 +0800
Date: Fri, 19 Apr 2024 19:00:47 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stefan.kanthak@nexgo.de
Subject: Re: [PATCH v2 0/4] crypto: x86/sha256-ni - cleanup and optimization
Message-ID: <ZiJO32BWdBHOVrzG@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411162359.39073-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Eric Biggers <ebiggers@kernel.org> wrote:
> This patchset reduces the amount of source code duplication in
> sha256_ni_asm.S and also reduces the binary code size slightly.
> 
> Changed in v2:
>   - Take advantage of .irp in patch 1
>   - Added two additional cleanup patches
> 
> Eric Biggers (4):
>  crypto: x86/sha256-ni - convert to use rounds macros
>  crypto: x86/sha256-ni - rename some register aliases
>  crypto: x86/sha256-ni - optimize code size
>  crypto: x86/sha256-ni - simplify do_4rounds
> 
> arch/x86/crypto/sha256_ni_asm.S | 253 +++++++-------------------------
> 1 file changed, 49 insertions(+), 204 deletions(-)
> 
> 
> base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

