Return-Path: <linux-kernel+bounces-43309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4991E8411FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1401F25CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26C76F07C;
	Mon, 29 Jan 2024 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TlTdSeJM"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3976F06A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552990; cv=none; b=UMqGCz6YRkMu+PaX5nRYAr95l2VwXWgSaz9fv4Xjp5uiHeCz7XXiWCwUgtoAv1CqIo3igjZjapPRAYVg3SvmKwDmRtrHs58lb/1nv4N/s7rr6hOasjLcwLWwJ4KyVdhaRwIEtSXliyL65pgRRxyDRUK9D3wHFVoqShYHhl9s9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552990; c=relaxed/simple;
	bh=C5reL8/AQXoUw1TSxfQy5hhY18bwgr15t49YsMn+zT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Au9mseuvW9yjLSSlX2+FMxppilfbchitB5Oxtvllr2aUHuXagCT+hAS2l0mNRDhReoF0xuh++ZLNNQJP6PN/MszAmFowf7eQEQJT4PEMqcpev4O04lHcYFT1RloETz535wjYOdC5MAdUJL7acqp3i/x2eM2f6Qr8bclBoRl4HNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TlTdSeJM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L15BcID6N2m2SSuhv58XpXjWm9YJ1v+eDodM3DQBG/I=; b=TlTdSeJMNlBeus/2VdtzaSVjyR
	ZFIM0+AuNPyNvc4rwhbOFnptVPGtnvZvwMEa6hbE5/7DQJ1WioyE6L65sSpFSzKzwaqvlrk4Q0A5J
	Q3QkOEJ+ESxun57sjoygJ9hE75u247qblK3KtHj76S0selNxypbHHUUoebVVMvG52CV8gSbXT73hm
	ceRRXtkXKZrywY216Rd2bzHPkbaTNlBdbxCZN3ZG80hHZkz6rut6DJyMO97S3GPaiK/z8WM44A92v
	8qBNw7mFeSOlIj0qohYunggZdda7u3R71zj6Z+SAi8RQYkitHzbrx1gqa7JYpVlQojxYkqo5sIX3V
	njpB4acA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUWO8-00000007Oe2-32RT;
	Mon, 29 Jan 2024 18:29:44 +0000
Date: Mon, 29 Jan 2024 18:29:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Manas Ghandat <ghandatmanas@gmail.com>,
	Linux-kernel-mentees@lists.linuxfoundation.org,
	jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	syzbot+411debe54d318eaed386@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] jfs: fix shift-out-of-bounds in dbJoin
Message-ID: <ZbfumG4uLUwZkzlf@casper.infradead.org>
References: <20231011143937.31996-1-ghandatmanas@gmail.com>
 <Zba9zRWq6rZhWn-p@casper.infradead.org>
 <a25c75af-c961-4ca6-9810-dbcfe64753d5@oracle.com>
 <Zbe8c_CPNP8IdphB@casper.infradead.org>
 <551e1e86-f990-487a-ad88-53799df0882a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551e1e86-f990-487a-ad88-53799df0882a@oracle.com>

On Mon, Jan 29, 2024 at 09:00:56AM -0600, Dave Kleikamp wrote:
> On 1/29/24 8:55AM, Matthew Wilcox wrote:
> > On Mon, Jan 29, 2024 at 08:39:18AM -0600, Dave Kleikamp wrote:
> > > On 1/28/24 2:49PM, Matthew Wilcox wrote:
> > > > On Wed, Oct 11, 2023 at 08:09:37PM +0530, Manas Ghandat wrote:
> > > > > Currently while joining the leaf in a buddy system there is shift out
> > > > > of bound error in calculation of BUDSIZE. Added the required check
> > > > > to the BUDSIZE and fixed the documentation as well.
> > > > 
> > > > This patch causes xfstests to fail frequently.  The one this trace is
> > > > from was generic/074.
> > > 
> > > Thanks for catching this. The sanity test is not right, so we need to revert
> > > that one.
> > 
> > Unfortunately, my overnight test run with this patch reverted crashed
> > again with the same signature.  I also reverted the parent commit,
> > and when that crashed I also reverted the parent of that.  Which also
> > crashed.
> > 
> > So maybe there's something else that makes this unstable.  Or maybe my
> > bisect went wrong.  Or _something_.  Anyway, I'm going to spend much of
> > today hammering on generic/074 with various kernel versions and see what
> > I can deduce.
> > 
> > So far I see no evidence that v6.7 crashes with g/074.  And I know that
> > next-20240125 does crash with g/074.  I'm pretty sure that v6.8-rc1 also
> > crashes with g/074, but will confirm that.
> 
> I'll try to beat on it too and see what I find.
> 
> Sasha, maybe hold up on to all the jfs patches for the time being.

I have it reproducing easily on cca974daeb6c.  I ran it a lot on
e0e1958f4c36 and have not reproduced it.  So I'm going back to my
earlier assertion that cca974daeb6c is bad.  Now, maybe other commits
are also bad?


