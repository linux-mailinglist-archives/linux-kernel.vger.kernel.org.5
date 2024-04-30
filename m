Return-Path: <linux-kernel+bounces-163449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554F18B6B20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A5D1F2286F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278A33771E;
	Tue, 30 Apr 2024 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVRe1e4p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CB825761
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460950; cv=none; b=fDnLmIGpngK2hSFcz3TdtH4MU79GvY7xSEkVFZUv/kcdNLGdLs9aWh7Wda0M7VmIH2D33QJa8QagD/3tQt7f5ZVEPkTtGD0LZKPo/0A33bkJ0Gc7DjF1cmfJlOxnWi3ayt0VZtTZ9zBB9+6/nOKI76l/Zm/Gsb6HHB/TeFZbSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460950; c=relaxed/simple;
	bh=THBI/Mv0ANMSgn3FeDWMCU6iIIp+Fw8eEXoIRzePTWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5z5gdm+MJCUtSq52iVsip8/N/yRfwu/UzyT+MZnTExoUMzt/+8hNlLKLhwRXg3YZc53DxZUkOGcXBmu+kHlZ8Ba8JR9PAPoaLgPpL/4HHN5R4q9v1IDaLvg1Sa8yZ34GinH0ra8RNeOQcW2S8o+AH2B6/+c9Mzy342euUqMxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NVRe1e4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F45C2BBFC;
	Tue, 30 Apr 2024 07:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714460949;
	bh=THBI/Mv0ANMSgn3FeDWMCU6iIIp+Fw8eEXoIRzePTWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVRe1e4pYMpIipsgB7DuKi1mt7YuO26E1IYMNSkWXsoX9fMuv3fDMO9rFm9EjF9uJ
	 8JK+EIPZHOGnhMSta0E+f0pK2Og5fk0+ThLUdeMEOsdRQDq1Xl0ScLwm0SJPXK6T3V
	 kDbjvtFrtowwNTnSk0goF+abIDUKOWHApLZoEpLQ=
Date: Tue, 30 Apr 2024 09:09:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Ahern <dsahern@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <2024043046-morbidly-marbling-fe0d@gregkh>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com>
 <20240304160237.GA2909161@nvidia.com>
 <2d6b0455-4d82-4bed-93f1-40255641548e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d6b0455-4d82-4bed-93f1-40255641548e@kernel.org>

On Mon, Apr 29, 2024 at 07:36:41PM -0600, David Ahern wrote:
> On 3/4/24 9:02 AM, Jason Gunthorpe wrote:
> > On Wed, Feb 14, 2024 at 01:57:35PM -0400, Jason Gunthorpe wrote:
> > 
> >> I also like this, I don't want the outcome of this discussion to be
> >> that only mlx5ctl gets merged. I want all the HW that has this problem
> >> to have support in the mainline kernel.
> > 
> > To this end here is my proposal to move forward with a new
> > mini-subsystem to provide rules for this common approach. Get the
> > existing tools out of hacky unstructured direct hardware access via
> > /sys/XX and into a formalized lockdown compatible system. I've talked
> > to enough people now to think we have a critical mass.
> > 
> > ===============
> > fwctl subsystem
> > ===============
> 
> 
> The aux bus infrastructure was created specifically for multifunction
> devices -- it allows a core PCI device driver with smaller, subsystem
> focused drivers for vendor specific implementations of various S/W stack
> APIs (IB, netdev, etc). One aspect not addressed in that design is where
> to park the various drivers and extensions that are not solely tied to
> any one subsystem.
> 
> Given, that how about moving the existing auxbus code into a new
> directory, drivers/auxbus. From there, create a subdirectory for this
> new fwctl subsystem which is most likely to be realized as a new auxbus
> device and then subdirectories for vendor specific drivers for the aux
> bus device. Then new drivers being developed in this auxbus world can
> put the core PCI device handling code under drivers/auxbus/core.
> 
> In short:
> - drivers/auxbus/auxiliary.c

Ah, the ever-frequent "where do we put the files" discussion :)

Is it "per bus" or "per functionality"?  In the end, it's a bit of both,
HOWEVER, no, auxiliary.c belongs in drivers/base/ for now, why move it?

And really, stuff on the auxbus has nothing to do with the auxbus, it
has everything to do with with the common device that auxbus really is
emulating (i.e. a pci device with multi-functions, or whatever.)

> - drivers/auxbus/core/<vendor>/  - per h/w device driver for managing
> the PCI device which is shared across multiple auxbus devices

Why "vendor"?  What happens when vendor names change?  :)

> - drivers/auxbus/fwctl/fwctl.c   - this FW interface

fwctl has nothing to do with auxbus other than it might be a user of it,
right?  So again, no need for it to be under auxbus/ as that is not
needed.

> - drivers/auxbus/fwctl/<vendor>/ - vendor specific driver for a fwctl
> auxbus device


if you want drivers/fwctl/<VENDOR>/ if <VENDOR> numbers get huge, sure
make subdirs, but really, why create a subdir like that if you don't
need it?

Start simple please, you can always move files later if it gets too
complex.  I think that discussing where to place non-existant files at
this point in time is kind of funny, given we have yet to see any actual
code...

thanks,

greg k-h

