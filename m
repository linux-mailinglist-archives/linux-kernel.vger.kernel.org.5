Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E4C7D0627
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346816AbjJTB0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346768AbjJTB0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:26:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634D6112;
        Thu, 19 Oct 2023 18:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697765191;
        bh=1SA1xNxQvd8tzPgP9eFSc47dQbmQd+W12jRnSvCdfu8=;
        h=Date:From:To:Cc:Subject:From;
        b=gs2/Av+T+z3A25jr3LKs9Qs1F9pt+UDhxFccMzbKmtVdYaLw/aIs/Md4TgLd5NxJ/
         dPIrc+JWnVUTIYOI/9JkPdYyFfTHiIqA/WBLMiH59+GL3pIE/afpfIjy2ETlfSqU+B
         7fI1wAYH5b4eROG8aZzWgKEkR+PzNWyTnZayuFNnc1bTf5s4fL0sqBX5kN+2u1XLq+
         MyxeYT1guBFxgbLW+gFLPGhiOus2EmMlqCIFWQZe/Vu6r6Qs6Yi4f6Q6OHy6STIL8Y
         AutyFqIl1oQYBYtXsQpip0xECKNaOSQIq0FAM8xZaL7pKxV+ppErw0gQRS3M01OUkk
         yCfaUWeVzgPUA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SBRkZ4Mtcz4xFS;
        Fri, 20 Oct 2023 12:26:30 +1100 (AEDT)
Date:   Fri, 20 Oct 2023 12:26:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: linux-next: manual merge of the sound-asoc tree with the sound tree
Message-ID: <20231020122629.0289fe9b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SXrtF.7EoapPRK_DgYL+6VK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SXrtF.7EoapPRK_DgYL+6VK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound-asoc tree got conflicts in:

  sound/soc/sof/intel/hda.h
  sound/soc/sof/sof-priv.h

between commits:

  17baaa1f950b ("ASoC: SOF: core: Add probe_early and remove_late callbacks=
")
  3d1a05581361 ("ASoC: SOF: Intel: Move binding to display driver outside o=
f deferred probe")

from the sound tree and commit:

  e4d09de3919b ("ASoC: SOF: make .remove callback return void")

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

diff --cc sound/soc/sof/intel/hda.h
index 8e846684279e,0ebc042c5ce1..000000000000
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@@ -573,10 -576,8 +576,10 @@@ struct sof_intel_hda_stream=20
  /*
   * DSP Core services.
   */
 +int hda_dsp_probe_early(struct snd_sof_dev *sdev);
  int hda_dsp_probe(struct snd_sof_dev *sdev);
- int hda_dsp_remove(struct snd_sof_dev *sdev);
+ void hda_dsp_remove(struct snd_sof_dev *sdev);
 +int hda_dsp_remove_late(struct snd_sof_dev *sdev);
  int hda_dsp_core_power_up(struct snd_sof_dev *sdev, unsigned int core_mas=
k);
  int hda_dsp_core_run(struct snd_sof_dev *sdev, unsigned int core_mask);
  int hda_dsp_enable_core(struct snd_sof_dev *sdev, unsigned int core_mask);
diff --cc sound/soc/sof/sof-priv.h
index e73a92189fe1,40bca5f80428..000000000000
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@@ -165,10 -165,8 +165,10 @@@ struct sof_firmware=20
  struct snd_sof_dsp_ops {
 =20
  	/* probe/remove/shutdown */
 +	int (*probe_early)(struct snd_sof_dev *sof_dev); /* optional */
  	int (*probe)(struct snd_sof_dev *sof_dev); /* mandatory */
- 	int (*remove)(struct snd_sof_dev *sof_dev); /* optional */
+ 	void (*remove)(struct snd_sof_dev *sof_dev); /* optional */
 +	int (*remove_late)(struct snd_sof_dev *sof_dev); /* optional */
  	int (*shutdown)(struct snd_sof_dev *sof_dev); /* optional */
 =20
  	/* DSP core boot / reset */

--Sig_/SXrtF.7EoapPRK_DgYL+6VK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUx10UACgkQAVBC80lX
0GwE6gf+Jj3wCwLrKU5cH8pe4uSSTLms48bCOWeSBGRuQis921IKDAviW4Y2gI/z
ZOAaw1RNVTmZFXHJTJT08Yv/wQ4PDkRT+llbz41CDaGp6SCYxthXf4ahvTZoC4xN
W6zo/Kuqi8TQy+5+vLNe9fLtS+gk1n4/RNVIXrMAy/K+F3f4quT5POIeWS7SyU9r
/r8O/DaMipIdhfnBYC6tDh0ZmZpYRZZezoIzxaoJ+dZcDS7djpSSISOWiz7YorCe
rE8/RvcJFprDSH2f8LnURbA+fWSvGW4SNEB2beL01rO3ERdiTcUZbQNpvNkNM7Tj
9k9bJwQVM639AmShpC/IhIJQGmKETA==
=Ol3s
-----END PGP SIGNATURE-----

--Sig_/SXrtF.7EoapPRK_DgYL+6VK--
