Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFCE7AAC38
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjIVIPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjIVIPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:15:14 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36CE1BCE;
        Fri, 22 Sep 2023 01:14:38 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0FBC58D0;
        Fri, 22 Sep 2023 10:12:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695370375;
        bh=ch/lk1F6pbZLPG1XrXV8h/fBd+ZpHz8XPvtvCBSOp0E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=u9uQvDFvbfQqV1z5FXdTc1uYySe8edRwIN7wofcGn35dDXDkJYBSfdsKoPl582yKJ
         QzQ34VyYqGHdDF/xHhleaU9yQF82Xl7ET/YWoVNedltCHDTmtQxjm86xB+Js2xomnT
         NMuhP2PLKaUhG2bEdKl+AQfnbbjDp8XzLyZCvv24=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230922080421.35145-3-wsa+renesas@sang-engineering.com>
References: <20230922080421.35145-1-wsa+renesas@sang-engineering.com> <20230922080421.35145-3-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 2/3] media: i2c: drop check because i2c_unregister_device() is NULL safe
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?utf-8?q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Date:   Fri, 22 Sep 2023 09:14:30 +0100
Message-ID: <169537047013.2915094.9440302098198891842@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Quoting Wolfram Sang (2023-09-22 09:04:19)
> No need to check the argument of i2c_unregister_device() because the
> function itself does it.

Well spotted!

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Build tested only. Please apply to your tree.
>=20
>  drivers/media/i2c/rdacm20.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
> index f4e2e2f3972a..b4647bda8c21 100644
> --- a/drivers/media/i2c/rdacm20.c
> +++ b/drivers/media/i2c/rdacm20.c
> @@ -625,8 +625,7 @@ static int rdacm20_probe(struct i2c_client *client)
>         v4l2_ctrl_handler_free(&dev->ctrls);
>  error:
>         media_entity_cleanup(&dev->sd.entity);
> -       if (dev->sensor)
> -               i2c_unregister_device(dev->sensor);
> +       i2c_unregister_device(dev->sensor);
> =20
>         dev_err(&client->dev, "probe failed\n");
> =20
> --=20
> 2.30.2
>
