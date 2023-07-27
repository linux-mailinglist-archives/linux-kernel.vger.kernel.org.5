Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A504765F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjG0WbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjG0WbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:31:11 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47392D64
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:31:07 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id P9VVqbVLtZ2imP9VVqfM8s; Fri, 28 Jul 2023 00:30:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690497055;
        bh=8ZtGc7eAE3vydkluaMlog20pWI9ZZcI5Fz1U2oENkHQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=s8cpxSP6oQl8AdAJXKe58Hy1LnFfcd+o4wyxEyC9ikpOyyIizv/j4QK3DZsPpRUD5
         aG5zOYP2I/vHSyqBO6Mjv15RZL/AxwiYARZtzE61oI1qfrxPxeIshNSq8zdCPTmCyD
         KykgPjPR1Jq+oyqY3MtmIDQTwYjA2Nr1pkEHsYOrp+pcSSTE9P26j1uBVN7Ml/Dulp
         Qyb75n+PgbE3wfDRaoSTreHU1tIOTHZBkVV8BBGYPtghw7txXp1QsL3aQmQrFGajYc
         fbqBojwt5Eo9MeWN3ZKTj7I4PlulNXpwwm+qKtaa7luXhV8uYlecsB5wBfU6fpokX4
         wLNKPNePcMuTg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Jul 2023 00:30:55 +0200
X-ME-IP: 86.243.2.178
Message-ID: <df1acc44-62c3-1ac6-103e-561baf8e38e4@wanadoo.fr>
Date:   Fri, 28 Jul 2023 00:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hid-mcp2200: added driver for GPIOs of MCP2200
Content-Language: fr, en-AU
To:     Johannes Roith <johannes@gnu-linux.rocks>, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        andi.shyti@kernel.org
References: <20230623110145.92566-1-johannes@gnu-linux.rocks>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230623110145.92566-1-johannes@gnu-linux.rocks>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/06/2023 à 13:01, Johannes Roith a écrit :
> Added a gpiochip compatible driver to control the 8 GPIOs of the MCP2200
> by using the HID interface.
> 
> Using GPIOs with alternative functions (GP0<->SSPND, GP1<->USBCFG,
> GP6<->RXLED, GP7<->TXLED) will reset the functions, if set (unset by
> default).
> 
> The driver was tested while also using the UART of the chip. Setting
> and reading the GPIOs has no effect on the UART communication. However,
> a reset is triggered after the CONFIGURE command. If the GPIO Direction
> is constantly changed, this will affect the communication at low baud
> rates. This is a hardware problem of the MCP2200 and is not caused by
> the driver.
> 
> Feedback from reviewers Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> and Andi Shyti <andi.shyti@kernel.org> was added.
> 
> Signed-off-by: Johannes Roith <johannes@gnu-linux.rocks>
> ---

[...]

> +static int mcp2200_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +	int ret;
> +	struct mcp2200 *mcp;
> +
> +	mcp = devm_kzalloc(&hdev->dev, sizeof(*mcp), GFP_KERNEL);
> +	if (!mcp)
> +		return -ENOMEM;
> +
> +	ret = hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "can't parse reports\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * This driver uses the .raw_event callback and therefore does not need any
> +	 * HID_CONNECT_xxx flags.
> +	 */
> +	ret = hid_hw_start(hdev, 0);
> +	if (ret) {
> +		hid_err(hdev, "can't start hardware\n");
> +		return ret;
> +	}
> +
> +	hid_info(hdev, "USB HID v%x.%02x Device [%s] on %s\n", hdev->version >> 8,
> +			hdev->version & 0xff, hdev->name, hdev->phys);
> +
> +	ret = hid_hw_open(hdev);
> +	if (ret) {
> +		hid_err(hdev, "can't open device\n");
> +		hid_hw_stop(hdev);
> +		return ret;
> +	}
> +
> +	mutex_init(&mcp->lock);
> +	init_completion(&mcp->wait_in_report);
> +	hid_set_drvdata(hdev, mcp);
> +	mcp->hdev = hdev;
> +
> +	ret = devm_add_action_or_reset(&hdev->dev, mcp2200_hid_unregister, hdev);
> +	if (ret)
> +		return ret;
> +
> +	mcp->gc = template_chip;
> +	mcp->gc.parent = &hdev->dev;
> +
> +	ret = gpiochip_add_data(&mcp->gc, mcp);

devm_gpiochip_add_data()?

> +	if (ret < 0) {
> +		dev_err(&hdev->dev, "Unable to register gpiochip\n");

hid_err() to be consistent?

> +		hid_hw_stop(hdev);

Isn't it already run by mcp2200_hid_unregister() registered a few lines 
above?

CJ

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void mcp2200_remove(struct hid_device *hdev)
> +{
> +	struct mcp2200 *mcp;
> +
> +	mcp = hid_get_drvdata(hdev);
> +	gpiochip_remove(&mcp->gc);
> +}
> +

[...]

