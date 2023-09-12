Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19C079C39D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241675AbjILDDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbjILDDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:03:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38891A828C;
        Mon, 11 Sep 2023 18:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694479609;
        bh=UurkH60F253ZS4YnVtKClb/qhorKoa9sREFXqxAMChE=;
        h=Date:From:To:Cc:Subject:From;
        b=OERPCPUFrnjbz+FQrF52fpvnI9ilMgqiJwb5u4+5oKXzhjf39sbLg/lzICcHAfjuc
         T5dmNhwMlJ1O8Y+Rk5Obq1wYi1jKFEWoRdkTKSnMHPbjSAibFq5fnyKW7yhm7F7s/3
         oJKMGEM6jqbsQUwqXtz5feFZ8s9MURtNTuVrjY/o15CK1n1Amn3RNkYx4BQdfgX3K4
         v7eRgDnUbS2iH2hS7vdoqggA7jeFmOKwR+0mIemOi72tqD5MS3xr5wafnnqupWu5bu
         fJqcM99N/wt3UTXmd7F22DoFfrRcQMMooEuIFEUPOyhfmbd1e6L5dsQb4hwbiwoPEh
         PLB4D8xfOlidA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rl4fJ6MvWz4xPf;
        Tue, 12 Sep 2023 10:46:48 +1000 (AEST)
Date:   Tue, 12 Sep 2023 10:46:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the btrfs tree
Message-ID: <20230912104646.3a9140f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z=QmpyhMfxYI8RtDDL6DavD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z=QmpyhMfxYI8RtDDL6DavD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the btrfs tree, today's linux-next build (powerpc
ppc64_defconfig) produced these warnings:

In file included from include/linux/swab.h:5,
                 from include/uapi/linux/byteorder/big_endian.h:14,
                 from include/linux/byteorder/big_endian.h:5,
                 from arch/powerpc/include/uapi/asm/byteorder.h:14,
                 from include/asm-generic/bitops/le.h:6,
                 from arch/powerpc/include/asm/bitops.h:336,
                 from include/linux/bitops.h:68,
                 from fs/btrfs/extent_io.c:3:
In function 'btrfs_disk_key_to_cpu',
    inlined from 'btrfs_item_key_to_cpu' at fs/btrfs/accessors.h:648:2,
    inlined from 'fiemap_find_last_extent_offset' at fs/btrfs/extent_io.c:2=
804:2,
    inlined from 'extent_fiemap' at fs/btrfs/extent_io.c:2879:8:
include/uapi/linux/swab.h:128:28: warning: 'disk_key.objectid' may be used =
uninitialized [-Wmaybe-uninitialized]
  128 | #define __swab64(x) (__u64)__builtin_bswap64((__u64)(x))
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/uapi/linux/byteorder/big_endian.h:33:26: note: in expansion of macr=
o '__swab64'
   33 | #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
      |                          ^~~~~~~~
include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__le6=
4_to_cpu'
   87 | #define le64_to_cpu __le64_to_cpu
      |                     ^~~~~~~~~~~~~
fs/btrfs/accessors.h:622:25: note: in expansion of macro 'le64_to_cpu'
  622 |         cpu->objectid =3D le64_to_cpu(disk->objectid);
      |                         ^~~~~~~~~~~
In file included from fs/btrfs/extent_io.c:34:
fs/btrfs/accessors.h: In function 'extent_fiemap':
fs/btrfs/accessors.h:645:31: note: 'disk_key.objectid' was declared here
  645 |         struct btrfs_disk_key disk_key;
      |                               ^~~~~~~~
In function 'fiemap_find_last_extent_offset',
    inlined from 'extent_fiemap' at fs/btrfs/extent_io.c:2879:8:
fs/btrfs/extent_io.c:2805:33: warning: 'disk_key.type' may be used uninitia=
lized [-Wmaybe-uninitialized]
 2805 |         if (key.objectid !=3D ino || key.type !=3D BTRFS_EXTENT_DAT=
A_KEY) {
fs/btrfs/accessors.h: In function 'extent_fiemap':
fs/btrfs/accessors.h:645:31: note: 'disk_key.type' was declared here
  645 |         struct btrfs_disk_key disk_key;
      |                               ^~~~~~~~

I don't really have any idea what caused this (it *may* have been my
change from gcc v12 to v13?).

--=20
Cheers,
Stephen Rothwell

--Sig_/Z=QmpyhMfxYI8RtDDL6DavD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT/tPYACgkQAVBC80lX
0Gy4Hwf/RbG3WH3+9Br5S1UumdgUwugkvBw3WUA4c7JP3WcZ5yAkuAriYK68Z0Q7
4I8LIUk0UOhs5UjCAzfl+qafScLrPTk4P/7SMaI8TIY/gdJrxOA4JHvGvcNxX/RA
c0LS0vQ4c2WHlV2zi/X8wUJFdCT1AwifmQPNSpa9+kh8JhHqHeT7A0+Of80wk3Ge
lIcOhPe2Fj7FRTQxi6QlTAUtRrC86baHAhob3r22c1xu3sllA+qheG1F4nO2+Eg7
QeXdeWXIy9PSc/zPEtn7hivSR9VNKWoA9VMAtTHaHHPn6ohekxroF/SwPOuouoxA
coC6/nKfnbfTyVIJlRRDaf+F2bWoEQ==
=CkPD
-----END PGP SIGNATURE-----

--Sig_/Z=QmpyhMfxYI8RtDDL6DavD--
