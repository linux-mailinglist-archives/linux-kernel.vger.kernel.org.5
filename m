Return-Path: <linux-kernel+bounces-9839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AAB81CC3A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389AB1F26C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EDF2376C;
	Fri, 22 Dec 2023 15:30:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70C923750;
	Fri, 22 Dec 2023 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C2322F4;
	Fri, 22 Dec 2023 07:31:03 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 999953F5A1;
	Fri, 22 Dec 2023 07:30:14 -0800 (PST)
Date: Fri, 22 Dec 2023 15:30:11 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/7] firmware: arm_scmi: introduce helper get_max_msg_size
Message-ID: <ZYWrgzujGh84CT-5@pluto>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
 <20231215-pinctrl-scmi-v1-1-0fe35e4611f7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-pinctrl-scmi-v1-1-0fe35e4611f7@nxp.com>

On Fri, Dec 15, 2023 at 07:56:29PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When Agent sending data to SCMI server, the Agent driver could check
> the size to avoid protocol buffer overflow. So introduce the helper
> get_max_msg_size.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/driver.c    | 15 +++++++++++++++
>  drivers/firmware/arm_scmi/protocols.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index a9f70e6e58ac..b4f8f190351b 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -1481,6 +1481,20 @@ static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
>  	return ret;
>  }
>  
> +/**
> + * scmi_common_get_max_msg_size  - Get maximum message size
> + * @ph: A protocol handle reference.
> + *
> + * Return: Maximum message size for the current protocol.
> + */
> +static int scmi_common_get_max_msg_size(const struct scmi_protocol_handle *ph)
> +{
> +	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
> +	struct scmi_info *info = handle_to_scmi_info(pi->handle);
> +
> +	return info->desc->max_msg_size;
> +}
> +
>  /**
>   * struct scmi_iterator  - Iterator descriptor
>   * @msg: A reference to the message TX buffer; filled by @prepare_message with
> @@ -1756,6 +1770,7 @@ static void scmi_common_fastchannel_db_ring(struct scmi_fc_db_info *db)
>  
>  static const struct scmi_proto_helpers_ops helpers_ops = {
>  	.extended_name_get = scmi_common_extended_name_get,
> +	.get_max_msg_size = scmi_common_get_max_msg_size,
>  	.iter_response_init = scmi_iterator_init,
>  	.iter_response_run = scmi_iterator_run,
>  	.fastchannel_init = scmi_common_fastchannel_init,
> diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
> index e683c26f24eb..08de8dc064c1 100644
> --- a/drivers/firmware/arm_scmi/protocols.h
> +++ b/drivers/firmware/arm_scmi/protocols.h
> @@ -270,6 +270,7 @@ struct scmi_proto_helpers_ops {
>  				 void __iomem **p_addr,
>  				 struct scmi_fc_db_info **p_db);
>  	void (*fastchannel_db_ring)(struct scmi_fc_db_info *db);
> +	int (*get_max_msg_size)(const struct scmi_protocol_handle *ph);
>  };

This looks good to me, but please add a comment for this new helper in
the comment block above.

Other than that:

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian


