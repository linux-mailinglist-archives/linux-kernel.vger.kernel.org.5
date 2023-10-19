Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FFB7CF5D2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbjJSKv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbjJSKvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:51:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE53B6;
        Thu, 19 Oct 2023 03:50:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 119EC1FD8C;
        Thu, 19 Oct 2023 10:50:51 +0000 (UTC)
Received: from lion.mk-sys.cz (unknown [10.163.44.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A11482C503;
        Thu, 19 Oct 2023 10:50:50 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id B44FA2016B; Thu, 19 Oct 2023 12:50:48 +0200 (CEST)
Date:   Thu, 19 Oct 2023 12:50:48 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] ethtool: fix clearing of WoL flags
Message-ID: <20231019105048.l64jp2nd46fxjewt@lion.mk-sys.cz>
References: <20231019070904.521718-1-o.rempel@pengutronix.de>
 <20231019090510.bbcmh7stzqqgchdd@lion.mk-sys.cz>
 <20231019095140.l6fffnszraeb6iiw@lion.mk-sys.cz>
 <20231019122114.5b4a13a9@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mumhc6hbb5xme4hm"
Content-Disposition: inline
In-Reply-To: <20231019122114.5b4a13a9@kmaincent-XPS-13-7390>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         TAGGED_RCPT(0.00)[];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 119EC1FD8C
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mumhc6hbb5xme4hm
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 12:21:14PM +0200, K=F6ry Maincent wrote:
> On Thu, 19 Oct 2023 11:51:40 +0200 > Michal Kubecek <mkubecek@suse.cz> wr=
ote:
> >=20
> > The issue was indeed introduced by commit 108a36d07c01 ("ethtool: Fix
> > mod state of verbose no_mask bitset"). The problem is that a "no mask"
> > verbose bitset only contains bit attributes for bits to be set. This
> > worked correctly before this commit because we were always updating
> > a zero bitmap (since commit 6699170376ab ("ethtool: fix application of
> > verbose no_mask bitset"), that is) so that the rest was left zero
> > naturally. But now the 1->0 change (old_val is true, bit not present in
> > netlink nest) no longer works.
>=20
> Doh I had not seen this issue! Thanks you for reporting it.
> I will send the revert then and will update the fix for next merge-window.

Something like the diff below (against current mainline) might do the
trick but it's just an idea, not even build tested.

Michal


diff --git a/net/ethtool/bitset.c b/net/ethtool/bitset.c
index 883ed9be81f9..4d4398879c95 100644
--- a/net/ethtool/bitset.c
+++ b/net/ethtool/bitset.c
@@ -74,6 +74,28 @@ static void ethnl_bitmap32_clear(u32 *dst, unsigned int =
start, unsigned int end,
 	}
 }
=20
+/**
+  * ethnl_bitmap32_equal() - Compare two bitmaps
+  * @map1:  first bitmap
+  * @map2:  second bitmap
+  * @nbits: bit size to compare
+  *
+  * Return: true if first @nbits are equal, false if not
+  */
+
+static bool ethnl_bitmap32_equal(const u32 *map1, const u32 *map2,
+				 unsigned int nbits)
+{
+	bool ret;
+
+	if (memcmp(map1, map2, nbits / 32 * sizeof(u32)))
+		return false;
+	if (nbits % 32 =3D=3D 0)
+		return true;
+	return !((map1[nbits / 32] ^ map2[nbits / 32]) &
+		 ethnl_lower_bits(nbits % 32));
+}
+
 /**
  * ethnl_bitmap32_not_zero() - Check if any bit is set in an interval
  * @map:   bitmap to test
@@ -431,7 +453,7 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int=
 nbits,
 			      ethnl_string_array_t names,
 			      struct netlink_ext_ack *extack, bool *mod)
 {
-	u32 *orig_bitmap, *saved_bitmap =3D NULL;
+	u32 *saved_bitmap =3D NULL;
 	struct nlattr *bit_attr;
 	bool no_mask;
 	bool dummy;
@@ -462,9 +484,6 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int=
 nbits,
 			return -ENOMEM;
 		memcpy(saved_bitmap, bitmap, nbytes);
 		ethnl_bitmap32_clear(bitmap, 0, nbits, &dummy);
-		orig_bitmap =3D saved_bitmap;
-	} else {
-		orig_bitmap =3D bitmap;
 	}
=20
 	nla_for_each_nested(bit_attr, tb[ETHTOOL_A_BITSET_BITS], rem) {
@@ -481,7 +500,7 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int=
 nbits,
 				      names, extack);
 		if (ret < 0)
 			goto out;
-		old_val =3D orig_bitmap[idx / 32] & ((u32)1 << (idx % 32));
+		old_val =3D bitmap[idx / 32] & ((u32)1 << (idx % 32));
 		if (new_val !=3D old_val) {
 			if (new_val)
 				bitmap[idx / 32] |=3D ((u32)1 << (idx % 32));
@@ -490,6 +509,8 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int=
 nbits,
 			*mod =3D true;
 		}
 	}
+	if (saved_bitmap)
+		*mod =3D ethnl_bitmap32_cmp(saved_bitmap, bitmap, nbits);
=20
 	ret =3D 0;
 out:

--mumhc6hbb5xme4hm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmUxCgQACgkQ538sG/LR
dpX6Agf6Aht9OqISQ9BQEbmfWk3BZYKgfcBISlXEq1+XD2W1wIP0ZoDjTxDcBFt7
uQS9NdTZ1VS3ESDaF3s3JMOjEjr8n9I5qGsyjJhZdznSMn9+z5kqK512iS8ntpnM
1QyutXBb7cWaoBR9ixvc98J3NbjuBCzJoDCvir6tb4oDM/rHouPV51BctF3Aoxef
bLZkWnwVupeFMB3qAOiGfFVzuxS62oaVKySuReJNKil/A+g5EXkVJj2GGKTqOcJ0
VNRSscGq0B2IMOqiGJA8e1csQZZ90qD+ZmpXKf+QlOdqF/ddhkpkMj/lqK6WVL2X
lXwPSVtCwiJ0IJdji5uKvNpyLgXNdQ==
=I33N
-----END PGP SIGNATURE-----

--mumhc6hbb5xme4hm--
