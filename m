Return-Path: <linux-kernel+bounces-58884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F1584EE17
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF131C2395F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCC451016;
	Thu,  8 Feb 2024 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="o5Z+jDJP"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5784F1EE;
	Thu,  8 Feb 2024 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436580; cv=none; b=F/QNElg5nG0c59wwj0eW8idV6BF8nQKxmHPjoZRkr0yS7KxNz0tYxZu09NOCasEepoTrqNKa9YPp60p/2ogjN3JwzYEOlBPne0atnlg5QeaoYpwwsksRwML5Nswkr4XnBzdhEpi8JYBU4I1HOKsSkxbRNUfzutaQHYUg2zSU5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436580; c=relaxed/simple;
	bh=p0GgrDVddXy5cinEKXWSu6CMVmd6nvI+TEu518DlJKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=X878rUIm9Jd4wunSqd9gLO9WXJ6uk5+kA6eCabzecJuLs/9brIBYBcKxJqVYFZee46/UCbVGbt0D4pJI/g3AcPUVmRwl8KjnrGR7yY8e3SiuJwiwF8TKTFLg0hh0nS0CkRCstR9sUQJEwOEKJioCprLapU8SciLYocvlmPK+Onc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=o5Z+jDJP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707436568;
	bh=JF9u5Fa1dVmcPt1ipcp/lcqbXM8SZnozmRqVtHfvw4U=;
	h=Date:From:To:Cc:Subject:From;
	b=o5Z+jDJPWJort99XiG8EnaY7WEPAiq3GppygibjGCjC6w3iumm8CTEf6uQqNbD3Gn
	 ixlyp78qdAQDazg3mVQRV1k/5IJol+C4UO9znqOe1M9FNly3Zm1kCeMtU/v1rnnqkl
	 tuT8gAIXo8wod4gfBd2Dimx0KWry39lrL9HFxzGRuQCkCufEH7u//qVEVpBW4T41gE
	 8FfsrYhJoWfP21sJkosctKYd7DMhcBQ362q9wrSxEJIr1Of5N6xJcobUrLiC7ZfUz1
	 oOQVDVGQ1X4kr9dg4dpgtTfJqx/HDCpb46Y1R356IVz15QEm1V8L1ssDkfbu5B4wCf
	 5lgYh3PZpzHgA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TWDQb0Qcgz4x04;
	Fri,  9 Feb 2024 10:56:07 +1100 (AEDT)
Date: Fri, 9 Feb 2024 10:56:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Wireless <linux-wireless@vger.kernel.org>, Daniel Gabay
 <daniel.gabay@intel.com>, Johannes Berg <johannes.berg@intel.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>
Subject: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20240209105606.66e7808b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_NyQymrl.JNnwVrYyY.hUzv";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/_NyQymrl.JNnwVrYyY.hUzv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  drivers/net/wireless/intel/iwlwifi/mvm/tx.c

between commit:

  2e57b77583ca ("wifi: iwlwifi: mvm: use correct address 3 in A-MSDU")

from the wireless tree and commit:

  3d869feacb74 ("wifi: iwlwifi: mvm: use FW rate for non-data only on new d=
evices")

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

diff --cc drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 461f26d9214e,4981bb1f0251..000000000000
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@@ -520,16 -520,31 +520,41 @@@ static void iwl_mvm_set_tx_cmd_crypto(s
  	}
  }
 =20
 +static void iwl_mvm_copy_hdr(void *cmd, const void *hdr, int hdrlen,
 +			     const u8 *addr3_override)
 +{
 +	struct ieee80211_hdr *out_hdr =3D cmd;
 +
 +	memcpy(cmd, hdr, hdrlen);
 +	if (addr3_override)
 +		memcpy(out_hdr->addr3, addr3_override, ETH_ALEN);
 +}
 +
+ static bool iwl_mvm_use_host_rate(struct iwl_mvm *mvm,
+ 				  struct iwl_mvm_sta *mvmsta,
+ 				  struct ieee80211_hdr *hdr,
+ 				  struct ieee80211_tx_info *info)
+ {
+ 	if (unlikely(!mvmsta))
+ 		return true;
+=20
+ 	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT))
+ 		return true;
+=20
+ 	if (likely(ieee80211_is_data(hdr->frame_control) &&
+ 		   mvmsta->sta_state >=3D IEEE80211_STA_AUTHORIZED))
+ 		return false;
+=20
+ 	/*
+ 	 * Not a data frame, use host rate if on an old device that
+ 	 * can't possibly be doing MLO (firmware may be selecting a
+ 	 * bad rate), if we might be doing MLO we need to let FW pick
+ 	 * (since we don't necesarily know the link), but FW rate
+ 	 * selection was fixed.
+ 	 */
+ 	return mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ;
+ }
+=20
  /*
   * Allocates and sets the Tx cmd the driver data pointers in the skb
   */

--Sig_/_NyQymrl.JNnwVrYyY.hUzv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXFahYACgkQAVBC80lX
0GxqUQf9Gn+VS0VsOzqLDeD950s6TnUCH7fNBvRJ4gsxYgXFMeUb5Ztixn1QPJvL
o1I7HQGueNStvqVlSMWyyhytUdbdxucoc/pUeYYKBWWbGxSVNLPiSQ2WvXO/2cbL
Ru1/YmqcgIR/fRFS/qIrxHop0vrvXwv+3c3Ka0QCG/qi/zIoGrSxJUHH9rKRR+AV
BXfjgJQlaL0HoJ+l0PlhxVl5RnKphgLPXmRLwsJDR+tNnn0VoKTW0YN07jJSeEad
yZ2x7c9lFnZ2f2hmY6dXRKEQo1W3CHfisP3yVOckAfdIkasPK6ZK3tPV2IEhL3Te
M885DZ3y6ea5dK6svCtdSvpr/A5gOA==
=0bto
-----END PGP SIGNATURE-----

--Sig_/_NyQymrl.JNnwVrYyY.hUzv--

