Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFF87B7980
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbjJDIEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241639AbjJDIEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:04:49 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C070AC;
        Wed,  4 Oct 2023 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1696406684; x=1727942684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uNd+HACguCoZjwveAU7kMZ/dp20g63cdWpbDWpo8YEo=;
  b=aL5werJQuCu2LVaK3cwCvJ/FTBAf8lfUgB2cvjTEmOAkytr53UdFgYUT
   1g3YQu0WXbWR/3hQGOzeGFNRV4xHRXeJpyTZmn/qm25/uCCZbbv62UFgx
   m3oMvqc+R1299hL65AKkqJx6wcBjSK2yGdJ445EsN+1K+k9wwx6tviaoT
   jATxgIqgC+2SI1SCARE0AzW8Rq/T1xjpLo481hPmhzZPh3BUaqUXGCegq
   6RHmUAM/uRUs7fRZVSy5bQrhT5lTkAqxX9/R/+iYXEOcGvF+0MUT9SoaX
   fSuPMrhmbMOckDn++p6uHZho29W8fJDjkG2RexkNq8YZL4tqHkj5bTxqO
   Q==;
X-IronPort-AV: E=Sophos;i="6.03,199,1694728800"; 
   d="scan'208";a="33270753"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Oct 2023 10:04:41 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 57403280075;
        Wed,  4 Oct 2023 10:04:41 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Benjamin Bara <bbara93@gmail.com>, Adam Ford <aford173@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Frank Oltmanns <frank@oltmanns.dev>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 00/13] imx8mp: first clock propagation attempt (for LVDS)
Date:   Wed, 04 Oct 2023 10:04:41 +0200
Message-ID: <12810050.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAHCN7x+WesF5Dac=9THtHR7Y=LJwzAEsZ9aD1B7Lppc2vQSnJQ@mail.gmail.com>
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com> <CAHCN7x+WesF5Dac=9THtHR7Y=LJwzAEsZ9aD1B7Lppc2vQSnJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Am Dienstag, 3. Oktober 2023, 15:28:05 CEST schrieb Adam Ford:
> On Sun, Sep 17, 2023 at 5:40=E2=80=AFPM Benjamin Bara <bbara93@gmail.com>=
 wrote:
> > Hi!
> >=20
> > Target of this series is to dynamically set the rate of video_pll1 to
> > the required LVDS clock rate(s), which are configured by the panel, and
> > the lvds-bridge respectively.
> >=20
> > Some background:
> > The LVDS panel requires two clocks: the crtc clock and the lvds clock.
> > The lvds rate is always 7x the crtc rate. On the imx8mp, these are
> > assigned to media_disp2_pix and media_ldb, which are both
>=20
> Could the LDB driver be updated to take in the crtc clock as a
> parameter, then set the media_ldb to 7x crct clock.  I wonder if that
> might simplify the task a bit.

