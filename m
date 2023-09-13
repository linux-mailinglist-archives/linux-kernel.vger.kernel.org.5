Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C637C79F1C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjIMTJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjIMTJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:09:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C561999;
        Wed, 13 Sep 2023 12:09:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A8AC433C7;
        Wed, 13 Sep 2023 19:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694632190;
        bh=Ktek55em2lQqOLi5XrDpc0X2yRD8Pv24UsJnY2E/vlM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nQO0JEba4WiZV1j94DNPCq1BYLHgmbABq30DurjcAe4ok7NGPCf/J/27Zi21UVgBS
         Pk3a3M7hCxfPJh6cyU6froE3+yxucopavyqW7AMR8EgeXbt8vgtdL/LpU1E3Rc/Djp
         xMwmpW3VMaOUeYdaT9ZjouDR95jpnqRZuKanFTKMGulk5s2gJ/yW/LE7fvYF8VQYjz
         wilMKcidfyehQeZv/+hPCiCKO20Xr0IaDUJyVH7jJ7i9qRd7df7esyofV+2a0OgkTU
         ynX+z+vpiKrV+U5S9smVMi+FtuO9bj8osyGqdeM7dfe//L+P4sVDFjsFr39MV1LsAY
         PpDX7Ynf6PBnA==
Date:   Wed, 13 Sep 2023 20:09:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: addac: ad74413r: update channel function set
Message-ID: <20230913200944.086ec3c3@jic23-huawei>
In-Reply-To: <20230911142950.216687-1-antoniu.miclaus@analog.com>
References: <20230911142950.216687-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 17:29:50 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> According to the datasheet switching to a new channel function implies
> multiple steps.
>=20
> All functions must be selected for a minimum of 130 =CE=BCs before changi=
ng
> to another function.
> The DAC_CODEx registers are not reset by changing channel functions.
> Prior to changing channel functions, it is recommended to set the DAC
> code to 0x0000 via the DAC_CODEx registers. Set the channel function
> to high impedance via the CH_FUNC_SETUPx registers before transitioning
> to the new channel function. After the new channel function is configured,
> it is recommended to wait 150 =CE=BCs before updating the DAC code.
>=20
> Even though the channel switch is done at only at probe, where a device
> reset is performed, that does not guarantee that the steps prior
> changing to new channel function should be neglected.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Given description and lack of fixes tag, I'm not treating this as a fix.
Let me know if I should and provide a fixes tag in reply to this therad.

Applied to the togreg branch of iio.git and pushed out as testing.
Thanks,

Jonathan
> ---
>  drivers/iio/addac/ad74413r.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index 6b0e8218f150..7b9ebb481815 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -441,12 +441,30 @@ static int ad74413r_set_channel_function(struct ad7=
4413r_state *st,
>  {
>  	int ret;
> =20
> +	ret =3D regmap_update_bits(st->regmap,
> +				 AD74413R_REG_CH_FUNC_SETUP_X(channel),
> +				 AD74413R_CH_FUNC_SETUP_MASK,
> +				 CH_FUNC_HIGH_IMPEDANCE);
> +	if (ret)
> +		return ret;
> +
> +	/* Set DAC code to 0 prior to changing channel function */
> +	ret =3D ad74413r_set_channel_dac_code(st, channel, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Delay required before transition to new desired mode */
> +	usleep_range(130, 150);
> +
>  	ret =3D regmap_update_bits(st->regmap,
>  				  AD74413R_REG_CH_FUNC_SETUP_X(channel),
>  				  AD74413R_CH_FUNC_SETUP_MASK, func);
>  	if (ret)
>  		return ret;
> =20
> +	/* Delay required before updating the new DAC code */
> +	usleep_range(150, 170);
> +
>  	if (func =3D=3D CH_FUNC_CURRENT_INPUT_LOOP_POWER)
>  		ret =3D regmap_set_bits(st->regmap,
>  				      AD74413R_REG_ADC_CONFIG_X(channel),

