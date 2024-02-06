Return-Path: <linux-kernel+bounces-54994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989A684B5FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03983B25442
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD5A130E27;
	Tue,  6 Feb 2024 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTUAN+O/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92176130E2C;
	Tue,  6 Feb 2024 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224981; cv=none; b=sQDI3cKotZZnmwHozdDR+LN4rtyvNDPuDrlBO4kXESK8flpgjEU1yBwv1hCb3NAPIylYFoeBeLx26qr/h3ANwu+ViLZX+m7cjygQNWX/VU3FY5ahU5kxsuQUIUqGk+vcp0GEE6RjBnwcy43hBF/W4NvWJCBWBNQ0SlMNzvoSyg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224981; c=relaxed/simple;
	bh=EIi8PsNJVlYI6YE+gaDW03VVmxtdFg+rlTNVZ23mC8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkDOw8exO28WbZio0MQYBVvo0+rgx2MD8P0aCgnDko1/zryp1i2tyMMLpvq0pW+uQh+QpfeTAoVpPwwMJ8Q17CHv2c9qZq+Pi2eS65aZro7e5Lly/IZyZ1sHpQroq1T6vHBvT2zkaOfWMznDNkxBh+BxB8RP4OmgeJlWHg1uPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTUAN+O/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707224979; x=1738760979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EIi8PsNJVlYI6YE+gaDW03VVmxtdFg+rlTNVZ23mC8I=;
  b=VTUAN+O/SqqrCACwYQ1bZ0iVSO3olxxfgvg3Aoc3l232YVMzTfjplGOc
   uSVsm0UM7M4FfOFr8cq4li1R8OE47Hxnmd0MTokOF2V9IETd/qZJvbqiC
   lLiXVSAeHwYa58jmn6+59eNPahayaYx5T3/2LfvNhcsfcemSYMb2+rXLe
   /ksYX+pDzca/Wcpgp1ccEWqCK0WwYuqfzLH3BQmO57GfxBlVzuyOtnidd
   fjklqKmkvpyfnjyfw8ltt3ltyAZ6JX1F/W+IjlrU3QH3yZ6JBwmJaT36n
   kDOhJVZnXRpXQXO3WVpZIZ/je3/aQ+zzGuY6A3PY5hnjXVnJtZlfBojGp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="654227"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="654227"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:09:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824176965"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="824176965"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:09:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXLCe-00000002LVL-1AyX;
	Tue, 06 Feb 2024 15:09:32 +0200
Date: Tue, 6 Feb 2024 15:09:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, tony@atomide.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	john.ogness@linutronix.de, tglx@linutronix.de,
	yangyicong@hisilicon.com, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
	fanghao11@huawei.com
Subject: Re: [PATCH v2] serial: port: Don't suspend if the port is still busy
Message-ID: <ZcIvjC1qzD4atwlT@smile.fi.intel.com>
References: <20240206073322.5560-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206073322.5560-1-yangyicong@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 06, 2024 at 03:33:22PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> We accidently met the issue that the bash prompt is not shown after the
> previous command done and until the next input if there's only one CPU
> (In our issue other CPUs are isolated by isolcpus=). Further analysis
> shows it's because the port entering runtime suspend even if there's
> still pending chars in the buffer and the pending chars will only be
> processed in next device resuming. We are using amba-pl011 and the
> problematic flow is like below:
> 
> Bash                                         kworker
> tty_write()
>   file_tty_write()
>     n_tty_write()
>       uart_write()
>         __uart_start()
>           pm_runtime_get() // wakeup waker
>             queue_work()
>                                              pm_runtime_work()
>                                                rpm_resume()
>                                                 status = RPM_RESUMING
>                                                 serial_port_runtime_resume()
>                                                   port->ops->start_tx()
>                                                     pl011_tx_chars()
>                                                       uart_write_wakeup()
>         […]
>         __uart_start()
>           pm_runtime_get() < 0 // because runtime status = RPM_RESUMING
>                                // later data are not commit to the port driver
>                                                 status = RPM_ACTIVE
>                                                 rpm_idle() -> rpm_suspend()
> 
> This patch tries to fix this by checking the port busy before entering
> runtime suspending. A runtime_suspend callback is added for the port
> driver. When entering runtime suspend the callback is invoked, if there's
> still pending chars in the buffer then flush the buffer.

..

> +static int serial_port_runtime_suspend(struct device *dev)
> +{
> +	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
> +	struct uart_port *port;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	port = port_dev->port;
> +
> +	if (port->flags & UPF_DEAD)
> +		return ret;
> +
> +	uart_port_lock_irqsave(port, &flags);
> +	if (__serial_port_busy(port)) {
> +		port->ops->start_tx(port);

> +		pm_runtime_mark_last_busy(dev);

Do you think we need to call this under a lock?

> +		ret = -EBUSY;
> +	}
> +	uart_port_unlock_irqrestore(port, flags);
> +
> +	return ret;
> +}

With the above I would rather write it as

static int __serial_port_busy(struct uart_port *port)
{
	if (uart_tx_stopped(port))
		return 0;

	if (uart_circ_chars_pending(&port->state->xmit)
		return -EBUSY;

	return 0;
}

static int serial_port_runtime_suspend(struct device *dev)
{
	int ret;
	...
	uart_port_lock_irqsave(port, &flags);
	ret = __serial_port_busy(port);
	if (ret)
		port->ops->start_tx(port);
	uart_port_unlock_irqrestore(port, flags);

	if (ret)
		pm_runtime_mark_last_busy(dev);

	return ret;
}

It also seems aligned with the resume implementation above.

..

For the consistency's sake the resume can be refactored as

static int serial_port_runtime_resume(struct device *dev)
{
	...
	int ret;
	...
	ret = __serial_port_busy(port);
	if (ret)
	...
}

but this can be done later.

-- 
With Best Regards,
Andy Shevchenko



