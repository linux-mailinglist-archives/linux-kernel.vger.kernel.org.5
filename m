Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52AD7DC3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbjJaAbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJaAba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:31:30 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FD0AB;
        Mon, 30 Oct 2023 17:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=X2TOenv2wSGzRFJrfy0MQGwX7TY9kSnJhQ8UmhdL0E8=; b=BdxZCsaAJ2Qj1dX8fdAe6qPIgG
        TdBdjnI+AbCe8MTH/Ayoa/s8HDQ5ZHCXqjrpxGfZOWygbbqe2OjksJLtz82BIDs9NbP4LIwWsOguY
        U5K8ltPwjY13mGT1P4cAzqo3Vak0egGhKSFlDMpirI5mDb/yaE1nOzvOwJhnohlev7kQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qxcf1-000ZWD-H7; Tue, 31 Oct 2023 01:31:11 +0100
Date:   Tue, 31 Oct 2023 01:31:11 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marco von Rosenberg <marcovr@selfnet.de>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: broadcom: Wire suspend/resume for BCM54612E
Message-ID: <9cb4f059-edea-4c81-9ee4-e6020cccb8a5@lunn.ch>
References: <20231030225446.17422-1-marcovr@selfnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030225446.17422-1-marcovr@selfnet.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 11:54:45PM +0100, Marco von Rosenberg wrote:
> On some devices, the bootloader suspends the PHY before booting the OS.
> Not having a resume callback wired up is a problem in such situations
> since it is then never resumed.

Hi Marco

This description seems odd to me. I'm guessing here:

Are we talking about a device which as been suspended? The PHY has
been left running because there is no suspend callback? Something then
triggers a resume. The bootloader then suspends the active PHY? Linux
then boots, detects its a resume, so does not touch the hardware
because there is no resume callback? The suspended PHY is then
useless.

Adding suspend/resume calls makes sense, i just don't follow the
commit message reasoning.

	Andrew
