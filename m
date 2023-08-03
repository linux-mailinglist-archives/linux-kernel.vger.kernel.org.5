Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D5276DBE9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjHCADQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjHCADN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:03:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04008173F;
        Wed,  2 Aug 2023 17:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691020985;
        bh=QxrpbN3/Snnkjiy3iazBNul/w92ghQ+lKXNFJqYRcKs=;
        h=Date:From:To:Cc:Subject:From;
        b=fvPq0biolsG0Vv1X+2NbPXoDIqvZ62I0wyn1sg7W8dlwOqWpJoipSgF5CCP3ncUco
         hZKBaXTApiV1Zi1pLE62cPl5FC0zILJgtVsNe8+LI6Mtk0Vox5dhlHBI7YajGOX471
         Pr+67ADOLKI9pm9hV2G53PhUrdhoNp1KLx5aOqFidpCNzIR0XFbkp/11nF+plaHGcf
         k633RPo+IOPz8eEDEN/HxuBcDQbCjzqb1XwCn/A19CZtGq296QMVp2S7Vvhwrs+TrH
         z71v/ozPD7qhynG/Lkotlz/FiLLW0ZuYK+WJAzfNasBtNvnKPrcqFmpd/+8jnrxGg+
         1GEqZGiekAF4g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RGTZJ2Bm6z4wZs;
        Thu,  3 Aug 2023 10:03:04 +1000 (AEST)
Date:   Thu, 3 Aug 2023 10:03:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20230803100303.1cd82ae8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uKyRE=Dgovp=TN2ewDQe07D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uKyRE=Dgovp=TN2ewDQe07D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (x86_64
allmodconfig) failed like this:

mm/shmem.c: In function 'shmem_enable_quotas':
mm/shmem.c:284:23: error: implicit declaration of function 'dquot_load_quot=
a_sb'; did you mean 'dquot_load_quota_inode'? [-Werror=3Dimplicit-function-=
declaration]
  284 |                 err =3D dquot_load_quota_sb(sb, type, QFMT_SHMEM,
      |                       ^~~~~~~~~~~~~~~~~~~
      |                       dquot_load_quota_inode

Caused by commit

  220a17f613eb ("shmem: quota support")

interacting with commit

  9543f84c067d ("quota: mark dquot_load_quota_sb static")

from the ext3 tree.

I have reverted the ext3 tree patch for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/uKyRE=Dgovp=TN2ewDQe07D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTK7rcACgkQAVBC80lX
0Gx3nwf7BHfBjKYnwMCOFxSCXzU/rD4YdplzD/IfHJVm8EeGz7ztQ2j/jJUSYRha
k8Ywjf3Xi7XPGccERxqPDznd515XCeJQc8oN7Gc8gSiGHmyeYeugRMd9LIlmwtb7
7hYvaXznOs8iVWDdVgrJwTuMB4iGAjt3f/6n/Q1r9eUfYtRvvjsLHAtrddVH883c
JWmqhX95C7w/L1JLWoaUR02rV3d4Wqah4xOQOztxyK07ZTRcmGmI2XRySrRcbbP1
Wpouxj5/K5Hl7VXl+lgoDDo8j1x2hfbmNsvlPT7hTmX/vLsDfMbta8R6i6rOBs+I
5q0vjCsZoSFifTc2IsbR8OZNCiFbOQ==
=bcUt
-----END PGP SIGNATURE-----

--Sig_/uKyRE=Dgovp=TN2ewDQe07D--
