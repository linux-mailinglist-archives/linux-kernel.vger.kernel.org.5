Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023DA7E5AB6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjKHP6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjKHP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:58:36 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1919C;
        Wed,  8 Nov 2023 07:58:33 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5A103836;
        Wed,  8 Nov 2023 16:58:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699459089;
        bh=izE/Se8rUqOBfxbMWlpwO5GUGwdoyHD9suQzG0SGspw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fss9AgJYrN0+Qayo8mLopZvrPG7jv3/ZA0r6GpZlxZDQLxqz54BK+nYBJfup9SfFN
         waIpiSfLLau0baqb3JRQ6xgSY/Q4GPk6IoFSKwKcKEaKlbzVPjS43lwG6qDVLYjCRI
         uaju3bofxFSpl4YYPPftGEGrQCQ+iQrpcjqhaEjY=
Date:   Wed, 8 Nov 2023 17:58:36 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: Re: [RFC PATCH 03/10] drm/mipi-dsi: add API for manual control over
 the DSI link power state
Message-ID: <20231108155836.GB21616@pendragon.ideasonboard.com>
References: <CAA8EJpp48AdJmx_U=bEJZUWZgOiT1Ctz6Lpe9QwjLXkMQvsw5w@mail.gmail.com>
 <uj6rtlionmacnwlqxy6ejt5iaczgbbe5z54ipte5ffbixcx3p4@pps7fcr3uqhf>
 <1696f131-83fb-4d0c-b4d7-0bdb61e4ae65@linaro.org>
 <mxtb6vymowutj7whbrygwlcupbdnfqxjralc3nwwapsbvrcmbm@sewxtdslfoen>
 <CAA8EJpozZkEswnioKjRCqBg4fcjVHFwGivoFNTNHVwyocKprQw@mail.gmail.com>
 <2z3yvvtd6ttsd7qw43sl5svtfijxevdr6omxxmws64k6l5qv55@5nnh2b32h2ep>
 <2023110704-playback-grit-7a27@gregkh>
 <hkzoi4sazufi5xdgr6hacuzk72cnbtmm6dwm2bzfgwh5yij6wj@2g4eb6ea4dgd>
 <2023110704-deem-jigsaw-0bbf@gregkh>
 <kuzbg4a52onojyfh2cc7h7c4iruzfbbbo2lm2jve72rnrpfk6f@2hars5pwujg3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kuzbg4a52onojyfh2cc7h7c4iruzfbbbo2lm2jve72rnrpfk6f@2hars5pwujg3>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 04:34:39PM +0100, Maxime Ripard wrote:
> On Tue, Nov 07, 2023 at 04:26:34PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Nov 07, 2023 at 01:18:14PM +0100, Maxime Ripard wrote:
> > > On Tue, Nov 07, 2023 at 12:22:21PM +0100, Greg Kroah-Hartman wrote:
> > > > On Tue, Nov 07, 2023 at 11:57:49AM +0100, Maxime Ripard wrote:
> > > > > +GKH
> > > > 
> > > > Why?  I don't see a question for me here, sorry.
> > > 
> > > I guess the question is: we have a bus with various power states
> > > (powered off, low power, high speed)
> > 
> > Great, have fun!  And is this per-device or per-bus-instance?
> 
> Per bus instance

To be precise, those power states are link states. They don't
necessarily translate directly to device power states, and they're not
so much about power management than speed (and bus turn-around for
reads) management.

Also, while DSI allows for multiple peripherals on a bus, the link is
point-to-point, with the peripherals being all behind a single DSI RX.

> > > low power is typically used to send commands to a device, high speed to
> > > transmit pixels, but still allows to send commands.

Low power (LP) is a link state where commands can be transmitted at a
low speed, as opposed to the high speed (HS) link state that is used to
transmit both video data and commands at high speed. Any device-to-host
data transfer (in response to read commands) occurs exclusively in LP
mode (at least with DSI v1.3, I don't have acces to newer
specifications).

> > > Depending on the devices, there's different requirements about the state
> > > devices expect the bus to be in to send commands. Some will need to send
> > > all the commands in the low power state, some don't care, etc. See
> > > the mail I was replying too for more details.
> > > 
> > > We've tried so far to model that in KMS itself, so the framework the
> > > drivers would register too, but we're kind of reaching the limits of
> > > what we can do there. It also feels to me that "the driver can't access
> > > its device" is more of a problem for the bus to solve rather than the
> > > framework.
> > 
> > This is up to the specific bus to resolve, there's nothing special
> > needed in the driver core for it, right?
> 
> Yeah, we weren't really looking to handle this into the driver core, but
> rather if there was a set of guidelines or feedback on implementing
> those kind of features for a bus.
> 
> > > Do you agree? Are you aware of any other bus in Linux with similar
> > > requirements we could look at? Or any suggestion on how to solve it?
> > 
> > There might be others, yes, look at how the dynamic power management
> > works for different devices on most busses, that might help you out
> > here.
> 
> Thanks for the pointers, we'll have a look

-- 
Regards,

Laurent Pinchart
