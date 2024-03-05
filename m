Return-Path: <linux-kernel+bounces-91605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0361D87142E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5CB1F23301
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0F3717D;
	Tue,  5 Mar 2024 03:19:28 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id DD9772942C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709608767; cv=none; b=Bji8KT/nDXTTMCmZfI/VsXjVm5qfiuCYPCO8ms3WobCRVfBVAmHz6SGX17EGoIo3ZmD1mjX8xINgHBGQMRH2r9JSMlaA2i02w+SsM+b4ycri3JE3uA/r6EExt/UEzdbi/8TptRZFZU3J12UmhN3nFrpl4gWA1Ogxdf7kI5HvS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709608767; c=relaxed/simple;
	bh=Ck4ZctKVOXdlbvUJ8DoMXK80YN5zrcPcWCl0t3M5bwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZTsvF+M+AtVQDCF8OToNV1/tVhsFMtDb0Dm03559sNQUUPvYE/3ocNV0da0yJMbNW+F+nusJ7nQHNG3PXE+6xuw4X2vTrsMxvyOoklLUQSBmIkcIrHKnSkKUKpy9CqjZDtqQHrA886jiWGi4hZlLp2N19xX6WDZdf3KzzlBL+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 143883 invoked by uid 1000); 4 Mar 2024 22:19:24 -0500
Date: Mon, 4 Mar 2024 22:19:24 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
  Demi Marie Obenour <demi@invisiblethingslab.com>, linux-usb@vger.kernel.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usbip doesn't work with userspace code that accesses USB devices
Message-ID: <a95c7e71-a720-49ba-b503-6f20a86be38e@rowland.harvard.edu>
References: <ZeYov0k8njwcZzGX@itl-email>
 <2024030406-kilogram-raving-33c5@gregkh>
 <ZeZPLX6z5pyn2Eh_@mail-itl>
 <ZeZetkR-i1bCDr9v@mail-itl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeZetkR-i1bCDr9v@mail-itl>

On Tue, Mar 05, 2024 at 12:52:22AM +0100, Marek Marczykowski-Górecki wrote:
> On Mon, Mar 04, 2024 at 11:46:04PM +0100, Marek Marczykowski-Górecki wrote:
> > Terminology:
> > 1. sys-usb - a VM where USB controller (a PCI device) lives; here
> > usbip-host is attached to the device
> > 2. testvm - target VM where usbip is connected; here vhci-hcd is used
> > 3. qvm-usb - tool that connects the above two (equivalent of
> > userspace part of standard usbip)
> > 
> > Specific steps:
> > 1. Connect android phone - at this point it's only in sys-usb
> > 2. Switch its mode to file transfer - observe reconnect in sys-usb
> > 3. Use qvm-usb to attach it to the testvm
> > 4. Call jmtpfs -d /mnt in testvm
> 
> Or maybe reset or something is involved here too?
> 
> After using qvm-usb to attach _and detach_ the device, it stays bound to
> usbip-host driver (that's intentional). But then, even after re-binding
> back to the "usb" driver, jmtpfs called in sys-usb directly fails the
> same way, including failure to reset.
> 
> In fact, even without usbip involved at all, jmtpfs directly in sys-usb
> works only once. The second attempt (without either physically reconnecting
> the phone, or changing its more to "no data transfer" and back to "file
> transfer") fails the same way. After terminating the first instance, I
> see just this logged:
> 
>     [921332.525210] usb 2-1: reset high-speed USB device number 22 using xhci_hcd

If something doesn't work when usbip isn't involved, you definitely 
shouldn't expect it to work when usbip _is_ involved.

It sounds like you're facing more than one type of problem.  The best 
approach is to attack them separately.

I'd start with problems that exist only on sys-usb first -- keeping 
usbip out of the picture will make everything much simpler.  You can try 
capturing a usbmon trace, starting from before the phone is attached, 
and continuing on through the mode changes and failures.  In fact, break 
it up into several traces, each starting just before one of the major 
events (initial plug-in, mode change, whatever).

Once that's under control, I suggest using usbmon on both sides (sys-usb 
and testvm) of the usbip connection.  But start without usbip.

Alan Stern

