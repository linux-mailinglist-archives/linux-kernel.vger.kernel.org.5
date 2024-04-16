Return-Path: <linux-kernel+bounces-147007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EE18A6E27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFEA1C224C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B219F131730;
	Tue, 16 Apr 2024 14:23:47 +0000 (UTC)
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A5128805;
	Tue, 16 Apr 2024 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277427; cv=none; b=SdtGdvlUFxIIIbJyxa3ls+fJiJrZATqc+jc5R51kzsbGn8NcsV0Tn6DdieY8HHtjADOMi7fAHgKf3WsM0jxTnu6T4rQmZpqQa/snQ/qTWjeOg+tUlmKC9hW8lu4EQP9iOmbAgZcJCagEMqhJv/1Xp3GpJ2s08yF9h/NPT/NT5bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277427; c=relaxed/simple;
	bh=QHU5zAV46hH4gPdF4wTQVl7/aVr6MuGxxpWelAUaaRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI1/MKQvi5z+R7g94qtNbZNUpT48SQqttiYW7kRcnihlgfObqPZaUH10/ivC+QIgQCFZ3ntIFdH5QuDd2GjyFDIxMdncEZVauYUSX1k+6t+KiM/cAAj4VKrNV8ekhfgbunD6jkI1GILP6py8pj1YSt8Rkuyb1lr+duXcE5wtc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id B93ABE803C0;
	Tue, 16 Apr 2024 16:23:43 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 6F69F1602F7; Tue, 16 Apr 2024 16:23:43 +0200 (CEST)
Date: Tue, 16 Apr 2024 16:23:43 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: API break, sysfs "capability" file
Message-ID: <Zh6J75OrcMY3dAjY@gardel-login>
References: <ZhQJf8mzq_wipkBH@gardel-login>
 <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
 <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
 <ZhRSVSmNmb_IjCCH@gardel-login>
 <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
 <ZhT5_fZ9SrM0053p@gardel-login>
 <20240409141531.GB21514@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409141531.GB21514@lst.de>

On Di, 09.04.24 16:15, Christoph Hellwig (hch@lst.de) wrote:
11;rgb:1717/1414/2121
> On Tue, Apr 09, 2024 at 10:19:09AM +0200, Lennart Poettering wrote:
> > All I am looking for is a very simple test that returns me a boolean:
> > is there kernel-level partition scanning enabled on this device or
> > not.
>
> And we can add a trivial sysfs attribute for that.
>
> > At this point it's not clear to me if I can write this at all in
> > a way that works reasonably correctly on any kernel since let's say
> > 4.15 (which is systemd's "recommended baseline" right now).
> >
> > I am really not sure how to salvage this mess at all. AFAICS there's
> > currently no way to write such a test correctly.
>
> You can't.  Maybe that's a lesson to not depend on undocumented internal
> flags exposed by accident by a weirdo interface.  Just talk to
> people.

Undocumented? Internal?

It's was actually one of the *best* documented kernel *public* APIs I
ever came across:

   https://www.kernel.org/doc/html/v5.16/block/capability.html

So much detail, I love it!

I mean, you did good work here, documented it, with all flags in all
details. I think that's great work! You should take pride in this, not
try to deny its existance!

> > I think it would be nice if the "capabilities" thing would be brought
> > back in a limited form. For example, if it would be changed to start
> > to return 0x200|0x1000 for part scanning is off, 0x1000 when it is on.
> >
> > That would then mean we return to compatibility with Linux <= 5.15,
> > but the new 0x1000 bit would tell us that the information is
> > reliable. i.e. if userspace sees 0x1000 being set we know that the
> > 0x200 bit is definitely correct. That would then just mean that
> > kernels >= 5.16 until today are left in the cold...
>
> At this point we're just better off with a clean new interface.
> And you can use the old hack for < 5.15 if you care strongly enough
> or just talk distros into backporting it to make their lives easier.

I'll take what I can get. If API compatibility is not coming back,
then sure, a new sysattr is better than nothing.

Lennart

--
Lennart Poettering, Berlin

