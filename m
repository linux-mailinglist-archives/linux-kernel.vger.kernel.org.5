Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B377D80C054
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjLKENC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKENB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:13:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15765B5;
        Sun, 10 Dec 2023 20:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702267984;
        bh=QmJBFR8Jd+l7wvhUpTwUIIFEUSssE1k1dZ/vixNT+wE=;
        h=Date:From:To:Cc:Subject:From;
        b=N2CkGRsSE/qUgDp+YeYV1FrERCqJeMw3ceJKiB8dtpJhblREm48Y9XlsCkad2R2RI
         ftFiaQbZGUZuyexxOAWG/PTE9PeFuYp/7esjIdaWK25iFeevi64PU6Y3R9obS+GrPw
         elnOmLdf2ZcsGfV042Wdt+YbbbHHZY/IdkcU5HHquZIwXF8QU4Qy8Ypetvc1On1JWe
         XSID5b6EoAWMkATdU5eN6e/vLWte0Kn3o5nDxD52zgArYAbhH2fp/v8VQLhiROm5wU
         aJbdwl5fOU/FmKtEfh9Edp1i4/NfFn3dI+p06RtVd7CxEBm2zadsrJWgNpu6+ON7le
         Ea3/rRW0JUg2w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpSym3fJdz4xCm;
        Mon, 11 Dec 2023 15:13:04 +1100 (AEDT)
Date:   Mon, 11 Dec 2023 15:13:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: linux-next: manual merge of the efi tree with the efi-fixes tree
Message-ID: <20231211151303.1286eda5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yo8XSFAKhlr3OmIsAQtWar4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yo8XSFAKhlr3OmIsAQtWar4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the efi tree got a conflict in:

  fs/efivarfs/super.c

between commits:

  0b6d38bdd6f8 ("efivarfs: Free s_fs_info on unmount")
  ab5c4251a009 ("efivarfs: Move efivarfs list into superblock s_fs_info")

from the efi-fixes tree and commit:

  b501d5b36f58 ("efivarfs: automatically update super block flag")

from the efi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/efivarfs/super.c
index d7d9a3e189a0,42eff5ac7ab4..000000000000
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@@ -18,6 -20,32 +20,30 @@@
 =20
  #include "internal.h"
 =20
 -LIST_HEAD(efivarfs_list);
 -
+ struct efivarfs_info {
+ 	struct super_block *sb;
+ 	struct notifier_block nb;
+ };
+=20
+ static struct efivarfs_info info;
+=20
+ static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long=
 event,
+ 				 void *data)
+ {
+ 	switch (event) {
+ 	case EFIVAR_OPS_RDONLY:
+ 		info.sb->s_flags |=3D SB_RDONLY;
+ 		break;
+ 	case EFIVAR_OPS_RDWR:
+ 		info.sb->s_flags &=3D ~SB_RDONLY;
+ 		break;
+ 	default:
+ 		return NOTIFY_DONE;
+ 	}
+=20
+ 	return NOTIFY_OK;
+ }
+=20
  static void efivarfs_evict_inode(struct inode *inode)
  {
  	clear_inode(inode);
@@@ -316,10 -345,17 +342,16 @@@ static int efivarfs_fill_super(struct s
  	if (!root)
  		return -ENOMEM;
 =20
+ 	info.sb =3D sb;
+ 	info.nb.notifier_call =3D efivarfs_ops_notifier;
+ 	err =3D blocking_notifier_chain_register(&efivar_ops_nh, &info.nb);
+ 	if (err)
+ 		return err;
+=20
 -	INIT_LIST_HEAD(&efivarfs_list);
 -
 -	err =3D efivar_init(efivarfs_callback, (void *)sb, true, &efivarfs_list);
 +	err =3D efivar_init(efivarfs_callback, (void *)sb, true,
 +			  &info->efivarfs_list);
  	if (err)
 -		efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
 +		efivar_entry_iter(efivarfs_destroy, &info->efivarfs_list, NULL);
 =20
  	return err;
  }
@@@ -357,13 -399,15 +400,15 @@@ static int efivarfs_init_fs_context(str
 =20
  static void efivarfs_kill_sb(struct super_block *sb)
  {
 +	struct efivarfs_fs_info *sfi =3D sb->s_fs_info;
 +
+ 	blocking_notifier_chain_unregister(&efivar_ops_nh, &info.nb);
+ 	info.sb =3D NULL;
  	kill_litter_super(sb);
 =20
 -	if (!efivar_is_available())
 -		return;
 -
  	/* Remove all entries and destroy */
 -	efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
 +	efivar_entry_iter(efivarfs_destroy, &sfi->efivarfs_list, NULL);
 +	kfree(sfi);
  }
 =20
  static struct file_system_type efivarfs_type =3D {

--Sig_/yo8XSFAKhlr3OmIsAQtWar4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV2jE8ACgkQAVBC80lX
0GxcBwgAh2gcjj6B3ickMq+S4X3yAaOwRgkzLXr+OJJmxX0vrDrDp/ZF9PcgHo7c
2ArueoIYYI0B+NmSIHi7HYRoiC4BG4OnANUR6XWPFXG7qedXHRdPbIHN+252DLZf
fnQmOifXXwJR4AsSK2RwP4tDrbqlMaWn/sOaSID2Cg+1+hF5p63gAhCkD9RiY+rl
0dT3XMgYpv5C9qMCqKaD9wUTz5lwfx0NV2SEWY7TDI8e5VtxcHIBUo4JAU8kzym8
x0H12393BFOcAnw2/AXxa6u175Af5DImZMNO6LDM4/h42iZDkLtpQi+TbdlgDqIF
T/SUMORhlIWGniiL/ROllYsUgO3Xng==
=zZwH
-----END PGP SIGNATURE-----

--Sig_/yo8XSFAKhlr3OmIsAQtWar4--
