Return-Path: <linux-kernel+bounces-130172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690858974EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 177D6B2A7DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DCA14EC57;
	Wed,  3 Apr 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kjfnl1kp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F1C14AD1A;
	Wed,  3 Apr 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160643; cv=none; b=OLA2ZLsMXmQXUXFdF1F+57V169/gZulnTvpVLLCtxZoxc3WHuYwMKMp6nbYQ94iHwQqZA8rgAPf8d3/ooA5BhgYgnr76uYKBpR8VjXfMCNhNlbcY7uUd9dUvfn2gUYQxuTWG16lwDB+qpGKwd0F8XmW1WoWLQ/lfjUKOsAHUr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160643; c=relaxed/simple;
	bh=RjjA3injla+yLIn6vNl/4MPYrvsFXCQlqf9JhAg/KQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq00+axNFdAXeFn97lK6+QWOIxoDE+7ge0+8AnwJKbOdSlegx390FCHBupzQwozmCoDTQSdBtIzPbM8BdooGOHkSW5NKY1io8n6SPpjuWc1O2nB8ivn1wkfOuW6LtQoxxMqAqwSoKw76mePWAPkq0JtQMY2mTpSRfpS0q2snKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kjfnl1kp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D596C43390;
	Wed,  3 Apr 2024 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712160643;
	bh=RjjA3injla+yLIn6vNl/4MPYrvsFXCQlqf9JhAg/KQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kjfnl1kpSAKDDMhblTZ/p/hPxaV/nIts/skjhfLCRSpXCJLhtZxUGkF4/eIr40Z8L
	 fTmth+n6+l4CI2GVjdTYomvaqCYKDIpyMrEMEKAxvWBwXk9+zV0oXy6SU2nSqQ9xKp
	 qge43Xu7r8oDhdOapRhhg5mUq0MkiQ+Bzm3kAL5Q=
Date: Wed, 3 Apr 2024 18:10:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Hibernate stuck after recent kernel/workqueue.c changes in
 Stable 6.6.23
Message-ID: <2024040319-doorbell-ecosystem-7d31@gregkh>
References: <ce4c2f67-c298-48a0-87a3-f933d646c73b@leemhuis.info>
 <ZgylCe48FuOKNWtM@slm.duckdns.org>
 <b6cdb17f-206c-4dff-bb45-a60317e0a55e@leemhuis.info>
 <2024040328-surfacing-breezy-34c6@gregkh>
 <Zg10Keik4KORjXMh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg10Keik4KORjXMh@slm.duckdns.org>

On Wed, Apr 03, 2024 at 05:22:17AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Apr 03, 2024 at 07:11:04AM +0200, Greg KH wrote:
> > > Side note: I have no idea why the stable team backported those patches
> > > and no option on whether that was wise, just trying to help finding the best
> > > solution forward from the current state of things.
> > 
> > The Fixes: tag triggered it, that's why they were backported.
> > 
> > > > which would
> > > > be far too invasive for -stable, thus no Cc: stable.
> > > >
> > > > I didn't know a Fixes
> > > > tag automatically triggers backport to -stable. I will keep that in mind for
> > > > future.
> > > 
> > > /me fears that more and more developers due to situations like this will
> > > avoid Fixes: tags and wonders what consequences that might have for the
> > > kernel as a whole
> > 
> > The problem is that we have subsystems that only use Fixes: and not cc:
> > stable which is why we need to pick these up as well.  Fixes: is great,
> > but if everyone were to do this "properly" then we wouldn't need to pick
> > these other ones up, but instead, it's about 1/3 of our volume :(
> > 
> > I'll gladly revert the above series if they shouldn't have been
> > backported to stable, but from reading them, it seemed like they were
> > fixing an issue that was serious and should have been added to stable,
> > which is why they were.
> 
> Oh, yeah, they're fixing an issue. It's just that the issue is relatively
> confined peformance degradation and the fix is really invasive, so not a
> great -stable candidate. At the very least, they'd need a log longer cooking
> time in mainline before being considered for -stable backport.

Ok, I'll go revert them all now.  I did some test builds here with them
reverted and they seem sane.  I'll push out some -rcs with just the
reverts to at least fix the regressions found in the 6.8.y tree now.

> My intention w/ Fixes: wasn't triggering -stable backport at all, so it's a
> miscommunication. From now on, I'll keep in mind that Fixes: does trigger
> backports. I'm not too worried about not using it as the fixee commit can be
> mentioned in the commit message.

No worries, if you want, we can add any files/paths to our "ignore
Fixes: tags, only take cc: stable ones" that we have for many parts of
the kernel already, where maintainers are good and properly tag stuff.
Just let me know.

thanks,

greg k-h

