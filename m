Return-Path: <linux-kernel+bounces-135812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E4789CBAE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D89281FE5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB42E1448E5;
	Mon,  8 Apr 2024 18:26:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5BE25753;
	Mon,  8 Apr 2024 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712600776; cv=none; b=ooe9sSPMo3isRM2mAIhce26nVIMgjEJekqchEFAmMeR/SIVlD9HhW8eE+fWXGwlEK6Djkv5jd52a+qH3OVdnOaL1w8JPETN+0ceqv0h9V1PR4UQPj9dWNdzjbjiq9GfLEGZkcnDu4SqBlCUCS6KzhQbujcIhEjVGjujxC4foWjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712600776; c=relaxed/simple;
	bh=jR1DyE7GHENtP4Snk86wjLw8PdnxEWutqv9mdaRcxyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jwq9kNlOCQxquPNj3XcbDMbLunZMeBWRtv13NTL9bJr7n+WZBb/JTAUu1ZPupAl14HJ4VTpzukNtHpnCEzPPOVJyuxMal+1mSknmuty1iWKfxcgwEb0nQDnvVF3nhUWkNq+uUSLxmQXpE+0tCpdmNggcnYmz+ryccD6WxW0fgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B44EDDA7;
	Mon,  8 Apr 2024 11:26:44 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55CA43F766;
	Mon,  8 Apr 2024 11:26:12 -0700 (PDT)
Date: Mon, 8 Apr 2024 19:26:09 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, peng.fan@oss.nxp.com,
	michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, souvik.chakravarty@arm.com,
	mturquette@baylibre.com
Subject: Re: [PATCH v2 2/5] clk: scmi: Add support for state control
 restricted clocks
Message-ID: <ZhQ2wRVtKDbenU6q@pluto>
References: <20240325210025.1448717-1-cristian.marussi@arm.com>
 <20240325210025.1448717-3-cristian.marussi@arm.com>
 <90ac6d2dce33e8078db7cb5681fb94d7.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90ac6d2dce33e8078db7cb5681fb94d7.sboyd@kernel.org>

On Sun, Apr 07, 2024 at 09:48:59PM -0700, Stephen Boyd wrote:
> Quoting Cristian Marussi (2024-03-25 14:00:22)
> > Some exposed SCMI Clocks could be marked as non-supporting state changes.
> > Configure a clk_ops descriptor which does not provide the state change
> > callbacks for such clocks when registering with CLK framework.
> > 
> > CC: Michael Turquette <mturquette@baylibre.com>
> > CC: Stephen Boyd <sboyd@kernel.org>
> > CC: linux-clk@vger.kernel.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/clk/clk-scmi.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> > index d5d369b052bd..fc9603988d91 100644
> > --- a/drivers/clk/clk-scmi.c
> > +++ b/drivers/clk/clk-scmi.c
> > @@ -18,6 +18,7 @@
> >  
> >  enum scmi_clk_feats {
> >         SCMI_CLK_ATOMIC_SUPPORTED,
> > +       SCMI_CLK_STATE_CTRL_FORBIDDEN,
> 
> Can it be positive, i.e. SCMI_CLK_STATE_CTRL_SUPPORTED?

Yes of course.

> 
> >         SCMI_CLK_MAX_FEATS
> >  };
> >  
> > @@ -230,15 +231,19 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
> >          * only the prepare/unprepare API, as allowed by the clock framework
> >          * when atomic calls are not available.
> >          */
> > -       if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED)) {
> > -               ops->enable = scmi_clk_atomic_enable;
> > -               ops->disable = scmi_clk_atomic_disable;
> > -               ops->is_enabled = scmi_clk_atomic_is_enabled;
> > -       } else {
> > -               ops->prepare = scmi_clk_enable;
> > -               ops->unprepare = scmi_clk_disable;
> > +       if (!(feats_key & BIT(SCMI_CLK_STATE_CTRL_FORBIDDEN))) {
> > +               if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED)) {
> > +                       ops->enable = scmi_clk_atomic_enable;
> > +                       ops->disable = scmi_clk_atomic_disable;
> > +               } else {
> > +                       ops->prepare = scmi_clk_enable;
> > +                       ops->unprepare = scmi_clk_disable;
> > +               }
> >         }
> >  
> > +       if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED))
> > +               ops->is_enabled = scmi_clk_atomic_is_enabled;
> > +
> >         /* Rate ops */
> >         ops->recalc_rate = scmi_clk_recalc_rate;
> >         ops->round_rate = scmi_clk_round_rate;
> > @@ -288,6 +293,9 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
> >         if (atomic_capable && ci->enable_latency <= atomic_threshold)
> >                 feats_key |= BIT(SCMI_CLK_ATOMIC_SUPPORTED);
> >  
> > +       if (ci->state_ctrl_forbidden)
> 
> Then this is negated.
> 

I will rework accordingly

Thanks,
Cristian

