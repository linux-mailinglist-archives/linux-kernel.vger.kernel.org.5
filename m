Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCA97D9F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346126AbjJ0SCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjJ0SCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:02:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F32F3;
        Fri, 27 Oct 2023 11:02:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698429751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=275/pEO9JSbT2rFQuOaMcx49ECFedNGNEcjTI6T5tHQ=;
        b=Cnym3aE/MF04lGmNEJ/rj7eiBbiNdk+shih3rRLBMz4VyD7Zf6m1qZDw33ZcSbXjM994/L
        n6Rk+EubSPDLkicm+IKTuemcD7T8eF0mb/zrxvI+QurSlI361oSl3j+xaEd6NM99jeC5B8
        vMv4AuFABxjznTyXaVjxyUEe1ArpgGvLfaSMkxV6XDOPgKQq5x8woyBt3MSK8YJuynjHH9
        8K2qLSMgNUeq97IGvbfvvb9fxKIOjlvJYPkka+EN7oiFdT16YioWtxK3lhrz55Id3XsN8+
        zGmxT6zssPwUwkJaR3y/SKHilgsR0nI87zc6lfm32GtrGP9ssWa+b26zRKP71A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698429751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=275/pEO9JSbT2rFQuOaMcx49ECFedNGNEcjTI6T5tHQ=;
        b=/Bh6SXcTZYFvCff2EuZ0kRFjPMNMy5Z1grSfncXKCX8u1pJkSJwkiFCPhQ/sQo7G+WpZwX
        zz0lNb02UgKn53AQ==
To:     Claudiu <claudiu.beznea@tuxon.dev>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 4/7] irqchip/renesas-rzg2l: implement restriction when
 writing ISCR register
In-Reply-To: <20231023102223.1309614-5-claudiu.beznea.uj@bp.renesas.com>
References: <20231023102223.1309614-1-claudiu.beznea.uj@bp.renesas.com>
 <20231023102223.1309614-5-claudiu.beznea.uj@bp.renesas.com>
Date:   Fri, 27 Oct 2023 20:02:30 +0200
Message-ID: <878r7o2bbd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23 2023 at 13:22, Claudiu wrote:
> In hardware manual of RZ/G2L (r01uh0914ej0130-rzg2l-rzg2lc.pdf)

This filename is completely useless.

> is available the following statement with regards to clearing
> interrupts

The RZ/G2L manual describes the operation to clear interrupts

> though ISCR register:

through the ISCR ...

>
> [Write operation]
> When "Falling-edge detection", "Rising-edge detection" or
> "Falling/Rising-edge detection" is set in ISCR.:
> - In case ISTAT is 1
> 	0: IRQn interrupt detection status is cleared.
> 	1: Invalid to write.
> - In case ISTAT is 0
> 	Invalid to write.
> When =E2=80=9CLow-level detection=E2=80=9D is set in IITSR.:
> 	Invalid to write.
>
> Thus, take into account interrupt type when clearing interrupts though

take the interrupt type into account... through the ISCR ...

> ISCR register.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/irqchip/irq-renesas-rzg2l.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-re=
nesas-rzg2l.c
> index 9ce0d6d67486..1ed9cb7178fa 100644
> --- a/drivers/irqchip/irq-renesas-rzg2l.c
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -73,11 +73,17 @@ static void rzg2l_irq_eoi(struct irq_data *d)
>  	unsigned int hw_irq =3D irqd_to_hwirq(d) - IRQC_IRQ_START;
>  	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
>  	u32 bit =3D BIT(hw_irq);
> -	u32 reg;
> +	u32 iitsr, iscr;
>=20=20
> -	reg =3D readl_relaxed(priv->base + ISCR);
> -	if (reg & bit)
> -		writel_relaxed(reg & ~bit, priv->base + ISCR);
> +	iscr =3D readl_relaxed(priv->base + ISCR);
> +	iitsr =3D readl_relaxed(priv->base + IITSR);
> +
> +	/*
> +	 * ISCR could be cleared only if type is falling-edge, rising-edge or

ISCR can only be cleared if the type is ...

> +	 * falling/rising-edge.
> +	 */
> +	if ((iscr & bit) && (iitsr & IITSR_IITSEL_MASK(hw_irq)))
> +		writel_relaxed(iscr & ~bit, priv->base + ISCR);
>  }
>=20=20
>  static void rzg2l_tint_eoi(struct irq_data *d)
