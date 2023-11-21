Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A67F2A66
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjKUKaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjKUKaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:30:15 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14263C1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:30:10 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6bd9:a79:1d00:5285])
        by albert.telenet-ops.be with bizsmtp
        id CyW22B00Y0Wid3g06yW2iz; Tue, 21 Nov 2023 11:30:07 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1r5O14-009vCd-NI;
        Tue, 21 Nov 2023 11:30:02 +0100
Date:   Tue, 21 Nov 2023 11:30:02 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Claudiu <claudiu.beznea@tuxon.dev>
cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 6/9] irqchip/renesas-rzg2l: Add macro to retrieve
 TITSR register offset based on register's index
In-Reply-To: <20231120111820.87398-7-claudiu.beznea.uj@bp.renesas.com>
Message-ID: <f01a5cc1-44c0-891a-c8f7-3023f3ff6b6a@linux-m68k.org>
References: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com> <20231120111820.87398-7-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 	Hi Claudiu,

Thanks for your patch!

On Mon, 20 Nov 2023, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> There are 2 TITSR registers available on IA55 interrupt controller. A

... the IA55 interrupt controller.

> single macro could be used to access both of them. Add a macro that
> retrieves TITSR register offset based on it's index. This macro is

the TITSR register offset ... its index

> useful in commit that adds suspend/resume support to access both TITSR

> registers in a for loop.

This macro will be useful to access both TITSR registers in a for loop
when adding suspend/resume support later/

>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> --- a/drivers/irqchip/irq-renesas-rzg2l.c
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -28,8 +28,7 @@
> #define ISCR				0x10
> #define IITSR				0x14
> #define TSCR				0x20
> -#define TITSR0				0x24
> -#define TITSR1				0x28
> +#define TITSR(n)			(0x24 + (n) * 4)
> #define TITSR0_MAX_INT			16
> #define TITSEL_WIDTH			0x2
> #define TSSR(n)				(0x30 + ((n) * 4))
> @@ -200,8 +199,7 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
> 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> 	unsigned int hwirq = irqd_to_hwirq(d);
> 	u32 titseln = hwirq - IRQC_TINT_START;
> -	u32 offset;
> -	u8 sense;
> +	u8 index, sense;
> 	u32 reg;
>
> 	switch (type & IRQ_TYPE_SENSE_MASK) {
> @@ -217,17 +215,17 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
> 		return -EINVAL;
> 	}
>
> -	offset = TITSR0;
> +	index = 0;
> 	if (titseln >= TITSR0_MAX_INT) {
> 		titseln -= TITSR0_MAX_INT;
> -		offset = TITSR1;
> +		index = 1;
> 	}

You can remove this if you would use ...
>
> 	raw_spin_lock(&priv->lock);
> -	reg = readl_relaxed(priv->base + offset);
> +	reg = readl_relaxed(priv->base + TITSR(index));

... TITSR(titseln / TITSR0_MAX_INT) here.

> 	reg &= ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
> 	reg |= sense << (titseln * TITSEL_WIDTH);
> -	writel_relaxed(reg, priv->base + offset);
> +	writel_relaxed(reg, priv->base + TITSR(index));
> 	raw_spin_unlock(&priv->lock);
>
> 	return 0;
> -- 
> 2.39.2
>
>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
