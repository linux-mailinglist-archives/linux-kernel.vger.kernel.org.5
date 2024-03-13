Return-Path: <linux-kernel+bounces-102352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E543187B111
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A041C26E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA96C60EDC;
	Wed, 13 Mar 2024 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V0IZuJfX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBED60EE4;
	Wed, 13 Mar 2024 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354054; cv=none; b=UHGWkavKJCOlI+6IYTSzMtdoZI/jN16t6SXEuxb4HvuUUVEKV3M6y4k/4NKbYdAhDG8Eo6RSfhJaNSZFNSnuE1nRb7RW6LLZbZZYue2hz6dQqLxtrfI103vZnNjMzCPKAVJ4K3svKg7S8KtWQE581b/9xPxcBkcr+qA2kympYLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354054; c=relaxed/simple;
	bh=pb3PbjRUKpd/7/a641PCQHaVm1QIzqBTmJAIh9Wpowg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8idFYOrX9RdODQwV9xycmYXKT0d6tLxemoE6QsmyR+ZTiyKgfRtoIgoWiCT808HvfWx82U+Kni7sjgoPXRRlBu0f4UXzR3RLztwNPMAqniOKr0NcQ99QbjC0bCBBDW9GvG2pK3RpIVdMkOkG+4t2Pn+mL2ytC6n1aZD4gVJ1FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V0IZuJfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66CFC433C7;
	Wed, 13 Mar 2024 18:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710354053;
	bh=pb3PbjRUKpd/7/a641PCQHaVm1QIzqBTmJAIh9Wpowg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0IZuJfX2Vwh09ol7ZcUKsvb8pu86deNyfD3mySIpkxFxGDbUPCzcgh4HKX3bmArC
	 70jTK2mNeXnkheUex8YZ45vBJkAtoIjjUpsdOjS94W8eEuUSCo6ojXqGyYP+D8rC76
	 Js68Di862bahzXNUncQKXExo7qZ+cDzMmoeez7ZE=
Date: Wed, 13 Mar 2024 19:20:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.7.y
Message-ID: <2024031352-valuables-handling-cec3@gregkh>
References: <2zaqetj6wlxgpbxgex643dnudgwhcrz23xgfuai3t3hgavjb2d@vwhyha3hlg5y>
 <zneppz2ohlalk2qeitdkzxvtexuqgfbhx6sxocgiasuuwsbopl@cr4d3wve2sot>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zneppz2ohlalk2qeitdkzxvtexuqgfbhx6sxocgiasuuwsbopl@cr4d3wve2sot>

On Tue, Mar 12, 2024 at 08:54:24PM -0400, Kent Overstreet wrote:
> On Sun, Mar 10, 2024 at 03:43:38PM -0400, Kent Overstreet wrote:
> > The following changes since commit 2e7cdd29fc42c410eab52fffe5710bf656619222:
> > 
> >   Linux 6.7.9 (2024-03-06 14:54:01 +0000)
> > 
> > are available in the Git repository at:
> > 
> >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-for-v6.7-stable-20240310
> > 
> > for you to fetch changes up to 560ceb6a4d9e3bea57c29f5f3a7a1d671dfc7983:
> > 
> >   bcachefs: Fix BTREE_ITER_FILTER_SNAPSHOTS on inodes btree (2024-03-10 14:36:57 -0400)
> > 
> > ----------------------------------------------------------------
> > bcachefs fixes for 6.7 stable
> > 
> > "bcachefs: fix simulateously upgrading & downgrading" is the important
> > one here. This fixes a really nasty bug where in a rare situation we
> > wouldn't downgrade; we'd write a superblock where the version number is
> > higher than the currently supported version.
> > 
> > This caused total failure to mount multi device filesystems with the
> > splitbrain checking in 6.8, since now we wouldn't be updating the member
> > sequence numbers used for splitbrain checking, but the version number
> > said we would be - and newer versions would attempt to kick every device
> > out of the fs.
> > 
> > ----------------------------------------------------------------
> > Helge Deller (1):
> >       bcachefs: Fix build on parisc by avoiding __multi3()
> > 
> > Kent Overstreet (3):
> >       bcachefs: check for failure to downgrade
> >       bcachefs: fix simulateously upgrading & downgrading
> >       bcachefs: Fix BTREE_ITER_FILTER_SNAPSHOTS on inodes btree
> > 
> > Mathias Krause (1):
> >       bcachefs: install fd later to avoid race with close
> > 
> >  fs/bcachefs/btree_iter.c        |  4 +++-
> >  fs/bcachefs/chardev.c           |  3 +--
> >  fs/bcachefs/errcode.h           |  1 +
> >  fs/bcachefs/mean_and_variance.h |  2 +-
> >  fs/bcachefs/super-io.c          | 27 ++++++++++++++++++++++++---
> >  5 files changed, 30 insertions(+), 7 deletions(-)
> 
> Why wasn't this applied?

Because our queue is huge and 1/2 of the stable team is finally taking
his first vacation in years (and regretting reading email during it
right now)?  Relax, it will get there, backport requests like this not
being handled in 48 hours seems like a big ask, don't you think?

greg k-h

