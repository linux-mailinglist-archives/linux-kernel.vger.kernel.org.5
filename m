Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9C7DC3C7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 02:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbjJaBHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 21:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjJaBHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 21:07:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AB1CC;
        Mon, 30 Oct 2023 18:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698714466;
        bh=0r7f7aeoGlM17q0fwDD24z5RdolX82nJaIK2/epUJ/Y=;
        h=Date:From:To:Cc:Subject:From;
        b=Jd5+0vsZAanmX0S9y84cXsrpqlJUPbfg3RtqlkreDarQ4uL9QAh2NOabE1XJS2tsL
         fvB82QSX6gbPULIUZzTcURlKIJ8eMP4q0jkrrLDDhg1u6W4ZjeLQSz3UGoE/UlZjQa
         z5sRpWBqHpeDXZ50iAo5sjJ/f3aRJH9iwR7x4RnwAbQ6AzhX7L+cre4fY24bh54ijt
         wlkvGHpOwXb49yqC5fCsJSKNhrvjoDC08ndAlKH+aJjdq5DTg+jLlQx4hxz2D1ZXYC
         MsWhliIV5gpp9LtZll7Y7RDhEgmDMJpH4ATokLelf+a/R08Ecr9HJ16gesu56O4BQU
         r4VWbJWbxfIsQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SKBnt50cVz4wdD;
        Tue, 31 Oct 2023 12:07:46 +1100 (AEDT)
Date:   Tue, 31 Oct 2023 12:07:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20231031120745.5d01f1a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cnVZEnIZ.I8xrsAS=OVssgV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cnVZEnIZ.I8xrsAS=OVssgV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/bcachefs/fs-ioctl.c: In function 'bch2_ioc_goingdown':
fs/bcachefs/fs-ioctl.c:294:23: error: implicit declaration of function 'fre=
eze_bdev' [-Werror=3Dimplicit-function-declaration]
  294 |                 ret =3D freeze_bdev(c->vfs_sb->s_bdev);
      |                       ^~~~~~~~~~~
fs/bcachefs/fs-ioctl.c:301:17: error: implicit declaration of function 'tha=
w_bdev' [-Werror=3Dimplicit-function-declaration]
  301 |                 thaw_bdev(c->vfs_sb->s_bdev);
      |                 ^~~~~~~~~

Caused by commit

  46bb2e011760 ("bdev: rename freeze and thaw helpers")

interacting with commit

  4495cbed568b ("bcachefs: Improve FS_IOC_GOINGDOWN ioctl")

I have applied the following merge resolution patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 31 Oct 2023 12:00:27 +1100
Subject: [PATCH] fixup for "bdev: rename freeze and thaw helpers"

interacting with "bcachefs: Improve FS_IOC_GOINGDOWN ioctl".

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/bcachefs/fs-ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
index 6040bd3f0778..d715a2b35189 100644
--- a/fs/bcachefs/fs-ioctl.c
+++ b/fs/bcachefs/fs-ioctl.c
@@ -291,14 +291,14 @@ static int bch2_ioc_goingdown(struct bch_fs *c, u32 _=
_user *arg)
=20
 	switch (flags) {
 	case FSOP_GOING_FLAGS_DEFAULT:
-		ret =3D freeze_bdev(c->vfs_sb->s_bdev);
+		ret =3D bdev_freeze(c->vfs_sb->s_bdev);
 		if (ret)
 			goto err;
=20
 		bch2_journal_flush(&c->journal);
 		c->vfs_sb->s_flags |=3D SB_RDONLY;
 		bch2_fs_emergency_read_only(c);
-		thaw_bdev(c->vfs_sb->s_bdev);
+		bdev_thaw(c->vfs_sb->s_bdev);
 		break;
=20
 	case FSOP_GOING_FLAGS_LOGFLUSH:
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/cnVZEnIZ.I8xrsAS=OVssgV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVAU2EACgkQAVBC80lX
0GyFuggAlQUOE8QohYRRq0DVz1HI9UrQotp8vBqTy7NNaOPe37LynoNxxuH3+/IW
rrru11Fop2f3yG5fcLU+M8h+gmYtslQ9Y1Va3If3C11eyva8kcK2RMmBytIOcuzw
ibRW8JwtguL3izgf+IMHqi6bDLKSrbAgKozh4oXbrwdmx7vKMxWiYDTdpqf1+Idk
4D0dl/Iyf2/DC/AMOIXQ2WL77lMEWMxSgizXXA2oQqs+FM8le57WUQyjQBFC0Lcv
jarkGHNey7FrThRbZMO/dUx+ZuGCmMacRuUFrXzilq71vNFvcFunMXpt/4jMFI33
CVGGbTnxyGcOqb/0Wai0dtZDZBoB3A==
=lICs
-----END PGP SIGNATURE-----

--Sig_/cnVZEnIZ.I8xrsAS=OVssgV--
