Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865987D60EE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 06:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjJYEo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 00:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJYEoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 00:44:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAA09D;
        Tue, 24 Oct 2023 21:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698209061;
        bh=eZaO9fpaQtji7iLDzW5eW+yJsGU0yPYdhQ1Im0uTBXY=;
        h=Date:From:To:Cc:Subject:From;
        b=A/kR7n4Fqm+3+zX8QhC1OL94pWVBzrjn0966h8GQg5NF+nHdkyMLlLKva4KDX8V8J
         bCmC2UG8Ru/E+TMStx96l158icAiWj1nO5CbjqhjVeX773M+YRPXaamavdn22RruBY
         cIvDQ/ECYMc/Sa9g4Cb+wq1OMxwoBZChhGUuhy7ZU/YoMRKio5Egfpy/H7bp7jDwIn
         K8t5GIP1U1vlKClws8tPJwQQuvQo/mQj3H3HrLmLb4acmmVAzEupk8UyNKBwcvod87
         8/1DaQMnEwuhbggOYr2dYBlOjjnZ5ois8aOB4mccY3MgddCdNDVHzp46eFuGCsAP/C
         004nXsmwcJBaQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFbtX3Zgvz4wcc;
        Wed, 25 Oct 2023 15:44:20 +1100 (AEDT)
Date:   Wed, 25 Oct 2023 15:44:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20231025154420.718e27af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2_R1etV5rzCjR+kCHxkEtiB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2_R1etV5rzCjR+kCHxkEtiB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommufd tree got a conflict in:

  include/linux/iommu.h

between commits:

  1c68cbc64fe6 ("iommu: Add IOMMU_DOMAIN_PLATFORM")
  4601cd2d7c4c ("iommu: Add ops->domain_alloc_paging()")

from the iommu tree and commits:

  1621aef1fbfe ("iommu: Add IOMMU_DOMAIN_NESTED")
  909f4abd1097 ("iommu: Add new iommu op to create domains owned by userspa=
ce")
  17dd7701a2e7 ("iommu: Pass in parent domain with user_data to domain_allo=
c_user op")

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

diff --cc include/linux/iommu.h
index b5b254e205c6,f347bf31761f..000000000000
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@@ -64,8 -66,10 +66,11 @@@ struct iommu_domain_geometry=20
  #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
 =20
  #define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
 +#define __IOMMU_DOMAIN_PLATFORM	(1U << 5)
 =20
+ #define __IOMMU_DOMAIN_NESTED	(1U << 5)  /* User-managed address space ne=
sted
+ 					      on a stage-2 translation        */
+=20
  #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
  /*
   * This are the possible domain-types
@@@ -94,7 -96,7 +99,8 @@@
  				 __IOMMU_DOMAIN_DMA_API |	\
  				 __IOMMU_DOMAIN_DMA_FQ)
  #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
 +#define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
+ #define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
 =20
  struct iommu_domain {
  	unsigned type;
@@@ -238,9 -327,19 +331,21 @@@ static inline int __iommu_copy_struct_f
   *           op is allocated in the iommu driver and freed by the caller =
after
   *           use. The information type is one of enum iommu_hw_info_type =
defined
   *           in include/uapi/linux/iommufd.h.
-  * @domain_alloc: allocate iommu domain
+  * @domain_alloc: allocate and return an iommu domain if success. Otherwi=
se
+  *                NULL is returned. The domain is not fully initialized u=
ntil
+  *                the caller iommu_domain_alloc() returns.
 + * @domain_alloc_paging: Allocate an iommu_domain that can be used for
 + *                       UNMANAGED, DMA, and DMA_FQ domain types.
+  * @domain_alloc_user: Allocate an iommu domain corresponding to the input
+  *                     parameters as defined in include/uapi/linux/iommuf=
d.h.
+  *                     Unlike @domain_alloc, it is called only by IOMMUFD=
 and
+  *                     must fully initialize the new domain before return.
+  *                     Upon success, if the @user_data is valid and the @=
parent
+  *                     points to a kernel-managed domain, the new domain =
must be
+  *                     IOMMU_DOMAIN_NESTED type; otherwise, the @parent m=
ust be
+  *                     NULL while the @user_data can be optionally provid=
ed, the
+  *                     new domain must support __IOMMU_DOMAIN_PAGING.
+  *                     Upon failure, ERR_PTR must be returned.
   * @probe_device: Add device to iommu driver handling
   * @release_device: Remove device from iommu driver handling
   * @probe_finalize: Do final setup work after the device is added to an I=
OMMU
@@@ -275,7 -372,9 +380,10 @@@ struct iommu_ops=20
 =20
  	/* Domain allocation and freeing by the iommu driver */
  	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
 +	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
+ 	struct iommu_domain *(*domain_alloc_user)(
+ 		struct device *dev, u32 flags, struct iommu_domain *parent,
+ 		const struct iommu_user_data *user_data);
 =20
  	struct iommu_device *(*probe_device)(struct device *dev);
  	void (*release_device)(struct device *dev);

--Sig_/2_R1etV5rzCjR+kCHxkEtiB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU4nSQACgkQAVBC80lX
0GzuGwf/a5Qrp7MTssRYjN59+BHB0B9kOwo/YsfBQsuqTIV4QIGaVobvw/8cShVD
OLb96Yw2E5YDogZeIcLqnDkGwsUgwtEn3gkGEFF6CF/g8UuTooHvu3d6ZV70bvuv
sXPKDe/xvy8nNFpedbavpoSHjRbD+eNz31BCfyEKSvRwDgOWA+UbeifUPmgU3Hvr
KVQiEinGvwxy9DpjOsDOU7ghUeJj7Y50SGtOUhkZbsiJBRWRA1xKJA3dtv1lUPB2
6L77W/L8O7w1Kqp3Vavu8rYXexmbeX4sOnUqDhvZXfWrRSWQJNJ0qfmzCn7fYPul
jrcS8e9Kc0qB+d1Z0qXiK9pdL9l0BQ==
=DnE6
-----END PGP SIGNATURE-----

--Sig_/2_R1etV5rzCjR+kCHxkEtiB--
