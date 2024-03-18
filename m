Return-Path: <linux-kernel+bounces-105761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2478087E3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D392F2811A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54E123741;
	Mon, 18 Mar 2024 07:15:52 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3B722EF4;
	Mon, 18 Mar 2024 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710746152; cv=none; b=kQOajtstgfH8UxmW+2wPwlaGhdLROGXzVIbHyKBFc1fblj6HJB8XYiWMTWH5zNBNC1w71iI1Brk7RmbUhFBTC2SX8wzcqR0lFHu9zxM1pMTF0eyYbTzxNJ02Ongwdj4a3TrPZthQ4+6GB6wRIdGCsUGoXjsGwgZ903ziHXF4S2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710746152; c=relaxed/simple;
	bh=H0xcAujiHOPzW4Dxw69wqAMqrD7WsCFBdG5Om9v6QJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOypWlguqofd67900eYlc+LTjN+BguiPVwuQWKxo7tuA86fku1fifpNupND0BgebV9yuVP7w0e1R7WM+8pymXawimmljyngrJhyCjQcC9aYcl0QtJZUdh1MEOqbXBhUev6sMfctl8tPdEfvM02t3xbT0XKf0B7YVTSNNhbONpFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id AFF932800BBC5;
	Mon, 18 Mar 2024 08:06:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9C3F8577CCE; Mon, 18 Mar 2024 08:06:01 +0100 (CET)
Date: Mon, 18 Mar 2024 08:06:01 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"saulo.alessandre@tse.jus.br" <saulo.alessandre@tse.jus.br>,
	"jarkko@kernel.org" <jarkko@kernel.org>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [EXTERNAL] [PATCH v6 12/13] crypto: asymmetric_keys - Adjust
 signature size calculation for NIST P521
Message-ID: <Zffn2XpvwPk9GVhv@wunner.de>
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-13-stefanb@linux.vnet.ibm.com>
 <SN7PR18MB531481F0A287ADCED3711193E32D2@SN7PR18MB5314.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR18MB531481F0A287ADCED3711193E32D2@SN7PR18MB5314.namprd18.prod.outlook.com>

On Mon, Mar 18, 2024 at 05:58:23AM +0000, Bharat Bhushan wrote:
> > --- a/crypto/asymmetric_keys/public_key.c
> > +++ b/crypto/asymmetric_keys/public_key.c
> > @@ -233,6 +233,7 @@ static int software_key_query(const struct
> > kernel_pkey_params *params,
> >  	info->key_size = len * 8;
> > 
> >  	if (strncmp(pkey->pkey_algo, "ecdsa", 5) == 0) {
> > +		int slen = len;
> >  		/*
> >  		 * ECDSA key sizes are much smaller than RSA, and thus could
> >  		 * operate on (hashed) inputs that are larger than key size.
> > @@ -246,8 +247,19 @@ static int software_key_query(const struct
> > kernel_pkey_params *params,
> >  		 * Verify takes ECDSA-Sig (described in RFC 5480) as input,
> >  		 * which is actually 2 'key_size'-bit integers encoded in
> >  		 * ASN.1.  Account for the ASN.1 encoding overhead here.
> > +		 *
> > +		 * NIST P192/256/384 may prepend a '0' to a coordinate to
> > +		 * indicate a positive integer. NIST P521 never needs it.
> >  		 */
> > -		info->max_sig_size = 2 * (len + 3) + 2;
> > +		if (strcmp(pkey->pkey_algo, "ecdsa-nist-p521") != 0)
> > +			slen += 1;
> > +		/* Length of encoding the x & y coordinates */
> > +		slen = 2 * (slen + 2);
> > +		/*
> > +		 * If coordinate encoding takes at least 128 bytes then an
> > +		 * additional byte for length encoding is needed.
> > +		 */
> > +		info->max_sig_size = 1 + (slen >= 128) + 1 + slen;
> 
> Is "(slen >= 128)" valid for P192/256/384 also?

It is valid but never true for those.

The signature consists of two integers encoded in ASN.1.
So each integer is prepended by 1 byte for the tag and 1 byte for the length.

The two integers are bundled together in a "sequence", which in turn requires
1 byte for the tag and 1 byte for the length.  However, for P521 the length
of the sequence is at least 2*(1+1+66) = 136 bytes, which exceeds 128 bytes
and therefore the length of the sequence occupies 2 bytes instead of 1.

For the shorter key lengths, the sequence fits in less than 128 bytes and
does not require the extra byte for the sequence length.

So the code is fine AFAICS.

Thanks,

Lukas

