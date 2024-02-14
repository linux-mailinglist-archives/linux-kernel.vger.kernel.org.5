Return-Path: <linux-kernel+bounces-65058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B20C85473D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E45E1F225A8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D96417C9E;
	Wed, 14 Feb 2024 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yAdiU5Zg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA0E125BB;
	Wed, 14 Feb 2024 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907047; cv=none; b=bTRo9GTU+RLjkYHba3euREYkI96DixXRqYP3STquxBq5FdKJ9ftgF1V32g5NhsZHvfnEj0Fmc9GSHc23D1tbd2MhiDzaw27RoZnLycAadVOPrrP+rQWTxn5MWs8y1iDCKzZovVgMErIJPrZYDRrKg8V3RlrdtQgYQi10nAcvNVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907047; c=relaxed/simple;
	bh=cxED5YPWgHhSBwJHo1owowGzFn88/peBM/syHypcwGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns2VxVzMelhJnu2YVdiIs1c+0y+EJpqcEEtHJ7E+DuuYUy0jCOIJjVsswlweCwxDzp7qbSMXkS7+H8y/TQB6RQYLx+hPmMi6TxEYoN/jf3yxtG+yzaUwIOu/XwvA3pFH+/COt0qJKkvFyozH3EE2TcEI2DEj+YU7DnyD2BpYAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yAdiU5Zg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C309C433F1;
	Wed, 14 Feb 2024 10:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707907047;
	bh=cxED5YPWgHhSBwJHo1owowGzFn88/peBM/syHypcwGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yAdiU5ZgI53hqY9FwXIbYtEU1neJBgYWFVbQJYJQwKXuydESuXEAkxtgQ1Doj7u+i
	 cWtV6GEl8rnlmooZ4HfX5YgYMbwAoMxyqATdC1vH4siqe7TubRvZGjMd0jFL5pEv2P
	 BM0MlKnjrrgvHqS9R/ysZy5aq4ai9YmWWeaP6ePU=
Date: Wed, 14 Feb 2024 11:37:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Laight <David.Laight@aculab.com>
Cc: 'Segher Boessenkool' <segher@kernel.crashing.org>,
	Arnd Bergmann <arnd@kernel.org>,
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
Message-ID: <2024021426-unleveled-unhearing-8021@gregkh>
References: <20240213101756.461701-1-arnd@kernel.org>
 <20240213191254.GA19790@gate.crashing.org>
 <57d72e2ccc8245fe99982613a11c461c@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57d72e2ccc8245fe99982613a11c461c@AcuMS.aculab.com>

On Wed, Feb 14, 2024 at 09:46:33AM +0000, David Laight wrote:
> From: Segher Boessenkool
> > Sent: 13 February 2024 19:13
> > 
> > On Tue, Feb 13, 2024 at 11:17:49AM +0100, Arnd Bergmann wrote:
> > > clang warns about explicitly casting between incompatible function
> > > pointers:
> > >
> > > drivers/tty/hvc/hvc_iucv.c:1100:23: error: cast from 'void (*)(const void *)' to 'void (*)(struct
> > device *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
> > >  1100 |         priv->dev->release = (void (*)(struct device *)) kfree;
> > >       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Such a cast of course is explicitly allowed by 6.3.2.3/8, only calling a
> > function using a non-compatible type is UB.  This warning message is
> > quite misleading.  Doubly so because of the -Werror, as always.
> 
> But it will get called using the wrong type.
> And (is it) fine-ibt will reject the incorrect call.

And rightfully so, this type of casting abuse is just that, abuse.

Almost no one should be just calling kfree() on a device pointer, I'll
look at the surrounding code as odds are something odd is going on.  But
for now, this patch is correct.

thanks,

greg k-h

