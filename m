Return-Path: <linux-kernel+bounces-56478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FEB84CAA6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33BEB24FB5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE90659B7E;
	Wed,  7 Feb 2024 12:24:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F161B803
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308642; cv=none; b=BNrFEjRBmskFF/Oqjqm2NOkuBtRycac/NbjjaVx0sr7AvOnBOiyYQ6Hq+GSOLKtxqlOL1sZznRwkxA7U7PbP8lerSQq8SkzAkm82KrUr6WykrHUm/SN2MCh1+qlSGFi2ltP0omChY8QKwx5oDll58EMgNc2ZG4FC4OUdHVisAgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308642; c=relaxed/simple;
	bh=WZoRpB52zZ7l1NyOfQgJEXEwZ+ms0vzx/IXhARDbYA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIKLBdKHgaug2uVh9HdTGGHvUvZi+Xwq+Yy3QjjqqDd5DU/HL27v2BTxsWtxqoRDlO2tFFWA1DnLwJv+frxGK/z/viiV6PnpSTWJM3zCinskFCIBAvvh01YnhSDuKtG42tKdMZ5cdB9GEdxLzedrsJi1zNAEl1kKHryp58a5ShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 133801FB;
	Wed,  7 Feb 2024 04:24:42 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 978193F5A1;
	Wed,  7 Feb 2024 04:23:58 -0800 (PST)
Date: Wed, 7 Feb 2024 12:23:56 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64/sve: Lower the maximum allocation for the SVE
 ptrace regset
Message-ID: <ZcN2XMkvqxNnsz5K@e133380.arm.com>
References: <20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org>
 <ZcEW3y0IlEctOYBA@e133380.arm.com>
 <ZcEd2zU/JpeIwn5f@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcEd2zU/JpeIwn5f@finisterre.sirena.org.uk>

On Mon, Feb 05, 2024 at 05:41:47PM +0000, Mark Brown wrote:
> On Mon, Feb 05, 2024 at 05:11:59PM +0000, Dave Martin wrote:
> > On Sat, Feb 03, 2024 at 12:16:49PM +0000, Mark Brown wrote:
> 
> > > We could also teach the ptrace core about runtime discoverable regset sizes
> > > but that would be a more invasive change and this is being observed in
> > > practical systems.
> 
> > This is not hard at all: see
> > 27e64b4be4b8 ("regset: Add support for dynamically sized regsets") 
> 
> > But since this is precisely what was ripped out, I guess adding it back
> > may be controversial (?)
> 
> Also just that people might want to backport and while it's not super
> *hard* I tend to prefer to do something as minimal as possible as a fix,
> the less we do the less the chances that we mess up.

Totally agree with that: the core code has now gone in another direction,
so we should consider that a done deal.  I'm just using the old patch as
an illustration of the (low) level of complexity.

> > > We should probably also use the actual architectural limit for the
> > > bitmasks we use in the VL enumeration code, though that's both a little
> > > bit more involved and less immediately a problem.
> 
> > Since these masks are 64 bytes each and rarely accessed, it seemed
> > pointless complexity to make them resizeable...
> 
> I was suggesting making them use the architectural maximum rather than
> making them dynamic.
> 
> > > +#define ARCH_SVE_VQ_MAX 16
> > >  #define SME_VQ_MAX	16
> 
> > Ack, though part of the reason for not doing this was to discourage
> > people from allocating statically sized buffers in general.
> 
> I was going to do a patch adding a comment to the header noting that
> this is not actually the architectural maximum since at present it's
> a bit of a landmine, people who have some idea of the architecture
> likely have a rough idea what sort of allocation size is needed for the
> maximum SVE state and are likely to not double check the value provided
> (I think that's what happened with the refactoring to remove the dynamic
> sizing).  A comment in the header is still very missable but it'd be
> something.
> 
> > If the kernel is now juggling two #defines for the maximum vector size,
> > this feels like it may seed bitrot...
> 
> Ideally we'd just not have the existing define externally but it's there
> and it's been used.

To clarify, is this intended as a temporary band-aid against silly
behaviour while a cleaner solution is found, or a permanent limitation?

We'd need to change various things if the architectural max VL actually
grew, so no forward-portability is lost immediately if the kernel
adopts 16 internally, but I'm still a little concerned that people may
poke about in the kernel code as a reference and this will muddy the
waters regarding how to do the right thing in userspace (I know people
shouldn't, but...)

[...]

Cheers
---Dave

