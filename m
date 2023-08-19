Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCCB781F70
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjHTTUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjHTTUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:20:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 173E9443F94;
        Sat, 19 Aug 2023 12:31:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C38071FB;
        Sat, 19 Aug 2023 12:32:33 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 048253F762;
        Sat, 19 Aug 2023 12:31:51 -0700 (PDT)
Date:   Sat, 19 Aug 2023 20:30:43 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Mikhail Kalashnikov <iuncuim@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: sunxi: h616: add extra gpio banks
Message-ID: <20230819203043.4e29c343@slackpad.lan>
In-Reply-To: <20230819092609.8136-1-iuncuim@gmail.com>
References: <20230819092609.8136-1-iuncuim@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2023 12:26:09 +0300
Mikhail Kalashnikov <iuncuim@gmail.com> wrote:

Hi Mkihail,

thanks very much for spending the time on this!

> From: iuncuim <iuncuim@gmail.com>
> 
> Some SoCs from the H616 family (for example, T507) have the same die, but
> more output pins that are used for additional peripherals. The T507 SoC
> don't have a built-in multiphy such as the AC200 or AC300. With the T507
> these pins can be freely used for any other application. So, patch add
> these missing muxes on banks A, C and D.

So I compared every pin against the manual, that looked alright, except
for two small naming issues, and the final line missing an EOL, see
below ...

> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c | 382 +++++++++++++++++++-
>  1 file changed, 367 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> index d6ca720ee..a88fed0aa 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> @@ -16,33 +16,81 @@
>  #include "pinctrl-sunxi.h"
>  
>  static const struct sunxi_desc_pin h616_pins[] = {
> -	/* Internal connection to the AC200 part */
> +	/* Internally connected to the AC200 part in the H616 SoC */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 0),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ERXD1 */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXD1 */
> +		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PA_EINT0 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 1),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ERXD0 */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXD0 */
> +		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SDA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PA_EINT1 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 2),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ECRS_DV */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ECRS_DV */
> +		  SUNXI_FUNCTION(0x4, "i2c1"),		/* SCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PA_EINT2 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 3),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ERXERR */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXERR */
> +		  SUNXI_FUNCTION(0x4, "i2c1"),		/* SDA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PA_EINT3 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 4),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXD1 */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXD1 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PA_EINT4 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 5),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXD0 */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXD0 */
> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* DOUT0 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/* PA_EINT5 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 6),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXCK */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXCK */
> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* MCLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PA_EINT6 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 7),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXEN */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXEN */
> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* BCLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/* PA_EINT7 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 8),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* EMDC */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* EMDC */
> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* LRCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PA_EINT8 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 9),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* EMDIO */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* EMDIO */
> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* DIN0 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),	/* PA_EINT9 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 10),
> -		  SUNXI_FUNCTION(0x2, "i2c3")),		/* SCK */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c3"),		/* SCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)),	/* PA_EINT10 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 11),
> -		  SUNXI_FUNCTION(0x2, "i2c3")),		/* SDA */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c3"),		/* SDA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 11)),	/* PA_EINT11 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 12),
> -		  SUNXI_FUNCTION(0x2, "pwm5")),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "pwm5"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 12)),	/* PA_EINT12 */
>  	/* Hole */
cs>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
> @@ -149,6 +197,310 @@ static const struct sunxi_desc_pin h616_pins[] = {
>  		  SUNXI_FUNCTION(0x4, "spi0"),		/* HOLD */
>  		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 16)),	/* PC_EINT16 */
>  	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D0 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP0 */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* CLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),	/* PD_EINT0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D1 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN0 */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* ERR */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/* PD_EINT1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D2 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP1 */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* SYNC */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),	/* PD_EINT2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D3 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN1 */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* DVLD */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),	/* PD_EINT3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D4 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP2 */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D0 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),	/* PD_EINT4 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D5 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN2 */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D1 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),	/* PD_EINT5 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D6 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VPC */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D2 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 6)),	/* PD_EINT6 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D7 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VNC */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D3 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 7)),	/* PD_EINT7 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D8 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP3 */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D4 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 8)),	/* PD_EINT8 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 9),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D9 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN3 */
> +		  SUNXI_FUNCTION(0x4, "ts0"), 		/* D5 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 9)),	/* PD_EINT9 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 10),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D10 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP0 */
> +		  SUNXI_FUNCTION(0x4, "ts0"), 		/* D6 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 10)),	/* PD_EINT10 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 11),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D11 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN0 */
> +		  SUNXI_FUNCTION(0x4, "ts0"), 		/* D7 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* PD_EINT11 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 12),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D12 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP1 */
> +		  SUNXI_FUNCTION(0x4, "sim"), 		/* VPPEN */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 12)),	/* PD_EINT12 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 13),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D13 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN1 */
> +		  SUNXI_FUNCTION(0x4, "sim"),		/* VPPPP */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 13)),	/* PD_EINT13 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 14),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D14 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP2 */
> +		  SUNXI_FUNCTION(0x4, "sim"),		/* PWREN */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 14)),	/* PD_EINT14 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 15),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D15 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN2 */
> +		  SUNXI_FUNCTION(0x4, "sim"),		/* CLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 15)),	/* PD_EINT15 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 16),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D16 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VPC */
> +		  SUNXI_FUNCTION(0x4, "sim"),		/* DATA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 16)),	/* PD_EINT16 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 17),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D17 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VNC */
> +		  SUNXI_FUNCTION(0x4, "sim"),		/* RST */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 17)),	/* PD_EINT17 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 18),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D18 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP3 */
> +		  SUNXI_FUNCTION(0x4, "sim"),		/* DET */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 18)),	/* PD_EINT18 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 19),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D19 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN3 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 19)),	/* PD_EINT19 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 20),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D20 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 20)),	/* PD_EINT20 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 21),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D21 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 21)),	/* PD_EINT21 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 22),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D22 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 22)),	/* PD_EINT22 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 23),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D23 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 23)),	/* PD_EINT23 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 24),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* CLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 24)),	/* PD_EINT24 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 25),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* DE */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 25)),	/* PD_EINT25 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 26),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* HSYNC */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 26)),	/* PD_EINT26 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 27),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* VSYNC */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 27)),	/* PD_EINT27 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 28),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "pwm0"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 28)),	/* PD_EINT28 */
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  PCLK  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 0)),	/* PE_EINT0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi_mclk1"),	/*  MCLK  */

