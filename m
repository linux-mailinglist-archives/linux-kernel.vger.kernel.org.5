Return-Path: <linux-kernel+bounces-131505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387918988CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DAD1C21567
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA517127B5D;
	Thu,  4 Apr 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fXMvBXkA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C7433A8;
	Thu,  4 Apr 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237441; cv=none; b=gB+pIMvxDrSfTuMgpmAGBQF4VwMYHHjJn6j0hZHtg15t27kvFMgc7vcH56bbv8xG1st/2mcsAIcZtWWP7cCo7X13tBQeoRNrT4dLXEFrAELmc2ANZhBQQtQ2mHhez9HJxdhj8mfQgqZJw57at5B7jIElb7E9NKafRUEjhgEizdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237441; c=relaxed/simple;
	bh=2fj/i+j2Id2LJwh/zFA6uxKkNq52kXJYfChrS9zCIQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWnGhOJuG22xz/BdLLrsAHURvbuKJoruev8p9nVJtyCAp1gh62+iGPcd9bRkBT0xNyWmhilwrsTYk3Ab0OH08f3Y5xmMBPvLCiNs4qMr4VUKO8SR7uv1QSg94pXjDi0cze5WyIYU1grI17SRyVv1OiHuc52ZQmZpvNMvs5bKkJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fXMvBXkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55E0C433C7;
	Thu,  4 Apr 2024 13:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712237441;
	bh=2fj/i+j2Id2LJwh/zFA6uxKkNq52kXJYfChrS9zCIQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fXMvBXkA6bFap/LgpTyA5qnYFj0KB01L0y7oIfhAWKLUFzSbgEBI99xJtQTcNwJ0q
	 FIG/raqcH3w/Yz8k3ZYz9HKsyae97jRU2hn0t7kmb5g2wWGn35qzK0jkoZoZbHTGkG
	 N5LtCrCpcIg1lodgT647mJKWiU48qp8Mb0d14eQk=
Date: Thu, 4 Apr 2024 15:30:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Pavan Holla <pholla@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 2/2] usb: typec: ucsi: Implement ChromeOS UCSI driver
Message-ID: <2024040422-ripcord-bladder-bdda@gregkh>
References: <20240403-public-ucsi-h-v3-0-f848e18c8ed2@chromium.org>
 <20240403-public-ucsi-h-v3-2-f848e18c8ed2@chromium.org>
 <3ezjocthsigo3t746slmgzffnmpxw7wwf3s535basiaf2qy6io@7ocxva6ndsbt>
 <2024040449-average-foyer-defa@gregkh>
 <oi3bwdyvyaezpmyxfdtsbiwwprxi2ufc3hlzoz23d5rxdkperl@cxpd7enatg7h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oi3bwdyvyaezpmyxfdtsbiwwprxi2ufc3hlzoz23d5rxdkperl@cxpd7enatg7h>

