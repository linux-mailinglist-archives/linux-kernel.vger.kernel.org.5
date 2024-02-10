Return-Path: <linux-kernel+bounces-60482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D085057B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F301F24FC2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA0D5C91E;
	Sat, 10 Feb 2024 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLcQfSuu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B374947F63;
	Sat, 10 Feb 2024 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707584279; cv=none; b=qvVlhEIQYPmBP1r81Y74U/22nZKvAUMXyq5U4YQ9wFxVPS19Bjh/V1ngbndzpUMpB+pyzeyw/TSKMj4UYD/j8l0H5qmESFSV8h4GJOaxWVHUBb0kNqjR8pd4qrcgXPdh/EJU3EtDyeUDuFVCJy80jmOvTqiHIdPMIoJtJMQKtD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707584279; c=relaxed/simple;
	bh=e2+ILLixGv/eQTmIFTQQRvqQLzC9MGoUNDf3vv8+W/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9LzcwublmV2y1lpILHm+WA60GUy3xDC6mfrwP3fYwyNvt3HLcFqazAsqKt3oF4wwMpf+OxNmKxSYRFvJwbBRKio5WwvfrmiWwhKleXZa5KGyzGNpUp7uWbIMUIpqtPS8nseol9FSjn7s131x6W2JeNy/DRI/x5N0UhAbdTACqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLcQfSuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91142C433F1;
	Sat, 10 Feb 2024 16:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707584279;
	bh=e2+ILLixGv/eQTmIFTQQRvqQLzC9MGoUNDf3vv8+W/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rLcQfSuu+zdAv2UdndXWuRyOTwgZKN205Hn6zUZxEnl27QBwe+SXvmSvT/jBuQb3K
	 vQD17cp8dTa38p8a8/Vdzy6PIbREmRaUj/bxG+8zrtZwAUKsugPHDWdxjmaTVMCH6m
	 WRNB2EnHUOnlGwSQq4NU8DAG17iN5La9CNhXdn9JOP9+06kZ+ZNrp28pmiNGTfa0BL
	 syGUhYIIYmmuYLQi36GqX1Z3CXdJk0cx54FJR3Wh1AmvSdQ/gg5CRv5rZXt6Ov7qCy
	 OxyR+YR0bRd2Vlof3q1TA4rLMwu/azuBDbmhWTNJmiargv07KbdEhvuoCTvvBnQkAS
	 lY0j6W1fpk8uQ==
Date: Sat, 10 Feb 2024 16:57:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Cosmin Tanislav <demonsingur@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: adxl367: fix I2C FIFO data register
Message-ID: <20240210165747.1f93c795@jic23-huawei>
In-Reply-To: <70a4854e94cfd04b1a0ec9d3defe50ec56fc874f.camel@gmail.com>
References: <20240207033657.206171-1-demonsingur@gmail.com>
	<20240207033657.206171-2-demonsingur@gmail.com>
	<70a4854e94cfd04b1a0ec9d3defe50ec56fc874f.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 07 Feb 2024 10:08:38 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2024-02-07 at 05:36 +0200, Cosmin Tanislav wrote:
> > As specified in the datasheet, the I2C FIFO data register is
> > 0x18, not 0x42. 0x42 was used by mistake when adapting the
> > ADXL372 driver.
For future reference (not worth a v2): You could wrap a little longer - 75
chars is fine normally for commit messages. =20
> >=20
> > Fix this mistake.
> >=20
> > Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
> > --- =20
>=20
> This needs a Fixes: tag. With that:
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Fine to just reply to each of these emails with an appropriate
fixes tag - no need for a v2.


>=20
> > =C2=A0drivers/iio/accel/adxl367_i2c.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl36=
7_i2c.c
> > index b595fe94f3a3..62c74bdc0d77 100644
> > --- a/drivers/iio/accel/adxl367_i2c.c
> > +++ b/drivers/iio/accel/adxl367_i2c.c
> > @@ -11,7 +11,7 @@
> > =C2=A0
> > =C2=A0#include "adxl367.h"
> > =C2=A0
> > -#define ADXL367_I2C_FIFO_DATA	0x42
> > +#define ADXL367_I2C_FIFO_DATA	0x18
> > =C2=A0
> > =C2=A0struct adxl367_i2c_state {
> > =C2=A0	struct regmap *regmap; =20
>=20


