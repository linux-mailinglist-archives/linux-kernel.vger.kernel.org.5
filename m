Return-Path: <linux-kernel+bounces-76100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0626185F2E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B86283BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB1C1B5A0;
	Thu, 22 Feb 2024 08:28:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89BC17F3;
	Thu, 22 Feb 2024 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590529; cv=none; b=X4PZJWVpMdLC1y7S0YzTdHjUEVoyqrl4GD2JquKIUslkkUpXqg6IwxrNAQ8hoKZwE6yZEIg3Jtu9N/mViiXd0xEOxQfPlaQL7YSF3Dfyjm8Xjlr6ct0OSN7FXaU8qYOLrNBF3hleTIrtUOoc4w2nEVzUC2WNcM4icH9cfmNlFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590529; c=relaxed/simple;
	bh=TS189Amvyy2CvqLVwG3evt8PDz3DhxOZrY0WmQ8O+TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdueeDKrIEB4IYwVPcoIoALwEq1U9yaW+4n15dnAxqLhAm3MSGY8t9U12j80oQ/hs2AIBRTVCK716bNcavC3Kv9ecmJKu0ky8ct+l9gmXnvLrkbp7UWOHMtOpIuTUTh2ghDtVWdQTquPUQzouODQUHr5KdFGtQQDktBpMoXzsa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F4561007;
	Thu, 22 Feb 2024 00:29:24 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53D6A3F762;
	Thu, 22 Feb 2024 00:28:44 -0800 (PST)
Date: Thu, 22 Feb 2024 08:28:41 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, souvik.chakravarty@arm.com,
	Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 6/7] clk: scmi: Allocate CLK operations dynamically
Message-ID: <ZdcFuV0KQDXTH8L8@pluto>
References: <20240214183006.3403207-1-cristian.marussi@arm.com>
 <20240214183006.3403207-7-cristian.marussi@arm.com>
 <500e265eb7c6a03a40e0067c8806e059.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500e265eb7c6a03a40e0067c8806e059.sboyd@kernel.org>

On Wed, Feb 21, 2024 at 09:44:14PM -0800, Stephen Boyd wrote:
> Quoting Cristian Marussi (2024-02-14 10:30:05)
> > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> > index 5747b6d651f0..b91a0dbd2fe0 100644
> > --- a/drivers/clk/clk-scmi.c
> > +++ b/drivers/clk/clk-scmi.c
> > @@ -158,51 +158,6 @@ static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
> >         return !!enabled;
> >  }
> >  

Hi Stephen,

thanks for having a look.

> > -/*
> > - * We can provide enable/disable/is_enabled atomic callbacks only if the
> > - * underlying SCMI transport for an SCMI instance is configured to handle
> > - * SCMI commands in an atomic manner.
> > - *
> > - * When no SCMI atomic transport support is available we instead provide only
> > - * the prepare/unprepare API, as allowed by the clock framework when atomic
> > - * calls are not available.
> > - *
> > - * Two distinct sets of clk_ops are provided since we could have multiple SCMI
> > - * instances with different underlying transport quality, so they cannot be
> > - * shared.
> > - */
> > -static const struct clk_ops scmi_clk_ops = {
> > -       .recalc_rate = scmi_clk_recalc_rate,
> > -       .round_rate = scmi_clk_round_rate,
> > -       .set_rate = scmi_clk_set_rate,
> > -       .prepare = scmi_clk_enable,
> > -       .unprepare = scmi_clk_disable,
> > -       .set_parent = scmi_clk_set_parent,
> > -       .get_parent = scmi_clk_get_parent,
> > -       .determine_rate = scmi_clk_determine_rate,
> > -};
> > -
> > -static const struct clk_ops scmi_atomic_clk_ops = {
> 
> It's not great to move these function pointer structs out of RO memory
> to RW. I'm also not convinced that it's any better to construct them at
> runtime. Isn't there a constant set of possible clk configurations? Or
> why can't we simply add some failures to the clk_ops functions instead?

Well, the real clock devices managed by the SCMI server can be a of
varying nature and so the minimum set of possible clk configurations
to cover will amount to all the possible combinations of supported ops
regarding the specific clock properties (i.e. .set_parent / .set_rate /
enable / .get/set_duty_cycle / atomic_capability ... for now)...we
simply cannot know in advance what the backend SCMI server is handling.

These seemed to me too much in number (and growing) to be pre-allocated
in all possible combinations. (and mostly wasted since you dont really
probably use all combinations all the time)

Moreover, SCMI latest spec now exposes some clock properties (or not) to
be able avoid even sending an actual SCMI message that we know will be
denied all the time; one option is that we return an error,, as you said,
but what is the point (I thought) to provide at all a clk-callback that
we know upfront will fail to be executed every time ? (and some consumer
drivers have been reported by partners not to be happy with these errors)

What I think could be optimized here instead, and I will try in the next
respin, it is that now I am allocating one set of custom ops for each clock
at the end, even if exactly the same ops are provided since the clock
capabilities are the same; I could instead allocate dynamically and fill only
one single set of ops for each distinct set of combinations, so as to avoid
useless duplication and use only the miminum strict amount of RW memory
needed.

Thanks,
Cristian

