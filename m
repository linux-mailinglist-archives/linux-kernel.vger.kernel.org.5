Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43157B5D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjJBWaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJBWaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:30:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADFDC4;
        Mon,  2 Oct 2023 15:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696285806;
        bh=TzautiH11u5xJZ5yKTvAAHe2+Zu9GUrJ4FbQqheGx0M=;
        h=Date:From:To:Cc:Subject:From;
        b=qgHGA790P06/QiWnHe5eq7WhnInXj5LBNRZHuDebflFfysicNuH/5HABMPVyTKcm9
         8JkMj/DwkRwpjMO7spx8k5dJJnBWlfqa3F/AuvD2eSxpKT2taTRynqpRy6tuJ6oFNi
         q8O8YNjc5/qNhg8yXrIyNKrTSTqcCR8aVGHpT0PPOAg4Cs51QduXHgKgIz5l+4qFRe
         kQaD+NnCtS7w2tWwZonVb4tHvPApovH64W+5ZbCiglW0p0vVaKHhBG+gh2o7PNBfVR
         foXyYNxzWWKW/fnnKC1MHi8UqMxb2KQ5qiPhCSl4cGyYUKhxljJ6SElVPsy4QKpAJH
         12rAyjXwk7AXA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rzwct0h25z4xGM;
        Tue,  3 Oct 2023 09:30:06 +1100 (AEDT)
Date:   Tue, 3 Oct 2023 09:30:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20231003093005.66556fcb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aHZh4_ZNUd3TE=EFiWi86ow";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aHZh4_ZNUd3TE=EFiWi86ow
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ERROR: modpost: "fget_files_rcu" [arch/powerpc/platforms/cell/spufs/spufs.k=
o] undefined!

Caused by commit

  af66b51563ad ("file: convert to SLAB_TYPESAFE_BY_RCU")

I applied the following fix up patch.

=46rom dab8e3bea1812a352c6e21bf0d0b49d833595d19 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 3 Oct 2023 09:26:33 +1100
Subject: [PATCH] fix up for "file: convert to SLAB_TYPESAFE_BY_RCU"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file.c b/fs/file.c
index e37611221161..f804d7e50958 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -972,6 +972,7 @@ struct file *fget_files_rcu(struct files_struct *files,=
 unsigned int fd)
 {
 	return __fget_files_rcu(files, fd, 0);
 }
+EXPORT_SYMBOL_GPL(fget_files_rcu);
=20
 static struct file *__fget_files(struct files_struct *files, unsigned int =
fd,
 				 fmode_t mask)
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/aHZh4_ZNUd3TE=EFiWi86ow
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUbRG0ACgkQAVBC80lX
0GyrNgf/TBmwlrMA1tk32Cj15YqZD58E39wVpw5HYfDmuN3R/gMgvzY/QR/JycAQ
QElrtO7SRvufVyWX2pa4eT0Qo61BV0S6LFBYrHMGLJ5WeCs5ldRn0Zok+TFjwtAF
yaC9dkobxOzh5Tm2DNYzmIOocqIJLfybnMY6Zpsg1rWsNnLY+smA6u2XtIDlTWJU
lSegpW/PtOsUulSoZBfrTJ1sWsoy2hXyUohsbzhuHxPkjeuYHNMq8lie8YOwNnRY
hFkXlocvjQa/bXRMaLjTG+JY+asnjurUFlnpC4kWT52x+eEwT/axghWxAIhFCGtJ
5KHgNucx9rz6kSCTZ5AVhOnA/EhPDg==
=q48G
-----END PGP SIGNATURE-----

--Sig_/aHZh4_ZNUd3TE=EFiWi86ow--
