Return-Path: <linux-kernel+bounces-75186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C81885E468
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F360FB22E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E3B83A1C;
	Wed, 21 Feb 2024 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Wa0cQajd"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEBB81737
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535900; cv=none; b=ZqX6amxFGaX1QXj4U9jk10WnvMH4l8bBxaKMlEbQ3A6zeizfgpVXglSsgZYmROqVnbKezQ5vqwcUbHzpgdLVlwPI6J5eYeM2Lui5Wm46d89iMQsAUEB2R1aRyAFpYPHtaKBLpM7pUxLFgA8jBn5Qiy1z46e1BiJv8rfC0oLndRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535900; c=relaxed/simple;
	bh=YbOHfwnWQEH/uqhlwHn4KCf+jK984Zh3XKCPyzW+VDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zyq5R7a4S9zwnzvASN1+YgymoDvqaVsRa8yltwWgQCRey5lMUJWqr9thAbT3u7DC3hPEce863cfRNy7KbPKIqPnZLEhw0XLmJVQU1wVLr7PIS5HcwmQje0JxyHcq8Cl4XRlIOcM1WTU0CWFo5QcrQyn4E2LRDsXHRHgvK+KftlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Wa0cQajd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1708535887;
	bh=YbOHfwnWQEH/uqhlwHn4KCf+jK984Zh3XKCPyzW+VDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wa0cQajdcPBgwV+9xc7gP2N+5mAfqqEeC77Yh96WOG2kYWqsUQOPJQRxK/Cg6YBxo
	 hz3AfdXjvo5kSQTGDR8vTnPXaafN7zCeIbFGZ8xDwJDPON+i/7hXDa0E/6xF2/u4WN
	 zDHSZ6oNAivpBQqrB/ukWTE3uqREFodMD/GJzk5I=
Date: Wed, 21 Feb 2024 18:18:06 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>, Willy Tarreau <w@1wt.eu>, 
	Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH RFC] misc/pvpanic: add support for normal shutdowns
Message-ID: <a24494f9-2ef5-4f69-a756-88b3e942b5e8@t-8ch.de>
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

Hi Greg,

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

could you confirm that it's fine to keep this UAPI header file?

Thomas

