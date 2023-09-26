Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB027AE38F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjIZCDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjIZCDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:03:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65713DF;
        Mon, 25 Sep 2023 19:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695693774;
        bh=bbAcJayj1L84857O4FBA8j8oz+LRbSeUOuV7lWJ03ck=;
        h=Date:From:To:Cc:Subject:From;
        b=fgnlhs7nWut1MvXLhBgAoJqVXIe81kmzYC22iwIEMNia+IqF8Srl/2ro+CQd12SdS
         fLwXFuA4bO+MEj/4uUWWw5007o/kO8v47gKzJU3B8YTKa9b523IZA7u03BAzxFHoyA
         VwdsSpav7Lyv4f/P/hZmkxkql491RRgrFotwDplBHZEt61Gu7iWW/jOULexpnZBlHj
         dEdQtKeuk3Lz/RXKfT3eHOQCr1ien/bQGXca/aMzsovtHCvpdeNTf4XpmBbqKPHcvX
         Hp2cNF+h1KSJMOK7hWXmyDBo+3fgfkmjTnr8kz3ZzcI3zKDm3gBZz0tHILcT2IvC+B
         FPSjNhYqKjsfg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rvjgf01Ttz4xP9;
        Tue, 26 Sep 2023 12:02:53 +1000 (AEST)
Date:   Tue, 26 Sep 2023 12:02:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20230926120253.4f1e5730@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/syRt0eOJQcCbFd=QbOtETN4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/syRt0eOJQcCbFd=QbOtETN4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got conflicts in:

  net/mac80211/cfg.c

between commit:

  31db78a4923e ("wifi: mac80211: fix potential key use-after-free")

from the wireless tree and commit:

  4d3acf4311a0 ("wifi: mac80211: remove sta_mtx")

from the wireless-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/mac80211/cfg.c
index 0e3a1753a51c,5bc6b1329465..000000000000
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@@ -565,15 -561,7 +561,11 @@@ static int ieee80211_add_key(struct wip
  		break;
  	}
 =20
 -	return ieee80211_key_link(key, link, sta);
 +	err =3D ieee80211_key_link(key, link, sta);
 +	/* KRACK protection, shouldn't happen but just silently accept key */
 +	if (err =3D=3D -EALREADY)
 +		err =3D 0;
-=20
-  out_unlock:
- 	mutex_unlock(&local->sta_mtx);
-=20
 +	return err;
  }
 =20
  static struct ieee80211_key *

--Sig_/syRt0eOJQcCbFd=QbOtETN4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUSO80ACgkQAVBC80lX
0GzQLwgAnBH0KvaJHxWsSbMIwPyNkzaDt8WO3G8EXyCNl5WgLBMq4hzk0Y7dcvJ2
KJQ2s7hh9GZXJ7KzF9hL68uhfNpWJzBZPpUVUokARPS0CceqSpvuJ9rN5RLzVoI4
TOcSgxZpKUl74VbBDzrTPHz6D75Mke4UeVMHq2ZNy7coXOUmVxBwKkvvrjG3lUW7
KfgG+XaviADGiXPPdKn5I9MVFuykqoaNK6n74sZVsbTU3yXl98vkeF2a5DLHbVmJ
IAThVHIOH8Gi52stLz4na1gyHsh5BNhalCqNqZAtQyih7W7BRwqYwFo3jr7dD1ls
ilWn+L86bQrpwEUMMdz7zejT8VnOZA==
=WjiI
-----END PGP SIGNATURE-----

--Sig_/syRt0eOJQcCbFd=QbOtETN4--
