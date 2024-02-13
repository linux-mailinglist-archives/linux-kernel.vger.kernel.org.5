Return-Path: <linux-kernel+bounces-63289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4890D852D49
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D151F2ADB0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD82511E;
	Tue, 13 Feb 2024 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXpHJn1F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329FD2421F;
	Tue, 13 Feb 2024 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818298; cv=none; b=tIFfoPDwe2XwLe6ovgMU6JKqZ3yGMfZb7UHIK6eoX2a+1BcXrnvGdEYFdSYSU1VhdXqFRI4SqjEGmV73kwYjoQgEO8+Lk07boA/hWMNtaD8hitklthWhN9sFkrRj/mfZLvAqO2Bsoj4pm9fm1BYcPVD9vzfLvtmDEa1xWU2rIvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818298; c=relaxed/simple;
	bh=VuVC5DVt6OYP+BgQzXBubGFYfL8/9v3YgwDCs/6JVh4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=ASJ+HrK91iMLa92+j9PdCJwjKFNbMAiFkDda74+zIPyc6dqFO7QkwWJlju7WdB9r7hXtJifUUYBTwUgK8BBPDHLN3e1TetA6qg4afPU5A14cVycYW1xtMIrlJE7NYonI9DKpJuFvi2p1rniirjxqf72ePXjHW4wafYaegCyz9wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXpHJn1F; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707818297; x=1739354297;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=VuVC5DVt6OYP+BgQzXBubGFYfL8/9v3YgwDCs/6JVh4=;
  b=HXpHJn1FAx8ut6o+LEtPasX8vz5jR6IHcbmbFyJtoGjz92xU59edeoYT
   n+G7XXj7lCGJuZQSkiMN1YPq3nYHzenGETH71nl6JEMf41clm4ebinbVF
   UE4P5wS7fQEOjDJh71mkF7tK3LE7HDDHS4C7lPJKvwDuWUvCUhznntzpy
   hb2+T55aOCgt0gnwa4Jh5AcokY1SY8F1q37c9rTJTyQWMj53JeVZIwPmY
   wGCt7iHK4AVa5yPVBn6F20E8hSwVQzAsv62v81054mA33s88e0P/zEqwU
   eqqTJaZSqo5vw8kMHQRbb9Sf8TzdHc0t3g4XGUNOQe4muqw3t7u2ZD3Pu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1686484"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="1686484"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 01:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935313672"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="935313672"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2024 01:58:14 -0800
Message-ID: <1b2558f7-94ea-123e-dd3f-b43ecd85c2ef@linux.intel.com>
Date: Tue, 13 Feb 2024 11:59:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Jan Henrik Weinstock <jan@mwa.re>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Lukas_J=c3=bcnger?= <lukas@mwa.re>
References: <CANi1PHh4W7KPagKkvZW6cNAQqgAeG3zxaaTJKkg3KiTbsFRMdg@mail.gmail.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: XHCI without USB2 ports
In-Reply-To: <CANi1PHh4W7KPagKkvZW6cNAQqgAeG3zxaaTJKkg3KiTbsFRMdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.2.2024 20.39, Jan Henrik Weinstock wrote:
> Hi all,
> 
> I am currently working on an XHCI platform device simulation model. I
> noticed that the Linux driver (Linux 6.5.6 xhci-hcd) stops working
> when I configure the model without any USB2 ports. During an interrupt
> (TRB_PORT_STATUS), I only get "xhci-hcd 12100000.usb: ignore port
> event for removed USB3 hcd."
> 
> During xhci_irq, in handle_port_status, xhci->shared_hcd is NULL [1],
> so the interrupt gets ignored. However, shared_hcd would only ever be
> allocated during xhci_plat_probe [2], if the device has both USB2 and
> USB3 ports, i.e. xhci_has_one_roothub returns false [3].
> 
> Without any USB2 ports, a shared_hcd will never be allocated in the
> first place, and handle_port_status will always exit early.

This is true.
That port handling code is from a time before xhci driver supported single
roothub setups.

I think all single roothub cases so far have been xHC hosts with only USB2
ports. This is probably the first one with only USB3 ports.

I have a vague memory that USB3 specification would require USB3 ports to
be backwards compatible, and support USB2.

But xhci driver could still support it, does this change help:

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index f0d8a607ff21..6ef081f5ef05 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1893,7 +1893,8 @@ static void handle_port_status(struct xhci_hcd *xhci,
         }
  
         /* We might get interrupts after shared_hcd is removed */
-       if (port->rhub == &xhci->usb3_rhub && xhci->shared_hcd == NULL) {
+       if (!xhci_has_one_roothub(xhci) && xhci->shared_hcd == NULL &&
+           port->rhub == &xhci->usb3_rhub) {
                 xhci_dbg(xhci, "ignore port event for removed USB3 hcd\n");
                 bogus_port_status = true;
                 goto cleanup;

Thanks
Mathias


