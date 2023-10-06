Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812A57BC31E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjJFXug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjJFXue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:50:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45644C6;
        Fri,  6 Oct 2023 16:50:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C294AC433C7;
        Fri,  6 Oct 2023 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696636230;
        bh=Gr8NIy25jma5858InK0zSBJrzPSCMCjYQVnqkTHw2Ls=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cf8rmM8kOwHed/fJq5mUa78PdLQJMfB6sVSDtHUHa0g/+fzucMGBeTEyoUqKAWLwG
         t2XTq+qWqJeOhiVwjkMbN3V6j8/GJYM5ya2KgSCLzsSBBwymHzDMFskkP7fK3G2fl+
         n6VPW/w1qIyS+8MDs19LKYCAW/H2ZYJIiRaUo885k2wPQ4A7uIEoNha8E42qTVw4o9
         mnW9ahoyXKu25iMUKbI9I6uecCcDYXXmKWXbWsSKtzmIRRfY/AbnKeXHyfc1UrT+fW
         H4DtIa3nld7kAGuCH/73LI2cS98ufhEQpnQc5qE7EwiqUch+VKfD10uh+dqfCaIvEQ
         zpKaO+xHhsB6w==
Message-ID: <7d529b2b9a16f238f533f1c03b4261b2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230928224051.160851-1-tmaimon77@gmail.com>
References: <20230928224051.160851-1-tmaimon77@gmail.com>
Subject: Re: [PATCH v20] clk: npcm8xx: add clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        benjaminfair@google.com, joel@jms.id.au, mturquette@baylibre.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com
Date:   Fri, 06 Oct 2023 16:50:28 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tomer Maimon (2023-09-28 15:40:51)
> diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> new file mode 100644
> index 000000000000..e575a8676ca3
> --- /dev/null
> +++ b/drivers/clk/clk-npcm8xx.c
> @@ -0,0 +1,547 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
[...]
> +
> +/* configurable dividers: */
> +static const struct npcm8xx_clk_div_data npcm8xx_divs[] =3D {
> +       { NPCM8XX_CLKDIV1, 28, 3, NPCM8XX_CLK_S_ADC,
> +       { .name =3D NPCM8XX_CLK_S_PRE_ADC, .index =3D -1 },
> +       CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_=
ADC },

Please format this some other way. I assume one line means one clk, but
here it is actually three lines. Perhaps something like this?

> +       {
> +		NPCM8XX_CLKDIV1, 28, 3, NPCM8XX_CLK_S_ADC,
> +       	{ .name =3D NPCM8XX_CLK_S_PRE_ADC, .index =3D -1 },
> +       	CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK=
_ADC
> +	  },

Please stop using the .name member of struct clk_parent_data. That
member is only there to support drivers that are migrating from a
binding that didn't specify the parents of clks that are outside of the
clk controller with the clocks property in their DT node. I see that the
dts exists upstream, but luckily we don't have a driver merged, so we're
free to change the binding to specify clks external to the node. The
.fw_name member will match a 'clock-names' element for the registering
driver's node. The .index member will match the index in the 'clocks'
property. Neither of those properties exist in the nuvoton,npcm845-clk
DT binding, so neither of those members shall be present. This means
that either the binding needs to be updated, or the clk_parent_data
structure should be replaced with clk_hw pointers to describe parents.
I'm going to guess that there aren't any external clk parents, so to
keep things simple this driver should change to use direct clk_hw
pointers to describe topology.

> +       { NPCM8XX_CLKDIV1, 26, 2, NPCM8XX_CLK_S_AHB, { .hw =3D &hw_pre_cl=
k },
> +       CLK_DIVIDER_READ_ONLY, CLK_IS_CRITICAL, NPCM8XX_CLK_AHB },
> +       { NPCM8XX_CLKDIV1, 21, 5, NPCM8XX_CLK_S_PRE_ADC,
> +       { .hw =3D &npcm8xx_muxes[6].hw }, CLK_DIVIDER_READ_ONLY, 0, -1 },
> +       { NPCM8XX_CLKDIV1, 16, 5, NPCM8XX_CLK_S_UART,
> +       { .hw =3D &npcm8xx_muxes[3].hw }, 0, 0, NPCM8XX_CLK_UART },
> +       { NPCM8XX_CLKDIV1, 11, 5, NPCM8XX_CLK_S_MMC,
> +       { .hw =3D &npcm8xx_muxes[2].hw }, CLK_DIVIDER_READ_ONLY, 0,
> +       NPCM8XX_CLK_MMC },
> +       { NPCM8XX_CLKDIV1, 6, 5, NPCM8XX_CLK_S_SPI3,
> +       { .fw_name =3D NPCM8XX_CLK_S_AHB, .name =3D NPCM8XX_CLK_S_AHB }, =
0, 0,
> +       NPCM8XX_CLK_SPI3 },
> +       { NPCM8XX_CLKDIV1, 2, 4, NPCM8XX_CLK_S_PCI,
> +       { .hw =3D &npcm8xx_muxes[7].hw }, CLK_DIVIDER_READ_ONLY, 0,
> +       NPCM8XX_CLK_PCI },

BTW, I looked at the dts file upstream (nuvoton-common-npcm8xx.dtsi).
The reset and clock controller start at the same address, which can only
mean that they're actually the same device. The two nodes should be
combined into one node and one driver should match that compatible so
that one IO mapping is made for the entire clock and reset contoller
register space. If you want, that driver can make two auxiliary device
drivers for the reset and clk parts of the io space and then those two
drivers can reside in drivers/reset and drivers/clk. I don't know where
the driver goes that matches the compatible node though, probably in
drivers/soc. This allows us to properly model the logical components
that make up the device in hardware (clks and resets) while also
allowing any device specific things for that entire register space to
live in the soc driver. For example, if some power domain needs to be
enabled to access that register space it would be attached to the soc
driver.
