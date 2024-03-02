Return-Path: <linux-kernel+bounces-89264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2A186ED7F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162DC1F22EE9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF6A748E;
	Sat,  2 Mar 2024 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elbertmai.com header.i=@elbertmai.com header.b="KAdWdcUt";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="bptFJgLm"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC363AE
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709339864; cv=none; b=GDGpP30KDTY/G257KIjB6ypoBCZ0rcW6ow6D0TdPDDYr6JXa+s/ADVfKEm1GUgctArMofo76IwFvGkOAIHuAU25A0Z2kXXt9RVd9u0kUqscPD+55XeWnvsE9SpJUMK05nnpSikzTTHjxslXGXnLfyOPcnbIjwThuZYI9Tq8zw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709339864; c=relaxed/simple;
	bh=Tcieo+uwDG7g5dy/tKQqJIYAE7naVq9HloCZlcsiKSE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=H8DISPIoRKP25+1rjpIJwFhy8IqWySC9zkWPoQW9FEMg27HdY1IAzF01dz+xfSl214mtfngZmASd4XzaWzCvbG0lLbwE3x0NH8WquKOxXvIxDhyc34gidN4D8+b8O6njqwLdcqCsvmmJS6rrAEehNj75SZOPeV+DYPZGBuDZZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elbertmai.com; spf=pass smtp.mailfrom=elbertmai.com; dkim=pass (2048-bit key) header.d=elbertmai.com header.i=@elbertmai.com header.b=KAdWdcUt; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=bptFJgLm; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elbertmai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elbertmai.com
DKIM-Signature: a=rsa-sha256; b=KAdWdcUtx6VBwQOlD0+iCX64nZQkMW8ampJH7F/dDBIj6rSJK/BWBkEusPm4QROQ/PPYKfh7IISb6lyZbAfgq6B96qlmbvAR4MsFX+MZN2+r0I4tSZkzD5EdSFfu0lBLcGS1y6PCOpibVS6uUWrKhGOo7KAk0oPI+QGtK4pnGa59fOgNrfXVs/dlma6AMLwZyWPQhYfRsEEFbOn952gglPogQIcHw9GIK/JCxqoi9pCn7X1CJA/hE5tFj+u8Jf78WGEutH3DmDw9nUbArO7quBAyGNYvV5W5yE+Uhp/BCQ9U2m5yjjRP3tqDg4hzdYaWk4NnpCXDx2GMb75DKSk3uQ==; s=purelymail1; d=elbertmai.com; v=1; bh=Tcieo+uwDG7g5dy/tKQqJIYAE7naVq9HloCZlcsiKSE=; h=Received:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=bptFJgLmqgjMk8vL2KO2yfZCixN8PgE5VkVfmZK0LREcmgecPT7Dtnfq9MwLWlMGUUUgNvhVKJS55xpDGzt8Wt3MvpwyGa06o13qdktNbeq4fd0241UwRENPVYWTiuCGUuW0/MdkIkr6cCSW6caCFTwU9M/W9vVbH8Xuv7jnJvXbi5KawvAlVxEKMdTZaLQEkyXcJD/SZTPaLJ+MCnhH2H7dZmnJTRjb1yOopCriVzy6ri9RxQesUMNS5zqEhW7YWY1PbsongUVe2EPavkLQkkbQwn8f0FwIJvs54dpbn3O/u/HYoStEdtVAQZvyM9qx1cFzzp1jixB5Jsor+486BQ==; s=purelymail1; d=purelymail.com; v=1; bh=Tcieo+uwDG7g5dy/tKQqJIYAE7naVq9HloCZlcsiKSE=; h=Feedback-ID:Received:From:To:Subject;
Feedback-ID: 5995:1482:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPA id 897328969;
          Sat, 02 Mar 2024 00:37:24 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 02 Mar 2024 00:37:24 +0000
From: Elbert Mai <code@elbertmai.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: Export BOS descriptor to sysfs
In-Reply-To: <2024030142-gloater-stem-fe94@gregkh>
References: <20240229235905.569705-1-code@elbertmai.com>
 <2024030142-gloater-stem-fe94@gregkh>
