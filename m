Return-Path: <linux-kernel+bounces-87949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A245B86DB65
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175651F257C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280255F84C;
	Fri,  1 Mar 2024 06:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JGDbc42F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05F2AEEE;
	Fri,  1 Mar 2024 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709273918; cv=none; b=nMF7NsUpq47YGrRzN5Bs980QwXyufPdlLaAdBda1VR0s0hRY+5/0JnQCMYoWuCiV2WTI0Z5rFp+vusMJnoAznfH0fcrj3lZ9Lvb3X43pvTbZ+DoI3T00xQBt9vK2Igrvxm2lMup7yZRNLH7I23LqeGlHin0OiFbMw7veEvzfHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709273918; c=relaxed/simple;
	bh=9CfH8/yUzS+Jiv3d7W0cC2LNTETeND1FrcCNlL5PePY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQaaQFoMg+OvCauDp048aF20T+61nElT01+LWoN/G27/M+09IA79YSzFlmPf2yGZPE9Tkfs33J9t6KSSpY/NZRBnRhAA6zWGxaogYVy/fdxhKDUtGoYSQ9cquehb/UNQrn2kieU8l11/0tAIvQMwm7Uc7bIPvHHbp1xW3gMo7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JGDbc42F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C197C433F1;
	Fri,  1 Mar 2024 06:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709273917;
	bh=9CfH8/yUzS+Jiv3d7W0cC2LNTETeND1FrcCNlL5PePY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGDbc42FoWlRnZ3Tg/zkYtWmX+DQDkPv0RT4+SFsUrurtNAcZTvYlQuH79rymvRl2
	 OcZzBqEKa0grASr8itj2oIvb/qpA182QhXwbzF2AfDT2Pm5hd/+mJClLYCuSBDNT3y
	 b+v3hQlIrvPbSRYeFcJrILX2orPKrqCm0vJI7QpU=
Date: Fri, 1 Mar 2024 07:18:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Elbert Mai <code@elbertmai.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: Export BOS descriptor to sysfs
Message-ID: <2024030142-gloater-stem-fe94@gregkh>
References: <20240229235905.569705-1-code@elbertmai.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229235905.569705-1-code@elbertmai.com>

On Thu, Feb 29, 2024 at 03:59:05PM -0800, Elbert Mai wrote:
> Motivation
> ----------
> 
> The kernel already retrieves and caches the binary device object store
> (BOS) descriptor from USB devices it enumerates. Export this descriptor to
> userspace via sysfs, so users do not need to open the USB device with the
> correct permissions and requesting the descriptor themselves.
> 
> A BOS descriptor contains a set of device capability descriptors. One that
> is of interest to users is the platform descriptor. This contains a 128-bit
> UUID and arbitrary data. The descriptor allows parties outside of USB-IF to
> add additional metadata about a device in a standards-compliant manner.
> 
> Notable examples include the WebUSB and Microsoft OS 2.0 descriptors. Of
> course, there could be more. By exporting the entire BOS descriptor we can
> handle these and all future device capabilities. In addition, tools like
> udev can match rules on device capabilities in the BOS without requiring
> additional I/O with the USB device.

But this requires that userspace parse the raw descriptor, right?  Why
not also export the descriptor information in simpler form through
different sysfs files as well so that scripts can read this information
easily?

That's not to say we don't also want this binary file, just maybe add
more?

> Implementation
> --------------
> 
> Add bos_descriptor file to sysfs. This is a binary file and it works the
> same way as the existing descriptors file. The file exists even if a device
> does not have a BOS descriptor (the file will be empty in this case). This
> allows users to detect if the kernel supports reading the BOS via sysfs and
> fall back to direct USB I/O if needed.

This is nice, but can you only create the file if it actually is
present?  Use the is_visible callback to determine this, having an
"empty" binary sysfs file isn't that nice.

Other tiny review comments below:

