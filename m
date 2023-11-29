Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAAE7FCBB9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 01:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjK2ApI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 19:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK2ApG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 19:45:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF9019A6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 16:45:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78E4C433C7;
        Wed, 29 Nov 2023 00:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701218712;
        bh=BoDVFsUwHvuFZBXmTakeJFuui2uZQsPNMqQoXk1kNR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+c/QVVlFt+4XBozCUgCmmdawfa41r0LR0C0rmMKZavCT4ks2DZVIA/7g4tpDjbZA
         D+4vAHH+Z3nDvsqsGxlYgioWFDizCwTyExQcZ4DIAaozf4IOE/lb4EwH2FcuzfUS7u
         WI8AU8MQ2Gk9Oc68S3WD7SqOG4HOWYGJ/xK6e3//MbbPpHdLB+IS4aGEQdZwD1mw60
         3QCh07zZTWZpudVjCmniRaNIO3stHLKDG/IbQFKnK+R/b7+ttxFieOGowaz2w7dZ03
         x7ecp7hwRyK7AM4bCcl8nDcbVzD+v4N8mY3b50gTDdClQ274lEB59KPvwWcR1is+5v
         YcnIOBhcd/Ukw==
Date:   Wed, 29 Nov 2023 01:45:09 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Wolfram Sang <wsa@kernel.org>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Cosmo Chou <chou.cosmo@gmail.com>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v2 RESEND 2/2] i2c: aspeed: Acknowledge Tx done with and
 without ACK irq late
Message-ID: <20231129004509.ilriuwm3hulvy67l@zenone.zhora.eu>
References: <20231128075236.2724038-1-quan@os.amperecomputing.com>
 <20231128075236.2724038-3-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231128075236.2724038-3-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quan,

On Tue, Nov 28, 2023 at 02:52:36PM +0700, Quan Nguyen wrote:
> Commit 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in
> interrupt handler") acknowledges most interrupts early before the slave
> irq handler is executed, except for the "Receive Done Interrupt status"
> which is acknowledged late in the interrupt.
> However, it is observed that the early acknowledgment of "Transmit Done
> Interrupt Status" (with ACK or NACK) often causes the interrupt to be
> raised in READ REQUEST state, resulting in "Unexpected ACK on read
> request." complaint messages.
> 
> Assuming that the "Transmit Done" interrupt should only be acknowledged
> once it is truly processed, this commit fixes this issue by acknowledging
> this interrupt for both ACK and NACK cases late in the interrupt handler
> also.
> 
> Fixes: 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in interrupt handler")
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> v2:
>   + Split to separate series [Joel]
>   + Added the Fixes line [Joel]
>   + Fixed multiline comment [Joel]
>   + Refactor irq clearing code [Joel, Guenter]
>   + Revised commit message [Joel]
>   + Revised commit message [Quan]
>   + About a note to remind why the readl() should immediately follow the
> writel() to fix the race condition when clearing irq status from commit
> c926c87b8e36 ("i2c: aspeed: Avoid i2c interrupt status clear race
> condition"), I think it looks straight forward in this patch and decided
> not to add that note. [Joel]
> 
> v1:
>   + First introduced in
> https://lore.kernel.org/all/20210519074934.20712-1-quan@os.amperecomputing.com/
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 79476b46285b..3231f430e335 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -611,8 +611,9 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  
>  	spin_lock(&bus->lock);
>  	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> -	/* Ack all interrupts except for Rx done */
> -	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
> +	/* Ack all interrupts except for Rx done and Tx done with/without ACK */
> +	writel(irq_received &
> +	       ~(ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK | ASPEED_I2CD_INTR_TX_NAK),
>  	       bus->base + ASPEED_I2C_INTR_STS_REG);
>  	readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>  	irq_received &= ASPEED_I2CD_INTR_RECV_MASK;
> @@ -657,12 +658,12 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
>  			irq_received, irq_handled);
>  
> -	/* Ack Rx done */
> -	if (irq_received & ASPEED_I2CD_INTR_RX_DONE) {
> -		writel(ASPEED_I2CD_INTR_RX_DONE,
> -		       bus->base + ASPEED_I2C_INTR_STS_REG);
> -		readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> -	}
> +	/* Ack Rx done and Tx done with/without ACK */
> +	writel(irq_received &
> +	       (ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK | ASPEED_I2CD_INTR_TX_NAK),
> +	       bus->base + ASPEED_I2C_INTR_STS_REG);
> +	readl(bus->base + ASPEED_I2C_INTR_STS_REG);

So, you are acknowledging everything here. Why wasn’t it done
this way in the first place?

I would appreciate a comment here from Guenter, whose commit you
are fixing.

Thanks,
Andi

>  	spin_unlock(&bus->lock);
>  	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
>  }
> -- 
> 2.35.1
> 
