Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B7777CB7A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbjHOLGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbjHOLGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:06:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788701BC3;
        Tue, 15 Aug 2023 04:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692097479;
        bh=MpV688qJIlCJuQL+DVSTSQJKjwVC/kuUS1SFDpx5fHo=;
        h=Date:From:To:Cc:Subject:From;
        b=Mg2sXWQXK7XZdVNWQunVqVS+1b8RHw4rRv0e7IJQEjCf+QfumthoI9ZhVmihwGNkD
         NiDpplI7MXjWz0XyOJIfQXb2o4HS8zJ6g/hkew/rZ3BTpIpKfEXxNiK4L5uSwv2vk4
         gVfTdI8YHhx+6l3tKRZY6SEs5hapVPeCjf6h47OoMQBzYY0FvDoJfoDG4p5tZebZJJ
         pTl5BChA1UOHrFZg4jGBe1xcKYMOpy1AL3/hRF24OCOzCt18nmtW7d/Foih/nsR2i8
         XdJJQ6H2h2Z4uFs8NEqe03Fd8fs1BM9p1J2Ga0w21uVBPaPH2zIhCIOnjIBYcTxsEK
         DvMJW2AbI/+fw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ7h62Bskz4wxW;
        Tue, 15 Aug 2023 21:04:38 +1000 (AEST)
Date:   Tue, 15 Aug 2023 21:04:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the iommufd tree
Message-ID: <20230815210437.12bd89b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mXfwBR3IljITL8fiCzopG_R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mXfwBR3IljITL8fiCzopG_R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the iommufd tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/iommu/iommu.c: In function 'iommu_device_register_bus':
drivers/iommu/iommu.c:335:15: error: too few arguments to function 'bus_iom=
mu_probe'
  335 |         err =3D bus_iommu_probe(bus);
      |               ^~~~~~~~~~~~~~~
In file included from drivers/iommu/iommu.c:20:
include/linux/iommu.h:474:12: note: declared here
  474 | extern int bus_iommu_probe(const struct bus_type *bus,
      |            ^~~~~~~~~~~~~~~

Caused by commit

  23a1b46f15d5 ("iommufd/selftest: Make the mock iommu driver into a real d=
river")

interacting with commit

  2b4de976b360 ("iommu: Pass in the iommu_device to probe for in bus_iommu_=
probe()")

from the iommu tree.

I have applied the following fix up patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 15 Aug 2023 20:50:05 +1000
Subject: [PATCH] fix up for "iommufd/selftest: Make the mock iommu driver i=
nto a real driver"

interacting with commit

  2b4de976b360 ("iommu: Pass in the iommu_device to probe for in bus_iommu_=
probe()")

from the iommu tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 20c9a0501760..1e017e1bf5ea 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -332,7 +332,7 @@ int iommu_device_register_bus(struct iommu_device *iomm=
u,
 	spin_unlock(&iommu_device_lock);
=20
 	bus->iommu_ops =3D ops;
-	err =3D bus_iommu_probe(bus);
+	err =3D bus_iommu_probe(bus, iommu);
 	if (err) {
 		iommu_device_unregister_bus(iommu, bus, nb);
 		return err;
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/mXfwBR3IljITL8fiCzopG_R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbW8UACgkQAVBC80lX
0Gw31wf/YlYZ96F/Cy+T9dh54lcYx4S3J3WuN/n60X0vkZ2hHQSeNzVyyi9Mv5BB
RMmlDATpqMoh1qRRP3F95e0rAdoL6/X3eMqIIz4twxU0iBUwrIWdZJ+DehTFtkPE
QXNjuhzIG7B2aoVoFQuKACDAirw2kOj1M6ovIHTwQGsSoA8x9aaFtRjnE3lWbqr/
VduMaL9RAKwV2AovB57a2Uiv/rCA9GoGZoK2uwZ/et6oD2/DzILbJYzbyveoXGFK
Jrnb4zazgW9KMGk1Q8634D62DZKuSnOeTDnn/rUx08ND4iRYfLuMEG9JuFkNOsWJ
UrojVXCUZM2f/MmPtd4WNAweABOLng==
=3CG8
-----END PGP SIGNATURE-----

--Sig_/mXfwBR3IljITL8fiCzopG_R--