User-Agent: Purely Mail via Roundcube/1.6.5
Message-ID: <faf0abfeefde4bb44494160224c78eca@purelymail.com>
X-Sender: code@elbertmai.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-01 06:18, Greg KH wrote:
> On Thu, Feb 29, 2024 at 03:59:05PM -0800, Elbert Mai wrote:
>> Motivation
>> ----------
>> 
>> The kernel already retrieves and caches the binary device object store
>> (BOS) descriptor from USB devices it enumerates. Export this 
>> descriptor to
>> userspace via sysfs, so users do not need to open the USB device with 
>> the
>> correct permissions and requesting the descriptor themselves.
>> 
>> A BOS descriptor contains a set of device capability descriptors. One 
>> that
>> is of interest to users is the platform descriptor. This contains a 
>> 128-bit
>> UUID and arbitrary data. The descriptor allows parties outside of 
>> USB-IF to
>> add additional metadata about a device in a standards-compliant 
>> manner.
>> 
>> Notable examples include the WebUSB and Microsoft OS 2.0 descriptors. 
>> Of
>> course, there could be more. By exporting the entire BOS descriptor we 
>> can
>> handle these and all future device capabilities. In addition, tools 
>> like
>> udev can match rules on device capabilities in the BOS without 
>> requiring
>> additional I/O with the USB device.
> 
> But this requires that userspace parse the raw descriptor, right?  Why
> not also export the descriptor information in simpler form through
> different sysfs files as well so that scripts can read this information
> easily?
> 
> That's not to say we don't also want this binary file, just maybe add
> more?

I've thought about this for a while, but IMHO it doesn't seem possible 
to
present the BOS in a simpler form like how it's done for the device and
configuration descriptors. The BOS was explicitly designed to be 
flexible
and extensible, and it's hard to make a "rich" sysfs interface around 
that.

We could have a platform_uuids file that lists all platform UUIDs in the 
BOS.
These could be presented in RFC 4122 string format, each separated by 
some
delimiter. This would make it possible to write a udev rule that matches 
a
particular UUID via a glob pattern. This seems like a rather inelegant 
way
of handling this, IMHO.

With regards to parsing raw descriptors in userspace, this already 
happens
at least with udev. About a dozen files in /usr/lib/udev/rules.d invoke 
a
built-in program called "usb_id", which opens the descriptors binary 
file
(among other files in sysfs) and parses it for interface information.

I think users and scripts interested in reading the BOS are best served 
with
userspace tools that can parse the BOS and present it in a convenient 
textual
format of their choosing. Having bos_descriptor in sysfs makes this 
possible
without needing elevated permissions or USB I/O. But I could be mistaken 
in
this regard.

>> Implementation
>> --------------
>> 
>> Add bos_descriptor file to sysfs. This is a binary file and it works 
>> the
>> same way as the existing descriptors file. The file exists even if a 
>> device
>> does not have a BOS descriptor (the file will be empty in this case). 
>> This
>> allows users to detect if the kernel supports reading the BOS via 
>> sysfs and
>> fall back to direct USB I/O if needed.
> 
> This is nice, but can you only create the file if it actually is
> present?  Use the is_visible callback to determine this, having an
> "empty" binary sysfs file isn't that nice.

Of course, I can make that happen.

