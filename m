Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C75280BB21
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 14:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjLJNjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 08:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjLJNjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 08:39:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749D9FE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 05:39:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE144C433C8;
        Sun, 10 Dec 2023 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702215552;
        bh=avQGx1khJq85b1wqGdR8Nraqua+bOgRavFBFOL0oL0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c+u5501+Z7AkUNDfgRWa6dbaByLXiqMukJRuFtnLzBvS69MfOyQRkAM+xGjeeWelk
         S9Bx5gJ1HA+LuhPzWiJ9bcUCmR1ep71GdfXK06Q+MxJOwYdmXkp3MD4EwrsPdGOVta
         Uhk4ETWGtDWRX9GFuuArs7uHGE1OJXTsBVEQMMTEhqf6RKXFGrOQb1hSHBWeJn94ZN
         D2VePs2y/Dd6igp1wBhV1B/9CyDadpTyRYncVay7PE8VUSLipEYo7OCsw4W1WqiJ/w
         1NCHHH7kXT14eHmCRyifkEqcHda3VrRqe+1CuPqSIXm1+DJ8CIRQMQCJ1izU1UbO1l
         4thf5+f1Ee2Tg==
Date:   Sun, 10 Dec 2023 13:39:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3 2/2] iio: light: driver for Lite-On ltr390
Message-ID: <20231210133906.3050a145@jic23-huawei>
In-Reply-To: <20231208102211.413019-2-anshulusr@gmail.com>
References: <20231208102211.413019-1-anshulusr@gmail.com>
        <20231208102211.413019-2-anshulusr@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Dec 2023 15:52:10 +0530
Anshul Dalal <anshulusr@gmail.com> wrote:

> Implements driver for the Ambient/UV Light sensor LTR390.
> The driver exposes two ways of getting sensor readings:
>   1. Raw UV Counts directly from the sensor
>   2. The computed UV Index value with a percision of 2 decimal places
> 
> [NOTE] Ambient light sensing has not been implemented yet.
> 
> Driver tested on RPi Zero 2W
> 
> Datasheet: https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>

I fixed up the case where you use dev_err_probe() in a path called from
places other than the probe() callback.

Applied to the togreg branch of iio.git and initially pushed out as testing for 0-day
to take a look and see if it can find things we missed

Thanks,

Jonathan


> +
> +static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
> +{
> +	struct device *dev = &data->client->dev;
> +	int ret;
> +	u8 recieve_buffer[3];
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = regmap_bulk_read(data->regmap, register_address, recieve_buffer,
> +			       sizeof(recieve_buffer));
> +	if (ret)
> +		return dev_err_probe(dev, ret,
dev_err_probe() is only intended for use in probe() and functions that are
only called from probe()
> +				     "failed to read measurement data");
> +
> +	return get_unaligned_le24(recieve_buffer);
> +}

