Return-Path: <linux-kernel+bounces-135904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D821789CCED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B491F23099
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA567146A94;
	Mon,  8 Apr 2024 20:23:55 +0000 (UTC)
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A948146596;
	Mon,  8 Apr 2024 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712607835; cv=none; b=AuvAzcc5EcNvMVbR6Ac2ZvqhAeEYRT3xvZxi7HWA6cNDCMLtouyBf74vlUTcUyz9Hg4N+7j+tOw4xML8twpeSbu6zSsF7EtQH7j7my85QNyMofJtUT7zAHOrHjJxywl3qOu2Z0NqMAy/PhkR1ll0JQBgWgNzXD/Qw1jsH/PvZUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712607835; c=relaxed/simple;
	bh=9ToRaUSFylkRrYfTwRebtnPF5fsDHwr785XYZw6kIcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs7JZsefPU17UMpti3UaZfLn3T4Fm4XktU/Z86ATKHD8OYF8y3zyiCjUBZ1CWt9PTV3x9iWlTU79LAJmaqgtRPr1AgFeRSQNhCdehayfbq4CV9lFInXbmxfOvSLJSXhaprEKfO+HqNwd8Hd4EAuNTSbrIT7ZpX6RLhf7DMJnehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 312CAE801D2;
	Mon,  8 Apr 2024 22:23:50 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id D6D9316019A; Mon,  8 Apr 2024 22:23:49 +0200 (CEST)
Date: Mon, 8 Apr 2024 22:23:49 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: API break, sysfs "capability" file
Message-ID: <ZhRSVSmNmb_IjCCH@gardel-login>
References: <ZhQJf8mzq_wipkBH@gardel-login>
 <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
 <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>

On Mo, 08.04.24 12:41, Keith Busch (kbusch@kernel.org) wrote:

> On Mon, Apr 08, 2024 at 07:43:04PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > [adding the culprit's author to the loop; also CCing everyone else in
> > the Signed-off-by chain and a few lists that should be in the loop, too]
> >
> > On 08.04.24 17:13, Lennart Poettering wrote:
> > >
> > > So this broke systemd:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e81cd5a983bb35dabd38ee472cf3fea1c63e0f23
> >>
> > > We use the "capability" sysfs attr to figure out if a block device has
> > > part scanning enabled or not. There seems to be no other API for
> > > this. (We also use it in our test suite to see if devices match are
> > > expectations, and older systemd/udev versions used to match agains it
> > > from udev rules.)
> > >
> > > The interface was part of sysfs, and documented:
> > >
> > > https://www.kernel.org/doc/html/v5.5/block/capability.html

I linked to the wrong docs btw: here is the right one:

https://www.kernel.org/doc/html/v5.15/block/capability.html

Quoting:

        This file documents the sysfs file block/<disk>/capability.

        capability is a bitfield, printed in hexadecimal, indicating
        which capabilities a specific block device supports:

        …

        GENHD_FL_NO_PART_SCAN (0x0200): partition scanning is disabled. Used
        for loop devices in their default settings and some MMC devices.

We used the flag 0x200 in systemd. i.e. followed the docs, and it
worked back when we added this.

> > > While it doesn't list the partscan bit it actually does document that
> > > one is supposed to look into include/linux/genhd.h for the various
> > > bits and their meanings. I'd argue that makes them API to some level.
> > >
> > > Could this please be reverted? Just keeping the relevant bits (i.e. at
> > > least the media change feature bit, and the part scanning bit) is
> > > enough for retaining userspace compat.
> > >
> > > (Please consider googling or a github code search or so before removing
> > > a public API like this. This compat breakage was very much avoidable
> > > with a tiny bit of googling.)
>
> That is unfortunate wording in the sysfs description.
>
> How were keeping in sync with the changing values before? The setting
> you seem to care about is now defined in a different file, with a
> different name, and with a different value. Or are you suggesting all
> those things should have been stable API?

Ah, so this ws already broken once
before... 430cc5d3ab4d0ba0bd011cfbb0035e46ba92920c

So the documented API was not just broken completely once but twice?

Good to know.

1. GENHD_FL_NO_PART(_SCAN) was originally documented as 0x200.

2. GENHD_FL_MEDIA_CHANGE_NOTIFY was originally documented as 4.

3. And then GENHD_FL_NO_PART(_SCAN) got redefined to 4 in
   430cc5d3ab4d0ba0bd011cfbb0035e46ba92920c.

All that even though this is documented API which is still up on
kernel.org?

Not sure how this is salvageable. This is just seriously fucked
up. What now?

It has been proposed to use the "range_ext" sysfs attr instead as a
hint if partition scanning is available or not. But it's entirely
undocumented. Is this something that will remain stable? (I mean,
whether something is documented or not apparently has no effect on the
stability of an API anyway, so I guess it's equally shaky as the
capability sysattr? Is any of the block device sysfs interfaces
actually stable or can they change any time?)

Lennart

--
Lennart Poettering, Berlin

