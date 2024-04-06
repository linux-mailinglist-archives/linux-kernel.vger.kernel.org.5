Return-Path: <linux-kernel+bounces-133986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB0C89ABC2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0826A1F212C9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608D72E84E;
	Sat,  6 Apr 2024 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH8beJvJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD838FA5;
	Sat,  6 Apr 2024 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712418406; cv=none; b=MbocLYEUuLlaZ8TBSeH0/v10s84oPcampZx5qkD9eEe6a/coNHEA6uYD0SNRAxaAzhzoHeuCCJLhidvAV8ztjCODHAe3oE5p3aTdNM8DlfG7YSRb0WrnmkT2LarDfA6vRBGOyst2T9oqOd8HJGMPzaJIEAVfuf7njlpYcBlmry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712418406; c=relaxed/simple;
	bh=AduoKm/UmGHvrrIH2O3jYTpeQVXIbbUL7w25qENLi68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfKIkjUUYE60ekl5KdQd+YFGBrlGEzgNsj9Y59GRVmT0LQ58c/DmTFK7wAwzTCUUh7cvNqiluejTaCX7/4VEQWra6m1AS8aGM8S5jQJ7x0h5Um6n6YzTyUM1NGgnqrdSx7CJbmCYicA+yQlaS2UE1sGiJg60eFY77eNKAVH4+yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH8beJvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DD4C433F1;
	Sat,  6 Apr 2024 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712418406;
	bh=AduoKm/UmGHvrrIH2O3jYTpeQVXIbbUL7w25qENLi68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PH8beJvJ3ggS32MNcSmFjLO6h19KDkT/zvwS7+65RYW//MKzcE73CzdlHYA9cqHbX
	 NI4ujxlq3WoWIPRbenPWvIEV1OQT05Cqj4sSDbHwWdUTkctlmIuWHCIcbVT69g8s4n
	 qc6RolkuApZGRrVb3j5i1dBTnNVPq4Tu5U/nNSMBmLmm8J8EZP5l9q3iea56bUMerL
	 Bs/+iDoS2/LCfqh4/2QAeqjLZxv2Bw8N6/9iY9l+kTYYDCDOv+8svyMhn5wJ5Sujj+
	 u6BBsLLu4RDpcQ39zgmnELqYwH9IGcuWwLjLsH4HvA/lSvZC/9w54lfe1zDhNRztbJ
	 nUYv9ZwVCJSyw==
Date: Sat, 6 Apr 2024 16:46:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iio:imu: adis16475: Fix sync mode setting
Message-ID: <20240406164633.76e3601b@jic23-huawei>
In-Reply-To: <00ed6785db2b43ec3727f42c71dc2c8dd1b627f1.camel@gmail.com>
References: <20240405045309.816328-1-ramona.bolboaca13@gmail.com>
	<20240405045309.816328-2-ramona.bolboaca13@gmail.com>
	<00ed6785db2b43ec3727f42c71dc2c8dd1b627f1.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 05 Apr 2024 09:02:33 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2024-04-05 at 07:53 +0300, Ramona Gradinariu wrote:
> > Fix sync mode setting by applying the necessary shift bits.
> >=20
> > Fixes: fff7352bf7a3 ("iio: imu: Add support for adis16475")
> > Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> > --- =20
>=20
> Not sure there was a reason to drop my tag... Anyways:
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Missing -S on b4 maybe?  A special parameter I save just for you Nuno ;)

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

>=20
> > changes in v2:
> > =C2=A0- added u16 value to call __adis_update_bits to fix build error
> > =C2=A0drivers/iio/imu/adis16475.c | 4 +++-
> > =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> > index 01f55cc902fa..060a21c70460 100644
> > --- a/drivers/iio/imu/adis16475.c
> > +++ b/drivers/iio/imu/adis16475.c
> > @@ -1289,6 +1289,7 @@ static int adis16475_config_sync_mode(struct adis=
16475
> > *st)
> > =C2=A0	struct device *dev =3D &st->adis.spi->dev;
> > =C2=A0	const struct adis16475_sync *sync;
> > =C2=A0	u32 sync_mode;
> > +	u16 val;
> >=20
> > =C2=A0	/* default to internal clk */
> > =C2=A0	st->clk_freq =3D st->info->int_clk * 1000;
> > @@ -1350,8 +1351,9 @@ static int adis16475_config_sync_mode(struct adis=
16475
> > *st)
> > =C2=A0	 * I'm keeping this for simplicity and avoiding extra variables
> > =C2=A0	 * in chip_info.
> > =C2=A0	 */
> > +	val =3D ADIS16475_SYNC_MODE(sync->sync_mode);
> > =C2=A0	ret =3D __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> > -				 ADIS16475_SYNC_MODE_MASK, sync->sync_mode);
> > +				 ADIS16475_SYNC_MODE_MASK, val);
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> >=20
> > --
> > 2.34.1
> >  =20
>=20


