Return-Path: <linux-kernel+bounces-89122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0A586EAB8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CBF1C243CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F72535BF;
	Fri,  1 Mar 2024 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tF8wNf/N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D8D3EA6F;
	Fri,  1 Mar 2024 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326310; cv=none; b=A6Jq9OXEJg8NO7zqHQC9IeRcZVCKpQABeQE+GFWPIl2gFzm9tJm/4mpG+2AUc/nnOgR8GxE6z8Rzil9YOCyX9m7M1OZ+qct8QpppwV0ZQWuHrMDV+3TzdqFI1dp7RgUXKBXMjSSPnDxWLYir1QEWXAjEP4ZqL8AmLKkN31VkXaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326310; c=relaxed/simple;
	bh=RyKbIk0JE7QfAMCfTxvDAqDPe+m3yOaykMCthkWixPk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aYGk9xSYJWeHA/JwRBgfdOmmeA2PCQSD+BYfKE9JSBVXiuamykUYlh5ux+SzWTzXSe/TrrelNpi96uw/BkMe3SVHDAyiUD5qKNPrSuTP0gUHp4XRbLPxWQvS6838oclZ99/r0uIG+dGWDYlmfT1lJU2HHW04bhdVMt3vMG3PcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tF8wNf/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF67C433F1;
	Fri,  1 Mar 2024 20:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709326309;
	bh=RyKbIk0JE7QfAMCfTxvDAqDPe+m3yOaykMCthkWixPk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tF8wNf/NHE0qBGR+8IHd+punLUB3yypPnoB5y8g7jC77sI+92WpezqEALQicQJqAi
	 GqUppFJDAErCSGz94vd66bhBQo9XLTNGfhHqMQiCdux7VocrGIbwLwpilpZIM1tsuZ
	 EfOoIEfbazI3W0evlz/GY1KzoEAnh0w+ZqA6TrtdmvqVoawsiHZNYXCSbME/0MR1X4
	 pEKe4khAGdOkN1Fz+NVqB+c3CuTOZcXX8dBPmOk+5KFt9qXmlubK6Ks4G0JSkHkfPS
	 DiFP8UtmSbaTxlkBStyXBok8DjTHs+czX0vRln5tUXUgKylq311o/9VHVeG+AWEyQC
	 mgi8/3rwlt7CQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Mar 2024 22:51:46 +0200
Message-Id: <CZIPLSJ3HA9K.LUY0REGO0GAH@suppilovahvero>
Cc: <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>
Subject: Re: [PATCH v3 01/10] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Lukas Wunner"
 <lukas@wunner.de>
X-Mailer: aerc 0.15.2
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240223204149.4055630-2-stefanb@linux.ibm.com>
 <20240229091105.GA29363@wunner.de>
 <aabeec7b-618c-4d15-b033-4162b6e54f6a@linux.ibm.com>
 <CZIOY02QS2QC.LV0A0HNT7VKM@suppilovahvero>
 <8d33a745-ac77-4965-8d1d-35061b027f33@linux.ibm.com>
In-Reply-To: <8d33a745-ac77-4965-8d1d-35061b027f33@linux.ibm.com>

On Fri Mar 1, 2024 at 10:48 PM EET, Stefan Berger wrote:
>
>
> On 3/1/24 15:26, Jarkko Sakkinen wrote:
> > On Thu Feb 29, 2024 at 4:57 PM EET, Stefan Berger wrote:
> >>
> >>
> >> On 2/29/24 04:11, Lukas Wunner wrote:
> >>> On Fri, Feb 23, 2024 at 03:41:40PM -0500, Stefan Berger wrote:
> >>>> +static inline void ecc_digits_from_bytes(const u8 *in, unsigned int=
 nbytes,
> >>>> +					 u64 *out, unsigned int ndigits)
> >>>> +{
> >>>> +	unsigned int sz =3D ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
> >>>> +	u8 tmp[ECC_MAX_DIGITS << ECC_DIGITS_TO_BYTES_SHIFT];
> >>>> +	unsigned int o =3D sz - nbytes;
> >>>> +
> >>>> +	memset(tmp, 0, o);
> >>>> +	memcpy(&tmp[o], in, nbytes);
> >>>> +	ecc_swap_digits(tmp, out, ndigits);
> >>>> +}
> >>>
> >>> Copying the whole key into tmp seems inefficient.  You only need
> >>> special handling for the first few bytes of "in" (6 bytes in the
> >>> P521 case) and could use ecc_swap_digits() to convert the rest
> >>> of "in" directly to "out" without using tmp.
> >>>
> >>> So it would be sufficient to allocate the first digit on the stack,
> >>> memset + memcpy, then convert that to native byte order into "in[0]"
> >>> and use ecc_swap_digits() for the rest.
> >>>
> >>> And the special handling would be conditional on "!o", so is skipped
> >>> for existing curves.
> >>
> >> Thanks. It looks like this now:
> >>
> >> static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nb=
ytes,
> >>                                            u64 *out, unsigned int ndig=
its)
> >> {
> >>           unsigned int o =3D nbytes & 7;
> >>           u64 msd =3D 0;
> >>           size_t i;
> >>
> >>           if (o =3D=3D 0) {
> >>                   ecc_swap_digits(in, out, ndigits);
> >>           } else {
> >>                   for (i =3D 0; i < o; i++)
> >>                           msd =3D (msd << 8) | in[i];
> >>                   out[ndigits - 1] =3D msd;
> >>                   ecc_swap_digits(&in[o], out, ndigits - 1);
> >=20
> > This would be more stream-lined IMHO:
> >=20
> >          unsigned int o =3D nbytes & 7;
> > 	unsigned int n =3D ndigits;
> >          u64 msd =3D 0;
> >          size_t i;
> >=20
> >          if (o !=3D 0) {
> >                  for (i =3D 0; i < o; i++)
> >                          msd =3D (msd << 8) | in[i];
> >=20
> >                  out[--n] =3D msd;
> >          }
> >=20
> >          ecc_swap_digits(in, out, n);
>
> You forgot to advance 'in'.

yeah, pointing out that two call sites is unnecessary complexity, that's
all

BR, Jarkko

