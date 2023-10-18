Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA557CD22E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 04:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjJRCNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 22:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJRCNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 22:13:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF4DF7;
        Tue, 17 Oct 2023 19:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697595216;
        bh=B3MoQ0UHZVQYnHEgV4JwPrpwPSToPMi2A+OnnFE0glE=;
        h=Date:From:To:Cc:Subject:From;
        b=YtWAmdo2Gn5YTCeut34j4G6KApPR7yyZ6AeCDWJP5RsR9XNy7utQ+zfJqdSsusQ83
         aHwM7OkINc26mCTocHn6KnQV31zj4uM6K5xTHBahxS1yGasqbx4tmGQp/CacHBu9PV
         MVb+vtOFY0C0Awq0i6v0Xw7F8NpV/JccdV9KIFOFQARmv7PAD/z7v6sswqn4wylanY
         0bcLYJCBPFGOOtu1f1LG8ATYn9ojvdXNdbtzdP0+YD1hfG3fYysyCD+NeVRREzMkBq
         1kYiIp1HWyM2ltwvp4yjLOCvWl4WtL/xDlPBVtX0CG2/pNJ9Y9goodVEhooJKohkrL
         x937QMrnS+Y+A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9Dsr2VB7z4x1v;
        Wed, 18 Oct 2023 13:13:36 +1100 (AEDT)
Date:   Wed, 18 Oct 2023 13:13:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Rob Herring <robh@kernel.org>
Cc:     Abdel Alkuor <abdelalkuor@geotab.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the usb tree with the devicetree tree
Message-ID: <20231018131334.5fb47992@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_Btt2PWcY33XfiDzmI/Qaaf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_Btt2PWcY33XfiDzmI/Qaaf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml

between commit:

  47b8fb4aef95 ("dt-bindings: usb: ti,tps6598x: Disallow undefined properti=
es")

from the devicetree tree and commit:

  6060d554e891 ("dt-bindings: usb: tps6598x: Add tps25750")

from the usb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
index 6ab674dea4c6,72ac534e6ed2..000000000000
--- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
@@@ -32,14 -47,43 +47,46 @@@ properties
      items:
        - const: irq
 =20
 +  connector:
 +    $ref: /schemas/connector/usb-connector.yaml#
 +
+   firmware-name:
+     description: |
+       Should contain the name of the default patch binary
+       file located on the firmware search path which is
+       used to switch the controller into APP mode.
+       This is used when tps25750 doesn't have an EEPROM
+       connected to it.
+     maxItems: 1
+=20
  required:
    - compatible
    - reg
 =20
+ allOf:
+   - if:
+       properties:
+         compatible:
+           contains:
+             const: ti,tps25750
+     then:
+       properties:
+         reg:
+           maxItems: 2
+=20
+         connector:
+           required:
+             - data-role
+=20
+       required:
+         - connector
+         - reg-names
+     else:
+       properties:
+         reg:
+           maxItems: 1
+=20
 -additionalProperties: true
 +additionalProperties: false
 =20
  examples:
    - |

--Sig_/_Btt2PWcY33XfiDzmI/Qaaf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUvP04ACgkQAVBC80lX
0Gy/uwf/Ssb8Fy+79wjy9/RCB8k+WGDHUeQ5He+RnU1r1PkpL1QlgL5nZxh1aQyD
MykkRmBn+ZgFZTacvrc1lNh7GzTJ8jBWtTt6NJW1jD8UQVEQojx0LYRc4xGobYwt
rO3rJF0Mcdp00PiTWxV1C72K62QRLN8IfqpM+7ebNvBvRFCLaqqdoy5+EF/knenh
xZEY5TMABbLm37FewRMNd7tchQGFaK6VoO5nVYFRtEXBc1HJ1lXM8ehypX9LOfd8
40ycf5JoZg+EAOEpBe1zKhFKTFckp6VgQRRP6RuWZkKe5nackeqlFrcA9riEe1yR
Ft+FuD/V1ZT2TAdVDdkt6iq9u9VJTQ==
=EAfY
-----END PGP SIGNATURE-----

--Sig_/_Btt2PWcY33XfiDzmI/Qaaf--
