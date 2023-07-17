Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC097565EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjGQOME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjGQOMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:12:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0307138;
        Mon, 17 Jul 2023 07:11:56 -0700 (PDT)
Received: from ideasonboard.com (mob-5-90-54-150.net.vodafone.it [5.90.54.150])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC28F337A;
        Mon, 17 Jul 2023 16:11:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689603062;
        bh=8l7sjCuc/m0acIUfPB6DYxH2Mf8R0n8TyysUiy0vmLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i6qEPi5A37JATinZ3Tw3tRzsCH19RlWBfAWT72MqzdW1LFLNEC8rwqTDZrxXuxG4+
         ZJOa8936/HHlGNC9jLO+rBGWdKO5+oTu+WZni9BtVaWjO/R7Vs6j1Qhi7gjAJ1gM9m
         mRKAIIjfq6X0O5UqPjFd/xOyaUS0/li0BAXbW0HU=
Date:   Mon, 17 Jul 2023 16:11:50 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Subject: Re: [PATCH 1/3] media: subdev: Drop implicit zeroing of stream field
Message-ID: <rzjtzsvk5q5oobh3khtjopn6ssqyf6akw2z3rswihfec3s3syw@xwjamnaqhplh>
References: <20230619112707.239565-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230619112707.239565-1-tomi.valkeinen@ideasonboard.com>
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

On Mon, Jun 19, 2023 at 02:27:05PM +0300, Tomi Valkeinen wrote:
> Now that the kernel drivers have been fixed to initialize the stream
> field, and we have the client capability which the userspace uses to say

Not sure I got this. Isn't the capabilities flag intended for drivers
to tell userspace it support streams ? This seems to suggest it is
userspace setting it ?

> it has initialized the stream field, we can drop the implicit zeroing of
> the stream field in the various check functions.
>

I guess this is safe, but I'm not sure why it wasn't before. If a
driver doesn't support streams (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
then it should have ignored the 'stream' field even if it wasn't
zeroed. So I suspect I am missing the reason for zeroing in first
place...

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 2ec179cd1264..c1ac6d7a63d2 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -200,9 +200,6 @@ static inline int check_format(struct v4l2_subdev *sd,
>  	if (!format)
>  		return -EINVAL;
>
> -	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
> -		format->stream = 0;
> -
>  	return check_which(format->which) ? : check_pad(sd, format->pad) ? :
>  	       check_state(sd, state, format->which, format->pad, format->stream);
>  }
> @@ -230,9 +227,6 @@ static int call_enum_mbus_code(struct v4l2_subdev *sd,
>  	if (!code)
>  		return -EINVAL;
>
> -	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
> -		code->stream = 0;
> -
>  	return check_which(code->which) ? : check_pad(sd, code->pad) ? :
>  	       check_state(sd, state, code->which, code->pad, code->stream) ? :
>  	       sd->ops->pad->enum_mbus_code(sd, state, code);
> @@ -245,9 +239,6 @@ static int call_enum_frame_size(struct v4l2_subdev *sd,
>  	if (!fse)
>  		return -EINVAL;
>
> -	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
> -		fse->stream = 0;
> -
>  	return check_which(fse->which) ? : check_pad(sd, fse->pad) ? :
>  	       check_state(sd, state, fse->which, fse->pad, fse->stream) ? :
>  	       sd->ops->pad->enum_frame_size(sd, state, fse);
> @@ -283,9 +274,6 @@ static int call_enum_frame_interval(struct v4l2_subdev *sd,
>  	if (!fie)
>  		return -EINVAL;
>
> -	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
> -		fie->stream = 0;
> -
>  	return check_which(fie->which) ? : check_pad(sd, fie->pad) ? :
>  	       check_state(sd, state, fie->which, fie->pad, fie->stream) ? :
>  	       sd->ops->pad->enum_frame_interval(sd, state, fie);
> @@ -298,9 +286,6 @@ static inline int check_selection(struct v4l2_subdev *sd,
>  	if (!sel)
>  		return -EINVAL;
>
> -	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
> -		sel->stream = 0;
> -
>  	return check_which(sel->which) ? : check_pad(sd, sel->pad) ? :
>  	       check_state(sd, state, sel->which, sel->pad, sel->stream);
>  }
> --
> 2.34.1
>