Shouldn't the function just be "csi"?

> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 1)),	/* PE_EINT1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  HSYNC  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 2)),	/* PE_EINT2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  VSYNC  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 3)),	/* PE_EINT3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D0  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 4)),	/* PE_EINT4 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D1  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 5)),	/* PE_EINT5 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D2  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 6)),	/* PE_EINT6 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D3  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 7)),	/* PE_EINT7 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D4  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 8)),	/* PE_EINT8 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 9),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D5  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 9)),	/* PE_EINT9 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 10),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D6  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 10)),	/* PE_EINT10 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 11),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D7  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 11)),	/* PE_EINT11 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 12),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D8  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 12)),	/* PE_EINT12 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 13),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D9  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 13)),	/* PE_EINT13 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 14),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D10  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 14)),	/* PE_EINT14 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 15),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D11  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 15)),	/* PE_EINT15 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 16),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D12  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 16)),	/* PE_EINT16 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 17),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D13  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 17)),	/* PE_EINT17 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 18),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D14  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 18)),	/* PE_EINT18 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 19),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D15  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 19)),	/* PE_EINT19 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 20),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  SCK  */
> +		  SUNXI_FUNCTION(0x5, "i2c2"),		/*  SCK  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 20)),	/* PE_EINT20 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 21),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  SDA */
> +		  SUNXI_FUNCTION(0x5, "i2c2"),		/*  SDA  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 21)),	/* PE_EINT21 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 22),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ncsi_fsin0"),	/*  FSIN0 */

Similar here, just "csi"?

> +		  SUNXI_FUNCTION(0x4, "tcon0"),		/*  TRIG0  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 22)),	/* PE_EINT22 */
> +	/* Hole */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
> @@ -545,4 +897,4 @@ static struct platform_driver h616_pinctrl_driver = {
>  		.of_match_table	= h616_pinctrl_match,
>  	},
>  };
> -builtin_platform_driver(h616_pinctrl_driver);
> +builtin_platform_driver(h616_pinctrl_driver);
> \ No newline at end of file

This line shouldn't change, somehow your editor ate the last EOL
character?

Otherwise it matches, good job!

Cheers,
Andre


