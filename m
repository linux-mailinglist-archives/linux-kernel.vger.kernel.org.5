Return-Path: <linux-kernel+bounces-91271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB01870C21
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246AD283E31
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE68B1C6AD;
	Mon,  4 Mar 2024 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eYSJJvCH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B17C79F2;
	Mon,  4 Mar 2024 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586365; cv=none; b=L9AfWNTUD0fEn/7GKUuq+gUU9wk7F4iapvTgUfPHEcxD+ihtNGwdXtVIWeDHJAPle7tBRaW7spZOv/45U3m+H4ZMPa2sUPd/DGp+EnnlvMexZzEb3VjC2cr9vbHfInG4CMWzkT3YoQNUuHVNDxl5lRPlRHGHgfjJcTsCaAtkv9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586365; c=relaxed/simple;
	bh=zS+gYeruCtodKk4pXApqYKYDJKfbyvisos470S6jSc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTF8oRMd0gL74uaGo5zhqhlCO27IiVs9leK3Iu4Hfhn7f7tImGqJjnr4g9K9Uz/V3NOBsUS7/BAjvJVjigZ0vq0QhsexWfHtvI/cSwRF9ckZXktz47VN/wC1CFcj9GIYsdTS6uWEA0i5b53aZ/lBuEALBrMTkwVekX/C9VaLa9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eYSJJvCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E217C433C7;
	Mon,  4 Mar 2024 21:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709586364;
	bh=zS+gYeruCtodKk4pXApqYKYDJKfbyvisos470S6jSc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYSJJvCHU2Ce1pT7JMGMPVWZ5AayXlllUFHdmhN5pBdwQSWydWkjJA4saC/SqbchX
	 Uq881zqu82nV2wjU3fgdGfX5m3BSA6PiBEFW6y8zwrUYG/vGweSLFPf558QCDNdvIU
	 Ia1KKwjDhaZtjL0flvDBS4ceyT2xYupfTZ8E+8Ek=
Date: Mon, 4 Mar 2024 21:04:00 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: linux-usb@vger.kernel.org,
	Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usbip doesn't work with userspace code that accesses USB devices
Message-ID: <2024030406-kilogram-raving-33c5@gregkh>
References: <ZeYov0k8njwcZzGX@itl-email>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeYov0k8njwcZzGX@itl-email>

On Mon, Mar 04, 2024 at 03:01:51PM -0500, Demi Marie Obenour wrote:
> Qubes OS users are reporting that MTP doesn't work with USB passthrough.
> Fastboot (used for flashing a custom OS to an Android device) also
> doesn't work.  Kernel-mode drivers, such as Bluetooth and USB storage,
> seem to usually work as expected.  Since MTP and fastboot are both
> implemented in userspace, it appears that there is some problem with the
> interaction of usbip, our USB proxy (which is based on USBIP), and
> userspace programs that interact with USB devices directly.
> 
> The bug report can be found at [1] and the source code for the USB proxy
> can be found at [2].  The script used on the sending side (the one with
> the physical USB controller) is at [3] and the script used by the
> receiving side (the one the device is attached to) is at [4].  All of
> these links are for the current version as of this email being sent, so
> that anyone looking at this email in the future doesn't get confused.
> 
> Is this a bug in usbip, or is this due to usbip being used incorrectly?

I'm amazed that usbip works with usbfs at all, I didn't think that was a
thing.

If you have a reproducer, or some error messages somewhere, that might
be the easiest way forward.  In reading the bug report, it looks like
the "bridge" you all made can't handle the device disconnecting itself
properly?  But that's just a guess, could be anything.

thanks,

greg k-h

