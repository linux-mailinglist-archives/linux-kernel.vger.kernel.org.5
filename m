Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66A679C3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242473AbjILDPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242025AbjILDP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:15:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250926CD7;
        Mon, 11 Sep 2023 19:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694486786;
        bh=9w8N1w65eM3j1HplfovIWdoaEqkHF1YpWPFz5tjpCFo=;
        h=Date:From:To:Cc:Subject:From;
        b=naIlmKO7lUSHzKh3udlfvGQAyEBpEO6uHF4815s40RKckMzEJAizrivmQ/FhSlhOb
         G8M6UGG9lYS9LFgrsuwa+zgk2k3X2OjKSWczolx31ctq1GKJebXMx2I2BTTzz/CCwW
         ikOShORCXJgH5ZRZLx9cUL/NfgOvsf12vuw7q5ZN9kIO8FTptXQ359QQI0NCu6gkLF
         dn3MzwOGVskGP5zFN6Jli0nqWgrT6EiKs8QOa5dc2GlCxTtd+LhZldZ152pXGSn7Cl
         +/yy0eYtelhaE2jCRG1Lk0J0AIGIYsVdUz2XrhWe5Nj9pindOZ6Y5LIbq3kh+0BaHK
         24pVpuzDswEPg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rl7JJ4Pfgz4x3C;
        Tue, 12 Sep 2023 12:46:24 +1000 (AEST)
Date:   Tue, 12 Sep 2023 12:46:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20230912124623.6591edd4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EtIg2kmiN+NByGDtODittXt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EtIg2kmiN+NByGDtODittXt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  net/wireless/nl80211.c

between commit:

  37c20b2effe9 ("wifi: cfg80211: fix cqm_config access race")

from the wireless tree and commit:

  076fc8775daf ("wifi: cfg80211: remove wdev mutex")

from the wireless-next tree.

I fixed it up (I used a supplied resolution from Johannes - see below)
and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/wireless/nl80211.c
index 7a88361b3414,ab0aea7dca7d..fe06c238d4ef
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@@ -6191,12 -6135,8 +6150,12 @@@ static int nl80211_start_ap(struct sk_b
 =20
  	err =3D nl80211_calculate_ap_params(params);
  	if (err)
- 		goto out_unlock;
+ 		goto out;
 =20
 +	err =3D nl80211_validate_ap_phy_operation(params);
 +	if (err)
- 		goto out_unlock;
++		goto out;
 +
  	if (info->attrs[NL80211_ATTR_AP_SETTINGS_FLAGS])
  		params->flags =3D nla_get_u32(
  			info->attrs[NL80211_ATTR_AP_SETTINGS_FLAGS]);
@@@ -12884,11 -12747,10 +12767,11 @@@ static int nl80211_set_cqm_rssi(struc=
t=20
  				u32 hysteresis)
  {
  	struct cfg80211_registered_device *rdev =3D info->user_ptr[0];
 +	struct cfg80211_cqm_config *cqm_config =3D NULL, *old;
  	struct net_device *dev =3D info->user_ptr[1];
  	struct wireless_dev *wdev =3D dev->ieee80211_ptr;
- 	int i, err;
  	s32 prev =3D S32_MIN;
 -	int i;
++	int i, err;
 =20
  	/* Check all values negative and sorted */
  	for (i =3D 0; i < n_thresholds; i++) {
@@@ -12917,11 -12781,9 +12800,9 @@@
  	if (n_thresholds =3D=3D 1 && thresholds[0] =3D=3D 0) /* Disabling */
  		n_thresholds =3D 0;
 =20
- 	wdev_lock(wdev);
- 	old =3D rcu_dereference_protected(wdev->cqm_config,
- 					lockdep_is_held(&wdev->mtx));
 -	if (n_thresholds) {
 -		struct cfg80211_cqm_config *cqm_config;
++	old =3D wiphy_dereference(wdev->wiphy, wdev->cqm_config);
 =20
 +	if (n_thresholds) {
  		cqm_config =3D kzalloc(struct_size(cqm_config, rssi_thresholds,
  						 n_thresholds),
  				     GFP_KERNEL);
@@@ -12936,22 -12796,10 +12815,20 @@@
  		       flex_array_size(cqm_config, rssi_thresholds,
  				       n_thresholds));
 =20
 -		wdev->cqm_config =3D cqm_config;
 +		rcu_assign_pointer(wdev->cqm_config, cqm_config);
 +	} else {
 +		RCU_INIT_POINTER(wdev->cqm_config, NULL);
  	}
 =20
 -	return cfg80211_cqm_rssi_update(rdev, dev);
 +	err =3D cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
 +	if (err) {
 +		rcu_assign_pointer(wdev->cqm_config, old);
 +		kfree_rcu(cqm_config, rcu_head);
 +	} else {
 +		kfree_rcu(old, rcu_head);
 +	}
- unlock:
- 	wdev_unlock(wdev);
 +
 +	return err;
  }
 =20
  static int nl80211_set_cqm(struct sk_buff *skb, struct genl_info *info)
@@@ -19107,41 -18879,18 +18907,39 @@@ void cfg80211_cqm_rssi_notify(struct =
ne
  		    rssi_event !=3D NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH))
  		return;
 =20
 -	if (wdev->cqm_config) {
 -		wdev->cqm_config->last_rssi_event_value =3D rssi_level;
 +	rcu_read_lock();
 +	cqm_config =3D rcu_dereference(wdev->cqm_config);
 +	if (cqm_config) {
 +		cqm_config->last_rssi_event_value =3D rssi_level;
 +		cqm_config->last_rssi_event_type =3D rssi_event;
 +		wiphy_work_queue(wdev->wiphy, &wdev->cqm_rssi_work);
 +	}
 +	rcu_read_unlock();
 +}
 +EXPORT_SYMBOL(cfg80211_cqm_rssi_notify);
 +
 +void cfg80211_cqm_rssi_notify_work(struct wiphy *wiphy, struct wiphy_work=
 *work)
 +{
 +	struct wireless_dev *wdev =3D container_of(work, struct wireless_dev,
 +						 cqm_rssi_work);
 +	struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wiphy);
 +	enum nl80211_cqm_rssi_threshold_event rssi_event;
 +	struct cfg80211_cqm_config *cqm_config;
 +	struct sk_buff *msg;
 +	s32 rssi_level;
 +
- 	wdev_lock(wdev);
- 	cqm_config =3D rcu_dereference_protected(wdev->cqm_config,
- 					       lockdep_is_held(&wdev->mtx));
++	cqm_config =3D wiphy_dereference(wdev->wiphy, wdev->cqm_config);
 +	if (!wdev->cqm_config)
- 		goto unlock;
++		return;
 =20
 -		cfg80211_cqm_rssi_update(rdev, dev);
 +	cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
 =20
 -		if (rssi_level =3D=3D 0)
 -			rssi_level =3D wdev->cqm_config->last_rssi_event_value;
 -	}
 +	rssi_level =3D cqm_config->last_rssi_event_value;
 +	rssi_event =3D cqm_config->last_rssi_event_type;
 =20
 -	msg =3D cfg80211_prepare_cqm(dev, NULL, gfp);
 +	msg =3D cfg80211_prepare_cqm(wdev->netdev, NULL, GFP_KERNEL);
  	if (!msg)
