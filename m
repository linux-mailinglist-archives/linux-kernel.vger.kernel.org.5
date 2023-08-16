Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94FC77DA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbjHPGV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242094AbjHPGVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:21:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14341FE6;
        Tue, 15 Aug 2023 23:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692166892;
        bh=/iSCmK2tnYDnc36gyD4blrwQea0I/4VHBMzwnihB6dA=;
        h=Date:From:To:Cc:Subject:From;
        b=gC3GNo1zQWWIZhRbfOc4LpUpupSaUBcnOIIzcFg/Kcj5Z7Bugegg1AzLdpQjXvdq0
         q8VKfXZi59Xz37Ro3GBgviDLYOg+9h6V/IzDJcDXyThhjOf/A84TVfS9zQFwuffSHm
         v4UpEuE/lRXMBrxXJeZaCakWQKJrwqd06qkUKK3TOrJgb58+xyTTi7x3fQXiXM6gTj
         pANV8oTlDsrAsFJu9P31+MgoRbbChn2o2d7ds3flNo18i3N0ugtnwQIHdEgAAnKhTq
         tCy5VdL/ukOwFZ4b/19bvf/eoRjfYfoNRQ1KtDqFAmcVYwTdtIkipYhzWehyXbz0Cf
         uefmXUWh6iovw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQdLz34vjz4wb0;
        Wed, 16 Aug 2023 16:21:31 +1000 (AEST)
Date:   Wed, 16 Aug 2023 16:21:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yi Liu <yi.l.liu@intel.com>
Subject: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20230816162128.58ef5475@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+qfPmgKRJ2GBp4NPXf/ebuy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+qfPmgKRJ2GBp4NPXf/ebuy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommufd tree got a conflict in:

  include/linux/iommu.h

between commit:

  2b4de976b360 ("iommu: Pass in the iommu_device to probe for in bus_iommu_=
probe()")

from the iommu tree and commit:

  c64805327b7d ("iommu: Move dev_iommu_ops() to private header")

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
index 411ce9b998dc,f2d6a3989713..000000000000
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@@ -460,19 -459,7 +469,8 @@@ static inline void iommu_iotlb_gather_i
  	};
  }
 =20
- static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
- {
- 	/*
- 	 * Assume that valid ops must be installed if iommu_probe_device()
- 	 * has succeeded. The device ops are essentially for internal use
- 	 * within the IOMMU subsystem itself, so we should be able to trust
- 	 * ourselves not to misuse the helper.
- 	 */
- 	return dev->iommu->iommu_dev->ops;
- }
-=20
 -extern int bus_iommu_probe(const struct bus_type *bus);
 +extern int bus_iommu_probe(const struct bus_type *bus,
 +			   struct iommu_device *iommu);
  extern bool iommu_present(const struct bus_type *bus);
  extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
  extern bool iommu_group_has_isolated_msi(struct iommu_group *group);

--Sig_/+qfPmgKRJ2GBp4NPXf/ebuy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTcaugACgkQAVBC80lX
0GxlcQf/dIAfWrW9jtxjgUQEvcmNC1uwLl/YnkdZ8o2nYrs/TlAVEJWVCs13x8N8
8AJ/kBKRqeQserJif6ZGnLS/DaOGETD9fcsiOqn0y9FTTMNoCFO40p+Wo59Wro/V
aJqrJzKhm5+w+uSjW7YmbKtRy2VSRXFXbOtXGj2ZKKGMFeFSb30UOm6npG/J8s1v
+GL94NlP3os6NE4FEjRcvlSOuDHF49gyvxGy/Iy6rG3XzZz6Ez8m/kadMDuxoiTH
ZGYpGhvTNXa3EvYsaqBkpZjgzIAZ0w85NQJ+Vr6wYSZlmNa2AtLO6ZNVWAgoWKEk
Cz2VH/+beViwD4N4+3L9VxByzw2zzQ==
=bglV
-----END PGP SIGNATURE-----

--Sig_/+qfPmgKRJ2GBp4NPXf/ebuy--
