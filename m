Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B807B1095
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjI1CGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1CGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:06:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB76B3;
        Wed, 27 Sep 2023 19:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695866761;
        bh=PiZdKhrE/o3h0tGaT8pGddKF7rJCeQnVsW/gwwhnafM=;
        h=Date:From:To:Cc:Subject:From;
        b=GRMuyIVD7OFAFCN42aro0PDyuSEH9y73kCbLx2Kq6Gj6YZz4fO3K+tOC6mLZAOhKi
         m4nmF7UufaQ0RlTPep1UXZWa94nbczGGUx+6VIh/1qkcjaLqKPqevlSYsHeyg3V4xb
         4FQMc7VvWSVDzuMglgD01IYfcECrX235HYTArXiql3omR+Aa216X0yud7VKulNojCa
         WDTxP01s19bHFCdmeI/q1BHVAVpWO1PjwbcET0J/9znllzN0TTBwh7WiaK6hNCbr2t
         geCDMMumUAFDJoyQdAyZOSXYqdBYDgEgAAAiSAHL+uVo1inIgzExsZ/YukqwA+bsew
         AS3DEUAWHkpqA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RwxfJ5ksWz4xQb;
        Thu, 28 Sep 2023 12:06:00 +1000 (AEST)
Date:   Thu, 28 Sep 2023 12:05:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Karol Wachowski <karol.wachowski@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes
 tree
Message-ID: <20230928120559.485eecd7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AI36QvNyIPurJhqGZN8m9Qs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AI36QvNyIPurJhqGZN8m9Qs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/accel/ivpu/ivpu_fw.c

between commit:

  645d694559ca ("accel/ivpu: Use cached buffers for FW loading")

from the drm-misc-fixes tree and commit:

  53d98420f5f9 ("accel/ivpu: Move ivpu_fw_load() to ivpu_fw_init()")

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

diff --cc drivers/accel/ivpu/ivpu_fw.c
index 0191cf8e5964,d57e103aae1c..000000000000
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@@ -331,9 -332,7 +333,7 @@@ void ivpu_fw_load(struct ivpu_device *v
  		memset(start, 0, size);
  	}
 =20
 -	wmb(); /* Flush WC buffers after writing fw->mem */
 +	clflush_cache_range(fw->mem->kvaddr, fw->mem->base.size);
-=20
- 	return 0;
  }
 =20
  static void ivpu_fw_boot_params_print(struct ivpu_device *vdev, struct vp=
u_boot_params *boot_params)

--Sig_/AI36QvNyIPurJhqGZN8m9Qs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUU34cACgkQAVBC80lX
0Gx0vQf/YgJqpqoaLiWKBT81dUyyFB/aKPq0CvJARdYNvmu3n69BhK3qN+64FX4T
VQzi4wCZwgvErmnv1cJ83WliDY+UXTz/nTHNfzfttjI2nNbA9Lfc4qSRahhM/SXV
AlbD8wXdwTCm0MojHra6QXM8UiGafGbf+7PS9MadQ92WdCw+J3FCAZfCeWxSSo0U
QH5/EQ11G2NdmtkgMaSD2MCOW0vGoYfnfSjteHbcx/pak2hGKk+NBRWKcC5KagoV
SuRagK+4/Vn8Oy/g/lAb9SiiacZdjBzs9RftJyfJy2NXITTzOKYdok01IRRHVKpM
SK43I5VBEzCypRbTTDU7k88bCHe+mA==
=TbLq
-----END PGP SIGNATURE-----

--Sig_/AI36QvNyIPurJhqGZN8m9Qs--
