Return-Path: <linux-kernel+bounces-148846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA18A8809
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6BC28374A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D84A147C9F;
	Wed, 17 Apr 2024 15:48:28 +0000 (UTC)
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BAD38DEC;
	Wed, 17 Apr 2024 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368907; cv=none; b=G5XFV0OVeBTtbmxIYpJ6eYOvuABS5Wa+P0RjL6Mpx1aXr9CCPNXCtqbOPD3QoRYQ9BkVsbzsqMyArifiJhjs0w1cMNxu9H5r8iQ4TvzuKfN6a7Sytdx+rTYK1xl2WInwNhKVyh6lo9JWBN/mgxhvlmKN17Y7bxGS2iX6Iu9qWTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368907; c=relaxed/simple;
	bh=92v5/pg8GFq/gzI9N8CziVTy0FY0vvgtjcbkTtj6bAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQedUD9EpPdrpYTqDpFpG7Ct4QzwEF0TsngAbHyadTWx5H6i8zVTL617F8ANG7yR9Vor/jCqeZ+XILkN7OYcRXvzstHACSIOXIcUKluu0KfIxf81GRfNKjP1Yb1E6MdlWLREYPNZy8SNK1ZlP6punQYx73eL+ue7WC2+nXvRakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id DCB8EE803C0;
	Wed, 17 Apr 2024 17:48:16 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 92B311602F7; Wed, 17 Apr 2024 17:48:16 +0200 (CEST)
Date: Wed, 17 Apr 2024 17:48:16 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: API break, sysfs "capability" file
Message-ID: <Zh_vQG9EyVt34p16@gardel-login>
References: <ZhQJf8mzq_wipkBH@gardel-login>
 <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
 <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
 <ZhRSVSmNmb_IjCCH@gardel-login>
 <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
 <ZhT5_fZ9SrM0053p@gardel-login>
 <20240409141531.GB21514@lst.de>
 <Zh6J75OrcMY3dAjY@gardel-login>
 <Zh6O5zTBs5JtV4D2@kbusch-mbp>
 <20240417151350.GB2167@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417151350.GB2167@lst.de>

On Mi, 17.04.24 17:13, Christoph Hellwig (hch@lst.de) wrote:

> On Tue, Apr 16, 2024 at 08:44:55AM -0600, Keith Busch wrote:
> > The patch that introduced this was submitted not because the API was
> > stable; it was committed to encourage developers to update it as it
> > changed because it is *not* stable. That's not the kind of interface you
> > want exported for users to rely on, but no one should have to search
> > commit logs to understand why the doc exists, so I think exporting it
> > was just a mistake on the kernel side. To say this doc is "good"
> > misunderstands what it was trying to accomplish, and what it ultimately
> > created instead: technical debt.
>
> Yes.  It might be a problem with the documentation generation mess,
> but something that is generated from a random code comment really
> can't be an API document.
>
> Anyway, instead of bickering about this, what does systemd actually
> want to known?  Because all these flags we talked about did slightly
> different things all vaguely related to partition scanning.
> We also have another GD_SUPPRESS_PART_SCAN bit that is used to
> temporarily suppress partition scanning (and ublk now also abuses
> it in really whacky way, sigh).  I'm not really sure why userspace
> would even care about any of this, but I'm open to come up with
> something sane if we can actually define the semantics.

systemd works a lot with partitioned GPT disk images, and many of our
tools you can point to such images, either by referencing a file or by
referencing a block device. We generally handle that
transparently. Typically we then look at the GPT partition table from
userspace, and then do something with the associated partition block
devices (i.e. mount them or so). But those will only be synthesized by
the kernel if we are operating on a block device with partition
scanning on. Since kernel part scanning is async if a partition block
device doesn#t exist yet could have two reasons: part scanning is off
for the device, or the part table is still read and processed by the
kernel. By being able to read the part scan flag off the block device
we know which case it is, and can avoid a potential time-out.

If we are operating on a regular file or on a block device with
partition scanning off, we first have to generate an intermediary
loopback block device off it, whith scanning on.

Hence it's very useful to be able to determine if we a block device
already supports partition scans, simply so that we can do all this
entirely generically: you give us anything and we can handle it.

Block devices with part scanning off are quite common after all,
i.e. "losetup" creates them by default like that, and partition block
devices themselves have no part scanning on and so on, hence we have
to be ablet to operate sanely with them.

Lennart

--
Lennart Poettering, Berlin

