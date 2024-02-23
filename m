Return-Path: <linux-kernel+bounces-78633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1AB861628
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684D81F25EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AC182C71;
	Fri, 23 Feb 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwCoGiwq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DC46E618;
	Fri, 23 Feb 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703080; cv=none; b=vGRqlv/kquVducKMDH+WNaJ+h/gxRSWgg+9AmcWW8HN9prcP5Tlue2w4WCy4OcX4FSohPwz85RHEV8tfXJXDui6uaekZjHIE6FDWSHBB2sGLQjcZktf2BSQwYZZpC7Y3ewWL8g2F+KySzEskIRsZlQVsFKxRlTQ3HiwTAP+n8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703080; c=relaxed/simple;
	bh=AImssem9VU8CF0rZUiMd5dBqWI5uMzEG8ynAi5lJ0vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpuS04xRWMSr8Lrp8JXuQyH16ZKjpyszS2H6VgoFtVAcJu182GcCFvnRoPXndHTuanBwwNqe9V0don2vwko3FVt1kkNRT0DUpxyLhp+W2aKokPFDv7SB9Ihfsm7McAqOFwiVCDmVwvkBP5Vbc701VDvjdJCumLj3TnAjXiV79cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwCoGiwq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708703078; x=1740239078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AImssem9VU8CF0rZUiMd5dBqWI5uMzEG8ynAi5lJ0vA=;
  b=lwCoGiwqd1tfpPP8LfNlHlY4+2I6JwKsQun3//3GckPypyQIOifOdtys
   JneqhR3LitYlqwykyZEoRZ1qmO9SSD4HP1AvabflxQOCMDhTIw4jyTIJr
   pt3TmZl8l5MId2wYhwxG6gPrMHkoVOsYjmJek7xy985txmEN6YIEDK8hF
   bA+YAGIBCmtYFNN8eJY2Cw1r2vs9RFUhV0lcB0pUF9mjfg27Z0ivmm85/
   QFMTJIke5ugqoxO7T2nm5oa+RmeAh5sTUX+IpuvDVlThGGEHrjgHhbyIY
   DFU0mua+KOp4xe/RV8zscDwSOTe2rqKa/HZSvYhFJy3wgHx/0ngaiDS/V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="20563561"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="20563561"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:44:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913749417"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913749417"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:44:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdXix-00000006wF9-2ICh;
	Fri, 23 Feb 2024 17:44:31 +0200
Date: Fri, 23 Feb 2024 17:44:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, tony@atomide.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	john.ogness@linutronix.de, tglx@linutronix.de,
	yangyicong@hisilicon.com, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
	fanghao11@huawei.com
Subject: Re: [PATCH v4] serial: port: Don't suspend if the port is still busy
Message-ID: <Zdi9X8qzQhNE3rGl@smile.fi.intel.com>
References: <20240223083903.42129-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223083903.42129-1-yangyicong@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 04:39:03PM +0800, Yicong Yang wrote:
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

> Cc: Tony Lindgren <tony@atomide.com>

No need to Cc to people whose tags you already have. The Git tools will add
them to the Cc list.

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>

In general, Cc is better to be either supplied with --cc or be located after
the cutter '---' line, so they won't pollute the commit message.

..

Code wise LGTM, thanks.
Minor remarks below, with them addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> +static int serial_port_runtime_suspend(struct device *dev)
> +{
> +	struct serial_port_device *port_dev = to_serial_base_port_device(dev);

> +	struct uart_port *port;

You can assign here

	struct uart_port *port = port_dev->port;

and save 2 LoCs.

> +	unsigned long flags;
> +	bool busy;
> +
> +	port = port_dev->port;

> +

If you want to have assignment separated, this blank line may be dropped.

> +	if (port->flags & UPF_DEAD)
> +		return 0;
> +
> +	uart_port_lock_irqsave(port, &flags);
> +	busy = __serial_port_busy(port);
> +	if (busy)
> +		port->ops->start_tx(port);
> +	uart_port_unlock_irqrestore(port, flags);
> +
> +	if (busy)
> +		pm_runtime_mark_last_busy(dev);
> +
> +	return busy ? -EBUSY : 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



