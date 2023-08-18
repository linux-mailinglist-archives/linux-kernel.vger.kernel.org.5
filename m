Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ED8780317
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356865AbjHRBXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356863AbjHRBWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:22:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2124203;
        Thu, 17 Aug 2023 18:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692321720;
        bh=J91y43CUV4wpm0FlW1qXk5Ftau/aRI4MIw2cmxJLr60=;
        h=Date:From:To:Cc:Subject:From;
        b=JzGGRFHpLI3bGcO8I+iEcT/l4ptJfOmsIjfRKzxc71gZuhyGApXRPBku/sJlhdxdP
         fKlYMR9Wz7YYIunlLsZzpLgwYsVfxUBJvfDiF8eFpoCuvmw3aRwN4AzijAzCLzNN+/
         tLPkjm/wBHbbzznjlQxEWMNNtaTlebBeXH0+jl7D1tHkq8eRH3dlDZjKNYDmNYcpmW
         Y7mamIqVVqIRXx3HEg2JOWA3y0x97CQ4/DWyxi2QHAxbZx2knfmMWr3tQ7cr9Qv7MP
         mC8k8xVrnY5RWS4a9/tqLSezLI9MPJtSC08D+L7gkg9LHjwOkfmjXDPlk/6JOR3KF/
         4iFoD13x4/KHw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRkcS3V3Lz4wZJ;
        Fri, 18 Aug 2023 11:22:00 +1000 (AEST)
Date:   Fri, 18 Aug 2023 11:21:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20230818112159.7430e9b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4x=_vmcY6dv.NiOPuZaOiYG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4x=_vmcY6dv.NiOPuZaOiYG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/sfc/tc.c

between commit:

  fa165e194997 ("sfc: don't unregister flow_indr if it was never registered=
")

from the net tree and commit:

  3bf969e88ada ("sfc: add MAE table machinery for conntrack table")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/sfc/tc.c
index fe268b6c1cac,246657222958..000000000000
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@@ -1657,11 -2087,17 +2087,17 @@@ int efx_init_tc(struct efx_nic *efx
  	rc =3D efx_tc_configure_fallback_acts_reps(efx);
  	if (rc)
  		return rc;
- 	rc =3D flow_indr_dev_register(efx_tc_indr_setup_cb, efx);
+ 	rc =3D efx_mae_get_tables(efx);
  	if (rc)
  		return rc;
 -	efx->tc->up =3D true;
+ 	rc =3D flow_indr_dev_register(efx_tc_indr_setup_cb, efx);
+ 	if (rc)
+ 		goto out_free;
 +	efx->tc->up =3D true;
  	return 0;
+ out_free:
+ 	efx_mae_free_tables(efx);
+ 	return rc;
  }
 =20
  void efx_fini_tc(struct efx_nic *efx)

--Sig_/4x=_vmcY6dv.NiOPuZaOiYG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTex7cACgkQAVBC80lX
0GyVTAgApL7cdEzEbkTkd3JPQ6bkSiv5gMEWKD6cg4ClpNAwVrbCNL0lSpHUamqD
ukvtZKetjrvGYSpAnnJuxP/9PlZEk3YVp6WwQSDa87MG8E1xndsCzFzzjb8iKgHE
DWLdjObxK+w2asWW0M/5WjiG/93FlfSQTllxaozMfWT/UAV71tmD01pmNRkV9Rix
gceupG81QEEqQEyoZq2cqGYU9VUJPrCFdoeBtQpoJaInNv8KeCnW6yBof9zdpx/c
ytm5bRIrbdNgEiZe9BRJXLkK5xyN0VbyhcyB5PQAmboBd5dYx5m9f5CstSNnMp2F
h1NXqadc5CqCg40WxRoCkT4hIXWXbQ==
=O70f
-----END PGP SIGNATURE-----

--Sig_/4x=_vmcY6dv.NiOPuZaOiYG--
