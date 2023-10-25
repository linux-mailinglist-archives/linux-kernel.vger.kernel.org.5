Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0B27D7854
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjJYXCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJYXCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:02:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132C0115;
        Wed, 25 Oct 2023 16:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698274919;
        bh=ILvvl/AKCad66JyAk+uyU1wjPs+a55UCOHy+Tqem/EA=;
        h=Date:From:To:Cc:Subject:From;
        b=Y/L8SHrZpbwLuA4zfNVcKCmbVAhyvmSMQzMsoBT/cDTJTHsJq40ngSJ4JhFwwlQLb
         mL8cZkFe+RnanmCwEC8iOypT+V1jmWgbbNRDYk2Ds690IcKneQICkXbkL/BU/265gn
         9dy6a+GEH3TDEbgANx5GUfndM6KAtMMTBh6XqQ20nXvEV+7YRhkj5FmZA426tLrSIs
         6exE1zAT7Y2JDhAP3JPYpoNroQbYLtMwbiAP/wprvR0FD/lqeQAN6ZaNgAuiBaib3t
         GkgJz2KRJYkpqRrr/s28SP6dqGVAtnnj4Xb/6wMsJJhDvGMDFpsBvC0zHNbnggsuUn
         ffr1GW5LV1+hw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SG4F24V4Vz4wx8;
        Thu, 26 Oct 2023 10:01:58 +1100 (AEDT)
Date:   Thu, 26 Oct 2023 10:01:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the bcachefs
 tree
Message-ID: <20231026100157.735d7dee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VmBDWPP88GD83wpyU+t3/kY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VmBDWPP88GD83wpyU+t3/kY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  include/linux/exportfs.h

between commit:

  85e95ca7cc48 ("bcachefs: Update export_operations for snapshots")

from the bcachefs tree and commit:

  2560fa66d2ac ("exportfs: define FILEID_INO64_GEN* file handle types")

from the vfs-brauner tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/exportfs.h
index be9900cc8786,21bae8bfeef1..000000000000
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@@ -98,12 -98,17 +98,23 @@@ enum fid_type=20
  	 */
  	FILEID_FAT_WITH_PARENT =3D 0x72,
 =20
 +	/*
 +	 * 64 bit inode number, 32 bit subvolume, 32 bit generation number:
 +	 */
 +	FILEID_BCACHEFS_WITHOUT_PARENT =3D 0x80,
 +	FILEID_BCACHEFS_WITH_PARENT =3D 0x81,
 +
+ 	/*
+ 	 * 64 bit inode number, 32 bit generation number.
+ 	 */
 -	FILEID_INO64_GEN =3D 0x81,
++	FILEID_INO64_GEN =3D 0x82,
+=20
+ 	/*
+ 	 * 64 bit inode number, 32 bit generation number,
+ 	 * 64 bit parent inode number, 32 bit parent generation.
+ 	 */
 -	FILEID_INO64_GEN_PARENT =3D 0x82,
++	FILEID_INO64_GEN_PARENT =3D 0x83,
+=20
  	/*
  	 * 128 bit child FID (struct lu_fid)
  	 * 128 bit parent FID (struct lu_fid)

--Sig_/VmBDWPP88GD83wpyU+t3/kY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU5nmUACgkQAVBC80lX
0Gy5Cgf+ImxdRgkOccozxtWZmpzqfmWeCkp9lsvmKvvwYLK86OuFS/pw6UD1S0y0
xRQLPHujQL6TRJlbpna/D34zSDAmzlDczJh3ClwG8vzZ2BWfw64r0b6hmVQVQA+4
e4eBHmEB9lb9QCEM0HpBDCYSuTtOh2uOs95g2g0n+PD8uhy5oQjTHhIn8gN0g91T
XNoJikAsJVbBknFO+cTZ/Sqt+8ThwMlb9cOQu3nFYUiUjNFbOkm7RN9lVJP4UBdW
cMs3oje8eMe72+LLACasA6eW5oxaOGHD6sx0wCT4MlwEnkl+Xu97f9YTJxa8hJrR
OfeAWe1Pp2c1+QKovnBUA8avT4GOEA==
=czoY
-----END PGP SIGNATURE-----

--Sig_/VmBDWPP88GD83wpyU+t3/kY--
