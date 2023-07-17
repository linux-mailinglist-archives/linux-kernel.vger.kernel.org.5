Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A517566D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGQOv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGQOvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:51:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508BFE52;
        Mon, 17 Jul 2023 07:51:24 -0700 (PDT)
Received: from ideasonboard.com (mob-5-90-54-150.net.vodafone.it [5.90.54.150])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CB21A2F5E;
        Mon, 17 Jul 2023 16:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689605430;
        bh=gzMkpzn7XxfhugzHe6TXhR0p+PPeqQz9c6km36jn8XA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qh7Cf37f2zUMAbUKl5R8yo575eGO9xgQWrwR1tml8tzxjaSkY6PXJ1+7JI1xJ9slw
         iBMU2sUmFzMMkMohF9UZ5CqVDBEnf6+hh3eB25Zb9CAuKVrHUkR9ErwgWoKfsy6q77
         Ys7RmqJ4U2gkaaQHn+f7dNh6WTHOHACDKezLx5xg=
Date:   Mon, 17 Jul 2023 16:51:19 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/3] media: subdev: Drop implicit zeroing of stream field
Message-ID: <xxq4vswnbyw6cchsmootkbruhr67ubchtlfd5xlmhddanx3pl4@qsh6ptjqak24>
References: <20230619112707.239565-1-tomi.valkeinen@ideasonboard.com>
 <rzjtzsvk5q5oobh3khtjopn6ssqyf6akw2z3rswihfec3s3syw@xwjamnaqhplh>
 <043ce183-921c-b411-82ba-889a6854fd4e@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <043ce183-921c-b411-82ba-889a6854fd4e@ideasonboard.com>
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

On Mon, Jul 17, 2023 at 05:39:21PM +0300, Tomi Valkeinen wrote:
> On 17/07/2023 17:11, Jacopo Mondi wrote:
> > Hi Tomi
> >
> > On Mon, Jun 19, 2023 at 02:27:05PM +0300, Tomi Valkeinen wrote:
> > > Now that the kernel drivers have been fixed to initialize the stream
> > > field, and we have the client capability which the userspace uses to say
> >
> > Not sure I got this. Isn't the capabilities flag intended for drivers
> > to tell userspace it support streams ? This seems to suggest it is
> > userspace setting it ?
>
> Client capabilities tell the capabilities of the client. It's the new
> VIDIOC_SUBDEV_S_CLIENT_CAP/VIDIOC_SUBDEV_G_CLIENT_CAP ioctl.
>
> > > it has initialized the stream field, we can drop the implicit zeroing of
> > > the stream field in the various check functions.
> > >
> >
> > I guess this is safe, but I'm not sure why it wasn't before. If a
> > driver doesn't support streams (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
> > then it should have ignored the 'stream' field even if it wasn't
> > zeroed. So I suspect I am missing the reason for zeroing in first
> > place...
>
> The code being removed here was a quick fix. The issue was that before we
> had the client capability flag for "userspace supports streams", the
> 'stream' field could contain garbage. Also some kernel drivers were not
> properly initializing struct v4l2_subdev_format to zero, so again the
> 'stream' field could contain garbage.
>
> The code removed here made sure that if a non-streams-supporting device was
> used, the 'stream' field would be zero as expected, and the v4l2 framework
> would not get confused by seeing a non-zero stream. The non-streams-enabled
> drivers themselves would not use the field anyway, of course, but the
> framework has code that expects the 'stream' to be zero (e.g. check_state()
> checks that stream == 0 if the device hasn't set V4L2_SUBDEV_FL_STREAMS).
>
> Now the kernel drivers have been fixed to initialize the struct properly,
> and we have the VIDIOC_SUBDEV_S_CLIENT_CAP to handle the userspace part.
> Thus this code is no longer needed, and, I think, just might confused the
> reader.
>
> And, in fact, I think it might hide an error. If a subdev is used that does
> not support streams, but the userspace supports streams. If the userspace
> uses an ioctl with stream != 0 for that subdev, it's clearly an error.
> However, with the code removed here, the error would go unnoticed as the
> kernel clears the stream field.
>

Thanks for the clarifications! I admit I missed VIDIOC_SUBDEV_S_CLIENT_CAP!

Now it makes sense
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j

>  Tomi
>
> > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > > ---
> > >   drivers/media/v4l2-core/v4l2-subdev.c | 15 ---------------
> > >   1 file changed, 15 deletions(-)
> > >
> > > diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> > > index 2ec179cd1264..c1ac6d7a63d2 100644
> > > --- a/drivers/media/v4l2-core/v4l2-subdev.c
> > > +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> > > @@ -200,9 +200,6 @@ static inline int check_format(struct v4l2_subdev *sd,
> > >   	if (!format)
> > >   		return -EINVAL;
> > >
> > > -	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
> > > -		format->stream = 0;
> > > -
> > >   	return check_which(format->which) ? : check_pad(sd, format->pad) ? :
> > >   	       check_state(sd, state, format->which, format->pad, format->stream);
> > >   }
> > > @@ -230,9 +227,6 @@ static int call_enum_mbus_code(struct v4l2_subdev *sd,
> > >   	if (!code)
> > >   		return -EINVAL;
> > >
> > > -	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
> > > -		code->stream = 0;
> > > -
> > >   	return check_which(code->which) ? : check_pad(sd, code->pad) ? :
> > >   	       check_state(sd, state, code->which, code->pad, code->stream) ? :
> > >   	       sd->ops->pad->enum_mbus_code(sd, state, code);
> > > @@ -245,9 +239,6 @@ static int call_enum_frame_size(struct v4l2_subdev *sd,
> > >   	if (!fse)
> > >   		return -EINVAL;
> > >
> > > -	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
> > > -		fse->stream = 0;
> > > -
> > >   	return check_which(fse->which) ? : check_pad(sd, fse->pad) ? :
> > >   	       check_state(sd, state, fse->which, fse->pad, fse->stream) ? :
> > >   	       sd->ops->pad->enum_frame_size(sd, state, fse);
> > > @@ -283,9 +274,6 @@ static int call_enum_frame_interval(struct v4l2_subdev *sd,
> > >   	if (!fie)
> > >   		return -EINVAL;
> > >
> > > -	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
> > > -		fie->stream = 0;
> > > -
> > >   	return check_which(fie->which) ? : check_pad(sd, fie->pad) ? :
> > >   	       check_state(sd, state, fie->which, fie->pad, fie->stream) ? :
> > >   	       sd->ops->pad->enum_frame_interval(sd, state, fie);
> > > @@ -298,9 +286,6 @@ static inline int check_selection(struct v4l2_subdev *sd,
> > >   	if (!sel)
> > >   		return -EINVAL;
> > >
> > > -	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
> > > -		sel->stream = 0;
> > > -
> > >   	return check_which(sel->which) ? : check_pad(sd, sel->pad) ? :
> > >   	       check_state(sd, state, sel->which, sel->pad, sel->stream);
> > >   }
> > > --
> > > 2.34.1
> > >
>
