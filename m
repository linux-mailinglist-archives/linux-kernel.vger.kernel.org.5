Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB107ACDBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjIYBy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjIYBy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:54:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08222BD;
        Sun, 24 Sep 2023 18:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695606888;
        bh=illLIB5QiVO2I/ClRB29TMm1vjfH3lNfej6QyfJwAlA=;
        h=Date:From:To:Cc:Subject:From;
        b=a1dkN4sqWf3EZaSUnXcpK1HH4yMS2zprFt5PRLs428UzH2rwT9tugkOQvbrFY7NZX
         6+7mBYFtzXDgsCyiTiwDM4HHqJOUWLrIQJqiwUuXUQNTdZUAqrWSysBWtp6WpdhFC4
         9rgZgKBaa6h8W36Cv/3mk3lL+j4ak456xFOj5/tj6KdN7aBalYJEdhbXp+6XW2kT4f
         Tc0fLNgpwW7iMoZFcsWqO3qt6D0DyGzSIPBkHLBDVhQE8g7858gYQsw3hEvBjUsl2/
         BjMQp2SUZ3DvfCpFevZlm9Wgrww1lKM0pqgrBxzliO1hZ9uXFY7+yQkOihwdcERYVe
         BQMfDc5RiCTgw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rv5Xm1Pkxz4xMC;
        Mon, 25 Sep 2023 11:54:48 +1000 (AEST)
Date:   Mon, 25 Sep 2023 11:54:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: linux-next: manual merge of the sound-asoc tree with the sound tree
Message-ID: <20230925115446.12bf0047@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kFonsbELoWoR1fd.EnROUzm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kFonsbELoWoR1fd.EnROUzm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound-asoc tree got a conflict in:

  sound/pci/hda/cs35l41_hda.c

between commit:

  447106e92a0c ("ALSA: hda: cs35l41: Support mute notifications for CS35L41=
 HDA")

from the sound tree and commit:

  77bf613f0bf0 ("ASoC: cs35l41: Fix broken shared boost activation")

from the sound-asoc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc sound/pci/hda/cs35l41_hda.c
index 92b815ce193b,c74faa2ff46c..000000000000
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@@ -555,9 -527,15 +555,9 @@@ static void cs35l41_hda_play_done(struc
 =20
  	dev_dbg(dev, "Play (Complete)\n");
 =20
- 	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 1, NULL,
+ 	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 1,
  			      cs35l41->firmware_running);
 -	if (cs35l41->firmware_running) {
 -		regmap_multi_reg_write(reg, cs35l41_hda_unmute_dsp,
 -				       ARRAY_SIZE(cs35l41_hda_unmute_dsp));
 -	} else {
 -		regmap_multi_reg_write(reg, cs35l41_hda_unmute,
 -				       ARRAY_SIZE(cs35l41_hda_unmute));
 -	}
 +	cs35l41_mute(dev, false);
  }
 =20
  static void cs35l41_hda_pause_start(struct device *dev)
@@@ -567,8 -545,8 +567,8 @@@
 =20
  	dev_dbg(dev, "Pause (Start)\n");
 =20
 -	regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mut=
e));
 +	cs35l41_mute(dev, true);
- 	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 0, NULL,
+ 	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 0,
  			      cs35l41->firmware_running);
  }
 =20

--Sig_/kFonsbELoWoR1fd.EnROUzm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUQ6GcACgkQAVBC80lX
0GwKNwf+Ll+aOwTj5SE8yKPgegw+AGoTUwNGTJk4ByK8QC9+wRiolbeij44JtmQa
KseedWdBeCrpKMuPwW5ocfj4m4xKhfhrN3GE2arVOJRQksg/nGuOVb7rqNL2k4nK
AgUSo5CkFrgQHAVBrpXSsbi7cb2o7G+KpSyATIU5NebU8tQJZ9sru3xh7WA34V9C
O1DhuwbMUbdQuDbYNsWJbemqlQKzFjyHHkYlNQ+wuNMhQOetoogmjXmS0JiV5c9s
mdZHqt1X4vnG+tw9hb4kpXBOCV+vVDJ/0Oa5cFTgLFP9iN85dA/198Yo7Bi0Rst8
I/IAclCFDtFfvGQfa1Gm8R1BfEwYqw==
=vnK/
-----END PGP SIGNATURE-----

--Sig_/kFonsbELoWoR1fd.EnROUzm--
