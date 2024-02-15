Return-Path: <linux-kernel+bounces-67318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A70C88569B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08886B20CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB05135A75;
	Thu, 15 Feb 2024 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpm7YOKx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3F13398C;
	Thu, 15 Feb 2024 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015225; cv=none; b=qZurzi3MdVYmEKTnEksAuduzBMUrx2B1CWy6YUEp+B4XSVX1OmSps6uh+fMSfanw3JirY4UHx97XB/3sL9hzejsMBkSqc7XVv9I65GlTMgLGFXO5RN356f3xXv42c6BlUedeS5nRM+DNaxgsjUo4GBBMUTRz4CDOjJdNBL8BSi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015225; c=relaxed/simple;
	bh=nrYn4SzXPl6GpL5y8qh9llXmJREkwJ8S/5Yc/GYxsjE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L7sLBAtu/vvkioDxeXtXbsIJjIl7Mmaw4ErOJgtJCgD6BNIiwFb37LPkuA86oh09+h4v8OAWll+baw/4LvHC1kdCKyB4/aHj52iU2q9JEYuKHoeQJIMx/cIMKz0Fx3lUbGN/MYqAQSriDswS3WxNSMXyRS+yxqnG8HbJXeXX5bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpm7YOKx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708015224; x=1739551224;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nrYn4SzXPl6GpL5y8qh9llXmJREkwJ8S/5Yc/GYxsjE=;
  b=mpm7YOKxwcfEpGlfR9GKrv+ogZJxVgcwHy7EdvYlUW9641cjmUIvkhiL
   4XMT0cUFJXasGvi9QW8E8d+g7wtGynKMun+1iT2Zzk8J2oIh0/74yb64o
   kPhftwtIfxlb3DEFvQCejMdvY4Z/6c/axZoJYJOK16Mck3by3SE8bdLUi
   ynogIqJMFZwDvRotoP+0d7dKhdfqRylVdFXBs6UgL1q0Kj23mB7MlxmP1
   /dU3D3xaKUhIlB0xGGD/urPXHTI40Nfu+MnECuKTS6NBSEOBa54woNbd2
   6pBQBPG0IZV2s0W6XDII0edtYdc/+0DYrjfSKgFh6BmvWgGfR+cH1fQ1a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="13503697"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="13503697"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:40:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="8280213"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.150])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:40:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 15 Feb 2024 18:40:15 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: 8250_of: Drop quirk fot NPCM from
 8250_port
In-Reply-To: <20240215145029.581389-1-andriy.shevchenko@linux.intel.com>
Message-ID: <835925e0-0df0-fed6-6b29-0cf4a9f811b0@linux.intel.com>
References: <20240215145029.581389-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 Feb 2024, Andy Shevchenko wrote:

> We are not supposed to spread quirks in 8250_port module especially
> when we have a separate driver for the hardware in question.
> 
> Move quirk from generic module to the driver that uses it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: added missing bits.h, reworked error handling in a switch-case
>  drivers/tty/serial/8250/8250_of.c   | 44 +++++++++++++++++++++++++++--
>  drivers/tty/serial/8250/8250_port.c | 24 ----------------
>  2 files changed, 42 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index 34f17a9785e7..9dcc17e33269 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -4,7 +4,10 @@
>   *
>   *    Copyright (C) 2006 Arnd Bergmann <arnd@arndb.de>, IBM Corp.
>   */
> +
> +#include <linux/bits.h>
>  #include <linux/console.h>
> +#include <linux/math.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/serial_core.h>
> @@ -25,6 +28,36 @@ struct of_serial_info {
>  	int line;
>  };
>  
> +/* Nuvoton NPCM timeout register */
> +#define UART_NPCM_TOR          7
> +#define UART_NPCM_TOIE         BIT(7)  /* Timeout Interrupt Enable */
> +
> +static int npcm_startup(struct uart_port *port)
> +{
> +	/*
> +	 * Nuvoton calls the scratch register 'UART_TOR' (timeout
> +	 * register). Enable it, and set TIOC (timeout interrupt
> +	 * comparator) to be 0x20 for correct operation.
> +	 */
> +	serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE | 0x20);
> +
> +	return serial8250_do_startup(port);

I know this matches how it is currently done but I wonder if TOIE 
should not be enabled until ->setup_irq() has been called.

-- 
 i.


