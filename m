Return-Path: <linux-kernel+bounces-146510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E8B8A665C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC111C21259
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFCE83CCD;
	Tue, 16 Apr 2024 08:46:12 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84274629
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257172; cv=none; b=oafg8IW97zONsOoWBAuuB43jT3ej/3j1KULg/Gjjazehpe+TAvJUabb7Rea4MeoOKdkdw36IT4OBpgJLIRCtoNu2bU9GGkrmU5VUZ8K4Dc4MB7GCEvIIJYHe/78CweXxvfu7n166swi5cq31MnFMQk/4wK2l4gTEyBQkshD+VmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257172; c=relaxed/simple;
	bh=3Qr/MuM4uXVFnY2ljfnWTLIE1lncUnhBYk9YiKW04ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEKiKco/JWHoeg5EY66vWPkX1CmqWvAA5Uy0NPJH5OhlyeBsUNnaz0y2CPAzJFS7a9LK7pDTCWjnILKRd1EwSE9NBMSgMdX50KhHYbqt1oF2nDt5MApT5sdCpDlTrf9NaTyQWHTuKzJc9q4H+fHOpLctWr9GZ9Gb4S237v3aWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CD09040E0177;
	Tue, 16 Apr 2024 08:46:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZdGIa9CSwlM9; Tue, 16 Apr 2024 08:46:00 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 509A440E00B2;
	Tue, 16 Apr 2024 08:45:51 +0000 (UTC)
Date: Tue, 16 Apr 2024 10:45:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: a-development@posteo.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
	jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
Message-ID: <20240416084544.GAZh46uKW6ijAfftmI@fat_crate.local>
References: <cbad6acb30e33e8dd387080e5936cc38@posteo.net>
 <20240127191942.GEZbVXTtDNzLB9hTpr@fat_crate.local>
 <181005cf4a78a4c3c5e1de77498f6c23@posteo.net>
 <20240127194139.GFZbVcc2RxhNtO3ZHD@fat_crate.local>
 <6170a3f60cd1ca68bca5829db4a8568a@posteo.net>
 <20240326222134.GNZgNKbgdBUsAU98RV@fat_crate.local>
 <d0dfa77ba8231652554c4e6088f985d1@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0dfa77ba8231652554c4e6088f985d1@posteo.net>

On Tue, Apr 16, 2024 at 06:48:54AM +0000, a-development@posteo.de wrote:
> It worked, it worked!
> 
> https://up.tail.ws/txt/working-suspend.txt
> 
> I've tested it now quite some time.
> But, I also had to start using 6.6.26-1-lts because my magewell capture card
> wouldn't without.

Right, that thing I guess:

[Mon Apr 15 18:37:58 2024] ProCapture: loading out-of-tree module taints kernel.
[Mon Apr 15 18:37:58 2024] ProCapture: module verification failed: signature and/or required key missing - tainting kernel

So, machines do suspend even with SRSO enabled and since your machine is
affected, you probably should try without spec_rstack_overflow=off to
see if it works with the new kernel.

Then, the other thing you could try is whether suspend works without
that proprietary crap.

And then we can see.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

