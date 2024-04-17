Return-Path: <linux-kernel+bounces-148080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD6D8A7D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D33B21770
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1246EB7A;
	Wed, 17 Apr 2024 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEUrXdTw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6956A8BA;
	Wed, 17 Apr 2024 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340406; cv=none; b=Z1/JehRxpQmYPob2tS3uUrG+H9aLC1fw/V10p6uDoit0IlYi8z6LxD2uqxGpf4bch4t1ZdsA8KyB8tChxKHCGul50o91ojyKMnXZdqoBABl59MDuxXtDWeXY31sCNWcoW7YP+lqGuEvcz6GaLbpgwZLNAU/JH7wfUmG3w5Ke0PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340406; c=relaxed/simple;
	bh=5l54YNXhhPbqCuj4BZ4xy0aZNQx9Pl5Q1ROBgoCPFWg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XVPwGVYvcityvKFCCoFYb3VStGcuXk0FV44vLgFLm2aJ949Pusi+7K5nT0JyFUP/lu7jkzxGli1JK1Hul/WOZ+EPLp4UQYHIwPuOojuM/ZS2JuRyYipPMZs+fdLX5wfPf/Dapv1OK9WhJfUiS5CsseECPMwwycs3tAh3315YZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEUrXdTw; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713340405; x=1744876405;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5l54YNXhhPbqCuj4BZ4xy0aZNQx9Pl5Q1ROBgoCPFWg=;
  b=oEUrXdTwhdMinnC1VF4Uv1WuuJVxARSFTgsBiJci7iZ1/5gONFyGAz/l
   +cSy12RsYL+7hiNTxabmMYNXtMFt25/TX8PkEGzft3t7mgBYtu3CQTc9Y
   AwagxdZBJRAIOaCe+CREaLP6fOeGUkVUHCQj/J27pGMen7zXqsZNcU26X
   fQzwphcQjPNk/va3fsJYf7HE2BvEliauBP93EGMXHOnY0UpoeEwXloVYM
   jNioUZVtgNG1/b93LTptTWWF5PkFStPob7y+uz2KUCtTCTKlGc84B/LPX
   mChwkXQa5idG3qFcqU/TuFx+zXNDSM6JVz3aD2xSKNhuneL6h//yq1RXU
   w==;
X-CSE-ConnectionGUID: B03Ih506TTiIoZo4gYZ/8w==
X-CSE-MsgGUID: PYNq6FS4QXKXE7QqwQ9Mxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8939286"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="8939286"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 00:53:10 -0700
X-CSE-ConnectionGUID: ScAnMQ9tRamATcZ+v/y4dA==
X-CSE-MsgGUID: Ndbtze/QQkSAdZ/pt7Zi6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22602983"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.35])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 00:52:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 17 Apr 2024 10:52:48 +0300 (EEST)
To: Michael Pratt <mcpratt@pm.me>
cc: LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Wander Lairson Costa <wander@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH v2 1/3] serial: core: Store fifo timeout again
In-Reply-To: <20240416182741.22514-2-mcpratt@pm.me>
Message-ID: <3355ac64-56d6-af6c-cc7a-03fa4f143db4@linux.intel.com>
References: <20240416182741.22514-1-mcpratt@pm.me> <20240416182741.22514-2-mcpratt@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Apr 2024, Michael Pratt wrote:

> This is a partial revert of Commit f9008285bb69
> ("serial: Drop timeout from uart_port").
> 
> In order to prevent having to calculate a timeout
> for the fifo device during a write operation, if enabled,
> calculate it ahead of time and store the value of the timeout
> in a struct member of uart_port.

Hi,

Why is calculating during write bad/wrong, you don't give any real 
justification for this change? You're talking about "low rates" in cover 
letter, which makes it even more confusing because writes occur very 
infrequently so a few math operations are nothing to be concerned of (in 
timescales UARTs operate in, no math penalty is really worth even 
discussing IMO).

-- 
 i.

> Signed-off-by: Michael Pratt <mcpratt@pm.me>
> ---
> V1 -> V2: new commit
> 
>  drivers/tty/serial/serial_core.c | 3 +++
>  include/linux/serial_core.h      | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index ff85ebd3a007..9b3176d684a4 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -414,6 +414,9 @@ uart_update_timeout(struct uart_port *port, unsigned int cflag,
>  
>  	temp *= NSEC_PER_SEC;
>  	port->frame_time = (unsigned int)DIV64_U64_ROUND_UP(temp, baud);
> +
> +	if (port->fifosize > 1)
> +		port->timeout = uart_fifo_timeout(port);
>  }
>  EXPORT_SYMBOL(uart_update_timeout);
>  
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 0a0f6e21d40e..c6422021152f 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -561,6 +561,7 @@ struct uart_port {
>  
>  	bool			hw_stopped;		/* sw-assisted CTS flow state */
>  	unsigned int		mctrl;			/* current modem ctrl settings */
> +	unsigned long		timeout;		/* character-based timeout */
>  	unsigned int		frame_time;		/* frame timing in ns */
>  	unsigned int		type;			/* port type */
>  	const struct uart_ops	*ops;
> 

