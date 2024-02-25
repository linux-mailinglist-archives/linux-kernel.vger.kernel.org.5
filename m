Return-Path: <linux-kernel+bounces-79959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE138628F9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36658B2110E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F91B5256;
	Sun, 25 Feb 2024 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uiZtspxh"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A35382
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708831256; cv=none; b=ibn+SLH5IyQVInOtESyYisKI8IcS0nLCA82XrNZPiofMmTNDqx+5xDMhOl8OGk9SiYm+JXXYP9LOBexXIwZVtuLf0td2OZIQ7bAyFkD0/+e+q8r3USPHBKIRmyk6JVoDAwkycu8zMzxp433s3Y+7O7JtADvjDktMXdMrdFTMWw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708831256; c=relaxed/simple;
	bh=xFKowyoMhCu8KoyOJwEQdR7hyiU/GR4QHk9WLiDY8Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKX/S1Ubgqighq/1/QXTT1x8+Mvag/UMn1tAWjRQX08Lt99tBWWFbGOIa4vMiFM8GgawLZ6e2ofFzP3UZBiK5GIrS5Yt4RxkJDetZYgJQzkKQ2LFIa4d4y244rpsDzZYFX4DUYSIwm/DJLPCQoF0v6xGy1d9247Ig0XXKeYSSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uiZtspxh; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 24 Feb 2024 22:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708831252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U9J1yKDnvDl6KolyPgEXqei4kWuchDlY2Ell6cdvMf0=;
	b=uiZtspxhcPDcD+TaJbQ3sUa9gdhY/699uXROpsOvonTdLCBd6xwRAtAIfpFDJpZJlIwG8Y
	FNR5P5cW1RZsVfmHpllBXBwqQ81G+JIQ9iClq1Lfrsp7bZOgnemR8gaWE8t/Jk6/jhzgLU
	bFuDazUhBfHkR5ZlMvpRf0swK0kzhHo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Laight <David.Laight@aculab.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Thomas Graf <tgraf@suug.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/1] Rosebush, a new hash table
Message-ID: <bm5xgk5vr5g7m35x4pzbxencbv57fjceowrchrxkuy4q5ri3sb@k4lj34hpvstb>
References: <20240222203726.1101861-1-willy@infradead.org>
 <Zdk2YgIoAGOEvcJi@gondor.apana.org.au>
 <4a1416fcb3c547eb9612ce07da6a77ed@AcuMS.aculab.com>
 <ZdqO3G6Fb4wYhVEj@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdqO3G6Fb4wYhVEj@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On Sun, Feb 25, 2024 at 08:50:36AM +0800, Herbert Xu wrote:
> On Sat, Feb 24, 2024 at 10:10:27PM +0000, David Laight wrote:
> >
> > > Normally an rhashtable gets resized when it reaches 75% capacity
> > > so the average chain length should always be one.
> > 
> > The average length of non-empty hash chains is more interesting.
> > You don't usually search for items in empty chains.
> > The only way you'll get all the chains of length one is if you've
> > carefully picked the data so that it hashed that way.
> 
> Sure.  But given the 75% capacity, you'd need a really bad hash
> function to get an *average* (not worst-case) chain length of
> 10.
> 
> > I remember playing around with the elf symbol table for a browser
> > and all its shared libraries.
> > While the hash function is pretty trivial, it really didn't matter
> > whether you divided 2^n, 2^n-1 or 'the prime below 2^n' some hash
> > chains were always long.
> 
> Even in the unlikely event of bad luck and everything bunches up
> together, we change theh hash function (through hash_rnd) every
> time we resize so you would expect things to even out after the
> resize event.
> 
> A rehash is also automatically triggered if the worst-case chain
> length exceeds 16.

16!? that's crap, use a decent hash function and 3-5 should be your
worst upper bound.

