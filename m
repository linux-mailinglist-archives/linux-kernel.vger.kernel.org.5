Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7397C48FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjJKFEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345290AbjJKFEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:04:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB30A98;
        Tue, 10 Oct 2023 22:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697000639;
        bh=K3u8hkJcQqtO+YQvZ3kZU5fcYnwrYeu1GVkzg+7Fdgg=;
        h=Date:From:To:Cc:Subject:From;
        b=PKm7Vnl0FYcA/3EuADgVuW2upi0LvJD4xUR5NVJL6hL3R4ci5S6G2oD1JRjm5vSNd
         1og8cTPiAOdm00Gwdv2bm7oh01YLmyTtQV2W3c5fbstjNKCxvORJWtr+56SGkUJeQ3
         mcw81fHPzr59vx38SLnwMMsw1wXN7QYeOzPALP7oW57N72YSRWltXtCxMe+9I5G3pE
         TM/iiW3evty7xrp7noxBne6jFgUJ5CZ12SPLbkP+5F66wCqPeYyGXPRBoGTcRwnSCD
         Q0JuTz0csEmjBsBbLyTtWzru6JQP7gw9/dLLlT49h+KGLS7Aj5TOzALoQOGOeBDeUm
         217F8yB9qvbFw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S50zd6kPbz4xVW;
        Wed, 11 Oct 2023 16:03:57 +1100 (AEDT)
Date:   Wed, 11 Oct 2023 16:03:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20231011160357.292c84e3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XUsIJ_1_dGcvgRQyzzcdzIk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XUsIJ_1_dGcvgRQyzzcdzIk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommufd tree got a conflict in:

  include/linux/iommu.h

between commit:

  4601cd2d7c4c ("iommu: Add ops->domain_alloc_paging()")

from the iommu tree and commit:

  909f4abd1097 ("iommu: Add new iommu op to create domains owned by userspa=
ce")

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
index 0c4d8ae985ac,3861d66b65c1..000000000000
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@@ -238,9 -234,15 +238,17 @@@ struct iommu_iotlb_gather=20
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
+  *                     Upon success, a domain is returned. Upon failure,
+  *                     ERR_PTR must be returned.
   * @probe_device: Add device to iommu driver handling
   * @release_device: Remove device from iommu driver handling
   * @probe_finalize: Do final setup work after the device is added to an I=
OMMU
@@@ -275,7 -275,7 +283,8 @@@ struct iommu_ops=20
 =20
  	/* Domain allocation and freeing by the iommu driver */
  	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
 +	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
+ 	struct iommu_domain *(*domain_alloc_user)(struct device *dev, u32 flags);
 =20
  	struct iommu_device *(*probe_device)(struct device *dev);
  	void (*release_device)(struct device *dev);

--Sig_/XUsIJ_1_dGcvgRQyzzcdzIk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUmLL0ACgkQAVBC80lX
0Gy9Lwf+KQDkhevSfSMpEi1dI/A1o817/ucreReGCLafDqz4Tnsxs6BBDnu3wQND
cTaUGqTMsJt2Qdd9aa4ZudHhRKqZ4UZbwS3w1yla/6BBsTJl66yO+H5AamfFtGpY
NU8HLZ3JYb5FTaTOYo+IjyUaCB4wzPeI93D1AnHxGENtuO/CkdOerG+rIDw2jAkG
XMKXfXSK/5yF+zhYqCnjC9WaXk6HjKmd5LaUHdHA9DC4+Ay34cAy9hwULWDdB9fL
A6C6TlBCkySAXiQktMPL9Wf4g3+mb9F6lwi06XctW0nO3HA8l/YUYe0SlEGIa9ly
5etszg6I5k5ykd/vl8TI2kpdmUXaIQ==
=T8Qq
-----END PGP SIGNATURE-----

--Sig_/XUsIJ_1_dGcvgRQyzzcdzIk--
