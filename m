Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B787D80ED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbjJZKkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjJZKkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:40:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E572189;
        Thu, 26 Oct 2023 03:40:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68C182F4;
        Thu, 26 Oct 2023 03:40:48 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD38D3F738;
        Thu, 26 Oct 2023 03:40:04 -0700 (PDT)
Date:   Thu, 26 Oct 2023 11:40:02 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ranjani.vaidyanathan@nxp.com, glen.wienecke@nxp.com,
        nitin.garg@nxp.com, chuck.cannon@nxp.com, sboyd@kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Subject: Re: [RFC] firmware: arm_scmi: support clock denied attributes
Message-ID: <ZTpCAgUxjbVnFEkB@pluto>
References: <20231026034125.1823954-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026034125.1823954-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 11:41:25AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This is not in SPEC and is just defined by NXP. This patch is
> to start the discussion to start include them in SPEC.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Hi Peng,

thanks for validating this scenario.

[CC Souvik]

So at the end, you are returning -EACCESS anyway, it is just that you
are avoiding to send any SCMI message at all if the flag reports that
you cannot touch this and you will get back a DENY.

Does this solve your usecase where your other drivers (callers) were
failing to probe due to such error being reported from the server ?

From our offline discussions my understanding was that, beside un-needed
SCMI msg exchanges, your main issue was receiving a DENY error from the
server when trying to modify a clock, how does this solves that ?
Basically You are just returning the same error from the clk driver,
just avoiding (rightly so) needless SCMI exchanges.
(..in your last RFC patch you attempt was indeed different, to refrain
 from registering any clk framework callbacks at all for untocuhable
 clocks...)

Does this work with upstream drivers, or just with some downstream
solution properly crafted to handle the EACCESS ?

Anyway IMO, these changes in this scenario are certainly valuable in
general since they avoid needless exchanges with the server around
clocks that we know upfront we cannot touch.

BUT, hvaing said that, if this series goes further as it is and the
spec is changed accordingly, please move all of this logic inside the
protocol layer: there is no reason to change the clk-scmi driver at
all for this.

You can just check that same new flags (that you set in clk discovery)
upfront inside the related clock operations in drivers/firmware/arm/clock.c
and just return EACCESS from there avoiding any SCMI exchanges if the
flags are set.

This way you dont either need to re-define and expose such new flags in
scmi_protocol.h, it can just all handled inside the SCMI protocol layer.

Thank,
Cristian

