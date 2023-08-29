Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F46C78C038
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjH2I0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjH2I0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:26:38 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE89118D;
        Tue, 29 Aug 2023 01:26:28 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 33B842B3;
        Tue, 29 Aug 2023 10:25:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693297505;
        bh=GkLtZxBKd6tNduywTWUucqaPaMBBxTSF9iM8hiFHiEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xt5YEJ1beoWI8tslseMTxsEVNrfTEQuJLeZBgnNdi6LSCe7ZNX2SbVshSDZu22zdH
         7p/rZUP63qv+/gOUhzARJYgom30VzDkeWRIGIUvbImmbFOmqAxTdnc34drDSRAndbw
         tcfRkqKA5rOYTRKz/fhWJH7s6q2aJG1Au+pURIIQ=
Date:   Tue, 29 Aug 2023 11:26:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        devicetree@vger.kernel.org,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Dan Scally <dan.scally@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [Linux-stm32] [PATCH v1 3/5] media: stm32-dcmipp: STM32 DCMIPP
 camera interface driver
Message-ID: <20230829082635.GC4698@pendragon.ideasonboard.com>
References: <20220910144010.34272-1-hugues.fruchet@foss.st.com>
 <20220910144010.34272-4-hugues.fruchet@foss.st.com>
 <ZNC5k3PynnEWL/ou@kekkonen.localdomain>
 <20230824110934.GA18226@gnbcxd0016.gnb.st.com>
 <ZOdMghQXfNgKZ6cN@kekkonen.localdomain>
 <20230824130432.GB27092@pendragon.ideasonboard.com>
 <20230824160506.GA21560@gnbcxd0016.gnb.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824160506.GA21560@gnbcxd0016.gnb.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 06:05:06PM +0200, Alain Volmat wrote:
> Hi Laurent,
> 
> On Thu, Aug 24, 2023 at 04:04:32PM +0300, Laurent Pinchart wrote:
> > On Thu, Aug 24, 2023 at 12:26:42PM +0000, Sakari Ailus wrote:
> > > On Thu, Aug 24, 2023 at 01:09:34PM +0200, Alain Volmat wrote:
> > > > Hi Sakari,
> > > > 
> > > > thanks a lot for the review.  I've already taken care of the comments I got
> > > > from Dan and will also add fixes for your comments as well before
> > > > pushing the v2.  Before going into that I thought I'd better clarify the
> > > > framerate part which seems the most tricky part.
> > > > 
> > > > On Mon, Aug 07, 2023 at 09:29:55AM +0000, Sakari Ailus wrote:
> > > 
> > > ...
> > > 
> > > > > > +static int dcmipp_byteproc_g_frame_interval(struct v4l2_subdev *sd,
> > > > > > +					    struct v4l2_subdev_frame_interval *fi)
> > > > > > +{
> > > > > > +	struct dcmipp_byteproc_device *byteproc = v4l2_get_subdevdata(sd);
> > > > > > +
> > > > > > +	if (IS_SINK(fi->pad))
> > > > > > +		fi->interval = byteproc->sink_interval;
> > > > > > +	else
> > > > > > +		fi->interval = byteproc->src_interval;
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int dcmipp_byteproc_s_frame_interval(struct v4l2_subdev *sd,
> > > > > > +					    struct v4l2_subdev_frame_interval *fi)
> > > > > > +{
> > > > > > +	struct dcmipp_byteproc_device *byteproc = v4l2_get_subdevdata(sd);
> > > > > > +
> > > > > > +	mutex_lock(&byteproc->lock);
> > > > > > +
> > > > > > +	if (byteproc->streaming) {
> > > > > > +		mutex_unlock(&byteproc->lock);
> > > > > > +		return -EBUSY;
> > > > > > +	}
> > > > > > +
> > > > > > +	if (fi->interval.numerator == 0 || fi->interval.denominator == 0)
> > > > > > +		fi->interval = byteproc->sink_interval;
> > > > > > +
> > > > > > +	if (IS_SINK(fi->pad)) {
> > > > > > +		/*
> > > > > > +		 * Setting sink frame interval resets frame skipping.
> > > > > > +		 * Sink frame interval is propagated to src.
> > > > > > +		 */
> > > > > > +		byteproc->frate = 0;
> > > > > > +		byteproc->sink_interval = fi->interval;
> > > > > > +		byteproc->src_interval = byteproc->sink_interval;
> > > > > 
> > > > > Is this used for anything else than configure skipping?
> > > > > 
> > > > > I think I'd just have a control for it in that case.
> > > > > 
> > > > > I don't think exposing frame interval configuration is necessarily even
> > > > > meaningful for a device that just processes data but does not produce it.
> > > > 
> > > > The DCMIPP is able to perform frame drop, 1/2, 1/4, 1/8 basically.
> > > > As Dan pointed me out, indeed setting frame interval as we did on both
> > > > sink and source pad isn't a defined behavior.  I first thought that
> > > > using the frame interval was the proper way to do that but that is
> > > > indeed only used on producers such as sensors ....
> > > > Which ctrl would you propose in such case ?
> > > 
> > > We don't have one, AFAIK, and I think it may be unlikely this will be
> > > needed elsewhere. So I'd use a private control.
> > > 
> > > I wonder what others think. Cc Laurent as well.
> > 
> > What are the use cases for this feature ?
> 
> This is basically to allow reducing the framerate of the
> captured stream when this is not possible at the producer
> (sensor) level and we need to lower down the stress on elements down the
> pipeline.

I wonder if the frame interval API is a good fit for this. The driver
accepts frame rates of 1, 2, 4 and 8 fps and maps them to the
corresponding decimation factor, these values are not the actual frame
rate.

-- 
Regards,

Laurent Pinchart
