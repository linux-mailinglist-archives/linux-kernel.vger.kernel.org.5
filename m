Return-Path: <linux-kernel+bounces-22413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5817C829D58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA08A283318
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCD44BAAC;
	Wed, 10 Jan 2024 15:19:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FD14C3A6;
	Wed, 10 Jan 2024 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE32C2F4;
	Wed, 10 Jan 2024 07:19:56 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F3933F64C;
	Wed, 10 Jan 2024 07:19:09 -0800 (PST)
Date: Wed, 10 Jan 2024 15:19:07 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, ranjani.vaidyanathan@nxp.com,
	glen.wienecke@nxp.com, nitin.garg_3@nxp.com, chuck.cannon@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 1/2] firmware: arm_scmi: clock: implement get
 permissions
Message-ID: <ZZ61a9IUZk4YMpQM@pluto>
References: <20231207093345.581048-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207093345.581048-1-peng.fan@oss.nxp.com>

On Thu, Dec 07, 2023 at 05:33:44PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 

Hi Peng,

a few remarks down below, but generally LGTM.

>> Subject: Re: [PATCH V2 1/2] firmware: arm_scmi: clock: implement get permissions

till now we never added a <proto>: tag just "firmware: arm_scmi:",
capitalizing the first word. (not saying that using "clock:" is bad but
since we never used till now...), as an example

	firmware: arm_scmi: Implement Clock get permissions


> ARM SCMI Spec 3.2 introduces Clock Get Permission command. This patch
> is to add the support. Add three bool entries to scmi_clock_info to
> indicate the operation is forbidden or not. If the CLOCK_GET_PERMISSIONS
> command is not supported, the three bool variables will default
> set to false, otherwise they will be set according to the return result
> of CLOCK_GET_PERMISSIONS.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Take Cristian's suggestion, https://lore.kernel.org/all/ZWiqqfQ73tezFmSk@pluto/
> 
>  drivers/firmware/arm_scmi/clock.c | 53 +++++++++++++++++++++++++++++++
>  include/linux/scmi_protocol.h     |  4 +++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index 98511a3aa367..0e048530bea2 100644
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
> @@ -281,6 +287,35 @@ static int scmi_clock_possible_parents(const struct scmi_protocol_handle *ph, u3
>  	return ret;
>  }
>  
> +static int
> +scmi_clock_get_permissions(const struct scmi_protocol_handle *ph, u32 clk_id,
> +			   struct scmi_clock_info *clk)
> +{
> +	struct scmi_xfer *t;
> +	u32 perm;
> +	int ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, CLOCK_GET_PERMISSIONS,
> +				      sizeof(clk_id), sizeof(perm), &t);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(clk_id, t->tx.buf);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		perm = get_unaligned_le32(t->rx.buf);
> +
> +		clk->state_ctrl_forbidden = !(perm & CLOCK_STATE_CONTROL_ALLOWED);
> +		clk->rate_ctrl_forbidden = !(perm & CLOCK_RATE_CONTROL_ALLOWED);
> +		clk->parent_ctrl_forbidden = !(perm & CLOCK_PARENT_CONTROL_ALLOWED);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
>  static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>  				     u32 clk_id, struct scmi_clock_info *clk,
>  				     u32 version)
> @@ -307,6 +342,7 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>  		if (PROTOCOL_REV_MAJOR(version) >= 0x2)
>  			latency = le32_to_cpu(attr->clock_enable_latency);
>  		clk->enable_latency = latency ? : U32_MAX;
> +		clk->attributes = attributes;

Exposing the full attributes is NOT needed anymore now you have the bools right ?

>  	}
>  
>  	ph->xops->xfer_put(ph, t);
> @@ -327,6 +363,8 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>  			clk->rate_change_requested_notifications = true;
>  		if (SUPPORTS_PARENT_CLOCK(attributes))
>  			scmi_clock_possible_parents(ph, clk_id, clk);
> +		if (SUPPORTS_GET_PERMISSIONS(attributes))
> +			scmi_clock_get_permissions(ph, clk_id, clk);
>  	}
>  
>  	return ret;
> @@ -499,6 +537,10 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
>  	struct scmi_xfer *t;
>  	struct scmi_clock_set_rate *cfg;
>  	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk = ci->clk + clk_id;
> +

