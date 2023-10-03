Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499127B7489
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjJCXOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjJCXOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:14:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7B99E;
        Tue,  3 Oct 2023 16:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696374837;
        bh=Q7qhg5+koDdvp1LrmdDZqKf4+yEoxZq8zg19PJx37lE=;
        h=Date:From:To:Cc:Subject:From;
        b=AZPZsHNWgfn97GOf/nStiTbOp7tol1U+EKHCgpLpbBNVqB2iaku/0g5Xef1rLAI3X
         attiRE9sXTwyB4v0I9VilRukxNdwadjlAZIyYgtr/qV/muWeil47AbDFYvbWDj9WLo
         Zn9NJocFuRmQ9nFPftrFuVQCgR42iPOxhXVZDGJ1z4AXhIM99fH8ugTBJ/Vhb2gSRM
         0E7QAyKni8dvc2GByeIaF4KpX/N8rTr9Bt1x4tJd6gKgNJH0pc8dOhWr/BejS/9lhf
         N/W++tKbjo7eAsEwO1ZB1FyScdKy81c6vO7L8teWq/qheDgOrTDN3oYkrPA0XknYoo
         MNANEMcMb9Mkg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S0YY104XQz4xQj;
        Wed,  4 Oct 2023 10:13:56 +1100 (AEDT)
Date:   Wed, 4 Oct 2023 10:13:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the kbuild tree
Message-ID: <20231004101356.4f3a0a9c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/a8ztTWT2wsREURC2p4NIvm+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a8ztTWT2wsREURC2p4NIvm+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kbuild tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

In file included from scripts/mod/modpost.c:23:
scripts/mod/modpost.c: In function 'section_rela':
scripts/mod/modpost.h:66:24: warning: passing argument 2 of '__endian' disc=
ards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
   66 |         __endian(&(x), &(__x), sizeof(__x));                    \
      |                        ^~~~~~
scripts/mod/modpost.c:1437:28: note: in expansion of macro 'TO_NATIVE'
 1437 |                 r_offset =3D TO_NATIVE(rela->r_offset);
      |                            ^~~~~~~~~
scripts/mod/modpost.h:56:52: note: expected 'void *' but argument is of typ=
e 'const Elf64_Addr *' {aka 'const long unsigned int *'}
   56 | static inline void __endian(const void *src, void *dest, unsigned i=
nt size)
      |                                              ~~~~~~^~~~
scripts/mod/modpost.h:66:24: warning: passing argument 2 of '__endian' disc=
ards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
   66 |         __endian(&(x), &(__x), sizeof(__x));                    \
      |                        ^~~~~~
scripts/mod/modpost.c:1440:25: note: in expansion of macro 'TO_NATIVE'
 1440 |                 taddr =3D TO_NATIVE(rela->r_addend);
      |                         ^~~~~~~~~
scripts/mod/modpost.h:56:52: note: expected 'void *' but argument is of typ=
e 'const Elf64_Sxword *' {aka 'const long int *'}
   56 | static inline void __endian(const void *src, void *dest, unsigned i=
nt size)
      |                                              ~~~~~~^~~~
scripts/mod/modpost.c: In function 'section_rel':
scripts/mod/modpost.h:66:24: warning: passing argument 2 of '__endian' disc=
ards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
   66 |         __endian(&(x), &(__x), sizeof(__x));                    \
      |                        ^~~~~~
scripts/mod/modpost.c:1472:28: note: in expansion of macro 'TO_NATIVE'
 1472 |                 r_offset =3D TO_NATIVE(rel->r_offset);
      |                            ^~~~~~~~~
scripts/mod/modpost.h:56:52: note: expected 'void *' but argument is of typ=
e 'const Elf64_Addr *' {aka 'const long unsigned int *'}
   56 | static inline void __endian(const void *src, void *dest, unsigned i=
nt size)
      |                                              ~~~~~~^~~~

Introduced by commit

  367df0e19c67 ("modpost: factor out the common boilerplate of section_rel(=
a)")

--=20
Cheers,
Stephen Rothwell

--Sig_/a8ztTWT2wsREURC2p4NIvm+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUcoDQACgkQAVBC80lX
0Gxg6Af+JtRc4LrnSh+Qnxwhh+eaK7xAkASQdSUIiTv40g29e45vjDI9W0u9AKMZ
NVh7EvZ6ELxNq/+UL86xHcbhQmv4BdpA+vCcdEIFeUJVKIckBnH5zsNJNuyhKciZ
t38wfjAK6L9Jpp4hVb/nmPCpke3PTYRigfmogDjTb3cKA0V91xcAOUhIwO0FU94x
oDSD6wnjtcbMNo/cCyivuQqfiKdA/LyWRVRhPSvFl29Mag7KusJ3E06Nh5XW8dMg
i0s8ejSo9705GWPhWJCfzvdw6daZ8/2PBxVAOt6Hv8+cG6xDWL0CQYY15RwwLh8i
XBZwZupUMdmOAGBx9Bs0Ui1sHohbWw==
=nA1H
-----END PGP SIGNATURE-----

--Sig_/a8ztTWT2wsREURC2p4NIvm+--
