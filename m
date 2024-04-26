Return-Path: <linux-kernel+bounces-160717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A458B4184
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C781C21397
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE43376E7;
	Fri, 26 Apr 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZKpNuJ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546AA374CC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714168434; cv=none; b=iCrXqmsf1q+m3FVveE9mA+UjHP2AUYmW+0oZFMcgA3tUAXp/5xIsnTlZ4sJytDxB3L1dFml1rJvnKVO9ndx7i2VjbTHBm4e4v2cdscmeOAvt/z8rHxiyvLRx33yVoQ9MNGw2yAwfHccKTo5wdiP7HA4HOysCJxCgfKBXIPpJfho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714168434; c=relaxed/simple;
	bh=JmkU59HQtS7Nf9V3I23Kr43ZjpzMetcH9MCG6rKL23I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbuudPyyq9n1zPxOK7EIaX5rUcTlhB1L3qUHZReUMB4euytj96Ko38WehPkz5PAkIe9/UApFE+seHiS0ZBDv5FDawgEwY2nbwPs2EznL8Flur2oQ7WqJulSo1sCcbrHGJZxU5abrGmTEWYT+IOCAFg0brq+b1PzsDOK+7hWAq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZKpNuJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B45C113CD;
	Fri, 26 Apr 2024 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714168434;
	bh=JmkU59HQtS7Nf9V3I23Kr43ZjpzMetcH9MCG6rKL23I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZKpNuJ7vvkN57xMlCriC/RrwkAnMLBTbGbOTwmtM7QvA5LjMXDNx3ivIPKkWVMFQ
	 UDkMdL2wsxzB7WrOq1m55tv+cx2UXJCmxU6FT6XGxZofQEZ7BAJN+ASYrCljZTeUii
	 JUaaljLuZAA6CgFBQl78jBoFG6lyfM+fpV13umLygKdUTETMvS4UPUNnBIfPRbtzlR
	 /P7BeBu5LRrBrAfiVBfnodi/LhDJI4DBTdYWXi9O2hCZ+l9FbI/iNe0OlIUSSVKbCy
	 7uMXYi6KF2BC4YA6WIAlNm+g/G7Y1qFab0Ym9VgSvjSdjyeW6ImLNr6CuPRXY8gK+C
	 devVKdiJ1RSog==
Date: Fri, 26 Apr 2024 14:53:51 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH 2/9] x86/purgatory: Simplify stack handling
Message-ID: <20240426215351.GA3278657@dev-arch.thelio-3990X>
References: <20240424155309.1719454-11-ardb+git@google.com>
 <20240424155309.1719454-13-ardb+git@google.com>
 <20240424182659.GA2126602@dev-arch.thelio-3990X>
 <pgsqflimo7d2ozhpmdrmscx25mxs5lypcvwq6mgjs7uixsxvsl@5papnq46mwbs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pgsqflimo7d2ozhpmdrmscx25mxs5lypcvwq6mgjs7uixsxvsl@5papnq46mwbs>

On Fri, Apr 26, 2024 at 09:32:52PM +0000, Justin Stitt wrote:
> Hi,
> 
> On Wed, Apr 24, 2024 at 11:26:59AM -0700, Nathan Chancellor wrote:
> > On Wed, Apr 24, 2024 at 05:53:12PM +0200, Ard Biesheuvel wrote:
> > >  arch/x86/purgatory/stack.S        | 18 ------------------
> > 
> > This needs a small fix up to build.
> > 
> >   make[6]: *** No rule to make target 'arch/x86/purgatory/stack.o', needed by 'arch/x86/purgatory/purgatory.ro'.
> > 
> 
> I was trying to reproduce this build failure, but to no avail. I am
> curious what your build target / build command was.
> 
> It is clear that stack.S has been removed so your change makes sense, I
> don't doubt that -- I just cannot get that specific error message you

Odd, I was using my distribution configuration for the test but it is
easily reproducible with allmodconfig:

  $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 allmodconfig arch/x86/purgatory/
  make[6]: *** No rule to make target 'arch/x86/purgatory/stack.o', needed by 'arch/x86/purgatory/purgatory.ro'.
  ...

> encountered (what is a .ro file supposed to be, anyway?).

Read only? Relocatable object? *shrug*

Cheers,
Nathan

