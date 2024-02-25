Return-Path: <linux-kernel+bounces-80104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC615862AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA20281B7F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5FB13ADA;
	Sun, 25 Feb 2024 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilwUpLP/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF679D3;
	Sun, 25 Feb 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708871613; cv=none; b=IW9Vj3a183Mxv/hbXP8K8sPgnHyEVT+07k+NnvbVdUW7JV3ZKVKggu9/EkVctZXdNKnXIpOXMscPrBh0ZX3Jwd9CmeQpMfIoGipVn1IP4EoPXnhu4MTUaIsuN7vy4tlGXdeOcqa7Kucn1MZ92WWjV97o7ZGAIAovvZVfWjjncYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708871613; c=relaxed/simple;
	bh=OELcLYQWAfO6EucWEyLgLxmpIXZPNA1SuufFf8+I1fs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+DVMJYxKZ9SEMFeshHfrlZwCGuF5k8JMeco+gr/J3pLkoVQ/FHMs9sXysw+a8bLkh6VkUnytohafKmBW5ZXiBoF605c4oE8DNyxD/uN8r/I5rMUbzShN1DpOL/tE7iHCwKuHnZd0d2pMw6Ua9iejpNnItBo9HV7nF5nS8RRMVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilwUpLP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79DCC433C7;
	Sun, 25 Feb 2024 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708871612;
	bh=OELcLYQWAfO6EucWEyLgLxmpIXZPNA1SuufFf8+I1fs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ilwUpLP/uVMMyjWJ82iFRW9cCTnnUehdXASobOpaayJnH9TGCSgm5zUsivekqHAJR
	 9/Z30oDqv7B8Cin/X+yee3RMzbJ1T8m7rBB7AKtCe2KbjV6LRnFM9q0zotVYXI0R2h
	 IQvTdeQn9Q1EtGE9d/BUhEAFK4yndvvZ4t3grFDZbTORQwwpzultOAZaHJiUo3X7Qj
	 fDXo14qmsw7ssPkJmZ+yJNzgjG0rldUUDhF++s2uZNYzC6pj95YaE3loGQxGJnu2jC
	 TfCTpF4YfEEfIs+5p77eO4VHvu1LiCyrDpooBf9U0R8o/He/EzoiJxnPXCwGyduEBj
	 OaMRX6pJG1w0g==
Date: Sun, 25 Feb 2024 14:33:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Cosmin Tanislav <demonsingur@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: adxl367: fix I2C FIFO data register
Message-ID: <20240225143319.7bffe341@jic23-huawei>
In-Reply-To: <20240210165747.1f93c795@jic23-huawei>
References: <20240207033657.206171-1-demonsingur@gmail.com>
	<20240207033657.206171-2-demonsingur@gmail.com>
	<70a4854e94cfd04b1a0ec9d3defe50ec56fc874f.camel@gmail.com>
	<20240210165747.1f93c795@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 10 Feb 2024 16:57:47 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 07 Feb 2024 10:08:38 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Wed, 2024-02-07 at 05:36 +0200, Cosmin Tanislav wrote: =20
> > > As specified in the datasheet, the I2C FIFO data register is
> > > 0x18, not 0x42. 0x42 was used by mistake when adapting the
> > > ADXL372 driver. =20
> For future reference (not worth a v2): You could wrap a little longer - 75
> chars is fine normally for commit messages. =20
> > >=20
> > > Fix this mistake.
> > >=20
> > > Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
> > > ---   =20
> >=20
> > This needs a Fixes: tag. With that:
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com> =20
> Fine to just reply to each of these emails with an appropriate
> fixes tag - no need for a v2.
>=20
Given these were still in my queue waiting for a fixes tag,
I went looking.

Fixes: cbab791c5e2a ("iio: accel: add ADXL367 driver")

Both patches added and both applied to the fixes-togreg branch of iio.git

Thanks

Jonathan

>=20
> >  =20
> > > =C2=A0drivers/iio/accel/adxl367_i2c.c | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl=
367_i2c.c
> > > index b595fe94f3a3..62c74bdc0d77 100644
> > > --- a/drivers/iio/accel/adxl367_i2c.c
> > > +++ b/drivers/iio/accel/adxl367_i2c.c
> > > @@ -11,7 +11,7 @@
> > > =C2=A0
> > > =C2=A0#include "adxl367.h"
> > > =C2=A0
> > > -#define ADXL367_I2C_FIFO_DATA	0x42
> > > +#define ADXL367_I2C_FIFO_DATA	0x18
> > > =C2=A0
> > > =C2=A0struct adxl367_i2c_state {
> > > =C2=A0	struct regmap *regmap;   =20
> >  =20
>=20
>=20


