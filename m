Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9923810F15
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378280AbjLMK6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378217AbjLMK57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:57:59 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED9112A;
        Wed, 13 Dec 2023 02:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=mGIQDTPQtHNZfQHDhzO46ShItOaXBrTUkfxx2nG5SQY=; b=u7wVbB2pV5gntyL4PYXEwy2kdJ
        u/EwwnGsIUcLsYSsvJRCle6GQ8iC3RZSiPxEj9f8pG+3hewpcncW/zHnPcttRW+nebLpb9zUkZ/6S
        5sydG1e30JK1vCa+ujf9NWPiO2Wdou9AWl7gCyzTEOFIWZzawGXVS7KPBK2OrQPper4I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rDMw4-002oEF-E9; Wed, 13 Dec 2023 11:57:52 +0100
Date:   Wed, 13 Dec 2023 11:57:52 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mdio: mdio-bcm-unimac: Delay before first poll
Message-ID: <c3cc7a9d-d464-48e7-beb7-b90b1abbcfc7@lunn.ch>
References: <20231213000249.2020835-1-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213000249.2020835-1-justin.chen@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 04:02:49PM -0800, Justin Chen wrote:
> With a clock interval of 400 nsec and a 64 bit transactions (32 bit
> preamble & 16 bit control & 16 bit data), it is reasonable to assume
> the mdio transaction will take 25.6 usec. Add a 30 usec delay before
> the first poll to reduce the chance of a 1000-2000 usec sleep.

#define  MDIO_C45               0

suggests the hardware can do C45? The timing works out different then.
Maybe add a comment by the udelay() that is assumes C22, to give a
clue to somebody who is adding C45 support the delay needs to be
re-evaluated.

	Andrew
