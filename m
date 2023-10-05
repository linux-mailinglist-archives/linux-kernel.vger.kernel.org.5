Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F10C7BA1B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbjJEOqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239258AbjJEOmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:42:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB7687407;
        Thu,  5 Oct 2023 07:17:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB1EC433B8;
        Thu,  5 Oct 2023 07:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696489850;
        bh=4Cea+AQlqVlvzP0f0/MWGhbo/vqvAJn2RycUTruhyG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhNHaN+F1gbpSF0jOZwD6aFEEifwVVGOTaY3n1LTPTJidCroXM183dtuLeqia92jc
         7LCru0QYBIrRAlBq5TbDd02SoeEYNw4rvlVlLAReKVReQYdl8wchcb++N0+w2lHQUE
         4bYiz36Dgq2ymusSQXqYgsPH/lAkeplbUPktguGH05jFamvh4Sug8N2Lkhj3m5qHET
         unG0zJ/vYcrqZLQJ1S4nqUEAMkQ4TuREdhiFaQgXMCE8tQmAbLqbg5/7aMRII/48Wm
         xgKiAQ3n5vLUDM2anZHGzxB1UHr5IjgVVKbJ9vmJDWJdCqxpkL+RbsC4Z+TW3L2Cmk
         zqSoVwfU0lSnw==
Date:   Thu, 5 Oct 2023 09:10:45 +0200
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2] HID: i2c-hid: fix handling of unpopulated devices
Message-ID: <cnnjghxj4od6fniotztlgorc7myzya2bsvixkf2cpk4metcipa@r2w2ouob5ths>
References: <20231002155857.24584-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002155857.24584-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 02 2023, Johan Hovold wrote:
> A recent commit reordered probe so that the interrupt line is now
> requested before making sure that the device exists.
> 
> This breaks machines like the Lenovo ThinkPad X13s which rely on the
> HID driver to probe second-source devices and only register the variant
> that is actually populated. Specifically, the interrupt line may now
> already be (temporarily) claimed when doing asynchronous probing of the
> touchpad:
> 
> 	genirq: Flags mismatch irq 191. 00082008 (hid-over-i2c) vs. 00082008 (hid-over-i2c)
> 	i2c_hid_of 21-0015: Could not register for hid-over-i2c interrupt, irq = 191, ret = -16
> 	i2c_hid_of: probe of 21-0015 failed with error -16
> 
> Fix this by restoring the old behaviour of first making sure the device
> exists before requesting the interrupt line.
> 
> Note that something like this should probably be implemented also for
> "panel followers", whose actual probe is currently effectively deferred
> until the DRM panel is probed (e.g. by powering down the device after
> making sure it exists and only then register it as a follower).
> 
> Fixes: 675cd877c952 ("HID: i2c-hid: Rearrange probe() to power things up later")
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Changes in v2
>  - initialise ihid->is_panel_follower sooner to avoid repeated property
>    lookups and so that it can be used consistently throughout the driver
>    for code that differs for "panel followers"

Patches looks good to me, but I can not test it unfortunately.

Doug, would you mind sending us your Ack or tested-by?

Cheers,
Benjamin


