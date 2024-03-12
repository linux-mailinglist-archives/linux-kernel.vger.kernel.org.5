Return-Path: <linux-kernel+bounces-99950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019A0878FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2564C1C20CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1397671B5F;
	Tue, 12 Mar 2024 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArsYcGPK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9DF71B42;
	Tue, 12 Mar 2024 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710232283; cv=none; b=EXwEMxjeMK+Qy7JKJdm5H6j6XBrUMQM1K8IrVWqXeYB+7zBlxu1pOTx3woQJc40L3mO4RygU/dZ0BkrVyl5rxdeWfmWDEx87EgUV1I04RDP3QheMjV95Yuajr9cfxAH26220k9RbpIB13ereFHZ63uLwyQteJy0PUdwisOmD2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710232283; c=relaxed/simple;
	bh=ncyot6GZVlpy2LYZy0ZH/PUatwzNeQz1tW9YE81ui3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2M/xypdRlztkhCqy8CsJmdXDv4+2LdHqqHofXQOlssNTt5J8Be+5cZm4y6WIYS7AdpsDxMoI9HzAsXrEpKhgKY0xq4306yXqZ92C9UpYtry0EFPKMZ301su0TrtdOJhmAQh5+Ic+nzcyR9XhHOAR3kz58qCRQyIByzUPDwvnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArsYcGPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969D2C433C7;
	Tue, 12 Mar 2024 08:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710232282;
	bh=ncyot6GZVlpy2LYZy0ZH/PUatwzNeQz1tW9YE81ui3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArsYcGPK1Nefx4rCHDQ5BLI3uYbqXqHkK96AybpsjZT7FAKKxhDT5Z4mUffTfMlWl
	 Fxzphszn3bX/RXuJCge442ZflprWulEV1qLtYVbEPRhYefNHp+XNT9xHWWlwEFJaFG
	 iJXdp7rBBmI5NFQDh8t925ZE4jpQ79M1rSeuCpL2ErLl7iQb1xHiGyf/Vxmtx7Y6AZ
	 hMqm/DWW+CUhqMrW//3EX1oEBBWHIcBqedYtrWwH8OpP+zp4wIJfwlWS8FLUkMC3Ax
	 IUZt3iMScNzb2t4hH/ddHY2xZUEXdVlh+vBEtayNtjGV5k5c7kGRDKDWK1VKHAdB6e
	 BnZn2hH4i+OoA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rjxXk-000000007Ib-21Kk;
	Tue, 12 Mar 2024 09:31:28 +0100
Date: Tue, 12 Mar 2024 09:31:28 +0100
From: Johan Hovold <johan@kernel.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: drm/msm: DisplayPort hard-reset on hotplug regression in 6.8-rc1
Message-ID: <ZfAS4MOXn_3Nk2OR@hovoldconsulting.com>
References: <Zd3kvD02Qvsh2Sid@hovoldconsulting.com>
 <ZesH21DcfOldRD9g@hovoldconsulting.com>
 <56de6cfb-fe0f-de30-d4d0-03c0fbb0afbb@quicinc.com>
 <ZeyOmJLlBbwnmaJN@hovoldconsulting.com>
 <Ze8Ke_M2xHyPYCu-@hovoldconsulting.com>
 <b1ae6e39-10c3-0ee1-11f4-3436c3e4ec1a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1ae6e39-10c3-0ee1-11f4-3436c3e4ec1a@quicinc.com>

On Mon, Mar 11, 2024 at 09:51:29AM -0700, Abhinav Kumar wrote:
> On 3/11/2024 6:43 AM, Johan Hovold wrote:
> > On Sat, Mar 09, 2024 at 05:30:17PM +0100, Johan Hovold wrote:
> >> On Fri, Mar 08, 2024 at 09:50:17AM -0800, Abhinav Kumar wrote:

> >>> I have posted my analysis with the patch here as a RFC y'day:
> >>>
> >>> https://patchwork.freedesktop.org/patch/581758/

> > I was able to reproduce the reset with some of my debug printks in place
> > after reapplying the reverted hpd notify change so I have an explanation
> > for (one of) the ways we can up in this state now.
> > 
> > This does not match description of the problem in the fix linked to
> > above and I don't think that patch solves the underlying issue even if
> > it may make the race window somewhat smaller. More details below.

