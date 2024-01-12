Return-Path: <linux-kernel+bounces-24703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4232B82C10D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAACB1F22EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03F16D1B3;
	Fri, 12 Jan 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QR/KQuBT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B276BB57;
	Fri, 12 Jan 2024 13:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC25C433C7;
	Fri, 12 Jan 2024 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705067157;
	bh=3JvVbXEnnqfnUcUOJti8cVIgK7zS+xCztEk0ikLx4bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QR/KQuBT4SI9zAmjsxh+lK2uJYFId8jfgfi57BoDSrw7XEVNb5SWhIf4ptc3B72/g
	 p/PbGG+75eylrbonEh9SUr9p/5N7j0HDhmYkEBThJhlHVkNP1ZBnTTsYF+1h9ZsWsO
	 +yWCrn20MHFBYNsdeH5TTIlsMVLKzH9+EHF5umXc=
Date: Fri, 12 Jan 2024 14:45:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gui-Dong Han <2045gemini@gmail.com>
Cc: jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com, tony@atomide.com,
	l.sanfilippo@kunbus.com, john.ogness@linutronix.de,
	tglx@linutronix.de, andriy.shevchenko@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	baijiaju1990@outlook.com, stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix double fetch in
 uart_throttle/uart_unthrottle
Message-ID: <2024011259-drab-ashy-0370@gregkh>
References: <20240112121844.17580-1-2045gemini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112121844.17580-1-2045gemini@gmail.com>

On Fri, Jan 12, 2024 at 08:18:44PM +0800, Gui-Dong Han wrote:
> In uart_throttle() and uart_unthrottle():
>     if (port->status & mask) {
>         port->ops->throttle/unthrottle(port);
>         mask &= ~port->status;
>     }
>     // Code segment utilizing the mask value to determine UART behavior
> 
> In uart_change_line_settings():
>     uart_port_lock_irq(uport);
>     // Code segment responsible for updating uport->status
>     uart_port_unlock_irq(uport);
> 
> In the uart_throttle() and uart_unthrottle() functions, there is a double
> fetch issue due to concurrent execution with uart_change_line_settings().
> In uart_throttle() and uart_unthrottle(), the check
> if (port->status & mask) is made, followed by mask &= ~port->status,
> where the relevant bits are cleared. However, port->status may be modified
> in uart_change_line_settings(). The current implementation does not ensure
> atomicity in the access and modification of port->status and mask. This
> can result in mask being updated based on a modified port->status value,
> leading to improper UART actions.

What would be modifying the status and mask at the same point in time?
Are you sure that it is possible do this?

> This possible bug is found by an experimental static analysis tool
> developed by our team, BassCheck[1]. This tool analyzes the locking APIs
> to extract function pairs that can be concurrently executed, and then
> analyzes the instructions in the paired functions to identify possible
> concurrency bugs including data races and atomicity violations. The above
> possible bug is reported when our tool analyzes the source code of
> Linux 5.17.

5.17 is VERY old and obsolete, please work against 6.7 at the oldest.
No one can take a patch for 5.17 anymore, you know this :(

thanks,

greg k-h

