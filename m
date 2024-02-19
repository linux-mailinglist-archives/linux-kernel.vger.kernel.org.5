Return-Path: <linux-kernel+bounces-71525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BB585A6A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88471C210B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7120E381B0;
	Mon, 19 Feb 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1TbsRCfB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KGw0AHdW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1837700
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354580; cv=none; b=mFH1DIeqZpf9Q0watycs4DCD42y0cJRzRpT6eV4uMbTZP3JMTfoJ32wGShDiETvLWOg5uUjN9ybh0GhygtVXdaStoYFf4j8nAVI5frZVazSapMwYVj6ky+ZFtTjkHjCkMrkdxAYreN3alkdhMG9H8zaBl3mUCrHmv5Q1rB66fbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354580; c=relaxed/simple;
	bh=5zS63jNT/YDZjnZziU+0uuX/rDwvESQkJpZcGzWxcGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uq44vP3u4nLYf44LdHvXOz5dMefr6mmNNtaWP7Scu9P+IwLQ2UCuTvbWol6cwZQkPPTFFuMftgkFcg8qd4DqYrHk/Pr4BjUNcb5V/L9uEWgP2F0iufXwyIh+wm/AxeBal5cS2zAsBFWL93ICD+345JJcDX+cdS01h/vaIZOMPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1TbsRCfB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KGw0AHdW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708354576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHlyd8j6kp9DlA7pZO5MIaEPRDtqFTi7Fn9egV2/uZo=;
	b=1TbsRCfBkg8xzE+wTmL7H/x0n8DmT5KFb7XyeF3Xxlw4NW3vDAapxiZLp710VbAjs0EIwv
	rz2qUndZOeIwKk+D5TVexrxcGQJq76SUduImRIK25eFIqnrgdZHpUKBL0TCCqb1i0N+QXw
	qdRYiv9L9Q2HaX9kpWQh/WPnpTt7fFV4yOlr94sxZRK26aB5P8MkLZW1isb5F5WqJ73Xss
	INZcKNdNfKHQ3W7+2ysYb7SdviSw+d3IFkEJyMGO3sT9qhy93zx+N5FsyB/bIWITQroR4v
	6oWdwliKWznctsvG51HLhfDqQXVebhQlM0W0mLeL3txRsewR6cGGmjjGEmxAaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708354576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHlyd8j6kp9DlA7pZO5MIaEPRDtqFTi7Fn9egV2/uZo=;
	b=KGw0AHdWoIdO7CjXJy+ARgvP8SOTZV/2oAxIGLUkxZS9tQXykgKK8Olu19povEvepeWOr2
	TYgBY22xwXY7h+Cg==
To: Nipun Gupta <nipun.gupta@amd.com>, gregkh@linuxfoundation.org,
 maz@kernel.org, jgg@ziepe.ca, linux-kernel@vger.kernel.org
Cc: git@amd.com, harpreet.anand@amd.com, pieter.jansen-van-vuuren@amd.com,
 nikhil.agarwal@amd.com, michal.simek@amd.com, abhijit.gangurde@amd.com,
 srivatsa@csail.mit.edu, Nipun Gupta <nipun.gupta@amd.com>
Subject: Re: [PATCH v7] cdx: add MSI support for CDX bus
In-Reply-To: <20240202113811.2546311-1-nipun.gupta@amd.com>
References: <20240202113811.2546311-1-nipun.gupta@amd.com>
Date: Mon, 19 Feb 2024 15:56:16 +0100
Message-ID: <877cj0a4fj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 02 2024 at 17:08, Nipun Gupta wrote:
> Add CDX-MSI domain per CDX controller with gic-its domain as
> a parent, to support MSI for CDX devices. CDX devices allocate
> MSIs from the CDX domain. Also, introduce APIs to alloc and free
> IRQs for CDX domain.
>
> In CDX subsystem firmware is a controller for all devices and
> their configuration. CDX bus controller sends all the write_msi_msg
> commands to firmware running on RPU and the firmware interfaces with
> actual devices to pass this information to devices
>
> Since, CDX controller is the only way to communicate with the Firmware
> for MSI write info, CDX domain per controller required in contrast to
> having a CDX domain per device.
>
> Changes v6->v7:
> - Rebased on Linux 6.8-rc2
>  ...
> Changes v1->v2:
> - fixed scenario where msi write was called asynchronously in
>   an atomic context, by using irq_chip_(un)lock, and using sync
>   MCDI API for write MSI message.
> - fixed broken Signed-off-by chain.

