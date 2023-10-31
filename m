Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820C47DCBE7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343767AbjJaLgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjJaLgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:36:48 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78E6DB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:36:43 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id xn2xqgsfSOWoRxn2xqgwky; Tue, 31 Oct 2023 12:36:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698752202;
        bh=9KvNXF6pEJh/jTsRIm8nizvmtEilekGphzqImz455pY=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=V5S0NbEIvGxPADjcYc+bU1NBTQLnjjvHHkEN7xNE+/mV2HlGqpWkqYH4cjh+svGnI
         XtohOlwTVUntCBSWXn3bSAx8o8ebKZU7MTjoDADiubzAD/E2gfSwc4ULzrnhZZUZOh
         y6i97d4QloK2R0cvq19YWCwdnVYObE1JSkZKhLitIKT4z/L4AJWQqRg6b7VVLwwmWu
         0MYTbqd28wFE984H7arsrGMLrBsFI4PC81xJ3AYj8G34xC5P197n6dz4/Efar6Q0ii
         +x2iPmbZn9lbx52pcnpvNF2OZmDuHvT8yd6ruQd1Zaedx2ojy9WOK2YKKPFFZHLVXe
         aK3CI9WbQ92fw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 31 Oct 2023 12:36:42 +0100
X-ME-IP: 86.243.2.178
Message-ID: <e1a06870-985a-4041-a21d-83d99d731fd6@wanadoo.fr>
Date:   Tue, 31 Oct 2023 12:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers: rtc: max31335: initial commit
Content-Language: fr
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20231030115016.97823-1-antoniu.miclaus@analog.com>
 <20231030115016.97823-3-antoniu.miclaus@analog.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231030115016.97823-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30/10/2023 à 12:50, Antoniu Miclaus a écrit :
> RTC driver for MAX31335 ±2ppm Automotive Real-Time Clock with
> Integrated MEMS Resonator.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +static bool max31335_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	/* time keeping registers */
> +	if (reg >= MAX31335_SECONDS &&
> +	    reg < MAX31335_SECONDS + MAX31335_TIME_SIZE)
> +		return true;
> +
> +	/* interrupt status register */
> +	if (reg == MAX31335_INT_EN1_A1IE)
> +		return true;
> +
> +	/* temperature registers */
> +	if (reg == MAX31335_TEMP_DATA_MSB || MAX31335_TEMP_DATA_LSB)
> +		return true;

return false otherwise?

CJ

> +}

...

