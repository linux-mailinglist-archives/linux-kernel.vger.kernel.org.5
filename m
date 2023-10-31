Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359437DCD80
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344438AbjJaNDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344366AbjJaNDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:03:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12918DF;
        Tue, 31 Oct 2023 06:03:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02A5EC15;
        Tue, 31 Oct 2023 06:03:53 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EC383F738;
        Tue, 31 Oct 2023 06:03:09 -0700 (PDT)
Date:   Tue, 31 Oct 2023 13:03:08 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ranjani.vaidyanathan@nxp.com, glen.wienecke@nxp.com,
        nitin.garg@nxp.com, chuck.cannon@nxp.com,
        Souvik.Chakravarty@arm.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V1] firmware: arm_scmi: clock: support clock denied flags
Message-ID: <ZUD7DGynqkvDzasN@pluto>
References: <20231031122734.1371524-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031122734.1371524-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 08:27:34PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The firmware may export flags to indicate whether the clock
> is allowed to set rate, set parent, enable/disable from the Agent.
> 
> If Agent is not allowed to enable/disable, directly return success.

... even though, this success on deny built-in policy could be
controversial...Have you tried the different approach of not
registerig the enable/prepare callbacks in clk-scmi instead ?
From the Clk framework code it seems could be handled gracefully.
(I have not tried though...)

Thanks,
Cristian

> If Agent is not allowed to set rate/parent, directly return -EACCES to
> avoid SCMI RPC calls.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>  drop the changes in clock.c, add an attribute entry in clock info which
>  may be easy for extending new flag.
> 
>  SPEC still not have such support, this is for discussion
> 
>  drivers/firmware/arm_scmi/clock.c | 19 +++++++++++++++++++
>  include/linux/scmi_protocol.h     |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index 42b81c181d68..fad4329a21fc 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -46,6 +46,9 @@ struct scmi_msg_resp_clock_attributes {
>  #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
>  #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
>  #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
> +#define SCMI_CLOCK_SET_ENABLE_DENIED		BIT(15)
> +#define SCMI_CLOCK_SET_RATE_DENIED		BIT(14)
> +#define SCMI_CLOCK_SET_PARENT_DENIED		BIT(13)
>  	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
>  	__le32 clock_enable_latency;
>  };
> @@ -307,6 +310,7 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>  		if (PROTOCOL_REV_MAJOR(version) >= 0x2)
>  			latency = le32_to_cpu(attr->clock_enable_latency);
>  		clk->enable_latency = latency ? : U32_MAX;
> +		clk->attributes = attributes;
>  	}
>  
>  	ph->xops->xfer_put(ph, t);
> @@ -499,6 +503,10 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
>  	struct scmi_xfer *t;
>  	struct scmi_clock_set_rate *cfg;
>  	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk = ci->clk + clk_id;
> +
> +	if (clk->attributes & SCMI_CLOCK_SET_RATE_DENIED)
> +		return -EACCES;
>  
>  	ret = ph->xops->xfer_get_init(ph, CLOCK_RATE_SET, sizeof(*cfg), 0, &t);
>  	if (ret)
> @@ -585,6 +593,9 @@ scmi_clock_set_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
>  	if (parent_id >= clk->num_parents)
>  		return -EINVAL;
>  
> +	if (clk->attributes & SCMI_CLOCK_SET_PARENT_DENIED)
> +		return -EACCES;
> +
>  	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_SET,
>  				      sizeof(*cfg), 0, &t);
>  	if (ret)
> @@ -668,6 +679,10 @@ static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id,
>  			     bool atomic)
>  {
>  	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk = ci->clk + clk_id;
> +
> +	if (clk->attributes & SCMI_CLOCK_SET_ENABLE_DENIED)
> +		return 0;
>  
>  	return ci->clock_config_set(ph, clk_id, CLK_STATE_ENABLE,
>  				    NULL_OEM_TYPE, 0, atomic);
> @@ -677,6 +692,10 @@ static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
>  			      bool atomic)
>  {
>  	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk = ci->clk + clk_id;
> +
> +	if (clk->attributes & SCMI_CLOCK_SET_ENABLE_DENIED)
> +		return 0;
>  
>  	return ci->clock_config_set(ph, clk_id, CLK_STATE_DISABLE,
>  				    NULL_OEM_TYPE, 0, atomic);
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index f2f05fb42d28..ddf5363c8cfd 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -58,6 +58,7 @@ struct scmi_clock_info {
>  			u64 step_size;
>  		} range;
>  	};
> +	u32 attributes;
>  	int num_parents;
>  	u32 *parents;
>  };
> -- 
> 2.37.1
> 
