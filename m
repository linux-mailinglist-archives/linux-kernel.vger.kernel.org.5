Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D4580C071
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjLKEjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKEjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:39:01 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AC6F1;
        Sun, 10 Dec 2023 20:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702269546;
        bh=ARe2WiYTYarVV8zakJUOA4IyWPnjsMkkih8W6w6qPxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XUermV09HIq7zbeM530Y+p8KUiSnOtcRdvKK7lOxGEEk7UpomONeLy+AtLa/bUpVV
         OJmJuEq1EN47PspkZx1b+mkQfihbN+OFdyw29whZJc5UX/StBqGk/6tqCRpqnK+eVK
         UXQJ7M2V+aP9ilXTlIXMlhiH9NszefBi1HnNxJSpdnA0s7blKEiqgt1EVpFF0l979I
         WizfSUjXHNw68yMP26VyGdOukdQMRnzlaRnVdfe6OLHbSJpcfiLCll6u0DkGfXOm73
         DMlpDLXuiS8ZWprVRkrVHUG4Y0wnteDNAJFx6rvBQ4xx/273BRlnh4UX7hRZURI4EF
         jssxUYamAOdtQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpTXp0B06z4x2W;
        Mon, 11 Dec 2023 15:39:05 +1100 (AEDT)
Date:   Mon, 11 Dec 2023 15:39:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: Re: linux-next: manual merge of the efi tree with the efi-fixes
 tree
Message-ID: <20231211153905.6cbf7dcb@canb.auug.org.au>
In-Reply-To: <20231211151303.1286eda5@canb.auug.org.au>
References: <20231211151303.1286eda5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CfHjMo=cqgXajriNPpRcQwj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CfHjMo=cqgXajriNPpRcQwj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 11 Dec 2023 15:13:03 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the efi tree got a conflict in:
>=20
>   fs/efivarfs/super.c
>=20
> between commits:
>=20
>   0b6d38bdd6f8 ("efivarfs: Free s_fs_info on unmount")
>   ab5c4251a009 ("efivarfs: Move efivarfs list into superblock s_fs_info")
>=20
> from the efi-fixes tree and commit:
>=20
>   b501d5b36f58 ("efivarfs: automatically update super block flag")
>=20
> from the efi tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Actually the below is needed. ("info" is not a great name for, even a
static, global variable.  And maybe what I have called "einfo" could be
"sfi" like in efivarfs_kill_sb() ...)
--=20
Cheers,
Stephen Rothwell

diff --cc fs/efivarfs/super.c
index d7d9a3e189a0,42eff5ac7ab4..d209475a8a49
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
@@@ -290,7 -317,6 +316,7 @@@ static int efivarfs_parse_param(struct=20
 =20
  static int efivarfs_fill_super(struct super_block *sb, struct fs_context =
*fc)
  {
- 	struct efivarfs_fs_info *info =3D sb->s_fs_info;
++	struct efivarfs_fs_info *einfo =3D sb->s_fs_info;
  	struct inode *inode =3D NULL;
  	struct dentry *root;
  	int err;
@@@ -316,10 -345,17 +342,16 @@@
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
- 			  &info->efivarfs_list);
++			  &einfo->efivarfs_list);
  	if (err)
- 		efivar_entry_iter(efivarfs_destroy, &info->efivarfs_list, NULL);
 -		efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
++		efivar_entry_iter(efivarfs_destroy, &einfo->efivarfs_list, NULL);
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

--Sig_/CfHjMo=cqgXajriNPpRcQwj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV2kmkACgkQAVBC80lX
0Gx/oQf+Np0FMi0jhZMQ+WbOU7bibnjtdOYhKGnoVRWXIbCM93RLvcVecuYmnbcI
myygrEeOFjwYVUbtyndnfP60GiJeEkuV0lQNty7CWCaQD7oH2mSyh2WUue76t7KR
zgTWKqkkRfnb4bt6CBiqOucftBUkrqwEsaL4B3jnSVRNi55hp/BsHImpgY6RQ8/g
3JB8fo7qVu+ySBpFkkQimJuGracJDaj2JCk9Wbf/p7M6Lv/6Xxfy3H/ZuBqO9o2s
t0I9JOY6nmr5fylYXauRANynTFWrXZHfVEYyjEYWR+e7epa3mp5gi1IrJp8c6i6U
9s249bvaFE7x2096qXsA1UNI5M8vlw==
=5vYV
-----END PGP SIGNATURE-----

--Sig_/CfHjMo=cqgXajriNPpRcQwj--
