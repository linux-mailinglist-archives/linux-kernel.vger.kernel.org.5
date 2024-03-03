Return-Path: <linux-kernel+bounces-89666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE62A86F3E2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 08:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D721D283CF9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 07:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4306F8F5D;
	Sun,  3 Mar 2024 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1r1CuVgL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3AF17F7
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 07:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709450906; cv=none; b=d0Lphn9TflxledAZMbXQCBaq32Uwtimy1qftaIdDNcKZEQJZdE/Iu/i2yt0Ujf+6f4Lw6A9djeDYF8CgnT7/dwgKY2IvEJoCR3atvXVgeM43p43mnuC32b7gqCQ0l5FMVTMbkVVZGqBvDhsonln7TigEKOCTlTDwrqOnK9gdNeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709450906; c=relaxed/simple;
	bh=fysfJa5zh9hCG1//vKgKPlZZ9LaSzsw47fSSVQhdVVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpgPaAaQtU3XCJKkkUglM4tgu/avdqI23foMVbgSlkN2cBmwK6jhp7eXnjaSbVkalQ/eQ1AW0YCeLT8kFskgkH6RqW5s5wnINVZKwIR6PvwvcUAlpW9OcwrjFS6kravu2ez4/zY0+vGRwdpeYPpmoY/ZSgX+DhFJkMuPgT2QSNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1r1CuVgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A2FC433C7;
	Sun,  3 Mar 2024 07:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709450906;
	bh=fysfJa5zh9hCG1//vKgKPlZZ9LaSzsw47fSSVQhdVVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1r1CuVgL7QBkr0gStG/9ujqDxkgufxKJfqV3hWagYic3ifm3WhMJk06TZSTo5qXeG
	 LrVhdojkUtgVpjkYChu5UjZRyhiUXfhVtZ4EwvP/6PSm9U3eJbMcitDpmQzR++TzB1
	 WTk8+o70/2QcSQnQrp1GO3tBc+XcWuWTDSzqL2PA=
Date: Sun, 3 Mar 2024 08:28:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>, cve@kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: CVE-2023-52466: PCI: Avoid potential out-of-bounds read in
 pci_dev_for_each_resource()
Message-ID: <2024030301-cornflake-unbounded-02cc@gregkh>
References: <2024022709-magazine-handshake-50da@gregkh>
 <20240227150744.GA235367@bhelgaas>
 <2024022706-kindle-tapering-5f66@gregkh>
 <nycvar.YFH.7.76.2402281011470.21798@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2402281011470.21798@cbobk.fhfr.pm>

On Wed, Feb 28, 2024 at 10:20:13AM +0100, Jiri Kosina wrote:
> On Tue, 27 Feb 2024, Greg Kroah-Hartman wrote:
> 
> > > 09cc90063240 ("PCI: Introduce pci_dev_for_each_resource()") added
> > > pci_dev_for_each_resource(), which expands to:
> > > 
> > >   for (...; res = (&(dev)->resource[(bar)]), bar < PCI_NUM_RESOURCES; ...)
> > > 
> > > We compute "res" before the bounds-check of "bar", so the pointer may
> > > be out-of-bounds, but the body of the pci_dev_for_each_resource() loop
> > > is never executed with that out-of-bounds value.
> > > 
> > > So I don't think this is a security issue, no matter how
> > > pci_dev_for_each_resource() is used, unless the mere presence of an
> > > invalid address in a register is an issue.
> > 
> > Ah, yeah, now I remember, stuff like this was fixed up in other loops as
> > just reading off into the wild can be a speculation issue and so we had
> > to fix up a bunch of places in the kernel where we did have "invalid
> > data" in a register.  The code didn't use that, but the processor would
> > fetch from there, and boom, speculation mess.  There's a whole research
> > paper published on this type of thing somewhere...
> 
> Greg, could you please elaborate on this?
> 
> Where in this whole construct do you see a potential for *_uncached_* (!) 
> memory access that'd cause CPU to speculate into the wild? I just don't 
> see it.

Ok, finally got the time to look at this, and you are right, and I was
right (in a different way), but you are right more :)

What the change does is hopefully NOT allow the extra resource[bar]
read to happen (that is IFF the && change always comes first, but
processors do not guarantee it).  But if/when that additional
read-off-the-end-of-the-array happens, before the check, we are reading
ONLY a chunk of memory that we already allocated, it's the middle of the
pci device structure itself.

So the uncached read can still happen, but the read is of a location
that we still allow to be read (i.e. the next field in the structure).

So the "read off the end of the array" can still happen with this
change, that didn't really get fixed, but the read is "safe" as it's a
memory chunk we control.  All this change did is make the static checker
happier, and on cpus without a lot of speculation, not do the read where
it shouldn't have, but on modern cpus, nothing really changed at all.

I'll go mark this CVE rejected now, thanks all for the reviews!

greg k-h

