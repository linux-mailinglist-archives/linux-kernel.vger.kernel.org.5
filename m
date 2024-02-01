Return-Path: <linux-kernel+bounces-48055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC338456B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F47A1F267D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BE215D5C4;
	Thu,  1 Feb 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiBNNyMw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B7A15D5B4;
	Thu,  1 Feb 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788778; cv=none; b=p05150c0HQNbd1d0OlSCF19UPmky9T/6QjpdvcohIPKMmGwthJa6qDzzj+Na+TwgUzq481gzZMcuWpF2HvCOTDPOqrG0FhBE7avwIBvCCdRmqqyIhTunzUgJK0Fj1ZoV9lNv8tXIUjjJmiquPG0YD/xZGjPMcPRe6b9I60baftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788778; c=relaxed/simple;
	bh=TVUCRYYR7L1IT+ME8oTcX1x2Rr9n3YCLMjyOODsG+BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eT9daKrl2NiiqPGm1z8mQYHOi+LBfsU0b57lg2qN5Y6Val3R25Uv07KngdfZM0p4VgsxNnRuYRQA+I24QKGSBxyBX3R1c5wsaKGNXHV7yUsfkbXemSf2zumGYr8xkPsZrooyPg0+i9Fne/rfa/wLWrk56HK0h3ilQSf6up9Q6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiBNNyMw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706788777; x=1738324777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TVUCRYYR7L1IT+ME8oTcX1x2Rr9n3YCLMjyOODsG+BU=;
  b=RiBNNyMwVlE5SKeiqTu0Hv5jJNLUxwVcITT+TBBZGTfI/EagY5DlslQI
   5zW5AS8IPCbirZvKJZP64WisKH6cbt1AaIbQ0N6zds/rVVgM7ldCuQahW
   sN68e6RE/Xx6h7FtNKRf/pD+2qTNUFZX7ErmnlfyxxENoqWr/eUiQf+Q/
   SXe7l0smXxUAygc6B7K4pWa4s6fKkpORtOmxr0QzlQTFSaks9LUm5g1xX
   KKybGVJZZ3pjl5WvchjhPuvCPcXl4zVloBsJ1xSQn7d87XOMd96Xz+4hl
   SIe4VjT8qU7gcJ92LpU7638a2YaAjBc0ndtfZB1LXLzYvDAGsTQLR30iI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10531082"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10531082"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 03:59:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="738409877"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="738409877"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 03:59:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVVbz-00000000p6M-3icn;
	Thu, 01 Feb 2024 13:52:07 +0200
Date: Thu, 1 Feb 2024 13:52:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rengarajan.S@microchip.com
Cc: Kumaravel.Thiagarajan@microchip.com, jiaqing.zhao@linux.intel.com,
	gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
	john.ogness@linutronix.de, tony@atomide.com,
	linux-kernel@vger.kernel.org, Tharunkumar.Pasumarthi@microchip.com,
	jirislaby@kernel.org, f.fainelli@gmail.com, tglx@linutronix.de,
	UNGLinuxDriver@microchip.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 tty] 8250: microchip: Add 4 Mbps support in PCI1XXXX
 UART
Message-ID: <ZbuF53TlbnD09rZA@smile.fi.intel.com>
References: <20240125100619.154873-1-rengarajan.s@microchip.com>
 <ZbZyW_g4OOkCqIxf@smile.fi.intel.com>
 <8406d8866968950b9bb2f2c01aaa92e3107a7a00.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8406d8866968950b9bb2f2c01aaa92e3107a7a00.camel@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 30, 2024 at 10:52:41AM +0000, Rengarajan.S@microchip.com wrote:
> On Sun, 2024-01-28 at 17:27 +0200, Andy Shevchenko wrote:
> > On Thu, Jan 25, 2024 at 03:36:19PM +0530, Rengarajan S wrote:

..

> > > +     /*
> > > +      * Microchip PCI1XXXX UART supports maximum baud rate up to 4
> > > Mbps
> > > +      */
> > > +     if (up->port.type == PORT_MCHP16550A)
> > > +             max = 4000000;
> > 
> > No. Please refactor the way the 8250_port won't be modified.
> > 
> > Also you have a define for this constant, use it.
> 
> The current UART clk in MCHP Ports in pci1xxxx.c is set to 62.5 MHz in
> order to support fractional baud rates which enables generation of
> acceptable baud rate and lower error percentage from any available
> frequency. With 62.5 MHz the maximum supported baud rate supported as
> per serial_8250_get_baud_rate is 3.9 Mbps. In order to extend the
> support to 4 Mbps we had hardcoded the max value to 4 Mbps. Since, baud
> rate is calculated here we needed to make these changes in 8250_port
> and could not find a way to handle as part 8250_pci1xxxx. Can you let
> us know any alternatives to address this upper(max) limit? 

Update port->uartclk accordingly in your driver, see how other 8250_* drivers
do that (e.g., 8250_mid).

So, it will no go with hack in the 8250_port.

-- 
With Best Regards,
Andy Shevchenko



