Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAE27803FC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357325AbjHRCzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357341AbjHRCzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:55:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E697D1706;
        Thu, 17 Aug 2023 19:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692327325;
        bh=ekb03ly0TuZ37SdD+kZOuA0OT7Kkf/BSCodtvDXU54E=;
        h=Date:From:To:Cc:Subject:From;
        b=hajqZ8K3xWTh+ELZSGAWWnuXWAD3mpv9U5MlIKqNMHD3/2pLbs8mj0G3btevsfcnw
         o13aDNu9r2fGs1eI73dyk9tDPE7MOhtE8dwiQOab3Hyuf5pxVu4JbEvXkf4fWc0HsL
         MOOWv32xrBd1y6RseiDUsAJu6H544HNJOD1S0P9kiL1eipRSW8mcRKq3NuVLnVVcuJ
         3H6n0kR0vabKSgWtrZ9XzxCVHN+DTT7MidUTDH1rpjqwJKCogpKXYyvS0nt/ssiCNT
         nyVTCjK6MakkL/DrffNwOuq9Izp/INkDcBij/mIB/snI/dti58XQmEiBlmwGhfotts
         y/L9TNmJwNMzA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRmhD5ZBWz4wb0;
        Fri, 18 Aug 2023 12:55:24 +1000 (AEST)
Date:   Fri, 18 Aug 2023 12:55:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: linux-next: manual merge of the sound tree with the
 sound-asoc-fixes tree
Message-ID: <20230818125523.2c838236@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//hMtXloFXbwf1XE4G7jHfwz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//hMtXloFXbwf1XE4G7jHfwz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound tree got a conflict in:

  sound/soc/codecs/cs35l56.c

between commit:

  897a6b5a030e ("ASoC: cs35l56: Read firmware uuid from a device property i=
nstead of _SUB")

from the sound-asoc-fixes tree and commit:

  898673b905b9 ("ASoC: cs35l56: Move shared data into a common data structu=
re")

from the sound tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc sound/soc/codecs/cs35l56.c
index fd06b9f9d496,19b6b4fbe5de..000000000000
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@@ -1353,22 -1017,26 +1016,22 @@@ static int cs35l56_dsp_init(struct cs35
  	return 0;
  }
 =20
 -static int cs35l56_acpi_get_name(struct cs35l56_private *cs35l56)
 +static int cs35l56_get_firmware_uid(struct cs35l56_private *cs35l56)
  {
- 	struct device *dev =3D cs35l56->dev;
 -	acpi_handle handle =3D ACPI_HANDLE(cs35l56->base.dev);
 -	const char *sub;
++	struct device *dev =3D cs35l56->base.dev;
 +	const char *prop;
 +	int ret;
 =20
 -	/* If there is no ACPI_HANDLE, there is no ACPI for this system, return =
0 */
 -	if (!handle)
 +	ret =3D device_property_read_string(dev, "cirrus,firmware-uid", &prop);
 +	/* If bad sw node property, return 0 and fallback to legacy firmware pat=
h */
 +	if (ret < 0)
  		return 0;
 =20
 -	sub =3D acpi_get_subsystem_id(handle);
 -	if (IS_ERR(sub)) {
 -		/* If bad ACPI, return 0 and fallback to legacy firmware path, otherwis=
e fail */
 -		if (PTR_ERR(sub) =3D=3D -ENODATA)
 -			return 0;
 -		else
 -			return PTR_ERR(sub);
 -	}
 +	cs35l56->dsp.system_name =3D devm_kstrdup(dev, prop, GFP_KERNEL);
 +	if (cs35l56->dsp.system_name =3D=3D NULL)
 +		return -ENOMEM;
 =20
 -	cs35l56->dsp.system_name =3D sub;
 -	dev_dbg(cs35l56->base.dev, "Subsystem ID: %s\n", cs35l56->dsp.system_nam=
e);
 +	dev_dbg(dev, "Firmware UID: %s\n", cs35l56->dsp.system_name);
 =20
  	return 0;
  }
@@@ -1405,14 -1074,14 +1069,14 @@@ int cs35l56_common_probe(struct cs35l56
 =20
  	ret =3D regulator_bulk_enable(ARRAY_SIZE(cs35l56->supplies), cs35l56->su=
pplies);
  	if (ret !=3D 0)
- 		return dev_err_probe(cs35l56->dev, ret, "Failed to enable supplies\n");
+ 		return dev_err_probe(cs35l56->base.dev, ret, "Failed to enable supplies=
\n");
 =20
- 	if (cs35l56->reset_gpio) {
+ 	if (cs35l56->base.reset_gpio) {
  		cs35l56_wait_min_reset_pulse();
- 		gpiod_set_value_cansleep(cs35l56->reset_gpio, 1);
+ 		gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 1);
  	}
 =20
 -	ret =3D cs35l56_acpi_get_name(cs35l56);
 +	ret =3D cs35l56_get_firmware_uid(cs35l56);
  	if (ret !=3D 0)
  		goto err;
 =20
@@@ -1594,12 -1198,14 +1193,12 @@@ void cs35l56_remove(struct cs35l56_priv
  	flush_workqueue(cs35l56->dsp_wq);
  	destroy_workqueue(cs35l56->dsp_wq);
 =20
- 	pm_runtime_suspend(cs35l56->dev);
- 	pm_runtime_disable(cs35l56->dev);
+ 	pm_runtime_suspend(cs35l56->base.dev);
+ 	pm_runtime_disable(cs35l56->base.dev);
 =20
- 	regcache_cache_only(cs35l56->regmap, true);
+ 	regcache_cache_only(cs35l56->base.regmap, true);
 =20
- 	gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
 -	kfree(cs35l56->dsp.system_name);
 -
+ 	gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 0);
  	regulator_bulk_disable(ARRAY_SIZE(cs35l56->supplies), cs35l56->supplies);
  }
  EXPORT_SYMBOL_NS_GPL(cs35l56_remove, SND_SOC_CS35L56_CORE);

--Sig_//hMtXloFXbwf1XE4G7jHfwz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTe3ZsACgkQAVBC80lX
0GyL1wf/ZGNA340XqynLVTPRMfnLs9xQLFvNwqAD5+DVe8m54m+8f6LIpyANh6U5
HyP+TMKSJcUSqiDBTSPHhTMpEVSRtZ2NPw6O4Bd6WjxCzGHAEtqA21B/fL9Or9wE
+tLUBCR/P5eCy74Eyz+DNgBB9XEFlaN2+QtDAZo1njqon+3AGQ77DfxQWIy82FEX
25mFFdz2RyIlqMBcmKWzZwPuuAXjVg8y7ConjGhIqdcwXxJwObPWEoH5yzS4JgSq
W6d2JYhVbA34PmIA8MB+zfF4Z0cd4G52gq8KBoVV+7BWMCPclLvzJBjGqragku4d
s1HbI9Opt9A0bR/fJ9znvJT2S9jEtA==
=IKXt
-----END PGP SIGNATURE-----

--Sig_//hMtXloFXbwf1XE4G7jHfwz--
