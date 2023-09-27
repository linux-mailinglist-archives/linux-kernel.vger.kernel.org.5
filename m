Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614567B0F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 01:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjI0XWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 19:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI0XWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 19:22:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882C0F4;
        Wed, 27 Sep 2023 16:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695856956;
        bh=zhfsFs/91UsszYRV8XiJIBCUPhlph09fGzAxjulnJ6k=;
        h=Date:From:To:Cc:Subject:From;
        b=V9vEoTj9uA4NaNN66VXUAWsrZfxuE4MRR4qck0EFI+m8H9YEsJxlOC5sWUQVhkJwx
         rTfCUZjo9JaeJvL8fBQWfpFL1o0jjsMQXQdkICmWL/vVES2BqlVxFS2qr83WKxdDtk
         /WxfpVlYZalxRGFSRzJgSQQ+iHzh4atAV2rA4AdQjdDMHgRuxROL0PQV1zwQv6SKIB
         uo2mZpeXLIE+TLD+2rLqVGpNqx2DMvwschaLkl1XDDQwZJLdJJ86P8FCWLeeLYpA94
         WjFRxVSkVLqf9dqfKh4PGvfql4YsyNyC3oay0sS1j4hwSceVpvFKY1qydAaJOTflBq
         BZvPqlVisW47A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rwt1l1xXZz4xG0;
        Thu, 28 Sep 2023 09:22:35 +1000 (AEST)
Date:   Thu, 28 Sep 2023 09:22:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230928092223.0625c6bf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/exW3gC+VgL.pg5p8Sn2c+VL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/exW3gC+VgL.pg5p8Sn2c+VL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

fs/proc/task_mmu.c: In function 'pagemap_scan_pmd_entry':
fs/proc/task_mmu.c:2153:22: error: implicit declaration of function 'pagema=
p_scan_is_interesting_page'; did you mean 'pagemap_scan_is_interesting_vma'=
? [-Werror=3Dimplicit-function-declaration]
 2153 |                 if (!pagemap_scan_is_interesting_page(categories, p=
))
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                      pagemap_scan_is_interesting_vma

Caused by commit

  825ebc8e4bf9 ("fs/proc/task_mmu: hide unused pagemap_scan_backout_range()=
 function")

I applied the following fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 28 Sep 2023 09:09:26 +1000
Subject: [PATCH] fix for "fs/proc/task_mmu: hide unused pagemap_scan_backou=
t_range() function"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/proc/task_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fdad3536d8ab..d4ef9a2bf95d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1940,6 +1940,7 @@ static void make_uffd_wp_huge_pte(struct vm_area_stru=
ct *vma,
 		set_huge_pte_at(vma->vm_mm, addr, ptep,
 				make_pte_marker(PTE_MARKER_UFFD_WP), psize);
 }
+#endif /* CONFIG_HUGETLB_PAGE */
=20
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLB_PAGE)
 static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
@@ -1954,7 +1955,7 @@ static void pagemap_scan_backout_range(struct pagemap=
_scan_private *p,
=20
 	p->found_pages -=3D (end - addr) / PAGE_SIZE;
 }
-#endif /* CONFIG_HUGETLB_PAGE */
+#endif
=20
 static bool pagemap_scan_is_interesting_page(unsigned long categories,
 					     const struct pagemap_scan_private *p)
@@ -1967,7 +1968,6 @@ static bool pagemap_scan_is_interesting_page(unsigned=
 long categories,
=20
 	return true;
 }
-#endif
=20
 static bool pagemap_scan_is_interesting_vma(unsigned long categories,
 					    const struct pagemap_scan_private *p)
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/exW3gC+VgL.pg5p8Sn2c+VL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUUuS8ACgkQAVBC80lX
0Gz2NAf7BSq5rSHp4iPeMG8uICJaxX4PAOHsvghAlh1Q7ktGHmz0p7BBSS3dC2nK
KkBAp0xg07y60mCimE8gyHUDlzbStzBxGT03fyn3oxdOXjwlVkdl5T4HKLWDvAYB
nb/fG557+ANmdmSYMRx2XcDSdnB9YSO7vUcmJ9rCqEe18mp8c5Z2HuAijrhEG5ZM
X6Em0t41u3v1vZtLpXE96ERAYh0VOktmZSWvfpNNTZapOGm1qNdubnMnG+fTsra/
/x0m8AckmxJjD9wdoEV0Fr58e34AdChR71ycli1g3TbsoG3IQo4ltauIU0HVfxjR
wk7kCbrJqXTbiLs1DqU5Hh5Q9ZVV/A==
=/4/u
-----END PGP SIGNATURE-----

--Sig_/exW3gC+VgL.pg5p8Sn2c+VL--