Please put the Changes documentation after the --- separator. That's not
part of the change log and just creates work for the maintainer to remove.

> +#ifdef CONFIG_GENERIC_MSI_IRQ

Why do you need this #ifdef? AFAICT it's completely pointless 

> +/**
> + * cdx_msi_domain_init - Init the CDX bus MSI domain.
> + * @dev: Device of the CDX bus controller
> + *
> + * Return: CDX MSI domain, NULL on failure
> + */
> +struct irq_domain *cdx_msi_domain_init(struct device *dev);
> +#endif
>  #endif /* _CDX_H_ */

> +	/*
> +	 * dev_configure is a controller callback which can interact with

s/dev_configure/dev_configure()/ which makes it clear that this is about
a function

> +	 * Firmware or other entities, and can sleep, so invoke this function
> +	 * outside of the mutex lock.

s/lock/held region/

> +	 */
> +	dev_config.type = CDX_DEV_MSI_CONF;
> +	if (cdx->ops->dev_configure)
> +		cdx->ops->dev_configure(cdx, cdx_dev->bus_num, cdx_dev->dev_num,
> +					&dev_config);

Please use either a single line, which is within the 100 character limit
or place brackets around the condition:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules

All over the place.

> +int cdx_msi_domain_alloc_irqs(struct device *dev, unsigned int irq_count)
> +{
> +	int ret;
> +
> +	ret = msi_setup_device_data(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN,
> +					  0, irq_count - 1);
> +	if (ret)
> +		dev_err(dev, "Failed to allocate IRQs: %d\n", ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdx_msi_domain_alloc_irqs);

Why does this need a special allocation function instead of setting the
irq domain of the device and using the generic allocation function
directly?

> +static int cdx_msi_prepare(struct irq_domain *msi_domain,
> +			   struct device *dev,
> +			   int nvec, msi_alloc_info_t *info)
> +{
> +	struct cdx_device *cdx_dev = to_cdx_device(dev);
> +	struct device *parent = cdx_dev->cdx->dev;
> +	struct msi_domain_info *msi_info;
> +	u32 dev_id;
> +	int ret;
> +
> +	/* Retrieve device ID from requestor ID using parent device */
> +	ret = of_map_id(parent->of_node, cdx_dev->msi_dev_id, "msi-map",
> +			"msi-map-mask", NULL, &dev_id);
> +	if (ret) {
> +		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
> +		return ret;
> +	}
> +
> +#ifdef GENERIC_MSI_DOMAIN_OPS
> +	/* Set the device Id to be passed to the GIC-ITS */
> +	info->scratchpad[0].ul = dev_id;
> +#endif

Is this ever used on a platform which does not have
GENERIC_MSI_DOMAIN_OPS ?

> @@ -120,9 +135,13 @@ struct cdx_controller {
>   * @req_id: Requestor ID associated with CDX device
>   * @is_bus: Is this bus device
>   * @enabled: is this bus enabled
> + * @msi_dev_id: MSI Device ID associated with CDX device
> + * @num_msi: Number of MSI's supported by the device
>   * @driver_override: driver name to force a match; do not set directly,
>   *                   because core frees it; use driver_set_override() to
>   *                   set or clear it.
> + * @irqchip_lock: lock to synchronize irq/msi configuration
> + * @msi_write_pending: MSI write pending for this device
>   */
>  struct cdx_device {
>  	struct device dev;
> @@ -144,7 +163,11 @@ struct cdx_device {
>  	u32 req_id;
>  	bool is_bus;
>  	bool enabled;
> +	u32 msi_dev_id;
> +	u32 num_msi;
>  	const char *driver_override;
> +	struct mutex irqchip_lock; /* Serialize write msi configuration */

This tail comment is pointless. It's already documented above, no?

Other than those nitpicks this looks reasonable.

Thanks,

        tglx

