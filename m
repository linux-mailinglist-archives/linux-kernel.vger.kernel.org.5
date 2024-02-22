Return-Path: <linux-kernel+bounces-76253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AFC85F4C8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E497C286FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B084C41757;
	Thu, 22 Feb 2024 09:42:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE30938DFC;
	Thu, 22 Feb 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594925; cv=none; b=YlzjT7GqGDtOeYnvjSP/NbUNOQvDix04DcqOGmTW2bBE7mYjkwBH6HdpxOSeXHbB2mxr/brPZRtWdOg6jDxCHIQT4UyMOxz0q/AzC0Q7kcYVaohRtiOXnIAnAhOD84nFR3zL0lYVvSvJc+punt6MTjm7Wyl8aEBH5XeaR+TY9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594925; c=relaxed/simple;
	bh=gQQtl2Hk4axXcUVCDJwIcvPOjcQGnTc5qWE0h4CCXR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gd9oth25dVPdt5m1xL81xPgjMBj2Ge2PNO8t2np/iqPgyZVochM1SkBveZ5v40JSQD0JDyxn/fwunkaRQNTwUscgDbhAZZ177jnGHhePRQgc2tBwG/JBIZ7HzvnNlo0zbh1gF0GjDUZIK0Tzxt7eA78ijaQmRdVDyYMCPrEVtCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 251A61477;
	Thu, 22 Feb 2024 01:42:41 -0800 (PST)
Received: from bogus (unknown [10.57.93.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C7223F766;
	Thu, 22 Feb 2024 01:41:59 -0800 (PST)
Date: Thu, 22 Feb 2024 09:41:53 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: cristian.marussi@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 2/2] clk: scmi: support state_ctrl_forbidden
Message-ID: <20240222094153.2nxvefa44y5ikutm@bogus>
References: <20240121110901.1414856-1-peng.fan@oss.nxp.com>
 <20240121110901.1414856-2-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121110901.1414856-2-peng.fan@oss.nxp.com>

On Sun, Jan 21, 2024 at 07:09:01PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Some clocks may exported to linux, while those clocks are not allowed
> to configure by Linux. For example:
> 
> SYS_CLK1-----
>              \
> 	     --MUX--->MMC1_CLK
>              /
> SYS_CLK2-----
> 
> MMC1 needs set parent, so SYS_CLK1 and SYS_CLK2 are exported to Linux,
> then the clk propagation will touch SYS_CLK1 or SYS_CLK2.
> So we need bypass the failure for SYS_CLK1 or SYS_CLK2 when enable
> the clock of MMC1, adding scmi_no_state_ctrl_clk_ops to use software
> enable counter, while not calling scmi api.
> 
> Co-developed-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V4:
>  Add scmi_no_state_ctrl_clk_ops per Cristian
>  Add Cristian's tag
> 
> V3:
>  Add check in atomic enable
> 
> V2:
>  New. Take Cristian's suggestion
> 
>  drivers/clk/clk-scmi.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index 8cbe24789c24..5747b6d651f0 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -194,6 +194,15 @@ static const struct clk_ops scmi_atomic_clk_ops = {
>  	.determine_rate = scmi_clk_determine_rate,
>  };
>  
> +static const struct clk_ops scmi_no_state_ctrl_clk_ops = {
> +	.recalc_rate = scmi_clk_recalc_rate,
> +	.round_rate = scmi_clk_round_rate,
> +	.set_rate = scmi_clk_set_rate,
> +	.set_parent = scmi_clk_set_parent,
> +	.get_parent = scmi_clk_get_parent,
> +	.determine_rate = scmi_clk_determine_rate,
> +};
> +
>  static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
>  			     const struct clk_ops *scmi_ops)
>  {
> @@ -290,8 +299,10 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
>  		 * specify (or support) an enable_latency associated with a
>  		 * clock, we default to use atomic operations mode.
>  		 */
> -		if (is_atomic &&
> -		    sclk->info->enable_latency <= atomic_threshold)
> +		if (sclk->info->state_ctrl_forbidden)
> +			scmi_ops = &scmi_no_state_ctrl_clk_ops;

With this, even if is_atomic and latency matches, we won't allow
atomic operations ? One reason why it gets tricky and as Cristian 
mentioned elsewhere we need dynamic assignment of these ops IMO.
Let me know if I am getting things wrong here ?

-- 
Regards,
Sudeep

