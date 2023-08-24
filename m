Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC10E786FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbjHXNEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbjHXNEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:04:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38559E79;
        Thu, 24 Aug 2023 06:04:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C4E7B87F3;
        Thu, 24 Aug 2023 15:03:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692882188;
        bh=lmURSCwOgg+aQoQ721pMBdHJuBeAn08oT40y6zo6TFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nhLxMlpiJQnligF7VzMZbyIZ479Gf5a9oQPN1MQ1JhV7umyyImZPnqz2phU5NPO6R
         zPFdbE6PSH0i6vBC1G24MqZa+ymQNZMdAMc/IXS6mHXp8w7TpO0SQ962ReglrRTc5n
         xRQ3eqs5mNSqKwlsunRR8VMGN+Nt67RSOXOW6ML4=
Date:   Thu, 24 Aug 2023 16:04:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Philippe CORNU <philippe.cornu@foss.st.com>,
        Dan Scally <dan.scally@ideasonboard.com>
Subject: Re: [PATCH v1 3/5] media: stm32-dcmipp: STM32 DCMIPP camera
 interface driver
Message-ID: <20230824130432.GB27092@pendragon.ideasonboard.com>
References: <20220910144010.34272-1-hugues.fruchet@foss.st.com>
 <20220910144010.34272-4-hugues.fruchet@foss.st.com>
 <ZNC5k3PynnEWL/ou@kekkonen.localdomain>
 <20230824110934.GA18226@gnbcxd0016.gnb.st.com>
 <ZOdMghQXfNgKZ6cN@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOdMghQXfNgKZ6cN@kekkonen.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 12:26:42PM +0000, Sakari Ailus wrote:
> On Thu, Aug 24, 2023 at 01:09:34PM +0200, Alain Volmat wrote:
> > Hi Sakari,
> > 
> > thanks a lot for the review.  I've already taken care of the comments I got
> > from Dan and will also add fixes for your comments as well before
> > pushing the v2.  Before going into that I thought I'd better clarify the
> > framerate part which seems the most tricky part.
> > 
> > On Mon, Aug 07, 2023 at 09:29:55AM +0000, Sakari Ailus wrote:
> 
> ...
> 
> > > > +static int dcmipp_byteproc_g_frame_interval(struct v4l2_subdev *sd,
> > > > +					    struct v4l2_subdev_frame_interval *fi)
> > > > +{
> > > > +	struct dcmipp_byteproc_device *byteproc = v4l2_get_subdevdata(sd);
> > > > +
> > > > +	if (IS_SINK(fi->pad))
> > > > +		fi->interval = byteproc->sink_interval;
> > > > +	else
> > > > +		fi->interval = byteproc->src_interval;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int dcmipp_byteproc_s_frame_interval(struct v4l2_subdev *sd,
> > > > +					    struct v4l2_subdev_frame_interval *fi)
> > > > +{
> > > > +	struct dcmipp_byteproc_device *byteproc = v4l2_get_subdevdata(sd);
> > > > +
> > > > +	mutex_lock(&byteproc->lock);
> > > > +
> > > > +	if (byteproc->streaming) {
> > > > +		mutex_unlock(&byteproc->lock);
> > > > +		return -EBUSY;
> > > > +	}
> > > > +
> > > > +	if (fi->interval.numerator == 0 || fi->interval.denominator == 0)
> > > > +		fi->interval = byteproc->sink_interval;
> > > > +
> > > > +	if (IS_SINK(fi->pad)) {
> > > > +		/*
> > > > +		 * Setting sink frame interval resets frame skipping.
> > > > +		 * Sink frame interval is propagated to src.
> > > > +		 */
> > > > +		byteproc->frate = 0;
> > > > +		byteproc->sink_interval = fi->interval;
> > > > +		byteproc->src_interval = byteproc->sink_interval;
> > > 
> > > Is this used for anything else than configure skipping?
> > > 
> > > I think I'd just have a control for it in that case.
> > > 
> > > I don't think exposing frame interval configuration is necessarily even
> > > meaningful for a device that just processes data but does not produce it.
> > 
> > The DCMIPP is able to perform frame drop, 1/2, 1/4, 1/8 basically.
> > As Dan pointed me out, indeed setting frame interval as we did on both
> > sink and source pad isn't a defined behavior.  I first thought that
> > using the frame interval was the proper way to do that but that is
> > indeed only used on producers such as sensors ....
> > Which ctrl would you propose in such case ?
> 
> We don't have one, AFAIK, and I think it may be unlikely this will be
> needed elsewhere. So I'd use a private control.
> 
> I wonder what others think. Cc Laurent as well.

What are the use cases for this feature ?

-- 
Regards,

Laurent Pinchart
