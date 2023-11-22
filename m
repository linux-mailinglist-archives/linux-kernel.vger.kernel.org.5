Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C7D7F3AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjKVA3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjKVA3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:29:42 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A42E1AA;
        Tue, 21 Nov 2023 16:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700612973;
        bh=NavejzRn6aIoSlrOplrfI6W3+q6tZqXpfcPZH5NPdKU=;
        h=Date:From:To:Cc:Subject:From;
        b=pD+oHtCrUImQFRms4jGN1oJD4HmI7hFhQCcQ/4Bqwr/XNEcwmHGc0z4vE+ZnTa2iV
         +4ekaqby84xho2zDZlgML0C9SLZfOcwSB0DBzvNdG02ExK0fEFBFR0+nWUnq91Go8R
         bxAT3BIBXi5hZOcmfqMMBwO+JhkHXnhGC9WYCnI7UHUYcQqyR4Y2z/3XjRAMhDqhXI
         rKSU4cQv/7k3VmbrFdlyH/JqORxxI95hO3OX5eej7VZj8RbsY9oMS10WmRwMrLJBBd
         70MJfLidjjvbMvr/kPWFuXTzH+tlWeKgBYqChmCu0g0moa+ov8Y8lkicrNzWTWnTpo
         7RwSqLlvaqnvw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZhvc0cHDz4x7q;
        Wed, 22 Nov 2023 11:29:31 +1100 (AEDT)
Date:   Wed, 22 Nov 2023 11:29:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes
 tree
Message-ID: <20231122112930.5e7c7bcd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rD=riml9APOu==RUQJkZaoY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rD=riml9APOu==RUQJkZaoY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/accel/ivpu/ivpu_hw_37xx.c

between commit:

  3f7c0634926d ("accel/ivpu/37xx: Fix hangs related to MMIO reset")

from the drm-misc-fixes tree and commits:

  3de6d9597892 ("accel/ivpu: Pass D0i3 residency time to the VPU firmware")
  cc19fedab8bd ("accel/ivpu/37xx: Print warning when VPUIP is not idle duri=
ng power down")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/accel/ivpu/ivpu_hw_37xx.c
index 4ccf1994b97a,4ab1f14cf360..000000000000
--- a/drivers/accel/ivpu/ivpu_hw_37xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_37xx.c
@@@ -720,14 -731,19 +733,14 @@@ static int ivpu_hw_37xx_power_down(stru
  {
  	int ret =3D 0;
 =20
- 	if (!ivpu_hw_37xx_is_idle(vdev))
- 		ivpu_warn(vdev, "VPU not idle during power down\n");
+ 	ivpu_hw_37xx_save_d0i3_entry_timestamp(vdev);
 =20
- 	if (ivpu_hw_37xx_reset(vdev)) {
- 		ivpu_err(vdev, "Failed to reset VPU\n");
- 		ret =3D -EIO;
+ 	if (!ivpu_hw_37xx_is_idle(vdev)) {
+ 		ivpu_warn(vdev, "VPU not idle during power down\n");
+ 		if (ivpu_hw_37xx_reset(vdev))
+ 			ivpu_warn(vdev, "Failed to reset the VPU\n");
  	}
 =20
 -	if (ivpu_pll_disable(vdev)) {
 -		ivpu_err(vdev, "Failed to disable PLL\n");
 -		ret =3D -EIO;
 -	}
 -
  	if (ivpu_hw_37xx_d0i3_enable(vdev)) {
  		ivpu_err(vdev, "Failed to enter D0I3\n");
  		ret =3D -EIO;

--Sig_/rD=riml9APOu==RUQJkZaoY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVdS2oACgkQAVBC80lX
0GwcEQf/RL8cTvBpGJ24GEQ2NRCpwaTVMlQDttNctoX+XN1qmXaFokz1hhjzjkph
5cC16d7TNYYLSPZ/IKXjuzQnNe/7u0MeaKcakDcBTglRnBtWxOu+pOicmZoIgqXV
sCCdmnLqMzrWPf+unRbL8SokKO8PCeI4y/2zAq2ubRJ1S+UWgKQOgq1adfe3bkhL
CIhcTEbyocDxXM7t2I0RW2a/JPrTUR1a2MLFHlr9oY1cMiq89gB1Z3ptu80E0cXw
ltIG3FWJtmxfJbeuev5TkDjvUTf+D2syUsNx5e50IOkmJMPiZi3YbvNAYrUV0bnP
OKzoiiJjnMzW/Mhv6200CJ8W8pgsPw==
=aZJJ
-----END PGP SIGNATURE-----

--Sig_/rD=riml9APOu==RUQJkZaoY--