This lacks a check on the provided clk_id bounds (just in case the
calling SCMI driver misbehaves)....in other protocols we have some
common internal helper to lookup a domain by id safely, it was still just
not added till today in Clock since not so much needed.

This seems not to be the case anymore, so today I posted this trivial:

https://lore.kernel.org/linux-arm-kernel/20240110120916.2482603-1-cristian.marussi@arm.com/

Please rebase on this and just use it also on this patch like::

--->8---
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 51b21ce97cd5..01b372ac205f 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -549,7 +549,11 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
 	struct scmi_xfer *t;
 	struct scmi_clock_set_rate *cfg;
 	struct clock_info *ci = ph->get_priv(ph);
-	struct scmi_clock_info *clk = ci->clk + clk_id;
+	struct scmi_clock_info *clk;
+
+	clk = scmi_clock_domain_lookup(ci, clk_id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	if (clk->rate_ctrl_forbidden)
 		return -EACCES;
@@ -724,7 +728,11 @@ static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id,
 			     bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
-	struct scmi_clock_info *clk = ci->clk + clk_id;
+	struct scmi_clock_info *clk;
+
+	clk = scmi_clock_domain_lookup(ci, clk_id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	if (clk->state_ctrl_forbidden)
 		return -EACCES;
@@ -737,7 +745,11 @@ static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
 			      bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
-	struct scmi_clock_info *clk = ci->clk + clk_id;
+	struct scmi_clock_info *clk;
+
+	clk = scmi_clock_domain_lookup(ci, clk_id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	if (clk->state_ctrl_forbidden)
 		return -EACCES;
---8<-------


> +	if (clk->rate_ctrl_forbidden)
> +		return -EACCES;
>  
>  	ret = ph->xops->xfer_get_init(ph, CLOCK_RATE_SET, sizeof(*cfg), 0, &t);
>  	if (ret)
> @@ -585,6 +627,9 @@ scmi_clock_set_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
>  	if (parent_id >= clk->num_parents)
>  		return -EINVAL;
>  
> +	if (clk->parent_ctrl_forbidden)
> +		return -EACCES;
> +
>  	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_SET,
>  				      sizeof(*cfg), 0, &t);
>  	if (ret)
> @@ -668,6 +713,10 @@ static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id,
>  			     bool atomic)
>  {
>  	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk = ci->clk + clk_id;

Ditto.

> +
> +	if (clk->state_ctrl_forbidden)
> +		return -EACCES;
>  
>  	return ci->clock_config_set(ph, clk_id, CLK_STATE_ENABLE,
>  				    NULL_OEM_TYPE, 0, atomic);
> @@ -677,6 +726,10 @@ static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
>  			      bool atomic)
>  {
>  	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk = ci->clk + clk_id;
Ditto.
> +
> +	if (clk->state_ctrl_forbidden)
> +		return -EACCES;
>  
>  	return ci->clock_config_set(ph, clk_id, CLK_STATE_DISABLE,
>  				    NULL_OEM_TYPE, 0, atomic);
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index f2f05fb42d28..ad75784b567b 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -47,6 +47,9 @@ struct scmi_clock_info {
>  	bool rate_discrete;
>  	bool rate_changed_notifications;
>  	bool rate_change_requested_notifications;
> +	bool state_ctrl_forbidden;
> +	bool rate_ctrl_forbidden;
> +	bool parent_ctrl_forbidden;
>  	union {
>  		struct {
>  			int num_rates;
> @@ -60,6 +63,7 @@ struct scmi_clock_info {
>  	};
>  	int num_parents;
>  	u32 *parents;
> +	u32 attributes;

Ditto. Drop this.

Thanks,
Cristian


