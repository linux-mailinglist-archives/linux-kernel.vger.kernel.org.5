Return-Path: <linux-kernel+bounces-157533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFA48B126E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF291F219AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F08168C7;
	Wed, 24 Apr 2024 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG/yl7TG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D8819479;
	Wed, 24 Apr 2024 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983614; cv=none; b=AwOZw6LUz5mAdhOFKbf7kH93AvQ8NpXlB+BKgjhUiyYdD5jPJOl9w6q+vNQXvBNjy055B2ysKurPddOMo/6jLavJDiEUs0JiMtuu1f6FpvReNkHBrEprMZpe95H3fH4v4FJRDUUu0zCZh20wkr59yQMA2pKNPeh9koN/2JY56qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983614; c=relaxed/simple;
	bh=Dw8j7UKEfEeuS79L8GjGzjL5AGQkzmeP8Nd1vojpPGc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=j08wk76NYHjDhHZicF/jPNj3SHL0D8GcXQmUefiNbNZFBri0Hoi4oV32ziXLWYsyI7hwecCTsIPfwTnY2HVG6X7V4GLdS+6m6Fy2k4U726A+/Nc9r/esarrUFvVArHfb69+3pwatmeOXpa/m0sfAonzm4DuC4aRydkBwmZa/eTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG/yl7TG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC06C113CD;
	Wed, 24 Apr 2024 18:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713983614;
	bh=Dw8j7UKEfEeuS79L8GjGzjL5AGQkzmeP8Nd1vojpPGc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=aG/yl7TGtQI9wbVbRfELyMxQuph9Oqp+keaN4+hAGVfCnFPiIHcszwjrgMCLEoxQL
	 wgsZGU+M+PgUpWolCFxOo0sXAIOo/DH5CSaVlpmZ3WoPkUsGmHvgd5JgxqLNAQzqnD
	 DkuUMCJIxh4fAOQC0X9faEleSmBp+Lii9IHjBEPsXWFV7WIHwEMv+qMHMP2oJ4IM71
	 drTejasbH+oAN4OoriNtwxI7GNW0nbHQHnpmYMN52aVCsLdobi9Fuvqpg5+Cklp8tY
	 L6jeFlTCptxOy7frDi/w17CdezBgV3FeUil6RCKzSLZ2oN/CgwguH4Y+f14UPzqHvM
	 poQGczQkOZ2Ng==
Message-ID: <722f31da34e5e1cfef05fb966f6c8c96.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240424-strangle-sharpener-34755c5e6e3e@spud>
References: <20240424-strangle-sharpener-34755c5e6e3e@spud>
Subject: Re: [PATCH v2] clock, reset: microchip: move all mpfs reset code to the reset subsystem
From: Stephen Boyd <sboyd@kernel.org>
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>, Philipp Zabel <p.zabel@pengutronix.de>, Daire McNamara <daire.mcnamara@microchip.com>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Date: Wed, 24 Apr 2024 11:33:32 -0700
User-Agent: alot/0.10

Quoting Conor Dooley (2024-04-24 01:42:08)
> diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
> index 7f3fb2d472f4..710f9c1676f9 100644
> --- a/drivers/reset/reset-mpfs.c
> +++ b/drivers/reset/reset-mpfs.c
> @@ -121,11 +135,15 @@ static int mpfs_reset_probe(struct auxiliary_device=
 *adev,
>  {
>         struct device *dev =3D &adev->dev;
>         struct reset_controller_dev *rcdev;
> +       struct mpfs_reset *rst;
> =20
> -       rcdev =3D devm_kzalloc(dev, sizeof(*rcdev), GFP_KERNEL);
> -       if (!rcdev)
> +       rst =3D devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
> +       if (!rst)
>                 return -ENOMEM;
> =20
> +       rst->base =3D (void __iomem *)adev->dev.platform_data;

Can use dev_get_platdata() here?

	rst->base =3D (void __iomem *)dev_get_platdata(dev);

That's sad that a cast is necessary. Does it need __force as well? An
alternative would be to make a container struct for auxiliary_device and
put the pointer there.

