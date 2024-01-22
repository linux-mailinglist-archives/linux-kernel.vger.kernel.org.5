Return-Path: <linux-kernel+bounces-34177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F143683752A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7868EB21A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A5647F72;
	Mon, 22 Jan 2024 21:24:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE96BF9C4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958664; cv=none; b=tiGt0qrb7X37D/u3avJZjhNckxjUbqMFy6zMF5XHuPaW6Kh8jAsFVTiDP0jjVBwDLutmESGMojqwEUwNnucwWvS+pOZi7VsiNuC/FLw380nSxY2Sft4lSYTxVwL8cAlJmdgTvaR5ttbBvESCUeepPmmZbzrPW8I8L8Z9mDPtmk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958664; c=relaxed/simple;
	bh=6xC4jtIb98lvi19x9ooerCbLShD3mbJHIdT1NX33ozw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcDI2EPsA3HsRF8h3oZVnFIZqp2Ps8cyJY+NiTDXEIyXk+mg3SLJ/z+f8UdMnICRp2SVC+rqC/VCWUpfqmgzAiZeu3OiGcUD8apkmoF4zg+boOIU3Z4l2sUUwIQTWzDurcGyMuMdnnKmdaRW4Y2gkICfNNfY7Byzmi14ZZEW7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: from rdvivi-mobl4 (unknown [192.55.55.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 369ECC433C7;
	Mon, 22 Jan 2024 21:24:22 +0000 (UTC)
Date: Mon, 22 Jan 2024 16:24:20 -0500
From: Rodrigo Vivi <rodrigo.vivi@kernel.org>
To: "Souza, Jose" <jose.souza@intel.com>, johannes@sipsolutions.net
Cc: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: Re: [PATCH] devcoredump: Remove devcoredump device if failing device
 is gone
Message-ID: <Za7c-8KfyKcMx8OM@rdvivi-mobl4>
References: <20240117195349.343083-1-rodrigo.vivi@intel.com>
 <b0fb26b5912ca3e6f3b6239e15b4dd02ebecd919.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0fb26b5912ca3e6f3b6239e15b4dd02ebecd919.camel@intel.com>

On Fri, Jan 19, 2024 at 01:13:45PM -0500, Souza, Jose wrote:
> On Wed, 2024-01-17 at 14:53 -0500, Rodrigo Vivi wrote:
> > Make dev_coredumpm a real device managed helper, that not only
> > frees the device after a scheduled delay (DEVCD_TIMEOUT), but
> > also when the failing/crashed device is gone.
> > 
> > The module remove for the drivers using devcoredump are currently
> > broken if attempted between the crash and the DEVCD_TIMEOUT, since
> > the symbolic sysfs link won't be deleted.
> > 
> > On top of that, for PCI devices, the unbind of the device will
> > call the pci .remove void function, that cannot fail. At that
> > time, our device is pretty much gone, but the read and free
> > functions are alive trough the devcoredump device and they
> > can get some NULL dereferences or use after free.
> > 
> > So, if the failing-device is gone, let's cancel the scheduled
> > work and remove devcoredump-device immediately.
> > 
> > Cc: Jose Souza <jose.souza@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > ---
> >  drivers/base/devcoredump.c | 29 ++++++++++++++++++++++-------
> >  1 file changed, 22 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> > index 7e2d1f0d903a..6db7a2fd9a02 100644
> > --- a/drivers/base/devcoredump.c
> > +++ b/drivers/base/devcoredump.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/module.h>
> >  #include <linux/device.h>
> >  #include <linux/devcoredump.h>
> > +#include <linux/devm-helpers.h>
> >  #include <linux/list.h>
> >  #include <linux/slab.h>
> >  #include <linux/fs.h>
> > @@ -118,19 +119,24 @@ static ssize_t devcd_data_read(struct file *filp, struct kobject *kobj,
> >  	return devcd->read(buffer, offset, count, devcd->data, devcd->datalen);
> >  }
> >  
> > -static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
> > -				struct bin_attribute *bin_attr,
> > -				char *buffer, loff_t offset, size_t count)
> > +static void devcd_remove_now(struct devcd_entry *devcd)
> 
> this function can also be used by devcd_free().

well, indeed.
And perhaps using the

flush_delayed_work(&devcd->del_wk);

instead of

mod_delayed_work(system_wq, &devcd->del_wk, 0);

and then I don't even need to switch from
INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
to
devm_delayed_work_autocancel()

since it will be flushed, so no need to autocancel it.

Johannes, any hard preference or request from your side?

Thanks,
Rodrigo.

> 
> Other than that LGTM.
> 
> >  {
> > -	struct device *dev = kobj_to_dev(kobj);
> > -	struct devcd_entry *devcd = dev_to_devcd(dev);
> > -
> >  	mutex_lock(&devcd->mutex);
> >  	if (!devcd->delete_work) {
> >  		devcd->delete_work = true;
> >  		mod_delayed_work(system_wq, &devcd->del_wk, 0);
> >  	}
> >  	mutex_unlock(&devcd->mutex);
> > +}
> > +
> > +static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
> > +				struct bin_attribute *bin_attr,
> > +				char *buffer, loff_t offset, size_t count)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct devcd_entry *devcd = dev_to_devcd(dev);
> > +
> > +	devcd_remove_now(devcd);
> >  
> >  	return count;
> >  }
> > @@ -304,6 +310,12 @@ static ssize_t devcd_read_from_sgtable(char *buffer, loff_t offset,
> >  				  offset);
> >  }
> >  
> > +static void devcd_remove(void *data)
> > +{
> > +	struct devcd_entry *devcd = data;
> > +	devcd_remove_now(devcd);
> > +}
> > +
> >  /**
> >   * dev_coredumpm - create device coredump with read/free methods
> >   * @dev: the struct device for the crashed device
> > @@ -379,7 +391,10 @@ void dev_coredumpm(struct device *dev, struct module *owner,
> >  
> >  	dev_set_uevent_suppress(&devcd->devcd_dev, false);
> >  	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
> > -	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> > +	if (devm_add_action(dev, devcd_remove, devcd))
> > +		dev_warn(dev, "devcoredump managed auto-removal registration failed\n");
> > +	if (devm_delayed_work_autocancel(dev, &devcd->del_wk, devcd_del))
> > +		dev_warn(dev, "devcoredump managed autocancel work failed\n");
> >  	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
> >  	mutex_unlock(&devcd->mutex);
> >  	return;
> 