I'm not sure if you had something different in mind, but I guess this happe=
ns=20
already in fsl_ldb_atomic_enable(), although using the mode clock.
As this might not always be possible, commit bd43a9844bc6f ("drm: bridge: l=
db:=20
Warn if LDB clock does not match requested link frequency") was added to=20
indicate something might be wrong.
The main problem here is that both media_ldb and crct clock are not in a=20
parent<->child relationship, but are siblings, configurable individually.

Best regards,
Alexander

> > clk-composite-8m. The rates are set by drm_client_modeset_commit() (and
> > later by fsl_ldb_atomic_enable()), and the fsl-ldb driver, first crtc,
> > then lvds. The parent is typically assigned to video_pll1, which is a
> > clk-pll14xx (pll1443x).
> >=20
> > The main problem:
> > As the clk-composite-8m currently doesn't support CLK_SET_RATE_PARENT,
> > the crtc rate is not propagated to video_pll1, and therefore must be
> > assigned in the device-tree manually.
> >=20
> > The idea:
> > Enable CLK_SET_RATE_PARENT, at least for media_disp2_pix and media_ldb.
> > When this is done, ensure that the pll1443x can be re-configured,
> > meaning it ensures that an already configured rate (crtc rate) is still
> > supported when a second child requires a different rate (lvds rate). As
>=20
> I still have concerns that the CLK_SET_RATE_PARENT may break the
> media_disp1_pix if media_disp2_pix is changing it.
>=20
> I think we should consider adding some sort of configurable flag to
> the CCM that lets people choose  if CLK_SET_RATE_PARENT should be set
> or not in the device tree instead of hard-coding it either on or off.
> This would give people the flexibility of stating whether
> media_disp1_pix, media_disp2_pix, both or neither could set
> CLK_SET_RATE_PARENT.
>=20
> I believe the imx8mp-evk can support both LVDS-> HDMI and DSI->HDMI
> bridges, and I fear that if they are trying to both set different
> clock rates, this may break something and the clocks need to be
> selected in advance to give people a bunch of HDMI options as well as
> being able to divide down to support the LVDS.
>=20
> I think some of the displays could be tied to one of the Audio PLL's,
> so I might experiment with splitting the media_disp1_pix and
> media_disp2_pix from each other to see how well .
>=20
> > the children have divider, the current approach is straight forward by
> > calculating the LCM of the required rates. During the rate change of the
> > PLL, it must ensure that all children still have the configured rate at
> > the end (and maybe also bypass the clock while doing so?). This is done
> > by implementing a notifier function for the clk-composite-8m. The tricky
> > part is now to find out if the rate change was intentional or not. This
> > is done by adding the "change trigger" to the notify data. In our case,
> > we now can infer if we aren't the change trigger, we need to keep the
> > existing rate after the PLL's rate change. We keep the existing rate by
> > modifying the new_rate of the clock's core, as we are quite late in an
> > already ongoing clock change process.
> >=20
> > Future work:
> > The re-configuration of the PLL can definitely be improved for other use
> > cases where the children have more fancy inter-dependencies. That's one
> > of the main reasons I currently only touched the mentioned clocks.
> > Additionally, it might make sense to automatically re-parent if a
> > different possible parent suits better.
> > For the core part, I thought about extending my "unintentional change
> > check" so that the core ensures that the children keep the configured
> > rate, which might not be easy as the parent could be allowed to "round",
> > but it's not clear (at least to me yet) how much rounding is allowed. I
> > found a similar discussion posted here[1], therefore added Frank and
> > Maxime.
> >=20
> > Thanks & regards,
> > Benjamin
> >=20
> > [1]
> > https://lore.kernel.org/lkml/20230825-pll-mipi_keep_rate-v1-0-35bc43570=
73
> > 0@oltmanns.dev/
> >=20
> > ---
> >=20
> > Benjamin Bara (13):
> >       arm64: dts: imx8mp: lvds_bridge: use root instead of composite
> >       arm64: dts: imx8mp: re-parent IMX8MP_CLK_MEDIA_MIPI_PHY1_REF
> >       clk: implement clk_hw_set_rate()
> >       clk: print debug message if parent change is ignored
> >       clk: keep track of the trigger of an ongoing clk_set_rate
> >       clk: keep track if a clock is explicitly configured
> >       clk: detect unintended rate changes
> >       clk: divider: stop early if an optimal divider is found
> >       clk: imx: pll14xx: consider active rate for re-config
> >       clk: imx: composite-8m: convert compute_dividers to void
> >       clk: imx: composite-8m: implement CLK_SET_RATE_PARENT
> >       clk: imx: imx8mp: allow LVDS clocks to set parent rate
> >       arm64: dts: imx8mp: remove assigned-clock-rate of IMX8MP_VIDEO_PL=
L1
> > =20
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi |  14 +--
> >  drivers/clk/clk-divider.c                 |   9 ++
> >  drivers/clk/clk.c                         | 146
> >  +++++++++++++++++++++++++++++- drivers/clk/imx/clk-composite-8m.c     =
 =20
> >  |  89 +++++++++++++++--- drivers/clk/imx/clk-imx8mp.c              |  =
 4
> >  +-
> >  drivers/clk/imx/clk-pll14xx.c             |  20 ++++
> >  drivers/clk/imx/clk.h                     |   4 +
> >  include/linux/clk-provider.h              |   2 +
> >  include/linux/clk.h                       |   2 +
> >  9 files changed, 261 insertions(+), 29 deletions(-)
> >=20
> > ---
> > base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
> > change-id: 20230913-imx8mp-dtsi-7c6e25907e0e
> >=20
> > Best regards,
> > --
> > Benjamin Bara <benjamin.bara@skidata.com>


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


