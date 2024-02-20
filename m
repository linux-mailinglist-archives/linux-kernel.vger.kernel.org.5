Return-Path: <linux-kernel+bounces-72470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF85985B3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E659B24BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1825B202;
	Tue, 20 Feb 2024 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6WSjOKx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249315A799;
	Tue, 20 Feb 2024 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413899; cv=none; b=YDA7ChZsGcNkQ+zJacCDxkUWMmyNdSdXmVuN0x2HATuaxhiq1B1ucu6vUWpyg50T0o2RHXOnqVnEjx7C8PkVHy/nXG3q6LN8UQcf3/Pqt4ueWsnE6UieN+BQ8bcRbELsgj9/KlnFaiNTKr73AsqQxJtBIrlKTm8lygqUUCP4G68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413899; c=relaxed/simple;
	bh=Km8gZMkJB7vNwcEvKJf3Z5MjG8s2kLrFv7d6SMKvVC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjfVbqr6wXtMvOkl6TZdPCZBmcRRO4r5yaR138+pEB5uDBmu5iB77MdhQ06lIwO9CMqhS2c4HyBiIIbo4I0hR+EZeItdTcNmExZn0bY2EEX8o+OD122UsDvHnEu1EYr0fSTmz2MiOpiNtQvXvt6O7vPq5RAl7tLsY2s+po7H24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6WSjOKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CECC433C7;
	Tue, 20 Feb 2024 07:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708413898;
	bh=Km8gZMkJB7vNwcEvKJf3Z5MjG8s2kLrFv7d6SMKvVC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6WSjOKxHt9TBefi2fivgCw5sGg4pib4PrIDZmtoesOTgo80CtchhROVw3pw0FeqR
	 Pc9MGfrCfAKPZbAgDQVs+NvTqOslO+bcwY0+bPdxSK2Sx7n0x9RIur2VOHGKxXS5q1
	 ZojucTaTTOXH7nqkaDAr7oKNW9keBDciLLBBztXj3jG96Dqy7egDtQFdz8u2Q2iBJt
	 aWy2UUb55Fmr0MdRm5gJysrUBrLO6+m7+7BBeis1O8wXCAb8JBXQ17KOHFtUMJxzgm
	 /zoywKFK7JfGrRP4yu7ts9/D14Ft57GqR0srDYm1N84JAeD8Tp4Vli9+dIMNop2M/1
	 B2HwmHPKoXLyg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rcKUp-0000000024l-2ZkS;
	Tue, 20 Feb 2024 08:24:56 +0100
Date: Tue, 20 Feb 2024 08:24:55 +0100
From: Johan Hovold <johan@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Johan Hovold <johan+linaro@kernel.org>, freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Vinod Koul <vkoul@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 1/6] drm/bridge: aux-hpd: fix OF node leaks
Message-ID: <ZdRTx2lmHBVlcLub@hovoldconsulting.com>
References: <20240217150228.5788-2-johan+linaro@kernel.org>
 <c95f5ff3-8dad-4302-9384-92a9b83f7bdc@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c95f5ff3-8dad-4302-9384-92a9b83f7bdc@web.de>

On Mon, Feb 19, 2024 at 06:48:30PM +0100, Markus Elfring wrote:
> > The two device node references taken during allocation need to be
> > dropped when the auxiliary device is freed.
> …
> > +++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> …
> > @@ -74,6 +75,8 @@ struct device *drm_dp_hpd_bridge_register(struct device *parent,
> >
> >  	ret = auxiliary_device_init(adev);
> >  	if (ret) {
> > +		of_node_put(adev->dev.platform_data);
> > +		of_node_put(adev->dev.of_node);
> >  		ida_free(&drm_aux_hpd_bridge_ida, adev->id);
> >  		kfree(adev);
> >  		return ERR_PTR(ret);
> 
> The last two statements are also used in a previous if branch.
> https://elixir.bootlin.com/linux/v6.8-rc5/source/drivers/gpu/drm/bridge/aux-hpd-bridge.c#L63
> 
> How do you think about to avoid such a bit of duplicate source code
> by adding a label here?

No, the current code is fine and what you are suggesting is in any case
unrelated to this fix.

If this function ever grows a third error path like that, I too would
consider it however.

Johan

