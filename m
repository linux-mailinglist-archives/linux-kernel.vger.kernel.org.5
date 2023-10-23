Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFB67D2982
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 06:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjJWE4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 00:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWE4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 00:56:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAC0E8;
        Sun, 22 Oct 2023 21:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698036971;
        bh=Ke4ba6atseiCGvNMRr/6znd5xtFRbtHUZz7Nfd0RhdA=;
        h=Date:From:To:Cc:Subject:From;
        b=LLO7UO65CQSyEzJX1LilTBbq237FrMpbkgF4VAnw07wbiFcUpFESRACMoy//fZSH0
         CDUyM5y9il2yconpoCpwR7YGEktpMn0lxbs6Mt304gTFNmId/ZEEml9ApLPQLEv1ww
         C2A0/wEOZ7u0vM5oUpHGp2HGXqjzWl6Zw9O7zNpppPGlAjtPAgnWUfHvWMCWprkYHx
         kwp2Ohji9ldBpEjtdrsQXC4X0xNcEm2hS940mRtro7S21if/ziPWD3SmhOY98vHzen
         pO85SMgYKK22EtlZllljJ0zicgHJzKbahkABNFy3vgF82QiPqDLs3T2LLmf7woUWBA
         //ff/B+PpmZLg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDNF44qKcz4wcN;
        Mon, 23 Oct 2023 15:56:08 +1100 (AEDT)
Date:   Mon, 23 Oct 2023 15:56:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20231023155606.247fa998@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i8kNvNtmyJ2frJSNEGZqtf8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i8kNvNtmyJ2frJSNEGZqtf8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommufd tree got a conflict in:

  drivers/iommu/intel/pasid.c

between commit:

  c61c255e114c ("iommu/vt-d: Remove unused function")

from the iommu tree and commit:

  3c576c995219 ("iommu/intel: Access/Dirty bit support for SL domains")

from the iommufd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/iommu/intel/pasid.c
index 06ddb3c927f5,b9264b9174e8..000000000000
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@@ -335,6 -340,45 +340,36 @@@ static inline void pasid_set_fault_enab
  	pasid_set_bits(&pe->val[0], 1 << 1, 0);
  }
 =20
+ /*
+  * Enable second level A/D bits by setting the SLADE (Second Level
+  * Access Dirty Enable) field (Bit 9) of a scalable mode PASID
+  * entry.
+  */
+ static inline void pasid_set_ssade(struct pasid_entry *pe)
+ {
+ 	pasid_set_bits(&pe->val[0], 1 << 9, 1 << 9);
+ }
+=20
+ /*
+  * Disable second level A/D bits by clearing the SLADE (Second Level
+  * Access Dirty Enable) field (Bit 9) of a scalable mode PASID
+  * entry.
+  */
+ static inline void pasid_clear_ssade(struct pasid_entry *pe)
+ {
+ 	pasid_set_bits(&pe->val[0], 1 << 9, 0);
+ }
+=20
+ /*
+  * Checks if second level A/D bits specifically the SLADE (Second Level
+  * Access Dirty Enable) field (Bit 9) of a scalable mode PASID
+  * entry is set.
+  */
+ static inline bool pasid_get_ssade(struct pasid_entry *pe)
+ {
+ 	return pasid_get_bits(&pe->val[0]) & (1 << 9);
+ }
+=20
 -/*
 - * Setup the WPE(Write Protect Enable) field (Bit 132) of a
 - * scalable mode PASID entry.
 - */
 -static inline void pasid_set_wpe(struct pasid_entry *pe)
 -{
 -	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
 -}
 -
  /*
   * Setup the P(Present) field (Bit 0) of a scalable mode PASID
   * entry.

--Sig_/i8kNvNtmyJ2frJSNEGZqtf8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU1/OYACgkQAVBC80lX
0Gz9ggf+PsOZQoqj/mYWFO5ZRm/XgJfvS9W5hSatw5MHZVabtn54FtLG1WNlp3+V
FFA/wGFRouJ/4W0F6MSU2kgjQvvzFQh/dxsBLtCm/VUORM/Qg5+cRrxV4sdfdsIf
Zy9JeIXqYnzkYWeY8X9o9e2XioTb82qWNkMv4zJC8gesUAlbnIN32WyvMaP8y4VU
VFbHTWZSbxa/3fYTPQ5wQEHDlvzwASpiIO3Lhrphqup0J0X1Cph8wYx0oIUv7vS/
eCroqqLp/NN79fHZVbzQdV5kTGP7qDSlxJOLG1xoA+gfQ88psIWzhMu1QVXmyGhd
rBrvf6WKSxRBqlwtycl3xF7pu+iiHQ==
=5G2a
-----END PGP SIGNATURE-----

--Sig_/i8kNvNtmyJ2frJSNEGZqtf8--
