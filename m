Return-Path: <linux-kernel+bounces-118385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C284188BA06
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EDE1F3B4DC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A382912AAD2;
	Tue, 26 Mar 2024 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="weP52to5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F8A1B7E4;
	Tue, 26 Mar 2024 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432587; cv=none; b=p59L/z+rXdY/9YOoGuy2f0B/EoaJf9ViV8W8QvlAmOtYPScQ0ExpoaWfFck6ZKQ2GgRmAA7gkfZ0jf5qzTNXJhXmWQvN7qGvMmED9M4Zk+abCK6TXHOwjJByz7MhXh+fvPM3WMosUBv12Ev/RzvHb6cssYhPNitKnGpiPsGO0bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432587; c=relaxed/simple;
	bh=DYedrnzxlTe1VeOFK/CO18oP7VDPvF0ibdLq+EfeSwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnzZrcFYBqHT284Eq6bix9WE00Xb041dxxgZzsupusJOWse8veFhq1SpawkyW2cXqoXzpodjCRJGICny4Ome9tz6xsN7IeW7i/tcuGqWo+4RiJAjavmxG3eVuh2LwK5k5Gsfb26uAHu6r5cq5LoiA3CXOsz2V6bxyDLkBpF+Tus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=weP52to5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6489C433C7;
	Tue, 26 Mar 2024 05:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711432585;
	bh=DYedrnzxlTe1VeOFK/CO18oP7VDPvF0ibdLq+EfeSwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=weP52to5auGTJjVTp/7ceVkBPI2AzwTTFbws4Ep8342AZyltrjXCR7DvjKH2xFS5a
	 gQiQI1V6qOtJT8DsQxDjOjrZRR84ruP4BcGrF6Y6ThehNg+vGsXfSiIc1JWSgu+Mx5
	 m6Z0M4rqe6DZLB33w1wZkQ/XJhVCcVz8drvUouXA=
Date: Tue, 26 Mar 2024 06:56:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
	oneukum@suse.com, Roy Luo <royluo@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: Disable USB3 LPM at shutdown
Message-ID: <2024032608-refinish-ambulance-84f7@gregkh>
References: <20240305065140.66801-1-kai.heng.feng@canonical.com>
 <CAAd53p7P_-4voZ49=WKpDCg9tx4QRV2NEG5FyqitsAc-Yzm2VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p7P_-4voZ49=WKpDCg9tx4QRV2NEG5FyqitsAc-Yzm2VA@mail.gmail.com>

On Tue, Mar 26, 2024 at 11:38:48AM +0800, Kai-Heng Feng wrote:
> On Tue, Mar 5, 2024 at 2:52 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > SanDisks USB3 storage may disapper after system reboot:
> >
> > usb usb2-port3: link state change
> > xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x2c0
> > usb usb2-port3: do warm reset, port only
> > xhci_hcd 0000:00:14.0: xhci_hub_status_data: stopping usb2 port polling
> > xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2b0, return 0x2b0
> > usb usb2-port3: not warm reset yet, waiting 50ms
> > xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2f0, return 0x2f0
> > usb usb2-port3: not warm reset yet, waiting 200ms
> > ...
> > xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x6802c0, return 0x7002c0
> > usb usb2-port3: not warm reset yet, waiting 200ms
> > xhci_hcd 0000:00:14.0: clear port3 reset change, portsc: 0x4802c0
> > xhci_hcd 0000:00:14.0: clear port3 warm(BH) reset change, portsc: 0x4002c0
> > xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x2c0
> > xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2c0, return 0x2c0
> > usb usb2-port3: not enabled, trying warm reset again...
> >
> > This is due to the USB device still cause port change event after xHCI is
> > shuted down:
> >
> > xhci_hcd 0000:38:00.0: // Setting command ring address to 0xffffe001
> > xhci_hcd 0000:38:00.0: xhci_resume: starting usb3 port polling.
> > xhci_hcd 0000:38:00.0: xhci_hub_status_data: stopping usb4 port polling
> > xhci_hcd 0000:38:00.0: xhci_hub_status_data: stopping usb3 port polling
> > xhci_hcd 0000:38:00.0: hcd_pci_runtime_resume: 0
> > xhci_hcd 0000:38:00.0: xhci_shutdown: stopping usb3 port polling.
> > xhci_hcd 0000:38:00.0: // Halt the HC
> > xhci_hcd 0000:38:00.0: xhci_shutdown completed - status = 1
> > xhci_hcd 0000:00:14.0: xhci_shutdown: stopping usb1 port polling.
> > xhci_hcd 0000:00:14.0: // Halt the HC
> > xhci_hcd 0000:00:14.0: xhci_shutdown completed - status = 1
> > xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x1203, return 0x203
> > xhci_hcd 0000:00:14.0: set port reset, actual port 2-3 status  = 0x1311
> > xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x201203, return 0x100203
> > xhci_hcd 0000:00:14.0: clear port3 reset change, portsc: 0x1203
> > xhci_hcd 0000:00:14.0: clear port3 warm(BH) reset change, portsc: 0x1203
> > xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x1203
> > xhci_hcd 0000:00:14.0: clear port3 connect change, portsc: 0x1203
> > xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x1203, return 0x203
> > usb 2-3: device not accepting address 2, error -108
> > xhci_hcd 0000:00:14.0: xHCI dying or halted, can't queue_command
> > xhci_hcd 0000:00:14.0: Set port 2-3 link state, portsc: 0x1203, write 0x11261
> > xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x1263, return 0x263
> > xhci_hcd 0000:00:14.0: set port reset, actual port 2-3 status  = 0x1271
> > xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x12b1, return 0x2b1
> > usb usb2-port3: not reset yet, waiting 60ms
> > ACPI: PM: Preparing to enter system sleep state S5
> > xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x12f1, return 0x2f1
> > usb usb2-port3: not reset yet, waiting 200ms
> > reboot: Restarting system
> >
> > The port change event is caused by LPM transition, so disabling LPM at shutdown
> > to make sure the device is in U0 for warmboot.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> A gentle ping...

It was the middle of the merge window, we couldn't do anything with new
changes, right?

And if you wish to see patches get merged quicker, please help review
other patches on the list, that will reduce the workload of the
maintainers.  Why haven't you done that while waiting?

thanks,

greg k-h

