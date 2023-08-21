Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D6A7835B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjHUW3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjHUW3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:29:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0190518B;
        Mon, 21 Aug 2023 15:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692656923;
        bh=bwNpfniyzgUU8NH8mqYb+JaEXQAeOYH+rSmH63Zl9jA=;
        h=Date:From:To:Cc:Subject:From;
        b=AfFV/ld5tzMF7xN4BJAySewYNhLTS5l/pTtuUCSL3TjrkSEb5I7UEd4UN89SFPARD
         Gh0Hgy22ypUtYzCVqoUQpQ7jtwwSnQLP2NA7irkVPbhnBoMaEMjZuBOTBAQ+DvZW9R
         CUFTi0e+9yA+nJlw9vDrDKy1cNaJbK6vIieEv7GmWoaKUrq3C3pwMBgkh2lsjU8MJ6
         sCGyIw+HVaQC28fGplpvAotj4zQUzqMlVZyo5MogsPum1Y6jd/ups/9pj8IxZq1g4U
         VIZbO9T8U6znWNoSSExMj2mI+KT7lTzbXDRmgMdAdKH2NpOpcjWhgtvOl7w7eqcFsj
         /0ZXSApNOB9IA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RV6Zg2c7Nz4wxN;
        Tue, 22 Aug 2023 08:28:43 +1000 (AEST)
Date:   Tue, 22 Aug 2023 08:28:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vineet Gupta <vgupta@kernel.org>
Cc:     Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm-stable tree with the arc-current
 tree
Message-ID: <20230822082841.7948474d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+DvXniYZYIqTSxEkOxoFa1D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+DvXniYZYIqTSxEkOxoFa1D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-stable tree got a conflict in:

  arch/arc/Kconfig

between commit:

  f798f91e7f5f ("ARC: uaccess: use optimized generic __strnlen_user/__strnc=
py_from_user")

from the arc-current tree and commit:

  06dfae39d200 ("arc: mm: convert to GENERIC_IOREMAP")

from the mm-stable tree.

BTW, if the "select GENERIC_IOREMAP" had been put in its (alphabetical)
proper place, this conflict would not have occurred ...

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arc/Kconfig
index c92bacc1ff4c,6f4995ad9873..000000000000
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@@ -21,6 -21,6 +21,7 @@@ config AR
  	select DMA_DIRECT_REMAP
  	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
  	# for now, we don't need GENERIC_IRQ_PROBE, CONFIG_GENERIC_IRQ_CHIP
++	select GENERIC_IOREMAP
  	select GENERIC_IRQ_SHOW
  	select GENERIC_PCI_IOMAP
  	select GENERIC_PENDING_IRQ if SMP

--Sig_/+DvXniYZYIqTSxEkOxoFa1D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTj5RoACgkQAVBC80lX
0Gy8Ywf/f8rdS1g1BNcpK3RTm8oXR8BSN8pi+tLb9zqcUs1kzbP8L7jpn38+b2yA
onx26645a2r+DIOR6yXZDAWHdZFTL+ptwh6MIKbjFZHbUvNcWLW+19VjVrGwSw0c
wqm0asyvh4GkG07hF0ZdRpcGTt7gxqIt6R4+IslqZ32RPhbrQ0L22cX5v/K25cNP
xv0V03OkfoNQQVAf9dkaRYYJfeCCOfzKiMULAi+wD+xAtC8IT+31slhdCqRfN8jp
O9f60Ga37J0kYgOCJSM5tPvCZXA9XvtdvoJjrDNHNixC7j0WixeyVlCCxP7PSDil
rX8FLI0v5f4YLGBquyCF4eI8cgUd4Q==
=2EaT
-----END PGP SIGNATURE-----

--Sig_/+DvXniYZYIqTSxEkOxoFa1D--
