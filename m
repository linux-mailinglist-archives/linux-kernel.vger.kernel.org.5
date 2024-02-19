Return-Path: <linux-kernel+bounces-70911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1EC859DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0C31C21B40
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208ED20DFD;
	Mon, 19 Feb 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jhfZg1UW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A52135C;
	Mon, 19 Feb 2024 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330387; cv=none; b=ZVO0Vh8ACLTsOSgcqDsgtRDIo21pK060sDfQdLksZ4IemqS/sGxhSn9fKIoemeNKDXIejnT2Av/lScyHL1bcvk/Q0WN3+eIwk+iRvT+5mz1jjycr14nzL7eRRp51kfs1y2FZH15D5UjwVSH1OsJAKHVNa+clIk2ETsK0BxHF8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330387; c=relaxed/simple;
	bh=1w3J45VRLDLeMHSNQ1LNWwVGXu9vFKXbgM2hR+lw2cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+6q6uEs7CqInmV+xi6GVVX0wCB/k8RDgzZiq51uTI9J1XDXbsH4i+HxFvY8sAI3pcSdTMuTcrQc/2Qg1vrefjzRBOj6FZFXrNgVOTTVSHjgsyAAo4oWoCjSXIhbPcLiS1KKXOkL8e71Jnm/W0tKWj87ab+syIO/l9zFKH0ZSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jhfZg1UW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59439C433C7;
	Mon, 19 Feb 2024 08:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708330386;
	bh=1w3J45VRLDLeMHSNQ1LNWwVGXu9vFKXbgM2hR+lw2cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhfZg1UWk/gIXkIAdbPlphVgddgqd1ksAhGXvha+wO8pNKb1DMovmkeVam5cOXg4V
	 ZjobisTZkClepNOBnY4pK1TvUg5MRJ46gK7Jb8S9Dh+4mNUj2diDLWUzWREqyw4PD8
	 PzqZuInLMj6WOi48A3lXFEc8a0b7BDAuxcmKG4ao=
Date: Mon, 19 Feb 2024 09:13:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/4] usb: gadget: legacy: add 9pfs multi gadget
Message-ID: <2024021911-facelift-graveyard-0760@gregkh>
References: <20240116-ml-topic-u9p-v2-0-b46cbf592962@pengutronix.de>
 <20240116-ml-topic-u9p-v2-3-b46cbf592962@pengutronix.de>
 <2024021757-geography-hacksaw-3022@gregkh>
 <ZdKze80oFj0PRkkZ@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdKze80oFj0PRkkZ@pengutronix.de>

On Mon, Feb 19, 2024 at 02:48:43AM +0100, Michael Grzeschik wrote:
> On Sat, Feb 17, 2024 at 04:59:28PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Feb 02, 2024 at 01:05:12AM +0100, Michael Grzeschik wrote:
> > > Add the newly introduced 9pfs transport gadget interface with an new
> > > multi composed gadget together with acm and eem.
> > > 
> > > When using this legacy module, it is also possible to
> > > mount the 9PFS usb dir as root filesystem. Just follow the
> > > instrucitons from Documentation/filesystems/9p.rst
> > 
> > Why are we adding new "legacy" gadgets?  What's wrong with the "correct"
> > api instead?  You need a lot of justification here to add something to
> > an api we want to one day just delete.
> 
> Without the legacy gadget there is no real solution to mount
> the 9pfs via the gadget as rootfs. The "correct" api is configfs
> which will need the user to have some filesystem to mount it to.

That's what your initramfs is for.  Why can't you just use that?

> There is the relatively new concept of bootconfig which sounds
> promising to describe an complete configfs tree from system boot.

Great, but until that happens, again, just use initramfs.

> However this is some future talk for now, so we would like to
> stick with the legacy setup to be able to mount the 9pfs rootfs.

I'd prefer to NOT add new legacy gadget drivers, and do everything
possible to delete them all from the tree "soon".

> > > +/*
> > > + * Gadget usb9pfs only needs two bulk endpoints, and will use the usb9pfs usb
> > > + * transport to mount host filesystem via usb gadget. This driver will
> > > + * also add one ACM and NCM interface.
> > 
> > Why "also"?  What are those interfaces going to be used for and what do
> > they have to do with 9pfs?
> 
> They are not necessary to be used with 9pfs. But since we introduce an
> new legacy module which is fully claiming the UDC, it would make sense
> to leave the other endpoints unavailable but instead add some common
> interfaces like ecm and acm.

But if no one needs/wants them, why make this complex?  Again, configfs
can handle the composition of this if you need it, which is why that
"new" interface was created.

thanks,

greg k-h