> 
> Link to v1: https://lore.kernel.org/lkml/20230918125851.310-1-johan+linaro@kernel.org/
> 
> 
>  drivers/hid/i2c-hid/i2c-hid-core.c | 144 ++++++++++++++++-------------
>  1 file changed, 81 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 9601c0605fd9..2735cd585af0 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -998,45 +998,29 @@ static int i2c_hid_core_resume(struct i2c_hid *ihid)
>  	return hid_driver_reset_resume(hid);
>  }
>  
> -/**
> - * __do_i2c_hid_core_initial_power_up() - First time power up of the i2c-hid device.
> - * @ihid: The ihid object created during probe.
> - *
> - * This function is called at probe time.
> - *
> - * The initial power on is where we do some basic validation that the device
> - * exists, where we fetch the HID descriptor, and where we create the actual
> - * HID devices.
> - *
> - * Return: 0 or error code.
> +/*
> + * Check that the device exists and parse the HID descriptor.
>   */
> -static int __do_i2c_hid_core_initial_power_up(struct i2c_hid *ihid)
> +static int __i2c_hid_core_probe(struct i2c_hid *ihid)
>  {
>  	struct i2c_client *client = ihid->client;
>  	struct hid_device *hid = ihid->hid;
>  	int ret;
>  
> -	ret = i2c_hid_core_power_up(ihid);
> -	if (ret)
> -		return ret;
> -
>  	/* Make sure there is something at this address */
>  	ret = i2c_smbus_read_byte(client);
>  	if (ret < 0) {
>  		i2c_hid_dbg(ihid, "nothing at this address: %d\n", ret);
> -		ret = -ENXIO;
> -		goto err;
> +		return -ENXIO;
>  	}
>  
>  	ret = i2c_hid_fetch_hid_descriptor(ihid);
>  	if (ret < 0) {
>  		dev_err(&client->dev,
>  			"Failed to fetch the HID Descriptor\n");
> -		goto err;
> +		return ret;
>  	}
>  
> -	enable_irq(client->irq);
> -
>  	hid->version = le16_to_cpu(ihid->hdesc.bcdVersion);
>  	hid->vendor = le16_to_cpu(ihid->hdesc.wVendorID);
>  	hid->product = le16_to_cpu(ihid->hdesc.wProductID);
> @@ -1050,17 +1034,49 @@ static int __do_i2c_hid_core_initial_power_up(struct i2c_hid *ihid)
>  
>  	ihid->quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
>  
> +	return 0;
> +}
> +
> +static int i2c_hid_core_register_hid(struct i2c_hid *ihid)
> +{
> +	struct i2c_client *client = ihid->client;
> +	struct hid_device *hid = ihid->hid;
> +	int ret;
> +
> +	enable_irq(client->irq);
> +
>  	ret = hid_add_device(hid);
>  	if (ret) {
>  		if (ret != -ENODEV)
>  			hid_err(client, "can't add hid device: %d\n", ret);
> -		goto err;
> +		disable_irq(client->irq);
> +		return ret;
>  	}
>  
>  	return 0;
> +}
> +
> +static int i2c_hid_core_probe_panel_follower(struct i2c_hid *ihid)
> +{
> +	int ret;
> +
> +	ret = i2c_hid_core_power_up(ihid);
> +	if (ret)
> +		return ret;
>  
> -err:
> +	ret = __i2c_hid_core_probe(ihid);
> +	if (ret)
> +		goto err_power_down;
> +
> +	ret = i2c_hid_core_register_hid(ihid);
> +	if (ret)
> +		goto err_power_down;
> +
> +	return 0;
> +
> +err_power_down:
>  	i2c_hid_core_power_down(ihid);
> +
>  	return ret;
>  }
>  
> @@ -1077,7 +1093,7 @@ static void ihid_core_panel_prepare_work(struct work_struct *work)
>  	 * steps.
>  	 */
>  	if (!hid->version)
> -		ret = __do_i2c_hid_core_initial_power_up(ihid);
> +		ret = i2c_hid_core_probe_panel_follower(ihid);
>  	else
>  		ret = i2c_hid_core_resume(ihid);
>  
> @@ -1136,7 +1152,6 @@ static int i2c_hid_core_register_panel_follower(struct i2c_hid *ihid)
>  	struct device *dev = &ihid->client->dev;
>  	int ret;
>  
> -	ihid->is_panel_follower = true;
>  	ihid->panel_follower.funcs = &i2c_hid_core_panel_follower_funcs;
>  
>  	/*
> @@ -1156,30 +1171,6 @@ static int i2c_hid_core_register_panel_follower(struct i2c_hid *ihid)
>  	return 0;
>  }
>  
> -static int i2c_hid_core_initial_power_up(struct i2c_hid *ihid)
> -{
> -	/*
> -	 * If we're a panel follower, we'll register and do our initial power
> -	 * up when the panel turns on; otherwise we do it right away.
> -	 */
> -	if (drm_is_panel_follower(&ihid->client->dev))
> -		return i2c_hid_core_register_panel_follower(ihid);
> -	else
> -		return __do_i2c_hid_core_initial_power_up(ihid);
> -}
> -
> -static void i2c_hid_core_final_power_down(struct i2c_hid *ihid)
> -{
> -	/*
> -	 * If we're a follower, the act of unfollowing will cause us to be
> -	 * powered down. Otherwise we need to manually do it.
> -	 */
> -	if (ihid->is_panel_follower)
> -		drm_panel_remove_follower(&ihid->panel_follower);
> -	else
> -		i2c_hid_core_suspend(ihid, true);
> -}
> -
>  int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
>  		       u16 hid_descriptor_address, u32 quirks)
>  {
> @@ -1211,6 +1202,7 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
>  	ihid->ops = ops;
>  	ihid->client = client;
>  	ihid->wHIDDescRegister = cpu_to_le16(hid_descriptor_address);
> +	ihid->is_panel_follower = drm_is_panel_follower(&client->dev);
>  
>  	init_waitqueue_head(&ihid->wait);
>  	mutex_init(&ihid->reset_lock);
> @@ -1224,14 +1216,10 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
>  		return ret;
>  	device_enable_async_suspend(&client->dev);
>  
> -	ret = i2c_hid_init_irq(client);
> -	if (ret < 0)
> -		goto err_buffers_allocated;
> -
>  	hid = hid_allocate_device();
>  	if (IS_ERR(hid)) {
>  		ret = PTR_ERR(hid);
> -		goto err_irq;
> +		goto err_free_buffers;
>  	}
>  
>  	ihid->hid = hid;
> @@ -1242,19 +1230,42 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
>  	hid->bus = BUS_I2C;
>  	hid->initial_quirks = quirks;
>  
> -	ret = i2c_hid_core_initial_power_up(ihid);
> +	/* Power on and probe unless device is a panel follower. */
> +	if (!ihid->is_panel_follower) {
> +		ret = i2c_hid_core_power_up(ihid);
> +		if (ret < 0)
> +			goto err_destroy_device;
> +
> +		ret = __i2c_hid_core_probe(ihid);
> +		if (ret < 0)
> +			goto err_power_down;
> +	}
> +
> +	ret = i2c_hid_init_irq(client);
> +	if (ret < 0)
> +		goto err_power_down;
> +
> +	/*
> +	 * If we're a panel follower, we'll register when the panel turns on;
> +	 * otherwise we do it right away.
> +	 */
> +	if (ihid->is_panel_follower)
> +		ret = i2c_hid_core_register_panel_follower(ihid);
> +	else
> +		ret = i2c_hid_core_register_hid(ihid);
>  	if (ret)
> -		goto err_mem_free;
> +		goto err_free_irq;
>  
>  	return 0;
>  
> -err_mem_free:
> -	hid_destroy_device(hid);
> -
> -err_irq:
> +err_free_irq:
>  	free_irq(client->irq, ihid);
> -
> -err_buffers_allocated:
> +err_power_down:
> +	if (!ihid->is_panel_follower)
> +		i2c_hid_core_power_down(ihid);
> +err_destroy_device:
> +	hid_destroy_device(hid);
> +err_free_buffers:
>  	i2c_hid_free_buffers(ihid);
>  
>  	return ret;
> @@ -1266,7 +1277,14 @@ void i2c_hid_core_remove(struct i2c_client *client)
>  	struct i2c_hid *ihid = i2c_get_clientdata(client);
>  	struct hid_device *hid;
>  
> -	i2c_hid_core_final_power_down(ihid);
> +	/*
> +	 * If we're a follower, the act of unfollowing will cause us to be
> +	 * powered down. Otherwise we need to manually do it.
> +	 */
> +	if (ihid->is_panel_follower)
> +		drm_panel_remove_follower(&ihid->panel_follower);
> +	else
> +		i2c_hid_core_suspend(ihid, true);
>  
>  	hid = ihid->hid;
>  	hid_destroy_device(hid);
> -- 
> 2.41.0
> 
