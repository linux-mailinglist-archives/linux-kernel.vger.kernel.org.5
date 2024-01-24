Return-Path: <linux-kernel+bounces-36808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EBF83A713
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D3A1C21D49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D601B26E;
	Wed, 24 Jan 2024 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="g3YnBGJc"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A31AACF;
	Wed, 24 Jan 2024 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092988; cv=none; b=OEu8pxl1t7Fn4mz/QxkU+f75iESiiEN/pl9o/GR9bvq/SaIDRFoK1LtelXnNC2fFSNFpY1Sfx2Mo11Wpzh9iMsbZbdHLBbERs+jGdjIUIXGwYTnhLoeGMyJ4lDJjZhdiEmpkqpTeDDA/eKoUdYgLSyLiubg2kvgfDr8woXCr9vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092988; c=relaxed/simple;
	bh=tFO9N8l/2OmrITVJ+vRPW1z9XlwVNvQOqgrof22Fl8o=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=B5l42xF2BCCYpO8+VN1c2CHEQcuIc4AnXSfL8pbeXWoEMsDcyFJaMmWg/Nm1rnfNae6WbPUPy8Z8oxK87PV7aD4OoMXMWokHdQaqxrM4Qo68myUgN2HRB9WuON8wXs6j8nzvjb31gLbVqRU5x/YtCb5Gow7Vcd1Q25UyLnvgFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=g3YnBGJc; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1706092979;
	bh=tFO9N8l/2OmrITVJ+vRPW1z9XlwVNvQOqgrof22Fl8o=;
	h=Subject:From:To:Cc:Date:From;
	b=g3YnBGJcjj+JuzPYUXQs+EJC9VQBwxMFtwis6scpLRSArQDHmmDy2mo2ir4qnhtEY
	 xbxRIkLGjDeTEk4lS/pjt+3t2G7ibDo68MrO2E3m8iIPzn3Y/PatuR62UT1T7qDPHi
	 JjPP5fZPtg1XIBY+KDO0RKps9jZCdQgpVokF/774=
Received: from [IPv6:2408:8471:101c:6a2e:1fb0:74c0:f402:1b17] (unknown [IPv6:2408:8471:101c:6a2e:1fb0:74c0:f402:1b17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 87AE566F94;
	Wed, 24 Jan 2024 05:42:55 -0500 (EST)
Message-ID: <75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site>
Subject: Strange EFAULT on mips64el returned by syscall when another thread
 is forking
From: Xi Ruoyao <xry111@xry111.site>
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, libc-alpha@sourceware.org
Date: Wed, 24 Jan 2024 18:42:30 +0800
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

Hi,

When I'm testing Glibc master branch for upcoming 2.39 release, I
noticed an alarming test failure on mips64el:

FAIL: stdlib/tst-arc4random-thread

I've gathered some info about it and pasted my findings into
https://sourceware.org/glibc/wiki/Testing/Tests/stdlib/tst-arc4random-threa=
d.

Finally I was able to reduce the test case into:

#include <stdlib.h>
#include <errno.h>
#include <pthread.h>
#include <unistd.h>
#include <fcntl.h>

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
      if (!fork ())
	_exit (0);
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

When running this on the mainline kernel (revision 6.8.0-rc1+-
g7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf) it fails in milliseconds.=20
Some "interesting" aspects:

1. This is related to the size parameter passed to read ().  When it's
less than 8 it fails, but when it's 8 or greater there is no failure.
2. This is not related to if "buf" is initialized or not.

Now I'm suspecting this might be a kernel bug.  Any pointer to further
triage?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

