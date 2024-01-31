Return-Path: <linux-kernel+bounces-45688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4884342C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2ECD28D49E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DD3FBE1;
	Wed, 31 Jan 2024 02:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gS99y5a4"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE57F9FA;
	Wed, 31 Jan 2024 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706669193; cv=none; b=DMhMnu18YzKk7XIN8hywkJHec0+ccxP5O0+jm19cuTvWc4SIF7tMkPALAHTGkN5B7NTc4ZuR6g6kqLp15fgm0v/QPxPf2+u97egTcCqYsemBJznmHzr0z18dpxGAWCMLrkD+xCOtOaGQh9ssrXHIZA1rKed0+7etUMPcD/b5o28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706669193; c=relaxed/simple;
	bh=hO88cir5G8VkmZGM+f/afElr7N0rrYwqQyzsZup6KuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0Wqwrb8qdBeKKK3yvqxxQI7WTQ+rwyBH3/zAs9Fe+wM1/scSmy0rY/W2zo2kjmlhZPVBuZ6MXUU97rAmPDX9aY8fdCcMoK9hWAKWdA7bMr+2/cAt2IPUQJ/mINPktcYHPv1lm3zl2DcQgT9nsCjG53KI8ULau/s4ma+uZAy9fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gS99y5a4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Deybqn/u0JV7iqQYKVUrpkV+y9JJeEkIA+dCsumRDOw=; b=gS99y5a4zz5O/PVtgb/0CjP34p
	R+EcuyI8nY0hmqrCBULxO8H88o4NmeP4xin7y8Gp5dPng8NVeNW7BJJ9tKqRZvtzXQ6ILVzXcXSEk
	Jig9+nsay5a3ZukfnSKN6LzJnmsyZ+juUylQBBj2QXzstdcXiqN1zr31Brk03r2MC2exk4TyTdzBE
	i2+voXkE56R0q6II9W8pi9B+k0AJvf+qDc/fhKHMiHkCvO8BfNW9pqkfVPKd163wmEV4IYvmQSh0v
	py5bTJ7AhbwlZ8wTlk/V789bbRZE66Bb76OPzq/3Amng1k3+MTCUqXas4ONZuuTNjemFMRA0JAoxB
	mmf7n/uQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rV0cM-001pEy-15;
	Wed, 31 Jan 2024 02:46:26 +0000
Date: Wed, 31 Jan 2024 02:46:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] eventfs: clean up dentry ops and add revalidate
 function
Message-ID: <20240131024626.GQ2087318@ZenIV>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-6-torvalds@linux-foundation.org>
 <20240131011246.GP2087318@ZenIV>
 <CAHk-=wie3VgLatmR4J_VpnyJR-qKppz=gnDfxEa9Gyy-7cH7HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wie3VgLatmR4J_VpnyJR-qKppz=gnDfxEa9Gyy-7cH7HQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 30, 2024 at 06:37:49PM -0800, Linus Torvalds wrote:
> On Tue, 30 Jan 2024 at 17:12, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > > + *
> > > + * Note that d_revalidate is called potentially under RCU,
> > > + * so it can't take the eventfs mutex etc. It's fine - if
> > > + * we open a file just as it's marked dead, things will
> > > + * still work just fine, and just see the old stale case.
> >
> > Looks like use after free, unless freeing ei is RCU-delayed...
> 
> We hold the ref to the ei in the very dentry that is doing d_revalidate().

What's to stop ->d_revalidate() from being called in parallel with
__dentry_kill()?

