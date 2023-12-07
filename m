Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529DE80926E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjLGUg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjLGUgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:36:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BC3171A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:36:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B75C433C8;
        Thu,  7 Dec 2023 20:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701981387;
        bh=A/iJPAJZbCyqXwpvMP5DNRiXuMJzxGLIa64KiWx8Gas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AexSbexJDdMRswMqpmCdOlHy2crmiHPWy9KFikL1+b2b7eNj7Oo1EZ44VOWsy2U88
         OeaRxbiJi00cyTUY4bziwCtpr+2QZpTl+4mEt2Ujx2M85ok0VyNA92hBtk4cmpMXWn
         UgQLxN5ZvcFy1gjkjc4ACN4HsjQZXjvXgGIwzNX20ufxaw7OuMt2nUtz1e7KMUJjKB
         pjVGdTpPgg45CON4WHIgBsgy5wlWiETvDuU1qx6v769g/T+B8McsVuYKCd4JaRVJB7
         hx7y4vYIoJvK4DV7s2PusDCaRcAAjs3Yqxo6AGHFerphjZI6EGN6V8oGhcqZC6p4Ma
         bwIOLfPLxV2KQ==
Date:   Thu, 7 Dec 2023 20:36:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Gergo Koteles <soyer@irl.hu>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 03/16] ASoC: tas2781: disable regmap regcache
Message-ID: <5f3f0306-799f-4f3b-9e05-fbd300c59d5d@sirena.org.uk>
References: <cover.1701906455.git.soyer@irl.hu>
 <21a183b5a08cb23b193af78d4b1114cc59419272.1701906455.git.soyer@irl.hu>
 <0b836c10-b21b-4275-8dd0-254dd5467497@sirena.org.uk>
 <47097f19398808b64f4cc87c2a3c7cc462fb2416.camel@irl.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Uj2TarlHLm2msvZq"
Content-Disposition: inline
In-Reply-To: <47097f19398808b64f4cc87c2a3c7cc462fb2416.camel@irl.hu>
X-Cookie: Two is company, three is an orgy.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Uj2TarlHLm2msvZq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 09:19:34PM +0100, Gergo Koteles wrote:
> On Thu, 2023-12-07 at 18:20 +0000, Mark Brown wrote:
> > On Thu, Dec 07, 2023 at 12:59:44AM +0100, Gergo Koteles wrote:

> > > The amp has 3 level addressing (BOOK, PAGE, REG).
> > > The regcache couldn't handle it.

> > So the books aren't currently used so the driver actually works?

> It writes to the book 0 and 8c. The initialization works with regcache,
> because it writes also the i2c devices.

I can't see any references to 0x8c in the driver?

> > >  static int tas2781_system_suspend(struct device *dev)
> > > @@ -770,10 +758,7 @@ static int tas2781_system_suspend(struct device =
*dev)
> > >  		return ret;
> > > =20
> > >  	/* Shutdown chip before system suspend */
> > > -	regcache_cache_only(tas_priv->regmap, false);
> > >  	tasdevice_tuning_switch(tas_priv, 1);
> > > -	regcache_cache_only(tas_priv->regmap, true);
> > > -	regcache_mark_dirty(tas_priv->regmap);

> > How can this work over system suspend?  This just removes the cache with
> > no replacement so if the device looses power over suspend (which seems
> > likely) then all the register state will be lost.  A similar issue may
> > potentially exist over runtime suspend on an ACPI system with
> > sufficiently heavily optimised power management.

> In runtime_resume, only one of the two amplifiers goes back.
> The runtime_suspend sets the current book/prog/conf to -1 on all
> devices, and tas2781_hda_playback_hook will restore the
> program/configuration/profile with tasdevice_tuning_switch.

What does "go back" mean? =20

> And only one, because tasdevice_change_chn_book directly changes the
> address of i2c_client, so the unlucky one gets invalid values in its
> actual book from regcache_sync.

The code creates the impression that writing to one tas2781 writes to
all of them, is that not the case?

> system_restore doesn't work at all, because regcache_cache_only stays
> true since system_suspend.

Presumably the next runtime resume would make the device writable again?

> It works without the regcache functions.

How would the devices get their configuration restored?

This sounds very much like a case of something working for your specific
system in your specific test through some external factor rather than
working by design, whatever problems might exist it seems fairly obvious
to inspection that this patch would make things worse for other systems.

At a minimum this patch needs a much clearer changelog (all the patches
I looked at could use clearer changelogs) which explains what's going on
here, I would really expect to see something that replaces the use of
the cache sync to restore the device state for example.

--Uj2TarlHLm2msvZq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVyLMUACgkQJNaLcl1U
h9A1fQf/Tlm20RKXzkcJxmQRhcBpwToF4r81+C/V1oU79kt+sva9XYW8cdM7zpJQ
LRgZIL4PcwHJIFjlxILYMs7iUaYnGqYEcL9OTxorCkVKUA29gqpF0LJLLQhxuCje
FVEHeQLgF1lPk2bu0WuJeyvOJuAjXQYRrmSdIFLIQZOS4r4T3HsjX4OIV6fiGaxR
pZZp+/R9MMFRe5nnA3nIsKVeqA21rH7rGdN0eCZsMhbRF82Vy9N8MNoAPw8EwgVU
d1DQ9lsWKqnvZkRnEIca9VU5kfcswwqtvj4fQn4e3mv2mrQpKBMXvng7lGHM5Hn5
43hKhgOyvrEp9y/L+pdxWi/piD+Uog==
=DLg/
-----END PGP SIGNATURE-----

--Uj2TarlHLm2msvZq--
