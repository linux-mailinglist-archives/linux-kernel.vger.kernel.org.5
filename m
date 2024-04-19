Return-Path: <linux-kernel+bounces-151348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11678AAD48
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9692282CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11E880BEC;
	Fri, 19 Apr 2024 11:04:37 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A0D8004E;
	Fri, 19 Apr 2024 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524677; cv=none; b=mDYQG98w5TAzar0FU23O9l7Xj5xIvgr5+OxGJcvt+pSA4B4kySx9u/sSrXK5SCiuf2WsI/9+v+4iXhRc0OXFRNIMEtNHmpOrN5cbERhmI48m+lZ+Na7N2F0Rr55wequ0/3IyT9ZywULE38T8QfBMOv4XaRLGKw5wzZZlf6f27KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524677; c=relaxed/simple;
	bh=3OP2m0b5G7lSryqCK+jVTsGv0zkCx5RQfG0IPAiZqxk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c0VHW73A3gkEmPfqIeIiaaT7J52w4J6FHRkrvZ0v4svd/cqpyG2djM4Ts+ltSujwDD/pBS7FNvaK6tlsidbWDuR+k7jjD53PzGbGwnFVXHCZiviGXPjtDOBAv/S/TN0HXUWURNporMJnadqjVDCDUj68cLKTWPUb6vn8Gcj6tBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rxm2g-003scv-Jg; Fri, 19 Apr 2024 19:04:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Apr 2024 19:04:48 +0800
Date: Fri, 19 Apr 2024 19:04:48 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: Re: [PATCH 0/3] crypto: x86/aes-xts - additional tuning
Message-ID: <ZiJP0DHVLWu/oQEE@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413031728.159495-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Eric Biggers <ebiggers@kernel.org> wrote:
> This series does some more fine-tuning of the new AES-XTS code.
> 
> It applies to cryptodev commit 751fb2528c12 plus the two pending patches
> https://lore.kernel.org/linux-crypto/20240409000154.29799-1-ebiggers@kernel.org/
> and
> https://lore.kernel.org/linux-crypto/20240412154559.91807-1-ebiggers@kernel.org/
> 
> Eric Biggers (3):
>  crypto: x86/aes-xts - handle AES-128 and AES-192 more efficiently
>  crypto: x86/aes-xts - eliminate a few more instructions
>  crypto: x86/aes-xts - optimize size of instructions operating on
>    lengths
> 
> arch/x86/crypto/aes-xts-avx-x86_64.S | 249 +++++++++++++--------------
> arch/x86/crypto/aesni-intel_glue.c   |  18 +-
> 2 files changed, 131 insertions(+), 136 deletions(-)
> 
> 
> base-commit: 751fb2528c12ef64d1e863efb196cdc968b384f6
> prerequisite-patch-id: 5c1ca8ffe87136eb7bfe74d996f5e6cac01e2768
> prerequisite-patch-id: a72a872736c8e0876c4b44a9e5792dcaa02d4e0e

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

