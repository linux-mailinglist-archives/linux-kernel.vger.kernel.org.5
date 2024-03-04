Return-Path: <linux-kernel+bounces-90955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E3C870783
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC2B284231
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425245C5F4;
	Mon,  4 Mar 2024 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="K8oP5Z9E"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034959B4F;
	Mon,  4 Mar 2024 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570994; cv=none; b=gYTQLstDx4S40TtFckm0UI6QfvsaNZyg9vTt15URVb1XDD6coxO779EzeUMB2TsII0Jyr2VoXYeCTBzWCwCO3QfN4OpK+h12xc1GHw2t0wWGuBL8ILdkJIxty1JA0Sirvq1YA+3A0TlQpiCyVWCuShrCauDiG8rcPp+7f7aHEVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570994; c=relaxed/simple;
	bh=b+8s5dVi6mrt5wOGzTAd9u16HmjZOBeOaZElzRl9yEc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=H8aXw+sPOTEWG+KsTpGJMNoMw14bunQNUgYGSFNEhN93JkRyNtolfHucwjFUXW3kQWtWlB9c4WoJvJXYn1IkLRPlYnNXZJs/ydkU9GHJ0BYbn1L6HhbbQRlanC/2silt9RlZx7+fMTc/k6fB3AcKlXoG/FXZqjp/Y40YwpgrJZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=K8oP5Z9E; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E43003871;
	Mon,  4 Mar 2024 17:49:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709570973;
	bh=b+8s5dVi6mrt5wOGzTAd9u16HmjZOBeOaZElzRl9yEc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=K8oP5Z9EbVRWPAZKyhAd1M77sg2MAZAaQsKh3VYgkdOMv3h0cv5qUZFnBScekdRT7
	 Pdn+KpoB9mV61fXZHSy+zSfF7bKrHw0zm+EP6SlNcX/yBPBqqjfmrflcm35sS8SlPe
	 zURgn290d6sXtDxe8RWUBKQpHOfbjkcAW0ECIut4=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240229165333.227484-7-mike.rudenko@gmail.com>
References: <20240229165333.227484-1-mike.rudenko@gmail.com> <20240229165333.227484-7-mike.rudenko@gmail.com>
Subject: Re: [PATCH v3 06/20] media: i2c: ov4689: Refactor ov4689_set_ctrl
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>, Tommaso Merciai <tomm.merciai@gmail.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Mikhail Rudenko <mike.rudenko@gmail.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date: Mon, 04 Mar 2024 16:49:46 +0000
Message-ID: <170957098683.566498.5256791258269936446@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Hi Mikhail,

I love this series. ;-)

Quoting Mikhail Rudenko (2024-02-29 16:53:19)
> Introduce local variable for regmap within the ov4689_set_ctrl
> function. This adjustment eliminates repetition within the function.
>=20
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

> ---
>  drivers/media/i2c/ov4689.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 56bf1d964e43..1bc00404f3fb 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -580,10 +580,11 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  {
>         struct ov4689 *ov4689 =3D
>                 container_of(ctrl->handler, struct ov4689, ctrl_handler);
> +       struct regmap *regmap =3D ov4689->regmap;
>         struct device *dev =3D ov4689->dev;
>         int sensor_gain;
>         s64 max_expo;
> -       int ret;
> +       int ret =3D 0;
> =20
>         /* Propagate change of current control to all related controls */
>         switch (ctrl->id) {
> @@ -603,16 +604,15 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>         switch (ctrl->id) {
>         case V4L2_CID_EXPOSURE:
>                 /* 4 least significant bits of exposure are fractional pa=
rt */
> -               ret =3D cci_write(ov4689->regmap, OV4689_REG_EXPOSURE,
> -                               ctrl->val << 4, NULL);
> +               cci_write(regmap, OV4689_REG_EXPOSURE, ctrl->val << 4, &r=
et);
>                 break;
>         case V4L2_CID_ANALOGUE_GAIN:
>                 ret =3D ov4689_map_gain(ov4689, ctrl->val, &sensor_gain);
> -               cci_write(ov4689->regmap, OV4689_REG_GAIN, sensor_gain, &=
ret);
> +               cci_write(regmap, OV4689_REG_GAIN, sensor_gain, &ret);
>                 break;
>         case V4L2_CID_VBLANK:
> -               ret =3D cci_write(ov4689->regmap, OV4689_REG_VTS,
> -                               ctrl->val + ov4689->cur_mode->height, NUL=
L);
> +               cci_write(regmap, OV4689_REG_VTS,
> +                         ctrl->val + ov4689->cur_mode->height, &ret);
>                 break;
>         case V4L2_CID_TEST_PATTERN:
>                 ret =3D ov4689_enable_test_pattern(ov4689, ctrl->val);
> --=20
> 2.43.0
>

