Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089297D42E8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 00:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjJWWwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 18:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJWWwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 18:52:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E4B10C;
        Mon, 23 Oct 2023 15:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698101558;
        bh=uDVePNwDDTDbRfzsnprDIRxTsgybIzbMUcsoxUeD4DA=;
        h=Date:From:To:Cc:Subject:From;
        b=mtvtjRr4cfCweGeA12ZgyrGJVcu2ItsR7BSMXijZUjDFLkpPrxyfuyU5b1flh9qfX
         HZAj4tcHsn19PtIWpJbcf2pVfThPHzBZ/02Ifo833bB33pNSeqh1QZ91kBHgjH/xwK
         S0yH1rde7Eb3ifAxGRlv4mlrJIZsllbP7xMRnqzS4OiGbJ9UfgjIXNfaSeveQPJxfH
         AHbME5kS24wdI0N64BeXr0vG5ZEVPM19YWV2ZS3E89JhW8Wi8kObdIIDjVUXqYm2XW
         qcXoS6+EfJeWwTojLmh47iSY8S7Cpf9tedgde9QXrwg/jthsLM4etLzxRYBmdArRzQ
         kF/81Ngh+VCzA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDr793ZDWz4wcZ;
        Tue, 24 Oct 2023 09:52:37 +1100 (AEDT)
Date:   Tue, 24 Oct 2023 09:52:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the arm64 tree with the mm-stable tree
Message-ID: <20231024095234.1118e7dd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FWjhNS95tLJHwMn92jYguN3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FWjhNS95tLJHwMn92jYguN3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm64 tree got a conflict in:

  arch/arm64/include/asm/tlb.h

between commit:

  55d2a0bd5ead ("mm: add statistics for PUD level pagetable")

from the mm-stable tree and commit:

  3399ee709734 ("arm64: mm: Add support for folding PUDs at runtime")

from the arm64 tree.

Thanks, Catalin for the heads up, I just used your resolution.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/include/asm/tlb.h
index 846c563689a8,771077f34a6c..000000000000
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@@ -96,10 -96,8 +96,12 @@@ static inline void __pmd_free_tlb(struc
  static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
  				  unsigned long addr)
  {
- 	struct ptdesc *ptdesc =3D virt_to_ptdesc(pudp);
 -	if (pgtable_l4_enabled())
 -		tlb_remove_ptdesc(tlb, virt_to_ptdesc(pudp));
++	if (pgtable_l4_enabled()) {
++		struct ptdesc *ptdesc =3D virt_to_ptdesc(pudp);
 +
- 	pagetable_pud_dtor(ptdesc);
- 	tlb_remove_ptdesc(tlb, ptdesc);
++		pagetable_pud_dtor(ptdesc);
++		tlb_remove_ptdesc(tlb, ptdesc);
++	}
  }
  #endif
 =20

--Sig_/FWjhNS95tLJHwMn92jYguN3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU2+TIACgkQAVBC80lX
0Gyf6ggAgwzhaGkHnEsm9ijFDqS87qHIyYWSQJ0gYDCnIn4Lo2bnGjWcFTrtX4xn
WSTdFoMPvTzgXy3cERReSYysR7FgNzjzsLXw2yjIyAZrcYM/VRnXzUukXiYtDrOl
/HePUFKOr6iM+RGOcjL9aWsiteoTsfiIV1kIIl/EEsMHnLLfdFcUnPw45Brm+xiV
gVcBT+817O7DoloufBmnERZqLIu/yN2QmzsHjYad908Ug8dIVgT2innU5Kah8c+t
KjjVxcKeqcPytQZusryPHFaS2mI7xsDS3KI4lCzs5IgCF8sY1JIvi+oBIdb2Q/Q9
AQSBsrj2UoxNw5ErIeniFdCBQ2gUjg==
=uatq
-----END PGP SIGNATURE-----

--Sig_/FWjhNS95tLJHwMn92jYguN3--
