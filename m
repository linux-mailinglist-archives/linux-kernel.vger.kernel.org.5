Return-Path: <linux-kernel+bounces-161479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7208B4C92
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1306D281955
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA07A6FE2D;
	Sun, 28 Apr 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlsmEHWW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41FE6E5EF;
	Sun, 28 Apr 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714320402; cv=none; b=hDRzvoNlpxZZPlj9dt4+VQFWwatB/MgjR4XHJb5zXQiVvVwo+8Vu1z1FZL7v88wKiBh/FdRDL13X6TAgDw3IkZJZpMy/Hv7QWsABJlRgSVn5C1FafBpOxZIFF7aUI39WkaYy+ZMzCHrs2XTGnp8iH1AYwcH4u3LBi3nZbX6yRxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714320402; c=relaxed/simple;
	bh=PNrlWlDt9TaAMiyqW+EragMJTkTq2ddIWeLDKoeOEjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hn/+AouNz30oQvAZaSQejwaAB+t3C1UX6KxzYOW/DeYAWJSJ+V87oIMcasGvmNYJdA4pdR8qGJV/Qdwb/CYxELulTR8EApD0VV4aIijJKhGZl8lK41ou9lV2ov3rQ+wlfA+M1X7UNU97vHMdz2duFVDErdb7RSeGCBsm4jLWk8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlsmEHWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BB8C113CC;
	Sun, 28 Apr 2024 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714320401;
	bh=PNrlWlDt9TaAMiyqW+EragMJTkTq2ddIWeLDKoeOEjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MlsmEHWWuFsTFEVNQtQGvfhEZv1yft6vbR8febqMaPdQBMCsLgYr39Mnf0S+nmk28
	 N5OWbljTp3vBAqAmwkH5RuZPxUM9vok88eLKENWzx7Gd8+Eeptxgg+qLChp61MHBmc
	 AuXaFxYoIT3QhfJoz9pAI4I27Cz6BiuYsNYVQVeLHQlQvWffU2mfTwLfU9zjO4eUaI
	 kQ6sSqB5QYw7VSjy2wNsTOQVfEkdC4WFXVbRlKNRJZ72qUHMlxZ5erkv2R21WD9IzB
	 ReTAKSN619+iA+FUgmT2F8UrcBJdx6fqqX9rcFm0l+egwkIJvaXe0ELfkVFxxFqO4K
	 kTxv/gofYXHAA==
Date: Sun, 28 Apr 2024 17:06:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Nuno Sa <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich 
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: dac: adi-axi: fix a mistake in
 axi_dac_ext_info_set()
Message-ID: <20240428170630.265f099d@jic23-huawei>
In-Reply-To: <87c6e65dadbb3ed0c9b4506e809eb3976b12f204.camel@gmail.com>
References: <df7c6e1b-b619-40c3-9881-838587ed15d4@moroto.mountain>
	<87c6e65dadbb3ed0c9b4506e809eb3976b12f204.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 14:30:02 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> Hi Dan,
>=20
> On Wed, 2024-04-24 at 14:45 +0300, Dan Carpenter wrote:
> > The last parameter of these axi_dac_(frequency|scale|phase)_set()
> > functions is supposed to be true for TONE_2 and false for TONE_1. The
> > bug is the last call where it passes "private - TONE_2".=C2=A0 That
> > subtraction is going to be zero/false for TONE_2 and and -1/true for
> > TONE_1.=C2=A0 Fix the bug, and re-write it as "private =3D=3D TONE_2" s=
o it's
> > more obvious what is happening.
> >=20
> > Fixes: 4e3949a192e4 ("iio: dac: add support for AXI DAC IP core")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > This is from code review.=C2=A0 Untested.
> > --- =20
>=20
> Auch, good catch! Agreed that private =3D=3D AXI_DAC_*_TONE_2 makes it mo=
re
> readable.
>=20
> I guess Jonathan may just squash this in the driver (was pushed this week=
end).
> Anyways, FWIW:
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>

Missed the pull request, so will have to follow it in next pull.

Applied to the togreg branch of iio.git and pushed out as testing. Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/dac/adi-axi-dac.c | 6 +++---
> > =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-da=
c.c
> > index 9047c5aec0ff..880d83a014a1 100644
> > --- a/drivers/iio/dac/adi-axi-dac.c
> > +++ b/drivers/iio/dac/adi-axi-dac.c
> > @@ -383,15 +383,15 @@ static int axi_dac_ext_info_set(struct iio_backend
> > *back, uintptr_t private,
> > =C2=A0	case AXI_DAC_FREQ_TONE_1:
> > =C2=A0	case AXI_DAC_FREQ_TONE_2:
> > =C2=A0		return axi_dac_frequency_set(st, chan, buf, len,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0 private - AXI_DAC_FREQ_TONE_1);
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 private =3D=3D AXI_DAC_FREQ_TONE_2);
> > =C2=A0	case AXI_DAC_SCALE_TONE_1:
> > =C2=A0	case AXI_DAC_SCALE_TONE_2:
> > =C2=A0		return axi_dac_scale_set(st, chan, buf, len,
> > -					 private - AXI_DAC_SCALE_TONE_1);
> > +					 private =3D=3D AXI_DAC_SCALE_TONE_2);
> > =C2=A0	case AXI_DAC_PHASE_TONE_1:
> > =C2=A0	case AXI_DAC_PHASE_TONE_2:
> > =C2=A0		return axi_dac_phase_set(st, chan, buf, len,
> > -					 private - AXI_DAC_PHASE_TONE_2);
> > +					 private =3D=3D AXI_DAC_PHASE_TONE_2);
> > =C2=A0	default:
> > =C2=A0		return -EOPNOTSUPP;
> > =C2=A0	} =20
>=20


