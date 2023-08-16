Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBEC77E9C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345837AbjHPTga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345826AbjHPTgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:36:17 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484EA270C;
        Wed, 16 Aug 2023 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=QxcHYEXSEj/KJ+FSI5KmSWw0t70fxjKqE05cLmLc4gg=; b=lHRwkJOmRglxwZ3Wo7qKJoYuDq
        ++x4k/xLJZbnx+/fwIytW6J2lhyheAYXnLHPLxU6auxEaBbtYvB8BZ+pKK6MuXiEd9GqgmTagZ8o0
        962N4AEESI9tv1nuxGTKfBqNuR1sXOf9FoWADFuk8Wj0lIvKhGPr0w3zeG6rA9xjrAY4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qWMJB-004J93-AI; Wed, 16 Aug 2023 21:35:57 +0200
Date:   Wed, 16 Aug 2023 21:35:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net] Revert "net: phy: Fix race condition on link status
 change"
Message-ID: <b5ae4bc5-20cb-470b-988c-86353592f1c9@lunn.ch>
References: <20230816180944.19262-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816180944.19262-1-fancer.lancer@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:09:40PM +0300, Serge Semin wrote:
> Protecting the phy_driver.drv->handle_interrupt() callback invocation by
> the phy_device.lock mutex causes all the IRQ-capable PHY drivers to lock
> the mutex twice thus deadlocking on the next calls thread:
> IRQ: phy_interrupt()
>      +-> mutex_lock(&phydev->lock); <-------------+
>          drv->handle_interrupt()                  | Deadlock due to the
>          +-> phy_error()                          + nested PHY-device
>              +-> phy_process_error()              | mutex lock
>                  +-> mutex_lock(&phydev->lock); <-+
>                      phydev->state = PHY_ERROR;
>                      mutex_unlock(&phydev->lock);
>          mutex_unlock(&phydev->lock);
> 
> The problem can be easily reproduced just by calling phy_error() from the
> any PHY-device interrupt handler.

https://elixir.bootlin.com/linux/v6.5-rc6/source/drivers/net/phy/phy.c#L1201

/**
 * phy_error - enter ERROR state for this PHY device
 * @phydev: target phy_device struct
 *
 * Moves the PHY to the ERROR state in response to a read
 * or write error, and tells the controller the link is down.
 * Must not be called from interrupt context, or while the
 * phydev->lock is held.
 */
void phy_error(struct phy_device *phydev)
{
	WARN_ON(1);
	phy_process_error(phydev);
}
EXPORT_SYMBOL(phy_error);

It is clearly documented you should not do this.

[Goes and looks]

Ah, there are lots of examples of

micrel.c-	irq_status = phy_read(phydev, LAN8814_INTS);
micrel.c-	if (irq_status < 0) {
micrel.c:		phy_error(phydev);
micrel.c-		return IRQ_NONE;
micrel.c-	}

I actually think phy_error() is broken here. The general pattern is
that the mutex is locked before calling into the driver. So we
actually want phy_error() to be safe to use with the lock already
taken. The exceptions when the lock is not held is stuff outside of
PHY operation, like HWMON, and suspend and resume, plus probe.

So i suggest you change phy_process_error() to remove the lock. Maybe
add a test to ensure the lock is actually held, and do a phydev_err()
if not.

The comment about interrupt context is also probably bogus. phylib
only uses threaded interrupts, and it is safe to block in this
context.

	Andrew
