Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197D07D8E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345144AbjJ0FeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0FeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:34:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32381A7;
        Thu, 26 Oct 2023 22:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698384843;
        bh=ZlwcCpgji3B4ca648vW3TWOMt2e5PNvnzxuKUwNW4i0=;
        h=Date:From:To:Cc:Subject:From;
        b=hUyF5o4YyWzHLuNGTX1VCmSRatkFuiUWNsanUDL7nkO1jzZfsp8cKSMaa/vRIhakK
         UVEoelL9P1KDvn+xbyJYDaHVnuadB+IG2qb3CWm4llXsXD+lMJoU0JKbJFsVDdlWLi
         BkmVJEFFQoA05b/8jGACzuAjUGWsazJBnKf51KrSHe4D7xudAm8FaXqosutjLJ80TN
         V7Thp+axHf3ph3qwS4kDKoeqo66YEme5mUts6bqY55iD60t38IxeNsyLkVUfddkbri
         wppuN9ylDKMh+G/HylhYHM9t7L71WLsCC74BnC6H3/xmyFdNBSy4gSqqvSxTUxmOXO
         O5C0jF/3qw5HA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGrty1GQNz4wcf;
        Fri, 27 Oct 2023 16:34:01 +1100 (AEDT)
Date:   Fri, 27 Oct 2023 16:34:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the landlock tree
Message-ID: <20231027163400.5764d549@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/m5HOWf6jM/D/e4rBXcr.b7H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m5HOWf6jM/D/e4rBXcr.b7H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the landlock tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from security/landlock/net.c:14:
security/landlock/net.c: In function 'landlock_add_net_hooks':
security/landlock/common.h:12:23: error: passing argument 3 of 'security_ad=
d_hooks' from incompatible pointer type [-Werror=3Dincompatible-pointer-typ=
es]
   12 | #define LANDLOCK_NAME "landlock"
      |                       ^~~~~~~~~~
      |                       |
      |                       char *
security/landlock/net.c:199:28: note: in expansion of macro 'LANDLOCK_NAME'
  199 |                            LANDLOCK_NAME);
      |                            ^~~~~~~~~~~~~
In file included from security/landlock/setup.h:12,
                 from security/landlock/cred.h:17,
                 from security/landlock/net.c:15:
include/linux/lsm_hooks.h:120:53: note: expected 'const struct lsm_id *' bu=
t argument is of type 'char *'
  120 |                                const struct lsm_id *lsmid);
      |                                ~~~~~~~~~~~~~~~~~~~~~^~~~~

Caused by commit

  fff69fb03dde ("landlock: Support network rules with TCP bind and connect")

interacting with commit

  9b09f11320db ("LSM: Identify modules by more than name")

from the security tree.

I have applied the following merge resolution patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 27 Oct 2023 16:13:32 +1100
Subject: [PATCH] fixup for "landlock: Support network rules with TCP bind a=
nd
 connect"

interacting with "LSM: Identify modules by more than name"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 security/landlock/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index aaa92c2b1f08..efa1b644a4af 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -196,5 +196,5 @@ static struct security_hook_list landlock_hooks[] __ro_=
after_init =3D {
 __init void landlock_add_net_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/m5HOWf6jM/D/e4rBXcr.b7H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU7S8gACgkQAVBC80lX
0GxBlwf8CZN2qGCwBQDbwTx5IZjzE3VfGoAEWcFxeQzH7FdS5eBJBJjb8h+4exNd
YayxJxYQ8yN5WYjBWjN6A26xEEdmpFB1Y0Db3MqTeQSW44V0x+ZOwXsj+HRVHQJD
WwVKeosXLAFJ7y7CLjcbZm+KdsoYeH311XndVrQYd5kzodfscfHPYyQBOgEEIjcO
whDOvkFDOTgBtdJN5QIf6j5KpN1YBOxAvFnffA1WOOEpKSuE40Z7qZteDgsJiOQ8
x6830RrEcY3TGikbQJQYlbK5SkqP5geg+V3KXO8i6yU2Sr5a9CXTmcjOxrLPc3jC
MbXLGAWc4GWObmh6y1IdOrB021Rj0Q==
=74Wl
-----END PGP SIGNATURE-----

--Sig_/m5HOWf6jM/D/e4rBXcr.b7H--