On Thu, Apr 04, 2024 at 04:20:30PM +0300, Dmitry Baryshkov wrote:
> On Thu, Apr 04, 2024 at 03:07:15PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 03, 2024 at 09:58:33PM +0300, Dmitry Baryshkov wrote:
> > > On Wed, Apr 03, 2024 at 06:05:22PM +0000, Pavan Holla wrote:
> > > > Implementation of a UCSI transport driver for ChromeOS.
> > > > This driver will be loaded if the ChromeOS EC implements a PPM.
> > > > 
> > > > Signed-off-by: Pavan Holla <pholla@chromium.org>
> > > > ---
> > > >  drivers/usb/typec/ucsi/Kconfig        |  13 ++
> > > >  drivers/usb/typec/ucsi/Makefile       |   1 +
> > > >  drivers/usb/typec/ucsi/cros_ec_ucsi.c | 245 ++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 259 insertions(+)
> > > > 
> > > > diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> > > > index bdcb1764cfae..4dceb14a66ee 100644
> > > > --- a/drivers/usb/typec/ucsi/Kconfig
> > > > +++ b/drivers/usb/typec/ucsi/Kconfig
> > > > @@ -69,4 +69,17 @@ config UCSI_PMIC_GLINK
> > > >  	  To compile the driver as a module, choose M here: the module will be
> > > >  	  called ucsi_glink.
> > > >  
> > > > +config CROS_EC_UCSI
> > > > +	tristate "UCSI Driver for ChromeOS EC"
> > > > +	depends on MFD_CROS_EC_DEV
> > > > +	depends on CROS_USBPD_NOTIFY
> > > > +	depends on !EXTCON_TCSS_CROS_EC
> > > > +	default MFD_CROS_EC_DEV
> > > > +	help
> > > > +	  This driver enables UCSI support for a ChromeOS EC. The EC is
> > > > +	  expected to implement a PPM.
> > > > +
> > > > +	  To compile the driver as a module, choose M here: the module
> > > > +	  will be called cros_ec_ucsi.
> > > > +
> > > >  endif
> > > > diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
> > > > index b4679f94696b..cb336eee055c 100644
> > > > --- a/drivers/usb/typec/ucsi/Makefile
> > > > +++ b/drivers/usb/typec/ucsi/Makefile
> > > > @@ -21,3 +21,4 @@ obj-$(CONFIG_UCSI_ACPI)			+= ucsi_acpi.o
> > > >  obj-$(CONFIG_UCSI_CCG)			+= ucsi_ccg.o
> > > >  obj-$(CONFIG_UCSI_STM32G0)		+= ucsi_stm32g0.o
> > > >  obj-$(CONFIG_UCSI_PMIC_GLINK)		+= ucsi_glink.o
> > > > +obj-$(CONFIG_CROS_EC_UCSI)		+= cros_ec_ucsi.o
> > > > diff --git a/drivers/usb/typec/ucsi/cros_ec_ucsi.c b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
> > > > new file mode 100644
> > > > index 000000000000..dd46b46d430f
> > > > --- /dev/null
> > > > +++ b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
> > > > @@ -0,0 +1,245 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * UCSI driver for ChromeOS EC
> > > > + *
> > > > + * Copyright 2024 Google LLC.
> > > > + */
> > > > +
> > > > +#include <linux/container_of.h>
> > > > +#include <linux/dev_printk.h>
> > > > +#include <linux/mod_devicetable.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/platform_data/cros_ec_commands.h>
> > > > +#include <linux/platform_data/cros_usbpd_notify.h>
> > > > +#include <linux/platform_data/cros_ec_proto.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/wait.h>
> > > > +
> > > > +#include "ucsi.h"
> > > > +
> > > > +#define DRV_NAME "cros-ec-ucsi"
> > > > +
> > > > +#define MAX_EC_DATA_SIZE 256
> > > > +#define WRITE_TMO_MS 500
> > > > +
> > > > +struct cros_ucsi_data {
> > > > +	struct device *dev;
> > > > +	struct ucsi *ucsi;
> > > > +
> > > > +	struct cros_ec_device *ec;
> > > > +	struct notifier_block nb;
> > > > +	struct work_struct work;
> > > > +
> > > > +	struct completion complete;
> > > > +	unsigned long flags;
> > > > +};
> > > > +
> > > > +static int cros_ucsi_read(struct ucsi *ucsi, unsigned int offset, void *val,
> > > > +			  size_t val_len)
> > > > +{
> > > > +	struct cros_ucsi_data *udata = ucsi_get_drvdata(ucsi);
> > > > +	struct ec_params_ucsi_ppm_get req = {
> > > > +		.offset = offset,
> > > > +		.size = val_len,
> > > > +	};
> > > > +	int ret;
> > > > +
> > > > +	if (val_len > MAX_EC_DATA_SIZE) {
> > > > +		dev_err(udata->dev, "Can't read %zu bytes. Too big.", val_len);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	ret = cros_ec_cmd(udata->ec, 0, EC_CMD_UCSI_PPM_GET,
> > > > +			  &req, sizeof(req), val, val_len);
> > > > +	if (ret < 0) {
> > > > +		dev_warn(udata->dev, "Failed to send EC message UCSI_PPM_GET: error=%d", ret);
> > > > +		return ret;
> > > > +	}
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int cros_ucsi_async_write(struct ucsi *ucsi, unsigned int offset,
> > > > +				 const void *val, size_t val_len)
> > > > +{
> > > > +	struct cros_ucsi_data *udata = ucsi_get_drvdata(ucsi);
> > > > +	uint8_t ec_buffer[MAX_EC_DATA_SIZE + sizeof(struct ec_params_ucsi_ppm_set)];
> > > > +	struct ec_params_ucsi_ppm_set *req = (struct ec_params_ucsi_ppm_set *)ec_buffer;
> > > > +	int ret = 0;
> > > > +
> > > > +	if (val_len > MAX_EC_DATA_SIZE) {
> > > > +		dev_err(udata->dev, "Can't write %zu bytes. Too big.", val_len);
> > > 
> > > I think it's better be written as
> > > 
> > > if (WARN_ON_ONCE(val_len > MAX_EC_DATA_SIZE))
> > > 	return -EINVAL;
> > 
> > So if you trigger this, you just rebooted all boxes that have
> > panic-on-warn enabled (hint, the HUGE majority in quantity of Linux
> > systems out there.)
> > 
> > So don't do that, just handle it like this.
> 
> Does that mean that we should not use WARN at all? What is the best
> current practice for WARN usage?

To never use it.  Handle the issue and recover properly.

> I'm asking because for me this looks like a perfect usecase. If I were
> at the positiion of the driver developer, I'd like to know the whole
> path leading to the bad call, not just the fact that the function was
> called with the buffer being too big.

Then use ftrace if you are a driver developer, don't crash users boxes
please.

If you REALLY need a traceback, then provide that, but do NOT use WARN()
for just normal debugging calls that you want to leave around in the
system for users to trip over.

thanks,

greg k-h

