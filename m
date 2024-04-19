Return-Path: <linux-kernel+bounces-151313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A5C8AACBA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF951C21011
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01997D417;
	Fri, 19 Apr 2024 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KV9ALzHq"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D987BAFF;
	Fri, 19 Apr 2024 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522143; cv=none; b=fkoZNCMDrf/Oomfc+E3oR+RLpdaXmCuRSCBMvVUk1pVrjTy6KdECj/G5tbX7zVwt2hZ3nb7SUhB1+YDB0JzZIcU4ZSivvz/xhBWLqdVkGTGDXNk0PYkV2PDekJD8XSyc1xTuMorrNDPB8l1C2uRVb/P6uyeOthiQ6NJ1ArACueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522143; c=relaxed/simple;
	bh=1LC7ko1xrM12tsKlZ7PDR7y1MoWu+FQYeUApmKp7FzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqC+0oJvcZJoXFTluPl/Gzglk9iTwnvWymEG2Kqofiv/V8U2+Sfl7jDbaghb12upYa9y1LmbQNzfppd++Qy6PWOa80sUyN6kRbeY4+gtEthwT9sDsEm3kNu+hzbSXeZcFa/F1lm1mANzwzSR+7KO+sLDsriBYXUbANx7GRriWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KV9ALzHq; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8B1FA63B;
	Fri, 19 Apr 2024 12:21:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713522091;
	bh=1LC7ko1xrM12tsKlZ7PDR7y1MoWu+FQYeUApmKp7FzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KV9ALzHqZApsCPcCkZxfrPCbvYgB65JF47mLdMsFWwugMrJgl4nbibE58v56Weeta
	 yWZftZweH1dXwpUWNwwFQFMeX0FmnDbQ7+ropzjGHhRausQoobrgx/yenQKlrfaaMV
	 QSdpZezAveqbJ7WwLYT2Wji5hxnXk8mMvXNoACDI=
Date: Fri, 19 Apr 2024 13:22:11 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] media: subdev: Support privacy led in
 v4l2_subdev_enable/disable_streams()
Message-ID: <20240419102211.GA2604@pendragon.ideasonboard.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-7-e5e7a5da7420@ideasonboard.com>
 <20240412182026.GJ31122@pendragon.ideasonboard.com>
 <0894861f-cb52-4c5b-8055-5fa50bea6689@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0894861f-cb52-4c5b-8055-5fa50bea6689@ideasonboard.com>

On Tue, Apr 16, 2024 at 01:34:22PM +0300, Tomi Valkeinen wrote:
> On 12/04/2024 21:20, Laurent Pinchart wrote:
> > Hi Tomi,
> > 
> > Thank you for the patch.
> > 
> > On Wed, Apr 10, 2024 at 03:35:54PM +0300, Tomi Valkeinen wrote:
> >> We support camera privacy leds with the .s_stream, in call_s_stream, but
> > 
> > s/the .s_stream/the .s_stream() operation/
> > 
> >> we don't have that support when the subdevice implements
> >> .enable/disable_streams.
> >>
> >> Add the support by enabling the led when the first stream for a
> >> subdevice is enabled, and disabling the led then the last stream is
> >> disabled.
> > 
> > I wonder if that will always be the correct constraint for all devices,
> > but I suppose we can worry about it later.
> > 
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> >> ---
> >>   drivers/media/v4l2-core/v4l2-subdev.c | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> >> index 20b5a00cbeeb..f44aaa4e1fab 100644
> >> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> >> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> >> @@ -2150,6 +2150,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
> >>   {
> >>   	struct device *dev = sd->entity.graph_obj.mdev->dev;
> >>   	struct v4l2_subdev_state *state;
> >> +	bool already_streaming;
> >>   	u64 found_streams = 0;
> >>   	unsigned int i;
> >>   	int ret;
> >> @@ -2198,6 +2199,8 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
> >>   
> >>   	dev_dbg(dev, "enable streams %u:%#llx\n", pad, streams_mask);
> >>   
> >> +	already_streaming = v4l2_subdev_is_streaming(sd);
> >> +
> >>   	/* Call the .enable_streams() operation. */
> >>   	ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
> >>   			       streams_mask);
> >> @@ -2216,6 +2219,9 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
> >>   			cfg->enabled = true;
> >>   	}
> >>   
> >> +	if (!already_streaming)
> >> +		v4l2_subdev_enable_privacy_led(sd);
> >> +
> >>   done:
> >>   	v4l2_subdev_unlock_state(state);
> >>   
> >> @@ -2340,6 +2346,9 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
> >>   	}
> >>   
> >>   done:
> >> +	if (!v4l2_subdev_is_streaming(sd))
> > 
> > Wouldn't it be more efficient to check this while looping over the
> > stream configs in the loop just above ? Same for
> > v4l2_subdev_enable_streams().
> 
> It would, but it would get a lot messier to manage with "media: subdev: 
> Refactor v4l2_subdev_enable/disable_streams()", and we would also need 
> to support the non-routing case.

True.

> This is usually a loop with a couple of iterations, and only called when 
> enabling or enabling a subdevice, so I'm not really worried about the 
> performance. If it's an issue, it would probably be better to also 
> update the sd->enabled_pads when enabling/disabling a stream.

OK, I can live with that for now.

-- 
Regards,

Laurent Pinchart

