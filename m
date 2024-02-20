Return-Path: <linux-kernel+bounces-72906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4585BA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8BA1F25FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0190C66B4F;
	Tue, 20 Feb 2024 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5juAYSU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D14664AD;
	Tue, 20 Feb 2024 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428421; cv=none; b=lhgsQ+zt7ACnA2sg0UUcGx6Gw3mS+kTf/XfH1YKmn12+Wy4CH8wi2pqhWaoDKAOdQ79fkg7JBEq2svZQ8/8yEcwYmCaANJ56Xi9VUGnm/PmrnOEBXvKSF3u/H0iTF6sq0/CIOY9kZ4cP8cK46BCGFLK8Z33vz5V38b3Sd/5xYoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428421; c=relaxed/simple;
	bh=VddnBpFylmssPBNR8LxVy9HNAItc6vmZJuhEvw0a1cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkK3ol7fiS83/xXDRbRdozrmkfsDhwVEbvKyypV7dYLxm8fUL6ysXr2yHbEuwFS+iK/9bPmNyp6tYeS7pawsK830H2zUM1jYZUz5IsgyUHOEpGyV4v6RegGaZELjAbDITXx+iQ68p703OQdX8Tuc4tjYuyPxoZXk0bPB1KoDSJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5juAYSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BF5C433C7;
	Tue, 20 Feb 2024 11:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708428420;
	bh=VddnBpFylmssPBNR8LxVy9HNAItc6vmZJuhEvw0a1cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5juAYSUvCxKuNFb30xnBGP17AeDgQUJFn90heG7na3+4GVGkGHv+uzoBqj9ng/t+
	 EFpWosEYzWejLzvTu1Bjvd4u5MAlivbrRnLRMjMfuVHGn0lk6E5xGLqRZs6afOtc8c
	 SYeeknMVdh8Ikld407i7xVPx2i0/h6I2pLkXnOgloW9j9ZrZa/OkqaAfpbGDOZjNpJ
	 726ZtnhyNIwlhqnaH68sGapgpXtajy8uqaA7IHDbJGyFupXqg/fdqFU9YA2D8CGGvs
	 JXtfLbRWHbGtx5EOJuo+kL+Wh1rV5LD7kN3bAl4LuNNiiS6AWwXNixXdTwbJAnTXyp
	 H2SE4ozHo1jxw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rcOH5-000000005Em-1y3j;
	Tue, 20 Feb 2024 12:26:59 +0100
Date: Tue, 20 Feb 2024 12:26:59 +0100
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
	Rob Clark <robdclark@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/6] soc: qcom: pmic_glink_altmode: fix drm bridge
 use-after-free
Message-ID: <ZdSMg63b4ZGYhUXO@hovoldconsulting.com>
References: <20240217150228.5788-4-johan+linaro@kernel.org>
 <9ff4221a-7083-4cb1-abde-1690f655da8d@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ff4221a-7083-4cb1-abde-1690f655da8d@web.de>

On Tue, Feb 20, 2024 at 11:55:57AM +0100, Markus Elfring wrote:
> …
> > Specifically, the dp-hpd bridge is currently registered before all
> > resources have been acquired which means that it can also be
> > deregistered on probe deferrals.
> >
> > In the meantime there is a race window where the new aux bridge driver
> > (or PHY driver previously) may have looked up the dp-hpd bridge and
> > stored a (non-reference-counted) pointer to the bridge which is about to
> > be deallocated.
> …
> > +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> …
> > @@ -454,7 +454,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
> >  		alt_port->index = port;
> >  		INIT_WORK(&alt_port->work, pmic_glink_altmode_worker);
> >
> > -		alt_port->bridge = drm_dp_hpd_bridge_register(dev, to_of_node(fwnode));
> > +		alt_port->bridge = devm_drm_dp_hpd_bridge_alloc(dev, to_of_node(fwnode));
> >  		if (IS_ERR(alt_port->bridge)) {
> >  			fwnode_handle_put(fwnode);
> >  			return PTR_ERR(alt_port->bridge);
> …
> 
> The function call “fwnode_handle_put(fwnode)” is used in multiple if branches.
> https://elixir.bootlin.com/linux/v6.8-rc5/source/drivers/soc/qcom/pmic_glink_altmode.c#L435
> 
> I suggest to add a jump target so that a bit of exception handling
> can be better reused at the end of this function implementation.

Markus, as people have told you repeatedly, just stop with these
comments. You're not helping, in fact, you are actively harmful to the
kernel community as you are wasting people's time.

Johan

