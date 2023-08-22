Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AC6783922
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 07:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjHVFNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjHVFN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:13:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C2FDB;
        Mon, 21 Aug 2023 22:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692681202;
        bh=i5HP5OdIK/S0e7ELbUqqis2x1/uZxOU3+PVil+G3fv0=;
        h=Date:From:To:Cc:Subject:From;
        b=dqEm0Bm0T+7CA5pAcRo2w2VurLkvfWFl7SAHlADCFNTA6X8l0MSqEM8B+FkLpUofz
         ZecKRQTPNdAvqUcBbFJTuSZ/o694z/pz0QH9e+3oMUWHnK83gc2TL+2Ox/vSDRTJVa
         Ij+lKX8gaXenm7N1kvFivWYlavNdZn1og0+ZOIHpHCXoQn70TAmaZuUCgVFwODVyNJ
         +y4TBV/R9ZcEDYK1bZ/cG2s6UuC/xV5YPp2VjfdP+XLn1X3pHaLOXCUXmJmmA6Fe6V
         waIouFju4TGif/Z2YAQvqUhz3b/rcDpYOKTRk98vq8e2Im4okJ51Yss40yTfGGC3q3
         QvIol4uJrRGAQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVHYY4ktnz4wxR;
        Tue, 22 Aug 2023 15:13:21 +1000 (AEST)
Date:   Tue, 22 Aug 2023 15:13:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the dmaengine tree with Linus' tree
Message-ID: <20230822151319.2cf59635@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/stLB8OgiwCK1=HG7.1szn1=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/stLB8OgiwCK1=HG7.1szn1=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the dmaengine tree got a conflict in:

  drivers/dma/mcf-edma.c

between commit:

  0a46781c89de ("dmaengine: mcf-edma: Fix a potential un-allocated memory a=
ccess")

from Linus' tree and commit:

  923b13838892 ("dmaengine: mcf-edma: Use struct_size()")

from the dmaengine tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/dma/mcf-edma.c
index 9413fad08a60,28304dd8763a..000000000000
--- a/drivers/dma/mcf-edma.c
+++ b/drivers/dma/mcf-edma.c
@@@ -190,15 -189,9 +189,15 @@@ static int mcf_edma_probe(struct platfo
  		return -EINVAL;
  	}
 =20
 -	chans =3D pdata->dma_channels;
 +	if (!pdata->dma_channels) {
 +		dev_info(&pdev->dev, "setting default channel number to 64");
 +		chans =3D 64;
 +	} else {
 +		chans =3D pdata->dma_channels;
 +	}
 +
- 	len =3D sizeof(*mcf_edma) + sizeof(*mcf_chan) * chans;
- 	mcf_edma =3D devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
+ 	mcf_edma =3D devm_kzalloc(&pdev->dev, struct_size(mcf_edma, chans, chans=
),
+ 				GFP_KERNEL);
  	if (!mcf_edma)
  		return -ENOMEM;
 =20

--Sig_/stLB8OgiwCK1=HG7.1szn1=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTkQ+8ACgkQAVBC80lX
0GzjiAf/VsXreApY8BVi+qhsTtoYSKce2sMjm6YaEXwB9SzBgdQGhlNifx3EAEGx
AnfMw6MWisUfH5CffEW0qYWCCW44u2WphV5iyahEDXoutn/9V0adfnbAKWXziyM+
37bppH2hfXSmKfmCCQefEJRgZuR+YYdQej+Gjpp3L0lAygiRA0fRxrsO4JpfNTKN
4m+wUjUNny3zW25sIuhPMnNeq1l3c/Eks/z2IuaWIHsSRHifB5WHdJ77bXx8ruUy
HUCX2WqBuQ0FQeAU+WmQT9OpUHr4u6C6Akysj4K470/RLzgtMHHN20c0PGaabebr
fzwwIuLeyxAu5VJWcHVauMfskSwtKQ==
=5qBK
-----END PGP SIGNATURE-----

--Sig_/stLB8OgiwCK1=HG7.1szn1=--
