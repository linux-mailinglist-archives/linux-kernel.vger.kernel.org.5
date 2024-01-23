Return-Path: <linux-kernel+bounces-34613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A3F838346
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7842F290425
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FC160DCB;
	Tue, 23 Jan 2024 01:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nw024Zjw"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5060BBD;
	Tue, 23 Jan 2024 01:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974757; cv=none; b=GVe0qPtVAxlRF376zfcje7PVQmWuPU7VjMblZwveANxG0d/BRmQpes7d6ZwLxLl/15th3xhe8HPQ7/m1D/JF330ja/LDx3T2h1JwleruRDan/7nI71rl+HuqUif2pDTBfmmyweZ3aQh1xV16dRrPdEkIAV2JQOBRraRnlwiGnqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974757; c=relaxed/simple;
	bh=8u0AgQw2OqnO0fPDfMvidyN8sk5sZzKAvfBOInESfwI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AB3e5OmqZ/lZfvuLvDB2N/7kCRBCJZekK2/GPf+cfM2PAJtRP77biw5PZCU7uWJ7tRv599sFHbflEa/7ImOwlwdhNdIJ+KICh2mEatPdxvSQfh9OgnBIk/CE7O04WmNMpP6yToT/R6OcnbMcA/fWTSz9MqSuHX9zSaJryeDd23w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nw024Zjw; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705974752;
	bh=p4hRPKTKLs19pGw1tsRGHFw3u8tWxyLxRDhe/WLRu8o=;
	h=Date:From:To:Cc:Subject:From;
	b=nw024ZjwreNqT3lbQ1YINKu+7B3nesrH5scQbmofdzQFHQO7rMRWMZRnXjWha43Mp
	 fA46Z4algPtQu9EXvAjilKYlEG3mgSfxY0Yx/ISi718HcqjTsZ+z9/7Pfar6OAFRvr
	 MVSPGHKm4nBmVzUxSTAocGTU+dKUPwVMyZDld6d5KodF0JPl9YAEGKAAlmhbZPAT9I
	 +g2vb3gN7/+Qmyyikf4b/eAwKV1Ztq6JKmxzH8ngobPaceJp6nA/AQTlbyaDoi3cAV
	 gmSaCq3dHQ98WbOIoI6K/j93Qf1s59l5+uNBL75FXq1fyN94360Sap/GJFk8/gVdTA
	 BDZ/UoPjtwUkQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TJqpl3Ls9z4xc5;
	Tue, 23 Jan 2024 12:52:31 +1100 (AEDT)
Date: Tue, 23 Jan 2024 12:52:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: Baokun Li <libaokun1@huawei.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20240123125227.0521c8d9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wwEr_+0bHO.BR4FXWEX7H1T";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/wwEr_+0bHO.BR4FXWEX7H1T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (powerpc
allnoconfig) failed like this:

In file included from <command-line>:
In function 'i_size_read',
    inlined from '__iomap_dio_rw' at fs/iomap/direct-io.c:570:16:
include/linux/compiler_types.h:435:45: error: call to '__compiletime_assert=
_229' declared with attribute error: Need native word sized stores/loads fo=
r atomicity.
  435 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
include/linux/compiler_types.h:416:25: note: in definition of macro '__comp=
iletime_assert'
  416 |                         prefix ## suffix();                        =
     \
      |                         ^~~~~~
include/linux/compiler_types.h:435:9: note: in expansion of macro '_compile=
time_assert'
  435 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/compiler_types.h:438:9: note: in expansion of macro 'compilet=
ime_assert'
  438 |         compiletime_assert(__native_word(t),                       =
     \
      |         ^~~~~~~~~~~~~~~~~~
include/asm-generic/barrier.h:206:9: note: in expansion of macro 'compileti=
me_assert_atomic_type'
  206 |         compiletime_assert_atomic_type(*p);                        =
     \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/fs.h:911:16: note: in expansion of macro 'smp_load_acquire'
  911 |         return smp_load_acquire(&inode->i_size);
      |                ^~~~~~~~~~~~~~~~

Caused by commit

  4bbd51d0f0ad ("fs: make the i_size_read/write helpers be smp_load_acquire=
/store_release()")

I have used the vfs-brauner tree from next-20240122 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/wwEr_+0bHO.BR4FXWEX7H1T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWvG9sACgkQAVBC80lX
0Gx1pAf+Pp3PjPzFgxC3P/a1IpT8KMzUv2pWUgcj5V8YoY2CDrQ2GngcpGhBDOu9
yXfMmRwl2otPoa1S91d5M/7yCd7HNnfwaKTNMfqfUKc+H/nPBwmOZjxVmDWKp4PJ
CM8l2TgLD3ysiV3nTc0WkuiynuBx9UqH+YGSxe4JNTXJEvKdOYBxV2dbKtO8mnbJ
79tt37I3phHjGCGbe/Kc2I0EIaHgxp0AjP34CREu2Pw8oYDTbZi0lj7orokHpCi4
FYhtNW0TNWNDJoNEjFuXhvZj2TuZ3m0uL74itjabtkAsIbvKWEb2qt/+6Ok/8Y4L
eoqP02gtV+uHTWlKO4OEoYJQ+/+mkA==
=QcsJ
-----END PGP SIGNATURE-----

--Sig_/wwEr_+0bHO.BR4FXWEX7H1T--

