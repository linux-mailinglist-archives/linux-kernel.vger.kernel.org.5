Return-Path: <linux-kernel+bounces-96826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBF48761F0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B34D283428
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02855467C;
	Fri,  8 Mar 2024 10:24:57 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A1535D7;
	Fri,  8 Mar 2024 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893497; cv=none; b=RNEnJZ02tziD+cgKNO456bOq7oZ5VORXtEpDhZ04FYE9eoqnV44NxaRgRiqYKX9XNKlM7E5bIvkXkubg0ZFoLjxeOv6XcPZiVRs/ACne9DSVYLnuoZD1hJ8XDNNv8AUOR8K+G4dxyxo93a3QXWzmvoQFBq/i3qWixYqPdcLZDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893497; c=relaxed/simple;
	bh=FHgKrmtpL5qJMcf6wT+EWhuFyHiWEd/Ju4BGzDwllvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxtWMay3oWs5n8W+GFrXueKng1MW9PJlWrCrZ6qbqMSVXF5Ete+9ZZbM3SoOs9QEgKt1Ht66PvzCk+bGkEH6TlTKBunf2XKyKFJfYKhWRdHJVONy314zSkVo+6Jmj3DkuvzQKOcD/ryS/M2Jtg5vjBgxzuhHzWhOXk4mlr3s1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1riXPB-004rot-G7; Fri, 08 Mar 2024 18:24:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Mar 2024 18:25:01 +0800
Date: Fri, 8 Mar 2024 18:25:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: WangYuli <wangyuli@uniontech.com>
Cc: davem@davemloft.net, chenhuacai@kernel.org, kernel@xen0n.name,
	linux-crypto@vger.kernel.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, guanwentao@uniontech.com
Subject: Re: [PATCH v2] LoongArch/crypto: Clean up useless assignment
 operations
Message-ID: <ZernfR9PlbJzxhI+@gondor.apana.org.au>
References: <79D75E042AE5B03F+20240229100449.1001261-1-wangyuli@uniontech.com>
 <ZermFgvsJymZkz4u@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZermFgvsJymZkz4u@gondor.apana.org.au>

On Fri, Mar 08, 2024 at 06:19:02PM +0800, Herbert Xu wrote:
>
> > diff --git a/arch/loongarch/crypto/crc32-loongarch.c b/arch/loongarch/crypto/crc32-loongarch.c
> > index a49e507af38c..3eebea3a7b47 100644
> > --- a/arch/loongarch/crypto/crc32-loongarch.c
> > +++ b/arch/loongarch/crypto/crc32-loongarch.c
> > @@ -44,7 +44,6 @@ static u32 crc32_loongarch_hw(u32 crc_, const u8 *p, unsigned int len)
> > 
> >                CRC32(crc, value, w);
> >                p += sizeof(u32);
> > -               len -= sizeof(u32);
> >        }
> 
> This makes no sense whatsoever.  Please review this patch carefully
> before you resubmit.

Nevermind, I see what's going on now.  Your reference to the lack
of a CRC instruction utterly confused me.

The fact that len -= is unnecessary has nothing to do with whether
there is a CRC instruction.

Please modify your patch description so that it is not needlessly
confusing.  You should simply state that len -= is unnecessary
because you only test whether the relevant bit is set in len for
the tail case.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

