Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9028C7B67F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbjJCLeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJCLeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:34:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1929E;
        Tue,  3 Oct 2023 04:33:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E29C433C7;
        Tue,  3 Oct 2023 11:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696332837;
        bh=jzJQoJEOtgE0PCeISU6Se33lKuEE7ReBhhE5kchD/uY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K7dDC9WGx6YUj3fhmNLR3sAQzWZOH02ZE5rggptZcUme76kJWI3Paa7A8AQ3NtMpY
         WhzMOw9W95ZOSwwY+NEUXfhBt885kWRG0FZKclw5DkywTJjAfVHQqDQGjQTeDb0lGQ
         sq8k9yhLFR+W2VSXvZHMZ72036WCYkH4RAyrpOX07wOfUKS5U6x2mzp6aWZyU3HMjr
         uU/xhPM2k/LHTK6D8Hu13cjRlo0gGdfmVJoO08O/3mB9e95Nsplm44EZIZBUQX/4Pe
         vOALXj3KkYX+4KkGpOOEjo+am6YB+M/2/ciWRit20FQDfHuX0ICeckKeL5T2ad37M0
         KqjWDoJhoDS7w==
Date:   Tue, 3 Oct 2023 13:33:54 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     aford173@gmail.com, benjamin.bara@skidata.com, frank@oltmanns.dev,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Subject: Re: [PATCH RFC 0/4] clk: re-set required rates during clk_set_rate()
Message-ID: <koutffkprg3asrokmaxx6optdbw35ouw2o3llc5kaw6dw4ttrd@kgjijzztzor4>
References: <cjow276e3hsgtaqq6e2lzv3xdxyssoh34wan7lcwunh636wsqv@35eyi5cvbbwd>
 <20231003074407.2856447-1-bbara93@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="keylsesp7i7kvq27"
Content-Disposition: inline
In-Reply-To: <20231003074407.2856447-1-bbara93@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--keylsesp7i7kvq27
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 09:44:07AM +0200, Benjamin Bara wrote:
> Hi Maxime,
>
> thank you for the feedback!
>
> On Mon, 2 Oct 2023 at 14:27, Maxime Ripard <mripard@kernel.org> wrote:
> > There's a couple of things you didn't reply on the first version and
> > you didn't really expand it here:
>
> Sorry for that, wanted to get the reduced series out first to have a
> better discussion base. Planned to reply to them and link to the
> spin-off later, probably should have mentioned that :/ Thanks for
> summarizing!

That's fine, don't worry :)

> > Most clocks don't care, and only the clocks that have used
> > clk_set_rate_exclusive actually care.
>=20
> I think that is one of the main points I don't understand yet... Why? I
> mean, the point of calling clk_set_rate() is to get a certain rate for a
> clock, right? Why should the clock not care if it is changed to
> something completely different?

Because it doesn't matter for most clocks, and doesn't really affect the
system in any way. Or there's never any conflicting rate change that
would impact them. I guess it's on a per-clock basis so it's hard to
generalize, but the fact alone that the CCF is 10+ years old and we only
have to discuss it now is kind of a proof that things mostly work out
for most cases :)

Also, some systems have likely side-stepped the entire problem by
switching different outputs to different PLLs for example if the SoCs
allow to.

And while the vast majority of those drivers don't really care about the
rate being strictly enforced, I would expect a reasonable amount of them
to check the return code of clk_set_rate(). So if you start strictly
enforcing the rate, you'll also have to fail more often because there's
configuration that you just can't handle.

And that would lead to more drivers failing for something they don't
really care about :)

> Maybe I am a bit biased here because I use the imx8mp as a reference.
> On this platform, most hardware blocks have an own divider and
> therefore the clocks which are connected to the blocks are mostly
> "exclusive". E.g. the tree for a panel looks like
> this:
> -osc_24m (oscillator)
> -- video_pll1_ref_sel (mux)
> --- video_pll1 (configurable; shared)
> ---- video_pll1_bypass (mux; shared)
> ----- video_pll1_out (gate; shared)
> ------ media_disp2_pix (divider; "panel exclusive")
> ------- media_disp2_pix_root_clk (gate; "panel exclusive")
> -------- <PANEL>

I guess that's mostly a typical clock tree for a panel. However, notice
that you only took a handful of clocks as an example, and not the 50-100
others in your system. While the panel clock rate is critical, the
register clock speed of the timers probably won't be as much.

And that's what I was mentioning really: out of the 50-100 clocks in
your system right now, you only really care about the rate of ~5, and
most of them are going to be in different subtrees.

So, while your problem is indeed a concern, it's also a corner case.

> > clk_set_rate never provided that guarantee, you're effectively merging
> > clk_set_rate and clk_set_rate_exclusive.
>=20
> Ah, I guess I see what you mean... Since we would error out now on a
> "conflict", this becomes very close to the "exclusiveness concept".

Yeah, exactly. clk_set_rate() gains the "I want this rate to be enforced
forever" property that clk_set_rate_exclusive() provides already.

> However, what I actually try to achieve is to leave the rest of the
> subtree unaffected by a change (if required and possible).
>=20
> > This might or might not be a good idea (it's probably not unless you
> > want to track down regressions forever), but we should really tie this
> > to clk_set_rate_exclusive or merge both.
>=20
> I see that the current "conflict handling" might fit very well for
> clk_set_rate_exclusive(). However, I think it's pretty hard to use
> clk_set_rate_exclusive() in a multi-platform driver, as the other
> competing consumers are not known.

You don't know that with clk_set_rate either though?

