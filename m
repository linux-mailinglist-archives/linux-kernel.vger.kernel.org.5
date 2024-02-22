Return-Path: <linux-kernel+bounces-76277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26F785F516
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585431F26230
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94F038FA0;
	Thu, 22 Feb 2024 09:55:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51BD1799E;
	Thu, 22 Feb 2024 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595731; cv=none; b=MRYZnIeUgVdTqoGCjjFT0Cdzwh+L8Q8L/MRZng5KyXN5sQmUPoVe5Swd+CsaCASusbAupEU/EoTqHxiiCg48bAZWbseeG7b2fXEWjhhYJkCgdQ0vfEtOpwP+hb5t83A5PjjYdEr5RP1UCpfNQZMpGrazBD6q2W0rTevGm8/bUKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595731; c=relaxed/simple;
	bh=zUT+seqiqb4QBcPutc6UO7JPuLUYjnGX3rqt10DwDoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmhEbjDj/pKEWVifCjmLY5UuytXKo7bV/RNLs4bhNKXLwSOOiiBR7lD8jbHFLhmVaW7ldpdplxP5UUN0rDpqVgYuUd1qOpAl6KFq8YSVt3UI5xrNNJKXspUNREuc/6M1gkNrlF2UZpDvOJqHMHGOrSC1/rob54yjGgLj4k+NrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33559C15;
	Thu, 22 Feb 2024 01:56:07 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99F803F766;
	Thu, 22 Feb 2024 01:55:27 -0800 (PST)
Date: Thu, 22 Feb 2024 09:55:25 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, mturquette@baylibre.com,
	sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 2/2] clk: scmi: support state_ctrl_forbidden
Message-ID: <ZdcaDYqWcF2XWoLE@pluto>
References: <20240121110901.1414856-1-peng.fan@oss.nxp.com>
 <20240121110901.1414856-2-peng.fan@oss.nxp.com>
 <20240222094153.2nxvefa44y5ikutm@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222094153.2nxvefa44y5ikutm@bogus>

On Thu, Feb 22, 2024 at 09:41:53AM +0000, Sudeep Holla wrote:
> On Sun, Jan 21, 2024 at 07:09:01PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > Some clocks may exported to linux, while those clocks are not allowed
> > to configure by Linux. For example:
> > 
> > SYS_CLK1-----
> >              \
> > 	     --MUX--->MMC1_CLK
> >              /
> > SYS_CLK2-----
> > 
> > MMC1 needs set parent, so SYS_CLK1 and SYS_CLK2 are exported to Linux,
> > then the clk propagation will touch SYS_CLK1 or SYS_CLK2.
> > So we need bypass the failure for SYS_CLK1 or SYS_CLK2 when enable
> > the clock of MMC1, adding scmi_no_state_ctrl_clk_ops to use software
> > enable counter, while not calling scmi api.
> > 
> > Co-developed-by: Cristian Marussi <cristian.marussi@arm.com>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > 
> > V4:
> >  Add scmi_no_state_ctrl_clk_ops per Cristian
> >  Add Cristian's tag
> > 
> > V3:
> >  Add check in atomic enable
> > 
> > V2:
> >  New. Take Cristian's suggestion
> > 
> >  drivers/clk/clk-scmi.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> > index 8cbe24789c24..5747b6d651f0 100644
> > --- a/drivers/clk/clk-scmi.c
> > +++ b/drivers/clk/clk-scmi.c
> > @@ -194,6 +194,15 @@ static const struct clk_ops scmi_atomic_clk_ops = {
> >  	.determine_rate = scmi_clk_determine_rate,
> >  };
> >  
> > +static const struct clk_ops scmi_no_state_ctrl_clk_ops = {
> > +	.recalc_rate = scmi_clk_recalc_rate,
> > +	.round_rate = scmi_clk_round_rate,
> > +	.set_rate = scmi_clk_set_rate,
> > +	.set_parent = scmi_clk_set_parent,
> > +	.get_parent = scmi_clk_get_parent,
> > +	.determine_rate = scmi_clk_determine_rate,
> > +};
> > +
> >  static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
> >  			     const struct clk_ops *scmi_ops)
> >  {
> > @@ -290,8 +299,10 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
> >  		 * specify (or support) an enable_latency associated with a
> >  		 * clock, we default to use atomic operations mode.
> >  		 */
> > -		if (is_atomic &&
> > -		    sclk->info->enable_latency <= atomic_threshold)
> > +		if (sclk->info->state_ctrl_forbidden)
> > +			scmi_ops = &scmi_no_state_ctrl_clk_ops;
> 
> With this, even if is_atomic and latency matches, we won't allow
> atomic operations ? One reason why it gets tricky and as Cristian 
> mentioned elsewhere we need dynamic assignment of these ops IMO.
> Let me know if I am getting things wrong here ?

It is fine that we wont allow atomic ops either since state_ctrl_forbidden
means the server will reject any enable/disable action, atomic or
not...what I missed here, though, is that we lost also is_enabled indeed,
which could be provided even if state_ctrl_forbidden BUT only if atomic
is supported...so yes this will need an additional atomic/non_atomic
split of this static ops...and so the need for dynamic allocation I was
saying elsewhere....indeed the is_enabled case is handled correctly
again with my pending clk dynamic allocation of ops patch.

My bad, thanks for spotting this Sudeep!
Cristian

