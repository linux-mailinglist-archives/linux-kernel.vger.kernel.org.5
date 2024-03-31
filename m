Return-Path: <linux-kernel+bounces-126116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3BF893261
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5F11C21C75
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1221622079;
	Sun, 31 Mar 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnnxChoe"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59D148FF3;
	Sun, 31 Mar 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900955; cv=fail; b=eX9YnE6oAdwEN6aIhFmRQY517wnZBnPhulfh4hZpakX9fMRGA86wcAVrJGyh2fbRDA6N0i2jcHDuAUfajTpoJW+eNE6J6Aw7flhNgSSaCCvVG6Fzd7MQoPJjP4ZidJfU8DuPhrNaNtEesPcBTCpGbtj1i4nUY/tz/kcD9hfBHRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900955; c=relaxed/simple;
	bh=YVgu6j1j0isPy4AXtAhtK7ZyY09vAr2lZa5WjLrIggg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHlvYphSgL8SLMom2Nx8t7w/b23opQaSpHY946F8/Ta9A1SDweEhM71mc1/IaQPg/E78yyqtqMipGnt2qEr9VO922MdRU0fuFuVBeW5Wpw+3l7IHTRh0zwX2fX23D2enZO3k/tx+o7l3Y0rQdycvzvYSoUJ/WKEu9P8djTP3Wc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnnxChoe reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E7DDC208C1;
	Sun, 31 Mar 2024 18:02:29 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Th7h4OmXf2nO; Sun, 31 Mar 2024 18:02:28 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 017DB2082B;
	Sun, 31 Mar 2024 18:02:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 017DB2082B
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id E92CC800055;
	Sun, 31 Mar 2024 18:02:27 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:02:27 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:47 +0000
X-sender: <linux-kernel+bounces-125915-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAxmBrGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAIYAAADmigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 20102
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125915-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D77EB20882
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711846127; cv=none; b=BZKqmTrdl/RN0V2FsGHWhIP578b9eDgzTT5Fk0PkW/O4wMO8zMJpx3mkUnaNVQURJUmyBpqFGLvg1D4lvDHMq6T2qJM8IBceiGw3yneAT31L0Cg4UYPSv0ZNwOt/inMG8Mj5xys3VjNbkH5Ivlm+GzopgHK7JVWqahwQASY5yy4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711846127; c=relaxed/simple;
	bh=5R/y/M+p05y5G7U6Q0i8lhl8d1NWN6ZRPceQTVGsVrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S622OIFwgXW/vLRK1N/i7M0+QXecyfPK2oSHoe8TBkMRMRCieJ7jSF/eKf5/sY1488lSTdHzW2rbjJbSOzIOjZwkaJLP2WFc7Xy8mn7G/e8c7YSnIyXhsVUQQgJz9cgAHbCmG1DvPpP/bvW2so8c/XOw6Tppt4EbNqYdPeBPuKg=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnnxChoe; arc=none smtp.client-ip=10.30.226.201
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <087bbfcf95c9014ee8f87d482773244f0833b892.camel@HansenPartnership.com>
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sat, Mar 30, 2024 at 09:09:51AM -0400, James Bottomley wrote:
> On Sat, 2024-03-30 at 00:04 -0700, Eric Biggers wrote:
> > [+Cc linux-crypto]
> >=20
> > On Sat, Mar 30, 2024 at 02:55:06PM +0800, Zhang Yiqun wrote:
> > > This patch is to introduce ECDH into keyctl syscall for
> > > userspace usage, containing public key generation and
> > > shared secret computation.
> > >=20
> > > It is mainly based on dh code, so it has the same condition
> > > to the input which only user keys is supported. The output
> > > result is storing into the buffer with the provided length.
> > >=20
> > > Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
> > > ---
> > > =A0Documentation/security/keys/core.rst |=A0 62 ++++++
> > > =A0include/linux/compat.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0=A0 4 +
> > > =A0include/uapi/linux/keyctl.h=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 11 +
> > > =A0security/keys/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 |=A0 12 +
> > > =A0security/keys/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0=A0 2 +
> > > =A0security/keys/compat_ecdh.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 50 +++=
++
> > > =A0security/keys/ecdh.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 | 318
> > > +++++++++++++++++++++++++++
> > > =A0security/keys/internal.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 =
44 ++++
> > > =A0security/keys/keyctl.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0 10 +
> > > =A09 files changed, 513 insertions(+)
> > > =A0create mode 100644 security/keys/compat_ecdh.c
> > > =A0create mode 100644 security/keys/ecdh.c
> >=20
> > Nacked-by: Eric Biggers <ebiggers@google.com>
> >=20
> > The existing KEYCTL_PKEY_*, KEYCTL_DH_COMPUTE, and AF_ALG are causing
> > enough problems.=A0 We do not need any more UAPIs like this.=A0 They ar=
e
> > hard to maintain, break often, not properly documented, increase the
> > kernel's attack surface, and what they do is better done in
> > userspace.
>=20
> Actually that's not entirely true.  There is a use case for keys which
> is where you'd like to harden unwrapped key handling and don't have the
> ability to use a device.  The kernel provides a harder exfiltration
> environment than user space, so there is a use case for getting the
> kernel to handle operations on unwrapped keys for the protection it
> affords the crytpographic key material.
>=20
> For instance there are people who use the kernel keyring to replace
> ssh-agent and thus *reduce* the attack surface they have for storing
> ssh keys:
>=20
> https://blog.cloudflare.com/the-linux-kernel-key-retention-service-and-wh=
y-you-should-use-it-in-your-next-application/
>=20
> The same thing could be done with gpg keys or the gnome keyring.

