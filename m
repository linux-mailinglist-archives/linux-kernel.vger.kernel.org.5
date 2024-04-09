Return-Path: <linux-kernel+bounces-136444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DFB89D420
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D7BB22ECA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842167E78E;
	Tue,  9 Apr 2024 08:19:16 +0000 (UTC)
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CD612880F;
	Tue,  9 Apr 2024 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650756; cv=none; b=rwgMuRtH2/o0G4KKAra/kYgwDG8XPDQtUZZVGul+Qj3pq5soSq+6gBFdUrtRq+JFExdxPFqtKHbQZcQQ+uxU57MWKvd44+c8g/1trxbgILTXyWYzxtxWrGNu6wxZ0Hqe2x42hLSiaaEuEVeplwrFIbmuzT2/sXMcpbWIsKO0iGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650756; c=relaxed/simple;
	bh=VJyWzBnYyefyTtjqbrovv8c/SufEzmjLtuCvSB1LCCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dy6KiOsD3DavSKG0Nfikb17Rw6eeUQmv1PB6uf7v1rfnKUrzJJsrJYecdY10GbBa0+WGr/3fpoIAc5PRBVcb8UNWWfkBLRRrXfNnL8VAKbyRaGvwMWPD2cmPioWJgykjo8u7qN+46ewPMTKIEf/qsKpcjRHPQ2ztacitXH/91KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id F1D32E80204;
	Tue,  9 Apr 2024 10:19:10 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 23E6D160433; Tue,  9 Apr 2024 10:19:09 +0200 (CEST)
Date: Tue, 9 Apr 2024 10:19:09 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: API break, sysfs "capability" file
Message-ID: <ZhT5_fZ9SrM0053p@gardel-login>
References: <ZhQJf8mzq_wipkBH@gardel-login>
 <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
 <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
 <ZhRSVSmNmb_IjCCH@gardel-login>
 <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>

On Mo, 08.04.24 16:41, Keith Busch (kbusch@kernel.org) wrote:

> On Mon, Apr 08, 2024 at 10:23:49PM +0200, Lennart Poettering wrote:
> > Not sure how this is salvageable. This is just seriously fucked
> > up. What now?
> >
> > It has been proposed to use the "range_ext" sysfs attr instead as a
> > hint if partition scanning is available or not. But it's entirely
> > undocumented. Is this something that will remain stable? (I mean,
> > whether something is documented or not apparently has no effect on the
> > stability of an API anyway, so I guess it's equally shaky as the
> > capability sysattr? Is any of the block device sysfs interfaces
> > actually stable or can they change any time?)
>
> The "ext_range" attribute does look like an appropriate proxy for the
> attribute, but indeed, it's not well documented.
>
> Looking at the history of the documentation you had been relying on, it
> appears that was submitted with good intentions (9243c6f3e012a92d), but
> it itself changed values, acknowledging the instability of this
> interface.
>
> So what to do? If documentation is all that's preventing "ext_range"
> from replacing you're previous usage, then let's add it in the
> Documentation/ABI/stable/sysfs-block. It's been there since 2008, so
> that seems like a reliable attribute to put there.

Well, history so far is telling us that this doesn't stop the block layer
to change it anyway...

AFAICS "ext_range" is kinda messy to use for this since it changed
behaviour – only since
https://github.com/torvalds/linux/commit/1ebe2e5f9d68e94c524aba876f27b945669a7879
it actually directly exposes GENHD_FL_NO_PART, before it it did some
more complex stuff which did *not* take GENHD_FL_NO_PART into
consideration. It's nasty to hack against that from userspace, since
we never know on what kernel we are on, and how it has been patched.

Also "ext_range" is only available on whole block devices afaics. Partition
block devices do not have it at all, which makes the check userspace
has to do even more complex.

All I am looking for is a very simple test that returns me a boolean:
is there kernel-level partition scanning enabled on this device or
not. At this point it's not clear to me if I can write this at all in
a way that works reasonably correctly on any kernel since let's say
4.15 (which is systemd's "recommended baseline" right now).

I am really not sure how to salvage this mess at all. AFAICS there's
currently no way to write such a test correctly.

1. "ext_range" does not work on older kernels, and not on partition
   block devices
2. "capabilities" does not work on newer kernels, because it changed
   meaning and then was amputated to be zero.
3. There's no way to know if we are on an old or new kernel, as
   apparently various distros backported the amputation.

So, what now?

I think it would be nice if the "capabilities" thing would be brought
back in a limited form. For example, if it would be changed to start
to return 0x200|0x1000 for part scanning is off, 0x1000 when it is on.

That would then mean we return to compatibility with Linux <= 5.15,
but the new 0x1000 bit would tell us that the information is
reliable. i.e. if userspace sees 0x1000 being set we know that the
0x200 bit is definitely correct. That would then just mean that
kernels >= 5.16 until today are left in the cold...

That would then allow userspace to implement:

1. if "capabilities" has 0x200 set → definitely no partition scanning
2. if "capabilities" has 0x1000 set → bit 0x200 reliably tells is
   whether partition scanning on or off
3. if DEVTYPE=partition → definitely no partition scanning
4. if "ext_range" is 1 → definitely no partition scanning
5. if LOOP_GET_STATUS64 works, then .lo_flags' LO_FLAGS_PARTSCAN flag
   indicates partition scanning on or off.
6. otherwise: ??? (probably we should assume partition scanning is on?)

Lennart

--
Lennart Poettering, Berlin

