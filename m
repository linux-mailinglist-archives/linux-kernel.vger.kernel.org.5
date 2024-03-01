Return-Path: <linux-kernel+bounces-89082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781BF86EA4A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3060928A769
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DF33C6BA;
	Fri,  1 Mar 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suEoBXOv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF793C470;
	Fri,  1 Mar 2024 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324793; cv=none; b=UoiBNmCzEtkhMUqNfXEkb2iUzsvMa46q8KELJrapP9Mdv8ZOXI3oR05eugQqmZFSg5ezs6iApAgB30HT4hXxRTDIsRJe+K4opcvMPsQ6p8necIHzdCqShe8yI/wxBK/4T3XJTwVcP2vnXj/QYaGzlgcU6whYHL0dONoZXxtm6uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324793; c=relaxed/simple;
	bh=PrJ3aVeOXXr6ChkhosX0KQsUPRlQeGLh2zV6DSxUaAw=;
	h=Mime-Version:Content-Type:Date:Subject:From:To:Cc:Message-Id:
	 References:In-Reply-To; b=CgCjJ+4b6gZA30WFxzOJfl3Jp1pvzHLBwlXCpXB+gXuTp9kdIFu+s2A2EMCEe8Kg6Dbf7RmZtiEoCe9UKu9iDpX1C+7+4zORMpgA7qCyfvp93tuFjwqu7a8byw9YMwBp/S3hAiteewwrqYsyxQIBbtnt2D8tX9JZiogMw+tj960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suEoBXOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EAEC433F1;
	Fri,  1 Mar 2024 20:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709324793;
	bh=PrJ3aVeOXXr6ChkhosX0KQsUPRlQeGLh2zV6DSxUaAw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=suEoBXOvlqG4qAZ3jekNNeljlAYHrPsJh6fR6LYNf/nXwWORCnJ90dMd+VgUybDla
	 LUWLkUUn7sIPKDhK54MQZoTOMNtmWdySLbBDM7ziR5xEJ8eK0OxZHY+jaQOk+TDJmw
	 a0wqaGOAbG65tmeI/W7VNls4nyTpWx1Sr4skloCYei7/jBFRQESWhaVkSVc/3Tn6G6
	 MfxgKWbb65y3xQHVFxmRmAb5woFOk3JI05GkF1+wFFLJGbTCcE6+5C/P2VAreW2kub
	 mq8vTYMgeHp+gRYF29A/6uaqutoIRlUX+kxSNQYhnbXuiEb4KV0z3ztp9Pvf6XujJu
	 q7TL/Ss+pvcKg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Mar 2024 22:26:29 +0200
Subject: Re: [PATCH v3 01/10] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Lukas Wunner"
 <lukas@wunner.de>
Cc: <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>
Message-Id: <CZIOY02QS2QC.LV0A0HNT7VKM@suppilovahvero>
X-Mailer: aerc 0.15.2
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240223204149.4055630-2-stefanb@linux.ibm.com>
 <20240229091105.GA29363@wunner.de>
 <aabeec7b-618c-4d15-b033-4162b6e54f6a@linux.ibm.com>
In-Reply-To: <aabeec7b-618c-4d15-b033-4162b6e54f6a@linux.ibm.com>

On Thu Feb 29, 2024 at 4:57 PM EET, Stefan Berger wrote:
>
>
> On 2/29/24 04:11, Lukas Wunner wrote:
> > On Fri, Feb 23, 2024 at 03:41:40PM -0500, Stefan Berger wrote:
> >> +static inline void ecc_digits_from_bytes(const u8 *in, unsigned int n=
bytes,
> >> +					 u64 *out, unsigned int ndigits)
> >> +{
> >> +	unsigned int sz =3D ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
> >> +	u8 tmp[ECC_MAX_DIGITS << ECC_DIGITS_TO_BYTES_SHIFT];
> >> +	unsigned int o =3D sz - nbytes;
> >> +
> >> +	memset(tmp, 0, o);
> >> +	memcpy(&tmp[o], in, nbytes);
> >> +	ecc_swap_digits(tmp, out, ndigits);
> >> +}
> >=20
> > Copying the whole key into tmp seems inefficient.  You only need
> > special handling for the first few bytes of "in" (6 bytes in the
> > P521 case) and could use ecc_swap_digits() to convert the rest
> > of "in" directly to "out" without using tmp.
> >=20
> > So it would be sufficient to allocate the first digit on the stack,
> > memset + memcpy, then convert that to native byte order into "in[0]"
> > and use ecc_swap_digits() for the rest.
> >=20
> > And the special handling would be conditional on "!o", so is skipped
> > for existing curves.
>
> Thanks. It looks like this now:
>
> static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbyte=
s,
>                                           u64 *out, unsigned int ndigits)
> {
>          unsigned int o =3D nbytes & 7;
>          u64 msd =3D 0;
>          size_t i;
>
>          if (o =3D=3D 0) {
>                  ecc_swap_digits(in, out, ndigits);
>          } else {
>                  for (i =3D 0; i < o; i++)
>                          msd =3D (msd << 8) | in[i];
>                  out[ndigits - 1] =3D msd;
>                  ecc_swap_digits(&in[o], out, ndigits - 1);

This would be more stream-lined IMHO:

        unsigned int o =3D nbytes & 7;
	unsigned int n =3D ndigits;
        u64 msd =3D 0;
        size_t i;

        if (o !=3D 0) {
                for (i =3D 0; i < o; i++)
                        msd =3D (msd << 8) | in[i];

                out[--n] =3D msd;
        }

        ecc_swap_digits(in, out, n);

BR, Jarkko

