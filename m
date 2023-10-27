Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E824E7D9F23
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjJ0R53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0R52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:57:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F78512A;
        Fri, 27 Oct 2023 10:57:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698429443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=58t0D6ESCSzexSg4v1kt6tJ4hy3mICpcIPZMbCXXn84=;
        b=keo8ZRjniGvDQH8XixV0C/IW4SmfusttUIfuaDrFMsYMlp9/TLJbbkpIykf1qNT9r2p+X4
        WOl+pS+ezpf6OmYoxfOTRp+y2m4SKskZ8+gk25re2TmuG22G/++/MukocbZtnKqiIPbrH7
        wF4CHapZo5B+t0Tqsv0Z+vVQ5KUgR/+TgEkd38qB1EdVSwkm1sX/RC1DlcYHYX3q3LzBif
        E4u+fhV6uGbQ6Ci+O7aAFp+ANMIsdBObtBs3qCzfiyX2/ZiKEYQg+tmx78X3aerV7zkTm6
        +bXxdXIt+48AErihL4mNQOE9vr0yWhdCikozeuBbNnBxUJQ8FT2n+Q9gDFUx/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698429443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=58t0D6ESCSzexSg4v1kt6tJ4hy3mICpcIPZMbCXXn84=;
        b=J8HWFFYgzidROH/s2RBjpBwD4G2jhOYDfrOjJBKITQEJJs9sfRG+xQR+Gff1ptjKKQjZQF
        O8jeOEWApyIH5jCw==
To:     Claudiu <claudiu.beznea@tuxon.dev>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 5/7] irqchip/renesas-rzg2l: cache registers on
 suspend/resume
In-Reply-To: <20231023102223.1309614-6-claudiu.beznea.uj@bp.renesas.com>
References: <20231023102223.1309614-1-claudiu.beznea.uj@bp.renesas.com>
 <20231023102223.1309614-6-claudiu.beznea.uj@bp.renesas.com>
Date:   Fri, 27 Oct 2023 19:57:23 +0200
Message-ID: <87h6mc2bjw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23 2023 at 13:22, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Cache registers content when going to suspend and restore them in resume
> as these may be lost when switching to deep sleep states. With this
> driver data has been marked as static to be able to play with it
> in struct syscon_ops::{suspend, resume}.

I have no idea what you are trying to tell me here. Why do the
suspend/resume callbacks need a static data structure and cannot operate
on a pointer which wastes less builtin memory when the driver is not
used?

Also "play with it" is definitely not a technical term. See
Documentation/process/* which has lots of explanations how to write
proper change logs.

> Because IA55 input is from pin controller and IA55 resumes before pin
> controller we don't restore interrupt enable bits here but let the
> pinctrl to do it on IA55 behalf after pins are in proper state to
> avoid invalid interrupts.
> +
> +static struct rzg2l_irqc_priv {
>  	void __iomem *base;
>  	struct irq_fwspec fwspec[IRQC_NUM_IRQ];
>  	raw_spinlock_t lock;
> -};
> +	struct rzg2l_irqc_reg_cache cache;
> +} priv;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

>  
>  static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
>  {
> @@ -238,6 +251,37 @@ static int rzg2l_irqc_set_type(struct irq_data *d, unsigned int type)
>  	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
>  }
>  
> +static int rzg2l_irqc_irq_suspend(void)
> +{
> +	struct rzg2l_irqc_reg_cache *cache = &priv.cache;
> +
> +	cache->iitsr = readl_relaxed(priv.base + IITSR);
> +	for (u8 i = 0; i < 2; i++)
> +		cache->titsr[i] = readl_relaxed(priv.base + TITSR(i));
> +
> +	return 0;
> +}
> +
> +static void rzg2l_irqc_irq_resume(void)
> +{
> +	struct rzg2l_irqc_reg_cache *cache = &priv.cache;
> +	u8 i;
> +
> +	/*
> +	 * Restore only interrupt type. TSSRx will be restored at the
> +	 * request of pin controller to avoid spurious interrupts due
> +	 * to invalid PIN states.
> +	 */
> +	for (i = 0; i < 2; i++)
> +		writel_relaxed(cache->titsr[i], priv.base + TITSR(i));
> +	writel_relaxed(cache->iitsr, priv.base + IITSR);
> +}
> +
> +static struct syscore_ops rzg2l_irqc_syscore_ops = {
> +	.suspend = rzg2l_irqc_irq_suspend,
> +	.resume = rzg2l_irqc_irq_resume,
> +};

Ditto.

>  static const struct irq_chip irqc_chip = {
>  	.name			= "rzg2l-irqc",
>  	.irq_eoi		= rzg2l_irqc_eoi,
> @@ -323,7 +367,6 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
>  	struct irq_domain *irq_domain, *parent_domain;
>  	struct platform_device *pdev;
>  	struct reset_control *resetn;
> -	struct rzg2l_irqc_priv *priv;

Make this pointer static at the top level and leave the rest of the code
alone and please give it a proper name. "priv" at the file level is
really non-descriptive.

Thanks,

        tglx
