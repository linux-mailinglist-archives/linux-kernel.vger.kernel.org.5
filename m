Return-Path: <linux-kernel+bounces-157723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 593808B1511
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCE41C23793
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D26745CB;
	Wed, 24 Apr 2024 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un/WangW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020215698B;
	Wed, 24 Apr 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992987; cv=none; b=gEPHiF91JUe+vR5phP3eCvxLF7t4HyPe0o+/DyvE6q0hgKSEZTVobbhRrW1RrEzGTw1423xWvcMwXc10M+e0Q2WDLL3Um59xcYzfoI1QZzdLEptpe5uU+9U1dCgyYNE/K9DVtTtbQUEnV0ZsuNRUIabBnbjSb9sj6DSR0Wk+qFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992987; c=relaxed/simple;
	bh=7D4fUL5psJBJkbBj2WQ9TWfJZkuflavBhvgCZyPDfYM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=RGtmuj5f/11Ncs4rVYUlQvRURHkG41be3YCQQYdiYynDGmUE3uJr1C1nuQz4gyI0Ley/2FPRsHx1/WpO8Zn7nCyQxTME+jgwWBGBXvCPDKK0lofCkHsG+No/iYZe7E4Eo0jFKeFL8yis2ps5RehspCUWTFEiw9aZ3LBWvRJQrgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un/WangW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8759AC113CD;
	Wed, 24 Apr 2024 21:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713992986;
	bh=7D4fUL5psJBJkbBj2WQ9TWfJZkuflavBhvgCZyPDfYM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Un/WangW4AqJvJVc9j+Woei1x5ZF7h6C4RRF1HE/47sduzAIddua6R9tWpcTkUhdN
	 QCi2FMMbNZTRpM2rkUUr270oAotl/sXOI1pzu4M/QmNTKQ97wGkd759pXqSidCR9xS
	 cP42IQUElaX2lHspIGcSREFb1ip1rb0L80UKBv4vwXltLbORLdor8+PKKCFJhFeE7w
	 vnOVJUiISBUpxI4wL4AK+8zwEcNNHrFoIqBNbzQfHMnY63FIrT0k3gDkFBntwjOe71
	 pWHI54a8uLEsZfrkVyknxo2z4FJsBmPDo7zfZZ3c5Hls80O4bYMqoE0e4UK0JmJTOV
	 ogvm10FnwVhiw==
Message-ID: <46c9baab4b3a834c27949b99668a9c30.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240424-glazing-handsaw-4c303fef4f7e@spud>
References: <20240424-strangle-sharpener-34755c5e6e3e@spud> <722f31da34e5e1cfef05fb966f6c8c96.sboyd@kernel.org> <20240424-glazing-handsaw-4c303fef4f7e@spud>
Subject: Re: [PATCH v2] clock, reset: microchip: move all mpfs reset code to the reset subsystem
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>, Philipp Zabel <p.zabel@pengutronix.de>, Daire McNamara <daire.mcnamara@microchip.com>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Conor Dooley <conor@kernel.org>
Date: Wed, 24 Apr 2024 14:09:44 -0700
User-Agent: alot/0.10

Quoting Conor Dooley (2024-04-24 13:19:04)
> On Wed, Apr 24, 2024 at 11:33:32AM -0700, Stephen Boyd wrote:
> > Quoting Conor Dooley (2024-04-24 01:42:08)
> > > diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
> > > index 7f3fb2d472f4..710f9c1676f9 100644
> > > --- a/drivers/reset/reset-mpfs.c
> > > +++ b/drivers/reset/reset-mpfs.c
> > > @@ -121,11 +135,15 @@ static int mpfs_reset_probe(struct auxiliary_de=
vice *adev,
> > >  {
> > >         struct device *dev =3D &adev->dev;
> > >         struct reset_controller_dev *rcdev;
> > > +       struct mpfs_reset *rst;
> > > =20
> > > -       rcdev =3D devm_kzalloc(dev, sizeof(*rcdev), GFP_KERNEL);
> > > -       if (!rcdev)
> > > +       rst =3D devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
> > > +       if (!rst)
> > >                 return -ENOMEM;
> > > =20
> > > +       rst->base =3D (void __iomem *)adev->dev.platform_data;
> >=20
> > Can use dev_get_platdata() here?
> >=20
> >       rst->base =3D (void __iomem *)dev_get_platdata(dev);
> >=20
> > That's sad that a cast is necessary. Does it need __force as well? An
> > alternative would be to make a container struct for auxiliary_device and
> > put the pointer there.
>=20
>=20
> Ye, I dunno if it was sparse that yelled at me, but either it or the
> compiler didn't approve. I don't really like the casting in and out, but
> the alternative I don't find elegant either, so I picked the one I deemed
> simpler. I'm happy to go with whichever you prefer.

I don't really care. Am I supposed to pick this patch up?

>=20
> And re: __force, AFAIU that's only required while discarding the
> __iomem, so the cast into the platform_data has one:
>         adev->dev.platform_data =3D (__force void *)base;
>=20

Ah, ok. Thanks for the remind.

