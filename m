Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A2676359B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjGZLue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjGZLua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:50:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12322D79
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9E4561AA8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441B9C433C8;
        Wed, 26 Jul 2023 11:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690372169;
        bh=lbF0liGI7QHy1bpQGze9hCny5OUhXwB6mv1T2xUmixM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=udFHHdx//JEXY8/J5haNDvJ5+2W4enEwTQaN8r9/mk6x9Nap8a5w66bQBFShMoQD6
         LP08fnZz6w+7Qe3jgYRyXWYKaj8pyIVvxiIyXPKcVuaQohmTj4iGUGdJR2VLJHBmZI
         XAEtD7g2zk9e7uVCVzThcE3AM1NcmjIsMIXFFYFM9611RURnIXm4MIXmfqmzkDwOWA
         ufp/H8We2eVZD+c719ZG0koNjl8GrcBeEMF94rpeOx8FzrXX4hR2Qq8NXGvTa/X3Ym
         DsPpBk2lTv5RSGntLKH55ipC+la+9JtxNuNB7uBxnk6xETnmqUZm9jz2z+Xiq1/H/U
         J+sPKSqCdmXog==
Date:   Wed, 26 Jul 2023 12:49:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     justinstitt@google.com
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] ASoC: intel: avs: refactor strncpy usage in topology
Message-ID: <8f9467c4-06c5-4e48-8f7e-2565e6b3b637@sirena.org.uk>
References: <20230725-sound-soc-intel-avs-remove-deprecated-strncpy-v1-1-6357a1f8e9cf@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iADVvZ87iNIM/HX1"
Content-Disposition: inline
In-Reply-To: <20230725-sound-soc-intel-avs-remove-deprecated-strncpy-v1-1-6357a1f8e9cf@google.com>
X-Cookie: Just to have it is enough.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iADVvZ87iNIM/HX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 10:08:38PM +0000, justinstitt@google.com wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1].
>=20
> A suitable replacement is `strscpy` [2].
>=20
> There are some hopes that someday the `strncpy` api could be ripped out
> due to the vast number of suitable replacements (strscpy, strscpy_pad,
> strtomem, strtomem_pad, strlcpy) [1].
>=20
> [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nu=
l-terminated-strings
> [2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
>=20
> ---
>=20
>=20
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---

You've put your signoff after a --- which means it gets deleted when
applied, don't do this.  The Signoff should be start of the main
changelog.

--iADVvZ87iNIM/HX1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTBCEIACgkQJNaLcl1U
h9AFWQf+NwrKTGgyPU7rnOtBaswSIlcHbij0ClP3vSjtJ/15xC6XRDzxtti6UZa5
HIOsxjuMRRTq6JKuh2/uRKc3IY2ZXqL1Wy7paSR+YB23DY+IBl3npR2aL3Bz7bP/
YMvM2vvrzdLmxmkY+uvvuGGfA46jlgnKT6ULtHECymLHXUolMeXOGWsy0Gd+YPAO
BL2P3v2NuPBe1b0KWfljfVaeGYXVGGvq9Xm4BcZPY3PCFngW00BvduN+USbQZFOy
+EQV18D7MB3sYYXmzmukLOdRNRSkKwE7p2q7Vy3ab0QX/Cwj1bV+hpKnKo2ielOW
IrmADzy2JEdr5W1FP6jXtCemKMKkEQ==
=g3ra
-----END PGP SIGNATURE-----

--iADVvZ87iNIM/HX1--
