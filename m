Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945707DBEB5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjJ3RVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJ3RVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:21:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2BDAB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:21:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECA8C433C8;
        Mon, 30 Oct 2023 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698686460;
        bh=lwbzUuW1aOxjwsXApLRGWceIvJkvo1xXplXhfkETyWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgXxKtg40pWM70heAuYMx5enwpJX/oe3SYbETr95gr9hUhtTXa3jg/nh2ctpjrLuR
         ud+tVgkj/LQmF27nR2mKAgfeS0cL33U0Z5/kWgZKhPMIimOwuOVHQDn9cuLdAHZHA2
         VBHbe8GVnBFvUbAkHL08sd9GIW1eo/0t1BpR3P8qxRWffqoZ/CnvrsZd2kKAjMEnEl
         /KCN45kvA3MwpybObB+Zg7bG8ovv9SPwXcwTh1OQ1EP6ktteTZ97r2/1aF7F0KagoD
         jsxgzzkwTErQY81VNIFw+i/xEApCiMk+kR6zdae6YOlKVtZayWCQZYMKm7XDnLEdNg
         fDNQc7Bi5l7AQ==
Date:   Mon, 30 Oct 2023 17:20:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Baojun Xu <baojun.xu@ti.com>, lgirdwood@gmail.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kevin-lu@ti.com, shenghao-ding@ti.com, peeyush@ti.com,
        navada@ti.com, tiwai@suse.de
Subject: Re: [PATCH v3] ASoC: tas2783: Add source files for tas2783 driver.
Message-ID: <9d922584-288a-4b73-83ef-477d1bc58521@sirena.org.uk>
References: <20231028092409.96813-1-baojun.xu@ti.com>
 <7f4465c1-5e8e-4c5f-bbff-d2c930326986@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5LMN/5Y4nwdbngJK"
Content-Disposition: inline
In-Reply-To: <7f4465c1-5e8e-4c5f-bbff-d2c930326986@linux.intel.com>
X-Cookie: Boy!  Eucalyptus!
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5LMN/5Y4nwdbngJK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 30, 2023 at 11:05:39AM -0500, Pierre-Louis Bossart wrote:

> > +static bool tas2783_readable_register(struct device *dev, unsigned int reg)
> > +{
> > +	switch (reg) {
> > +	case 0x000 ... 0x080:	/* Data port 0. */

> No, this is wrong. All the data port 'standard' registers are "owned" by
> the SoundWire core and handled during the port prepare/configure/bank
> switch routines. Do not use them for regmap.

> In other words, you *shall* only define vendor-specific registers in
> this codec driver.

This seems to come up a moderate amount and is an understandable thing
to do - could you (or someone else who knows SoundWire) perhaps send a
patch for the regmap SoundWire integration which does some validation
here during registration and at least prints a warning?

Also worth noting that the default is going to be that the registers are
readable if the driver doesn't configure anything at all so perhaps at
least for just readability this might be worth revisiting.

> > +static const struct snd_soc_dapm_widget tasdevice_dapm_widgets[] = {
> > +	SND_SOC_DAPM_AIF_IN("ASI", "ASI Playback", 0, SND_SOC_NOPM, 0, 0),
> > +	SND_SOC_DAPM_AIF_OUT("ASI OUT", "ASI Capture", 0, SND_SOC_NOPM,
> > +		0, 0),
> > +	SND_SOC_DAPM_SPK("SPK", NULL),
> > +	SND_SOC_DAPM_OUTPUT("OUT"),
> > +	SND_SOC_DAPM_INPUT("DMIC")
> > +};

> Can you clarify what "ASI" is?

ASI seems to be a fairly commonly used name in TI devices...  In general
naming that corresponds to the datasheet should be fine, especially for
internal only things like this sort of DAPM widget.  I'd guess it's
something like Audio Serial Interface but not actually gone and looked.

--5LMN/5Y4nwdbngJK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU/5fYACgkQJNaLcl1U
h9ARhAgAhgRuLFI+OnWYzXEkD7ojB6ZTuPex3LKj3PhI8JGwXsJbN41iFSzInS10
tMksTNi7ewYcziVKhNzn6Jq+XlWPNlCgtuxE6/hL8UdKt2KqsJGA9r7DKXNp2/kz
8zM3B/I/fRtVb6vPRyAzI7XPkFxjBWkqeraDYLXY1Rdw3EYhn9VDLy6+PLoGiRG2
08tlnKKEBG6PMytmIrqmAP+VRJbq8YLH6wnRoggvvtKGj+xhpLjyqm5wO3+LDgqi
bE1C2z7l/gqouaVoeK2vVVaXKPGZkTH0eZ7Ksk4WQ8aoakuxbGQnH6LdEh25N2es
DNLcFKS5P4KGRORpzNVluc7RB23jDw==
=dOoN
-----END PGP SIGNATURE-----

--5LMN/5Y4nwdbngJK--