> Its the same condition you described below that enable does not go 
> through and we bail out as we are in ST_DISCONNECTED.

It's closely related but clearly not the same as user space is not
involved in the reset I see.
 
> > Turns out there are paths like that and we hit those more often before
> > reverting e467e0bde881 ("drm/msm/dp: use drm_bridge_hpd_notify().
> > 
> > Specifically, when a previous connect attempt did not enable the bridge
> > fully so that it is still in the ST_MAINLINK_READY when we receive a
> > disconnect event, dp_hpd_unplug_handle() will turn of the link clock.
> > 
> > [  204.527625] msm-dp-display ae98000.displayport-controller: dp_bridge_hpd_notify - link_ready = 1, status = 2
> > [  204.531553] msm-dp-display ae98000.displayport-controller: dp_hpd_unplug_handle
> > [  204.533261] msm-dp-display ae98000.displayport-controller: dp_ctrl_off_link
> > 
> > A racing connect event, such as the one I described earlier, can then
> > try to enable the bridge again but dp_bridge_atomic_enable() just bails
> > out early (and leaks a rpm reference) because we're now in
> > ST_DISCONNECTED:
> > 
> > [  204.535773] msm-dp-display ae98000.displayport-controller: dp_bridge_hpd_notify - link_ready = 1, status = 1
> > [  204.536187] [CONNECTOR:35:DP-2] status updated from disconnected to connected
> > [  204.536905] msm-dp-display ae98000.displayport-controller: dp_display_notify_disconnect - would clear link ready (1), state = 0
> > [  204.537821] msm-dp-display ae98000.displayport-controller: dp_bridge_atomic_check - link_ready = 1
> > [  204.538063] msm-dp-display ae98000.displayport-controller: dp_display_send_hpd_notification - hpd = 0, link_ready = 1
> > [  204.542778] msm-dp-display ae98000.displayport-controller: dp_bridge_atomic_enable
> > [  204.586547] msm-dp-display ae98000.displayport-controller: dp_bridge_atomic_enable - state = 0 (rpm leak?)
> > 
> > Clearing link_ready already in dp_display_notify_disconnect() would make
> > the race window slightly smaller, but it would essentially just paper
> > over the bug as the events are still not serialised. Notably, there is
> > no user space interaction involved here and it's the spurious connect
> > event that triggers the bridge enable.

> Yes, it only narrows down the race condition window. The issue can still 
> happen if the commit / modeset was issued before we marked link_ready as 
> false.
> 
> And yes, I was only targetting a short term fix till we rework the HPD. 
> That will happen only incrementally as its a delicate piece of code.

Ok, thanks for confirming. Please also make that clear in the commit
message of any patch.

I am however not sure that your patch (RFC) is needed at this point as
the HPD revert fixes the 6.8-rc1 regression, and moving the clearing of
link_ready can actually make things worse as it makes any spurious
hotplug event always be processed (not just if they happen after
dp_display_send_hpd_notification()).

I'll reply to you patch as well.
 
> > So, while it may still be theoretically possible to hit the resets after
> > the revert, the HPD notify revert effectively "fixed" the regression in
> > 6.8-rc1 by removing the preconditions that now made us hit it (i.e. the
> > half-initialised bridge).

> Not entirely. In the bug which was reported before the patch 
> e467e0bde881 ("drm/msm/dp: use drm_bridge_hpd_notify() got landed, its a 
> classic example of how this issue can happen with userspace involvement 
> and not just fbdev client which was your case.

Sure, but you already added some kind of band-aid for that issue, right?

	https://lore.kernel.org/all/1664408211-25314-1-git-send-email-quic_khsieh@quicinc.com/

How likely is it that you'd still hit that? Have you had an reports of
anyone actually hitting that issue since the above workaround was
merged?

Note that I, and other users of the X13s, only started hitting the
resets with 6.8-rc1, which broke hotplug notification and resulted in
the half-initialised bridges.

I'm not saying it's impossible to hit the unclocked access still, just
that that does not seem to be relevant for the regression.
 
> > It seems the hotplug state machine needs to be reworked completely, but
> > at least we're roughly back where we were with 6.7 (including that the
> > bus clocks will never be turned of because of the rpm leaks on
> > disconnect).

> Yes, we already landed that revert but I am also planning to land the 
> patch I had posted till we rework HPD.

Ok, but please consider the implications that would have for any
spurious connect events first.

Johan

