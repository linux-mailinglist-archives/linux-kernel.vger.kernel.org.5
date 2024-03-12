Return-Path: <linux-kernel+bounces-100553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF64879982
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C80A2849F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8A7137C3B;
	Tue, 12 Mar 2024 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxoRalM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D829D137937;
	Tue, 12 Mar 2024 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262790; cv=none; b=FFDGZDj2uop6FdVq8+xUJyoRnSQl8Y8nACuwM4Xmuh3R3MJ0W7bECmz4s7em1A/mqtbPNivZ0YltcKkVmOny7Bd/OEFDtKmGk7jBo0Sueu+PX/h/2qzxIekRLLw8JfHcBtMg6XQOV1FhIILOAlRN4L4oPOE1oIdheL4bTZWfrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262790; c=relaxed/simple;
	bh=FSXZZfDNrd7UxykRlFzm59PWeSEaNKZ1Vv92FRdyvbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ9bxRgaaJbPnS3xUDBMabz3zFg2oIzgfNeFgWrHBz1S8NFplu9Cw/jTc9MlUrH8oojfddRp1uCfOORFQq7EX8t3YyjOUf4i+Xm6uHKCV2mwJh1MwY9qblAZbIaLtVqkD63+yLfbLqQP5spLioDh74CgPdn55vTH761LoUI6kIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxoRalM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6565BC433F1;
	Tue, 12 Mar 2024 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710262790;
	bh=FSXZZfDNrd7UxykRlFzm59PWeSEaNKZ1Vv92FRdyvbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxoRalM4CEDvFeUEfC+bcww4xWbVK/OEUIkpGV3walVZXYmVRDvxLSpkwNMXpv24M
	 hxtsYbP9eiWdngP109yto1HIFUlA8W7VJQq792SuiCsmLMBNIw+0m5C1vfzae5PtIl
	 nNZxLQZz3W+1GVimGGxISe5Ftwf9gNrZ7pu2l/ID6uo9e574LGggcBOc6aKPzF5OA5
	 JhQN0fdSDF/yiz25TCm4dqsBuAQxlYO5wWW7VdAxmr2aQ6pObkO/jKIPKgapD786+1
	 hY0XsfomZjHNGdARdQuBoDfKxtNi9MEs9cHf/fksvRmPZaLAwVnHx0k02oEs7Uu/lx
	 MA5jr7ic3xN4w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rk5To-000000005qR-3wEe;
	Tue, 12 Mar 2024 17:59:56 +0100
Date: Tue, 12 Mar 2024 17:59:56 +0100
From: Johan Hovold <johan@kernel.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	dri-devel@lists.freedesktop.org, swboyd@chromium.org,
	quic_jesszhan@quicinc.com, quic_parellan@quicinc.com,
	quic_bjorande@quicinc.com, Rob Clark <robdclark@chromium.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: move link_ready out of HPD event thread
Message-ID: <ZfCKDGq9n9WG3Quj@hovoldconsulting.com>
References: <20240308214532.1404038-1-quic_abhinavk@quicinc.com>
 <ZfApxyVAJMK4bL8O@hovoldconsulting.com>
 <ZfCFsmNv62-KMkA6@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfCFsmNv62-KMkA6@hovoldconsulting.com>

On Tue, Mar 12, 2024 at 05:41:23PM +0100, Johan Hovold wrote:
> On Tue, Mar 12, 2024 at 11:09:11AM +0100, Johan Hovold wrote:
> > On Fri, Mar 08, 2024 at 01:45:32PM -0800, Abhinav Kumar wrote:
> 
> > > @@ -466,6 +466,8 @@ static int dp_display_notify_disconnect(struct device *dev)
> > >  {
> > >  	struct dp_display_private *dp = dev_get_dp_display_private(dev);
> > >  
> > > +	dp->dp_display.link_ready = false;
> > 
> > As I also pointed out in the other thread, setting link_ready to false
> > here means that any spurious connect event (during physical disconnect)
> > will always be processed, something which can currently lead to a leaked
> > runtime pm reference.
> > 
> > Wasting some power is of course preferred over crashing the machine, but
> > please take it into consideration anyway.
> > 
> > Especially if your intention with this patch was to address the resets
> > we saw with sc8280xp which are gone since the HPD notify revert (which
> > fixed the hotplug detect issue that left the bridge in a
> > half-initialised state).
> 
> Heh. This is getting ridiculous. I just tried running with this patch
> and it again breaks hotplug detect in a VT console and in X (where I
> could enable a reconnected external display by running xrandr twice
> before).
> 
> So, please, do not apply this one.

To make things worse, I indeed also hit the reset when disconnecting
after such a failed hotplug.

Johan

