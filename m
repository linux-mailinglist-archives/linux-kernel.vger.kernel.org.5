Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40E97932EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 02:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbjIFAjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 20:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjIFAjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:39:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1428199;
        Tue,  5 Sep 2023 17:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693960749;
        bh=9SzOc2eVVFdZBWdYMyl/TtJTI6sHlh7Cr3aC84LwvK4=;
        h=Date:From:To:Cc:Subject:From;
        b=Sonz4tiWCA2MpfFPa8ZVK2ajt+aCT02sc4BBNulOP2eMqoUhTp2ClZme8CRnsL01K
         JSz9hsiKpULQ8pkZQnpefZdz7Q0sQVQdnR3qaEOUXoUoXn9JC/XIKSFHPCLm1xXCVY
         JCCnfIfNrji9iEygBzq2HKeSZWTyhextbhy+PkSiM7wX7WrpcbklxV/Ert8UO/hgyn
         L/ayNoY4q48AOM5sXYOHK9kVQcq57rWivsBcKu1KFXOthsbJCDrMnW99P9cTR1hPAC
         CtR3N/iL4Ruc02dNPVOGE0ceZEjsXdgWoWbAwackoQcAkjqzL+5DmlPl6LoMlbbsTF
         xOd8XFkSBMvUw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RgNmD66xRz4wxR;
        Wed,  6 Sep 2023 10:39:08 +1000 (AEST)
Date:   Wed, 6 Sep 2023 10:39:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jinjie Ruan <ruanjinjie@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>
Subject: linux-next: manual merge of the scsi-mkp tree with the mm tree
Message-ID: <20230906103905.0752736e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lVP_cTRtyzol0zOrfSVy7zh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lVP_cTRtyzol0zOrfSVy7zh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/scsi/qla2xxx/qla_dfs.c

between commit:

  d16e04dc79ed ("scsi: qla2xxx: use DEFINE_SHOW_STORE_ATTRIBUTE() helper fo=
r debugfs")

from the mm tree and commit:

  d0b0822e32db ("scsi: qla2xxx: Fix NULL vs IS_ERR() bug for debugfs_create=
_dir()")

from the scsi-mkp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/scsi/qla2xxx/qla_dfs.c
index debb14d71e8a,a7a364760b80..000000000000
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@@ -662,8 -707,8 +662,8 @@@ create_nodes
 =20
  	if (IS_QLA27XX(ha) || IS_QLA83XX(ha) || IS_QLA28XX(ha)) {
  		ha->tgt.dfs_naqp =3D debugfs_create_file("naqp",
 -		    0400, ha->dfs_dir, vha, &dfs_naqp_ops);
 +		    0400, ha->dfs_dir, vha, &qla_dfs_naqp_fops);
- 		if (!ha->tgt.dfs_naqp) {
+ 		if (IS_ERR(ha->tgt.dfs_naqp)) {
  			ql_log(ql_log_warn, vha, 0xd011,
  			       "Unable to create debugFS naqp node.\n");
  			goto out;

--Sig_/lVP_cTRtyzol0zOrfSVy7zh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT3yikACgkQAVBC80lX
0GxsZQgAnx6GCsy9tsJi2lH2Z+ZqfM7qfnKYNXO3NeVLmJHL9lrI18+9iWZBytFI
5EFihmCycUETGzcq4zdc2oWhcVUhTaItnH4x8fWp59f3vQ8buvZx2UTM2mdfWMhs
3kXUd5gmwEtVi0pbRgN6InA6nncJ5OIpGEVKw0IdJJIMMgc2+Vz1G/8bcaTHIjsW
OxhcCqcsFg1xDvNkI7+P6sLVYRCNX02olClFJ//95jJx8ny5P709UHgU52WSdr33
zilnOXi5pHynq0bPSpVoVt2xmyz0qRWzUPTDU2YorkWiIPKbmkMZVcBS+dW4fh7w
OFK8iPco/1kC4yGTLK+z0MqRCfdAyQ==
=YBQE
-----END PGP SIGNATURE-----

--Sig_/lVP_cTRtyzol0zOrfSVy7zh--
