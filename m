Return-Path: <linux-kernel+bounces-79799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C528626ED
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C87A1C20A89
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061064A9BF;
	Sat, 24 Feb 2024 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwLXVzvj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28179EDE;
	Sat, 24 Feb 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708802174; cv=none; b=IbBDr80QRmdEarFQZV704TYN6keY17ckkEpkMd2IlSZk8tJK23L8v1gCm5+SnPk0KA6TgH9wefRZBo7LV+aqufjtvQsjYuiBIIBOXf3eC0Q/ksGsaS2epnBh9x+l1286e7fs1346hYvW1EeFVxiS9uA+PAFBiN6BLs6xfBvzd1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708802174; c=relaxed/simple;
	bh=5FBe6gIH2VSgqewGABuk95/AUKFSgRWfUj0Hvjtw1T8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtAnRMqin0bOtUvTvjiurD68AAeeuUeGa/eNaAHZkoKIKi7FscRUq3tB+hVYFHSmOCUqWEfZjqO8MPE3JFyrlhSdDHxHaz8gf+j19slhjNEAuIpyuWizOzz/tXd5i0BzYcAN0ivp6NWiD8qvIcFhjLbYaSPUJB8i/6nqWsknqWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwLXVzvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A510C433F1;
	Sat, 24 Feb 2024 19:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708802173;
	bh=5FBe6gIH2VSgqewGABuk95/AUKFSgRWfUj0Hvjtw1T8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UwLXVzvjPu3+50+gP9yY2+lwUwblz2EK67plRHFNMyAEXlsFcpl3BTJUHIxCqX+PM
	 fc0/BvKcLSi47cvp7p8Nf3/A1l7zbjnVfEmhqgePdunVhTbiA1U7xit9pbOO+44NWh
	 NnvymaCH3aWUYgGun1gZpfKj0W4lduLO3B8z3VT03GaJKPfC62sIgWBmmRpHcB2BzF
	 sFSMzUKUFAx/p9WOQ9vyW+FM005RE1Aqb0w0LsJREIOLuikD8MxOvkYb5vGeXmfhTl
	 QgQUj90zt/ZZw6IxZ56n+HJOdUdNDBnirX54Oii50CUHvC7qkBmgHGLPedHua1wO6v
	 e4JS8Iph3ygVw==
Date: Sat, 24 Feb 2024 19:15:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <marius.cristea@microchip.com>
Cc: <lars@metafoo.de>, <robh+dt@kernel.org>, <jdelvare@suse.com>,
 <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] iio: adc: adding support for PAC193x
Message-ID: <20240224191559.40d233db@jic23-huawei>
In-Reply-To: <20240222164206.65700-3-marius.cristea@microchip.com>
References: <20240222164206.65700-1-marius.cristea@microchip.com>
	<20240222164206.65700-3-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 18:42:06 +0200
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip
> PAC193X series of Power Monitor with Accumulator chip family.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
So I had a few comments on this, but nothing that can't be cleaned up later.
+ I'll fix the thing the bots didn't like on the bindings.

Series applied to the togreg branch of iio.git and pushed out
as testing for 0-day to take a look at it.

Thanks,

Jonathan


> diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> new file mode 100644
> index 000000000000..a67fdaba940d
> --- /dev/null
> +++ b/drivers/iio/adc/pac1934.c


> +
> +/*
> + * documentation related to the ACPI device definition
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC1934-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
> + */
> +static bool pac1934_acpi_parse_channel_config(struct i2c_client *client,
> +					      struct pac1934_chip_info *info)
> +{
This should probably also return an int with 0 good and anything else having
a more meaningful error value if we can come up with one.

> +static bool pac1934_of_parse_channel_config(struct i2c_client *client,
> +					    struct pac1934_chip_info *info)

pac1934_fw_parse_channel_config seeing as code isn't of specific now.

Also return negative error or zero so that you can provide a more
meaningful return value in probe + it will be handy when
we make use of the device_for_each_child_node_scoped() in here
(that's so new I'm not asking people to use it this cycle).

Can make these changes later as part of the changes to use
new infrastructure I mention below.

> +{
> +	struct fwnode_handle *node, *fwnode;
> +	struct device *dev = &client->dev;
> +	unsigned int current_channel;
> +	int idx, ret;
> +
> +	info->sample_rate_value = 1024;
> +	current_channel = 1;
> +
> +	fwnode = dev_fwnode(dev);
> +	fwnode_for_each_available_child_node(fwnode, node) {

Ah this. Did we discuss this in earlier versions?
Been a while so I've forgotten.

	device_for_each_child_node() is actually implemented to only
allow for available nodes.  So you can use that directly here.
It's weird, and we've raised it several times with the fwnode
folk.

Seeing as we'll probably convert this shortly to
device_for_each_child_node_scoped() we can deal with that detail
as part of that patch.


> +		ret = fwnode_property_read_u32(node, "reg", &idx);
> +		if (ret) {
> +			dev_err_probe(dev, ret,
> +				      "reading invalid channel index\n");
> +			goto err_fwnode;
> +		}
> +		/* adjust idx to match channel index (1 to 4) from the datasheet */
> +		idx--;
> +
> +		if (current_channel >= (info->phys_channels + 1) ||
> +		    idx >= info->phys_channels || idx < 0) {
> +			dev_err_probe(dev, -EINVAL,
> +				      "%s: invalid channel_index %d value\n",
> +				      fwnode_get_name(node), idx);
> +			goto err_fwnode;
> +		}
> +
> +		/* enable channel */
> +		info->active_channels[idx] = true;
> +
> +		ret = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms",
> +					       &info->shunts[idx]);
> +		if (ret) {
> +			dev_err_probe(dev, ret,
> +				      "%s: invalid shunt-resistor value: %d\n",
> +				      fwnode_get_name(node), info->shunts[idx]);
> +			goto err_fwnode;
> +		}
> +
> +		if (fwnode_property_present(node, "label")) {
> +			ret = fwnode_property_read_string(node, "label",
> +							  (const char **)&info->labels[idx]);
> +			if (ret) {
> +				dev_err_probe(dev, ret,
> +					      "%s: invalid rail-name value\n",
> +					      fwnode_get_name(node));
> +				goto err_fwnode;
> +			}
> +		}
> +
> +		info->bi_dir[idx] = fwnode_property_read_bool(node, "bipolar");
> +
> +		current_channel++;
> +	}
> +
> +	return true;
> +
> +err_fwnode:
> +	fwnode_handle_put(node);
> +
> +	return false;
> +}

> +static int pac1934_prep_iio_channels(struct pac1934_chip_info *info, struct iio_dev *indio_dev)
> +{
> +	struct iio_chan_spec *ch_sp;
> +	int channel_size, attribute_count, cnt;
> +	void *dyn_ch_struct, *tmp_data;
> +	struct device *dev = &info->client->dev;
> +
> +	/* find out dynamically how many IIO channels we need */
> +	attribute_count = 0;
> +	channel_size = 0;
> +	for (cnt = 0; cnt < info->phys_channels; cnt++) {
> +		if (!info->active_channels[cnt])
> +			continue;
> +
> +		/* add the size of the properties of one chip physical channel */
> +		channel_size += sizeof(pac1934_single_channel);
> +		/* count how many enabled channels we have */
> +		attribute_count += ARRAY_SIZE(pac1934_single_channel);
> +		dev_info(dev, ":%s: Channel %d active\n",
dev_dbg()
This is too noisy really given I'd assume that's easy to establish
after the driver is loaded. If nothing else comes up I'll make this dev_dbg
whilst applying.
> +			 __func__, cnt + 1);
> +	}



