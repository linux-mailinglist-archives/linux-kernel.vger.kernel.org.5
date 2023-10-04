Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15B17B75F1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 02:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjJDAoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 20:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJDAoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 20:44:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A29A7;
        Tue,  3 Oct 2023 17:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696380238;
        bh=VTUgVwGFs/x1FHkkO7KJ0hxykuV2FQw9OJPcxcssznM=;
        h=Date:From:To:Cc:Subject:From;
        b=Arnyhv6pHMymBXETeIMD6pL9PdUcZg35nqkmN0t/DNMu36jY3M9g3gedTNzVKMF/F
         7nx12bnxjLSE9wZIx2GQuq2jLpqogaZ0NasWb+g1lF9uBJkeEaN3+wukUAtSSyZwni
         wfYrV86DqcYU+79jzWkNexK8nA5RplWT+zV4suFZOks8ENsXkb2NWTcOx2LffP925n
         jTwKicr8VFkWY1q7rGgX42mpZe143k9Vm1sl1kOAWxBcDxPaxRQ+FC5tcVa74Pb/RB
         c/i03qgIDJD6vNsj8EMm5wHJ73ODlGE9sw7dVr6J575TY4JZvZQoYwWJHcKk+MPBHc
         PDD5ELeBeim5A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S0bXs4ydwz4xM2;
        Wed,  4 Oct 2023 11:43:57 +1100 (AEDT)
Date:   Wed, 4 Oct 2023 11:43:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jack Brennen <jbrennen@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: linux-next: manual merge of the modules tree with the kbuild tree
Message-ID: <20231004114354.39a71ab3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oH1/TL=DeD9tVNWwk++UQXc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oH1/TL=DeD9tVNWwk++UQXc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the modules tree got a conflict in:

  scripts/mod/modpost.c

between commit:

  4074532758c5 ("modpost: Optimize symbol search from linear to binary sear=
ch")

from the kbuild tree and commit:

  dc95e422c283 ("module: Make is_valid_name() return bool")

from the modules tree.

I fixed it up (I used the former version of this files and applied the
following merge resolution patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 4 Oct 2023 11:39:03 +1100
Subject: [PATCH] fix up for "module: Make is_valid_name() return bool"

interacting with commit

  4074532758c5 ("modpost: Optimize symbol search from linear to binary sear=
ch")

from the kbuild tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 scripts/mod/modpost.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 6413f26fcb6b..5a0324f3257f 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -163,12 +163,12 @@ static inline unsigned int get_secindex(const struct =
elf_info *info,
  *
  * Internal symbols created by tools should be ignored by modpost.
  */
-static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
+static inline bool is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 {
 	const char *name =3D elf->strtab + sym->st_name;
=20
 	if (!name || !strlen(name))
-		return 0;
+		return false;
 	return !is_mapping_symbol(name);
 }
=20
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/oH1/TL=DeD9tVNWwk++UQXc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUctUoACgkQAVBC80lX
0Gx2Pwf9FTvYCFWISG4yvSKQy0vGAxJGeWoybTOEEUj7DwO5hZC/1BepWpNbUJOt
9nD/cPQVLz/S3FJsg0oUWbzm+TjXt9TZVJTuLgdYdlOIVTNutb18mDPV0726LOSm
neHlF9U3+TPJhc8+LRNW0nlQAwvrGsSx3TLk5NKXOtKKjGiYv2h22LYFh2B2haVd
4lcjFl24TNBYvsdeGzdkzWwY6aFbanLy7j53LCaA17DGAO/mPhVuBrKvMJTUeZpC
5whnT7oEU5thhQpFKX8ov6orAOixGWWD/NaNcS8PPyjAd4uMe5kXXzd+nqqZ7lMa
15b2FN8YE09Ag4DM6snQ48ZcRZ+7Jw==
=yr7x
-----END PGP SIGNATURE-----

--Sig_/oH1/TL=DeD9tVNWwk++UQXc--
