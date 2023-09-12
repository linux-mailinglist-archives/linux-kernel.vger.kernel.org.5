Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF579DA2F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjILUhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjILUhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:37:50 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AF310D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:37:46 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gA8gqd7Tg4d7DgA8gqXZ6T; Tue, 12 Sep 2023 22:37:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694551059;
        bh=lMcb8WrFX7B6OJqoOfSUz/GFKwhDlyO9IScBhzlH2nY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NUYtJ1+M46Jm22jKLcunMpM+YLbndMczChoBGBxX6qMcUWkn2FF+NjlONpdrrhyJv
         fm5z3kbVUblgnZe1UGlSADIi6wPS1NuiSa/R3YqXFGi9Qz8AT0jKVedzc2XccgdYgj
         irV/jNn+uBmbH7MX1EzHxFmPArp7EYMhgZPN3cMbXx/VNnqcUTTuvvYHPWiSjtigYA
         iPxmhOXGeWPVRePF1sY1tZGrUq9/THDVmGBfVJ3n9bVLy/PXNpi9FCuKsTUBTyPYZk
         O2JvRGDc5P5HYHRFWhcrPOzsVa4Sdt+TukSgtaKGDDxf69tQyCHQ77rhyt54hdQHce
         ymx2867p8gGMA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Sep 2023 22:37:39 +0200
X-ME-IP: 86.243.2.178
Message-ID: <eab4324a-9e46-fa07-b849-792eba613ac8@wanadoo.fr>
Date:   Tue, 12 Sep 2023 22:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/3] power: supply: bq24190_charger: Export current
 regulator
Content-Language: fr, en-US
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Alexandre Courbot <acourbot@nvidia.com>,
        azkali <a.ffcc7@gmail.com>, CTCaer <ctcaer@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824112741.201353-1-linkmauve@linkmauve.fr>
 <20230824131342.206784-1-linkmauve@linkmauve.fr>
 <20230824131342.206784-4-linkmauve@linkmauve.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230824131342.206784-4-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/08/2023 à 15:13, Emmanuel Gil Peyrot a écrit :
> From: Alexandre Courbot <acourbot@nvidia.com>
> 
> This prevents the charger from ever going over the current limit.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>   drivers/power/supply/bq24190_charger.c | 82 ++++++++++++++++++++++++++
>   1 file changed, 82 insertions(+)
> 
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index a56122b39687..cc1bd87f4982 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -530,6 +530,79 @@ static int bq24190_set_otg_vbus(struct bq24190_dev_info *bdi, bool enable)
>   }
>   
>   #ifdef CONFIG_REGULATOR
> +static int bq24190_set_charging_current(struct regulator_dev *dev,
> +			int min_uA, int max_uA)
> +{
> +	struct bq24190_dev_info *bdi = rdev_get_drvdata(dev);
> +	u8 ss_reg;
> +	int in_current_limit;
> +	int ret = 0;

Nit: Un-needed init.

> +
> +	ret = bq24190_read(bdi, BQ24190_REG_SS, &ss_reg);
> +	if (ret < 0)
> +		goto error;
> +
> +	if (max_uA == 0 && ss_reg != 0)
> +		return ret;

ret is known to be 0 here. If it is the intension, return 0 would be 
more explicit. Otherwise a ret = -<error_code> is missing.

Just my 2c,

CJ

> +
> +	if (!(ss_reg & BQ24190_REG_SS_VBUS_STAT_MASK))
> +		in_current_limit = 500;
> +	else
> +		in_current_limit = max_uA / 1000;
> +
> +	return bq24190_set_field_val(bdi, BQ24190_REG_ISC,
> +			BQ24190_REG_ISC_IINLIM_MASK,
> +			BQ24190_REG_ISC_IINLIM_SHIFT,
> +			bq24190_isc_iinlim_values,
> +			ARRAY_SIZE(bq24190_isc_iinlim_values),
> +			in_current_limit);
> +error:
> +	dev_err(bdi->dev, "Charger enable failed, err = %d\n", ret);
> +	return ret;
> +}

...

