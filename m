Return-Path: <linux-kernel+bounces-84574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA95986A88A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645ED289273
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C3422EFD;
	Wed, 28 Feb 2024 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="oO6y+2W1"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC2A23746
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709102920; cv=none; b=aDV4URVs9j848Wjxoh2unYiHKbtn0nRzMMet1Su5In5G5f0kJENYPYUiKAH8EwzVhk72K/4coj88aBSQmh8w7X17ZP3TW5RCrhxCG1Xq42s6e5+X+5g78E4eeO8VrnCfVeQD2FdpBNcisZUkBZYqwtpy/VVJ9k8GbrpddsuWL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709102920; c=relaxed/simple;
	bh=eMeNeT19jqeiXFrZIuRqIqAr/reG8k2xmqZQT1Q5gKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9p1GeoZJei5/62yvLlkj6mqTMGUnYqZrFuUTwEQmWSuJiFapOYP53hyowSd/50oINEUcxkSxQLNj+l8+i2GzBLPYVvUDlEp+FOwvkKZm8XSizhlMZkijVGYOZWsdI/MNwugTcJZagAmEndKlQWPHmA8TN2azdUMoEGXPJ0Tfr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=oO6y+2W1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1709102908;
	bh=eMeNeT19jqeiXFrZIuRqIqAr/reG8k2xmqZQT1Q5gKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oO6y+2W1BaLc+y1z2JOt48eAa4IKT10yvHbjLpo0ryx1nXj5Gc+L7DAK3QdYK7D7d
	 RSj/gy/Y6V73ZqmyJqDvXojNwxvuG6qMpVNFrY+1+LbTCUrSBlYQqPpj26B1q26L6S
	 /qBNiiXMSRWFkGW9n/VDJIE44xo12Yn2TAegydbw=
Date: Wed, 28 Feb 2024 07:48:26 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	Zhangjin Wu <falcon@tinylab.org>, Willy Tarreau <w@1wt.eu>, Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH RFC] misc/pvpanic: add support for normal shutdowns
Message-ID: <ae7a35e9-16f6-4877-8075-a0fb9fe5bfff@t-8ch.de>
References: <20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net>
 <2023110407-unselect-uptight-b96d@gregkh>
 <20240213053953-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213053953-mutt-send-email-mst@kernel.org>

Hi Michael,

On 2024-02-13 05:41:48-0500, Michael S. Tsirkin wrote:
> On Sat, Nov 04, 2023 at 02:05:02PM +0100, Greg Kroah-Hartman wrote:
> > > diff --git a/include/uapi/misc/pvpanic.h b/include/uapi/misc/pvpanic.h
> > > index 54b7485390d3..82fc618bfbcf 100644
> > > --- a/include/uapi/misc/pvpanic.h
> > > +++ b/include/uapi/misc/pvpanic.h
> > > @@ -5,5 +5,6 @@
> > >  
> > >  #define PVPANIC_PANICKED	(1 << 0)
> > >  #define PVPANIC_CRASH_LOADED	(1 << 1)
> > > +#define PVPANIC_SHUTDOWN	(1 << 2)
> > 
> > Why are these in a uapi file?
> > 
> > And if they need to be here, why not use the proper BIT() macro for it?
> > 
> > thanks,
> > 
> > greg k-h
> 
> This is interface with hypervisor not userspace, but for PV historically
> we do this since the compatibility implications are about the same,
> hypervisors (e.g. QEMU) are mostly userspace and so it is convenient for
> them to reuse the same machinery to export the headers.
> 
> Let's stick to that, cleaner than duplicating everything I think.

as Greg seems to be busy with other stuff I'd like to go ahead with
submitting this again using the existing header file.
It seems unfortunate to block this work on the non-function detail of
the location if a header file which already exists and which we could
always change after the fact, too.

Do you have any recommendations in which parts and order to submit these
changes to the kernel and Qemu?

I need to touch the specification document in qemu, the header in the
kernel, the import of the header in qemu and drivers in both qemu and
the kernel.


Thomas

