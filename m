Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84808029B6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 02:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjLDBDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 20:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjLDBDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 20:03:14 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E431CB;
        Sun,  3 Dec 2023 17:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701651796;
        bh=QTgVbSc8ljMVBQbD1I9Qp/eGoaOdEunqZnUVXlnbtNU=;
        h=Date:From:To:Cc:Subject:From;
        b=f6CgkEb8+Ynj1frTRFyPaZPMDMX+2rdUiIb5ij7+RFQluV0ezZSe0YW5210aD9MQJ
         yZD/lo/XxZFwJT7NIHdv+7YCy6BQjAhk59UNEZHbxDD5OLqZl9nGneJoVvkK3eobeT
         Iz0L67MBTFg4sRwVIR5cLuXS2Vm5fNtMHu6yqf0wE+LAbi/kfIOwjGGv2qe0Qt2PR9
         pZlespMIChAGuNLQqDd31uAShcl3bzbpcCWkqpO9COADSIeVNFEQCqPF16H0Z2JOce
         cU20WOdzTiI6JO+xYCmYukS7roXsXV8MyipoAEMjes5lTHB/KIcy3kdkxdOkeFyV68
         21wcQBBh1LCwA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sk54z6HTgz4xMv;
        Mon,  4 Dec 2023 12:03:15 +1100 (AEDT)
Date:   Mon, 4 Dec 2023 12:03:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: linux-next: manual merge of the security tree with the block tree
Message-ID: <20231204120314.5718b5f6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AvgUSqnof4ek/XouhAriC_P";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AvgUSqnof4ek/XouhAriC_P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the security tree got conflicts in:

  security/selinux/hooks.c
  security/smack/smack_lsm.c

between commit:

  bf18dde00aa9 ("io_uring: split out cmd api into a separate header")

from the block tree and commit:

  f3b8788cde61 ("LSM: Identify modules by more than name")

from the security tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc security/selinux/hooks.c
index 17ec5e109aec,b340425ccfae..000000000000
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@@ -91,7 -91,8 +91,8 @@@
  #include <uapi/linux/mount.h>
  #include <linux/fsnotify.h>
  #include <linux/fanotify.h>
 -#include <linux/io_uring.h>
 +#include <linux/io_uring/cmd.h>
+ #include <uapi/linux/lsm.h>
 =20
  #include "avc.h"
  #include "objsec.h"
diff --cc security/smack/smack_lsm.c
index 2cdaa46088a0,53336d7daa93..000000000000
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@@ -42,7 -42,8 +42,8 @@@
  #include <linux/fs_context.h>
  #include <linux/fs_parser.h>
  #include <linux/watch_queue.h>
 -#include <linux/io_uring.h>
 +#include <linux/io_uring/cmd.h>
+ #include <uapi/linux/lsm.h>
  #include "smack.h"
 =20
  #define TRANS_TRUE	"TRUE"

--Sig_/AvgUSqnof4ek/XouhAriC_P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVtJVMACgkQAVBC80lX
0GxKcAf6AqLSO11wPsPuwQHQxgQ6FBkrjfx0CLVgMsi64ZeosRssAbgDzTyD/r0s
pIDpE9SH5f/HfqIqY29lrpAbUcMLr1mtdRudXZXKpgXIPhvCRmSzIH671PjuoYGG
CPxGoGIfnGXHUvs+r603Bllq+ifpklhm8sNtiTIoXpIPVdwZzHyk0QGfEc6/nnkO
0NAA7ZAK3Mll7vr0qcz+EHSo9QrziSVXpIj2dyFAIqkvqC4WgCppI8P9wpTO4NgT
bq+WIx3MpawMy4qyDIcFQLvPAbqePBs3XM7VSpe3mP8lABhfJ3jtZC3v56xCgM7Y
bNbgv6mVIj1DdBJPjxOZexyv06E+Sg==
=BpOO
-----END PGP SIGNATURE-----

--Sig_/AvgUSqnof4ek/XouhAriC_P--
