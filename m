Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD2F7FAD7C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjK0WdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjK0WdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:33:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1201BF5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:25:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870A7C433C8;
        Mon, 27 Nov 2023 22:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701123926;
        bh=GRyFkV0q85dCw/8aaH+ce1mWfZBdwTA+ebfxJuBFea8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pjb9M3dguGR27IGPgk/7/jJ7HJDeS4kcZHWrGtB6092BMnDwGSeo6greCg8V3ZJMw
         h+Un3fkdNsnqi2kCK1/1wVmliPfj9ayXqqBZ+i0Rb2ymnHNVXCyGeS7FGCc/ipMIA5
         xpyJJ1iLa9qeTTlGGs2qtZ11lSX2hEctXIaxJblHMQcmw7tT3hU9NGiSisDXJtTQ4q
         fNKPhB9JRF2v1qDFyuPZr39+7oV4r8dQvnqfhl1NElCvV95Qw/cwdKNY8bmZP0UmEj
         UonC0osEUR63TOcFdhGbXTC1I+8DWlnG/n/Tn5WKfozXD8vuuRyQk+EB06+umtURVW
         eaS1NLYatfWfg==
Date:   Mon, 27 Nov 2023 23:25:22 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Cosmo Chou <chou.cosmo@gmail.com>
Cc:     brendan.higgins@linux.dev, benh@kernel.crashing.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, linux@roeck-us.net,
        wsa@kernel.org, jae.hyun.yoo@linux.intel.com,
        linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        cosmo.chou@quantatw.com
Subject: Re: [PATCH] i2c: aspeed: Acknowledge Tx ack late when in
 SLAVE_READ_PROCESSED
Message-ID: <20231127222522.wjdd6btbug6shd7y@zenone.zhora.eu>
References: <20231120091746.2866232-1-chou.cosmo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120091746.2866232-1-chou.cosmo@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cosmo,

On Mon, Nov 20, 2023 at 05:17:46PM +0800, Cosmo Chou wrote:
> commit 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early
> in interrupt handler") moved most interrupt acknowledgments to the
> start of the interrupt handler to avoid race conditions. However,
> slave Tx ack status shouldn't be cleared before SLAVE_READ_PROCESSED
> is handled.
> 
> Acknowledge Tx ack status after handling SLAVE_READ_PROCESSED to fix
> the problem that the next byte is not sent correctly.
> 
> Fixes: 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in interrupt handler")
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 28e2a5fc4528..c2d74e4b7e50 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -337,6 +337,12 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>  		break;
>  	}
>  
> +	/* Ack Tx ack */
> +	if (irq_handled & ASPEED_I2CD_INTR_TX_ACK) {
> +		writel(ASPEED_I2CD_INTR_TX_ACK, bus->base + ASPEED_I2C_INTR_STS_REG);
> +		readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +	}
> +
>  	return irq_handled;
>  }
>  #endif /* CONFIG_I2C_SLAVE */
> @@ -602,13 +608,18 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>  static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  {
>  	struct aspeed_i2c_bus *bus = dev_id;
> -	u32 irq_received, irq_remaining, irq_handled;
> +	u32 irq_received, irq_remaining, irq_handled, irq_acked;
>  
>  	spin_lock(&bus->lock);
>  	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>  	/* Ack all interrupts except for Rx done */
> -	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
> -	       bus->base + ASPEED_I2C_INTR_STS_REG);
> +	irq_acked = irq_received & ~ASPEED_I2CD_INTR_RX_DONE;
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +	/* shouldn't ack Slave Tx Ack before it's handled */
> +	if (bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED)
> +		irq_acked &= ~ASPEED_I2CD_INTR_TX_ACK;
> +#endif
> +	writel(irq_acked, bus->base + ASPEED_I2C_INTR_STS_REG);

which branch are you? You don't look like being in the latest.
Please update your branch.

Andi

>  	readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>  	irq_received &= ASPEED_I2CD_INTR_RECV_MASK;
>  	irq_remaining = irq_received;
> -- 
> 2.34.1
> 
