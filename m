Return-Path: <linux-kernel+bounces-59375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE83484F60D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE171C213C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557493BB55;
	Fri,  9 Feb 2024 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ocXzfvxL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF737700;
	Fri,  9 Feb 2024 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485661; cv=none; b=CmpkKyY8tp9NTtU8kfPCUXlX7LK89v/7U5RrGcvCXg3WIyOkM+DnrxsXDmLzYWW7R6+eCRADTjsq7Nmx/fyq8ObVfrrxGAXCn+rlUv6C4eaZWcj1OKX/LWYh2EpYAH3S6eQWaQMMjjfLIgxZVStBz5SdIAhPnqZq2Qr/8i873zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485661; c=relaxed/simple;
	bh=M8z63cOFXZYPxqtw6vNUVaneKTcxkItbWEwJHaqQhjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+wfPG+wLJhuH39H2YPqAM3nysqbibiOEI1dlBaau9Atz8P91q73UHSpjnHHLC192ykSVnJzyfJ3OoFBxsp017rx+F6J1QZwBrIBmMm+OmVcBvtqTqxMc6iAkGpgDyp1u9dHfaMruaRzRVGT2KEleCtV4h6PZRpmUONHwNMukEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ocXzfvxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B92AC43394;
	Fri,  9 Feb 2024 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707485659;
	bh=M8z63cOFXZYPxqtw6vNUVaneKTcxkItbWEwJHaqQhjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocXzfvxLB49LlLRgHEkKS+h/E3fEnum+P6FVTCAjPCCXVLRQD2NgdHPBmI7UFnAQm
	 vTuvIYpMgN7c9L0p80fFTwS+lTDqTIIP+AU4jUsYz8kHVZ+o+4jndS3qc+VIdFjbnJ
	 uMxefVEJRUYS1c5QhxBufF44EbWglEzFEIHOTFec=
Date: Fri, 9 Feb 2024 13:34:17 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Niko Mauno <niko.mauno@vaisala.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	vesa.jaaskelainen@vaisala.com, geert@linux-m68k.org
Subject: Re: [PATCH v3 1/2] usb: core: Amend initial authorized_default value
Message-ID: <2024020911-utilize-etching-595a@gregkh>
References: <20240209094651.5379-1-niko.mauno@vaisala.com>
 <2024020903-october-placidly-20cc@gregkh>
 <65582610-72ba-4644-9032-91c09f50a6bf@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65582610-72ba-4644-9032-91c09f50a6bf@vaisala.com>

On Fri, Feb 09, 2024 at 02:39:01PM +0200, Niko Mauno wrote:
> On 9.2.2024 12.47, Greg KH wrote:
> > On Fri, Feb 09, 2024 at 11:46:50AM +0200, niko.mauno@vaisala.com wrote:
> > > From: Niko Mauno <niko.mauno@vaisala.com>
> > > 
> > > Since the wireless USB implementation has been removed and since the
> > > behavior with authorized_default values -1 and 1 is now effectively
> > > same, change the initial value to latter in order to stop using the
> > > leftover value. The former value can still be passed as a module
> > > parameter to retain backwards compatibility.
> > > 
> > > Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
> > > ---
> > >   drivers/usb/core/hcd.c | 6 ++----
> > >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > Isn't this series already in my tree?
> > 
> > confused,
> > 
> > greg k-h
> 
> Hi Greg, apologies for any confusion I may have caused,
> 
> Geert requested some further clarification in the new Kconfig help section,
> please see:
> https://marc.info/?l=linux-usb&m=170747246528305&w=2

Great, but I can't take patches that are already in my tree, right?

Please submit a new one on top of what I currently have.

> (There shouldn't be any functional change introduced between v2 and v3)

That always needs to be listed, as my bot says, otherwise we have no
idea what is going on here.  Remember, some of us get 1000+ emails a day
to do something with (review, apply, delete, ignore...)

thanks,

greg k-h

