Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B038280957F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjLGWjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjLGWjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:39:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32289133
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:39:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DC8C433C8;
        Thu,  7 Dec 2023 22:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701988761;
        bh=MsLLpv1+/XDyn3UAs12wR75ZLa9IjOrbPm1kkfTtosE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7kkiL7Ak/7GSuJ1qH4EHyUTxoHiRKTwCqw53xa/OV4dG+kFQuSJLBVZpzq1ocJGa
         QIuH0T9Tbb8/jeLEiHZW6rxhzy8mrpYV2qyy0rNpEzPjqkHTXC4eqXH7mOKNTVrMTv
         5o7+wMTHoTkQarxlu6vWVUA1lwwSCE40hv+TlBJW4f8Pf64VgaN9dZ8dSr3kbNZjS6
         bOaD0RbbdGg8s0e2/vqLwp9n3THviaOJZ2LYhM/PYjonw2zONkzwOSHDuSNqODY/It
         RG4qsrMtDz3JS/nbpytfBiewpy1Kp5f+7hll2qUBJGeR9b0D92tSZ73TbZfU2jLYGo
         7F3ic/gYzLXRw==
Date:   Thu, 7 Dec 2023 22:39:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Gergo Koteles <soyer@irl.hu>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 03/16] ASoC: tas2781: disable regmap regcache
Message-ID: <bf24488f-e4e1-4d3e-a67e-fe74c05acda4@sirena.org.uk>
References: <cover.1701906455.git.soyer@irl.hu>
 <21a183b5a08cb23b193af78d4b1114cc59419272.1701906455.git.soyer@irl.hu>
 <0b836c10-b21b-4275-8dd0-254dd5467497@sirena.org.uk>
 <47097f19398808b64f4cc87c2a3c7cc462fb2416.camel@irl.hu>
 <5f3f0306-799f-4f3b-9e05-fbd300c59d5d@sirena.org.uk>
 <b0ab21657f2e4f0825579de97ca012e294d1e743.camel@irl.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FPnKMl3SLG0UUQNN"
Content-Disposition: inline
In-Reply-To: <b0ab21657f2e4f0825579de97ca012e294d1e743.camel@irl.hu>
X-Cookie: Two is company, three is an orgy.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FPnKMl3SLG0UUQNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 10:12:13PM +0100, Gergo Koteles wrote:
> On Thu, 2023-12-07 at 20:36 +0000, Mark Brown wrote:

> > > And only one, because tasdevice_change_chn_book directly changes the
> > > address of i2c_client, so the unlucky one gets invalid values in its
> > > actual book from regcache_sync.

> > The code creates the impression that writing to one tas2781 writes to
> > all of them, is that not the case?

> Yes, the tasdevice_* functions, but the regcache_sync doesn't know
> this.

So this syncing is done in software not hardware?  My understanding was
that this was a hardware thing.

> > How would the devices get their configuration restored?

> tasdevice_tuning_switch calls tasdevice_select_tuningprm_cfg which
> checks whether the devices needs a new program or configuration.

> the runtime_suspend and system resume set the devices cur_prog,
> cur_conf to -1.

...

> The tas2781_hda_playback_hook calls the tasdevice_tuning_switch

And there are no registers other than these programs?

--FPnKMl3SLG0UUQNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVySZQACgkQJNaLcl1U
h9Dz0Qf9EolHA/7hwfIR8tUUDiJRQu5X9PEQJHjmqNgUo0b2RfbIXugc4S/61wPO
reW9pzswW/8Uix3UZcpSo16bjD2ZphcGMFoaFuYBfVf+7j8mg9fUMCuX2LcY5ch1
0EUB6G/1a3qGcVhC8yC9hGtF24lMOogSClM+t3jj8RhH60EU7VLKc1B4GhX+Vm/E
ROtqapM8Tx5oi1tsQLV8nQ+zGdOXdqsg1kZNp9Arv7EcgQ2YkhqA3C6bnb2lebwF
2RZzfAdeX1wlXobP0fzO0h626QjKcHq1YqQgPc6Eyl+QIZfIZ67yvY3y0WJwHh6r
TIHr3QC4TNT60x8XouFh6PuIHtjnaA==
=eHRJ
-----END PGP SIGNATURE-----

--FPnKMl3SLG0UUQNN--
