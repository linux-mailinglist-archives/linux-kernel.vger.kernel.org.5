Return-Path: <linux-kernel+bounces-90739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E787044D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392CF1F26FD4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B13B482C6;
	Mon,  4 Mar 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Igjde9ZN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8FD481CD;
	Mon,  4 Mar 2024 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562948; cv=none; b=PR2Fb4Fr6oBVuQR27bq215jfbMn5kP/WeuDMBj6zNnz954G4O4q39yUobZCFYVykLwxkAb6rcPmxpJQgpdozlKiZFTeoHx2j3jypiP6cavL+0BA+gaLIkqa6cIAEv2At0xmg0udfPt3r6a5VMBNKoD3DshPlJ4YlLBjlsxn8Myk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562948; c=relaxed/simple;
	bh=q9f7jSXfpd9bEo6UkCv1LEyThgtNtItIMZvG8v/XxyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAACIyKmar0v610IM6QYiTt1+06qutbr8paidy5IjorPXPl8EDxvrKuSFKHAkbmelOGNYzCvidd/qPQKV4Ui7466XhmkeFFSsAkBXeUJNVHkMC1zjWaIy/dmjAWmGIeNy9jY+FDbIhKQv2gSK8bAuJU6jalv6JXLNuiRGMZ/hNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Igjde9ZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAFAC433F1;
	Mon,  4 Mar 2024 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709562947;
	bh=q9f7jSXfpd9bEo6UkCv1LEyThgtNtItIMZvG8v/XxyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Igjde9ZNKPtjRk1+omIGDhEgrS4a4lSnvVm69VeaEefz65x/Er0tW7LU5p18gAUvp
	 k4iYZNWyO9p3EfLjkO2FcTbto/ZlZPLbh1q5mkSo/z7ApTi2VlszMinw/0ADoter7x
	 TnF6JSMwoNZFJLAkOvctELk+1a4f3c4QXiE/o+9FBLEqDq5twdMEMmLuFK5qaOKLVt
	 ugf5Y/4vDBMgs+2plwRmO01C7QgqDUDPBv1p/K15nY+wEbHLVOfpGBpF0O5UnsWJGA
	 8c52lqpM4M2Tkfs2B/PZF8hGYrUSr5gPYuNaLKbLmB2KSiizNiQ2U67AA6oPDja+TP
	 hm/OxdSV3Zztw==
Date: Mon, 4 Mar 2024 08:35:46 -0600
From: Seth Forshee <sforshee@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>,
	sam sun <samsun1006219@gmail.com>
Subject: Re: [PATCH] 9p: cap xattr max size to XATTR_SIZE_MAX
Message-ID: <ZeXcQmHWcYvfCR93@do-x1extreme>
References: <20240304-xattr_maxsize-v1-1-322357ec6bdf@codewreck.org>
 <4091309.WcpKHNDlqE@silver>
 <20240304-zeitschrift-tagung-6f2a28e781bc@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-zeitschrift-tagung-6f2a28e781bc@brauner>

On Mon, Mar 04, 2024 at 03:19:58PM +0100, Christian Brauner wrote:
> On Mon, Mar 04, 2024 at 02:35:07PM +0100, Christian Schoenebeck wrote:
> > On Monday, March 4, 2024 1:42:43 PM CET Dominique Martinet wrote:
> > > We probably shouldn't ever get an xattr bigger than that, and the current check
> > > of SSIZE_MAX is a bit too large.
> > 
> > Maybe, OTOH e.g. ACLs (dynamic size) are implemented by storing them as xattrs
> > on 9p server as well, and this change somewhat expects server to run Linux as
> > well. So maybe s/XATTR_SIZE_MAX/KMALLOC_MAX_SIZE/ might be more appropriate,
> > considering that this patch is about fixing a potential kmalloc() warning?
> > 
> > Worth to mention in the commit log BTW what the issue was.
> > 
> > /Christian
> 
> So the error is somewhat specific to filesystem capabilities which also
> live in the xattr apis but Seth is working to get rid of them in there.
> 
> They currently use a special api vfs_getxattr_alloc() which is an
> in-kernel api that does a racy query-size+allocate-buffer+retrieve-data
> dance.

Yes, the patches I've sent does use vfs_getxattr_alloc() for fscaps
anymore.

> That api is used for fscaps, security labels, and other xattrs. And that
> api doesn't do any size checks which probably should also be fixed now
> that I write this.
> 
> @Seth?

I agree. I don't see any reason that vfs_getxattr_alloc() shouldn't just
bail out with an error if the size of the xattr is >= XATTR_SIZE_MAX.

