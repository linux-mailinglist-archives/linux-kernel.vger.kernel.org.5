Return-Path: <linux-kernel+bounces-30470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06631831F14
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC4A1F25161
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CE72D61B;
	Thu, 18 Jan 2024 18:27:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46B52D607;
	Thu, 18 Jan 2024 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602440; cv=none; b=CIAupL0fEb049DyiTAD86NX6I4PLPz7e/jwo2zW+cx0TvAGUsPf964Z+jHhAMwOx6Dm32S6OWFeM0EANUrBz4sy7EaqZsBxJulAEwIC9rqfaFXO3qZRkdDzlOGyfyK6zIwSmlpubslWzjnq1wRjiBs9oy2y6pWFcyZ48C1IX4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602440; c=relaxed/simple;
	bh=2MOfPFz7G5ELeaymAprmqeqIr3xcUu1nA2k4jv5ebks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuegSm6MAc8qvEF5Q4n89walbUvsSogf2zmOGLZgGAYWMDQ3XKIVhhimIqu6nLIdfcXM+AObgfXIF1Utg6vn4C2w/O8wRnIO6uhBcuJwC8qqHsBOMX3sKmeZrZrgu7l3JA+mpqjtnBofoiJ43tJh9ihUl/7Hjt/dlbjcldMZtwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 980B11042;
	Thu, 18 Jan 2024 10:28:02 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C4943F766;
	Thu, 18 Jan 2024 10:27:15 -0800 (PST)
Date: Thu, 18 Jan 2024 18:27:12 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 2/2] clk: scmi: support state_ctrl_forbidden
Message-ID: <ZaltgIGyx1al-F9x@pluto>
References: <20240115060203.813168-1-peng.fan@oss.nxp.com>
 <20240115060203.813168-2-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115060203.813168-2-peng.fan@oss.nxp.com>

On Mon, Jan 15, 2024 at 02:02:03PM +0800, Peng Fan (OSS) wrote:
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
> the clock of MMC1.
> 

Hi,

so this looks good to me and apparently (as noted) the CLK framework is OK
with a driver swallowing the -EACCESS when a clock is immutable, BUT at the
end of the day do we even need to try this SCMI call and hide the failure in
case of immutable clocks ?

I mean, what if we just dont provide any callback for enable/disable...I can
see plenty of drivers not providing those callbacks ?
Maybe this is probably more of a question for Stephen...

IOW what about doing something like below...does it make any difference
in your setup ? works fine in my emulated env

(Note that last snippet in clk_gate_restore_context() is probably a fix
 that needs to be added anyway by looking at the code in clk.c)

Thanks,
Cristian

--->8----
diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 5327e0547741..a669a2f2f78b 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -121,11 +121,7 @@ static int scmi_clk_enable(struct clk_hw *hw)
 	struct scmi_clk *clk = to_scmi_clk(hw);
 	int ret;
 
-	ret = scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
-	if (ret == -EACCES && clk->info->state_ctrl_forbidden)
-		return 0;
-
-	return ret;
+	return scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
 }
 
 static void scmi_clk_disable(struct clk_hw *hw)
@@ -140,11 +136,7 @@ static int scmi_clk_atomic_enable(struct clk_hw *hw)
 	struct scmi_clk *clk = to_scmi_clk(hw);
 	int ret;
 
-	ret = scmi_proto_clk_ops->enable(clk->ph, clk->id, ATOMIC);
-	if (ret == -EACCES && clk->info->state_ctrl_forbidden)
-		return 0;
-
-	return ret;
+	return scmi_proto_clk_ops->enable(clk->ph, clk->id, ATOMIC);
 }
 
 static void scmi_clk_atomic_disable(struct clk_hw *hw)
@@ -204,6 +196,15 @@ static const struct clk_ops scmi_atomic_clk_ops = {
 	.determine_rate = scmi_clk_determine_rate,
 };
 
+static const struct clk_ops scmi_no_state_ctrl_clk_ops = {
+	.recalc_rate = scmi_clk_recalc_rate,
+	.round_rate = scmi_clk_round_rate,
+	.set_rate = scmi_clk_set_rate,
+	.set_parent = scmi_clk_set_parent,
+	.get_parent = scmi_clk_get_parent,
+	.determine_rate = scmi_clk_determine_rate,
+};
+
 static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
 			     const struct clk_ops *scmi_ops)
 {
@@ -300,8 +301,10 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		 * specify (or support) an enable_latency associated with a
 		 * clock, we default to use atomic operations mode.
 		 */
-		if (is_atomic &&
-		    sclk->info->enable_latency <= atomic_threshold)
+		if (sclk->info->state_ctrl_forbidden)
+			scmi_ops = &scmi_no_state_ctrl_clk_ops;
+		else if (is_atomic &&
+			 sclk->info->enable_latency <= atomic_threshold)
 			scmi_ops = &scmi_atomic_clk_ops;
 		else
 			scmi_ops = &scmi_clk_ops;
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f0940af485a5..79b90a8099d7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1200,9 +1200,11 @@ void clk_gate_restore_context(struct clk_hw *hw)
 	struct clk_core *core = hw->core;
 
 	if (core->enable_count)
-		core->ops->enable(hw);
+		if (core->ops->enable)
+			core->ops->enable(hw);
 	else
-		core->ops->disable(hw);
+		if (core->ops->disable)
+			core->ops->disable(hw);
 }
 EXPORT_SYMBOL_GPL(clk_gate_restore_context);
---8<---

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V3:
>  Add check in atomic enable
> 
> V2:
>  New. Take Cristian's suggestion
> 
>  drivers/clk/clk-scmi.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index 8cbe24789c24..5327e0547741 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -119,8 +119,13 @@ static int scmi_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *r
>  static int scmi_clk_enable(struct clk_hw *hw)
>  {
>  	struct scmi_clk *clk = to_scmi_clk(hw);
> +	int ret;
> +
> +	ret = scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
> +	if (ret == -EACCES && clk->info->state_ctrl_forbidden)
> +		return 0;
>  
> -	return scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
> +	return ret;
>  }
>  
>  static void scmi_clk_disable(struct clk_hw *hw)
> @@ -133,8 +138,13 @@ static void scmi_clk_disable(struct clk_hw *hw)
>  static int scmi_clk_atomic_enable(struct clk_hw *hw)
>  {
>  	struct scmi_clk *clk = to_scmi_clk(hw);
> +	int ret;
> +
> +	ret = scmi_proto_clk_ops->enable(clk->ph, clk->id, ATOMIC);
> +	if (ret == -EACCES && clk->info->state_ctrl_forbidden)
> +		return 0;
>  
> -	return scmi_proto_clk_ops->enable(clk->ph, clk->id, ATOMIC);
> +	return ret;
>  }
>  
>  static void scmi_clk_atomic_disable(struct clk_hw *hw)
> -- 
> 2.37.1
> 

