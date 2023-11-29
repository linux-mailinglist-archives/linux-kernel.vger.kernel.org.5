Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DC87FD092
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjK2IVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjK2IVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:21:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F4C1990
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:21:12 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-332f4ad27d4so2898120f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701246070; x=1701850870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLuNTW8XH4PEfzpW51yRQR6dS0qm2pf0kAPxK7046Cc=;
        b=o21aWQRX85Th8GdpbYgEVW5GYcLxF8EZLakhTc2gqM/2eGbKpH1H++1DIkz9OEBp6x
         wzdXGbBB5lZle37b0S6wqFLa49W6OMx3cu8plah+kj76xHQFWU71YiMtk3WHbU+hLkV+
         E+o5LtRgFOTZpcBQ4r5WX3eq6q9lsYzHF2gDQvmrV7K8KAUCGmkk6jvES7XFcnqQAQH0
         5TFWYOFO6DSW00tFGzGvk+ZrP6rHsZrCFinpJezx8YKZ9As9LFQ4B+0hpg/sCVUv2Mk2
         gUhtYWRzH8cmN9ylqWvzPqS6NiD8qfC7EQpbIUV1Xtc1AOHFNHBR70Q9JOSZgvTvYAdO
         qoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701246070; x=1701850870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLuNTW8XH4PEfzpW51yRQR6dS0qm2pf0kAPxK7046Cc=;
        b=pu4XLedBjY/bj8d/+xqfQxI5yUcWOkNbm+L6tUd9W6jqmfyEBtwKKd/BBQKUb3rfuC
         zmAqE3A+USEr9LUfo5JJx7+7lh6uX/uqRMU6Z4lZJSamnEkhHFMCynxhvNHE15RAjQ12
         HLCZpaZgBkYpw8lV8iMox0CTTdLsgV6c9qScqa1j8VloFv/d5bjDuwTr75zfjfo9T+hJ
         ipuWCX6miX0aDuKp5X0yk3dL5INk1kqi8JgZYs6bH7ZVpJ235T3hASMNwIJbyNXYTGRi
         3hRw4TuVQ6fcOJxWVuILayfGGptwgO8aHeprjcyf/pvwNBsjJfM2326n3e2XL2zJ6qmK
         0JOQ==
X-Gm-Message-State: AOJu0Yxo3xXasYvB5Je9/XASdim+MAYDk96iqXiRKHQAaXbYVykMKjlR
        I5cch49JxGEAnbdf64gvb6BRMw==
X-Google-Smtp-Source: AGHT+IFELq4kDVe3oXsCSJfllz3gUx2n1XDc0OX0ErbwOo53FIekEY4EztAbCjNhesOPqtiz4mk7wQ==
X-Received: by 2002:adf:a416:0:b0:32f:9af6:332a with SMTP id d22-20020adfa416000000b0032f9af6332amr11889613wra.0.1701246070555;
        Wed, 29 Nov 2023 00:21:10 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d4a8e000000b00332e073f12bsm17106646wrq.19.2023.11.29.00.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 00:21:10 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:21:06 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     James Tai <james.tai@realtek.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3 2/6] irqchip: Add interrupt controller support for
 Realtek DHC SoCs
Message-ID: <d94c79bf-04c4-4e87-bd7e-a8755508ac89@suswa.mountain>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-3-james.tai@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129054339.3054202-3-james.tai@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 01:43:35PM +0800, James Tai wrote:
> +static int realtek_intc_subset(struct device_node *node, struct realtek_intc_data *data, int index)
> +{
> +	struct realtek_intc_subset_data *subset_data = &data->subset_data[index];
> +	const struct realtek_intc_subset_cfg *cfg = &data->info->cfg[index];
> +	int irq;
> +
> +	irq = irq_of_parse_and_map(node, index);
> +	if (irq <= 0)
> +		return irq;

I don't think irq_of_parse_and_map() can return negatives.  Only zero
on error.  Returning zero on error is a historical artifact with IRQ
functions and a constant source of bugs.  But here returning zero is
success.  See my blog for more details:
https://staticthinking.wordpress.com/2023/08/07/writing-a-check-for-zero-irq-error-codes/

So this should probably be:

	irq = irq_of_parse_and_map(node, index);
	if (!irq)
		return -ENODEV;

I should create a static checker warning for this...  Possibly I should
create a static checker warning any time someone does:

	if (foo <= 0)
		return foo;

> +
> +	subset_data->common = data;
> +	subset_data->cfg = cfg;
> +	subset_data->parent_irq = irq;
> +	irq_set_chained_handler_and_data(irq, realtek_intc_handler, subset_data);
> +
> +	return 0;
> +}
> +
> +int realtek_intc_probe(struct platform_device *pdev, const struct realtek_intc_info *info)
> +{
> +	struct realtek_intc_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	int ret, i;
> +
> +	data = devm_kzalloc(dev, struct_size(data, subset_data, info->cfg_num), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->base = of_iomap(node, 0);
> +	if (!data->base) {
> +		ret = -ENOMEM;
> +		goto out_cleanup;

devm_ allocations are cleaned up automatically so there is no need to
call devm_kfree() before returning.

regards,
dan carpenter

> +	}
> +
> +	data->info = info;
> +
> +	raw_spin_lock_init(&data->lock);
> +
> +	data->domain = irq_domain_add_linear(node, 32, &realtek_intc_domain_ops, data);
> +	if (!data->domain) {
> +		ret = -ENOMEM;
> +		goto out_cleanup;
> +	}
> +
> +	data->subset_data_num = info->cfg_num;
> +	for (i = 0; i < info->cfg_num; i++) {
> +		ret = realtek_intc_subset(node, data, i);
> +		if (ret) {
> +			WARN(ret, "failed to init subset %d: %d", i, ret);
> +			ret = -ENOMEM;
> +			goto out_cleanup;
> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	return 0;
> +
> +out_cleanup:
> +
> +	if (data->base)
> +		iounmap(data->base);
> +
> +	devm_kfree(dev, data);
> +
> +	return ret;
> +}

