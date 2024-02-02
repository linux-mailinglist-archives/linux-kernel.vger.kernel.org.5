Return-Path: <linux-kernel+bounces-49647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370B4846D6E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3DF1C22076
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792487A70A;
	Fri,  2 Feb 2024 10:11:42 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1A79DCE;
	Fri,  2 Feb 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868702; cv=none; b=q4Wo8HEEeaD3j5gCiikSMhP0XHtZ4gz25DEL6iGXHR4VYmVJHNnOh8m6BhRPHxHvN3WXJWTVQWqXYxFebxEreQD20FCLmhtOtP9MONeu01X/wHshRMsUUPG7l3XlECCqrDycZROnoLwikJVtPFKxBH25ZM8LsKXKS1jHX8h+9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868702; c=relaxed/simple;
	bh=C7uLKFP3Y5+66Alum0hktoFqE9J4pbgBVFFvwulqzFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFCIOEQ9qlWZl8xkB4YJqw3GGcfbK0LCwouF7dLMilulgfEZFOP76rCp8ZS0AFwwtlZeP9JXrpr1GVAYdkSmz5PZWB4rk6uYAQ+/bmDnfNEMfMD+AiDA13l1WTFbe+IpHaI8ffCp3+ja0PhgS9KdCyf9wkXA8T0/hgGRyLT9iwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rVqWB-0092tc-2S; Fri, 02 Feb 2024 18:11:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Feb 2024 18:11:44 +0800
Date: Fri, 2 Feb 2024 18:11:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Qi Tao <taoqi10@huawei.com>
Cc: davem@davemloft.net, liulongfang@huawei.com,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 0/4] some updates and cleanups for hisilicon/sec2.
Message-ID: <Zby/4CjHCbF2VyDo@gondor.apana.org.au>
References: <20240126093828.14131-1-taoqi10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126093828.14131-1-taoqi10@huawei.com>

On Fri, Jan 26, 2024 at 05:38:24PM +0800, Qi Tao wrote:
> This seires patch mainly add some RAS registers to enhance the 
> DFX positioning function and fix some cleanup issues.
> 
> [PATCH v1 3/4] -> [PATCH v2 3/4]
> 	sec_sqe3->c_len_ivin |= cpu_to_le32(c_req->c_len);
> -	sec_sqe3->tag = cpu_to_le64((unsigned long)(uintptr_t)req);
> +	sec_sqe3->tag = cpu_to_le64((unsigned long)req);
> 
> Other patches are not modified.
> 
> Qi Tao (3):
>   crypto: hisilicon/sec2 - updates the sec DFX function register
>   crypto: hisilicon/sec2 - modify nested macro call
>   crypto: hisilicon/sec2 - fix some cleanup issues
> 
> Wenkai Lin (1):
>   crypto: hisilicon/sec - remove unused parameter
> 
>   drivers/crypto/hisilicon/sec2/sec_crypto.c | 33 ++++++++--------------
>   drivers/crypto/hisilicon/sec2/sec_main.c   |  5 ++++
>   2 files changed, 17 insertions(+), 21 deletions(-)
> 
> -- 
> 2.33.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

