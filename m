Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D167ADAEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjIYPHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjIYPHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:07:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CF1103;
        Mon, 25 Sep 2023 08:07:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087A5C433C8;
        Mon, 25 Sep 2023 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695654429;
        bh=bivzZDncrKe0eAtcWd82K5+BpAK/gZqr/XIOn3YurAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0K0o8kJ56GSNHPhAk6QFPkhTSVBV+cmOb2ikJeU7Mkv4vVR5axSxnyeDIE7ZSINb
         /0I+0XyU3gTLA3LNDm+P3moOj9fpid57kqif0rnqOpgoW5R1me9H/E1accyHUTSQo0
         M/E0WoKNi01FBpo3f4B+Si9oeAOcVqNAHh3b+C58hwtqht4MZeg4XszGPx6h6U8upM
         Ka7zAvP+P1c5YuKz7d7ST9d/+pbw3P/zYHSUEM7Hyjrv82BV3w8eoIxvSnL9GmSeNl
         3xt69wWujr7S07Ws0mfNPUfoUwyKX0VZBevM18O5os5CXz8G5lLPdpRvMH6T67pQ+l
         NVTA/VrvYxhAg==
Date:   Mon, 25 Sep 2023 17:07:06 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     abelvesa@kernel.org, benjamin.bara@skidata.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        festevam@gmail.com, frank@oltmanns.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, mturquette@baylibre.com, peng.fan@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        shawnguo@kernel.org
Subject: Re: [PATCH 06/13] clk: keep track if a clock is explicitly configured
Message-ID: <2z7ujpgyptfa2wtzmb2jvb6krngh5fpnbbqjhx22rwv2qvofas@uple3zsk42nx>
References: <pgnlrokdqqqclqvp4h2zk7iyq2jfncnvvwavovydovdmj3d2gf@kszpslmeswbr>
 <20230920072216.1737599-1-bbara93@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w3qki6j3vhdewku6"
Content-Disposition: inline
In-Reply-To: <20230920072216.1737599-1-bbara93@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w3qki6j3vhdewku6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

On Wed, Sep 20, 2023 at 09:22:16AM +0200, Benjamin Bara wrote:
> On Tue, 19 Sept 2023 at 09:07, Maxime Ripard <mripard@kernel.org> wrote:
> > On Mon, Sep 18, 2023 at 12:40:02AM +0200, Benjamin Bara wrote:
> > > From: Benjamin Bara <benjamin.bara@skidata.com>
> > >
> > > When we keep track if a clock has a given rate explicitly set by a
> > > consumer, we can identify unintentional clock rate changes in an easy
> > > way. This also helps during debugging, as one can see if a rate is set
> > > by accident or due to a consumer-related change.
> > >
> > > Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> > > ---
> > >  drivers/clk/clk.c            | 25 +++++++++++++++++++++++++
> > >  include/linux/clk-provider.h |  1 +
> > >  2 files changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index 8f4f92547768..82c65ed432c5 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -70,6 +70,7 @@ struct clk_core {
> > >       unsigned long           rate;
> > >       unsigned long           req_rate;
> > >       unsigned long           new_rate;
> > > +     unsigned long           set_rate;
> >
> > This is pretty much what req_rate is supposed to be about. Why didn't it
> > work in your case?
>=20
> I picked this one to respond first because I think some of the
> implemented stuff just workarounds the current req_rate behaviour.
>=20
> Currently, I have two "problems" with it:
> 1. It's set during initialization[1]. In this phase, the *required* rate
>    isn't known yet, so it should be 0 imo.

Agreed. Ideally, it should be another value (like -1) since 0 is also
used for rates in some drivers, but that's a separate story :)

> 2. It's set during re-parenting[2,3]. Also here, just because we
>    re-parent, the active consumer (which set the req_rate to a valid
>    value) still requires the clock to have the same rate.
>
> That is basically the reason why we have no info if the req_rate is
> really "required" by a consumer or if it is just set because the parent
> had it at some time. It's only usage is here[4], which IMO doesn't
> really depends on the wrong behaviour I described above.

Ah, right.

> The respective sub-tree we talk about on the imx8mp looks like this (one
> example for the the LVDS-only case):
> video_pll1 (pll; 7x crtc rate - currently, rate is assigned via dt)
>   video_pll1_bypass (mux; 7x crtc rate)
>     video_pll1_out (gate; 7x crtc rate)
>       media_ldb (divider; 7x crtc rate)
>         media_ldb_root_clk (gate; 7x crtc rate)
>       media_disp2_pix (divider; 1x crtc rate)
>         media_disp2_pix_root_clk (gate; 1x crtc rate)
>       media_disp1_pix (divider; unused for now)
>         media_disp1_pix_root_clk (gate; unused for now)
>=20
> The problem is that the panel driver sets media_disp1_pix_root_clk,
> ldb-bridge driver sets media_ldb_root_clk. All the others have a
> req_rate of the rate video_pll1 had when they got initialized or
> re-parented.

So we have only dividers, but what is the range of those? ie, could we
get away with running the video-pll1 at 297/594MHz (or a multiple of it)
and cover most of the pixel rates for LVDS?

> My idea was, that when media_disp2_pix_root_clk is set to the CRTC rate,
> IMO all clocks along the line (especially media_disp1_pix, which is
> "seen" as child of the PLL, and the actual divider for
> media_disp2_pix_root_clk) need to set their new rate as "required",
> because the subtree below them relies on it. This might be a wrong
> approach. It might be sufficient to have a req_rate only on the nodes
> that actually require it.

That makes total sense. However, the clock framework hasn't been
designed around modifying the rate of multiple clocks in one go, which
is pretty much what you want to achieve at the moment.

You're already reaching those limits in your patches since, for example,
you kind of hardcode the tolerance the clocks consider to be ok within
the framework, which something that really belongs to each clock driver.

This is why I'm insisting in figuring out whether we can run the main
PLL at a frequency that is good enough for each use-case. That way it
doesn't have to change, you don't have to propagate anything, the
problem becomes much simpler :)

> However, IMHO we need to make sure that *all* required rates
> (especially the ones of leaves!) are respected after a change.

Part of the issue I was telling you about is that clk_set_rate never
really expressed any time duration, it's very much a fire and forget
call, so for all the CCF cares the rate could change on the very next
instruction and it would be ok.

Doing so would also introduce some subtle corner-cases, like what is
happening if cpufreq set your CPU frequency to (for example) 1GHz, but
the firmware lowered it to 600MHz for thermal throttling. What happens
then? Which rate do you consider the required rate?

This would effectively mean merging clk_set_rate with
clk_set_rate_exclusive, but the latter never really caught up because
most clocks don't care, and it's fairly inconvenient to use.

If there is an effort to be made (and I still don't believe we need to),
then I think we should put in into improving clk_set_rate_exclusive()
rather than changing the semantics of clk_set_rate().

Maxime

--w3qki6j3vhdewku6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZRGiGgAKCRDj7w1vZxhR
xYF8AQD3ptB1rqfyR5RILANllLGYphcfR0zwbSaykHIjMoX3lwD/eeKkYte4HbhG
AZ1KPxfPovlj7jmuBLB0KW7uY228YQg=
=Dr5U
-----END PGP SIGNATURE-----

--w3qki6j3vhdewku6--
