Return-Path: <linux-kernel+bounces-4676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBEF818083
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BFAC2825D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C5915EBF;
	Tue, 19 Dec 2023 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IvABewiw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868FB15E8E;
	Tue, 19 Dec 2023 04:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702959947;
	bh=/GodJswsfgqvQ6EUOQlKVjRhHjooClJBbxpLEL4Lp+c=;
	h=Date:From:To:Cc:Subject:From;
	b=IvABewiwU7VR3DEmYN/Ikix6Z2lpm4HxYo24jIZ4XwYpsVntKAmgxrCXIEC6gkW83
	 vcbxb5xahivU6aseKKw8QESs7rIdhIWkT2a5LMREDo416bYir11e2AWgu4CUa1l88/
	 rJL4HdK+IVRVhVLLE3ArKBEsQ6zqLyMAd2i4suqowFI4gWhj5XUy1qSeGGVA09PJak
	 /o4yk4JO/uAbsd7aQEY+PjVIuj9WoNbm84AjJOoy7/h5Vt74/pZlALwHKInyUra6lv
	 /hpOMgRW35KvX4ImCgtJZQFQ4NhJvFdRqaWk2tua/Mae9OFE1FrlC9sz9Y8K9bDxF8
	 /5nz6lQL7iKMA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvNsl35Yqz4wx5;
	Tue, 19 Dec 2023 15:25:47 +1100 (AEDT)
Date: Tue, 19 Dec 2023 15:25:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the header_cleanup tree
Message-ID: <20231219152545.54ac44cd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RGIQnRG2=vNVQrSH7Ep8Adi";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/RGIQnRG2=vNVQrSH7Ep8Adi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the header_cleanup tree, today's linux-next build (s390
defconfig) failed like this:

arch/s390/kernel/signal.c: In function 'arch_do_signal_or_restart':
arch/s390/kernel/signal.c:491:17: error: implicit declaration of function '=
rseq_signal_deliver' [-Werror=3Dimplicit-function-declaration]
  491 |                 rseq_signal_deliver(&ksig, regs);
      |                 ^~~~~~~~~~~~~~~~~~~

Presumably caused by commit

  cd1146fc0ad3 ("rseq: Split out rseq.h from sched.h")

I have applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 19 Dec 2023 15:19:02 +1100
Subject: [PATCH] fixup for s390 and "rseq: Split out rseq.h from sched.h"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/s390/kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 27bcc43fe1b7..43e9661cd715 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -12,6 +12,7 @@
=20
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
+#include <linux/rseq.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/kernel.h>
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/RGIQnRG2=vNVQrSH7Ep8Adi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWBG0kACgkQAVBC80lX
0Gy2lQf+PYLqj1egA7gvBit6/aroG/tphR/VlMKW84xwkx6kSJCwFX03w5cXRCLI
r7QtWvXpidvm8Fnle75l4w/YkWj0K9TSN5yMtqdrFNHafq8X3SXiw4otzBjRTEL/
tp5/7JVlga9mVcVjnAjlL+jfMzxIKmzslYwQlnlAfvZmGyapK9YgXOiqULtkk2RM
n7KhZyfCNeNK2cNpHqDB1NPFY8WccG4uTN6asaBKqrZhFeDLHzy6TjvvfZmHZROb
PHHuhf+mKaubsdQprHcM7WL1A24LwS1RD6jJ/K1CQcLh7qITX/OrZsVdy0Xjmguw
W40wX4rgCvquHzkCARhu3QgD0KirlA==
=Qt8u
-----END PGP SIGNATURE-----

--Sig_/RGIQnRG2=vNVQrSH7Ep8Adi--

