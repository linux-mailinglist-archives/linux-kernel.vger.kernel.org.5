Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96F477C2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjHNVzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjHNVzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:55:23 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5AC1989
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:54:52 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 51b4ccd9-3aec-11ee-a9de-005056bdf889;
        Tue, 15 Aug 2023 00:48:38 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 15 Aug 2023 00:48:35 +0300
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 2/2] gpio: loongson: add firmware offset parse support
Message-ID: <ZNqhM18XoaqNdN99@surfacebook.localdomain>
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
 <20230807074043.31288-3-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807074043.31288-3-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Aug 07, 2023 at 03:40:43PM +0800, Yinbo Zhu kirjoitti:
> Loongson GPIO controllers come in multiple variants that are compatible
> except for certain register offset values.  Add support for device
> properties allowing to specify them in ACPI or DT.

> +	if (device_property_read_u32(dev, "ngpios", &ngpios) || !ngpios)
> +		return -EINVAL;
> +
> +	ret = DIV_ROUND_UP(ngpios, 8);
> +	switch (ret) {
> +	case 1 ... 2:
> +		io_width = ret;
> +		break;
> +	case 3 ... 4:
> +		io_width = 0x4;
> +		break;
> +	case 5 ... 8:
> +		io_width = 0x8;
> +		break;
> +	default:
> +		dev_err(dev, "unsupported io width\n");
> +		return -EINVAL;
> +	}

Why? We have bgpio_init() handle this.
https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git/commit/?h=gpio/for-next&id=55b2395e4e92adc492c6b30ac109eb78250dcd9d

...

> +	lgpio->chip.can_sleep = 0;

It's boolean, use boolean initializer.

...

> +	if (lgpio->chip_data->label)
> +		lgpio->chip.label = lgpio->chip_data->label;
> +	else
> +		lgpio->chip.label = kstrdup(to_platform_device(dev)->name, GFP_KERNEL);

No error check? Not a devm_*() variant, so leaking memory?

...

> +	{
> +		.id = "LOON0007",
> +	},

How does DSDT excerpt for this device look like?

-- 
With Best Regards,
Andy Shevchenko


