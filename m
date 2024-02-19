Return-Path: <linux-kernel+bounces-71093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2603585A089
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5ED6283386
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA3725601;
	Mon, 19 Feb 2024 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F5Zy+6n7"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F8F2556D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337337; cv=none; b=jSsePPwXVTfCD25Dq39mJ9i5wu35qsPQ4UR+IU9IucwKAeHwOaUgAe7bxM9Th4i7jnOj0NraPSgQe6QccxavCD8IuKGJ5dv+YnhYGRZ4lpOdVZ7uZqVbmliBGWADF4LQvde59goO+zHA+GjmRLnjPCGrgXJoMq6X9EA9rEq1suE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337337; c=relaxed/simple;
	bh=vQNnQ4Oebk7hlN/YUyaGGRGNwcnydncgUc66GmV4vZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJR2CHWj+I3hFhLbJ87BSkHn2oPVLArAM/1I2aXQ/s3ppBmOSzDcPJtbYzni+MpmUCnlL+zq3Qt9spoYAI9LeHdFZa8Z0AIM/Dv7LwsyVSSq+LyuNzWhQLibETJ00oUkRKZN2m0s1BuYDCB6MKIamBBOgDVuxTtdrmwjhymu34c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F5Zy+6n7; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 19 Feb 2024 05:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708337333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gxk0e3O8bT35FXZWS3vzdrhUbpsNOT2IUQee273pX60=;
	b=F5Zy+6n7EjnaPhEATMbDMZb5PZViND3IvBazodlaJi0okQpudTUQN1qmmJv0dsIVK5Qakj
	I7p98xtN/bT0MSgz6QAVqVY9LJUhh0p8Ravgn2RHxv1h36IjTKgop/F5FYgHnX+A+eIAls
	r7R3dhV9kjO1bamTOGP2oaMivrTWiAA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, 
	Calvin Owens <jcalvinowens@gmail.com>, Dave Martin <Dave.Martin@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>
Subject: Re: [PATCH] arm: Silence gcc warnings about arch ABI drift
Message-ID: <a5afnvgygh3nk34oqiaq7cj5mqbbnz2vaokpsz2mmv6kqo76bd@4744h2x4zsvm>
References: <fe51512baa18e1480ce997fc535813ce6a0b0721.1708286962.git.jcalvinowens@gmail.com>
 <431dd956-ad31-4da8-ad42-34f7380824bb@app.fastmail.com>
 <ZdMe24xN1Ej4QoVU@shell.armlinux.org.uk>
 <xs2splnjhlj257uca5yae64fp4solc4ugbxrkczoyd75n42r66@42boyzdcmyj4>
 <7299839b-06e6-40eb-8024-93ed5f9b733f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7299839b-06e6-40eb-8024-93ed5f9b733f@app.fastmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 19, 2024 at 10:57:46AM +0100, Arnd Bergmann wrote:
> On Mon, Feb 19, 2024, at 10:40, Kent Overstreet wrote:
> > On Mon, Feb 19, 2024 at 09:26:51AM +0000, Russell King (Oracle) wrote:
> >> On Mon, Feb 19, 2024 at 07:21:11AM +0100, Arnd Bergmann wrote:
> >> 
> >> +1 - bcachefs definitely needs fixing. Passing all that as an argument
> >> not only means that it has to be read into registers, but also when
> >> accessing members, it has to be extracted from those registers as well.
> >> 
> >> Passing that by argument is utterly insane.
> >
> > If the compiler people can't figure out a vaguely efficient way to pass
> > a small struct by value, that's their problem - from the way you
> > describe it, I have to wonder at what insanity is going on there.
> 
> On most ABIs, there are only six argument registers (24 bytes)
> for function calls. The compiler has very little choice here if
> it tries to pass 32 bytes worth of data.
> 
> On both x86_64 and arm64, there are theoretically enough
> registers to pass the data, but kernel disallows using the
> vector and floating point registers for passing large
> compounds arguments.
> 
> The integer registers on x86 apparently allow passing compounds
> up to 16 bytes, but only if all members are naturally aligned.
> Since you have both __packed members and bitfields, the compiler
> would not even be allowed to pass the structure efficiently
> even if it was small enough.

from an efficiency pov, the thing that matters is whether the
compiler is going to emit a call to memcpy (bad) or inline the copy -
and also whether the compiler can elide the copy if the variable is
never modified in the callee.

if were passing by reference it's also going to be living on the stack,
not registers.

