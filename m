Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DD37FCB6C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 01:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376698AbjK2Afn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 19:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376683AbjK2Afk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 19:35:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C0B19A6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 16:35:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD2CC433C8;
        Wed, 29 Nov 2023 00:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701218146;
        bh=CEyKgl9exP4XEknYN9UDsJmLxQMgn2xe10MjBsA+2Rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujwKHO23grlfzlnd0pvsWiou2vfCGyav3Rf2RrCygDfh2jSoPPcv9jNDzJRo9tP3S
         H/Om4NjxC0ZIYNEmNoJSXekdmoT9sno3LV82jwmo3Wm4MnLi/14WEzzDq8Z1A+Gr3B
         4GhSvp3i7COC2HRpAXHDGwrkyMPM5p6jOfewEyRPPgbloX4NRFp+ZOsnTfHiI2DzCK
         TX05jGApV4o6HvJPeU3nJsrycy/4lreBoQf7OM+nVtsmSxC2RCBrBypqXEuh4XhPJX
         Vt2iZ6WMcKqAA2hlgoWhnYZ/OgLsv1iGofep+vnd5mt5jMePKIHY/H8hat/HJ76GgK
         Of3wVqe1InEjw==
Date:   Wed, 29 Nov 2023 01:35:42 +0100
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
Subject: Re: [PATCH v2 RESEND 1/2] i2c: aspeed: Fix unhandled Tx done with NAK
Message-ID: <20231129003542.jfhhotebweb3uwyb@zenone.zhora.eu>
References: <20231128075236.2724038-1-quan@os.amperecomputing.com>
 <20231128075236.2724038-2-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231128075236.2724038-2-quan@os.amperecomputing.com>
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

On Tue, Nov 28, 2023 at 02:52:35PM +0700, Quan Nguyen wrote:
> Under normal conditions, after the last byte is sent by the Slave, the
> TX_NAK interrupt is raised.  However, it is also observed that
> sometimes the Master issues the next transaction too quickly while the
> Slave IRQ handler is not yet invoked and the TX_NAK interrupt for the
> last byte of the previous READ_PROCESSED state has not been ack’ed.
> This TX_NAK interrupt is then raised together with SLAVE_MATCH interrupt
> and RX_DONE interrupt of the next coming transaction from Master. The
> Slave IRQ handler currently handles the SLAVE_MATCH and RX_DONE, but
> ignores the TX_NAK, causing complaints such as
> "aspeed-i2c-bus 1e78a040.i2c-bus: irq handled != irq. Expected
> 0x00000086, but was 0x00000084"
> 
> This commit adds code to handle this case by emitting a SLAVE_STOP event
> for the TX_NAK before processing the RX_DONE for the coming transaction
> from the Master.
> 
> Fixes: f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed I2C driver")
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> v2:
>   + Split to separate series [Joel]
>   + Added the Fixes line [Joel]
>   + Revised commit message [Quan]
> 
> v1:
>   + First introduced in
> https://lore.kernel.org/all/20210519074934.20712-1-quan@os.amperecomputing.com/
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 28e2a5fc4528..79476b46285b 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -253,6 +253,11 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>  
>  	/* Slave was requested, restart state machine. */
>  	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
> +		if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
> +		    bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
> +			irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
> +			i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
> +		}

this is a duplicate of a later "if (...)" satement. What is the
need for having them both?

Andi

>  		irq_handled |= ASPEED_I2CD_INTR_SLAVE_MATCH;
>  		bus->slave_state = ASPEED_I2C_SLAVE_START;
>  	}
> -- 
> 2.35.1
> 
