Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47137D7B39
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 05:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjJZD1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 23:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZD1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 23:27:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAE3187;
        Wed, 25 Oct 2023 20:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698290857;
        bh=uZcN/okWIB4ryLnAV48yQVnuFynysUqMSeAVPBsSjyQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Ot91u8+xZEFcqWqJa7UCNIL9yrkGxXKkBU7HrPkQcjr6b9yzqpwP8kEk/sl2y9Fmv
         4mH4HEpFBzPNl4gm8i+0gEmY2cNd45awjgCi+UZEXl1JyUHQy5L3HbmgVggRqtUKsP
         8x2SXzXE1d+DDW4UvhIZgIT4zuOpbAHi6TXvDQverWs76pdWIJbdwlqU0fuXWycxRL
         eRgxGgwcEo9WSxSruQ2Mf2eoEDdtiU76z6CoBK3Me8vWaEeGCN704n18asYQwNaRQ0
         twjbbRIq8vgzYsmZxqSvT5ljR7WyYLj7H8fT4dNQYKkS8EFm9fmyahFJLVs4rR1ej6
         yQRUuQ5JhUXKg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGB7X1qtdz4wcZ;
        Thu, 26 Oct 2023 14:27:36 +1100 (AEDT)
Date:   Thu, 26 Oct 2023 14:27:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Shavit <mshavit@google.com>,
        Tina Zhang <tina.zhang@intel.com>,
        Will Deacon <will@kernel.org>
Subject: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20231026142733.442e18a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tK7kIIiHSe7r3YfzFGS6Mxb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tK7kIIiHSe7r3YfzFGS6Mxb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommufd tree got a conflict in:

  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c

between commit:

  24503148c545 ("iommu/arm-smmu-v3: Refactor write_ctx_desc")

from the iommu tree and commit:

  a247f322787d ("iommu: Add mm_get_enqcmd_pasid() helper function")

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

diff --cc drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 353248ab18e7,08fac84c1804..000000000000
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@@ -264,10 -233,10 +264,10 @@@ static void arm_smmu_mm_release(struct=20
  	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
  	 * but disable translation.
  	 */
- 	arm_smmu_update_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd);
 -	arm_smmu_write_ctx_desc(smmu_domain, mm_get_enqcmd_pasid(mm), &quiet_cd);
++	arm_smmu_update_ctx_desc_devices(smmu_domain, mm_get_enqcmd_pasid(mm), &=
quiet_cd);
 =20
  	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
- 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+ 	arm_smmu_atc_inv_domain(smmu_domain, mm_get_enqcmd_pasid(mm), 0, 0);
 =20
  	smmu_mn->cleared =3D true;
  	mutex_unlock(&sva_lock);
@@@ -323,16 -290,7 +323,16 @@@ arm_smmu_mmu_notifier_get(struct arm_sm
  		goto err_free_cd;
  	}
 =20
 -	ret =3D arm_smmu_write_ctx_desc(smmu_domain, mm_get_enqcmd_pasid(mm), cd=
);
 +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 +	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
- 		ret =3D arm_smmu_write_ctx_desc(master, mm->pasid, cd);
++		ret =3D arm_smmu_write_ctx_desc(master, mm_get_enqcmd_pasid(mm), cd);
 +		if (ret) {
 +			list_for_each_entry_from_reverse(master, &smmu_domain->devices, domain=
_head)
- 				arm_smmu_write_ctx_desc(master, mm->pasid, NULL);
++				arm_smmu_write_ctx_desc(master, mm_get_enqcmd_pasid(mm), NULL);
 +			break;
 +		}
 +	}
 +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
  	if (ret)
  		goto err_put_notifier;
 =20
@@@ -357,8 -315,7 +357,8 @@@ static void arm_smmu_mmu_notifier_put(s
  		return;
 =20
  	list_del(&smmu_mn->list);
 -	arm_smmu_write_ctx_desc(smmu_domain, mm_get_enqcmd_pasid(mm), NULL);
 +
- 	arm_smmu_update_ctx_desc_devices(smmu_domain, mm->pasid, NULL);
++	arm_smmu_update_ctx_desc_devices(smmu_domain, mm_get_enqcmd_pasid(mm), N=
ULL);
 =20
  	/*
  	 * If we went through clear(), we've already invalidated, and no

--Sig_/tK7kIIiHSe7r3YfzFGS6Mxb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU53KUACgkQAVBC80lX
0Gzndgf/S2pw71j8Idqieqy7PiH0BlPDqksLsRxL1VReKjDDKJqqEajoThQJpAtX
/4Tny4aCjMB5IBC09THAkV9DSlmf2uW4Cz0iL8WJXVHWuh/VL6f1zfxsuAzsq0mV
D8zRV02K4HuY+w5XYqFq71XLnLwQy0fD9Lzz4zyrSZdnEDX0AGxVfVTrklNXarjh
cY61KFOy/qp4uL+SP17uucO87pUvmvGt68jVajEAy/ekyRP77zqFyi2xLxUXRSm6
q2IYKRPize7MzqO5qyXQQ78VjTLw18fD9USp/FtlrRWknSNWKc2V6w6gOEprAfoE
ZiKUKBeesymdODmxZfCZ3YPfojKtEg==
=8UMB
-----END PGP SIGNATURE-----

--Sig_/tK7kIIiHSe7r3YfzFGS6Mxb--
