Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BD77FF39B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346229AbjK3Pat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjK3Par (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:30:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AB9E10C2;
        Thu, 30 Nov 2023 07:30:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C52DD1042;
        Thu, 30 Nov 2023 07:31:39 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C83943F73F;
        Thu, 30 Nov 2023 07:30:51 -0800 (PST)
Date:   Thu, 30 Nov 2023 15:30:49 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ranjani.vaidyanathan@nxp.com, glen.wienecke@nxp.com,
        nitin.garg_3@nxp.com, chuck.cannon@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] firmware: arm_scmi: clock: implement get permissions
Message-ID: <ZWiqqfQ73tezFmSk@pluto>
References: <20231129082957.1319895-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129082957.1319895-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:29:57PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> ARM SCMI Spec 3.2 introduces Clock Get Permission command. This patch
> is to add the support. For clock enable/disable, directly return zero
> if not allow to config. For rate & parent set, directly return -EACCES
> if not allow to set.
> 

Hi Peng,

thanks for this, a few comments below.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/clock.c | 51 +++++++++++++++++++++++++++++++
>  include/linux/scmi_protocol.h     |  2 ++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index 98511a3aa367..ebc140f2a3c0 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -25,8 +25,13 @@ enum scmi_clock_protocol_cmd {
>  	CLOCK_POSSIBLE_PARENTS_GET = 0xC,
>  	CLOCK_PARENT_SET = 0xD,
>  	CLOCK_PARENT_GET = 0xE,
> +	CLOCK_GET_PERMISSIONS = 0xF,
>  };
>  
> +#define CLOCK_STATE_CONTROL_ALLOWED	BIT(31)
> +#define CLOCK_PARENT_CONTROL_ALLOWED	BIT(30)
> +#define CLOCK_RATE_CONTROL_ALLOWED	BIT(29)
> +
>  enum clk_state {
>  	CLK_STATE_DISABLE,
>  	CLK_STATE_ENABLE,
> @@ -46,6 +51,7 @@ struct scmi_msg_resp_clock_attributes {
>  #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
>  #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
>  #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
> +#define SUPPORTS_GET_PERMISSIONS(x)		((x) & BIT(1))
>  	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
>  	__le32 clock_enable_latency;
>  };
> @@ -281,6 +287,29 @@ static int scmi_clock_possible_parents(const struct scmi_protocol_handle *ph, u3
>  	return ret;
>  }
>  
> +static int
> +scmi_clock_get_permissions(const struct scmi_protocol_handle *ph, u32 clk_id,
> +			   struct scmi_clock_info *clk, u32 *perm)
> +{

mmmm...what's the *clk parameter needed for ?
(but more on this later...)

> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, CLOCK_GET_PERMISSIONS,
> +				      sizeof(clk_id), sizeof(*perm), &t);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(clk_id, t->tx.buf);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret)
> +		*perm = get_unaligned_le32(t->rx.buf);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
>  static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>  				     u32 clk_id, struct scmi_clock_info *clk,
>  				     u32 version)
> @@ -307,6 +336,7 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>  		if (PROTOCOL_REV_MAJOR(version) >= 0x2)
>  			latency = le32_to_cpu(attr->clock_enable_latency);
>  		clk->enable_latency = latency ? : U32_MAX;
> +		clk->attributes = attributes;
>  	}
>  
>  	ph->xops->xfer_put(ph, t);
> @@ -327,6 +357,8 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>  			clk->rate_change_requested_notifications = true;
>  		if (SUPPORTS_PARENT_CLOCK(attributes))
>  			scmi_clock_possible_parents(ph, clk_id, clk);
> +		if (SUPPORTS_GET_PERMISSIONS(attributes))
> +			scmi_clock_get_permissions(ph, clk_id, clk, &clk->perm);
>  	}
>  
>  	return ret;
> @@ -499,6 +531,11 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
>  	struct scmi_xfer *t;
>  	struct scmi_clock_set_rate *cfg;
>  	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk = ci->clk + clk_id;
> +
> +	if (SUPPORTS_GET_PERMISSIONS(clk->attributes) &&
> +	    !(clk->perm & CLOCK_RATE_CONTROL_ALLOWED))
> +		return -EACCES;
>  
>  	ret = ph->xops->xfer_get_init(ph, CLOCK_RATE_SET, sizeof(*cfg), 0, &t);
>  	if (ret)
> @@ -585,6 +622,10 @@ scmi_clock_set_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
>  	if (parent_id >= clk->num_parents)
>  		return -EINVAL;
>  
> +	if (SUPPORTS_GET_PERMISSIONS(clk->attributes) &&
> +	    !(clk->perm & CLOCK_PARENT_CONTROL_ALLOWED))
> +		return -EACCES;
> +
>  	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_SET,
>  				      sizeof(*cfg), 0, &t);
>  	if (ret)
> @@ -668,6 +709,11 @@ static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id,
>  			     bool atomic)
>  {
>  	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk = ci->clk + clk_id;
> +
> +	if (SUPPORTS_GET_PERMISSIONS(clk->attributes) &&
> +	    !(clk->perm & CLOCK_STATE_CONTROL_ALLOWED))
> +		return 0;

So this returning success when not allowed to change could be controversial,
as said, but anyway I would not hide this here at the protocol layer:
IOW, it is good that we now have the perm bits to check to avoid sending an
un-needed message that will be denied, but you should report -EACCESS from
the protocol operation here up to the caller (like you did with the other
parent/rate ops) and let instead the clk-scmi driver to deal with the -EACCESS
retcode deciding (maybe) to return success when the clock is marked as NOT
allowing control of the state.

Moreover I would not expose all the attributes and perm flag mask in
clk_info...maybe you could just perform all these perms checks in
get_permission and set per-clock individual flags that can be then checked
here AND in the clk-scmi driver just by looking up clk_info (instead of
having to export all the macros to dissect the bitfields)

IOW you could check all the perms once for all in clock_get_permission
and setting something like

	ret = ph->xops->do_xfer(ph, t);
	if (!ret) {
		perm = get_unaligned_le32(t->rx.buf);

		clk->state_ctrl_forbidden = !(perm & CLOCK_PARENT_CONTROL_ALLOWED);
		clk->rate_ctrl_forbidden = !(perm & CLOCK_RATE_CONTROL_ALLOWED);
		clk->parent_ctrl_forbidden = !(perm & CLOCK_PARENT_CONTROL_ALLOWED);
	}

for each clock and then here in the clock operations just:

	if (clk->state_ctrl_forbidden)
		return -EACCESS;

etc etc

(with all the clocks NOT supporting the new commands so defaulting to
forbidden=false....)

while in the clk-scmi driver you could similarly filter out the DENY with

	if (ret == -EACCESS && clk->state_control_forbidden)
		return 0;

(if accepted and not too much controversial ...)

This way we avoid exposing all the attributes and all the related macros
while keeping all the strictly protocol related stuff in the protocol
layer...so that in case of further changes the above boolean wont have
to be touched again. (even though is a bit wasteful in terms of space....)

Does this make any sense ? :P

Thanks,
Cristian