First, that blog post never actually said that the "replace ssh-agent with
kernel keyrings" idea was deployed.  It sounds like a proof of concept idea=
 that
someone thought was interesting and decided to blog about.  Upstream OpenSS=
H has
no support for Linux keyrings.  It seems unlikely it would get added, espec=
ially
given the OpenSSH developers' healthy skepticism of using broken Linux-isms=
.
You're welcome to bring it up on openssh-unix-dev and get their buy-in firs=
t.

Second, as mentioned by the blog post, the kernel also does not support pri=
vate
keys in the default OpenSSH format.  That sort of thing is an example of th=
e
fundamental problem with trying to make the kernel support every cryptograp=
hic
protocol and format in existence.  Userspace simply has much more flexibili=
ty to
implement whatever it happens to need.

Third, ssh-agent is already a separate process, and like any other process =
the
kernel enforces isolation of its address space.  The potential loopholes ar=
e
ptrace and coredumps, which ssh-agent already disables, except for ptrace b=
y
root which it can't do alone, but the system administrator can do that by
setting the ptrace_scope sysctl to 3 or by using SELinux.

Amusingly, the existing KEYCTL_DH_* APIs, and the KEYCTL_ECDH_* APIs propos=
ed by
this patch, only operate on user keys that the process has READ access to. =
 This
means that the keys can be trivially extracted by a shell script running in=
 your
user session.  That's *less* secure than using an isolated process...

That's not to mention that merging this will likely add vulnerabilities
reachable by unprivileged users, just as the original KEYCTL_DH_* did.  I h=
ad to
fix some of them last time around (e.g. commits 12d41a023efb, bbe240454d86,
3619dec5103d, 1d9ddde12e3c, ccd9888f14a8, 199512b1234f).  I don't really fe=
el
like doing it again. (Wait, was this supposed to *improve* security?)

> > Please refer to the recent thread
> > https://lore.kernel.org/linux-crypto/CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.=
cz/T/#u
> > where these issues were discussed in detail.
>=20
> This thread was talking about using the kernel for handling the
> algorithms themselves (which is probably best done in userspace) and
> didn't address using the kernel to harden the key protection
> environment.

This patch is about using the kernel to handle a class of algorithm,
Elliptic-Curve Diffie-Hellman.  Which specific algorithm in that class (i.e=
.
which elliptic curve), who knows.  Just like the existing APIs like this, i=
t's
undocumented which algorithm(s) are actually supported.

- Eric


