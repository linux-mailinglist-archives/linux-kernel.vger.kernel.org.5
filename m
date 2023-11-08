Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1742E7E6102
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 00:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjKHXXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 18:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHXXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 18:23:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC5B25B1;
        Wed,  8 Nov 2023 15:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699485818;
        bh=8fsIunIAE5KCLBd5LIZzuFBkZLYZH+YNTQP+e9AX4as=;
        h=Date:From:To:Cc:Subject:From;
        b=PhllRnjQ4h7Sl1+96vZbjSbUsknFj150zIWbjn4vKbhvTBAGKevPb0Jbldb2e5YQX
         2bAl8C/QCJyBt/b6Dlw2EcV987hycRcfzt3KZ6A/vDmWAmyhDT/Nh90Jhim9OoGzBJ
         X8ysacOqgMguKOF4RBckQA9Ioji6IEoftFj/DvVbL5nv6k0Pxd7P8Mp24NImTZZgi4
         X7M5cAZBxzfLXUjiOqxk2SJt3zO6h5MVuayAdmEsl+iFYRG4iuTS+xh8TL2eTIuBYj
         0o7AUUutU1u3JSHJlKFLQAmjJmAgSlOsZW5TudPUNCsKPO0hLbWPJkNjWsYmr11/02
         FjHWfy/5TKS9Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SQh3Z4gBZz4xSY;
        Thu,  9 Nov 2023 10:23:37 +1100 (AEDT)
Date:   Thu, 9 Nov 2023 10:23:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Hengqi Chen <hengqi.chen@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tianrui Zhao <zhaotianrui@loongson.cn>
Subject: linux-next: manual merge of the loongarch tree with Linus' tree
Message-ID: <20231109102335.79b6bf50@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/os/O14jSNV/xMlxJ5WXR0Kv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/os/O14jSNV/xMlxJ5WXR0Kv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the loongarch tree got a conflict in:

  arch/loongarch/include/asm/inst.h

between commit:

  81efe043a351 ("LoongArch: KVM: Implement handle iocsr exception")

from Linus' tree and commit:

  add28024405e ("LoongArch: Add more instruction opcodes and emit_* helpers=
")

from the loongarch tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/loongarch/include/asm/inst.h
index 008a88ead60d,5350ae9ee380..000000000000
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@@ -65,14 -65,8 +65,16 @@@ enum reg2_op=20
  	revbd_op	=3D 0x0f,
  	revh2w_op	=3D 0x10,
  	revhd_op	=3D 0x11,
+ 	extwh_op	=3D 0x16,
+ 	extwb_op	=3D 0x17,
 +	iocsrrdb_op     =3D 0x19200,
 +	iocsrrdh_op     =3D 0x19201,
 +	iocsrrdw_op     =3D 0x19202,
 +	iocsrrdd_op     =3D 0x19203,
 +	iocsrwrb_op     =3D 0x19204,
 +	iocsrwrh_op     =3D 0x19205,
 +	iocsrwrw_op     =3D 0x19206,
 +	iocsrwrd_op     =3D 0x19207,
  };
 =20
  enum reg2i5_op {

--Sig_/os/O14jSNV/xMlxJ5WXR0Kv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVMGHcACgkQAVBC80lX
0Gy5XAf+JGHtOoZSAfXs9IZJWWNkPmIY6379HrniToaiWjNp5WWfSdHa6vSW9cfJ
VKo3PCrwmTqTXlZ7gNLY87d+9Rlsv5V+yMBUY0AHndM0bxj5ZNJYf6PMoeNTUW7y
WC//hAKlq40DfxUdMTrZAgyzKrh4lqV5fwR0C81boFKc9THUBQLet/TKVDKIeikK
poP36p8u8SS1MbGk6eZ8vAixJqIrBlX5Dn0KN+oDExNuyJ0CheG3RJmU0hdmP5vq
WFdi6j1SJMle2sNPTb32QY1mEuh8CD3gEDzLzpd+jKhDXRSX5eK5yTPntD95aVQz
p5dQySJ/eOS2IeZGmtWIS9pyvoRU2g==
=xynt
-----END PGP SIGNATURE-----

--Sig_/os/O14jSNV/xMlxJ5WXR0Kv--
