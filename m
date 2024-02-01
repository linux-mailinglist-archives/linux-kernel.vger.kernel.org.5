Return-Path: <linux-kernel+bounces-49008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A7984649D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B96D28C30C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E61947F78;
	Thu,  1 Feb 2024 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5EBWuJA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4724547F59;
	Thu,  1 Feb 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706831509; cv=none; b=bX6nH0Ib01G4QJ5Cv9yG9jc4pd7tI5I7SgEK9BpW7KobpjJjRpihgYS3yjllizYD2dUbNN3dZ8OrfDgZiR7TMI9y3kjgVLgUdV72mTwdbfMEhYq2IAu8C3mBosRtQmH9qlGMO0eAquosuhNH/qLrtgZ4N5MRkHBf9dKU8sTM73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706831509; c=relaxed/simple;
	bh=FOHcufONbN0/pF2GMlGqhXYPYixKrUUq72o/McpHSq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRV8y874F6DWGAB9DEH228FpY/4XwUEVWTkfNPYPeb0E77KSsz4R7Bn2auauT33lmOCYipWXAjVw1gJ50QzkhXUN7GXZbixg7ZfA2yL7vPJJSj32NZ5rnKnDTTIEpOjHjiby18RgoYkN6FBFq8dH/MH0I0uWdcf2I/4Jsh+Zu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5EBWuJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DBEC433C7;
	Thu,  1 Feb 2024 23:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706831508;
	bh=FOHcufONbN0/pF2GMlGqhXYPYixKrUUq72o/McpHSq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5EBWuJAP/b8dmyCSFJx8XNPEJ5E1M8Dp1GohRlEGSI8SE1/pNUNHLxByQS83YTZp
	 +kTMEBxol1rAQCSE17sCAq+awsWMGpeaDR22rbUWqjevvacu9rtP/dqQbK4c2WAlck
	 /DIMSq2Q1PowNjSf4B0a4Lz6ZnwyJ7sgh+MPmabnDX89axYwtvdWdbtVqUqkNQMBsO
	 4rcJmUTLRz6TjSkVc6KS+oRPiGxp/CycgheXgB3YnOGMo96KTOgRI531EHSZLPwmzt
	 0WUMDoJSDuCHrb3fFel0qo8oZ1fsVssVEgkGDO2djNy9oUkvYklOLAHbuABdumDvlh
	 +YVdi/wSh/09g==
Date: Thu, 1 Feb 2024 17:51:45 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: Re: [PATCH v4 1/5] PM: domains: Allow devices attached to genpd
 to be managed by HW
Message-ID: <l7icfezpajren25545n4cjtqehhividt5b2dxnxgetdsshc3k3@tdws423qdblk>
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
 <20240122-gdsc-hwctrl-v4-1-9061e8a7aa07@linaro.org>
 <tax3c6o5qjegy6tv3zbgrd5rencfvypr3zg7twxfrmdngscp74@n44ei3q63g64>
 <CAPDyKFpdtrWbzNksLoY++aOY7Ltyt1HhtLZo8bj8sQ05-4Sq0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpdtrWbzNksLoY++aOY7Ltyt1HhtLZo8bj8sQ05-4Sq0g@mail.gmail.com>

On Wed, Jan 31, 2024 at 01:12:00PM +0100, Ulf Hansson wrote:
> On Wed, 31 Jan 2024 at 02:09, Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Mon, Jan 22, 2024 at 10:47:01AM +0200, Abel Vesa wrote:
> > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > >
> > > Some power-domains may be capable of relying on the HW to control the power
> > > for a device that's hooked up to it. Typically, for these kinds of
> > > configurations the consumer driver should be able to change the behavior of
> > > power domain at runtime, control the power domain in SW mode for certain
> > > configurations and handover the control to HW mode for other usecases.
> > >
> > > To allow a consumer driver to change the behaviour of the PM domain for its
> > > device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
> > > let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
> > > which the genpd provider should implement if it can support switching
> > > between HW controlled mode and SW controlled mode. Similarly, add the
> > > dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
> > > its corresponding optional genpd callback, ->get_hwmode_dev(), which the
> > > genpd provider can also implement for reading back the mode from the
> > > hardware.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  drivers/pmdomain/core.c   | 69 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/pm_domain.h | 17 ++++++++++++
> > >  2 files changed, 86 insertions(+)
> > >
> > > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > > index a1f6cba3ae6c..41b6411d0ef5 100644
> > > --- a/drivers/pmdomain/core.c
> > > +++ b/drivers/pmdomain/core.c
> > > @@ -548,6 +548,75 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
> > >
> > > +/**
> > > + * dev_pm_genpd_set_hwmode - Set the HW mode for the device and its PM domain.
> >
> > This isn't proper kernel-doc
> 
> Sorry, I didn't quite get that. What is wrong?
> 

https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
says that there should be () after the function name, and below there
should be a Return:

> >
> > > + *
> > > + * @dev: Device for which the HW-mode should be changed.
> > > + * @enable: Value to set or unset the HW-mode.
> > > + *
> > > + * Some PM domains can rely on HW signals to control the power for a device. To
> > > + * allow a consumer driver to switch the behaviour for its device in runtime,
> > > + * which may be beneficial from a latency or energy point of view, this function
> > > + * may be called.
> > > + *
> > > + * It is assumed that the users guarantee that the genpd wouldn't be detached
> > > + * while this routine is getting called.
> > > + *
> > > + * Returns 0 on success and negative error values on failures.
> > > + */
> > > +int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
> > > +{
> > > +     struct generic_pm_domain *genpd;
> > > +     int ret = 0;
> > > +
> > > +     genpd = dev_to_genpd_safe(dev);
> > > +     if (!genpd)
> > > +             return -ENODEV;
> > > +
> > > +     if (!genpd->set_hwmode_dev)
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     genpd_lock(genpd);
> > > +
> > > +     if (dev_gpd_data(dev)->hw_mode == enable)
> >
> > Between this and the gdsc patch, the hw_mode state might not match the
> > hardware state at boot.
> >
> > With hw_mode defaulting to false, your first dev_pm_genpd_set_hwmode(,
> > false) will not bring control to SW - which might be fatal.
> 
> Right, good point.
> 
> I think we have two ways to deal with this:
> 1) If the provider is supporting ->get_hwmode_dev(), we can let
> genpd_add_device() invoke it to synchronize the state.

I'd suggest that we skip the optimization for now and just let the
update hit the driver on each call.

> 2) If the provider doesn't support ->get_hwmode_dev() we need to call
> ->set_hwmode_dev() to allow an initial state to be set.
> 
> The question is then, if we need to allow ->get_hwmode_dev() to be
> optional, if the ->set_hwmode_dev() is supported - or if we can
> require it. What's your thoughts around this?
> 

Iiuc this resource can be shared between multiple clients, and we're
in either case returning the shared state. That would mean a client
acting upon the returned value, is subject to races.

I'm therefore inclined to say that we shouldn't have a getter, other
than for debugging purposes, in which case reading the HW-state or
failing would be reasonable outcomes.

Regards,
Bjorn