> Signed-off-by: Elbert Mai <code@elbertmai.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-usb |  9 +++++++
>  drivers/usb/core/sysfs.c                | 35 ++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
> index 614d216dff1d..bfffaa752a13 100644
> --- a/Documentation/ABI/testing/sysfs-bus-usb
> +++ b/Documentation/ABI/testing/sysfs-bus-usb
> @@ -293,3 +293,12 @@ Description:
>  		USB 3.2 adds Dual-lane support, 2 rx and 2 tx -lanes over Type-C.
>  		Inter-Chip SSIC devices support asymmetric lanes up to 4 lanes per
>  		direction. Devices before USB 3.2 are single lane (tx_lanes = 1)
> +
> +What:		/sys/bus/usb/devices/.../bos_descriptor
> +Date:		March 2024
> +Contact:	Elbert Mai <code@elbertmai.com>
> +Description:
> +		Binary file containing the cached binary device object store (BOS)
> +		descriptor of the device. This file is empty if the BOS descriptor
> +		is not present. The kernel will not request a BOS descriptor from
> +		the device if its bcdUSB value is less than 0x0201.
> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
> index a2ca38e25e0c..208d2f8cde2d 100644
> --- a/drivers/usb/core/sysfs.c
> +++ b/drivers/usb/core/sysfs.c
> @@ -901,7 +901,7 @@ read_descriptors(struct file *filp, struct kobject *kobj,
>  			srclen = sizeof(struct usb_device_descriptor);
>  		} else {
>  			src = udev->rawdescriptors[cfgno];
> -			srclen = __le16_to_cpu(udev->config[cfgno].desc.
> +			srclen = le16_to_cpu(udev->config[cfgno].desc.

Why is this line changed?

>  					wTotalLength);
>  		}
>  		if (off < srclen) {
> @@ -923,6 +923,34 @@ static struct bin_attribute dev_bin_attr_descriptors = {
>  	.size = 18 + 65535,	/* dev descr + max-size raw descriptor */
>  };
>  
> +static ssize_t
> +read_bos_descriptor(struct file *filp, struct kobject *kobj,
> +		struct bin_attribute *attr,
> +		char *buf, loff_t off, size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct usb_device *udev = to_usb_device(dev);
> +	struct usb_host_bos *bos = udev->bos;
> +	struct usb_bos_descriptor *desc;
> +	size_t desclen, n = 0;
> +
> +	if (bos) {
> +		desc = bos->desc;
> +		desclen = le16_to_cpu(desc->wTotalLength);
> +		if (off < desclen) {
> +			n = min(count, desclen - (size_t) off);
> +			memcpy(buf, (void *) desc + off, n);
> +		}
> +	}
> +	return n;

If bos is not present an error should return, not 0, right?

> +}
> +
> +static struct bin_attribute dev_bin_attr_bos_descriptor = {
> +	.attr = {.name = "bos_descriptor", .mode = 0444},
> +	.read = read_bos_descriptor,

Isn't there a mscro for all of this?

> +	.size = 65535,	/* max-size BOS descriptor */

Do we know the size of the descriptor at runtime?  Ideally we would set
it to be that, not an unknown size that way userspace knows what needs
to be read.  But that's not really a big deal, if it's not possible, as
the other USB binary descriptor does much the same.

> +};

This should go into an attribute group with the other descriptor, making
the rest of the patch not needed and simpler.

> +
>  /*
>   * Show & store the current value of authorized_default
>   */
> @@ -1042,6 +1070,10 @@ int usb_create_sysfs_dev_files(struct usb_device *udev)
>  	if (retval)
>  		goto error;
>  
> +	retval = device_create_bin_file(dev, &dev_bin_attr_bos_descriptor);
> +	if (retval)
> +		goto error;
> +

long-term I'd like to get rid of the individual "add and remove" sysfs
files in this function, and just use the default groups instead so the
driver core handles it.  It's not an issue here for this change, but if
you can find a way to work on that as part of a patch series here, I
think that would be really good (if possible, not a requirement.)

thanks!

greg k-h

