Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3842A7905CA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351730AbjIBHfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjIBHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:35:20 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DF290;
        Sat,  2 Sep 2023 00:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693640115;
        bh=9xMdGiESgscmhwAbix3Q4d0UwO37JeCDRpwrHEAP68I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBIuehy0Z3tktPa/0j8H/2O2yz6nKtakM5Dyhswz5zdjBnQk4m5zpsz3QYD4DlAAZ
         9NzZ9SECeclDoTpJ7Fe7LGNaDf/7LSVTpHKUizktyYqdDulZ5R9CBCYVDJQD3HgiSw
         ycdJkAhkv9nZNqs9P5mrP2f8PhZn5BVtgjZvjUGk=
Date:   Sat, 2 Sep 2023 09:35:14 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: add POWER-Z driver
Message-ID: <2bdf5aa0-9fe6-40b1-bec2-3dedc9094949@t-8ch.de>
References: <20230902-powerz-v3-1-ed78d450c6c3@weissschuh.net>
 <61fae328-e56d-f999-1613-160987dcefa6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61fae328-e56d-f999-1613-160987dcefa6@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-01 17:30:04-0700, Guenter Roeck wrote:
> On 9/1/23 15:36, Thomas Weißschuh wrote:
> [..]

> > diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c
> > new file mode 100644
> > index 000000000000..6209339e5414
> > --- /dev/null
> > +++ b/drivers/hwmon/powerz.c

>[..]

> > +static int powerz_read_string(struct device *dev, enum hwmon_sensor_types type,
> > +			      u32 attr, int channel, const char **str)
> > +{
> > +	if (type == hwmon_curr && attr == hwmon_curr_label) {
> > +		*str = "IBUS";
> > +	} else if (type == hwmon_in && attr == hwmon_in_label) {
> > +		if (channel == 0)
> > +			*str = "VBUS";
> > +		else if (type == hwmon_in && attr == hwmon_in_label && channel == 1)
> > +			*str = "VCC1";
> > +		else if (type == hwmon_in && attr == hwmon_in_label && channel == 2)
> > +			*str = "VCC2";
> > +		else if (type == hwmon_in && attr == hwmon_in_label && channel == 3)
> > +			*str = "VDP";
> > +		else if (type == hwmon_in && attr == hwmon_in_label && channel == 4)
> > +			*str = "VDM";
> > +		else if (type == hwmon_in && attr == hwmon_in_label && channel == 5)
> > +			*str = "VDD";
> 
> All those repeated "type == hwmon_in && attr == hwmon_in_label" checks are
> unnecessary. Note that this could be much simpler written as
> 
> 	const char *in_labels[] = {
> 		"VBUS", "VCC1", "VCC2", "VDP", "VDM", "VDD"
> 	};
> 	...
> 	*str = in_labels[channel];
> 
> but I'll leave that up to you.

I prefer the current style for consistency.
But I dropped all the redundant comparisions of type and attr.

> [..]

> > +static int powerz_read(struct device *dev, enum hwmon_sensor_types type,
> > +		       u32 attr, int channel, long *val)
> > +{
> > +	struct usb_interface *intf = to_usb_interface(dev->parent);
> > +	struct usb_device *udev = interface_to_usbdev(intf);
> > +	struct powerz_priv *priv = usb_get_intfdata(intf);
> > +	struct powerz_sensor_data *data;
> > +	int ret;
> > +
> > +	if (!priv)
> > +		return -EIO; /* disconnected */
> > +
> > +	mutex_lock(&priv->mutex);
> > +	ret = powerz_read_data(udev, priv);
> > +	if (ret)
> > +		goto out;
> > +
> > +	data = (struct powerz_sensor_data *)priv->transfer_buffer;
> > +
> > +	if (type == hwmon_curr) {
> > +		if (attr == hwmon_curr_input)
> > +			*val = ((s32)le32_to_cpu(data->I_bus)) / 1000;
> > +		else if (attr == hwmon_curr_average)
> > +			*val = ((s32)le32_to_cpu(data->I_bus_avg)) / 1000;
> 
> Just wondering ... does this device really report current in micro-amps ?

Yes, the device has its own display and the values on the display and
in hwmon match.

> [..]

> > +		else
> > +			ret = -EOPNOTSUPP;
> > +	} else if (type == hwmon_in) {
> > +		if (attr == hwmon_in_input) {
> > +			if (channel == 0)
> > +				*val = le32_to_cpu(data->V_bus) / 1000;
> 
> and voltage in micro-volt ? Just asking, because I don't think I have
> ever seen that.

Yes, the same as for the current.

> > +			else if (channel == 1)
> > +				*val = le16_to_cpu(data->V_cc1) / 10;
> > +			else if (channel == 2)
> > +				*val = le16_to_cpu(data->V_cc2) / 10;
> > +			else if (channel == 3)
> > +				*val = le16_to_cpu(data->V_dp) / 10;
> > +			else if (channel == 4)
> > +				*val = le16_to_cpu(data->V_dm) / 10;
> > +			else if (channel == 5)
> > +				*val = le16_to_cpu(data->V_dd) / 10;
> > +			else
> > +				ret = -EOPNOTSUPP;
> > +		} else if (attr == hwmon_in_average && channel == 0) {
> > +			*val = le32_to_cpu(data->V_bus_avg) / 1000;
> > +		} else if (attr == hwmon_in_min && channel == 0) {
> > +			*val = -POWERZ_MAX_VOLTAGE;
> > +		} else if (attr == hwmon_in_max && channel == 0) {
> > +			*val = POWERZ_MAX_VOLTAGE;
> > +		} else {
> 
> There are more repeated checks (for channel == 0) here. Not that it matters,
> because the constants should not bre reported anyway. Also, I do wonder if
> hwmon_in_min == -POWERZ_MAX_VOLTAGE is really correct.

Current can flow in both directions through the device. The sign
indicates the direction. I'll add a note for that to the documentation.

> 
> > +			ret = -EOPNOTSUPP;
> > +		}
> > +	} else if (type == hwmon_temp && attr == hwmon_temp_input) {
> > +		*val =
> > +		    ((long)data->temp[1]) * 2000 +
> > +		    ((long)data->temp[0]) * 1000 / 128;
> 
> I guess this is really ((data->temp[1] << 8) + data->temp[0]) * 1000 / 128,
> which might be easier to understand, but good enough. The typecasts are
> unnecessary, though.

No, it's really "* 2000".

Dropped the casts.
