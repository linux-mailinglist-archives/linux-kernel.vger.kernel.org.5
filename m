Return-Path: <linux-kernel+bounces-162342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0CC8B59BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1543DB2FB22
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8327350E;
	Mon, 29 Apr 2024 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig0PRhPy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2C7C127;
	Mon, 29 Apr 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396378; cv=none; b=aHbvp80mB6EXK0EtJtfsDpiPow3i760gBWtS52kFJRWRmIuy4fn4QgzKASe1uz+LYbM97FwKxoxqO8R/VKzHwsbFUeeK/n/6dfR1BcHUh1KSALkEvMK8C8Zcr7Sb2zYmj8SkGGy2kwgoRTyhT/k7+ND399W2VERsryJrb7n8k04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396378; c=relaxed/simple;
	bh=C/1/HgtOPadIccfda7rkD/uKMPU+S43i6YXTEI9RK70=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HRm8tx3sWr97aAvdRZaBXXJEP4voPbK66vGvqZWfvgQytrVDiVX33gb9Cvv+R2CcfJJgSJoAyZBdf/gfDdfkIT6qKZnzGdqFY7TvYrgVPonb11ENSKTx0LBhy/0Jn/ALH0Or7FfGFQBjsxoSTc7RMqGw/m7FuZMX8C3TjyyEQZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig0PRhPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97814C113CD;
	Mon, 29 Apr 2024 13:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714396378;
	bh=C/1/HgtOPadIccfda7rkD/uKMPU+S43i6YXTEI9RK70=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Ig0PRhPyyWkKOwe/eu5h8ET0VfrmwbqvRZfWKTAHn4yuxUXHHxyb4S0POuhUwQs2o
	 FUw3mdPX8kjdylv3ZVICMGb/q/ITOv4pahl3dRxc7MpDFNLfgSeisZHBjxgW8dP2Q9
	 yxxUuR1e7MYyf6ZxgwfxUS8rXgtsu29Lh1zFTi8ZyUJFmrPmEpSuaJOpJmUt/+CRC0
	 tdCdH9c+uEU448gyCCi419nAm0rCnBbfnGvNassirpClrb7dJt7qGvOcjeKThSBTry
	 WrwBkwK4y6DsPkCoz9ifJ2dzK4hIeBWT0MpDaqTn59D8xD0QznHnuDP5Cir/ielRcV
	 qwHCcOz9CCsDw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Apr 2024 16:12:54 +0300
Message-Id: <D0WMSLWS0GIR.149P7U2PJBUV1@kernel.org>
Cc: <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: ecc - Protect ecc_digits_from_bytes from
 reading too many bytes
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Lukas Wunner"
 <lukas@wunner.de>
X-Mailer: aerc 0.17.0
References: <20240426225553.3038070-1-stefanb@linux.ibm.com>
 <D0W3MTR0CY08.Q2UIYE4N274L@kernel.org> <Zi8UXS1MD5V58dnN@wunner.de>
 <D0WIZTMRKHSJ.1Z4ZV54DLVWAB@kernel.org>
 <8109c35b-344e-4d98-8245-77f4919624a1@linux.ibm.com>
In-Reply-To: <8109c35b-344e-4d98-8245-77f4919624a1@linux.ibm.com>

On Mon Apr 29, 2024 at 2:11 PM EEST, Stefan Berger wrote:
>
>
> On 4/29/24 06:14, Jarkko Sakkinen wrote:
> > On Mon Apr 29, 2024 at 6:30 AM EEST, Lukas Wunner wrote:
> >> On Mon, Apr 29, 2024 at 01:12:00AM +0300, Jarkko Sakkinen wrote:
> >>> On Sat Apr 27, 2024 at 1:55 AM EEST, Stefan Berger wrote:
> >>>> Protect ecc_digits_from_bytes from reading too many bytes from the i=
nput
> >>>> byte array in case an insufficient number of bytes is provided to fi=
ll the
> >>>> output digit array of ndigits. Therefore, initialize the most signif=
icant
> >>>> digits with 0 to avoid trying to read too many bytes later on.
> >>>>
> >>>> If too many bytes are provided on the input byte array the extra byt=
es
> >>>> are ignored since the input variable 'ndigits' limits the number of =
digits
> >>>> that will be filled.
> >>>>
> >>>> Fixes: d67c96fb97b5 ("crypto: ecdsa - Convert byte arrays with key c=
oordinates to digits")
> >>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >>>> ---
> >>>>   include/crypto/internal/ecc.h | 7 +++++++
> >>>>   1 file changed, 7 insertions(+)
> >>>>
> >>>> diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal=
/ecc.h
> >>>> index 7ca1f463d1ec..56215f14ff96 100644
> >>>> --- a/include/crypto/internal/ecc.h
> >>>> +++ b/include/crypto/internal/ecc.h
> >>>> @@ -67,9 +67,16 @@ static inline void ecc_swap_digits(const void *in=
, u64 *out, unsigned int ndigit
> >>>>   static inline void ecc_digits_from_bytes(const u8 *in, unsigned in=
t nbytes,
> >>>>   					 u64 *out, unsigned int ndigits)
> >>>>   {
> >>>> +	int diff =3D ndigits - DIV_ROUND_UP(nbytes, sizeof(u64));
> >>>>   	unsigned int o =3D nbytes & 7;
> >>>>   	__be64 msd =3D 0;
> >>>>  =20
> >>>> +	/* diff > 0: not enough input bytes: set most significant digits t=
o 0 */
> >>>> +	while (diff > 0) {
> >>>> +		out[--ndigits] =3D 0;
> >>>> +		diff--;
> >>>> +	}
> >>>
> >>> Could be just trivial for-loop:
> >>>
> >>> for (i =3D 0; i < diff; i++)
> >>> 	out[--ndigits] =3D 0;
> >>>
> >>> Or also simpler while-loop could work:
> >>>
> >>> while (diff-- > 0)
> >>> 	out[--ndigits] =3D 0;
> >>
> >> Or just use memset(), which uses optimized instructions on many arches=
.
> >=20
> > Yeah, sure, that would be even better, or even memzero_explicit()?
>
> Thanks. The function isn't getting too big for an inline?

Hmm... so as far as I'm concerned you pick what works for you. Just
was pointing out at it would make to simplify the original a bit :-)

BR, Jarkko

