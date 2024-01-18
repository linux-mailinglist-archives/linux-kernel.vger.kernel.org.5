Return-Path: <linux-kernel+bounces-30459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 898D6831EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D2928CEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEF52D62C;
	Thu, 18 Jan 2024 18:10:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2552D608;
	Thu, 18 Jan 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601430; cv=none; b=IOJvN8OO8csAaZZC5PX5qcGT6OIYd0mRYRmA+Fr3NUkSSOQLZ+91tM6iuq+UFQTdExpp0AbDCdCIkToI6PAxslwVMo9tb5dhtZw7qz4crN0sMz5WW5Gua64E/fNC7jLjsaBk64I2YgqW/G1I6PV8Nqf1dk7Y2NGggvU/apxgcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601430; c=relaxed/simple;
	bh=app39ODx04QOPsP6qKx4T9KHOMqJMMY/EWK9P11lEl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+IQ7u578zLblsVg56UznFWoOXx5vfzB24IlDUbczHKLmtmejIc9tm9JLK1N4TDHLcfRoMsz2nGwtXarKj4wpD+lTDnfQQV0tC64+Zl53jDzTaR+KaOowXwYtO9tHeBkivzS3AaJO49xTW2ESzEsEj+EBXuSwQq3SrpzfXnZ300=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE3CB1042;
	Thu, 18 Jan 2024 10:11:10 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A3933F766;
	Thu, 18 Jan 2024 10:10:23 -0800 (PST)
Date: Thu, 18 Jan 2024 18:10:20 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 1/2] firmware: arm_scmi: Implement Clock get
 permissions
Message-ID: <ZalpjHLTt_EHDE1T@pluto>
References: <20240115060203.813168-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115060203.813168-1-peng.fan@oss.nxp.com>

On Mon, Jan 15, 2024 at 02:02:02PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> ARM SCMI Spec 3.2 introduces Clock Get Permission command. This patch
> is to add the support. Add three bool entries to scmi_clock_info to
> indicate the operation is forbidden or not. If the CLOCK_GET_PERMISSIONS
> command is not supported, the three bool variables will default
> set to false, otherwise they will be set according to the return result
> of CLOCK_GET_PERMISSIONS.
> 

LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V3:
>  Rebased on https://lore.kernel.org/linux-arm-kernel/20240110120916.2482603-1-cristian.marussi@arm.com/
>  Drop attribute which is no needed
>  Use scmi_clock_domain_lookup
>  Update patch subject
> 
> V2:
>  Take Cristian's suggestion, https://lore.kernel.org/all/ZWiqqfQ73tezFmSk@pluto/
> 
>  drivers/firmware/arm_scmi/clock.c | 64 +++++++++++++++++++++++++++++++
>  include/linux/scmi_protocol.h     |  3 ++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index 2e4d6479a639..959e48aba1b5 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -28,8 +28,13 @@ enum scmi_clock_protocol_cmd {
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
> @@ -49,6 +54,7 @@ struct scmi_msg_resp_clock_attributes {
>  #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
>  #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
>  #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
> +#define SUPPORTS_GET_PERMISSIONS(x)		((x) & BIT(1))
>  	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
>  	__le32 clock_enable_latency;
>  };
> @@ -293,6 +299,35 @@ static int scmi_clock_possible_parents(const struct scmi_protocol_handle *ph, u3
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
> @@ -339,6 +374,8 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>  			clk->rate_change_requested_notifications = true;
>  		if (SUPPORTS_PARENT_CLOCK(attributes))
>  			scmi_clock_possible_parents(ph, clk_id, clk);
> +		if (SUPPORTS_GET_PERMISSIONS(attributes))
> +			scmi_clock_get_permissions(ph, clk_id, clk);
>  	}
>  
>  	return ret;
> @@ -511,6 +548,14 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
>  	struct scmi_xfer *t;
>  	struct scmi_clock_set_rate *cfg;
>  	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk;
> +
> +	clk = scmi_clock_domain_lookup(ci, clk_id);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	if (clk->rate_ctrl_forbidden)
> +		return -EACCES;
>  
>  	ret = ph->xops->xfer_get_init(ph, CLOCK_RATE_SET, sizeof(*cfg), 0, &t);
>  	if (ret)
> @@ -596,6 +641,9 @@ scmi_clock_set_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
>  	if (parent_id >= clk->num_parents)
>  		return -EINVAL;
>  
> +	if (clk->parent_ctrl_forbidden)
> +		return -EACCES;
> +
>  	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_SET,
>  				      sizeof(*cfg), 0, &t);
>  	if (ret)
> @@ -679,6 +727,14 @@ static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id,
>  			     bool atomic)
>  {
>  	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk;
> +
> +	clk = scmi_clock_domain_lookup(ci, clk_id);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	if (clk->state_ctrl_forbidden)
> +		return -EACCES;
>  
>  	return ci->clock_config_set(ph, clk_id, CLK_STATE_ENABLE,
>  				    NULL_OEM_TYPE, 0, atomic);
> @@ -688,6 +744,14 @@ static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
>  			      bool atomic)
>  {
>  	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk;
> +
> +	clk = scmi_clock_domain_lookup(ci, clk_id);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	if (clk->state_ctrl_forbidden)
> +		return -EACCES;
>  
>  	return ci->clock_config_set(ph, clk_id, CLK_STATE_DISABLE,
>  				    NULL_OEM_TYPE, 0, atomic);
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index f2f05fb42d28..0cc40af5519a 100644
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
> -- 
> 2.37.1
> 

