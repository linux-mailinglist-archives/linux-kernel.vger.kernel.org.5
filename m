Return-Path: <linux-kernel+bounces-135831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BD589CBDD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5A628299A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BB9146592;
	Mon,  8 Apr 2024 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPddvwU9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCFE142658;
	Mon,  8 Apr 2024 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601703; cv=none; b=WWVvB8LIJ9mc1FSgS1Y+gSL3wInjrkMZLDuUC8U1wTLRDmbQKyeDwb3imXe25SA7gYwpUIQpGvTtiutLLlqtNS7fX+XgRYs0ZZtcFVVLzR7fwcZtmTSB3PV3MLSSVHaLdt3Ux666l1jgA4X4CU0QkrFtMMS43fox36+r6hMM2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601703; c=relaxed/simple;
	bh=kvkQSlddqci/+RUhxhBMoeQfL8gXtcjlyJF3nXAwetw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtOu0fKWa3UmEHPaa5zveuU46600KaTxJBCdhtMxUi6kAbJwXwDTbm864KbbI8bPbZ7OTYAMD11ne6/54eOQPxUQ+KWV5xgiz/FkkpDWnnFDXssbdEY69gj49JVxjcCqFLQwwqAMr930fRHeiFVoWeTaDaBCXdyPKxxhhAedE5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPddvwU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA929C433F1;
	Mon,  8 Apr 2024 18:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712601703;
	bh=kvkQSlddqci/+RUhxhBMoeQfL8gXtcjlyJF3nXAwetw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPddvwU9dRrZQRHPi6LGS+Yc36cwkojFEvpaSzqJx816Mhy0fSs5APEpMl+Yq2BfC
	 QN/vDvOismURCY5nOEeX2UVqyE0K6ePgmxxMaXoh7SlsOg0DDVOo49Yq9eBHDOgDaZ
	 Xt+eRhZingpzg5CWoNMusN4lWjykAp7LmbuIqRPwEI3VmTy9qt+ZrfjGImX9Dz9LI5
	 B2GJZYzTbW5I/vu5DwZ284Fy6mP9YzSGZKNlEQq2eHeetimCs2kaxJF1uMNizTY83+
	 SORuj56kSyIuXN3Xur51aW43vHzyNhlobrsTi9pQ/XfY/pWR6V4DiL3Otqf2K8s3mw
	 LDRXJF9VfJJtw==
Date: Mon, 8 Apr 2024 12:41:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,
	Lennart Poettering <lennart@poettering.net>,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: API break, sysfs "capability" file
Message-ID: <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
References: <ZhQJf8mzq_wipkBH@gardel-login>
 <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>

On Mon, Apr 08, 2024 at 07:43:04PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> [adding the culprit's author to the loop; also CCing everyone else in
> the Signed-off-by chain and a few lists that should be in the loop, too]
> 
> On 08.04.24 17:13, Lennart Poettering wrote:
> > 
> > So this broke systemd:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e81cd5a983bb35dabd38ee472cf3fea1c63e0f23
>> 
> > We use the "capability" sysfs attr to figure out if a block device has
> > part scanning enabled or not. There seems to be no other API for
> > this. (We also use it in our test suite to see if devices match are
> > expectations, and older systemd/udev versions used to match agains it
> > from udev rules.)
> > 
> > The interface was part of sysfs, and documented:
> > 
> > https://www.kernel.org/doc/html/v5.5/block/capability.html
> > 
> > While it doesn't list the partscan bit it actually does document that
> > one is supposed to look into include/linux/genhd.h for the various
> > bits and their meanings. I'd argue that makes them API to some level.
> > 
> > Could this please be reverted? Just keeping the relevant bits (i.e. at
> > least the media change feature bit, and the part scanning bit) is
> > enough for retaining userspace compat.
> > 
> > (Please consider googling or a github code search or so before removing
> > a public API like this. This compat breakage was very much avoidable
> > with a tiny bit of googling.)

That is unfortunate wording in the sysfs description.

How were keeping in sync with the changing values before? The setting
you seem to care about is now defined in a different file, with a
different name, and with a different value. Or are you suggesting all
those things should have been stable API?

