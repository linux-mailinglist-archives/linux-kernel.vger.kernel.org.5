Return-Path: <linux-kernel+bounces-137073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E8189DBF9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF121C2112E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE7C12FF6B;
	Tue,  9 Apr 2024 14:15:38 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887112FB0F;
	Tue,  9 Apr 2024 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672138; cv=none; b=bGLUHZXtvOM4NVFcZZbEh9eIaabcbI4KJkV2xO2oGjQbTrmPMj15EvHGJyoDgumliJGxvqk9N8e/RLl2Amy3OHLKJmS9XWCjjVs+6SK9p9ihPGTwXIxnlHI2zhvsqHUwhtFXLEsEgrUJbh/B7as8rxB6xbd7F/L+ogwmyGAEv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672138; c=relaxed/simple;
	bh=1Hvn0UUQi7daY6MeWzk+embfXVjNT5NRKIlTZP6dTWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM30V1E9KCYCvnUFUQVKk3uq335eW1DXoTlnxs8OTyjFak6mhRCMeQqFuOY0MuCLAbxO5OaMCD3IIJCx4nKPSmi6b3uY+0dgMU9k7F2OOj8gL9zNfYa5HxTHBpwgJGm+wJAPaGCQJs7wF0MOrEogA9B90M3d4HJ2RydsF3RmzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65FB468B05; Tue,  9 Apr 2024 16:15:32 +0200 (CEST)
Date: Tue, 9 Apr 2024 16:15:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: API break, sysfs "capability" file
Message-ID: <20240409141531.GB21514@lst.de>
References: <ZhQJf8mzq_wipkBH@gardel-login> <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info> <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com> <ZhRSVSmNmb_IjCCH@gardel-login> <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com> <ZhT5_fZ9SrM0053p@gardel-login>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhT5_fZ9SrM0053p@gardel-login>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 09, 2024 at 10:19:09AM +0200, Lennart Poettering wrote:
> All I am looking for is a very simple test that returns me a boolean:
> is there kernel-level partition scanning enabled on this device or
> not.

And we can add a trivial sysfs attribute for that.

> At this point it's not clear to me if I can write this at all in
> a way that works reasonably correctly on any kernel since let's say
> 4.15 (which is systemd's "recommended baseline" right now).
> 
> I am really not sure how to salvage this mess at all. AFAICS there's
> currently no way to write such a test correctly.

You can't.  Maybe that's a lesson to not depend on undocumented internal
flags exposed by accident by a weirdo interface.  Just talk to people.

> I think it would be nice if the "capabilities" thing would be brought
> back in a limited form. For example, if it would be changed to start
> to return 0x200|0x1000 for part scanning is off, 0x1000 when it is on.
> 
> That would then mean we return to compatibility with Linux <= 5.15,
> but the new 0x1000 bit would tell us that the information is
> reliable. i.e. if userspace sees 0x1000 being set we know that the
> 0x200 bit is definitely correct. That would then just mean that
> kernels >= 5.16 until today are left in the cold...

At this point we're just better off with a clean new interface.
And you can use the old hack for < 5.15 if you care strongly enough
or just talk distros into backporting it to make their lives easier.

