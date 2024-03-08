Return-Path: <linux-kernel+bounces-96612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872AD875EEB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90C41C220BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D464F61D;
	Fri,  8 Mar 2024 07:56:39 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4B74EB43;
	Fri,  8 Mar 2024 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884599; cv=none; b=ePA0xhn/vcmK74k8HXf6wL6TaD78Ieki/OfgG/xdOj8EUzETjCzxK9NwsSssqICTEzPrJIfc20ZEHXFFL/IBogB4sewCyM0uStPBOWtIhBMD9vnQ4JUdAL6neVtjj4XxJWi7vU1h+ZqyKnyQCblEqLR+IXFhFYJzvQZfL7tdC3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884599; c=relaxed/simple;
	bh=77y5yz7tvTPJlsDrybYtETDg+H02RhwsEJCmIwEOSqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpNkUhcJ8LB08+3IvPLjX1H8I3mqtyrtIWuuYqALUyj6i9RciqIJOWmQYYgcllMfATxhnVkS3/dcSjAOICYdXL9FHvVWiy1NImBIQi/enTHqjQswNaIl0sD94Ov08N+uGwkBUOxXFeQEEL3zKAC6b3PAp7GFF1etHacWIqgNCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id EEBCD72C980;
	Fri,  8 Mar 2024 10:48:42 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id DFA9436D0168;
	Fri,  8 Mar 2024 10:48:42 +0300 (MSK)
Date: Fri, 8 Mar 2024 10:48:42 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
	lukas@wunner.de
Subject: Re: [PATCH v5 09/12] crypto: ecdsa - Rename keylen to bufsize where
 necessary
Message-ID: <20240308074842.g25bsphtbwdzzo4l@altlinux.org>
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
 <20240306222257.979304-10-stefanb@linux.ibm.com>
 <CZNR9UY8J7Q0.2R1YYTOO4Z92G@kernel.org>
 <571aa199-00cc-4153-9424-0012d20dc6f6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <571aa199-00cc-4153-9424-0012d20dc6f6@linux.ibm.com>

Jarkko,

On Thu, Mar 07, 2024 at 02:20:12PM -0500, Stefan Berger wrote:
> On 3/7/24 14:13, Jarkko Sakkinen wrote:
> > On Thu Mar 7, 2024 at 12:22 AM EET, Stefan Berger wrote:
> > > In some cases the name keylen does not reflect the purpose of the variable
> > > anymore once NIST P521 is used but it is the size of the buffer. There-
> > > for, rename keylen to bufsize where appropriate.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Tested-by: Lukas Wunner <lukas@wunner.de>
> > > ---
> > >   crypto/ecdsa.c | 12 ++++++------
> > >   1 file changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> > > index 4daefb40c37a..4e847b59622a 100644
> > > --- a/crypto/ecdsa.c
> > > +++ b/crypto/ecdsa.c
> > > @@ -35,8 +35,8 @@ struct ecdsa_signature_ctx {
> > >   static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
> > >   				  const void *value, size_t vlen, unsigned int ndigits)
> > >   {
> > > -	size_t keylen = ndigits * sizeof(u64);
> > 
> > nit: still don't get why "* sizeof(u64)" would ever be more readable
> > thean "* 8".
> 
> Because existing code in crypto uses sizeof(u64) when converting ndigits to
> number of bytes and '8' is not used for converting to bytes. Do we need to
> change this now ? No, I think it's better to conform to existing code.

`sizeof(u64)` is easily read as `8` by reviewers, but just `8` will
require inline comments because it's magic number isn't it? So this will
not even decrease number of letters.

`sizeof(u64)` is self-documenting code and you don't even need to
interpret it as `8` for review as you don't need number from any
sizeof(struct ..).

Also, possible we need to calculate number of bits in the big number, so
this would become `* 8 * 8`, in that case how would you distinguish
omission of one `* 8` by a typo.

Overall it's quite common in the whole tree

  linux/torvalds$ git grep -e '\* sizeof(u64)' -e 'sizeof(u64) \*' | wc -l
  551

So this is perhaps acceptable and depends on point of view. crypto
subsystem coders seems to prefer not to save on letters and type
`sizeof(u64)`.

Thanks,

> 
> # grep -rI ndigits crypto/ | grep sizeof\(u64\)
> crypto/ecrdsa.c:        unsigned int ndigits = req->dst_len / sizeof(u64);
> crypto/ecrdsa.c:            req->dst_len != ctx->curve->g.ndigits *
> sizeof(u64) ||
> crypto/ecrdsa.c:        vli_from_be64(r, sig + ndigits * sizeof(u64),
> ndigits);
> crypto/ecrdsa.c:            ctx->curve->g.ndigits * sizeof(u64) !=
> ctx->digest_len)
> crypto/ecrdsa.c:            ctx->key_len != ctx->curve->g.ndigits *
> sizeof(u64) * 2)
> crypto/ecrdsa.c:        ndigits = ctx->key_len / sizeof(u64) / 2;
> crypto/ecrdsa.c:        vli_from_le64(ctx->pub_key.y, ctx->key + ndigits *
> sizeof(u64),
> crypto/ecrdsa.c:        return ctx->pub_key.ndigits * sizeof(u64);
> crypto/ecdh.c:      params.key_size > sizeof(u64) * ctx->ndigits)
> crypto/ecc.c:   size_t len = ndigits * sizeof(u64);
> crypto/ecc.c:           num_bits = sizeof(u64) * ndigits * 8 + 1;
> crypto/ecdsa.c: size_t bufsize = ndigits * sizeof(u64);
> crypto/ecdsa.c: size_t bufsize = ctx->curve->g.ndigits * sizeof(u64);
> crypto/ecdsa.c: ndigits = DIV_ROUND_UP(digitlen, sizeof(u64));
> 
>    Stefan
> 
> > 
> > BR, Jarkko

