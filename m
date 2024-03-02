Return-Path: <linux-kernel+bounces-89454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B38F86F097
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DECB225AF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C7F17C69;
	Sat,  2 Mar 2024 14:00:07 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7D134C9;
	Sat,  2 Mar 2024 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709388007; cv=none; b=u9+wgqKkfEkZExqTXCpldrZ/Hc9Duif1h1f4tEp3zt5OPcBHms5x9HuUvqY9sVAc8woRRaxv0fK9bPzVFpNqiw9ePs43mrCswylRDtCLW3c4+OjaqoqgNy5eYFkg19Og7wuWPSp4GgnSfTvuS19kJFMj3hVUbuKnIDDzXhpfrPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709388007; c=relaxed/simple;
	bh=5KUV8TszCFXRHWuLCnbMeuU3FypeFbMaSg6NAJFWi4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFIRGAibNUzHGtA7D5xKv6IwEZ1C6gcKEgw8y6MiXPmshf6oSfQuVvbqNd7Zyo/4Nd2m+Yct0fi8+azWT+iYw2BGvMzZ4OhJuQM9Mo1N6oxZ2zH+/G3q6Qvk193RwEh30yc+ci+pcQE37zaMIGS/uD/jDK9ts0MTb4TCk1DkvLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id E7B0030008A00;
	Sat,  2 Mar 2024 15:00:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C66D82DB1C; Sat,  2 Mar 2024 15:00:01 +0100 (CET)
Date: Sat, 2 Mar 2024 15:00:01 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	saulo.alessandre@tse.jus.br
Subject: Re: [PATCH v3 01/10] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
Message-ID: <20240302140001.GA3095@wunner.de>
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240223204149.4055630-2-stefanb@linux.ibm.com>
 <20240229091105.GA29363@wunner.de>
 <aabeec7b-618c-4d15-b033-4162b6e54f6a@linux.ibm.com>
 <CZIOY02QS2QC.LV0A0HNT7VKM@suppilovahvero>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZIOY02QS2QC.LV0A0HNT7VKM@suppilovahvero>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Mar 01, 2024 at 10:26:29PM +0200, Jarkko Sakkinen wrote:
> On Thu Feb 29, 2024 at 4:57 PM EET, Stefan Berger wrote:
> >
> >
> > On 2/29/24 04:11, Lukas Wunner wrote:
> > > On Fri, Feb 23, 2024 at 03:41:40PM -0500, Stefan Berger wrote:
> > >> +static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
> > >> +					 u64 *out, unsigned int ndigits)
> > >> +{
> > >> +	unsigned int sz = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
> > >> +	u8 tmp[ECC_MAX_DIGITS << ECC_DIGITS_TO_BYTES_SHIFT];
> > >> +	unsigned int o = sz - nbytes;
> > >> +
> > >> +	memset(tmp, 0, o);
> > >> +	memcpy(&tmp[o], in, nbytes);
> > >> +	ecc_swap_digits(tmp, out, ndigits);
> > >> +}
> > > 
> > > Copying the whole key into tmp seems inefficient.  You only need
> > > special handling for the first few bytes of "in" (6 bytes in the
> > > P521 case) and could use ecc_swap_digits() to convert the rest
> > > of "in" directly to "out" without using tmp.
> > > 
> > > So it would be sufficient to allocate the first digit on the stack,
> > > memset + memcpy, then convert that to native byte order into "in[0]"
> > > and use ecc_swap_digits() for the rest.
> > > 
> > > And the special handling would be conditional on "!o", so is skipped
> > > for existing curves.
> >
> > Thanks. It looks like this now:
> >
> > static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
> >                                           u64 *out, unsigned int ndigits)
> > {
> >          unsigned int o = nbytes & 7;
> >          u64 msd = 0;
> >          size_t i;
> >
> >          if (o == 0) {
> >                  ecc_swap_digits(in, out, ndigits);
> >          } else {
> >                  for (i = 0; i < o; i++)
> >                          msd = (msd << 8) | in[i];
> >                  out[ndigits - 1] = msd;
> >                  ecc_swap_digits(&in[o], out, ndigits - 1);
> 
> This would be more stream-lined IMHO:
> 
>         unsigned int o = nbytes & 7;
>         unsigned int n = ndigits;
>         u64 msd = 0;
>         size_t i;
> 
>         if (o != 0) {
>                 for (i = 0; i < o; i++)
>                         msd = (msd << 8) | in[i];
> 
>                 out[--n] = msd;
>         }
> 
>         ecc_swap_digits(in, out, n);

Maybe eliminate the for-loop as well?

	unsigned int o = nbytes & 7;
	u64 msd = 0;

	if (o != 0) {
		/* if key length is not a multiple of 64 bits (NIST P521) */
		memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
		out[--ndigits] = be64_to_cpu(msd);
		in += o;
	}

	ecc_swap_digits(in, out, ndigits);

