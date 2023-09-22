Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22B67AB132
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjIVLuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIVLuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:50:14 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE455FB;
        Fri, 22 Sep 2023 04:50:08 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 93A1EB53;
        Fri, 22 Sep 2023 13:48:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695383309;
        bh=2GbyfCzifSVASFE59umZegd9PqtBJFhWiw0YjYIKeP8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cI3D16xI4CIWHi6aWJvFBJKBlrwQlU18GVC95revLpVQ26H2Dg2pBMw5TLz9CZ9lc
         O96GvT9BeeOkO69AUG8Eyp9sS6uNEbBNcfhX8Tc8v0pCk5fQ6ICBTRUeinRDM/nM/m
         ulUd09pgZxWn9kE5LKdfFdUvjT9ojepGTBtOYfvw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230922080421.35145-2-wsa+renesas@sang-engineering.com>
References: <20230922080421.35145-1-wsa+renesas@sang-engineering.com> <20230922080421.35145-2-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 1/3] usb: typec: drop check because i2c_unregister_device() is NULL safe
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Date:   Fri, 22 Sep 2023 12:50:05 +0100
Message-ID: <169538340502.2915094.11564554500846900939@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wolfram Sang (2023-09-22 09:04:18)
> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

And this is the same pattern here so:

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
> Build tested only. Please apply to your tree.
>=20
>  drivers/usb/typec/anx7411.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index 221604f933a4..b12a07edc71b 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -1550,8 +1550,7 @@ static void anx7411_i2c_remove(struct i2c_client *c=
lient)
>         if (plat->workqueue)
>                 destroy_workqueue(plat->workqueue);
> =20
> -       if (plat->spi_client)
> -               i2c_unregister_device(plat->spi_client);
> +       i2c_unregister_device(plat->spi_client);
> =20
>         if (plat->typec.role_sw)
>                 usb_role_switch_put(plat->typec.role_sw);
> --=20
> 2.30.2
>
