Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E807C4E52
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbjJKJRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjJKJR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:17:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2F594;
        Wed, 11 Oct 2023 02:17:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C36C433C8;
        Wed, 11 Oct 2023 09:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697015845;
        bh=7XlyisTL0PNew7b7bn2AFOQZ7plIxn38T0gcXf5PMhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m9nt3iImKjP6dDpdQPedvZhm8i9IowNTzjGOJZRIaQoYymyI2J14eR9POXbj/DGBP
         WYLKfLBRQLU/OcYBzy1LgG7Nf9jAfz6uS1Hbn1rcmnAbCqhamKUTBQO3SPzbpZAEmI
         014MvHQobgz3Y1BcDCoCeSBhTMP6EmW/lQxpgoZVaH+mok6PI8k1351JqDGf2z/RCS
         rdVtdSL0TRW8QkEoihuNeUP40kAnH/e7ylXFaLgo292eQtqPNPZCEW4Ts/a/oM5V4g
         beoiN6U2sWZLhdmHOqZzjZ+Ow8i62ZUO+3hXqOEMyEXj5GNOn2BqSerItLldQzeEUW
         DymPA0D9X5ofQ==
Date:   Wed, 11 Oct 2023 11:17:22 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Benedikt Spranger <b.spranger@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH 1/1] clk: socfpga: gate: Fix of by factor 2 for serial
 console
Message-ID: <xcq3wiayrfa67pn4thepgewrcif4fdhplykvb4nkwgmxd3i7yo@vcimkuy32qd4>
References: <20231005095927.12398-1-b.spranger@linutronix.de>
 <20231005095927.12398-2-b.spranger@linutronix.de>
 <qpskbgigcaoyjuhzeguz366cjukv3ij7utlbkra5edhwn6uzh4@bdedm6vs62y5>
 <20231005203202.08b5d1cf@mitra>
 <ujs6kaisllqu3qzm76qkwpmdy2vnulp6z742ooclbsdz36zl5f@m7ujgar4pwqs>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y74tgyyzda7ng5wq"