> But maybe it makes sense to have the same path and decide on a
> conflict whether we are allowed to do the change or not
> (exclusive/protected).
>=20
> > Why do we need a new req_rate, and why req_rate can't be changed to
> > accomodate your changes.
>=20
> For me, the existing req_rate is a "persistent" rate. It is the rate a
> consumer requires the clock to have. It's something typically for leaves
> of the clock-tree, which are directly connected to (probably
> multi-platform) clock-consuming blocks, e.g. the dividers mentioned.
> The new req_rate is "temporary". It is rather important for the !leaves
> and indicate that a clock is required to change during this
> clk_set_rate() call, in order to fulfill the requested rate.
>=20
> Short example, let's say we have something like this:
> - Video PLL
> -- LVDS divider
> --- LVDS bridge (HW block)
> -- CRTC divider
> --- Panel (HW block)
>=20
> From a hardware-description point of view, the CRTC divider is exclusive
> to the panel and the LVDS divider exclusive to the LVDS bridge. However,
> the Video PLL is not the only possible parent of both and it should also
> not be set exclusively by one of them.
>=20
> When a CRTC rate of 35M is required by the panel, it would be set to the
> following:
> - Video PLL:     req_tmp=3D35M, req=3D-1,  new=3D35M
> -- LVDS divider: req_tmp=3D-1,  req=3D-1,  new=3D35M (div=3D1)
> -- CRTC divider: req_tmp=3D35M, req=3D35M, new=3D35M (div=3D1)
>=20
> Next, the LVDS bridge requires 245M, which would be a multiple of
> 35M. The Video PLL is configured again, this time "by" the LVDS divider:
> - Video PLL:     req_tmp=3D245M, req=3D-1,   new=3D245M
> -- LVDS divider: req_tmp=3D245M, req=3D245M, new=3D245M (div=3D1)
> -- CRTC divider: req_tmp=3D-1,   req=3D35M,  new=3D245M (div=3D1)
>=20
> So without additional interaction (current behaviour), we would set the
> CRTC divider to 245M, which contradicts with the unchanged previous
> requirement stored in req. As req_tmp =3D=3D -1, we know that the new rate
> of the CRTC divider is not crucial for the actual requested change (LVDS
> =3D> 245M). Therefore, what I would like to achieve is to have some
> component/process that tells the CRTC divider to set its div to 7, as
> this won't affect the ongoing requested change and would restore a
> required rate of a different component, which was changed "unintended".

My point earlier was that if we configure the Video PLL from the start
to be 245MHz, then we don't need to worry about it.

For the temporary requested rate, it's not clear to me why we should
store it into the struct clk_core itself. It looks to be transient by
nature, so it would be better in the clk_rate_request structure.
clk_rate_request are now instantiated by functions, maybe we could add a
pointer to the clk_rate_request that triggered it (some kind of
"parent", but most likely to go from the child clock to the parent)?

> > Why do you even need the core to be involved in the first place? You
> > say you think it does, but you haven't answered any of my mails to
> > provide more details and figure out if we can do it without it.
>=20
> We already have this functionality (calc required new rates) inside the
> core and the core currently is the only one knowing all the context
> about the tree-structure and the required and new rates.

I mean, that whole discussion kind of proves that we don't have that
functionality in the core.

> So I think in the example above, calling calc_new_rates() again, this
> time with the CRTC divider and req, might be the simplest solution to
> the problem.
>=20
> I think as the Video PLL isn't directly consumed, we don't really have a
> different possibility to achieve the same outcome, except of starting
> Video PLL already with 245M (e.g. via device-tree).

It doesn't need to happen in the device tree, but that sounds completely
reasonable to me.

> Just for the sake of completeness:
> A "conflict" occurs if this call would try to re-configure Video PLL
> again (if req_tmp is already set; by not involving req here, we
> basically avoid the "exclusiveness"). IMO, there are different ways to
> proceed on a conflict: A possible clk_set_rate() option would be to
> ignore a potential re-change of Video PLL by the second calc_new_rates()
> and just set a somewhat close to the req rate for CRTC divider. A
> possible clk_set_rate_exclusive() option is the one implemented here:
> error out if we cannot guarantee the existing required rates for the
> rest of the subtree.

The problem here is that you effectively want to coordinate clocks to
change their rate. Most of the logic of whether or not they care about
it, and how they care about it cannot be embedded in the clock
framework.

If we want to address this properly, I think we would need to switch the
entire clock framework to some kind of state like KMS does.

Something like:

  - All the affected clocks by a configuration (rate, parent, phase,
    accuracy, etc.) change are supposed to be within the state.

  - Whenever someone does a clk_set_rate call, we build up a state with
    the clock it was called on and all its child clocks.

  - We introduce a new hook in clk_ops that will take that state and the
    clock tells whether it's ok, or whether it needs to modify some
    parameters. We call every clock, starting from the top most clock,
    asking whether it's ok or if they need to change anything. If they
    need to change anything, we start again with the new set of
    parameters.

  - Clocks are free to pull into the state more clocks (ie, their
    parent), which in turn will pull their child.

  - Once every driver agrees, we "commit" that state.

That way, we can keep the driver requirements in the driver, and every
clock affected by a rate change can adapt.

That's a major undertaking, and we would need a bunch of helpers to
maintain compatibility with the current API we have. Plus tons of kunit
tests.

Again, if we have the option to just run the PLL at some multiple of
both, I really think for everyone's sanity that we should do that.

Maxime

--keylsesp7i7kvq27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZRv8IgAKCRDj7w1vZxhR
xVVQAQDF35HfjmL/HOOhvk0TTYhKIUjV8PqkzI77bFiZmWhWEAEAz7bZ9L3uKqzs
MUwMsOx2POBhs5AVo9xrZb9h8pJMQAM=
=PWXd
-----END PGP SIGNATURE-----

--keylsesp7i7kvq27--
