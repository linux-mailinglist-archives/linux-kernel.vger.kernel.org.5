Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F03762BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGZGvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGZGvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:51:42 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302811990;
        Tue, 25 Jul 2023 23:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690354299;
        bh=CUeLls7WOsjmZP9qyjq2DPHqSWyd21lUGxXgzDhxtdA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uKzkhMbVzoPHoWeL3oE+AGunVEOJpLLT7yRPEZj6FULvzHVgsU6e8hoc7IKZ43n7a
         XKIWitTf76nHHINLAY3uqQEJfKN0VwKSGKJGC44mQPe78Zy3PWjbR1o3q0HqGqkY2E
         GjQtX6QZp1XVGrnS3MIamn80us8jMJV9sZSID/YBNTmyyCJhIqyoXFG8UpkyAo/C3O
         QARAmhXtmqclQEuq2L2A9UgBS2bI0RujJiKn7vzcX4xFKrYZK8zPIsmqjvbzjveZzv
         eXVmTV0L17UIMziCs5qaJFxmYeUT9uITxbpKytWC9OJB3T0j0cOe5pLCpo4gbBoFg9
         VfZEFyrC1ItpQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R9l1R2Vspz4wjG;
        Wed, 26 Jul 2023 16:51:39 +1000 (AEST)
Date:   Wed, 26 Jul 2023 16:51:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20230726165137.49b17052@canb.auug.org.au>
In-Reply-To: <87zg3jw8km.fsf@linux.ibm.com>
References: <20230726145356.5e42830f@canb.auug.org.au>
        <87zg3jw8km.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GzwxIJZ+QWoVLtUro6OlHGt";
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

--Sig_/GzwxIJZ+QWoVLtUro6OlHGt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Aneesh,

On Wed, 26 Jul 2023 10:52:33 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.i=
bm.com> wrote:
>
> Thanks for the report. Can you add the below diff. We should look at
> ppc64 not including radix headers if CONFIG_PPC_RADIX_MMU is disabled.
> But for now we can keep the below diff?
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/in=
clude/asm/book3s/64/radix.h
> index 3195f268ed7f..357e23a403d3 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -364,8 +364,10 @@ int radix__remove_section_mapping(unsigned long star=
t, unsigned long end);
> =20
>  void radix__kernel_map_pages(struct page *page, int numpages, int enable=
);
> =20
> +#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
>  #define vmemmap_can_optimize vmemmap_can_optimize
>  bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap=
 *pgmap);
> +#endif
> =20
>  #define vmemmap_populate_compound_pages vmemmap_populate_compound_pages
>  int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,

That fixes the powerpc64 allnoconfig build for me

--=20
Cheers,
Stephen Rothwell

--Sig_/GzwxIJZ+QWoVLtUro6OlHGt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTAwnkACgkQAVBC80lX
0GzFIgf/YKo1V7FRGFPIkWmBx/XCCEwRYCsb5lWIDgfn2NtKIMnaXAD1D3AH/NaA
1p6la2Euqb3jUeW838FmqIIkHpHSqoEgRoxCN+19++dFjG/+u3GiaxIyL1c0MNdu
+jyOhSDT8uCmHHt1hj6J3eSJfybsaDtsQCYpMHfZa5sJiTyLT9pWSZriTfP/p31P
q3AK9rkRkb7hBjR6tixk048a9HbJBAPtBMN5D1kmxL2VNZCCWlzvxTE+5c0D8c+Z
KXCHyXIvBphMEQlhaPQWf/a6ddOZqAxKCymS/Is5O4zn2qGDfskBUDLOnCIb44lg
mN1iqZbXCO4ncNA76dSTxKS35WgyDg==
=3iJm
-----END PGP SIGNATURE-----

--Sig_/GzwxIJZ+QWoVLtUro6OlHGt--