Content-Disposition: inline
In-Reply-To: <ujs6kaisllqu3qzm76qkwpmdy2vnulp6z742ooclbsdz36zl5f@m7ujgar4pwqs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y74tgyyzda7ng5wq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 05:01:34PM +0200, Maxime Ripard wrote:
> On Thu, Oct 05, 2023 at 08:32:23PM +0200, Benedikt Spranger wrote:
> > On Thu, 5 Oct 2023 13:34:01 +0200
> > Maxime Ripard <mripard@kernel.org> wrote:
> >=20
> > > Hi,
> > >=20
> > > On Thu, Oct 05, 2023 at 11:59:27AM +0200, Benedikt Spranger wrote:
> > > > Commit 9607beb917df ("clk: socfpga: gate: Add a determine_rate
> > > > hook") introduce a specific determine_rate hook. As a result the
> > > > calculated clock for the serial IP is off by factor 2 after that
> > > > i.e. if the system configures a baudrate of 115200 it is set
> > > > physicaly to 57600. =20
> > >=20
> > > Where is that factor 2 coming from?
> > In drivers/tty/serial/8250/8250_dw.c p->uartclk is set twice as high,
> > as it should be:=20
> >=20
> > dw8250_set_termios() is called and rate is evaluated to 20000000 in the
> > bad and 10000000 in the good case. As a result p->uartclk is set to
> > 20000000 in the bad case.
>=20
> Sure, sorry I worded that poorly. What I meant was what clock tree
> decision is taken now that wasn't taken before that leads to that factor
> 2 difference.
>=20
> > > > Change the determine_rate hook to the reparent variant
> > > > __clk_mux_determine_rate() to fix the issue. =20
> > >=20
> > > It's also not clear to me why that would fix anything. This patch
> > > should only make the old behaviour explicit, could you expand a bit
> > > on what happens?
> > Booting the kernel with console=3DttyS0,115200 result in a corrupted
> > character output. Setting the serial terminal application to 57600
> > make the serial console working.
> >=20
> > I dug deeper and added some debug output (see patch below):
>=20
> Thanks for the traces, that's helpful. It looks like the culprit is:
>=20
> Good:
>=20
>             init-1       [001] .....     0.125643: clk_rate_request_start=
: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
>             init-1       [001] .....     0.125651: clk_rate_request_done:=
 l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
>             init-1       [001] .....     0.125657: dw8250_set_termios: dw=
8250_set_termios: rate =3D 200000000 newrate =3D 1843200
>=20
> vs Bad:
>=20
>             init-1       [001] .....     0.116063: clk_rate_request_start=
: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
>             init-1       [001] .....     0.116089: clk_rate_request_done:=
 l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
>             init-1       [001] .....     0.116096: dw8250_set_termios: dw=
8250_set_termios: rate =3D 4294967274 newrate =3D 1843200
>=20
> The rate returned is super suspicious, as it's an -EINVAL casted into an
> unsigned long. So I think something on that clock chain is returning an
> error for some reason, which is then treated as a rate by the rest and
> everybody's just confused.

Wait, no, I got confused.

The good traces have:

            init-1       [001] .....     0.116063: clk_rate_request_start: =
l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.116089: clk_rate_request_done: l=
4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.116096: dw8250_set_termios: dw82=
50_set_termios: rate =3D 4294967274 newrate =3D 1843200
            init-1       [001] .....     0.116098: dw8250_set_termios: dw82=
50_set_termios: before: uartclk =3D 100000000
            init-1       [001] .....     0.116100: dw8250_set_termios: dw82=
50_set_termios: after: uartclk =3D 100000000

So the weird cast is actually in the "working" case.

The bad traces have:

            init-1       [001] .....     0.125643: clk_rate_request_start: =
l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.125651: clk_rate_request_done: l=
4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.125657: dw8250_set_termios: dw82=
50_set_termios: rate =3D 200000000 newrate =3D 1843200
            init-1       [001] .....     0.125660: dw8250_set_termios: dw82=
50_set_termios: before: uartclk =3D 100000000
            init-1       [001] .....     0.125662: clk_rate_request_start: =
l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.125664: clk_rate_request_done: l=
4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.125666: clk_rate_request_start: =
l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.125668: clk_rate_request_done: l=
4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.125673: clk_set_rate: l4_sp_clk =
200000000
            init-1       [001] .....     0.125675: clk_set_rate_complete: l=
4_sp_clk 200000000
            init-1       [001] .....     0.125678: socfpga_clk_recalc_rate:=
 socfpga_clk_recalc_rate: div_reg: div =3D 2
            init-1       [001] .....     0.125681: socfpga_clk_recalc_rate:=
 socfpga_clk_recalc_rate: rate =3D 100000000
            init-1       [001] .....     0.125683: dw8250_set_termios: dw82=
50_set_termios: after: uartclk =3D 200000000

First, it looks like dw8250_set_termios uses a signed long and you're
using %ld in your trace_printk calls so it's not entirely clear to me
why 4294967274 doesn't show up as -22.

That being said, it looks like the code handles it properly and just
skips the clk_set_rate call because (rate > 0) isn't true.

The rate isn't changed, and the dividers don't need to be adjusted
either: the clock rate change fails, but it keeps on working (probably
because it was already setup as a console and the baudrate didn't
change).

In the bad case, the rate returned is actually the one we would expect
when if we don't reparent and we don't have CLK_SET_RATE_PARENT: the one
of its currently muxed parent, per_base_clk in this case, so 200MHz.

Since the rate returned by clk_round_rate is now greater than 0,
clk_set_rate is called, we go into clk_change_rate() with a rate of
200MHz as expected, and since the gateclk_ops don't have a set_rate
hook, we end up with "clk_set_rate_complete: l4_sp_clk 200000000".

We're here so far:
https://elixir.bootlin.com/linux/latest/source/drivers/clk/clk.c#L2350

The next line is a call to clk_recalc, which is going to call
socfpga_clk_recalc_rate, and since that clocks appears to have some
dividers, it returns the parent rate divided by the divider, 100MHz in
this case.

There's a couple of (broken) things here:

  - The clock rate change was completely ignored before because the
    driver was returning an error. I'm pretty sure it was broken too if
    you were trying to change the baudrate, but since that's not really
    common nobody noticed. It's also pretty trivial, so I'm not sure why
    there was an error in the first place. I think it's because we hit

    https://elixir.bootlin.com/linux/v6.5.7/source/drivers/clk/clk.c#L684

    But again, not entirely sure why using either parents doesn't really
    work.

  - It looks like the patch you mentioned is now exerting the rate
    change logic that wasn't really tested before due to the above, and
    it doesn't go well. The main culprit is that the socfpga gate driver
    kind of hides its divider, but not entirely.

    The rate returned by clk_round_rate doesn't take it into account,
    but the one stored in the internal structure does, which probably
    leads to other interesting issues.

Could you test that patch?

----8<----

diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 8dd601bd8538..486a4d84e418 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -87,10 +87,8 @@ static int socfpga_clk_set_parent(struct clk_hw *hwclk, =
u8 parent)
 	return 0;
 }

-static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
-	unsigned long parent_rate)
+static u32 socfpga_clk_get_div(struct socfpga_gate_clk *socfpgaclk)
 {
-	struct socfpga_gate_clk *socfpgaclk =3D to_socfpga_gate_clk(hwclk);
 	u32 div =3D 1, val;

 	if (socfpgaclk->fixed_div)
@@ -105,12 +103,33 @@ static unsigned long socfpga_clk_recalc_rate(struct c=
lk_hw *hwclk,
 			div =3D (1 << val);
 	}

+	return div;
+}
+
+static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
+					     unsigned long parent_rate)
+{
+	struct socfpga_gate_clk *socfpgaclk =3D to_socfpga_gate_clk(hwclk);
+	u32 div =3D socfpga_clk_get_div(socfpgaclk);
+
 	return parent_rate / div;
 }

+
+static int socfpga_clk_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	struct socfpga_gate_clk *socfpgaclk =3D to_socfpga_gate_clk(hwclk);
+	u32 div =3D socfpga_clk_get_div(socfpgaclk);
+
+	req->rate =3D req->best_parent_rate / div;
+
+	return 0;
+}
+
 static struct clk_ops gateclk_ops =3D {
 	.recalc_rate =3D socfpga_clk_recalc_rate,
-	.determine_rate =3D clk_hw_determine_rate_no_reparent,
+	.determine_rate =3D socfpga_clk_determine_rate,
 	.get_parent =3D socfpga_clk_get_parent,
 	.set_parent =3D socfpga_clk_set_parent,
 };
----8<----

Maxime

--y74tgyyzda7ng5wq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZSZoIgAKCRDj7w1vZxhR
xQcMAQC/fa/shDGwz/RIs+b8E/q9OB9wSyFC7+gwfTyqh2LWAAEAgTr1l/CJB1Z0
LSMSTmnWOjVLeRk5XjNNCYAKwqfgEA0=
=fTU4
-----END PGP SIGNATURE-----

--y74tgyyzda7ng5wq--
