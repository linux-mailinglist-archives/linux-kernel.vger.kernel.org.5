Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB2076895A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 02:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGaAXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 20:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGaAXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 20:23:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B70A1;
        Sun, 30 Jul 2023 17:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690762976;
        bh=JlyC7xX6YRAjfY+BJvIeslbDpyrbJNzV0Pn7JECl8ng=;
        h=Date:From:To:Cc:Subject:From;
        b=b2lIF1a88q+4khD02Wv2RV+HkJqsoDUitLGqUN3xbzu1A8jwDBXFRyi2YeHnEhE4v
         3kS75Zyrs6jJXZplyaMCgsjnOGQ5KEUAVngdC4VP3G7GzZhEazPRI1kL4OQsTNmPg1
         QhqK+GdQ6MPdKL8ewvPVkhPfLtqtOCmMLDSziMlI/TJQA3HxwWUc7sl9NLvM4GdA26
         4gNR9phasaya/HoDzGFcpMuLeTybLPWlzXhxmKdFMASqibQhFSbLPZBThkD2BYqmN4
         ORRk8XBGoricEShve+ISpAKjNUUoeFHhmqhloBGODSQFQz+AVdkYKiNYJ1T2nYgFgM
         jQzJXarIThnNw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RDf8b4lD1z4wbv;
        Mon, 31 Jul 2023 10:22:55 +1000 (AEST)
Date:   Mon, 31 Jul 2023 10:22:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20230731102254.2c9868ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wZu=aJ1U7grPfU8_xT3sbWF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wZu=aJ1U7grPfU8_xT3sbWF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/dsa/port.c

between commit:

  9945c1fb03a3 ("net: dsa: fix older DSA drivers using phylink")

from the net tree and commit:

  a88dd7538461 ("net: dsa: remove legacy_pre_march2020 detection")

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

diff --cc net/dsa/port.c
index 2f6195d7b741,c63cbfbe6489..000000000000
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@@ -1720,22 -1686,8 +1686,15 @@@ int dsa_port_phylink_create(struct dsa_
  	if (err)
  		mode =3D PHY_INTERFACE_MODE_NA;
 =20
- 	/* Presence of phylink_mac_link_state or phylink_mac_an_restart is
- 	 * an indicator of a legacy phylink driver.
- 	 */
- 	if (ds->ops->phylink_mac_link_state ||
- 	    ds->ops->phylink_mac_an_restart)
- 		dp->pl_config.legacy_pre_march2020 =3D true;
-=20
 -	if (ds->ops->phylink_get_caps)
 +	if (ds->ops->phylink_get_caps) {
  		ds->ops->phylink_get_caps(ds, dp->index, &dp->pl_config);
 +	} else {
 +		/* For legacy drivers */
 +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 +			  dp->pl_config.supported_interfaces);
 +		__set_bit(PHY_INTERFACE_MODE_GMII,
 +			  dp->pl_config.supported_interfaces);
 +	}
 =20
  	pl =3D phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn),
  			    mode, &dsa_port_phylink_mac_ops);

--Sig_/wZu=aJ1U7grPfU8_xT3sbWF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTG/t4ACgkQAVBC80lX
0GwHAwgAnl/nArYn9tWD8GHbwXIgxyd62jf5TGXcc4KditZHOeLb9rFmdPx0eXyK
GQhFqQ61l/wz9djN3SC+ReiPk6htfsHMi8nMyHqylw768fuY3Yw9yXg6fkvcd41f
gBSaqxCLF/XRIfL8QP1gISgX9zxhV7PdyW7g+QJptoJ9c9fi2FSGlUS2PBfHEmR5
A3SmwvYek+tTpQdcxsWYCzWCQ4Ge/3WaBBcl5XhSWfg+sB+8UE/T8nfkqm3ZbvEN
G8p1N+c/ai4IlCCFWCARJJDDkPeBduBy3YLqqTWdqiDbY808A8yad+BeD6+15SMv
v1SiHSIvGtpCc0yVw4nzV6ZWNdZm+A==
=EdLa
-----END PGP SIGNATURE-----

--Sig_/wZu=aJ1U7grPfU8_xT3sbWF--
