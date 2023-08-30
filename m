Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26FB78E345
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344476AbjH3X3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbjH3X3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:29:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26BDBC;
        Wed, 30 Aug 2023 16:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693438155;
        bh=Tu7XsOYuVncE94hnJYbLF/6rnpC9u35K2EVAF6+C8wI=;
        h=Date:From:To:Cc:Subject:From;
        b=pDMTdY0v1BBSBgcwj0vgbrb3tFiptI8+aZByFRbqAVokLoUzHfzgntba9ZRZPol+e
         nSD0Dvc5kN2yQzIEHs9XuGH/V0QUrKXVbflkJwT33oJNExn5KlewN3dchjPH4NcsHD
         DyvvF+vV9NhKYNEMypXRrZvix1KRe9nJPt70wm9jjUD7BWfq1AhHaBDcStSdH7SsU4
         +i6iFVvK6yBHM98FJvmFmpo2zGqt+tm0wbG30lR4TwoTRAMVuEMNGdMk6siDAUGXhu
         xQY+da7p8fcXeS4fUowtb3zM9kUjs6T60KG37+xvD35eQFMj7wxNaAyBEipYMxKjhf
         dWVjdnG0DXuYw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RbgVM2wzfz4wbP;
        Thu, 31 Aug 2023 09:29:15 +1000 (AEST)
Date:   Thu, 31 Aug 2023 09:29:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20230831092914.4f91cd33@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cVUf8VTt6BeYXVNxI0K+Wr_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cVUf8VTt6BeYXVNxI0K+Wr_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/mm/kasan_init.c

between commit:

  d2402048bc8a ("riscv: mm: fix 2 instances of -Wmissing-variable-declarati=
ons")

from Linus' tree and commit:

  56e1803d9de0 ("riscv: Mark KASAN tmp* page tables variables as static")

from the risc-v tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/riscv/mm/kasan_init.c
index a01bc15dce24,435e94a5b1bb..000000000000
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@@ -22,9 -22,10 +22,9 @@@
   * region is not and then we have to go down to the PUD level.
   */
 =20
- pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
- p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
- pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;
 -extern pgd_t early_pg_dir[PTRS_PER_PGD];
+ static pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
+ static p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
+ static pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;
 =20
  static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, un=
signed long end)
  {

--Sig_/cVUf8VTt6BeYXVNxI0K+Wr_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTv0MoACgkQAVBC80lX
0GyYJAf6AuPhSTq/XiQ/aoFNK6nyQruoHzfP+qOBnzg063GMtRotYIMwnOBzMsSo
f9JwtyQZbEp8un04wKeYo1zWs3QhgfUpXDnvYwWgqhgh9zcJFPP8dJiuI/N8geY6
xRgD1DfRx6qp6sbArhhahn1znzfH3gWgJbO/5lC3WvwZYLu6hyz2A8xt3gB7Tx/r
Gw3gc2eTuR/JOfElOZy3YI6caIzNAFsyzbyLOLeFXg5HmnKWi6r9nt0QU7Dh5FBU
oM1HnXmmR9Enb8sS/KorZckERaxQdR8f3qA22KIFM9UjowHvjoThg+uiNQwcvwr6
Bab+9eR8y3lX7ZN7Xp7Lm9PH6C4S/Q==
=hRJR
-----END PGP SIGNATURE-----

--Sig_/cVUf8VTt6BeYXVNxI0K+Wr_--
