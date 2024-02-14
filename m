Return-Path: <linux-kernel+bounces-65208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4F4854977
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D22EB22163
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AAC52F61;
	Wed, 14 Feb 2024 12:42:52 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21E5524C9;
	Wed, 14 Feb 2024 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914571; cv=none; b=ZJw1ZqyIbbbvS39MaFSaDfPODp0HLwuCZjkAZMdN+aP44IXI42wFJUIPqtxTqOzGxkK7R5w176qBLpHxVywku5lSG9jX44qy3b+nBFyXGlgV9BaZjYdrmNwTRLDJ8F305JrRKB/+904WZKMuGr5bR/agBxx12sRIeR4FAHjwYOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914571; c=relaxed/simple;
	bh=r6TYTqFwQotruhi73e9osnG5YZSVtIWyB3/MDHVNG88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDX0xyjNebrNZ5Byv3m+pcju9zRiJmRjwQ+5yy/+oLRIuxurtNi2G2lyDKRu/2+6bJrtGq4KHYms0j9/9U7n1zmb1vcs5l/IooBHpATmwTO3twqpOBj1inzmFtOC2HPobFBARRaLPLKuAcM/QHeX3I6ZYhWDJKcxhZWOEuz0P5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 41ECaQmn030022;
	Wed, 14 Feb 2024 06:36:26 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 41ECaO1V030021;
	Wed, 14 Feb 2024 06:36:24 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 14 Feb 2024 06:36:24 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Laight <David.Laight@aculab.com>, Arnd Bergmann <arnd@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty: hvc-iucv: fix function pointer casts
Message-ID: <20240214123624.GB19790@gate.crashing.org>
References: <20240213101756.461701-1-arnd@kernel.org> <20240213191254.GA19790@gate.crashing.org> <57d72e2ccc8245fe99982613a11c461c@AcuMS.aculab.com> <2024021426-unleveled-unhearing-8021@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021426-unleveled-unhearing-8021@gregkh>
User-Agent: Mutt/1.4.2.3i

On Wed, Feb 14, 2024 at 11:37:21AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 14, 2024 at 09:46:33AM +0000, David Laight wrote:
> > From: Segher Boessenkool
> > > Sent: 13 February 2024 19:13
> > > 
> > > On Tue, Feb 13, 2024 at 11:17:49AM +0100, Arnd Bergmann wrote:
> > > > clang warns about explicitly casting between incompatible function
> > > > pointers:
> > > >
> > > > drivers/tty/hvc/hvc_iucv.c:1100:23: error: cast from 'void (*)(const void *)' to 'void (*)(struct
> > > device *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
> > > >  1100 |         priv->dev->release = (void (*)(struct device *)) kfree;
> > > >       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > Such a cast of course is explicitly allowed by 6.3.2.3/8, only calling a
> > > function using a non-compatible type is UB.  This warning message is
> > > quite misleading.  Doubly so because of the -Werror, as always.
> > 
> > But it will get called using the wrong type.
> > And (is it) fine-ibt will reject the incorrect call.
> 
> And rightfully so, this type of casting abuse is just that, abuse.
> 
> Almost no one should be just calling kfree() on a device pointer, I'll
> look at the surrounding code as odds are something odd is going on.  But
> for now, this patch is correct.

Yes, and I said so.  My point is that the warning message pretends the
cast is bad or dangerous.  It is not, similar casts are the only way in
C to do certain things (yes, you can always avoid it completely, by
writing completely different code, like the patch does, and that
sometimes is a better idea even).

But the warning message is misleading and does more damage than it helps
avoid.


Segher

