Return-Path: <linux-kernel+bounces-96815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006EC8761C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A017628279C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008A853E3C;
	Fri,  8 Mar 2024 10:19:14 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FBA5380F;
	Fri,  8 Mar 2024 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893153; cv=none; b=EJJlf1pB3e3+a8CXMiYbBcvmHlq0gWDGTOwmVCdcM733XWhZDrJfpedhbNNga7PFsstKg1+kwO9OMH2E54JF3zvsn4vwqn/Z06fTf3vfcWaXzao4zMaYihLhPnGKwV2Zur5/rEVPeGi2hx1FNB90o+YQUgNQr/+8PgNLFaCEY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893153; c=relaxed/simple;
	bh=o4kROZZaMlT9MHw4rxVnPT0wK6D0X294PyFRuzqQc9A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H9wMe97cmoWBDgebBfUKRaPIaNIyZs69iXRu/WZSB8Yl5HcfJfd4BhGDXzDGdNLdxiM2BBtI3GlfcziIcuMBggcAzC0d0NuhpD67djRNt6U3JaR1tJ2vmx7JYdA/y6TIMV1fVSltcm1XIblBvMRR1fdRnCiokryRk9v2YkmvnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1riXJP-004rex-4M; Fri, 08 Mar 2024 18:18:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Mar 2024 18:19:02 +0800
Date: Fri, 8 Mar 2024 18:19:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: WangYuli <wangyuli@uniontech.com>
Cc: davem@davemloft.net, chenhuacai@kernel.org, kernel@xen0n.name,
	linux-crypto@vger.kernel.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, wangyuli@uniontech.com,
	guanwentao@uniontech.com
Subject: Re: [PATCH v2] LoongArch/crypto: Clean up useless assignment
 operations
Message-ID: <ZermFgvsJymZkz4u@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79D75E042AE5B03F+20240229100449.1001261-1-wangyuli@uniontech.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

WangYuli <wangyuli@uniontech.com> wrote:
> The LoongArch CRC32 hw acceleration is based on
> arch/mips/crypto/crc32-mips.c. While the MIPS code supports both
> MIPS32 and MIPS64, LA32 lacks the CRC instruction. As a result,
> "line len -= sizeof(u32)" is unnecessary.
> 
> Removing it can make context code style more unified and improve
> code readability.
> 
> Suggested-by: Guan Wentao <guanwentao@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
> arch/loongarch/crypto/crc32-loongarch.c | 2 --
> 1 file changed, 2 deletions(-)
> 
> diff --git a/arch/loongarch/crypto/crc32-loongarch.c b/arch/loongarch/crypto/crc32-loongarch.c
> index a49e507af38c..3eebea3a7b47 100644
> --- a/arch/loongarch/crypto/crc32-loongarch.c
> +++ b/arch/loongarch/crypto/crc32-loongarch.c
> @@ -44,7 +44,6 @@ static u32 crc32_loongarch_hw(u32 crc_, const u8 *p, unsigned int len)
> 
>                CRC32(crc, value, w);
>                p += sizeof(u32);
> -               len -= sizeof(u32);
>        }

This makes no sense whatsoever.  Please review this patch carefully
before you resubmit.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

