Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426A37B1026
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjI1Ayv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1Ayu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:54:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0EFBF;
        Wed, 27 Sep 2023 17:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695862485;
        bh=cWJWQLaCutW3/ihZakmlgvowJp6CyCO6KwVHcVIhhyo=;
        h=Date:From:To:Cc:Subject:From;
        b=b5UO7KI/iUEwHzj7Iuu0bRBoMuSvMfVmVyWcToTFHAqxqnb0SU3UNdV32PE6Ks2u8
         wleaKXlZTUmrgT4dgu77o6UVzOJ2yYTY4Ht7C9RekyxE63hTdMgRpU5fjUl2jTNo9s
         IbL7PrcN67H6QK3Yord2QSM9JSapnTjlHa8g/q8ofKSxUrWM4bU4lcXVXl/OMCu5y8
         VemF25oJg08X/+xlYoN99o9RJH7Pz8LijwQf0Yqk0Tfx3NfRykxZp3cSELErgRu90N
         jdn1mAbM9O4iBFmM+e8k+25DsY2T4S/c5/JPD4vBnWSLIVDX/BY8XnrsAGv/V1ib1Y
         i2wikRn4Of1pw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rww444zQlz4xQN;
        Thu, 28 Sep 2023 10:54:44 +1000 (AEST)
Date:   Thu, 28 Sep 2023 10:54:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20230928105443.1b1ad98c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N+9XUcT7G25Ssnlk5N0mUyM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N+9XUcT7G25Ssnlk5N0mUyM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/bcachefs/super-io.c: In function 'bch2_free_super':
fs/bcachefs/super-io.c:166:17: error: implicit declaration of function 'blk=
dev_put'; did you mean 'bdi_put'? [-Werror=3Dimplicit-function-declaration]
  166 |                 blkdev_put(sb->bdev, sb->holder);
      |                 ^~~~~~~~~~
      |                 bdi_put
fs/bcachefs/super-io.c: In function 'bch2_read_super':
fs/bcachefs/super-io.c:687:20: error: implicit declaration of function 'blk=
dev_get_by_path'; did you mean 'bdev_open_by_path'? [-Werror=3Dimplicit-fun=
ction-declaration]
  687 |         sb->bdev =3D blkdev_get_by_path(path, sb->mode, sb->holder,=
 &bch2_sb_handle_bdev_ops);
      |                    ^~~~~~~~~~~~~~~~~~
      |                    bdev_open_by_path
fs/bcachefs/super-io.c:687:18: error: assignment to 'struct block_device *'=
 from 'int' makes pointer from integer without a cast [-Werror=3Dint-conver=
sion]
  687 |         sb->bdev =3D blkdev_get_by_path(path, sb->mode, sb->holder,=
 &bch2_sb_handle_bdev_ops);
      |                  ^
fs/bcachefs/super-io.c:693:26: error: assignment to 'struct block_device *'=
 from 'int' makes pointer from integer without a cast [-Werror=3Dint-conver=
sion]
  693 |                 sb->bdev =3D blkdev_get_by_path(path, sb->mode, sb-=
>holder, &bch2_sb_handle_bdev_ops);
      |                          ^
cc1: all warnings being treated as errors

Caused by commit

  953863a5a2ff ("block: Remove blkdev_get_by_*() functions")

interacting with commit(s) from the bcachefs tree.

I would have reverted that commit for today, except I used the old
vfs-brauner tree due to another build failure.  Can we just delay this
one commit until after bcachefs has been converted (and any other
references that may be added are fixed)?

--=20
Cheers,
Stephen Rothwell

--Sig_/N+9XUcT7G25Ssnlk5N0mUyM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUUztMACgkQAVBC80lX
0Gy3lwf/atqZzIZQKkVZG5fdRCS6ZvQsAf/YRhrKTDY23anQG0QXpv7706oZEz3M
7R1j5rqk+LZnpLLfGRKD8wWnkVF47ACD/0I5lt2vmZV0X3v9zrttm1XfRANZJKnI
/f+YUVTTdHKUH7jK1UvRgvkxg9yhPsQ4YbNxJl4PY5tGs+qi9OmRSFbZ1NlkHGo1
QvBx0/oOqOV3yn6rWYWbz2LfPh99s9l1gbccoy8PkDZkSy9oUM0p6pbLpU7XDo1s
9D7+Mo+8d8hcdwsVs/23F1EIUxttIkUcT6JR4tOVjT92lF8euHiGDkxDDNrdy5T+
8mKUwauzTSV+Q9JrEOXqOH59TvILqg==
=kZre
-----END PGP SIGNATURE-----

--Sig_/N+9XUcT7G25Ssnlk5N0mUyM--
