Return-Path: <linux-kernel+bounces-1006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D4B81491D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7911C22FED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FAF2DB81;
	Fri, 15 Dec 2023 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mjR+LvMx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C102DB75
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <09d43174-03fc-abb8-db28-b0fb338492f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702646607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWutSZhoRLpsHq1ss8DLqxz5PanY9fUqHso3qlY5Y3k=;
	b=mjR+LvMxSuWdkFGFG4DUNSzFKZil3WEiZc5MnuuONTcrLrkXQCR3ZrvciqT5IkP+FNDx38
	qUR/FYdCLkCQFzsssJPIUpZcZlzDe7k1whpDj05gBHjdwTXxxqoWwaJhKWABFInL7T0UrM
	jv77eIug5gUENdFPPSQuH8qRHyMnQCo=
Date: Fri, 15 Dec 2023 21:23:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] USB: core: Use device_driver directly in struct
 usb_driver and usb_device_driver
To: Greg KH <gregkh@linuxfoundation.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 wg@grandegger.com, mkl@pengutronix.de, aspriel@gmail.com,
 franky.lin@broadcom.com, hante.meuleman@broadcom.com, kvalo@kernel.org,
 briannorris@chromium.org, mka@chromium.org, johan@kernel.org,
 oneukum@suse.com, stern@rowland.harvard.edu, valentina.manea.m@gmail.com,
 shuah@kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231215063101.792991-1-yajun.deng@linux.dev>
 <2023121505-dexterity-rectal-8898@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <2023121505-dexterity-rectal-8898@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2023/12/15 20:40, Greg KH wrote:
> On Fri, Dec 15, 2023 at 02:31:01PM +0800, Yajun Deng wrote:
>> There is usbdrv_wrap in struct usb_driver and usb_device_driver,
>> it contains device_driver and for_devices. for_devices is used to
>> distinguish between device drivers and interface drivers.
> Yes.
>
>> We can compare that if 'drv->probe' is equal to usb_probe_device instead
>> of using for_devices in is_usb_device_driver().
> Why?


For remove struct usbdrv_wrap. As we can see,  other structs use 
device_driver directly.

struct sdio_driver {

... ...

         struct device_driver drv;
};


struct pcie_port_service_driver {

... ...

         struct device_driver driver;
};

and so on ...

So there is no need a wrapper for device_driver if we can implement 
is_usb_device_driver().

>
>> Remove struct usbdrv_wrap, use device_driver directly in struct usb_driver
>> and usb_device_driver. This makes the code more concise.
> Really?  What does this help out with?  Are there future changes that
> require this?


No, just for cleanups and consistency with other structs.

> I'm all for cleanups, but I don't see what this helps with.
>
> Also, you have a coding style issue in this patch, which means I
> couldn't take it anyway:
>
>> +extern int usb_probe_device(struct device *dev);
> We don't do that in .c files :(


It's in drivers/usb/core/usb.h, not in .c files.

>
> thanks,
>
> greg k-h

