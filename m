Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447837A50E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjIRRYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIRRYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:24:53 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C47DB;
        Mon, 18 Sep 2023 10:24:47 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RqBVy2295z9sVw;
        Mon, 18 Sep 2023 19:24:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1695057882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+4yHZzrHJjqPq7LBrt01/QAbJUKdFCg/AHjFPUYawGM=;
        b=FNUSQaK7LApdoP5g+mITwld4G9hToDRz95VaB47X6UkIF4AXHWaH097ukp/autFcL6DmU8
        uyXDLwDHuCAOVXTnm28zLYj1tQWwlGkMrJyuOWXbJlPUWyB4UsmSSE431UJQduy/LeH6o/
        +hhTnswkKDH6nnkzhPca9FglyNr9lFm88xC8we0pR+6/JWQtKd4KaGpt0nHCmdc/lz4tay
        Jsa6Y2EqX96ESgoyGzzqPulK76XFtliJEhgJYNZtTxordHMW0KRWa6ESnLu+lwLBB71N1L
        g58hb9jE3HEMFvs6Zn+onrZ8EKm/1QCDo6rC1C70ylqDxLH9rOGGkMWGEvzYXg==
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Benjamin Bara <bbara93@gmail.com>
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
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 00/13] imx8mp: first clock propagation attempt (for LVDS)
In-reply-to: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
Date:   Mon, 18 Sep 2023 19:24:08 +0200
Message-ID: <87fs3bbdjb.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin!

On 2023-09-18 at 00:39:56 +0200, Benjamin Bara <bbara93@gmail.com> wrote:
> Hi!
>
> Target of this series is to dynamically set the rate of video_pll1 to
> the required LVDS clock rate(s), which are configured by the panel, and
> the lvds-bridge respectively.
>
> Some background:
> The LVDS panel requires two clocks: the crtc clock and the lvds clock.
> The lvds rate is always 7x the crtc rate. On the imx8mp, these are
> assigned to media_disp2_pix and media_ldb, which are both
> clk-composite-8m. The rates are set by drm_client_modeset_commit() (and
> later by fsl_ldb_atomic_enable()), and the fsl-ldb driver, first crtc,
> then lvds. The parent is typically assigned to video_pll1, which is a
> clk-pll14xx (pll1443x).
>
> The main problem:
> As the clk-composite-8m currently doesn't support CLK_SET_RATE_PARENT,
> the crtc rate is not propagated to video_pll1, and therefore must be
> assigned in the device-tree manually.
>
> The idea:
> Enable CLK_SET_RATE_PARENT, at least for media_disp2_pix and media_ldb.
> When this is done, ensure that the pll1443x can be re-configured,
> meaning it ensures that an already configured rate (crtc rate) is still
> supported when a second child requires a different rate (lvds rate). As
> the children have divider, the current approach is straight forward by
> calculating the LCM of the required rates. During the rate change of the
> PLL, it must ensure that all children still have the configured rate at
> the end (and maybe also bypass the clock while doing so?). This is done
> by implementing a notifier function for the clk-composite-8m. The tricky
> part is now to find out if the rate change was intentional or not. This
> is done by adding the "change trigger" to the notify data. In our case,
> we now can infer if we aren't the change trigger, we need to keep the
> existing rate after the PLL's rate change. We keep the existing rate by
> modifying the new_rate of the clock's core, as we are quite late in an
> already ongoing clock change process.
>
> Future work:
> The re-configuration of the PLL can definitely be improved for other use
> cases where the children have more fancy inter-dependencies. That's one
> of the main reasons I currently only touched the mentioned clocks.
> Additionally, it might make sense to automatically re-parent if a
> different possible parent suits better.
> For the core part, I thought about extending my "unintentional change
> check" so that the core ensures that the children keep the configured
> rate, which might not be easy as the parent could be allowed to "round",
> but it's not clear (at least to me yet) how much rounding is allowed. I
> found a similar discussion posted here[1], therefore added Frank and
> Maxime.

Thank you very much for including me in the discussion. If I understood
Maxime correctly, your proposal is close to what he was suggesting in
the discussion you referenced. Unfortunately, it doesn't cover the
rounding aspect (which you also mentioned in your cover letter and the
description for clk_detect_unintended_rate_changes in patch 7. I've been
pondering the last three weeks how to find a good solution to this
problem, but so far haven't found any.

Hopefully, your suggestion spurs some new thoughts.

Thanks,
  Frank

>
> Thanks & regards,
> Benjamin
>
> [1] https://lore.kernel.org/lkml/20230825-pll-mipi_keep_rate-v1-0-35bc43570730@oltmanns.dev/
>
> ---
> Benjamin Bara (13):
>       arm64: dts: imx8mp: lvds_bridge: use root instead of composite
>       arm64: dts: imx8mp: re-parent IMX8MP_CLK_MEDIA_MIPI_PHY1_REF
>       clk: implement clk_hw_set_rate()
>       clk: print debug message if parent change is ignored
>       clk: keep track of the trigger of an ongoing clk_set_rate
>       clk: keep track if a clock is explicitly configured
>       clk: detect unintended rate changes
>       clk: divider: stop early if an optimal divider is found
>       clk: imx: pll14xx: consider active rate for re-config
>       clk: imx: composite-8m: convert compute_dividers to void
>       clk: imx: composite-8m: implement CLK_SET_RATE_PARENT
>       clk: imx: imx8mp: allow LVDS clocks to set parent rate
>       arm64: dts: imx8mp: remove assigned-clock-rate of IMX8MP_VIDEO_PLL1
>
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi |  14 +--
>  drivers/clk/clk-divider.c                 |   9 ++
>  drivers/clk/clk.c                         | 146 +++++++++++++++++++++++++++++-
>  drivers/clk/imx/clk-composite-8m.c        |  89 +++++++++++++++---
>  drivers/clk/imx/clk-imx8mp.c              |   4 +-
>  drivers/clk/imx/clk-pll14xx.c             |  20 ++++
>  drivers/clk/imx/clk.h                     |   4 +
>  include/linux/clk-provider.h              |   2 +
>  include/linux/clk.h                       |   2 +
>  9 files changed, 261 insertions(+), 29 deletions(-)
> ---
> base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
> change-id: 20230913-imx8mp-dtsi-7c6e25907e0e
>
> Best regards,
