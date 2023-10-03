Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CAF7B68BF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjJCMNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjJCMNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:13:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61788AF;
        Tue,  3 Oct 2023 05:13:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 553C11FB;
        Tue,  3 Oct 2023 05:14:15 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCDEA3F59C;
        Tue,  3 Oct 2023 05:13:35 -0700 (PDT)
Date:   Tue, 3 Oct 2023 13:13:33 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 2/2] clk: scmi: add set/get_parent support
Message-ID: <ZRwFbc8G_5dDzUmb@pluto>
References: <20231003-scmi-clock-v3-v4-0-358d7f916a05@nxp.com>
 <20231003-scmi-clock-v3-v4-2-358d7f916a05@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003-scmi-clock-v3-v4-2-358d7f916a05@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 07:48:49PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> SCMI v3.2 adds set/get parent clock commands, so update the clk driver
> to support them.
> 

Hi,

in general LGTM, BUT I have just spotted one more *bad* thing that have to be
fixe down below which I have missed previously, my bad.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/clk-scmi.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index 2e1337b511eb..e7a27fda561b 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -24,6 +24,7 @@ struct scmi_clk {
>  	struct clk_hw hw;
>  	const struct scmi_clock_info *info;
>  	const struct scmi_protocol_handle *ph;
> +	struct clk_parent_data *parent_data;
>  };
>  
>  #define to_scmi_clk(clk) container_of(clk, struct scmi_clk, hw)
> @@ -78,6 +79,43 @@ static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>  	return scmi_proto_clk_ops->rate_set(clk->ph, clk->id, rate);
>  }
>  
> +static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index)
> +{
> +	struct scmi_clk *clk = to_scmi_clk(hw);
> +
> +	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id, parent_index);
> +}
> +
> +static u8 scmi_clk_get_parent(struct clk_hw *hw)
> +{
> +	struct scmi_clk *clk = to_scmi_clk(hw);
> +	u32 parent_id, p_idx;
> +	int ret;
> +
> +	ret = scmi_proto_clk_ops->parent_get(clk->ph, clk->id, &parent_id);
> +	if (ret)
> +		return 0;
> +
> +	for (p_idx = 0; p_idx < clk->info->num_parents; p_idx++) {
> +		if (clk->parent_data[p_idx].index == parent_id)
> +			break;
> +	}
> +
> +	if (p_idx == clk->info->num_parents)
> +		return 0;
> +
> +	return p_idx;
> +}
> +
> +static int scmi_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
> +{
> +	/*
> +	 * Suppose all the requested rates are supported, and let firmware
> +	 * to handle the left work.
> +	 */
> +	return 0;
> +}
> +
>  static int scmi_clk_enable(struct clk_hw *hw)
>  {
>  	struct scmi_clk *clk = to_scmi_clk(hw);
> @@ -139,6 +177,9 @@ static const struct clk_ops scmi_clk_ops = {
>  	.set_rate = scmi_clk_set_rate,
>  	.prepare = scmi_clk_enable,
>  	.unprepare = scmi_clk_disable,
> +	.set_parent = scmi_clk_set_parent,
> +	.get_parent = scmi_clk_get_parent,
> +	.determine_rate = scmi_clk_determine_rate,
>  };
>  
>  static const struct clk_ops scmi_atomic_clk_ops = {
> @@ -148,6 +189,9 @@ static const struct clk_ops scmi_atomic_clk_ops = {
>  	.enable = scmi_clk_atomic_enable,
>  	.disable = scmi_clk_atomic_disable,
>  	.is_enabled = scmi_clk_atomic_is_enabled,
> +	.set_parent = scmi_clk_set_parent,
> +	.get_parent = scmi_clk_get_parent,
> +	.determine_rate = scmi_clk_determine_rate,
>  };
>  
>  static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
> @@ -158,9 +202,10 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
>  
>  	struct clk_init_data init = {
>  		.flags = CLK_GET_RATE_NOCACHE,
> -		.num_parents = 0,
> +		.num_parents = sclk->info->num_parents,
>  		.ops = scmi_ops,
>  		.name = sclk->info->name,
> +		.parent_data = sclk->parent_data,
>  	};
>  
>  	sclk->hw.init = &init;
> @@ -250,6 +295,17 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
>  		else
>  			scmi_ops = &scmi_clk_ops;
>  
> +		/* Initialize clock parent data. */
> +		if (sclk->info->num_parents > 0) {
> +			sclk->parent_data = devm_kcalloc(dev, sclk->info->num_parents,
> +							 sizeof(*sclk->parent_data), GFP_KERNEL);
> +

Here, you missed to check the return value of devm_kcalloc() before carrying on.

> +			for (int i = 0; i < sclk->info->num_parents; i++) {
> +				sclk->parent_data[i].index = sclk->info->parents[i];
> +				sclk->parent_data[i].hw = hws[sclk->info->parents[i]];
> +			}
> +		}
> +

Other than this, FWIW:

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian
