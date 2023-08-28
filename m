Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F74878A6C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjH1Hsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjH1HsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:48:18 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325FB114;
        Mon, 28 Aug 2023 00:48:16 -0700 (PDT)
Received: from ideasonboard.com (mob-5-91-19-240.net.vodafone.it [5.91.19.240])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D98D1E51;
        Mon, 28 Aug 2023 09:46:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693208813;
        bh=ePUh+9FFj0l+5PveCc6ydNu/nAlr4VfwDuWCBVWfhAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XRlET+jAH6tyW5sxN6T/qsGqpTGSXoiYIm/TiQdnGCEfBSBCoQS3zL5VjJSJY9p16
         0QJodWOb2SciAO0uYUy3EhJmPqOm49p1i+i3jrzpIGRIx4ih3D5CywAi+j/fd80n0J
         Dc6jaTDdIeuExITtPupeeymV0EgxipaELnwVms4s=
Date:   Mon, 28 Aug 2023 09:48:10 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: rdacm2: Remove an incorrect
 fwnode_handle_put() call
Message-ID: <zijwh5kcrfsg4q4pmxtkzia7tdpg4wnau53npe2y2xe4j7n7wy@zqwigtmyftu3>
References: <d9230082aefcb7bab6363c51c08598eb5ab62cfc.1693037086.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9230082aefcb7bab6363c51c08598eb5ab62cfc.1693037086.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe

On Sat, Aug 26, 2023 at 10:05:06AM +0200, Christophe JAILLET wrote:
> The commit in Fixes has removed an fwnode_handle_put() call in the error
> handling path of the probe.
>
> Remove the same call from the remove function.
>
> Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

> ---
> /!\   This patch is highly speculative. Review with care.   /!\
>
> If it is correct, it is likely that other similar issue lurk in commit
> 1029939b3782. I've not looked in detail and my cocci script did not
> trigger on them but drivers/media/i2c/max9286.c also looks like a
> similar candidate.

I think the call to  fwnode_handle_put(priv->sd.fwnode) in
max9286_v4l2_unregister() can indeed be removed, yes!

Thanks
  j

> ---
>  drivers/media/i2c/rdacm21.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/media/i2c/rdacm21.c b/drivers/media/i2c/rdacm21.c
> index a36a709243fd..3e22df36354f 100644
> --- a/drivers/media/i2c/rdacm21.c
> +++ b/drivers/media/i2c/rdacm21.c
> @@ -608,7 +608,6 @@ static void rdacm21_remove(struct i2c_client *client)
>  	v4l2_async_unregister_subdev(&dev->sd);
>  	v4l2_ctrl_handler_free(&dev->ctrls);
>  	i2c_unregister_device(dev->isp);
> -	fwnode_handle_put(dev->sd.fwnode);
>  }
>
>  static const struct of_device_id rdacm21_of_ids[] = {
> --
> 2.34.1
>
