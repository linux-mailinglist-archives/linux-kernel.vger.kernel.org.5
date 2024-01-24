Return-Path: <linux-kernel+bounces-37697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B3583B3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0B4286B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF37135401;
	Wed, 24 Jan 2024 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="jmoWAk0q"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF6613540E;
	Wed, 24 Jan 2024 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131987; cv=none; b=X1q/k8WcY1nHaqOAcaF6blAPNTv/kHNNYDDgVKNr4rXmWIakTudIsYw6r78nmFmPKYJFQA1ttUelGgQtTY1BBkFfD+abRH0N87y2tJJRuMfdUxjHigyaKrXLbXUmKP/llmVdJD0c09wpkXHhqmkXsQS7hVyHQgUvILBmPpgM8uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131987; c=relaxed/simple;
	bh=ziTHwcQqcapg3pVzdE+ZardjAdUN8XTv3xGQCPYdaz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lNjXWAwWHjSbdmwDI01Q65lh9X9f6rxExYoui5O3Z1Mq+eWeoVNSa4OIJPilQunS282tTbiF6cRo895g7qWZuO/joxOhL2p9STvdlvngI+ZxmROy88oSmQFXN7MdA+t4VW5jdxd9kcVShQa8BwrPZJScykebw6KZ1eKGRcPPahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=jmoWAk0q; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1706131982;
	bh=ziTHwcQqcapg3pVzdE+ZardjAdUN8XTv3xGQCPYdaz4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jmoWAk0qhYPXnrmgEfpUhBIlc9h6qrS2t4yfbrlqa4zq9d2UhFbys18mSH7qZcRsI
	 JzjseQtUzh4MjZZM/bdv10PK5EKZ32QN23xv9KDGZ/og2yUnlR/4Wsw5X8uk99DuKP
	 teJsIFsYgSBB6Bt7d6KvF/fCL++xh0VnHxIQpzkk=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 08FDE66A79;
	Wed, 24 Jan 2024 16:33:00 -0500 (EST)
Message-ID: <e8583a3ab0522b4e75ba0ada47b6f093b186fa81.camel@xry111.site>
Subject: Re: Strange EFAULT on mips64el returned by syscall when another
 thread is forking
From: Xi Ruoyao <xry111@xry111.site>
To: Andreas Schwab <schwab@suse.de>, Ben Hutchings <ben@decadent.org.uk>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
  libc-alpha@sourceware.org, Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jan 2024 05:32:59 +0800
In-Reply-To: <0be1203c9df55432548c92281c8392dfa2f7d6bf.camel@xry111.site>
References: <75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site>
	 <mvmplxraqmd.fsf@suse.de>
	 <9481b6d9d015aea25d8f2563bf7bd6f6462f758f.camel@xry111.site>
	 <0be1203c9df55432548c92281c8392dfa2f7d6bf.camel@xry111.site>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 00:13 +0800, Xi Ruoyao wrote:
> On Wed, 2024-01-24 at 20:49 +0800, Xi Ruoyao wrote:
> > On Wed, 2024-01-24 at 12:59 +0100, Andreas Schwab wrote:
> > > On Jan 24 2024, Xi Ruoyao wrote:
> > >=20
> > > > Now I'm suspecting this might be a kernel bug.=C2=A0 Any pointer to=
 further
> > > > triage?
> > >=20
> > > Is this a regression?
> >=20
> > Initially I guessed it was perhaps a Glibc regression related to the
> > newly introduced clone3 usage on MIPS, but it fails with Glibc-2.35 too=
.
> >=20
> > Not sure if this is a kernel regression, I'll try different kernels in
> > several hours (once I can physically access the system).
>=20
> Not happening with kernel 5.18.1.=C2=A0 I can do a bisection but it will =
take
> several days, I guess.

Hmm, not so time-consuming as I expected.

4bce37a68ff884e821a02a731897a8119e0c37b7 is the first bad commit
commit 4bce37a68ff884e821a02a731897a8119e0c37b7
Author: Ben Hutchings <ben@decadent.org.uk>
Date:   Thu Jun 22 18:47:40 2023 +0200

    mips/mm: Convert to using lock_mm_and_find_vma()

Re-posting the broken test case for Ben (I also added a waitpid call to
prevent PID exhaustion):

#include <stdlib.h>
#include <errno.h>
#include <pthread.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>

void *
test_thread (void *)
{
  char buf[16] =3D {};
  int fd =3D open("/dev/zero", O_RDONLY);
  while (1)
    {
      ssize_t ret =3D read (fd, buf, 7);
      if (ret =3D=3D -1 && errno =3D=3D EFAULT)
        abort ();
    }
}

void *
fork_thread (void *)
{
  while (1)
    {
      pid_t p =3D fork ();
      if (!p)
        _exit (0);
      waitpid (p, NULL, 0);
    }
}

int
main (void)
{
  pthread_t test_th;
  pthread_t fork_th;

  pthread_create (&test_th, NULL, test_thread, NULL);
  pthread_create (&fork_th, NULL, fork_thread, NULL);
  pthread_join (test_th, NULL);
  pthread_join (fork_th, NULL);
}

and the context where this issue was detected:

https://sourceware.org/glibc/wiki/Testing/Tests/stdlib/tst-arc4random-threa=
d

and the "interesting" aspects:

1. If I change the third parameter of "read" to any value >=3D 8, it no
longer fails.  But it fails with any integer in [1, 8).
2. It fails no matter if I initialize buf.
3. It does not fail on arm64 (the only other port using
lock_mm_and_find_vma I have access to).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

