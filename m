Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CBF765EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjG0WDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjG0WDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:03:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45B3100;
        Thu, 27 Jul 2023 15:03:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C4B961F5D;
        Thu, 27 Jul 2023 22:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B53C433C8;
        Thu, 27 Jul 2023 22:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690495386;
        bh=pUFypZ6Op1liCm0dzOBMukorJ2DZC8LJEzU599aSVtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0cXAlpp/tK2f18TcHP5uj4xabU+OlalONQ46BQJt7NLeEr5bAouFbf+xz5Gveuzd
         PLqd7U5xN7KWtnLeq5OJdpspEFI8KYtMP29KzUWrGWBkyaWGm4iDsL62FGtLkiDJJl
         vDinOgZL+IqNBZ2Ju69pb/6gfXyBwQRIURNwVcQCQEHPEsmHPSYrj5l913KryFKikF
         H5uBVp+d4Q2Lb8Xlu+wjxEsFyh5g40hGLJP86cGpqQruHiz2z8xDim/hyY98ICpcFn
         h+SNZ8xhKvmYRvJiK0XQ27mlFuwYKuA5gysVDOaEuWHqYoBScvgfIW5iotnqnl2DRF
         lUnbTFTvwt7bg==
Date:   Fri, 28 Jul 2023 00:03:04 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Johannes Roith <johannes@gnu-linux.rocks>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH] hid-mcp2200: added driver for GPIOs of MCP2200
Message-ID: <20230727220304.a7vgqfuboeilxhgb@intel.intel>
References: <20230623110145.92566-1-johannes@gnu-linux.rocks>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623110145.92566-1-johannes@gnu-linux.rocks>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Fri, Jun 23, 2023 at 01:01:45PM +0200, Johannes Roith wrote:
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

Just one note... please add a versioning to your patches and a
changelog.

I saw that your previous version did not receive any reply
(sorry)... in that case you could add a prefix RESEND.

So that this patch would look like:

	[PATCH RESEND v3] hid-mcp2200: Added driver for GPIOs of MCP2200

(note "Added" with capital letter)

[...]

> +/* Altternative pin assignments */

Alternative

> +#define TXLED		2
> +#define RXLED		3
> +#define USBCFG		6
> +#define SSPND		7
> +#define MCP_NGPIO	8

[...]

> +static int mcp_cmd_read_all(struct mcp2200 *mcp)
> +{
> +	struct mcp_read_all *read_all;
> +	int len, t;
> +
> +	reinit_completion(&mcp->wait_in_report);
> +	read_all = kzalloc(sizeof(struct mcp_read_all), GFP_KERNEL);
> +	if (!read_all)
> +		return -ENOMEM;

any reason for allocating read_all dynamically?

> +
> +	read_all->cmd = READ_ALL;
> +
> +	mutex_lock(&mcp->lock);
> +	len = hid_hw_output_report(mcp->hdev, (u8 *) read_all,
> +			sizeof(struct mcp_read_all));

Please align "sizeof" with "mcp"

> +	mutex_unlock(&mcp->lock);
> +	kfree(read_all);
> +
> +	if (len != sizeof(struct mcp_read_all))
> +		return -EINVAL;
> +
> +	t = wait_for_completion_timeout(&mcp->wait_in_report, msecs_to_jiffies(4000));

not an error, just a suggestion... would be nice to keep lines
withing 80 characters whenever possible... and here it's possible :)

> +	if (!t)
> +		return -ETIMEDOUT;
> +
> +	/* return status, negative value if wrong response was received */
> +	return mcp->status;
> +}
> +
> +static void mcp_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> +				  unsigned long *bits)

please align "struct" with "unsigned"

> +{
> +	struct mcp2200 *mcp = gpiochip_get_data(gc);
> +	u8 value;
> +	int status;
> +	struct mcp_set_clear_outputs *cmd;
> +
> +	cmd = kzalloc(sizeof(struct mcp_set_clear_outputs), GFP_KERNEL);
> +	if (!cmd)
> +		return;
> +
> +	mutex_lock(&mcp->lock);
> +
> +	value = mcp->gpio_val & ~*mask;
> +	value |= (*mask & *bits);
> +
> +	cmd->cmd = SET_CLEAR_OUTPUTS;
> +	cmd->set_bmap = value;
> +	cmd->clear_bmap = ~(value);
> +
> +	status = hid_hw_output_report(mcp->hdev, (u8 *) cmd,
> +		       sizeof(struct mcp_set_clear_outputs));
> +
> +	mutex_unlock(&mcp->lock);
> +	kfree(cmd);

again, any reason for allocating dynamically cmd?

> +	if (status == sizeof(struct mcp_set_clear_outputs))
> +		mcp->gpio_val = value;

should this be inside the lock?

> +}

[...]

> +static int mcp_get(struct gpio_chip *gc, unsigned int gpio_nr)
> +{
> +	unsigned long mask = 0, bits = 0;
> +
> +	mask = (1 << gpio_nr);
> +	mcp_get_multiple(gc, &mask, &bits);
> +	return (bits > 0) ? 1 : 0;

eventually you could just:

	return bits > 0;

> +}

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

Is it dev_err_probe() preferred to hid_err() here?

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

hit_hw_stop()?

Maybe a goto is better?

Andi

> +		return ret;
> +
> +	mcp->gc = template_chip;
> +	mcp->gc.parent = &hdev->dev;
> +
> +	ret = gpiochip_add_data(&mcp->gc, mcp);
> +	if (ret < 0) {
> +		dev_err(&hdev->dev, "Unable to register gpiochip\n");
> +		hid_hw_stop(hdev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
