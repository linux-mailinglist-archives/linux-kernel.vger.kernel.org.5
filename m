Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD09076FCCB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjHDJES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHDJDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:03:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AF05BA7;
        Fri,  4 Aug 2023 01:59:59 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5E5CF15E9;
        Fri,  4 Aug 2023 10:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691139532;
        bh=Nf2jOIjmL6GdHJuQQM3P3z1ArTv+j+iXjXc5dsPWDns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1U7XALtdTfiq7Vjsdmmez4zcICb4H8lZwTpo+83Empn+dUodx1mwhifqBmhyl9G2
         vXOCC2i186CYdaeezROBYEDtIAbtQyw371/6ZkqyTv1Dl9senZT3caCednaqNKzzMn
         dIgkVbPiEH67a+4TM4K0qJoN3ecmqmx00rOHbwn4=
Date:   Fri, 4 Aug 2023 12:00:02 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: i2c: ds90ub9x3: Fix use of uninitialized
 variables
Message-ID: <20230804090002.GA12951@pendragon.ideasonboard.com>
References: <20230803-ub9xx-uninit-vars-v1-0-284a5455260f@ideasonboard.com>
 <20230803-ub9xx-uninit-vars-v1-1-284a5455260f@ideasonboard.com>
 <20230803214646.GG27752@pendragon.ideasonboard.com>
 <f2a438ca-73ff-5412-f985-763122dd3651@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2a438ca-73ff-5412-f985-763122dd3651@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 08:49:28AM +0300, Tomi Valkeinen wrote:
> On 04/08/2023 00:46, Laurent Pinchart wrote:
> > Hi Tomi,
> > 
> > Thank you for the patch.
> > 
> > On Thu, Aug 03, 2023 at 11:41:38AM +0300, Tomi Valkeinen wrote:
> >> smatch reports some uninitialized variables:
> >>
> >> drivers/media/i2c/ds90ub913.c:481 ub913_log_status() error: uninitialized symbol 'v1'.
> >> drivers/media/i2c/ds90ub913.c:481 ub913_log_status() error: uninitialized symbol 'v2'.
> >> drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_local_data'.
> >> drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_input_ctrl'.
> >> drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_pin_sts'.
> >>
> >> These are used only for printing debug information, and the use of an
> >> uninitialized variable only happens if an i2c transaction has failed,
> >> which will print an error. Thus, fix the errors just by initializing the
> >> variables to 0.
> >>
> >> Fixes: 6363db1c9d45 ("media: i2c: add DS90UB953 driver")
> >> Fixes: c158d0d4ff15 ("media: i2c: add DS90UB913 driver")
> >> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
> >> Closes: https://lore.kernel.org/all/8d6daeb1-b62a-bbb2-b840-8759c84f2085@xs4all.nl/
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> >> ---
> >>   drivers/media/i2c/ds90ub913.c | 2 +-
> >>   drivers/media/i2c/ds90ub953.c | 6 +++---
> >>   2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/media/i2c/ds90ub913.c b/drivers/media/i2c/ds90ub913.c
> >> index 80d9cf6dd945..b2115e3519e2 100644
> >> --- a/drivers/media/i2c/ds90ub913.c
> >> +++ b/drivers/media/i2c/ds90ub913.c
> >> @@ -469,7 +469,7 @@ static int ub913_log_status(struct v4l2_subdev *sd)
> >>   {
> >>   	struct ub913_data *priv = sd_to_ub913(sd);
> >>   	struct device *dev = &priv->client->dev;
> >> -	u8 v = 0, v1, v2;
> >> +	u8 v = 0, v1 = 0, v2 = 0;
> > 
> > This seems to work around the lack of error checking when calling
> 
> Yes.
> 
> > ub913_read(). Wouldn't it be better to check for errors there ? Or,
> > because this is ub913_log_status(), do you consider that we can print an
> > invalid CRC errors count, given that the ub913_read() function will have
> > printed an error message before ?
> 
> Yes, that was my thinking. Adding proper error handling would complicate 
> the function (more visibly so in ub953 and ub960, which have more 
> printing done), and what would be the benefit? Not much, in my opinion. 
> If the i2c transactions start to fail, we're in a bad situation anyway 
> (and, as you mention, ub913_read() will print errors).
> 
> However, I guess the "benefit" depends on the use a bit. If log status 
> is used as a debug aid, I think my reasoning is fine. But if it's used 
> by some automated script, to collect data, it may be more difficult for 
> the script to detect that an error has happened in the log status.

I see log status as a debugging aid only, so I'm fine with your
reasoning.

> That said, I have to say this ignore-errors code somewhat bugs me, so 
> maybe I'll improve the log-status functions later. But I think these are 
> acceptable fixes to get rid of the smatch errors.

-- 
Regards,

Laurent Pinchart
