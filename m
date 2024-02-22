Return-Path: <linux-kernel+bounces-76840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802EB85FD73
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D9A1F23960
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B371414F9E4;
	Thu, 22 Feb 2024 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bN9vPhX5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CEE138496;
	Thu, 22 Feb 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617717; cv=none; b=CQOWRz6kGPqxRvg3NpvLIuBamKO60+7NMY5SPrSy9LZXwZIrkKwu9Z844ZCvRFUPEHchQ882JBfsha2TsGClSDLbHP7JL6B0qKmdEkE2m3IsnYzJfxTsjfhnpziN/dZ5A73vWjzQCC0e2ktO2hPiUldCWI5lK5YwwRheyei+GgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617717; c=relaxed/simple;
	bh=SUuCGHBfr+e9wXEmhb8mV4moLDcmcxBNTGHyspNshv4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G9eD+SUel+Fwy1lL7gdr+/5ko6V/80dp+YZH89GQPL8IvhqkHcdchKO0q+n5UMTyAweopdA0/TQd/vnHJZ9rHmDuaii6XmZ3HIevpyj2kz6vmOR09gkZZbd2UL1z0S/JY8hBrpDXIr9x1GqgbEZYyYaIOamnUv9m5pubgaqad8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bN9vPhX5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708617716; x=1740153716;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SUuCGHBfr+e9wXEmhb8mV4moLDcmcxBNTGHyspNshv4=;
  b=bN9vPhX5RQymB4F+Z9mwZMpt3PpHyWTh3eFFHXIpR2vzqansK3HVahdU
   KPosKJsl8bnPrzoSa4HbalO+pK0RpLBLIMV6mAoG1PnJpmgsHGVy10rN+
   /sBZ4UT2bCwuxXg4dHDHFKwynyHkxAUs2mapH3JbmG6crVNz4AxV8zc9c
   Uk63pRLbO6qv071RSP9j+ZuO6V5NAHz9Qu9geVikT+rQVXkDWNOj7qHJX
   6msGTCIaerZA+ChJtqBz2G7wK+G8ioej3+Z2dhVcm9yel2u98iQ0LdUaY
   UmmYO8wQONRq2y0R44m01kT0V7PQL8Vfc+8xdTbpQYNH08RaH0qRroaq+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="5801777"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5801777"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:01:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="36363798"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.249.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:01:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 22 Feb 2024 18:01:34 +0200 (EET)
To: Rengarajan S <rengarajan.s@microchip.com>
cc: kumaravel.thiagarajan@microchip.com, tharunkumar.pasumarthi@microchip.com, 
    gregkh@linuxfoundation.org, jirislaby@kernel.org, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
    unglinuxdriver@microchip.com
Subject: Re: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
In-Reply-To: <20240222134944.1131952-1-rengarajan.s@microchip.com>
Message-ID: <37490c91-a48f-e0a1-ec92-2307c08260e2@linux.intel.com>
References: <20240222134944.1131952-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Feb 2024, Rengarajan S wrote:

> Updated the TX Burst implementation by changing the circular buffer
> processing with the pre-existing APIs in kernel. Also updated conditional
> statements and alignment issues for better readability.
> 
> Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
> ---

> @@ -434,16 +435,7 @@ static void pci1xxxx_tx_burst(struct uart_port *port, u32 uart_status)
>  
>  	xmit = &port->state->xmit;
>  
> -	if (port->x_char) {
> -		writeb(port->x_char, port->membase + UART_TX);
> -		port->icount.tx++;
> -		port->x_char = 0;
> -		return;
> -	}
> -
> -	if ((uart_tx_stopped(port)) || (uart_circ_empty(xmit))) {
> -		port->ops->stop_tx(port);
> -	} else {
> +	if (!(port->x_char)) {
>  		data_empty_count = (pci1xxxx_read_burst_status(port) &
>  				    UART_BST_STAT_TX_COUNT_MASK) >> 8;
>  		do {
> @@ -453,15 +445,22 @@ static void pci1xxxx_tx_burst(struct uart_port *port, u32 uart_status)
>  						    &data_empty_count,
>  						    &valid_byte_count);
>  
> -			port->icount.tx++;
>  			if (uart_circ_empty(xmit))
>  				break;
>  		} while (data_empty_count && valid_byte_count);
> +	} else {
> +		writeb(port->x_char, port->membase + UART_TX);
> +		port->icount.tx++;
> +		port->x_char = 0;
> +		return;

Why you made this reorganization for x_char handling?? It seems 
entirely wrong thing to do, x_char should have precendence over 
sending normal chars.

This patch would have been some much simpler to review if it would have 
not attempted to n things in one go, please try to split into sensible 
changes.


-- 
 i.


