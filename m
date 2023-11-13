Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D307EA111
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjKMQPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjKMQPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:15:14 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9451732;
        Mon, 13 Nov 2023 08:15:09 -0800 (PST)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2FDC629A;
        Mon, 13 Nov 2023 17:14:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699892083;
        bh=jbwW8U517Pub9rnbNDGmI79ycJWQYPSXd+6TbJGS91s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Co6IIJXHCPZQ0uaKQzupmlli97jx8F7SdewXYugfOeVWTiVCChPBIhvWLQy3slJ9e
         7qj8XCZSoYDRPiiMaVvqtr4aZdr6Te9PeWveBPW1T/QRhi1Saef3e9NxqZWeR1tODG
         HNwbDZSWNbStofhszYmMRADeofnPEOzjpwax9C94=
Date:   Mon, 13 Nov 2023 17:15:05 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        stable@vger.kernel.org,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: st-mipid02: correct format propagation
Message-ID: <gcj7tu5kj7v53lm5iz4i22zk4ab7umqeftrdz37lx2xoheingi@s3c23byizc5t>
References: <20231113145731.89796-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231113145731.89796-1-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alain

On Mon, Nov 13, 2023 at 03:57:30PM +0100, Alain Volmat wrote:
> Use a copy of the struct v4l2_subdev_format when propagating
> format from the sink to source pad in order to avoid impacting the
> sink format returned to the application.
>
> Thanks to Jacopo Mondi for pointing the issue.
>

;)

> Fixes: 6c01e6f3f27b ("media: st-mipid02: Propagate format from sink to source pad")
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/media/i2c/st-mipid02.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
> index fa27638edc07..dab14787116b 100644
> --- a/drivers/media/i2c/st-mipid02.c
> +++ b/drivers/media/i2c/st-mipid02.c
> @@ -770,6 +770,7 @@ static void mipid02_set_fmt_sink(struct v4l2_subdev *sd,
>  				 struct v4l2_subdev_format *format)
>  {
>  	struct mipid02_dev *bridge = to_mipid02_dev(sd);
> +	struct v4l2_subdev_format source_fmt;
>  	struct v4l2_mbus_framefmt *fmt;
>
>  	format->format.code = get_fmt_code(format->format.code);
> @@ -781,8 +782,12 @@ static void mipid02_set_fmt_sink(struct v4l2_subdev *sd,
>
>  	*fmt = format->format;
>
> -	/* Propagate the format change to the source pad */
> -	mipid02_set_fmt_source(sd, sd_state, format);
> +	/*
> +	 * Propagate the format change to the source pad, taking
> +	 * care not to update the format pointer given back to user
> +	 */
> +	source_fmt = *format;
> +	mipid02_set_fmt_source(sd, sd_state, &source_fmt);

Looks good!
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j

>  }
>
>  static int mipid02_set_fmt(struct v4l2_subdev *sd,
> --
> 2.25.1
>
