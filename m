Return-Path: <linux-kernel+bounces-76256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8691A85F4CE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4347B287339
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E1A45C1C;
	Thu, 22 Feb 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lft8I9ui"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970ED45979
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594936; cv=none; b=lDs+dXpBF63rsinFnMrASzfbELb1OWL8Exk0tgtp/Tjd+pPlpTmf6jBckL8Vgf5fGYMPrMqjI3XxCYncPw+5Vf2qze3o4xCwLaVJAeihPw3A/Q0y3Hg8bJQxdZHF6PLFrutifHqyqdGcgANFxSCgIGJNXW7aQjDTWySkNQ1Bv0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594936; c=relaxed/simple;
	bh=ah58RzzFtf/QZ8WIKwVSkToS/angBk2sZBegYkjTVKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7h2Mp9n9Kh6Ihg4bkI8UDrrwFT6wlgYl18gBLBaDLj98DwJSspaSHIdEyTfDsy/jZDlRN5OPWH7r+chJgAFcUJVsBIxku/rFs6FHtBQEYD5oWtmPDYuSW9Yewk3G6XWhvDVSInVDYlqrMJKxd44vSkFCZqQCPcG/cHB1drU0Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lft8I9ui; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Feb 2024 04:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708594932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/9kSiEtJHUHHWQj1wTEcJDePb3j+S/ewbxUGuLw4+wU=;
	b=Lft8I9uiOXcqQyQUai0lrAf6AWR+BEusn/kEOxS4KQ/YRPf+u2kR8lTm8+w6Hxw8lcycqj
	OHZYThCXDF2HbAmefuOk1nd1osIE3VqPGwtz0z0+4XuPpYkbcsZTfyRroLUlqqMJC2ZC8j
	3uOHqHu8Gbf55pMA7CF+quTSZ1NxCJw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF TOPIC] statx extensions for subvol/snapshot filesystems &
 more
Message-ID: <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx>
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting>
 <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 22, 2024 at 10:14:20AM +0100, Miklos Szeredi wrote:
> On Wed, 21 Feb 2024 at 22:08, Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Wed, Feb 21, 2024 at 04:06:34PM +0100, Miklos Szeredi wrote:
> > > On Wed, 21 Feb 2024 at 01:51, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > >
> > > > Recently we had a pretty long discussion on statx extensions, which
> > > > eventually got a bit offtopic but nevertheless hashed out all the major
> > > > issues.
> > > >
> > > > To summarize:
> > > >  - guaranteeing inode number uniqueness is becoming increasingly
> > > >    infeasible, we need a bit to tell userspace "inode number is not
> > > >    unique, use filehandle instead"
> > >
> > > This is a tough one.   POSIX says "The st_ino and st_dev fields taken
> > > together uniquely identify the file within the system."
> > >
> >
> > Which is what btrfs has done forever, and we've gotten yelled at forever for
> > doing it.  We have a compromise and a way forward, but it's not a widely held
> > view that changing st_dev to give uniqueness is an acceptable solution.  It may
> > have been for overlayfs because you guys are already doing something special,
> > but it's not an option that is afforded the rest of us.
> 
> Overlayfs tries hard not to use st_dev to give uniqueness and instead
> partitions the 64bit st_ino space within the same st_dev.  There are
> various fallback cases, some involve switching st_dev and some using
> non-persistent st_ino.

Yeah no, you can't crap multiple 64 bit inode number spaces into 64
bits: pigeonhole principle.

We need something better than "hacks".

> What overlayfs does may or may not be applicable to btrfs/bcachefs,
> but that's not my point.  My point is that adding a flag to statx does
> not solve anything.   You can't just say that from now on btrfs
> doesn't have use unique st_ino/st_dev because we've just indicated
> that in statx and everything is fine.   That will trigger the
> no-regressions rule and then it's game over.  At least I would expect
> that to happen.
> 
> What we can do instead is introduce a new API that is better,

This isn't a serious proposal.

