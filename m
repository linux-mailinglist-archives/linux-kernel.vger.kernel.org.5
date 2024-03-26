Return-Path: <linux-kernel+bounces-118386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F32888BA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC4F2E382E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDB812AAD2;
	Tue, 26 Mar 2024 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hDlavuOz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238771B7E4;
	Tue, 26 Mar 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432613; cv=none; b=n6oIy0UrOXtjHFKvdO20vpxjRVhbr7O6e71riyOydtYfoAlPX351lULp1L7N/bMv32SgeM8mhPe4rUt+QyJTj4XKp/J6hWL7E5ZhWPCdVYsm7ZeiH2p5s3zlPkUYAtdvPCZ7BC6bjged21z9wgDN4NRrHWRnIErGlcw9b7rQfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432613; c=relaxed/simple;
	bh=2Y0CkT0ZOJcLy1VmFk2t5Kvbarzyzbh1KvpjNsVRibo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWh90a9WtZRuyPSTKvW17I1g8x1SkbBDUqY1rfMtTo6ZHUOkRrme1RTy6o3LLdBQVkKTkhquM9uWWlC6/Xcqdk0F0ViQDSYE4jiyQ0PDr+ovkSzXmuE2nOdKL9iCWO2M3dj4npI+9uHQGsC4yvhKErnxwa0Ac10teFocPDeX8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hDlavuOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A06C43390;
	Tue, 26 Mar 2024 05:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711432612;
	bh=2Y0CkT0ZOJcLy1VmFk2t5Kvbarzyzbh1KvpjNsVRibo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDlavuOzuQRTYIJzFPkOymgHHJ5OAVfylQgy0PXxgtmoJ/yK+EwoqtBpLZau4L3+j
	 VNiYq/tl9emSQIJWqbPeqUiq54qWhSCdXAxvA5iiI8pacPhTDcp2avl9zUg3aBo78r
	 /7mh5phMJXYhOzv5ZkeVGWzIWQvIieIuXqhG29IU=
Date: Tue, 26 Mar 2024 06:56:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
	oneukum@suse.com, Roy Luo <royluo@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: Disable USB3 LPM at shutdown
Message-ID: <2024032639-deny-boggle-276e@gregkh>
References: <20240305065140.66801-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305065140.66801-1-kai.heng.feng@canonical.com>

On Tue, Mar 05, 2024 at 02:51:38PM +0800, Kai-Heng Feng wrote:
> SanDisks USB3 storage may disapper after system reboot:
> 
> usb usb2-port3: link state change
> xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x2c0
> usb usb2-port3: do warm reset, port only
> xhci_hcd 0000:00:14.0: xhci_hub_status_data: stopping usb2 port polling
> xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2b0, return 0x2b0
> usb usb2-port3: not warm reset yet, waiting 50ms
> xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2f0, return 0x2f0
> usb usb2-port3: not warm reset yet, waiting 200ms
> ...
> xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x6802c0, return 0x7002c0
> usb usb2-port3: not warm reset yet, waiting 200ms
> xhci_hcd 0000:00:14.0: clear port3 reset change, portsc: 0x4802c0
> xhci_hcd 0000:00:14.0: clear port3 warm(BH) reset change, portsc: 0x4002c0
> xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x2c0
> xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2c0, return 0x2c0
> usb usb2-port3: not enabled, trying warm reset again...
> 
> This is due to the USB device still cause port change event after xHCI is
> shuted down:
> 
> xhci_hcd 0000:38:00.0: // Setting command ring address to 0xffffe001
> xhci_hcd 0000:38:00.0: xhci_resume: starting usb3 port polling.
> xhci_hcd 0000:38:00.0: xhci_hub_status_data: stopping usb4 port polling
> xhci_hcd 0000:38:00.0: xhci_hub_status_data: stopping usb3 port polling
> xhci_hcd 0000:38:00.0: hcd_pci_runtime_resume: 0
> xhci_hcd 0000:38:00.0: xhci_shutdown: stopping usb3 port polling.
> xhci_hcd 0000:38:00.0: // Halt the HC
> xhci_hcd 0000:38:00.0: xhci_shutdown completed - status = 1
> xhci_hcd 0000:00:14.0: xhci_shutdown: stopping usb1 port polling.
> xhci_hcd 0000:00:14.0: // Halt the HC
> xhci_hcd 0000:00:14.0: xhci_shutdown completed - status = 1
> xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x1203, return 0x203
> xhci_hcd 0000:00:14.0: set port reset, actual port 2-3 status  = 0x1311
> xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x201203, return 0x100203
> xhci_hcd 0000:00:14.0: clear port3 reset change, portsc: 0x1203
> xhci_hcd 0000:00:14.0: clear port3 warm(BH) reset change, portsc: 0x1203
> xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x1203
> xhci_hcd 0000:00:14.0: clear port3 connect change, portsc: 0x1203
> xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x1203, return 0x203
> usb 2-3: device not accepting address 2, error -108
> xhci_hcd 0000:00:14.0: xHCI dying or halted, can't queue_command
> xhci_hcd 0000:00:14.0: Set port 2-3 link state, portsc: 0x1203, write 0x11261
> xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x1263, return 0x263
> xhci_hcd 0000:00:14.0: set port reset, actual port 2-3 status  = 0x1271
> xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x12b1, return 0x2b1
> usb usb2-port3: not reset yet, waiting 60ms
> ACPI: PM: Preparing to enter system sleep state S5
> xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x12f1, return 0x2f1
> usb usb2-port3: not reset yet, waiting 200ms
> reboot: Restarting system
> 
> The port change event is caused by LPM transition, so disabling LPM at shutdown
> to make sure the device is in U0 for warmboot.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/usb/core/port.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

What commit id does this fix?

