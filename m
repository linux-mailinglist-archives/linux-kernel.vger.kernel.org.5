Return-Path: <linux-kernel+bounces-125915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D661892E28
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 01:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F9B1C20C10
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 00:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2210E6;
	Sun, 31 Mar 2024 00:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnnxChoe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35546383;
	Sun, 31 Mar 2024 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711846127; cv=none; b=BZKqmTrdl/RN0V2FsGHWhIP578b9eDgzTT5Fk0PkW/O4wMO8zMJpx3mkUnaNVQURJUmyBpqFGLvg1D4lvDHMq6T2qJM8IBceiGw3yneAT31L0Cg4UYPSv0ZNwOt/inMG8Mj5xys3VjNbkH5Ivlm+GzopgHK7JVWqahwQASY5yy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711846127; c=relaxed/simple;
	bh=5R/y/M+p05y5G7U6Q0i8lhl8d1NWN6ZRPceQTVGsVrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S622OIFwgXW/vLRK1N/i7M0+QXecyfPK2oSHoe8TBkMRMRCieJ7jSF/eKf5/sY1488lSTdHzW2rbjJbSOzIOjZwkaJLP2WFc7Xy8mn7G/e8c7YSnIyXhsVUQQgJz9cgAHbCmG1DvPpP/bvW2so8c/XOw6Tppt4EbNqYdPeBPuKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnnxChoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A51C433C7;
	Sun, 31 Mar 2024 00:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711846126;
	bh=5R/y/M+p05y5G7U6Q0i8lhl8d1NWN6ZRPceQTVGsVrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnnxChoe6PD0c253FzpqzrGbGakgdwsrko83C1NyXCjMlc/PkIYrqVejJGzJnRubB
	 SLh08seHoHgJPf+qCjJqbfUC5LZS3KmneiZh/vCoGOPs9LPhZFp5mRnRTKzAjHQOVw
	 G/Qnzd/pDbFPQBIBcBVgBp0Ev0HUtGqAt1a+lCPHKpuE4GXTrs2IFjjKGYd+BqYjjR
	 ixOvthPzaXJ0azrzgMB/UozGCbk2SPB3SpOVWfe0H7eHgF3u8HoH/36lYd8Vp+FFMl
	 trrs/8GeDhb6fOZFacgfmEzzuYVsjcsBiFUMyvUyyrujhffg/T0MHmMiChmiDDkww6
	 Q7QKPIw9ue+Gg==
Date: Sat, 30 Mar 2024 17:48:44 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Zhang Yiqun <zhangyiqun@phytium.com.cn>, dhowells@redhat.com,
	jarkko@kernel.org, corbet@lwn.net, keyrings@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH] KEYS: Add ECDH support
Message-ID: <20240331004844.GA104623@sol.localdomain>
References: <20240330065506.3146-1-zhangyiqun@phytium.com.cn>
 <20240330070436.GA2116@sol.localdomain>
 <087bbfcf95c9014ee8f87d482773244f0833b892.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <087bbfcf95c9014ee8f87d482773244f0833b892.camel@HansenPartnership.com>

