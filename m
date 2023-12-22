Return-Path: <linux-kernel+bounces-9913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA7081CD2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFA91F23F31
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BFC24B4F;
	Fri, 22 Dec 2023 16:35:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F5D249FD;
	Fri, 22 Dec 2023 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12901139F;
	Fri, 22 Dec 2023 08:36:03 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17FAB3F7F5;
	Fri, 22 Dec 2023 08:35:13 -0800 (PST)
Date: Fri, 22 Dec 2023 16:35:11 +0000
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
	Peng Fan <peng.fan@nxp.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 6/7] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Message-ID: <ZYW6v724Ags5JtY9@pluto>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
 <20231215-pinctrl-scmi-v1-6-0fe35e4611f7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-pinctrl-scmi-v1-6-0fe35e4611f7@nxp.com>

On Fri, Dec 15, 2023 at 07:56:34PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCMI platform firmware, which does the changes in HW.
> 

[CC: Akashi which was interested in this series]

This generic driver still works fine for me as of now in my emulated
setup using the generic SCMI bindings as in the initial Oleksii example
and a dummy driver consumer for this pins, BUT there is still an open
issue as reported by Akashi previously ..see below.

> Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  MAINTAINERS                    |   1 +
>  drivers/pinctrl/Kconfig        |  11 ++
>  drivers/pinctrl/Makefile       |   1 +
>  drivers/pinctrl/pinctrl-scmi.c | 403 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 416 insertions(+)
 
 [snip]

> +static const struct pinmux_ops pinctrl_scmi_pinmux_ops = {
> +	.request = pinctrl_scmi_request,
> +	.free = pinctrl_scmi_free,
> +	.get_functions_count = pinctrl_scmi_get_functions_count,
> +	.get_function_name = pinctrl_scmi_get_function_name,
> +	.get_function_groups = pinctrl_scmi_get_function_groups,
> +	.set_mux = pinctrl_scmi_func_set_mux,
> +};
> +
> +static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev, unsigned int _pin,
> +				    unsigned long *config)
> +{
> +	int ret;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param config_type;
> +	unsigned long config_value;
> +
> +	if (!config)
> +		return -EINVAL;
> +
> +	config_type = pinconf_to_config_param(*config);

This config types that are packed/unpacked from the generic Pinctrl
subsystem have also to be mapped/umapped, here and below, to the SCMI
ones since they are slightly different/.

IOW SCMI V3.2 Table_24 in the spec, which defines Pins Config Types as
understood by an SCMI platform FW is NOT exactly mapping to the enum
pin_config_param used by Pinctrl in its pinconf_to_config so you risk
passing a config_type to the SCMI fw that does NOT mean at all what
intended...if the FW is compliant with SCMI.

> +
> +	ret = pinctrl_ops->config_get(pmx->ph, _pin, PIN_TYPE, config_type, &config_value);
> +	if (ret)
> +		return ret;
> +
> +	*config = pinconf_to_config_packed(config_type, config_value);
> +
> +	return 0;
> +}
> +
> +static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
> +				    unsigned int _pin,
> +				    unsigned long *configs,
> +				    unsigned int num_configs)
> +{
> +	int ret;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!configs || !num_configs)
> +		return -EINVAL;
> +

Same here, as said in the previous patch about pinctrl protocol, you
should pack/unpack and map/unmap from Pinctrl packed configs and types
to SCMI types and unpacked config/values, to fix the mismatch between
Pinctrl and SCMI types and also to avoid the usage of Pinctrl helpers to
extract the types from the SCMI protocol layer so that we can keep it
agnostic in these regards.

Thanks,
Cristian

