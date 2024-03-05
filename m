Return-Path: <linux-kernel+bounces-91845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5C187176B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E5FB229F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BE37F469;
	Tue,  5 Mar 2024 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LpGlrz6U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF47E78B;
	Tue,  5 Mar 2024 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625146; cv=none; b=JvJV9uaQ2sciBrTvI8Uj5a3sVh1rQ183WeTszRftQ5iv5juCNBhK9ZOa/uqZUHFAYNmLuSZujBFMYzFg4w4xErqcoIv7/HEfCLaDgwNYwm9+fw6hlWnMD6YiLNWP5/sPDoSY+iMMKgqqT+b9XGu0ByHPeu1Vk9+eqP9eo3FH5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625146; c=relaxed/simple;
	bh=AM09GKPYJH/8gNJ+NzSyVqjaenAF0cZN+Cb8vT4dlew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6IpfZnpS/6UQh0t/I/RlAxgWojU3HkvwgGOQ6R5I0A29d1zwyDA6wcuMlDH63r8Up+ukI377tWKpeFyCgD9Xi6DDK6RHtTnDdFgvoCbJoUnYiqptddNKAprpiLyR7aHEBMiGnVNif4D5juTGYj08d37mWgI/YFzwXXsJQImDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LpGlrz6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74159C43390;
	Tue,  5 Mar 2024 07:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709625143;
	bh=AM09GKPYJH/8gNJ+NzSyVqjaenAF0cZN+Cb8vT4dlew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpGlrz6U4DYo0szXcCLN3qySBTzVZK09L0wBZrGS5comnhFIvVJWxIm+PynYFkYdX
	 1WwxtHQ+/h+An5Seq91B6O12hyMxiGuEhsOmqfEi4xqyOO5bqnB+TkRtmcLtv0uTr9
	 FlEmJ28M/aW5DwvTPoqJNoQ8QCjctH8YvuEHxzXs=
Date: Tue, 5 Mar 2024 07:52:20 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Elbert Mai <code@elbertmai.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: Export BOS descriptor to sysfs
Message-ID: <2024030515-cruelly-ungreased-3fd9@gregkh>
References: <20240305002301.95323-1-code@elbertmai.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305002301.95323-1-code@elbertmai.com>

On Mon, Mar 04, 2024 at 04:23:01PM -0800, Elbert Mai wrote:
> Motivation
> ----------
> 
> The binary device object store (BOS) of a USB device consists of the BOS
> descriptor followed by a set of device capability descriptors. One that is
> of interest to users is the platform descriptor. This contains a 128-bit
> UUID and arbitrary data, and it allows parties outside of USB-IF to add
> additional metadata about a USB device in a standards-compliant manner.
> Notable examples include the WebUSB and Microsoft OS 2.0 descriptors.
> 
> The kernel already retrieves and caches the BOS from USB devices if its
> bcdUSB is >= 0x0201. Because the BOS is flexible and extensible, we export
> the entire BOS to sysfs so users can retrieve whatever device capabilities
> they desire, without requiring USB I/O or elevated permissions.
> 
> Implementation
> --------------
> 
> Add bos_descriptors attribute to sysfs. This is a binary file and it works
> the same way as the existing descriptors attribute. The file exists only if
> the BOS is present in the USB device.
> 
> Also create a binary attribute group, so the driver core can handle the
> creation of both the descriptors and bos_descriptors attributes in sysfs.
> 
> Signed-off-by: Elbert Mai <code@elbertmai.com>
> ---
> Changes in v2:
>  - Rename to bos_descriptors (plural) since the attribute contains the
>    entire BOS, not just the first descriptor in it.
>  - Use binary attribute groups to let driver core handle attribute
>    creation for both descriptors and bos_descriptors.
>  - The attribute is visible in sysfs only if the BOS is present in the
>    USB device.

Very nice, thanks for this!

One very minor comment, you can send a follow-on patch for this if you
like:

> +static umode_t dev_bin_attrs_are_visible(struct kobject *kobj,
> +		struct bin_attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct usb_device *udev = to_usb_device(dev);
> +
> +	/* All USB devices have a device descriptor, so the descriptors
> +	 * attribute always exists. No need to check for its visibility.
> +	 */

This comment is in the "wrong" style, I think checkpatch will complain
about that, right?

But it's a bit confusing, you say "no need to check", and then you:

> +	if (a == &bin_attr_bos_descriptors) {
> +		if (udev->bos == NULL)
> +			return 0;
> +	}

check something :)

How about this as a comment instead:
	/*
	 * If this is the BOS descriptor, check to verify if the device
	 * has that descriptor at all or not.
	 */

That's all you need here, right?

Anyway, again, very nice, I'll go queue this up and run it through the
0-day tests.

thanks!

greg k -h