> Other tiny review comments below:
> 
>> Signed-off-by: Elbert Mai <code@elbertmai.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-usb |  9 +++++++
>>  drivers/usb/core/sysfs.c                | 35 
>> ++++++++++++++++++++++++-
>>  2 files changed, 43 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/ABI/testing/sysfs-bus-usb 
>> b/Documentation/ABI/testing/sysfs-bus-usb
>> index 614d216dff1d..bfffaa752a13 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-usb
>> +++ b/Documentation/ABI/testing/sysfs-bus-usb
>> @@ -293,3 +293,12 @@ Description:
>>  		USB 3.2 adds Dual-lane support, 2 rx and 2 tx -lanes over Type-C.
>>  		Inter-Chip SSIC devices support asymmetric lanes up to 4 lanes per
>>  		direction. Devices before USB 3.2 are single lane (tx_lanes = 1)
>> +
>> +What:		/sys/bus/usb/devices/.../bos_descriptor
>> +Date:		March 2024
>> +Contact:	Elbert Mai <code@elbertmai.com>
>> +Description:
>> +		Binary file containing the cached binary device object store (BOS)
>> +		descriptor of the device. This file is empty if the BOS descriptor
>> +		is not present. The kernel will not request a BOS descriptor from
>> +		the device if its bcdUSB value is less than 0x0201.
>> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
>> index a2ca38e25e0c..208d2f8cde2d 100644
>> --- a/drivers/usb/core/sysfs.c
>> +++ b/drivers/usb/core/sysfs.c
>> @@ -901,7 +901,7 @@ read_descriptors(struct file *filp, struct kobject 
>> *kobj,
>>  			srclen = sizeof(struct usb_device_descriptor);
>>  		} else {
>>  			src = udev->rawdescriptors[cfgno];
>> -			srclen = __le16_to_cpu(udev->config[cfgno].desc.
>> +			srclen = le16_to_cpu(udev->config[cfgno].desc.
> 
> Why is this line changed?

Consistency with the rest of the file. This was the only instance of 
__le16_to_cpu,
other lines used le16_to_cpu (no underscores).

>>  					wTotalLength);
>>  		}
>>  		if (off < srclen) {
>> @@ -923,6 +923,34 @@ static struct bin_attribute 
>> dev_bin_attr_descriptors = {
>>  	.size = 18 + 65535,	/* dev descr + max-size raw descriptor */
>>  };
>> 
>> +static ssize_t
>> +read_bos_descriptor(struct file *filp, struct kobject *kobj,
>> +		struct bin_attribute *attr,
>> +		char *buf, loff_t off, size_t count)
>> +{
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct usb_device *udev = to_usb_device(dev);
>> +	struct usb_host_bos *bos = udev->bos;
>> +	struct usb_bos_descriptor *desc;
>> +	size_t desclen, n = 0;
>> +
>> +	if (bos) {
>> +		desc = bos->desc;
>> +		desclen = le16_to_cpu(desc->wTotalLength);
>> +		if (off < desclen) {
>> +			n = min(count, desclen - (size_t) off);
>> +			memcpy(buf, (void *) desc + off, n);
>> +		}
>> +	}
>> +	return n;
> 
> If bos is not present an error should return, not 0, right?

The interface_show function in sysfs.c returns 0 if the string 
describing
the interface is not present, so I did it the same way. Should I instead
return -ENOENT or some other specific error code?

>> +}
>> +
>> +static struct bin_attribute dev_bin_attr_bos_descriptor = {
>> +	.attr = {.name = "bos_descriptor", .mode = 0444},
>> +	.read = read_bos_descriptor,
> 
> Isn't there a mscro for all of this?

It turns out there is, called BIN_ATTR_RO in in linux/sysfs.h. I'm not 
sure
why the original code didn't use it for read_descriptors. I can change
both instances to shorten the code.

>> +	.size = 65535,	/* max-size BOS descriptor */
> 
> Do we know the size of the descriptor at runtime?  Ideally we would set
> it to be that, not an unknown size that way userspace knows what needs
> to be read.  But that's not really a big deal, if it's not possible, as
> the other USB binary descriptor does much the same.

We do know the size via wTotalLength, but that varies between USB 
devices
and dev_bin_attr_bos_descriptor is a static variable. So not really 
possible
unless we dynamically allocate all the attribute structs.

>> +};
> 
> This should go into an attribute group with the other descriptor, 
> making
> the rest of the patch not needed and simpler.

Will do. I'm in favor of simpler patches.

>> +
>>  /*
>>   * Show & store the current value of authorized_default
>>   */
>> @@ -1042,6 +1070,10 @@ int usb_create_sysfs_dev_files(struct 
>> usb_device *udev)
>>  	if (retval)
>>  		goto error;
>> 
>> +	retval = device_create_bin_file(dev, &dev_bin_attr_bos_descriptor);
>> +	if (retval)
>> +		goto error;
>> +
> 
> long-term I'd like to get rid of the individual "add and remove" sysfs
> files in this function, and just use the default groups instead so the
> driver core handles it.  It's not an issue here for this change, but if
> you can find a way to work on that as part of a patch series here, I
> think that would be really good (if possible, not a requirement.)

I'll see what I can do. I'll go for at least the low-hanging fruit.

> thanks!
> 
> greg k-h

And thank you for taking the time to review this patch!

-Elbert

