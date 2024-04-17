Return-Path: <linux-kernel+bounces-148209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DA58A7F55
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD31F22040
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D47C12D759;
	Wed, 17 Apr 2024 09:12:26 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112912EBE2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345146; cv=none; b=Jp6uy7MiXmyT9NxFSCTHlAT0a5yuSpyx7bVGKyeYktE4izpUwE44fsZK3TN4czn3LF5t/W+lvactYI9+fD9dgr4V+x6FJmeKvqz1i8vO+D/7gV8vTjQZVUO3GccfRy9RRPev8ySIAj+Ji60BYkehFQAAPsiDsQvzKLsoK+2Yr6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345146; c=relaxed/simple;
	bh=xwwIXSY47KZfycmKt+XXuXJCWRokr5xgAS6HoTEIbOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhd47eiPI5+f39UYzFWIi3/c7dMk1rea1JM4EFeLLAEwqVx2mc31aELSlN/1puLcqdCsRAwXIw/y7b53Xw1Ayj5F4xm7WASCarQWwCDmDmsn/IM6ffwEOL/sb/mb8tfNohiAEl4HyO84iRVlMmyZ8vFd8fPwc5W6PquioVsTXy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4781540E00B2;
	Wed, 17 Apr 2024 09:12:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9fihFXr3HZad; Wed, 17 Apr 2024 09:12:16 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D086840E0177;
	Wed, 17 Apr 2024 09:12:06 +0000 (UTC)
Date: Wed, 17 Apr 2024 11:12:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: a-development@posteo.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
	jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
Message-ID: <20240417091200.GAZh-SYOGABCnsqpKj@fat_crate.local>
References: <cbad6acb30e33e8dd387080e5936cc38@posteo.net>
 <20240127191942.GEZbVXTtDNzLB9hTpr@fat_crate.local>
 <181005cf4a78a4c3c5e1de77498f6c23@posteo.net>
 <20240127194139.GFZbVcc2RxhNtO3ZHD@fat_crate.local>
 <6170a3f60cd1ca68bca5829db4a8568a@posteo.net>
 <20240326222134.GNZgNKbgdBUsAU98RV@fat_crate.local>
 <d0dfa77ba8231652554c4e6088f985d1@posteo.net>
 <20240416084544.GAZh46uKW6ijAfftmI@fat_crate.local>
 <a49e7560f982f00ef1c5452483459b26@posteo.net>
 <0065fda592b2652d1a2730ddbc81cea6@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0065fda592b2652d1a2730ddbc81cea6@posteo.net>

On Wed, Apr 17, 2024 at 08:08:53AM +0000, a-development@posteo.de wrote:
> Today I failed to suspend, and the spec_rstack thing was off.
> 
> https://up.tail.ws/txt/non-working-suspend-2.txt

Ok, but please do not top-post. Put your reply underneath the next
you're replying to and remove the rest of the quoted text like I just
did.

So this could be caused by the proprietary module or something else.

If you want this debugged, you'd have to try to reproduce it with the
latest upstream kernel from here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

after having removed the propietary module.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

