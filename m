Return-Path: <linux-kernel+bounces-100528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4E487992A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4710B22913
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEAE7E570;
	Tue, 12 Mar 2024 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCyyrJVi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94047E114;
	Tue, 12 Mar 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261677; cv=none; b=uy9kadAYKvUZadlJ6M4+sMq60SenBuAYNWhjdP4CEOW0/fQ8e5j/lNoYixOQvdK9HYatmRq7nH0E5KUdTxe7Y7AwaJqt1bfFAFpXOXFUw+CdlCNuv+VycDshLAAqecnCYlhgSNxf+gPd1eVVjXmCW9r9IQqgkKuFPvXxX7IYzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261677; c=relaxed/simple;
	bh=0g9LLPvlH5qpBdQAUmu++557crlx9uckDyhZnn5Qxls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiigUdyI4QuOzoMmBDv1a0vsIkB0HP1g7VhgCHxESa3EOUqEIHr/uRMzpss4rUXyuz4WS1cyeAFTr2ifwfi5pULdPeV4NpWjNTrt+D/QBpHgl6IqVaPrf0Fu6tT+gptOC5tJNfltqtMg2cNYG0jVFmr4IUEl1hwABAD52VyUj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCyyrJVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE3EC433F1;
	Tue, 12 Mar 2024 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710261676;
	bh=0g9LLPvlH5qpBdQAUmu++557crlx9uckDyhZnn5Qxls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCyyrJVi8Gfx4GQpxPp/xOYa4x3L/5rtjT+tWPz/oNwV+8ariPs6A9sEHDdmj1DV+
	 pBmgoR0O1eT9oyW/GOEZBaJj6N2MaF2RlMtTgdBGb/xoHfxC6bjVMD4H9u4DvvU84S
	 hM2T++jhIZ8UkplTr7aH/5Oa8odR3abY9IRzQX9HpeOJfFc67JP7p9fqdLkZMwOzV4
	 6g+Uo2hgDhS/f//VYHB0rO9DFINzDI9uv89grP2I56yU0nGsgRhhOPj350h3LzPpmY
	 uqBCPQS42VJeYxGVGlmF/1nV7JxtSTHIPYVyGE7VU3ttUfNA7ehckv3NBzURj2+QS/
	 Vr4xm7r6P6fIw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rk5Bq-000000005fC-2l0B;
	Tue, 12 Mar 2024 17:41:23 +0100
Date: Tue, 12 Mar 2024 17:41:22 +0100
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
Message-ID: <ZfCFsmNv62-KMkA6@hovoldconsulting.com>
References: <20240308214532.1404038-1-quic_abhinavk@quicinc.com>
 <ZfApxyVAJMK4bL8O@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfApxyVAJMK4bL8O@hovoldconsulting.com>

On Tue, Mar 12, 2024 at 11:09:11AM +0100, Johan Hovold wrote:
> On Fri, Mar 08, 2024 at 01:45:32PM -0800, Abhinav Kumar wrote:

> > @@ -466,6 +466,8 @@ static int dp_display_notify_disconnect(struct device *dev)
> >  {
> >  	struct dp_display_private *dp = dev_get_dp_display_private(dev);
> >  
> > +	dp->dp_display.link_ready = false;
> 
> As I also pointed out in the other thread, setting link_ready to false
> here means that any spurious connect event (during physical disconnect)
> will always be processed, something which can currently lead to a leaked
> runtime pm reference.
> 
> Wasting some power is of course preferred over crashing the machine, but
> please take it into consideration anyway.
> 
> Especially if your intention with this patch was to address the resets
> we saw with sc8280xp which are gone since the HPD notify revert (which
> fixed the hotplug detect issue that left the bridge in a
> half-initialised state).

Heh. This is getting ridiculous. I just tried running with this patch
and it again breaks hotplug detect in a VT console and in X (where I
could enable a reconnected external display by running xrandr twice
before).

So, please, do not apply this one.

Johan

