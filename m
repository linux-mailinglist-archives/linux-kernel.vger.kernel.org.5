Return-Path: <linux-kernel+bounces-89607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D42286F2A1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 22:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8310F2828F6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485D243147;
	Sat,  2 Mar 2024 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CploIfIk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D641211;
	Sat,  2 Mar 2024 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709416504; cv=none; b=mC7NoTSDU+urZcwa8FMg1829+N4UYUy7xTfr1b0sTpE/mMsTvCCDEGDK9dM3XkE+RLDrcNhjpODXYpBJV1DiZ1QVHqan2ZkI30jnq0DG/eoL/l+TulWlx+D6LOvmPeklQLzNLBE7UARd9aVaNG2X8d31V6/q7uT6M8OHFuxYBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709416504; c=relaxed/simple;
	bh=+r4eXVhR3+ABrstefGAz7F5xG813E6/x5+a8CRWLllc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KpoUmoZPR6IH7uqWCsEx+KPsUx7Rj9ailj6ojwAr6fsw8eL41+QqAdnIRguHFpmQ9uTfE+WDiy8Y+Dcfb5qNw87HKfZgU5LzDWWNKzClaotEPZq8gd+xdFKFBoZyz7SAYwUGeHkQLltaGadmB0UhSkw3Oirc93HPWh9MO4U0YSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CploIfIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97435C433F1;
	Sat,  2 Mar 2024 21:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709416504;
	bh=+r4eXVhR3+ABrstefGAz7F5xG813E6/x5+a8CRWLllc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=CploIfIkYMNllumUJd5Fd6jigHRMXKzFPeVPcIQQ+vyyYJvceU4skH76OjezIKH4m
	 TWIPQRFFWN+l9DmlHKf/jRfHjSnT+Nygl1AWAWtINxMlzsnDu0utL5R+O8zY06rHqK
	 EOJI56bQQXq4l1/cB8mo3X68ob+Sw8cx7Oqp7+d3zc/n+I0UH0i9YVPQCeRKLeO1RF
	 SQusxmXZdr/VZT+K7W7TNuVVcmruRs/h7riwUnb9ScaI7P+WMtA1dp3Avb9JU8e4eo
	 CASg3QIAE1RV8LAFDHheZIsKBPkKfkC8rnMhvZRsz4jGwwaK1GEUhFEExv5ICuOzz+
	 etbyP37NwPzUA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Mar 2024 23:55:00 +0200
Message-Id: <CZJLKR6WDPJJ.1QMHE8BSHP3UH@suppilovahvero>
Cc: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <saulo.alessandre@tse.jus.br>
Subject: Re: [PATCH v3 01/10] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lukas Wunner" <lukas@wunner.de>
X-Mailer: aerc 0.15.2
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240223204149.4055630-2-stefanb@linux.ibm.com>
 <20240229091105.GA29363@wunner.de>
 <aabeec7b-618c-4d15-b033-4162b6e54f6a@linux.ibm.com>
 <CZIOY02QS2QC.LV0A0HNT7VKM@suppilovahvero>
 <20240302140001.GA3095@wunner.de>
In-Reply-To: <20240302140001.GA3095@wunner.de>

On Sat Mar 2, 2024 at 4:00 PM EET, Lukas Wunner wrote:
> On Fri, Mar 01, 2024 at 10:26:29PM +0200, Jarkko Sakkinen wrote:
> > On Thu Feb 29, 2024 at 4:57 PM EET, Stefan Berger wrote:
> > >
> > >
> > > On 2/29/24 04:11, Lukas Wunner wrote:
> > > > On Fri, Feb 23, 2024 at 03:41:40PM -0500, Stefan Berger wrote:
> > > >> +static inline void ecc_digits_from_bytes(const u8 *in, unsigned i=
nt nbytes,
> > > >> +					 u64 *out, unsigned int ndigits)
> > > >> +{
> > > >> +	unsigned int sz =3D ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
> > > >> +	u8 tmp[ECC_MAX_DIGITS << ECC_DIGITS_TO_BYTES_SHIFT];
> > > >> +	unsigned int o =3D sz - nbytes;
> > > >> +
> > > >> +	memset(tmp, 0, o);
> > > >> +	memcpy(&tmp[o], in, nbytes);
> > > >> +	ecc_swap_digits(tmp, out, ndigits);
> > > >> +}
> > > >=20
> > > > Copying the whole key into tmp seems inefficient.  You only need
> > > > special handling for the first few bytes of "in" (6 bytes in the
> > > > P521 case) and could use ecc_swap_digits() to convert the rest
> > > > of "in" directly to "out" without using tmp.
> > > >=20
> > > > So it would be sufficient to allocate the first digit on the stack,
> > > > memset + memcpy, then convert that to native byte order into "in[0]=
"
> > > > and use ecc_swap_digits() for the rest.
> > > >=20
> > > > And the special handling would be conditional on "!o", so is skippe=
d
> > > > for existing curves.
> > >
> > > Thanks. It looks like this now:
> > >
> > > static inline void ecc_digits_from_bytes(const u8 *in, unsigned int n=
bytes,
> > >                                           u64 *out, unsigned int ndig=
its)
> > > {
> > >          unsigned int o =3D nbytes & 7;
> > >          u64 msd =3D 0;
> > >          size_t i;
> > >
> > >          if (o =3D=3D 0) {
> > >                  ecc_swap_digits(in, out, ndigits);
> > >          } else {
> > >                  for (i =3D 0; i < o; i++)
> > >                          msd =3D (msd << 8) | in[i];
> > >                  out[ndigits - 1] =3D msd;
> > >                  ecc_swap_digits(&in[o], out, ndigits - 1);
> >=20
> > This would be more stream-lined IMHO:
> >=20
> >         unsigned int o =3D nbytes & 7;
> >         unsigned int n =3D ndigits;
> >         u64 msd =3D 0;
> >         size_t i;
> >=20
> >         if (o !=3D 0) {
> >                 for (i =3D 0; i < o; i++)
> >                         msd =3D (msd << 8) | in[i];
> >=20
> >                 out[--n] =3D msd;
> >         }
> >=20
> >         ecc_swap_digits(in, out, n);
>
> Maybe eliminate the for-loop as well?
>
> 	unsigned int o =3D nbytes & 7;
> 	u64 msd =3D 0;
>
> 	if (o !=3D 0) {
> 		/* if key length is not a multiple of 64 bits (NIST P521) */
> 		memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
> 		out[--ndigits] =3D be64_to_cpu(msd);
> 		in +=3D o;
> 	}
>
> 	ecc_swap_digits(in, out, ndigits);

+1

BR, Jarkko

