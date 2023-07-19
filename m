Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D41D758CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 06:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjGSEkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 00:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSEkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 00:40:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE841BE3;
        Tue, 18 Jul 2023 21:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689741593;
        bh=mpYeohI8Pee874UkThW3F2XXH1ckXk34XfZjDU3yDCY=;
        h=Date:From:To:Cc:Subject:From;
        b=ccikDY8fHhsUIxO7guMIKt75vc+L2Xz8s6pCl0SFgtjrUZaSlGlYx5zIFOjXA818t
         gThsviw3ejGyZE6X7ZgxKAdwTMxBkWjQjxTVWjpsSY19MHmk7WAZcDJB9OQ356UChb
         owjpBYRCdI0Tt+hBkt1kZjAmf+QLsRWqIxnUl+ki6HKaioy0nuCybJRf/L/wea6kkw
         x81cD7B/KxLZ00q+5dLeDomnsjl+HGRfuSnnY0zGbv3g0QQECJogbvgOUt9cTlM8Px
         mDvuggzPOQr0FeDHuqwQAC7dAF0fqai9KNhjAJr4xYnlsDuwu5lnFCfBNfH3/FQjnB
         gnFUaA2TJHOEA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R5NQd5cWVz4wqW;
        Wed, 19 Jul 2023 14:39:53 +1000 (AEST)
Date:   Wed, 19 Jul 2023 14:32:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230719143233.1c283b0e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k1bVQ0vzWFCmPomiZwkRQEo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k1bVQ0vzWFCmPomiZwkRQEo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm64 defconfig)
failed like this:

In file included from arch/arm64/include/asm/pgtable.h:15,
                 from include/linux/pgtable.h:6,
                 from arch/arm64/include/asm/io.h:12,
                 from include/linux/io.h:13,
                 from include/acpi/acpi_io.h:5,
                 from include/linux/acpi.h:37,
                 from include/acpi/apei.h:9,
                 from include/acpi/ghes.h:5,
                 from include/linux/arm_sdei.h:8,
                 from arch/arm64/kernel/asm-offsets.c:10:
arch/arm64/include/asm/tlbflush.h: In function '__flush_tlb_page_nosync':
arch/arm64/include/asm/tlbflush.h:268:53: error: 'vma' undeclared (first us=
e in this function); did you mean 'cma'?
  268 |         mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, uad=
dr & PAGE_MASK,
      |                                                     ^~~
      |                                                     cma

Caused by commit

  8c2be11e06f4 ("mmu_notifiers: call arch_invalidate_secondary_tlbs() when =
invalidating TLBs")

I have reverted that commit (and the following clear
one and the two
earlier ones - otherwise it would not buildfrom) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/k1bVQ0vzWFCmPomiZwkRQEo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS3Z2EACgkQAVBC80lX
0GwCoQgAkhhBDK+wlGb4T/EIvai7HvIgBz9nPfGZSylRvF1peiecKDfM98cDuce2
KvvFcjqk5Nbnoz9xAfW0dZgL66e8n7yr/6s+8m0Z4K4d+DTukLl0pvZwjC2cc+95
kyrErlbi5xU4w9dn4XISeNOv4tT0iBBwHCAJGjzBVHmwheCWrKEe7qRcukPB1T4P
Sv+jli9IxZKP1qqgKbGtXQXcvUrklggtLeAAdGVR2CJ1Rj4FMFFEOMKhIOQoAXuI
hj/XblywZ6KroS5z3hYz2O+ZVKoHPayHmryXeb4Q7WQFk+vWYFiEEjirG5FdhhMa
m9Kbzwj7SuKPtK9/oWKMgvh/YGx8Cg==
=GYdN
-----END PGP SIGNATURE-----

--Sig_/k1bVQ0vzWFCmPomiZwkRQEo--
