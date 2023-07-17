Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8367F756635
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjGQOTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGQOTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:19:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3871398;
        Mon, 17 Jul 2023 07:19:02 -0700 (PDT)
Received: from ideasonboard.com (mob-5-90-54-150.net.vodafone.it [5.90.54.150])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A353D2F5E;
        Mon, 17 Jul 2023 16:18:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689603488;
        bh=tW5wrM9YsFTrnEVtCnzTgjkk4JqW4DwYkYsrUAcNsQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iq0u0I1Z6Q+aVtA0B4w0WU/UaE9k98Fmt8c/O+TfbUabkn0p1FY/qoeivrhhooy09
         P25fROaSItCluwKbwGdSsgERlz18gDaIelrVdTQJlB+Uf6CLZBbyMCR6RYSOp1IMSW
         YKVVWTYtoHd6ccjlCvtN4WTQrfl4PuVXVX71xeTs=
Date:   Mon, 17 Jul 2023 16:18:56 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Subject: Re: [PATCH 3/3] media: subdev: Add debug prints to
 enable/disable_streams
Message-ID: <6yvjiklxzxnlu6dxbp2pobpwgolomyqeqhuhhqax3kxccqirgr@x5ipfgxsbp6q>
References: <20230619112707.239565-1-tomi.valkeinen@ideasonboard.com>
 <20230619112707.239565-3-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230619112707.239565-3-tomi.valkeinen@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi

On Mon, Jun 19, 2023 at 02:27:07PM +0300, Tomi Valkeinen wrote:
> It is often useful to see when streaming for a device is being enabled
> or disabled. Add debug prints for this to v4l2_subdev_enable_streams()
> and v4l2_subdev_disable_streams().
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 73f716a42569..0f86a165b202 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -1977,11 +1977,16 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  		goto done;
>  	}
>
> +	dev_dbg(dev, "enable streams %u:%#llx\n", pad, streams_mask);

With the use of the # incantation clarified offline:

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>


> +
>  	/* Call the .enable_streams() operation. */
>  	ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
>  			       streams_mask);
> -	if (ret)
> +	if (ret) {
> +		dev_dbg(dev, "enable streams %u:%#llx failed: %d\n", pad,
> +			streams_mask, ret);
>  		goto done;
> +	}
>
>  	/* Mark the streams as enabled. */
>  	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> @@ -2089,11 +2094,16 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>  		goto done;
>  	}
>
> +	dev_dbg(dev, "disable streams %u:%#llx\n", pad, streams_mask);
> +
>  	/* Call the .disable_streams() operation. */
>  	ret = v4l2_subdev_call(sd, pad, disable_streams, state, pad,
>  			       streams_mask);
> -	if (ret)
> +	if (ret) {
> +		dev_dbg(dev, "disable streams %u:%#llx failed: %d\n", pad,
> +			streams_mask, ret);
>  		goto done;
> +	}
>
>  	/* Mark the streams as disabled. */
>  	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> --
> 2.34.1
>
