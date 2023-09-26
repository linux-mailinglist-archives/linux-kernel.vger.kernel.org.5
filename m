Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9867AE3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjIZClX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjIZClU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:41:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB5610A;
        Mon, 25 Sep 2023 19:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695696072;
        bh=lHFDEW0kq8NtsAXpBZ++Cp7iz9lotlz7DmLLsh5/l20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M69x6LKc4uJ4uFRycLqidqnGAxfhWCADft1UAL+Qzr79X5I4vs5X4gqDWcHl42JlU
         6KW+ZHYRqfc+ZGchPVGzhX02kbW+wCsCaGLLj2bqLSFRrUF32LTBQTKD9vsPolPRh6
         XouktsWpvCV+qMQPTamUzCGpBzqrvktrX4X/sP43kcO13w0ohjNwFc116RB7YTIpwl
         bWPCOqO9taeBlpmJ0Gx4rIPOl5uEXeBSR2bcfAzQMjrtg0QJXSrdbUFNaR7IhQ2tGb
         k4MVlcNa0Ym4JYD1oZbalJCaXgu+brGm8DAno3VymqMy3t+AmQEfLbPMZu3AlHPwWa
         izGJax7MBdRQg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RvkWq63BNz4xP9;
        Tue, 26 Sep 2023 12:41:11 +1000 (AEST)
Date:   Tue, 26 Sep 2023 12:41:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20230926124111.29103070@canb.auug.org.au>
In-Reply-To: <20230926120253.4f1e5730@canb.auug.org.au>
References: <20230926120253.4f1e5730@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZKHl_fTBWpCZtF5YDNHFwqc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZKHl_fTBWpCZtF5YDNHFwqc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 26 Sep 2023 12:02:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the wireless-next tree got conflicts in:
>=20
>   net/mac80211/cfg.c
>=20
> between commit:
>=20
>   31db78a4923e ("wifi: mac80211: fix potential key use-after-free")
>=20
> from the wireless tree and commit:
>=20
>   4d3acf4311a0 ("wifi: mac80211: remove sta_mtx")
>=20
> from the wireless-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

That wasn't quite right.  The final resolution is below.
--=20
Cheers,
Stephen Rothwell

diff --cc net/mac80211/cfg.c
index 0e3a1753a51c,5bc6b1329465..3e7bb883137c
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@@ -472,8 -470,9 +470,10 @@@ static int ieee80211_add_key(struct wip
  	struct ieee80211_local *local =3D sdata->local;
  	struct sta_info *sta =3D NULL;
  	struct ieee80211_key *key;
 +	int err;
 =20
+ 	lockdep_assert_wiphy(local->hw.wiphy);
+=20
  	if (!ieee80211_sdata_running(sdata))
  		return -ENETDOWN;
 =20
@@@ -565,15 -561,7 +562,11 @@@
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

--Sig_/ZKHl_fTBWpCZtF5YDNHFwqc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUSRMcACgkQAVBC80lX
0GwEggf/TpfEL0JAdGjvNEPw9ytkOvN59ikvJc+qHM/Z1gVYUr+DRYqCq5xew2de
JhVLx+++FPoX8mg5rtEfwBLVst6E7BaWWTTE7dXHXT0ZYihTfc7efZ9kzs9zWuco
I54+9WUG0l7qdbmAhQAO50qDyKpy0FD2ONLNbbB1DbiFZJoJWtvyQ4jEO8yK2V1I
EruqpiwoAip+sjMIG73NrZkD5kcD4NkpoFVRojYrhnZzMwV8u9vYfumHm37SsHCT
Y8AzrrHCwMRIgSwg6GoPUYHo2QVERQtqlwiXZeIhogp6YiyKoPvCCe4CBFiF6Mzk
/cSwnFj3FrE+pLSAzxlsLqIlvjA2ZA==
=uduE
-----END PGP SIGNATURE-----

--Sig_/ZKHl_fTBWpCZtF5YDNHFwqc--