- 		goto unlock;
+ 		return;
 =20
  	if (nla_put_u32(msg, NL80211_ATTR_CQM_RSSI_THRESHOLD_EVENT,
  			rssi_event))
@@@ -19151,15 -18900,14 +18949,13 @@@
  				      rssi_level))
  		goto nla_put_failure;
 =20
 -	cfg80211_send_cqm(msg, gfp);
 +	cfg80211_send_cqm(msg, GFP_KERNEL);
 =20
- 	goto unlock;
+ 	return;
 =20
   nla_put_failure:
  	nlmsg_free(msg);
-  unlock:
- 	wdev_unlock(wdev);
  }
 -EXPORT_SYMBOL(cfg80211_cqm_rssi_notify);
 =20
  void cfg80211_cqm_txe_notify(struct net_device *dev,
  			     const u8 *peer, u32 num_packets,

--Sig_/EtIg2kmiN+NByGDtODittXt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT/0P8ACgkQAVBC80lX
0GxmKAgAhFwTkAlObU0Rl4d/XxvO2r6z01TP1U6Ga1NwuhFQfOYh0TPd5ybS30X6
Cgz3tDgyj/KzL7j/FejSdE1cDaFv3HB6OUOcTy8jrEFpLGk8P9ERuI13fsZZeTDi
uCI9SEhM7ZpPjvyysCPsf0lyAfAEDSh6DMWmgyOgwM6O9TV01mQxYF2jFeTA7xWB
BWRdLo/0t6rgew+ygEjMEggmNt/QWjVU5Mn1TseurpFoyZXGuCjXJwPjubv1noKw
n12OwGNQssLKRDKbFI9o7SCia/twSHEKvA/FmGeIn7/48aPsceUR0/u1VhKOjMAO
naFqbuZmU/Nz2ozw2kdvzqlbzgqQPw==
=ZBWJ
-----END PGP SIGNATURE-----

--Sig_/EtIg2kmiN+NByGDtODittXt--
