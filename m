Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6177AD75A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjIYL7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjIYL7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:59:35 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5082DA;
        Mon, 25 Sep 2023 04:59:28 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 15762DB7;
        Mon, 25 Sep 2023 13:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695643067;
        bh=twXFU1ffd53uD2bBqyPE7sWjRJJ+8MyS9WR6rrTNHBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/a+qnXSK8kJSj+OIGnmL0UnCVjb3NpbpyBUVa4mj5M5WrIEyvma0ONm/3QBTIASJ
         TDQbWJc/MZ89VNzxyERxvI5K17itPsI8PDQF+pA6tBFIYG0hfox6uqYxs2RyDPNcL4
         h6/A/McJlIPiesFz7SlxDx2WFh5kK65nOVZOI25Q=
Date:   Mon, 25 Sep 2023 14:59:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] media: i2c: drop check because
 i2c_unregister_device() is NULL safe
Message-ID: <20230925115938.GB375@pendragon.ideasonboard.com>
References: <20230922080421.35145-1-wsa+renesas@sang-engineering.com>
 <20230922080421.35145-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230922080421.35145-3-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:04:19AM +0200, Wolfram Sang wrote:
> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

I'll take this in my tree and send a pull request if Sakari doesn't pick
up the patch himself.

> ---
> Build tested only. Please apply to your tree.
> 
>  drivers/media/i2c/rdacm20.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
> index f4e2e2f3972a..b4647bda8c21 100644
> --- a/drivers/media/i2c/rdacm20.c
> +++ b/drivers/media/i2c/rdacm20.c
> @@ -625,8 +625,7 @@ static int rdacm20_probe(struct i2c_client *client)
>  	v4l2_ctrl_handler_free(&dev->ctrls);
>  error:
>  	media_entity_cleanup(&dev->sd.entity);
> -	if (dev->sensor)
> -		i2c_unregister_device(dev->sensor);
> +	i2c_unregister_device(dev->sensor);
>  
>  	dev_err(&client->dev, "probe failed\n");
>  

-- 
Regards,

Laurent Pinchart
