Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0C080B653
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjLIUo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjLIUo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:44:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E699D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 12:45:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D95C433C8;
        Sat,  9 Dec 2023 20:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702154702;
        bh=+7qwKc+g6O9nPYHObVhq00UWcOt2oMbcUuD1ls3YUTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/4uchdKtwypNWRTa301WpvfdXEMmFakt5eog88JUDkRhczMX02e3rBBWNEwlx6jg
         PxtES+X9BVhyAsugIobcqBW8v+Y+EUd1b46dg2QTmBNxvZcHYXf5CrmyWPsJUbK+J6
         inuDB4VU2hVdI8Zvgc+Rh9hR0GrAcXt0Jq2mxUubAy7rzs0aWFKylmRRpgmQliSB14
         yZNL8vhb+wq9yb7WJeyTEJVfFYEZ0bF0Kup+mBXqrErjRnHSe3d9IblX19xyWi2r/k
         XnxKG81bLPX5jty4mlhRlHrV28YTlmPt/PHuy8Y26qhk5OKchvN6Lpk6cWZH6TZDTi
         BUZNlNoGDhOxw==
Date:   Sat, 9 Dec 2023 21:44:55 +0100
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
Subject: Re: [PATCH v3 2/2] i2c: aspeed: Acknowledge Tx done with and without
 ACK irq late
Message-ID: <20231209204455.jxize3muvx7hhpos@zenone.zhora.eu>
References: <20231208033142.1673232-1-quan@os.amperecomputing.com>
 <20231208033142.1673232-3-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208033142.1673232-3-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quan,

[...]

> -	/* Ack all interrupts except for Rx done */
> -	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
> -	       bus->base + ASPEED_I2C_INTR_STS_REG);
> +
> +	/*
> +	 * Early acking of INTR_RX_DONE and INTR_TX_[ACK|NAK] would indicate HW to
> +	 * start receiving or sending new data, and this may cause a race condition
> +	 * as the irq handler has not yet handled these irqs but is being acked.
> +	 * Let's ack them late at the end of the irq handler when those are truly processed.
> +	 */
> +	irq_ack_last = ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK | ASPEED_I2CD_INTR_TX_NAK;
> +	writel(irq_received & ~irq_ack_last, bus->base + ASPEED_I2C_INTR_STS_REG);

I like Andrews suggestion of having irq_ack_last as a define that
is already negated, instead of negating it in the writel, which
makes it a bit difficult to read.

Besides, ack_last, as a name is not very meaningful, I'd rather
call it irq_ack_rx_tx (or something similar).

But I'm not going to block it for this, up to you if you want to
send a new version.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
