Return-Path: <linux-kernel+bounces-148771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554468A872D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1BB1F224ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CC51474C5;
	Wed, 17 Apr 2024 15:13:56 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076DC146D41;
	Wed, 17 Apr 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366836; cv=none; b=aMVTrsXJnq0XiOvG7UQOywbqiKD4GaY9G8ysxDQYLajfxRSHHw5Di0wxS8RzbHApmeAICW1BK33DpX0USXXi2zxhrLFbrUBQgAX/nn65oZl1gDmr5AQrZv3C4Ym8UYA2ZLr1UpWr5iv2oNHXOKNZfPcP5oLd94kGDItKSU4BDKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366836; c=relaxed/simple;
	bh=eeHlBHvXaDB3on0ByhfRt5OA6kYCTofvpJLzF7XmYtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+kk4cFhQN5YE/xLldDbn+h0inY7XhHGmHages7La/XwB0KxB5IpkVWVQW5ivJG0pALuSo4plKRe40MVhl4eqSN0JyVJykY/pOA6Bx7cAhUopFxF9MA+PAyZmq6LcXYtssH+TQBfqqaID8KU/XBGchpVXkHIAMM2GCNqGrphT7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 285EF227A88; Wed, 17 Apr 2024 17:13:51 +0200 (CEST)
Date: Wed, 17 Apr 2024 17:13:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Lennart Poettering <mzxreary@0pointer.de>,
	Christoph Hellwig <hch@lst.de>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: API break, sysfs "capability" file
Message-ID: <20240417151350.GB2167@lst.de>
References: <ZhQJf8mzq_wipkBH@gardel-login> <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info> <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com> <ZhRSVSmNmb_IjCCH@gardel-login> <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com> <ZhT5_fZ9SrM0053p@gardel-login> <20240409141531.GB21514@lst.de> <Zh6J75OrcMY3dAjY@gardel-login> <Zh6O5zTBs5JtV4D2@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh6O5zTBs5JtV4D2@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 16, 2024 at 08:44:55AM -0600, Keith Busch wrote:
> The patch that introduced this was submitted not because the API was
> stable; it was committed to encourage developers to update it as it
> changed because it is *not* stable. That's not the kind of interface you
> want exported for users to rely on, but no one should have to search
> commit logs to understand why the doc exists, so I think exporting it
> was just a mistake on the kernel side. To say this doc is "good"
> misunderstands what it was trying to accomplish, and what it ultimately
> created instead: technical debt.

Yes.  It might be a problem with the documentation generation mess,
but something that is generated from a random code comment really
can't be an API document.

Anyway, instead of bickering about this, what does systemd actually
want to known?  Because all these flags we talked about did slightly
different things all vaguely related to partition scanning.
We also have another GD_SUPPRESS_PART_SCAN bit that is used to
temporarily suppress partition scanning (and ublk now also abuses
it in really whacky way, sigh).  I'm not really sure why userspace
would even care about any of this, but I'm open to come up with
something sane if we can actually define the semantics.

