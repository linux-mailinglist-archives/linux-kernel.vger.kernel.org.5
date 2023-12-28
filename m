Return-Path: <linux-kernel+bounces-12624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED8A81F7E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75271F2262C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D747491;
	Thu, 28 Dec 2023 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Bngoph/6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E5D6FD6;
	Thu, 28 Dec 2023 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 03D61836;
	Thu, 28 Dec 2023 12:42:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1703763756;
	bh=Fee/9t0eXgS6MDUz/D+jsD/PXIla4i5fBeCId8d0IYA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Bngoph/6tV0FvJwOF5jSGqoej4B5Gk6cpCkdiJHTmu78Bqz98EJX12pogYjjwAq8I
	 GMP8eFKuSiVf0Sx5EPesdgXL1b+oHn1WNWNNH9KEb5uE7N9mut2CXbf/PD0RwFyCQJ
	 mESBz/r0KabHj1yXsH+19eZVM7gmh78Sgbo6dZlM=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231227133516.1356553-1-bhavin.sharma@siliconsignals.io>
References: <20231227133516.1356553-1-bhavin.sharma@siliconsignals.io>
Subject: Re: [PATCH] media: adv7180: Fix cppcheck warnings and errors
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: bhavin.sharma@siliconsignals.io
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>, lars@metafoo.de, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@kernel.org
Date: Thu, 28 Dec 2023 11:43:28 +0000
Message-ID: <170376380893.2881109.11558061738942135116@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Bhavin Sharma (2023-12-27 13:35:16)
> WARNING: Missing a blank line after declarations
> ERROR: else should follow close brace '}'
>=20
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
>=20
> diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
> index 54134473186b..91756116eff7 100644
> --- a/drivers/media/i2c/adv7180.c
> +++ b/drivers/media/i2c/adv7180.c
> @@ -357,6 +357,7 @@ static int adv7180_querystd(struct v4l2_subdev *sd, v=
4l2_std_id *std)
>  {
>         struct adv7180_state *state =3D to_state(sd);

Personally, I would keep the if (err) hugging the line it's associated
with.


>         int err =3D mutex_lock_interruptible(&state->mutex);
> +
>         if (err)
>                 return err;
> =20
> @@ -411,6 +412,7 @@ static int adv7180_g_input_status(struct v4l2_subdev =
*sd, u32 *status)
>  {
>         struct adv7180_state *state =3D to_state(sd);
>         int ret =3D mutex_lock_interruptible(&state->mutex);
> +
>         if (ret)
>                 return ret;
> =20
> @@ -1046,8 +1048,7 @@ static int adv7182_init(struct adv7180_state *state)
>                                               ADV7180_REG_EXTENDED_OUTPUT=
_CONTROL,
>                                               0x17);
>                         }
> -               }
> -               else
> +               } else

I think kernel code style requires an else clause following a multiline
scope to also have its scope enclosed in braces even if it's a single
statement.

--
Kieran

>                         adv7180_write(state,
>                                       ADV7180_REG_EXTENDED_OUTPUT_CONTROL,
>                                       0x07);
> --=20
> 2.25.1
>

