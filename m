Return-Path: <linux-kernel+bounces-111605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC50886E72
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6F61F225D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1C847A74;
	Fri, 22 Mar 2024 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9C1X74a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A5481D1;
	Fri, 22 Mar 2024 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117496; cv=none; b=JcVDK/iimSHb7LHmyWOfxQxot6NDER+mLPIKPVlDiSo08rjyyAvLPpnkuyT5PhGaZiWWLfCuUFv5JH4vS52pP8rZJDzSzjfU6nuQZGzcj/d1ESXRdSDQNfuLLQ/4yxy8BGNrEWx9SCaMnMNFMrvLZ5JHclxmGfiIdrCICbKoKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117496; c=relaxed/simple;
	bh=RVI/efteQCKqZjTG1IpZpoRWMwJCgqrfbqKi4jhZC4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1q6prOZ+eNJ2fBFMly9NzNQsr3GbzILWi0Bxc33xRkVHF5wqPtFnOYdZVUlMtHwTgP9lPVCtkRpBCdGEYKrUbvCGdYgRI4O+Nq0HActcdtvUATDFRXFH7cUh63OucwRZBC2Gc1HWq+DI61XeP4EVaCKOEK5a6m+DZyg+1Bamhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9C1X74a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEC5C433C7;
	Fri, 22 Mar 2024 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711117496;
	bh=RVI/efteQCKqZjTG1IpZpoRWMwJCgqrfbqKi4jhZC4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9C1X74a1jnG3XpxuajooWGojIDix6bmT6uqBE8l2HkAY9omVA4O1B0byql0SKdyH
	 CYi7jeSkQf46LxgR1Ni0T0njDfeLKT7xiNS3gA/3cdGTKGCdel/QpQJQVI7ZeITY/T
	 TCw3b5WDMwKKCqqSwoAgcF9kMlW0e7JE77y8nv80k2qYxUuWvRffrtI2EoaSJBWKpy
	 UBpTPQohevNnSMe9JV+y1Isxz+8TjQCDi+uY05tQ+wtO1KCYBP0nQ8Xp4t7aO1LI0/
	 6Iq4d3j/s4EMcrA3RgzpLv1icIZZFUVxdgMvffPcfwtVNw6BLtFLnHk8e3rdHIXAKm
	 nzpFs27W6mSdQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rnfpQ-000000001yB-3TGf;
	Fri, 22 Mar 2024 15:25:05 +0100
Date: Fri, 22 Mar 2024 15:25:04 +0100
From: Johan Hovold <johan@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] drm/msm/dp: Add support for determining the
 eDP/DP mode from DT
Message-ID: <Zf2UwOGU2N7BfTTw@hovoldconsulting.com>
References: <20240322-x1e80100-display-refactor-connector-v3-0-af14c29af665@linaro.org>
 <20240322-x1e80100-display-refactor-connector-v3-1-af14c29af665@linaro.org>
 <CAA8EJpp6V5qVzbYtnU=JjO8FX45fcxBvWsD3PWQ5bu5wuv-T=g@mail.gmail.com>
 <Zf2JYmm3DEaR8vB5@linaro.org>
 <CAA8EJppT2VAXMxAbMztbi=-QZj8nP++_Zy4RQHkY-DrO5W_3EQ@mail.gmail.com>
 <Zf2Se84QnWccpiM/@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf2Se84QnWccpiM/@linaro.org>

On Fri, Mar 22, 2024 at 04:15:23PM +0200, Abel Vesa wrote:
> On 24-03-22 15:38:03, Dmitry Baryshkov wrote:
> > On Fri, 22 Mar 2024 at 15:36, Abel Vesa <abel.vesa@linaro.org> wrote:
> > > On 24-03-22 15:30:54, Dmitry Baryshkov wrote:
> > > > On Fri, 22 Mar 2024 at 15:22, Abel Vesa <abel.vesa@linaro.org> wrote:

> > > > > +static int dp_display_get_connector_type(struct platform_device *pdev,
> > > > > +                                        const struct msm_dp_desc *desc)
> > > > > +{
> > > > > +       struct device *dev = &pdev->dev;
> > > > > +       struct device_node *aux_bus;
> > > > > +       struct device_node *panel;
> > > > > +       int ret = DRM_MODE_CONNECTOR_DisplayPort;
> > > > > +
> > > > > +       /* legacy platforms specify connector type in match data */
> > > > > +       if (desc->connector_type == DRM_MODE_CONNECTOR_eDP ||
> > > > > +               desc->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
> > > >
> > > > misaligned
> > > >
> > >
> > > Sure, will fix.
> > >
> > > > > +               return desc->connector_type;
> > > >
> > > > Can we drop this part completely?
> > > >
> > >
> > > You mean the whole if clause? How should we handle the legacy approach
> > > then?
> > 
> > Legacy platforms still have the aux-bus/panel. so they should be
> > handled by the check below.
> > 
> 
> Oh, in that case we can drop the connector_type from every desc for all
> platforms.

Guys, please trim your replies!

Johan

