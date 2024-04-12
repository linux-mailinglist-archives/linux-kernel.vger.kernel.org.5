Return-Path: <linux-kernel+bounces-141931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268C68A2536
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19D01F2220F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B8EB67A;
	Fri, 12 Apr 2024 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jEpiXcgP"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82D48495
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896628; cv=none; b=pk3a3LX5V0ogbiQclDmKc4Vc2IwP1+cptg2k8UA1EnCtYNuHZOILE1UDfTb7N6y6hEnoNAudagARRTQ6JRQgZ2nLaBJaOKPn8TG4XbeYKBmq1tNy5+N1Z3VPgzFJ8niDbeyyVO/uHnq80I7zFp1OTjEJZGbWPgZGxDNtCdNILqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896628; c=relaxed/simple;
	bh=28aDDdp4ZyVVvWYbXK2FC+8iawxiTHZ063zYakO+3EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr1XPWxURkBEwSRIXGlbBo/+aswkD8LFG6e7YAqhaJIkDPxHXo4ld3JxFvWMu+SLulYoilSSYbU8ehbPTq8va/Ak4humjfiCwjViXTpV30SRTGe6p4ck7rA5qr6+wVdN7wRLubso/xnMRXWrEp/4W6dzgPcx2gIOv56XXEl+wu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jEpiXcgP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=50wyF2KZKqdNatgKipHckXSKuZ2uXv5c12WMdeC0bh0=; b=jEpiXcgPTURTFA8JtoW4yWst3Q
	HXL1KZ/PPpI18YmHGFKGJjpC1r3mSlqLQAPitU/dvk4EPnbU3On5qtFuTAnCQ42dz6nbf8aaz150i
	NGCrLBiINgnRUgBWdwaoZTp+6xasLwefNy5967Ilc8xz3hB7ruCqcxJe6QSp985tOtHDO67X+rcZL
	Dx+DVHHeF95qtVdtqArOTFTTlvJDiiXhf5HaitDPp90yLgeSHEfytN3svh+BERPVTA8Fa9zJ+rt7U
	L6RUQmeMeIT8M+tUzEapKivsGntL1RsOhH2d5ZipR+Q9CP0CHvoNYVFhGDGbKFWiZ9b9XOLoovSGY
	4/xfCrqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rv8et-00AwC2-1r;
	Fri, 12 Apr 2024 04:37:03 +0000
Date: Fri, 12 Apr 2024 05:37:03 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET RFC 0/437] Kill off old fops ->read() and ->write()
Message-ID: <20240412043703.GA2606434@ZenIV>
References: <20240411153126.16201-1-axboe@kernel.dk>
 <20240412042910.GK2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412042910.GK2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 12, 2024 at 05:29:10AM +0100, Al Viro wrote:
> On Thu, Apr 11, 2024 at 09:12:20AM -0600, Jens Axboe wrote:
> > Hi,
> > 
> > This patchset will obviously be split, commit messages updated, and
> > specific driver patches targeted to where they belong. But I figured
> > it'd be useful to blast out the full set at least once for reference,
> > and then I'll continue down the right path for the next one.
> > 
> > Subject line says it all, really. 10 years ago we added ->read_iter()
> > and ->write_iter() to struct file_operations. These are great, as they
> > pass in an iov_iter rather than a user buffer + length, and they also
> > take a struct kiocb rather than just a file. Since then we've had two
> > paths for any read or write - one legacy one that can't do per-IO hints
> > like "This read should be non-blocking", they strictly only work with
> > O_NONBLOCK on the file, and a newer one that supports everything the
> > old path does and a bunch more. We've had a few issues with the
> > iov_iter based path being slower, but those have basically been
> > resolved with solutions like ITER_UBUF to optimize the single segment
> > case that is often the fast path.
> > 
> > There are basically three parts to this series:
> > 
> > 1) Add generic helpers that we need to convert drivers.
> > 2) Convert any use of fops->read() and ->write()
> > 3) Kill off old cruft.
> > 3a) Profit.
> 
> The fundamental problem with that is that a bunch of drivers
> do care about the vector boundaries.  Very much so.  It's very
> common to have this kind of situation:
> 	write() parses the buffer sloppily, and ignores the junk in
> the end, claiming that everything that been written.
> 	writev() feeds each vector to write().
> 
> From a cursory look through that pile, you seem to have broken
> writev() on at least some (if not all) of those.

OK, it's 'some', not 'all', but AFAICS you'd been far too
optimistic about the number of instances that do not need
your vfs_write_iter() wrappers...

