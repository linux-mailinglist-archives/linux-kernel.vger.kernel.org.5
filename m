Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D9C7AE3A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjIZCU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIZCUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:20:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B577BF;
        Mon, 25 Sep 2023 19:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695694811;
        bh=TcPGSxwt9MInQj/celUnubsm5b1vkF3Gs12n9nTNg+c=;
        h=Date:From:To:Cc:Subject:From;
        b=e9xdnIuv+S5IexeCO7HdwPtekTa9fEYqE+2bQnMadh1ivXxvgDwpv6gXZ6ENQg+OG
         ncOiQyjwezbh3KJUO1sY8CrLaQsprvYpudhZHQ/lvinoN/ywcvay6Xn9Ex+0ikrJ7U
         WFOYqcuy2RAHeVb6wHa5ybX5ti0YZSqOPrCqG46d3C+aMVyDqOMgHNrjl8ETiz2Dc6
         BBJ0s/NCk5Q/H8OOPfGo3KYn0syGAWzIDz1f8EVAZhHu3UDXiEmpr0jQfhrSTBPn9h
         C0rkYSY4uNqoZBHsY7ZaMciVQeYGJy75hsGzlxp9NKRq4gwChcmIsg/Fvd4mAg0mZg
         ZY/2fIn8NMVWw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rvk3b0wJwz4xPR;
        Tue, 26 Sep 2023 12:20:11 +1000 (AEST)
Date:   Tue, 26 Sep 2023 12:20:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20230926122009.67735060@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KDVFAo=cdHDYBMd1yQd=GhK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KDVFAo=cdHDYBMd1yQd=GhK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  net/mac80211/key.c

between commits:

  31db78a4923e ("wifi: mac80211: fix potential key use-after-free")
  d097ae01ebd4 ("wifi: mac80211: fix potential key leak")

from the wireless tree and commit:

  2a8b665e6bcc ("wifi: mac80211: remove key_mtx")

from the wireless-next tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/mac80211/key.c
index 0665ff5e456e,ac410f6632b5..000000000000
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@@ -881,21 -875,20 +880,22 @@@ int ieee80211_key_link(struct ieee80211
 =20
  		if (link_id >=3D 0) {
  			link_sta =3D rcu_dereference_protected(sta->link[link_id],
- 							     lockdep_is_held(&sta->local->sta_mtx));
+ 							     lockdep_is_held(&sta->local->hw.wiphy->mtx));
 -			if (!link_sta)
 -				return -ENOLINK;
 +			if (!link_sta) {
 +				ret =3D -ENOLINK;
 +				goto out;
 +			}
  		}
 =20
- 		old_key =3D key_mtx_dereference(sdata->local, link_sta->gtk[idx]);
+ 		old_key =3D wiphy_dereference(sdata->local->hw.wiphy,
+ 					    link_sta->gtk[idx]);
  	} else {
  		if (idx < NUM_DEFAULT_KEYS)
- 			old_key =3D key_mtx_dereference(sdata->local,
- 						      sdata->keys[idx]);
+ 			old_key =3D wiphy_dereference(sdata->local->hw.wiphy,
+ 						    sdata->keys[idx]);
  		if (!old_key)
- 			old_key =3D key_mtx_dereference(sdata->local,
- 						      link->gtk[idx]);
+ 			old_key =3D wiphy_dereference(sdata->local->hw.wiphy,
+ 						    link->gtk[idx]);
  	}
 =20
  	/* Non-pairwise keys must also not switch the cipher on rekey */
@@@ -910,10 -901,10 +910,8 @@@
  	 * Silently accept key re-installation without really installing the
  	 * new version of the key to avoid nonce reuse or replay issues.
  	 */
--	if (ieee80211_key_identical(sdata, old_key, key)) {
- 		ret =3D -EALREADY;
- 		goto unlock;
 -		ieee80211_key_free_unused(key);
 -		return 0;
--	}
++	if (ieee80211_key_identical(sdata, old_key, key))
++		return -EALREADY;
 =20
  	key->local =3D sdata->local;
  	key->sdata =3D sdata;
@@@ -936,13 -927,6 +934,10 @@@
  		ieee80211_key_free(key, delay_tailroom);
  	}
 =20
 +	key =3D NULL;
 +
 + out:
 +	ieee80211_key_free_unused(key);
-  unlock:
- 	mutex_unlock(&sdata->local->key_mtx);
-=20
  	return ret;
  }
 =20

--Sig_/KDVFAo=cdHDYBMd1yQd=GhK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUSP9kACgkQAVBC80lX
0GxOwwf/bGjeKYnuKz2e6EzFgvC6zVZFPet+UiRM7RA8Y7l73Bu+N5l+34eCMcJh
fj9LCqslTg/5o/BIoe9boDMsZadr4UCNVUpa5i5kF4Cz5zM2m4Pyy+z0eq7sKHp8
gGdfXbsm+S2E2leqTK7JPU1H/GlWVhejhrw4xtJFzjMIZJuA0CnYNNZF/Z4Bai/w
JQnF57Dlgh/XNlXmCvo8zPJyBQZmPXy1QObGOCFVcAkeKz/I619241jyHbU7zap2
+M06DOAf6JRUeJMog5w3mL+/WAHOJSNddFAvYQtzYQqq68LUEXCqG17jsQT7c8LC
L3+JSUtMP5zoyQKIG3IBwyeSzJ5HFQ==
=gRb+
-----END PGP SIGNATURE-----

--Sig_/KDVFAo=cdHDYBMd1yQd=GhK--
