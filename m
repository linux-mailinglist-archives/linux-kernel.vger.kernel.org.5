Return-Path: <linux-kernel+bounces-64585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41CF85408C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D861C26BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CD764A8A;
	Tue, 13 Feb 2024 23:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/5GHkPC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10B369D2D;
	Tue, 13 Feb 2024 23:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868692; cv=none; b=SwJ/FLW+nndpmdHPmuXXeOULZ7g6xdtcG+fyOUqhydAR1mQq9RDQEVb8zuDipBt1DKzYgViL3x1NfOtUcV0B/trOhO0o7/3LCTNb0LSRHVG6qxRH/+T/PmUk+18DoanTcHSXDrfMhXwoXq9f2dEK0WYFKn2wTrUL2EU26T0XSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868692; c=relaxed/simple;
	bh=gNqNSc2uf6gFYuN9ZBm4KIxHP1qZmB6TQVFDZVxZC3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAhicaOyGWgUVxD+4gAQiq3iwLwcCOS860rUNFaIijPUnUXUii9INA/7Whz+3XUcrw/CMGv/7pSIvuUhvGgHFXPqRcdjhej/L9x1J4UVGTVdh4OCgKSfro0tBr6GUc4e0W6P16n56m/3GNp2jfuucVFMmEa1aGKGAa8q5DiQ64g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/5GHkPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8C4C433C7;
	Tue, 13 Feb 2024 23:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707868692;
	bh=gNqNSc2uf6gFYuN9ZBm4KIxHP1qZmB6TQVFDZVxZC3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/5GHkPCttL6z0RfSJrW5H17w2Bo+fpdUaCfIdqb0Xb9UV3PHHBzIS0DGbiuehz0X
	 qU5PRq7oQgJv0z6E5VDh5FvGXTh+azQCwx3AjSxOrKXixZ3qvnQvNRhH0Urv+0OsZz
	 M7pFG1lWRbCO9iGA3hj4yk+Rzygz9cTHb2eSf8zcR2C6TcFUE8MY2tLO+VQmjwAjd0
	 o2OYchSxIT6d0dYH63S8J6ncIYRzp1atQ6prUPAXz9n5BECMJLlyPuhOWzhR9mUjRx
	 RDmk61rwMx/RZP5Gn3UgpuKnmeCkB0WVoYT3wzgmmb9DrMv+S4MF1gok0he/CQ4cr6
	 5P8BwM+z+SpfA==
Received: by mercury (Postfix, from userid 1000)
	id 55B4D1061C38; Wed, 14 Feb 2024 00:58:09 +0100 (CET)
Date: Wed, 14 Feb 2024 00:58:09 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "David S . Miller" <davem@davemloft.net>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dhruva Gole <d-gole@ti.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Johan Hovold <johan@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 4/6] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
Message-ID: <jnfrv7wj4wigtzsh7r7p4zgbtim64kniriwbtjc3pebznyvwtk@7l36wdfn6tja>
References: <20240213084545.40617-1-tony@atomide.com>
 <20240213084545.40617-5-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213084545.40617-5-tony@atomide.com>

Hi,

On Tue, Feb 13, 2024 at 10:45:11AM +0200, Tony Lindgren wrote:
> We can now add hardware based addressing for serial ports. Starting with
> commit 84a9582fd203 ("serial: core: Start managing serial controllers to
> enable runtime PM"), and all the related fixes to this commit, the serial
> core now knows to which serial port controller the ports are connected.
> 
> The serial ports can be addressed with DEVNAME:0.0 style naming. The names
> are something like 00:04:0.0 for a serial port on qemu, and something like
> 2800000.serial:0.0 on platform device using systems like ARM64 for example.
> 
> The DEVNAME is the unique serial port hardware controller device name, AKA
> the name for port->dev. The 0.0 are the serial core controller id and port
> id.
> 
> Typically 0.0 are used for each controller and port instance unless the
> serial port hardware controller has multiple controllers or ports.
> 
> Using DEVNAME:0.0 style naming actually solves two long term issues for
> addressing the serial ports:
> 
> 1. According to Andy Shevchenko, using DEVNAME:0.0 style naming fixes an
>    issue where depending on the BIOS settings, the kernel serial port ttyS
>    instance number may change if HSUART is enabled
> 
> 2. Device tree using architectures no longer necessarily need to specify
>    aliases to find a specific serial port, and we can just allocate the
>    ttyS instance numbers dynamically in whatever probe order
> 
> To do this, let's match the hardware addressing style console name to
> the character device name used, and add a preferred console using the
> character device name.
> 
> Note that when using console=DEVNAME:0.0 style kernel command line, the
> 8250 serial console gets enabled later compared to using console=ttyS
> naming for ISA ports. This is because the serial port DEVNAME to character
> device mapping is not known until the serial driver probe time. If used
> together with earlycon, this issue is avoided.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

I would expect an update to the console= section in [0] somewhere in
this series.

[0] Documentation/admin-guide/kernel-parameters.txt

Greetings,

-- Sebastian

