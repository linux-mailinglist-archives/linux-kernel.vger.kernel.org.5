Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F587ED624
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344907AbjKOViC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKOViB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:38:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE21130
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:37:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD8EC433C7;
        Wed, 15 Nov 2023 21:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700084278;
        bh=AmCgzmB7jjz+T45RrytzAofEx2AMRRYYB6hhglefLRg=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=vAYHeNK+27nLlK6csqDqimKGiMbHfw6gqr5RfG1F+2FyF2QETyLVwaii0D83vzB42
         PtVQOhRSWwe1LhVH7u07nXv9W8GW4TF9LiqzLCIMSpupPxvJuKJCTG7MtdFaU2w0bH
         CiTfFjX08v5IMmdM59s8dNC91keCn04H8Dj82yZNVDUuxAHKayzrhCkTdRQUvg7j7n
         pZDkQxAugC/D4TZ8O77V/MRcvxLZTPVhILsYWZlmt/YwqZsmsprA4HaMGac1GulYKs
         HDG6vPoCuSrsZm4gG3m7gXB7dW7Ow11Ck1iPLUoB0OYeu+WltkuYahWhTyX/EdfkBB
         aOiCAPDdZM6tw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 15 Nov 2023 23:37:55 +0200
Message-Id: <CWZPKU58PWLS.1B1N297O1D9CY@kernel.org>
Cc:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] tpm: nuvoton: Use i2c_get_match_data()
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Rob Herring" <robh@kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.15.2
References: <20231115210215.3743873-1-robh@kernel.org>
In-Reply-To: <20231115210215.3743873-1-robh@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Nov 15, 2023 at 11:02 PM EET, Rob Herring wrote:
> Use preferred i2c_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/char/tpm/tpm_i2c_nuvoton.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2=
c_nuvoton.c
> index d7be03c41098..5490f7e0fa43 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -19,7 +19,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/wait.h>
>  #include <linux/i2c.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
>  #include "tpm.h"
> =20
>  /* I2C interface offsets */
> @@ -524,7 +525,6 @@ static int get_vid(struct i2c_client *client, u32 *re=
s)
> =20
>  static int i2c_nuvoton_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
>  	int rc;
>  	struct tpm_chip *chip;
>  	struct device *dev =3D &client->dev;
> @@ -546,15 +546,8 @@ static int i2c_nuvoton_probe(struct i2c_client *clie=
nt)
>  	if (!priv)
>  		return -ENOMEM;
> =20
> -	if (dev->of_node) {
> -		const struct of_device_id *of_id;
> -
> -		of_id =3D of_match_device(dev->driver->of_match_table, dev);
> -		if (of_id && of_id->data =3D=3D OF_IS_TPM2)
> -			chip->flags |=3D TPM_CHIP_FLAG_TPM2;
> -	} else
> -		if (id->driver_data =3D=3D I2C_IS_TPM2)
> -			chip->flags |=3D TPM_CHIP_FLAG_TPM2;
> +	if (i2c_get_match_data(client))
> +		chip->flags |=3D TPM_CHIP_FLAG_TPM2;
> =20
>  	init_waitqueue_head(&priv->read_queue);
> =20

OK, apologies for having to do a resend. I'll pick this, thanks!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
