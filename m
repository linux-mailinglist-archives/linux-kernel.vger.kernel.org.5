Return-Path: <linux-kernel+bounces-157803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0B8B1670
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A418E1F2449E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8B016E89C;
	Wed, 24 Apr 2024 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sfZB61Ro"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ED9155A50;
	Wed, 24 Apr 2024 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998999; cv=none; b=RaDsT3dVju0k/QvDF8NunMxkH5/s2cUp7wcqqymr6b9Q3jmAzcfvk15wHY9V/wfwq7TII5IEBXt0Aro1rThtRCGtJxGpEefU3WVuhlc0sjM5OrtwdUstTzs9BGgHQYnk6tjebp+djYrOvLW8p+5LgEUNLOpuNkCO8RU6guTRURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998999; c=relaxed/simple;
	bh=W5ohCgmJVkWl9zcBgvtQXRpF+AE5gPvRcpMsUWtmR7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIYJYVYlVlG9sDLddv2Hu6KJgBUJqYg51Y1wLXpT8vu0KB4R2ogoCE1nGcV4dB4yiQ+X4mICll1J3yuc5SCQzNi75u3vHtJiu6xql9KWXqhd1vnjbTo69zNSng1nwY/fyjmCdFUaGrc2g4m0h0y5F45pb4OiTD/+cKDmm/2OzMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sfZB61Ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AF7C113CD;
	Wed, 24 Apr 2024 22:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713998999;
	bh=W5ohCgmJVkWl9zcBgvtQXRpF+AE5gPvRcpMsUWtmR7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfZB61Roxjh0IGI0V5/i3GHMVS3OWunHEtCGm0eysMyJFZM6TmsoGFOsfhNz07w/h
	 w12XAhbav5hrlL+K4dP8/Oybe+REP64j8slv+ECTjpE4hgaoI9g0vtRVBHZ7M3+bX1
	 DI8SIUFdi8LXrT5/p6AGCvnTTfugR+k2B1ZsMftU=
Date: Wed, 24 Apr 2024 15:49:50 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2] usb: ohci: Prevent missed ohci interrupts
Message-ID: <2024042441-salutary-finishing-f54d@gregkh>
References: <20240424195951.3749388-1-linux@roeck-us.net>
 <0a29cc85-a79e-476d-aae6-0a054aad2e90@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a29cc85-a79e-476d-aae6-0a054aad2e90@rowland.harvard.edu>

On Wed, Apr 24, 2024 at 06:30:06PM -0400, Alan Stern wrote:
> On Wed, Apr 24, 2024 at 12:59:51PM -0700, Guenter Roeck wrote:
> > Testing ohci functionality with qemu's pci-ohci emulation often results
> > in ohci interface stalls, resulting in hung task timeouts.
> > 
> > The problem is caused by lost interrupts between the emulation and the
> > Linux kernel code. Additional interrupts raised while the ohci interrupt
> > handler in Linux is running and before the handler clears the interrupt
> > status are not handled. The fix for a similar problem in ehci suggests
> > that the problem is likely caused by edge-triggered MSI interrupts. See
> > commit 0b60557230ad ("usb: ehci: Prevent missed ehci interrupts with
> > edge-triggered MSI") for details.
> > 
> > Ensure that the ohci interrupt code handles all pending interrupts before
> > returning to solve the problem.
> > 
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2: Only repeat if the interface is still active
> 
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Greg might insist that the patch be CC'ed to stable@vger.kernel.org since 
> it contains a Fixes: tag.

I'll add that by hand, no worries.

