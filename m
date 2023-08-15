Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4A577C49B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjHOAqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjHOAqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:46:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900A81710;
        Mon, 14 Aug 2023 17:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692060366;
        bh=me3eybes+zlcQcUJ/EfBqYdNpJbT4a+804ymVsF9GKA=;
        h=Date:From:To:Cc:Subject:From;
        b=QnnXLZEFx8Xr2fXzmoPDfZb99yTgP0gAvmhX30Rbm6yt88a1GNSWsillOcwqz6NFv
         QI6poxt3OiFolNVt1qxP11z7LD9MQS07DEHeOTzJ23Yop0b5rpMpeytVEtGUnY7sCY
         Qcn1EPL1+hn2BLZLyFeFAlAPVIhvx5oPqlymvIi99+UnqpqkMCWqFrQlw2Ff0KDsk9
         mmSrIEY/FYFdgxICg3BgdcaQrkekcsnHeWePUt96vJ50DJ9CS0KunVEjD5QcKIDbB/
         H8Vc3k1PwgL70Z5NwpUjNSWoDSvoq7M6J8FMzQZ+gm6szpuzWp8NPkmcPetgpZzUbX
         9J+YeSuSB7Fkw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPsyP22Lnz4wb5;
        Tue, 15 Aug 2023 10:46:05 +1000 (AEST)
Date:   Tue, 15 Aug 2023 10:46:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guo Ren <guoren@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: linux-next: manual merge of the csky tree with the mm tree
Message-ID: <20230815104604.54f65293@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GzS8aiehNO2LkT=uczdgajv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GzS8aiehNO2LkT=uczdgajv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the csky tree got a conflict in:

  arch/csky/abiv2/cacheflush.c

between commit:

  1222e1310d64 ("csky: implement the new page table range API")

from the mm tree and commit:

  1362d15ffb59 ("csky: pgtable: Invalidate stale I-cache lines in update_mm=
u_cache")

from the csky tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/csky/abiv2/cacheflush.c
index d05a551af5d5,500eb8f69397..000000000000
--- a/arch/csky/abiv2/cacheflush.c
+++ b/arch/csky/abiv2/cacheflush.c
@@@ -16,23 -15,22 +16,22 @@@ void update_mmu_cache_range(struct vm_f
 =20
  	flush_tlb_page(vma, address);
 =20
 -	if (!pfn_valid(pte_pfn(*pte)))
 +	if (!pfn_valid(pfn))
  		return;
 =20
 -	page =3D pfn_to_page(pte_pfn(*pte));
 -	if (page =3D=3D ZERO_PAGE(0))
 +	folio =3D page_folio(pfn_to_page(pfn));
 +
 +	if (test_and_set_bit(PG_dcache_clean, &folio->flags))
  		return;
 =20
 -	if (test_and_set_bit(PG_dcache_clean, &page->flags))
 -		return;
 +	for (i =3D 0; i < folio_nr_pages(folio); i++) {
 +		unsigned long addr =3D (unsigned long) kmap_local_folio(folio,
 +								i * PAGE_SIZE);
 =20
 -	addr =3D (unsigned long) kmap_atomic(page);
 -
 -	icache_inv_range(address, address + PAGE_SIZE);
 -	dcache_wb_range(addr, addr + PAGE_SIZE);
 -
 -	kunmap_atomic((void *) addr);
++		icache_inv_range(address, address + PAGE_SIZE);
 +		dcache_wb_range(addr, addr + PAGE_SIZE);
- 		if (vma->vm_flags & VM_EXEC)
- 			icache_inv_range(addr, addr + PAGE_SIZE);
 +		kunmap_local((void *) addr);
 +	}
  }
 =20
  void flush_icache_deferred(struct mm_struct *mm)

--Sig_/GzS8aiehNO2LkT=uczdgajv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTayswACgkQAVBC80lX
0GxXkAf9GMiFShF9ez6ykv7Q6ku8QmQvWbaAzMsvP81f9sfUtEbqbmwwBoB2iFyr
UsgU0hotkuy0lXCkYXzGIDCP3zTcC2/atiQMrnMPyoQwESp3JR460eFVzaw2MFrj
2wNCdLubygnoCeLm4eGdHlc+v5YlHRIY7njZdS0C2kaaQg9nQtR+FDVfftC9DcVg
5NBb3JE5BZaEZn26MTsFhvyQiv7dplZtnpHzdpmFPjPwh+bD4U1LIhzg19UpPeD6
vz5pF6FA3uQX6Kr87Ax/p4BLSuIDWqWQ4vTyGDxF3GUki/983p5S948GoIPat0hO
FAzDmkTuMaqQkt8DMjg2e33gPQWxGg==
=GZzy
-----END PGP SIGNATURE-----

--Sig_/GzS8aiehNO2LkT=uczdgajv--