On Sat, Mar 30, 2024 at 09:09:51AM -0400, James Bottomley wrote:
> On Sat, 2024-03-30 at 00:04 -0700, Eric Biggers wrote:
> > [+Cc linux-crypto]
> > 
> > On Sat, Mar 30, 2024 at 02:55:06PM +0800, Zhang Yiqun wrote:
> > > This patch is to introduce ECDH into keyctl syscall for
> > > userspace usage, containing public key generation and
> > > shared secret computation.
> > > 
> > > It is mainly based on dh code, so it has the same condition
> > > to the input which only user keys is supported. The output
> > > result is storing into the buffer with the provided length.
> > > 
> > > Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
> > > ---
> > >  Documentation/security/keys/core.rst |  62 ++++++
> > >  include/linux/compat.h               |   4 +
> > >  include/uapi/linux/keyctl.h          |  11 +
> > >  security/keys/Kconfig                |  12 +
> > >  security/keys/Makefile               |   2 +
> > >  security/keys/compat_ecdh.c          |  50 +++++
> > >  security/keys/ecdh.c                 | 318
> > > +++++++++++++++++++++++++++
> > >  security/keys/internal.h             |  44 ++++
> > >  security/keys/keyctl.c               |  10 +
> > >  9 files changed, 513 insertions(+)
> > >  create mode 100644 security/keys/compat_ecdh.c
> > >  create mode 100644 security/keys/ecdh.c
> > 
> > Nacked-by: Eric Biggers <ebiggers@google.com>
> > 
> > The existing KEYCTL_PKEY_*, KEYCTL_DH_COMPUTE, and AF_ALG are causing
> > enough problems.  We do not need any more UAPIs like this.  They are
> > hard to maintain, break often, not properly documented, increase the
> > kernel's attack surface, and what they do is better done in
> > userspace.
> 
> Actually that's not entirely true.  There is a use case for keys which
> is where you'd like to harden unwrapped key handling and don't have the
> ability to use a device.  The kernel provides a harder exfiltration
> environment than user space, so there is a use case for getting the
> kernel to handle operations on unwrapped keys for the protection it
> affords the crytpographic key material.
> 
> For instance there are people who use the kernel keyring to replace
> ssh-agent and thus *reduce* the attack surface they have for storing
> ssh keys:
> 
> https://blog.cloudflare.com/the-linux-kernel-key-retention-service-and-why-you-should-use-it-in-your-next-application/
> 
> The same thing could be done with gpg keys or the gnome keyring.

First, that blog post never actually said that the "replace ssh-agent with
kernel keyrings" idea was deployed.  It sounds like a proof of concept idea that
someone thought was interesting and decided to blog about.  Upstream OpenSSH has
no support for Linux keyrings.  It seems unlikely it would get added, especially
given the OpenSSH developers' healthy skepticism of using broken Linux-isms.
You're welcome to bring it up on openssh-unix-dev and get their buy-in first.

Second, as mentioned by the blog post, the kernel also does not support private
keys in the default OpenSSH format.  That sort of thing is an example of the
fundamental problem with trying to make the kernel support every cryptographic
protocol and format in existence.  Userspace simply has much more flexibility to
implement whatever it happens to need.

Third, ssh-agent is already a separate process, and like any other process the
kernel enforces isolation of its address space.  The potential loopholes are
ptrace and coredumps, which ssh-agent already disables, except for ptrace by
root which it can't do alone, but the system administrator can do that by
setting the ptrace_scope sysctl to 3 or by using SELinux.

Amusingly, the existing KEYCTL_DH_* APIs, and the KEYCTL_ECDH_* APIs proposed by
this patch, only operate on user keys that the process has READ access to.  This
means that the keys can be trivially extracted by a shell script running in your
user session.  That's *less* secure than using an isolated process...

That's not to mention that merging this will likely add vulnerabilities
reachable by unprivileged users, just as the original KEYCTL_DH_* did.  I had to
fix some of them last time around (e.g. commits 12d41a023efb, bbe240454d86,
3619dec5103d, 1d9ddde12e3c, ccd9888f14a8, 199512b1234f).  I don't really feel
like doing it again. (Wait, was this supposed to *improve* security?)

> > Please refer to the recent thread
> > https://lore.kernel.org/linux-crypto/CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz/T/#u
> > where these issues were discussed in detail.
> 
> This thread was talking about using the kernel for handling the
> algorithms themselves (which is probably best done in userspace) and
> didn't address using the kernel to harden the key protection
> environment.

This patch is about using the kernel to handle a class of algorithm,
Elliptic-Curve Diffie-Hellman.  Which specific algorithm in that class (i.e.
which elliptic curve), who knows.  Just like the existing APIs like this, it's
undocumented which algorithm(s) are actually supported.

- Eric

