Return-Path: <linux-kernel+bounces-122447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0D688F7A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785F829572F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE284E1D0;
	Thu, 28 Mar 2024 06:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="swEcdWQK"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0F1CAAC;
	Thu, 28 Mar 2024 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605949; cv=none; b=teb/Q8nwSVTBBVRbtiuyLKzdyDlfCYBLdW0szumO/CJxumoBVBwEElIfQR3ThuzudMMJbnihMk3ijMUAx5MPKU26xeIb2+WUA3jcJQuxzidpGkJqAse+DA1P2VVJWM73uwa0RaunbNtJvwQAVKUO+rSJYjwnL/iJNcPv0UNnzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605949; c=relaxed/simple;
	bh=ABYblnci5DuY9zuX72BJyFDfbDWX7R9abq6IDLqDHuE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmBPpQu7qjLoKJDz+3fexMbF0/sFJ8uFaoGIpFpZUqCWd9xzay8Nc1m+NI2xatyx0aHbKKzn+aI1kSO6ZwT6Vhrauzt1bcKyBQfdov1aa9CejlcfzIsPmqpGRkliAuuHGSjOj1QWX9grBGTUgSypfbnN+bxr0zf713KTmPYe7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=swEcdWQK; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42S658mR032721;
	Thu, 28 Mar 2024 01:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711605908;
	bh=pwH+ggQvvyFr5UgfIb0P+cau43yIc2EcVeYd5t4MYxU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=swEcdWQKpeNYpHRlp72e0BYtv8a3XxVn5euvFUILe2DD/g+cQP0gV0RAuJszO2KNg
	 eDTUYtsvHc4JcepDuqHjDBNki8SF/69btNdyMC4eR/FB8vkazre0S2R5tS2MSZ5kdC
	 Eth5KXoXl4h2y6k9yAAkhD7abMMJH+cArqgykLy4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42S658BH090463
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Mar 2024 01:05:08 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 01:05:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 01:05:08 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42S657tu025790;
	Thu, 28 Mar 2024 01:05:07 -0500
Date: Thu, 28 Mar 2024 11:35:06 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness
	<john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?=
	<ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 7/7] Documentation: kernel-parameters: Add DEVNAME:0.0
 format for serial ports
Message-ID: <20240328060506.zhd7xctahudscoao@dhruva>
References: <20240327110021.59793-1-tony@atomide.com>
 <20240327110021.59793-8-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240327110021.59793-8-tony@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Tony,

On Mar 27, 2024 at 12:59:41 +0200, Tony Lindgren wrote:
> Document the console option for DEVNAME:0.0 style addressing for serial
> ports.

Thanks, this will really add in more context for people unaware.

> 
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -785,6 +785,25 @@
>  			Documentation/networking/netconsole.rst for an
>  			alternative.
>  
> +		<DEVNAME>:<n>.<n>[,options]
> +			Use the specified serial port on the serial core bus.
> +			The addressing uses DEVNAME of the physical serial port
> +			device, followed by the serial core controller instance,
> +			and the serial port instance. The options are the same
> +			as documented for the ttyS addressing above.
> +
> +			The mapping of the serial ports to the tty instances
> +			can be viewed with:
> +
> +			$ ls -d /sys/bus/serial-base/devices/*:*.*/tty/*
> +			/sys/bus/serial-base/devices/00:04:0.0/tty/ttyS0
> +
> +			In the above example, the console can be addressed with
> +			console=00:04:0.0. Note that a console addressed this
> +			way will only get added when the related device driver
> +			is ready. The use of an earlycon parameter in addition to
> +			the console may be desired for console output early on.

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

