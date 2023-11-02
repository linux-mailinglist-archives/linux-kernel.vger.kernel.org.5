Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26A07DFD5D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 00:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjKBXyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 19:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjKBXyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 19:54:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0312196;
        Thu,  2 Nov 2023 16:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698969237;
        bh=JQBJ6xDHHKFcC4YoQlU9mDR0r7uubIawaPypa/2vXq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WuVHTR89mHR1EIOk5U6NtHK/iH06BhsVlBcBVu/qc9TA0MPgIllCUgcZeZP/nU7Lr
         lCTRYBrKc9LEklR0+X2fx6bxC5cYovKdgnLwqgPpcTOIC3iFqc/Z3cvDGilgeJFATw
         mdsAA4AOSVwYJcz82y0K6g/Pmqv/z0vv5sVUAxTBakqK+x0YjMxYKF4k3PU4SDbTyL
         mvaxnrnsOTIWuy9gBc84yx2tbrUNdox8AvQSBMQWU+15bu6JLF4PnG5hLAvjOgk5N+
         CRRY0MvP9Zy4479Rx5HVsuZgyJE4Gy7fY5gcQg3B+/sjgaKEOU+Zr50/buBZMHMZQd
         bBrwoRpIu5PSw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SM11J4nDPz4x5j;
        Fri,  3 Nov 2023 10:53:56 +1100 (AEDT)
Date:   Fri, 3 Nov 2023 10:53:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: linux-next: manual merge of the iommufd tree with the iommu
 tree
Message-ID: <20231103105355.71575cf6@canb.auug.org.au>
In-Reply-To: <20231025154420.718e27af@canb.auug.org.au>
References: <20231025154420.718e27af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/m7W_noYGPzxMdC8Ku2q84/g";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m7W_noYGPzxMdC8Ku2q84/g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 25 Oct 2023 15:44:20 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the iommufd tree got a conflict in:
>=20
>   include/linux/iommu.h
>=20
> between commits:
>=20
>   1c68cbc64fe6 ("iommu: Add IOMMU_DOMAIN_PLATFORM")
>   4601cd2d7c4c ("iommu: Add ops->domain_alloc_paging()")
>=20
> from the iommu tree and commits:
>=20
>   1621aef1fbfe ("iommu: Add IOMMU_DOMAIN_NESTED")
>   909f4abd1097 ("iommu: Add new iommu op to create domains owned by users=
pace")
>   17dd7701a2e7 ("iommu: Pass in parent domain with user_data to domain_al=
loc_user op")
>=20
> from the iommufd tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc include/linux/iommu.h
> index b5b254e205c6,f347bf31761f..000000000000
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@@ -64,8 -66,10 +66,11 @@@ struct iommu_domain_geometry=20
>   #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue   =
 */
>  =20
>   #define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
>  +#define __IOMMU_DOMAIN_PLATFORM	(1U << 5)
>  =20
> + #define __IOMMU_DOMAIN_NESTED	(1U << 5)  /* User-managed address space =
nested
> + 					      on a stage-2 translation        */
> +=20
>   #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
>   /*
>    * This are the possible domain-types
> @@@ -94,7 -96,7 +99,8 @@@
>   				 __IOMMU_DOMAIN_DMA_API |	\
>   				 __IOMMU_DOMAIN_DMA_FQ)
>   #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
>  +#define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
> + #define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
>  =20
>   struct iommu_domain {
>   	unsigned type;
> @@@ -238,9 -327,19 +331,21 @@@ static inline int __iommu_copy_struct_f
>    *           op is allocated in the iommu driver and freed by the calle=
r after
>    *           use. The information type is one of enum iommu_hw_info_typ=
e defined
>    *           in include/uapi/linux/iommufd.h.
> -  * @domain_alloc: allocate iommu domain
> +  * @domain_alloc: allocate and return an iommu domain if success. Other=
wise
> +  *                NULL is returned. The domain is not fully initialized=
 until
> +  *                the caller iommu_domain_alloc() returns.
>  + * @domain_alloc_paging: Allocate an iommu_domain that can be used for
>  + *                       UNMANAGED, DMA, and DMA_FQ domain types.
> +  * @domain_alloc_user: Allocate an iommu domain corresponding to the in=
put
> +  *                     parameters as defined in include/uapi/linux/iomm=
ufd.h.
> +  *                     Unlike @domain_alloc, it is called only by IOMMU=
FD and
> +  *                     must fully initialize the new domain before retu=
rn.
> +  *                     Upon success, if the @user_data is valid and the=
 @parent
> +  *                     points to a kernel-managed domain, the new domai=
n must be
> +  *                     IOMMU_DOMAIN_NESTED type; otherwise, the @parent=
 must be
> +  *                     NULL while the @user_data can be optionally prov=
ided, the
> +  *                     new domain must support __IOMMU_DOMAIN_PAGING.
> +  *                     Upon failure, ERR_PTR must be returned.
>    * @probe_device: Add device to iommu driver handling
>    * @release_device: Remove device from iommu driver handling
>    * @probe_finalize: Do final setup work after the device is added to an=
 IOMMU
> @@@ -275,7 -372,9 +380,10 @@@ struct iommu_ops=20
>  =20
>   	/* Domain allocation and freeing by the iommu driver */
>   	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
>  +	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
> + 	struct iommu_domain *(*domain_alloc_user)(
> + 		struct device *dev, u32 flags, struct iommu_domain *parent,
> + 		const struct iommu_user_data *user_data);
>  =20
>   	struct iommu_device *(*probe_device)(struct device *dev);
>   	void (*release_device)(struct device *dev);

This is now a conflict between the iommu tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/m7W_noYGPzxMdC8Ku2q84/g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVENpQACgkQAVBC80lX
0Gy/jgf+OLhq6Xi7fJ3xXJxNBplLh5qPb+0iKdaKEbGuri2+GgTtajO05uO1/f4k
YzDv1N144ksyEkx6Knh6P3M0O2Ggwt2vR4w/+zh/BwAsXNz6KLlf0N5e/5vXG4g4
ACHjIXttJvidxnZUiqJaddAY8lz0Oet16E9Z7/f+9lCI4KtR6UYj+ixyS3+e5K2e
9gPc473GfkDJfnhIY0dWUr/xYj4en9KbCb3ClYsQdU8ux8LVzNGa6FkNdVM7ZJPy
cyPlPuuCDcjB8Dq/2Q4G85933hCl8JDGXFMsOrAdyoUcu+gUz1EP45pGoMVcJQFx
pm6jC5O7blWAjPD1Zw3QNUXcFmbzdA==
=ypI6
-----END PGP SIGNATURE-----

--Sig_/m7W_noYGPzxMdC8Ku2q84/g--
