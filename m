Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526087EA772
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 01:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjKNAZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 19:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKNAZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 19:25:13 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E28CD50;
        Mon, 13 Nov 2023 16:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699921507;
        bh=0OLCvVOkYstpdcz9x3Fniksg/NrhBMGEfgtUuBgeYaU=;
        h=Date:From:To:Cc:Subject:From;
        b=ZgFK4Z5xVWHQiwE9Oh0UIAxGoBI5/cW9TvTJoBUCYs4y/QxMuemzRn2O2B8ePGiDS
         AU/8q2L9iSAf+kDi6U3j7dLuQzAhzD0UCEq8x33MOc8Jahe8dOgs1+2zcy8Z8l1Mrg
         dhWivIpdxLehYAdu0o1PgxrEkm5hzrrxjGlsLscU0nBjZJSX0yEa2mJK/hnOGA6bWH
         xluDfos+akAfuQaw3UlWyrDKtcbRGlUcUnKiH2gQHYYk/n0cqqQIs7iLLZo9zmdTsY
         PERkah7OjrnSS7zPnjVziouwRT78MLvlLVSX7WhRW9UKRKfWs/Q5qQFhqRxbOEn6iy
         Kku4rkXUKDmrg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4STnBB2v1Zz4xQZ;
        Tue, 14 Nov 2023 11:25:05 +1100 (AEDT)
Date:   Tue, 14 Nov 2023 11:25:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20231114112503.6e098829@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iPB_Kq5N=avBmm1/F4ReNpJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iPB_Kq5N=avBmm1/F4ReNpJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/accel/ivpu/ivpu_drv.c

between commit:

  828d63042aec ("accel/ivpu: Don't enter d0i3 during FLR")

from Linus' tree and commit:

  57c7e3e4800a ("accel/ivpu: Stop job_done_thread on suspend")

from the drm-misc tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/accel/ivpu/ivpu_drv.c
index 790603017653,51fa60b6254c..000000000000
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@@ -389,13 -390,7 +388,14 @@@ void ivpu_prepare_for_reset(struct ivpu
  	disable_irq(vdev->irq);
  	ivpu_ipc_disable(vdev);
  	ivpu_mmu_disable(vdev);
+ 	ivpu_job_done_thread_disable(vdev);
 +}
 +
 +int ivpu_shutdown(struct ivpu_device *vdev)
 +{
 +	int ret;
 +
 +	ivpu_prepare_for_reset(vdev);
 =20
  	ret =3D ivpu_hw_power_down(vdev);
  	if (ret)

--Sig_/iPB_Kq5N=avBmm1/F4ReNpJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVSvmAACgkQAVBC80lX
0GxgaAgAgYZvkvJS8o3jOn8Cpzr1F+VAS8lx2oXk0Jfhzft4Y5rEgscfl8ja8Hu2
uJ9n6rtqsFNd1q6AEikjBcoAn0rzrQ7RJp9MKB/xbtMPi1DBDlYcGIh7YMJVH9i1
OWCmz0hcWtlsfi7OUY4zX2wKUEwBr/1PGloRcXJyOklUvm1qP2ES20B+EVi2MDru
QBKNyxQeP30wZfQ9YqmkOs6WEqAUlM/0SBMfnb18yCkaQi94b/vFglBoCXqd1uwF
QZAUa2c8bfQd67s0BesSvKwIEUIh46L9Jo6Z58tom9ZvWllZZU8YMKJbd2Yedd1M
lDaPNkBKsRmOBuDcdwHI7Fu6kWz/kw==
=3A1u
-----END PGP SIGNATURE-----

--Sig_/iPB_Kq5N=avBmm1/F4ReNpJ--
