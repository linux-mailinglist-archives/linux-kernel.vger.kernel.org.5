Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A5E7F977C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjK0C2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjK0C2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:28:10 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03904C5;
        Sun, 26 Nov 2023 18:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701052092;
        bh=qhOqTKNBi/EFmiADHd5ayMEH+8UZij1qQS+GarSvOk8=;
        h=Date:From:To:Cc:Subject:From;
        b=LhNCEe3skKSb/ECq4ppTKq8aHTaRWKOeb+3+Du8FdQ27ddNvgc6GPe0sPt7OQYk7j
         s4ToPmGWPchF1qiRJr31AjSpZmgZPvMFCftOdTOuE5BB+K2Chuhzn6IKiSIXm23h9h
         FO/pK2udynSyu8+5gIFfiKkbbH7v1W2+FAuW/w9E4DPmQ3d3gHMTY3NEgCAhRFCV79
         hblnISeNqVKlM3SQPei03+PaOkjmLREgeg8Qs+d9oTdDJeKpRh9R1PkIziilbTI98i
         N9FbQE2RuXOjbN6Xnb7FuT/9kb40ofY2ihmEmvBO5DMZCMfT3U+lccXjTdrzBnSSGI
         idGhksHo7LcQA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SdqJC5XRsz4wcJ;
        Mon, 27 Nov 2023 13:28:11 +1100 (AEDT)
Date:   Mon, 27 Nov 2023 13:28:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20231127132809.45c2b398@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//JC9PMS_qqHdMn+RHzl7VN.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//JC9PMS_qqHdMn+RHzl7VN.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc64
allnoconfig) failed like this:

arch/powerpc/mm/book3s64/pgtable.c:557:5: error: no previous prototype for =
'pmd_move_must_withdraw' [-Werror=3Dmissing-prototypes]
  557 | int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
      |     ^~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  c6345dfa6e3e ("Makefile.extrawarn: turn on missing-prototypes globally")

I have added the following patch for today (which could be applied to
the mm or powerpc trees):

=46rom 194805b44c11b4c0aa28bdcdc0bb0d82acef394c Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 27 Nov 2023 13:08:57 +1100
Subject: [PATCH] powerpc: pmd_move_must_withdraw() is only needed for
 CONFIG_TRANSPARENT_HUGEPAGE

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/book3s64/pgtable.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/=
pgtable.c
index be229290a6a7..3438ab72c346 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -542,6 +542,7 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma=
, unsigned long addr,
 	set_pte_at(vma->vm_mm, addr, ptep, pte);
 }
=20
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * For hash translation mode, we use the deposited table to store hash slot
  * information and they are stored at PTRS_PER_PMD offset from related pmd
@@ -563,6 +564,7 @@ int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
=20
 	return true;
 }
+#endif
=20
 /*
  * Does the CPU support tlbie?
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_//JC9PMS_qqHdMn+RHzl7VN.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVj/rkACgkQAVBC80lX
0GxGEwf/WzdRnWh92onGJMdaj8YGBZo1ubNgvxb0d+sEfSNZYTUqDHtXT7fEKOby
I8Ps208c+rIIXcJ1liNKHhpqCgePqwWIoylwLLStLplg+2Ohi3fODQFTR5XRBmVY
J596F5FfPJeKs13eBSgMBp7wuE5vD5YMmHgFHutGlUkakmLGQNMmdJBL7IVxRyyf
J/t974Rnp/hodhQfvYdpvxCJW6GB5gQVQQEdjn7mnePTnm6A6CdYEfeGlAFlHlk6
EB0+BjQh4SmUAStecJ6f1Q9O0z2gY0QaEQYBZVYrB3+7ppGMFOO43n7XoSbkBGSE
GTN1l6RNX1P6F9MNBJoy8/zmNSB++A==
=lVkl
-----END PGP SIGNATURE-----

--Sig_//JC9PMS_qqHdMn+RHzl7VN.--
