Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6205C7B5E6E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 03:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjJCBET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 21:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjJCBET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 21:04:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB99B4;
        Mon,  2 Oct 2023 18:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696295054;
        bh=xsf9tIw5a6T3R+Pom55EWLjfIAm3f6Ai/hp/EsxCLXE=;
        h=Date:From:To:Cc:Subject:From;
        b=j8twwBzmjkuslN1x5RHY0DwyGNwM4fvJq3AYuF4KDlgktjhRwkkIBPRk9q+j6Pvi/
         Cksp2YV93qdxDwRbOU3RIVakM6blpKd8i5szwyTYlN0Y0GbmynvnekoLmHVvPQ6ngT
         waD/aoQXHRzx1oqV7vDzKNR6vpFGD6gOMl6vjPbXUfgY7MPdmQE+0dKd6e08nJaTDa
         Kq7eFJDcfs7t6Q0NGEe85X7YOT+FRn9rUh34wMX41gXk3LgOrIuYJVreqD7qBtnKEL
         om/wouqNP8Au1lRaY59ExcD2LZkPFIvgxM2Qckce7TM6tr+h1HWddxW0L/pKsvQ8Kd
         W016rKXOW+K7g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S002j1sdWz4xPf;
        Tue,  3 Oct 2023 12:04:12 +1100 (AEDT)
Date:   Tue, 3 Oct 2023 12:04:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joerg Roedel <joro@8bytes.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: linux-next: manual merge of the iommu tree with the asm-generic
 tree
Message-ID: <20231003120410.3c408680@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3jZx8B.5TOmVuygG6eAZsh_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3jZx8B.5TOmVuygG6eAZsh_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommu tree got a conflict in:

  drivers/iommu/Kconfig

between commit:

  cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")

from the asm-generic tree and commit:

  c76c067e488c ("s390/pci: Use dma-iommu layer")

from the iommu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/iommu/Kconfig
index 7f04491ca5f0,3199fd54b462..000000000000
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@@ -91,7 -91,7 +91,7 @@@ config IOMMU_DEBUGF
  choice
  	prompt "IOMMU default domain type"
  	depends on IOMMU_API
- 	default IOMMU_DEFAULT_DMA_LAZY if X86
 -	default IOMMU_DEFAULT_DMA_LAZY if X86 || IA64 || S390
++	default IOMMU_DEFAULT_DMA_LAZY if X86 || S390
  	default IOMMU_DEFAULT_DMA_STRICT
  	help
  	  Choose the type of IOMMU domain used to manage DMA API usage by
@@@ -146,7 -146,7 +146,7 @@@ config OF_IOMM
 =20
  # IOMMU-agnostic DMA-mapping layer
  config IOMMU_DMA
- 	def_bool ARM64 || X86
 -	def_bool ARM64 || IA64 || X86 || S390
++	def_bool ARM64 || X86 || S390
  	select DMA_OPS
  	select IOMMU_API
  	select IOMMU_IOVA

--Sig_/3jZx8B.5TOmVuygG6eAZsh_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUbaIoACgkQAVBC80lX
0Gwf+gf/fTm1ValJxmMBwATFJLZLLpSDO7uf+N2P3c6dYXckucL302QmPaSrX/5w
DyuRSqhnL3EsxK6oMMfSS6HqinSCPjktpnIptMzcan/1WoHAQ1Nr/O1GG1LChK5d
CkdullLHJGhaJqdnZWAkY6/7C17IayZAMJhbdZ5GsERLYlyqibgUpMUOuSbw5UAt
MdRc9J1Pe/KheLMoB1XbDdjOVU5dIbmuj2NAKb4RjvyVqHadCvZMSKo0fzAKstZv
wbQLA4TgUi8K6Pt+E9xoILRjXQVv1j203sEYFgO7rQOsEibrAJnSHlrksb5hArjD
YS15B48Y6yqei1V7VR26fWyaR5OGzQ==
=8ZmM
-----END PGP SIGNATURE-----

--Sig_/3jZx8B.5TOmVuygG6eAZsh_--
