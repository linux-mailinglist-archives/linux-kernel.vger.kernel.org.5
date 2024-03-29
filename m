Return-Path: <linux-kernel+bounces-125309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B72D8923D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D4B1F231FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CF5131E59;
	Fri, 29 Mar 2024 19:10:30 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768486240
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739429; cv=none; b=lXaVEXbRr7o8Mt9LiklNemY1oKfeC1jb9xSK3PSfsa8tsndT9PWVC44OKMTLa+kxNcKm/ZJ7OPBcaR38kTm1qUUWzPIJ3f5nF0goiMuGzSwrerdCIP7+6oQoYvMKfz0rtJZnmFxMzaQpEYFgLjE3kKCaZHHJMUn2YuB49m+7D9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739429; c=relaxed/simple;
	bh=wvyg9g9jnzEB2eV9iE+Drh2zsS96ZqjdjsK1QL3w1M4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI5Eo3h/b7ARUiYZgTd8eEMCfiY909yR6MhvT9jIuD+S3ydXNEq/ANnU8Nf5/xgc2Ys5KMglsp3xtgiD3wK5IjjG74ugActE1tzoXl8Zc4fWQK77vub2pLkg0kfuwzuNpPjZtjxPxbV0u04pxwJ2V3L3vfBeUGqRaZ9y8Wazbjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id ff602b77-edff-11ee-abf4-005056bdd08f;
	Fri, 29 Mar 2024 21:10:25 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Mar 2024 21:10:25 +0200
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v6 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Message-ID: <ZgcSIb4BVcbVmPyW@surfacebook.localdomain>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-4-a895243257c0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-pinctrl-scmi-v6-4-a895243257c0@nxp.com>

Sat, Mar 23, 2024 at 08:15:17PM +0800, Peng Fan (OSS) kirjoitti:
> From: Peng Fan <peng.fan@nxp.com>
> 
> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCMI platform firmware, which does the changes in HW.

..

> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/seq_file.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>

Use IWYU principle. There are missing header inclusions and/or forward
declarations.

..

> +struct scmi_pinctrl_funcs {
> +	unsigned int num_groups;
> +	const char **groups;
> +};

This is repeating struct pinfunction. Why can't the latter be used?

..

> +err_free:
> +	devm_kfree(pmx->dev, groups);

Why?!

This is 99.9% that the initial allocation must not be devm. 

..

> +	*p_config_value = kcalloc(num_configs, sizeof(u32), GFP_KERNEL);

sizeof(**p_config_value)?

> +	*p_config_type = kcalloc(num_configs,
> +				 sizeof(enum scmi_pinctrl_conf_type),

sizeof(**p_config_type)?

> +				 GFP_KERNEL);
> +
> +	if (!*p_config_value || !*p_config_type) {
> +		kfree(*p_config_value);
> +		kfree(*p_config_type);
> +		return -ENOMEM;

Why to allocate / free memory in the case when you know that the first one
failed?

> +	}

..

> +static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
> +				 struct pinctrl_desc *desc)
> +{
> +	struct pinctrl_pin_desc *pins;
> +	unsigned int npins;
> +	int ret, i;
> +
> +	npins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
> +	pins = devm_kmalloc_array(pmx->dev, npins, sizeof(*pins), GFP_KERNEL);
> +	if (!pins)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < npins; i++) {
> +		pins[i].number = i;
> +		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE, &pins[i].name);
> +		if (ret)
> +			return dev_err_probe(pmx->dev, ret,
> +					     "Can't get name for pin %d", i);
> +	}
> +
> +	desc->npins = npins;
> +	desc->pins = pins;
> +	dev_dbg(pmx->dev, "got pins %d", npins);

%u

> +	return 0;
> +}

..

> +	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL,
> +						&ph);

One line.

> +	if (IS_ERR(pinctrl_ops))
> +		return PTR_ERR(pinctrl_ops);

-- 
With Best Regards,
Andy Shevchenko



