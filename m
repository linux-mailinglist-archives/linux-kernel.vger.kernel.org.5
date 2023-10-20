Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440887D0637
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346827AbjJTBnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346809AbjJTBnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:43:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431ED119;
        Thu, 19 Oct 2023 18:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697766180;
        bh=RcONGGUP+t0yTiKTpy5L7tV29oN1Vf/lUY4ZI43AkQc=;
        h=Date:From:To:Cc:Subject:From;
        b=LL8WP0QbE4BK9Tnt4Qnp6mPi9IYZ8kedhEiHglDyZYXnXYVBSRWRlya8AwoqvJIF+
         13rauMxbbwrD2/Nrz0khQIE1PEEv3+ex1gmPxegiAFYpf7S8IodR51W405Ulsfh0F3
         uQrkhSpo/SWChMbf5uQGVhos8qkudDler4oQDKzM1LFo7UJ+auiL/RkwyCUpHzB5Wm
         QsymJd9cIo/0mA8k+0RS5fNhFbyVc8FxgOWMr77LLUkYEjtqpIws1MifLtQ06PRAVo
         kub+w+HltR+d+xn0Euy5QHUuYaNfZoLUhwUwXDzsSKzVoogr2kElE0cU57vFLKeRnY
         Yb1fFWnjcLHSQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SBS5c0RDpz4wnx;
        Fri, 20 Oct 2023 12:43:00 +1100 (AEDT)
Date:   Fri, 20 Oct 2023 12:42:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20231020124259.7d77b077@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vp5RwhVEh75twrm4tNXaI7H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vp5RwhVEh75twrm4tNXaI7H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

sound/soc/sof/intel/hda.c: In function 'hda_dsp_remove':
sound/soc/sof/intel/hda.c:1384:16: error: 'return' with a value, in functio=
n returning void [-Werror=3Dreturn-type]
 1384 |         return 0;
      |                ^
sound/soc/sof/intel/hda.c:1330:6: note: declared here
 1330 | void hda_dsp_remove(struct snd_sof_dev *sdev)
      |      ^~~~~~~~~~~~~~
sound/soc/sof/intel/hda.c: In function 'hda_dsp_remove_late':
sound/soc/sof/intel/hda.c:1392:1: error: control reaches end of non-void fu=
nction [-Werror=3Dreturn-type]
 1392 | }
      | ^
cc1: all warnings being treated as errors

Caused by a bad automatic merge between commit

  e4d09de3919b ("ASoC: SOF: make .remove callback return void")

and commit

  3d1a05581361 ("ASoC: SOF: Intel: Move binding to display driver outside o=
f deferred probe")

from the sound tree.

I have applied the follwoing merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 20 Oct 2023 12:37:26 +1100
Subject: [PATCH] fix for bad merge of "ASoC: SOF: Intel: Move binding to
 display driver outside of deferred probe"

with "ASoC: SOF: make .remove callback return void"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 sound/soc/sof/intel/hda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 2f12265c472b..8342fcf52f52 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1380,8 +1380,6 @@ void hda_dsp_remove(struct snd_sof_dev *sdev)
=20
 	if (!sdev->dspless_mode_selected)
 		iounmap(sdev->bar[HDA_DSP_BAR]);
-
-	return 0;
 }
=20
 int hda_dsp_remove_late(struct snd_sof_dev *sdev)
@@ -1389,6 +1387,8 @@ int hda_dsp_remove_late(struct snd_sof_dev *sdev)
 	iounmap(sof_to_bus(sdev)->remap_addr);
 	sof_hda_bus_exit(sdev);
 	hda_codec_i915_exit(sdev);
+
+	return 0;
 }
=20
 int hda_power_down_dsp(struct snd_sof_dev *sdev)
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/vp5RwhVEh75twrm4tNXaI7H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUx2yMACgkQAVBC80lX
0GyE8Qf+KPpRGYyXxqxsyyp51ZIxJDlXBy+18P4irT6UVAVo//OKygfM7Rje8M21
L2rgJqKRR7eqzZY9PJ06pOVjYoimLIhl4Jl8Trmbmq3ImKm3M4lZGXoIKnp9XSxH
2XogZuYPZkYOzcQG9vbdNXq0pQWi9kdVPLZYHXG6ge9sxSiLE4FmblGcpW9A/yQq
OpiTv1z75mCg9h52EV7F5uqY695ikiFnrozRm3LzhPHEr/U6/tbvXssnQkMqWV1f
GaZuu4sdLbHDIE5pqCw2Kh+qDBIvqbP82/vw2Ytqy/iw3oIEwIB1yVIRBRvqBbDa
zZIBxSvrmmM3YITpGGqLtcXzr2N2sA==
=wz9p
-----END PGP SIGNATURE-----

--Sig_/vp5RwhVEh75twrm4tNXaI7H--
