Return-Path: <linux-kernel+bounces-80428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496A986685D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F6028216B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15711172C;
	Mon, 26 Feb 2024 02:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gnV1TqM1"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BB4C84;
	Mon, 26 Feb 2024 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916046; cv=none; b=JpdX+o5JAs+71P81XfXUnVhqXgvJPJPK8QmOqXRPIanDV6vcRVJ6vsF7Fzehr5iBBJIwb5U9s1u5aAyiLES5NBfVra6I0eDR06YK8KoY+srQvUuT+dPZLxqOwTlXZryzrTA9aPoUDcm2aoakjCcp8pQ0PH1H4PoDy7AGazNepyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916046; c=relaxed/simple;
	bh=ziDPUZ9sKbOLhrgxQX1/6HtN48N+pARDVpqIFpsLSTs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tBrpoRrdRwXS4dlW83pdd7OMwMjdwDCMuIZcEtNHfz0Cym/7U1/Z2VPlIEwv9Ttl1gtbIX7/AWlr1U0payk0Ukm+ZM3hoeeG81R1IGrnlYJacFu3x/2TkEgFOE3ZOh50nTKrVnWQjCT+j/Rt+W/4xCAnq6zlVxU+tpOY/xkiSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=gnV1TqM1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708916040;
	bh=tyx+IVS66RM0qtOBOj8rXQvkKnD2WQxqXMUHmV+Tkcw=;
	h=Date:From:To:Cc:Subject:From;
	b=gnV1TqM1rQwD1FWJt8+iyOz33OJ07fe9Hfz7FxchuYa4pkQAzS816i3E9Hg/89wVI
	 A7A0KeDKCXiI6rY1PLflRRRtzIUbCGOhH285XdCcv/qDKZb2wfkTrTovUpDO01R5wW
	 p/OzBps8zqbNSOJCOCmTXIwiEILvIgYjNj90G+oe0ov11n0LdxWyAaV26jYi+CxpOo
	 fo86MiM9pAOwJ2U6VL2IyiDpSRemzyWKkOeJKruHv5qGC1Qweytg7Dn4izFIMAyl/9
	 Fw8f4PQMdGhtAJn+f+QhlVALQz4xHudObDzJfGw/1Tl6dPLIsCsIHEu402Vi5ZZc71
	 9jKZf6gPSlYLQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TjlYz3kqZz4wc8;
	Mon, 26 Feb 2024 13:53:59 +1100 (AEDT)
Date: Mon, 26 Feb 2024 13:53:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Tejun Heo <tj@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Leonardo Bras
 <leobras@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the workqueues tree
Message-ID: <20240226135357.29ebadf0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2_F7J9oi_gN1uQDw37VMJPH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2_F7J9oi_gN1uQDw37VMJPH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  kernel/workqueue.c

between commit:

  aae17ebb53cd ("workqueue: Avoid using isolated cpus' timers on queue_dela=
yed_work")

from the workqueues tree and commit:

  c0e8c5b59949 ("workqueue: Use global variant for add_timer()")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/workqueue.c
index 65a27be81452,78eaea2e5d72..000000000000
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@@ -2545,18 -1958,10 +2545,18 @@@ static void __queue_delayed_work(int cp
  	dwork->cpu =3D cpu;
  	timer->expires =3D jiffies + delay;
 =20
 -	if (unlikely(cpu !=3D WORK_CPU_UNBOUND))
 +	if (housekeeping_enabled(HK_TYPE_TIMER)) {
 +		/* If the current cpu is a housekeeping cpu, use it. */
 +		cpu =3D smp_processor_id();
 +		if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
 +			cpu =3D housekeeping_any_cpu(HK_TYPE_TIMER);
  		add_timer_on(timer, cpu);
 -	else
 -		add_timer_global(timer);
 +	} else {
 +		if (likely(cpu =3D=3D WORK_CPU_UNBOUND))
- 			add_timer(timer);
++			add_timer_global(timer);
 +		else
 +			add_timer_on(timer, cpu);
 +	}
  }
 =20
  /**

--Sig_/2_F7J9oi_gN1uQDw37VMJPH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXb/UUACgkQAVBC80lX
0GzrJAgAkdLl0SzaagaYHZA1abwu1d8ZoGOk+YhSXWESByQMWQAZMnu8R6uAYxIY
AGod47N3uzCYiOHcLG13YIBqRoKl4v+gb97IUpr46L6vUpyUu7WPGGo0sARUueDA
UDIXtXWTMqBjwMFOHhg1yY3nk71SAcgJBqzMho2WTR+zQ9WvANksJWu37vcbh8im
wVNus5cHj8hfiF+CVYwbWrjxIf67N/f7y0K3m8igr6PAMOm8sYl53xpQVW+uGc8U
0fJQDPKbVSDv/ubY1n8P/7AIwIvtsbEiKWJF1hRlh0bUcRz++NLqpYiX0M4DEOd6
NLmlWypeOd7Eg7kLURWWWxE+c4bBXQ==
=hPa/
-----END PGP SIGNATURE-----

--Sig_/2_F7J9oi_gN1uQDw37VMJPH--

