Return-Path: <linux-kernel+bounces-54615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD6184B188
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B04285937
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215A912D17B;
	Tue,  6 Feb 2024 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JO6Eluaq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F0E12D146;
	Tue,  6 Feb 2024 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212674; cv=none; b=kYjW3RRmTCbR56TtRVKVNBDevJpTlKbUqC1HypGxlaefkttOlJTK4pJUMQD/vN5CXjIbtafnwEda1moSIZcijJMQL38VcoEGkFYPSIkdrv+kq+WmbLT51o3J5rGuDTrAWmv7JypG2vp2386VjziZhAPNseI+c6yIuRTt5XfYoSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212674; c=relaxed/simple;
	bh=tg9pHfnMgYgL/Q/jdYJ/Y5q7DJviTwxBb9aNHAB6+1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecTbAgfXvbJ5Gf8OQzNTMZOcIHxvEWPmri18SszTdDrd4kRw1BrnuHGfkS/W8QOlOjWOZ9A2y1tbKJpskAc+1tL4jILv7xm5QBdmgrJp1b8sdl+gjZAW9jirUSnQ3l8G8+0JDDC+92C8vW1j2h1GSZO4r8XlQsOlvmzf48yu1tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JO6Eluaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D799C433C7;
	Tue,  6 Feb 2024 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707212673;
	bh=tg9pHfnMgYgL/Q/jdYJ/Y5q7DJviTwxBb9aNHAB6+1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JO6EluaqjikBYJ17aVisH1Kw8Bz59GJOa5l880B3n3Vljz9Mc3hIDqBeHImTnC5HE
	 cThoXmAfLV6WR9qqztBXWnZaeGOtKenm1tL19ROp28o8ziVVMJ5aEYDKJFJpe00HHE
	 iaJzqQLoNqQg1VljCvnZAdtHl8xQcQNNaBz5z3ao=
Date: Tue, 6 Feb 2024 09:44:30 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: jirislaby@kernel.org, tony@atomide.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, john.ogness@linutronix.de,
	andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
	yangyicong@hisilicon.com, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
	fanghao11@huawei.com
Subject: Re: [PATCH v2] serial: port: Don't suspend if the port is still busy
Message-ID: <2024020600-attendant-verbally-6441@gregkh>
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
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Is this a regression that was caused by the port code?  If so, what
commit id does this fix?  Should it be backported to older kernels?

thanks,

greg k-h