>  drivers/clk/clk-scmi.c            | 39 +++++++++++++++++++++++++------
>  drivers/firmware/arm_scmi/clock.c |  9 +++++++
>  include/linux/scmi_protocol.h     |  4 ++++
>  3 files changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index 8cbe24789c24..303f8a8ec8e0 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -75,15 +75,13 @@ static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>  			     unsigned long parent_rate)
>  {
>  	struct scmi_clk *clk = to_scmi_clk(hw);
> +	const struct scmi_clock_info *info = clk->info;
> +	u64 rate1 = 0;
>  
> -	return scmi_proto_clk_ops->rate_set(clk->ph, clk->id, rate);
> -}
> -
> -static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index)
> -{
> -	struct scmi_clk *clk = to_scmi_clk(hw);
> +	if (info->flags & SCMI_CLOCK_SET_RATE_DENIED)
> +		return -EACCES;
>  
> -	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id, parent_index);
> +	return scmi_proto_clk_ops->rate_set(clk->ph, clk->id, rate);
>  }
>  
>  static u8 scmi_clk_get_parent(struct clk_hw *hw)
> @@ -107,6 +105,17 @@ static u8 scmi_clk_get_parent(struct clk_hw *hw)
>  	return p_idx;
>  }
>  
> +static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index)
> +{
> +	struct scmi_clk *clk = to_scmi_clk(hw);
> +	const struct scmi_clock_info *info = clk->info;
> +
> +	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
> +		return -EACCES;
> +
> +	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id, parent_index);
> +}
> +
>  static int scmi_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
>  {
>  	/*
> @@ -119,6 +128,10 @@ static int scmi_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *r
>  static int scmi_clk_enable(struct clk_hw *hw)
>  {
>  	struct scmi_clk *clk = to_scmi_clk(hw);
> +	const struct scmi_clock_info *info = clk->info;
> +
> +	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
> +		return 0;
>  
>  	return scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
>  }
> @@ -126,6 +139,10 @@ static int scmi_clk_enable(struct clk_hw *hw)
>  static void scmi_clk_disable(struct clk_hw *hw)
>  {
>  	struct scmi_clk *clk = to_scmi_clk(hw);
> +	const struct scmi_clock_info *info = clk->info;
> +
> +	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
> +		return;
>  
>  	scmi_proto_clk_ops->disable(clk->ph, clk->id, NOT_ATOMIC);
>  }
> @@ -133,6 +150,10 @@ static void scmi_clk_disable(struct clk_hw *hw)
>  static int scmi_clk_atomic_enable(struct clk_hw *hw)
>  {
>  	struct scmi_clk *clk = to_scmi_clk(hw);
> +	const struct scmi_clock_info *info = clk->info;
> +
> +	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
> +		return 0;
>  
>  	return scmi_proto_clk_ops->enable(clk->ph, clk->id, ATOMIC);
>  }
> @@ -140,6 +161,10 @@ static int scmi_clk_atomic_enable(struct clk_hw *hw)
>  static void scmi_clk_atomic_disable(struct clk_hw *hw)
>  {
>  	struct scmi_clk *clk = to_scmi_clk(hw);
> +	const struct scmi_clock_info *info = clk->info;
> +
> +	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
> +		return;
>  
>  	scmi_proto_clk_ops->disable(clk->ph, clk->id, ATOMIC);
>  }
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index 42b81c181d68..1a62e3b82d34 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -46,6 +46,9 @@ struct scmi_msg_resp_clock_attributes {
>  #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
>  #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
>  #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
> +#define SETS_ENABLE_DENIED(x)			((x) & BIT(15))
> +#define SETS_RATE_DENIED(x)			((x) & BIT(14))
> +#define SETS_PARENT_DENIED(x)			((x) & BIT(13))
>  	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
>  	__le32 clock_enable_latency;
>  };
> @@ -327,6 +330,12 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>  			clk->rate_change_requested_notifications = true;
>  		if (SUPPORTS_PARENT_CLOCK(attributes))
>  			scmi_clock_possible_parents(ph, clk_id, clk);
> +		if (SETS_PARENT_DENIED(attributes))
> +			clk->flags |= SCMI_CLOCK_SET_PARENT_DENIED;
> +		if (SETS_RATE_DENIED(attributes))
> +			clk->flags |= SCMI_CLOCK_SET_RATE_DENIED;
> +		if (SETS_ENABLE_DENIED(attributes))
> +			clk->flags |= SCMI_CLOCK_SET_ENABLE_DENIED;
>  	}
>  
>  	return ret;
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index f2f05fb42d28..71911dcd8117 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -41,12 +41,16 @@ struct scmi_revision_info {
>  	char sub_vendor_id[SCMI_SHORT_NAME_MAX_SIZE];
>  };
>  
> +#define SCMI_CLOCK_SET_PARENT_DENIED	BIT(13)
> +#define SCMI_CLOCK_SET_RATE_DENIED	BIT(14)
> +#define SCMI_CLOCK_SET_ENABLE_DENIED	BIT(15)
>  struct scmi_clock_info {
>  	char name[SCMI_MAX_STR_SIZE];
>  	unsigned int enable_latency;
>  	bool rate_discrete;
>  	bool rate_changed_notifications;
>  	bool rate_change_requested_notifications;
> +	unsigned int flags;
>  	union {
>  		struct {
>  			int num_rates;
> -- 
> 2.37.1
> 
