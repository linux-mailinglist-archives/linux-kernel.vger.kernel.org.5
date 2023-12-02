Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD8801DB8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjLBQ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:28:06 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB046102;
        Sat,  2 Dec 2023 08:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=8ciHNODe1XPDwRK+aaMl61d1zRycOP5g608zUMVfPxw=; b=2thgjsDDHgmxMZfWqUFviHaPEK
        n+R1DfQa8qc2fTb2/P/ct6SRk4m0gUInbJ4AyF/msduCPmpGvMSLhmGfUU3VlU8oHZtfLeqQqaYNB
        AecDJKiEpOv84dLDKIKHkv9DawjHv9H8rLIn2t0UfrdL5WY0guaQm91jw67cXr7xbxX4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r9SqT-001rE6-RY; Sat, 02 Dec 2023 17:27:57 +0100
Date:   Sat, 2 Dec 2023 17:27:57 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Justin Lai <justinlai0215@realtek.com>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v13 01/13] rtase: Add pci table supported in
 this module
Message-ID: <27b2b87a-929d-4b97-9265-303391982d27@lunn.ch>
References: <20231130114327.1530225-1-justinlai0215@realtek.com>
 <20231130114327.1530225-2-justinlai0215@realtek.com>
 <20231201203602.7e380716@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201203602.7e380716@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 08:36:02PM -0800, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 19:43:15 +0800 Justin Lai wrote:
> > + *  Below is a simplified block diagram of the chip and its relevant interfaces.
> > + *
> > + *               *************************
> > + *               *                       *
> > + *               *  CPU network device   *
> > + *               *                       *
> > + *               *   +-------------+     *
> > + *               *   |  PCIE Host  |     *
> > + *               ***********++************
> > + *                          ||
> > + *                         PCIE
> > + *                          ||
> > + *      ********************++**********************
> > + *      *            | PCIE Endpoint |             *
> > + *      *            +---------------+             *
> > + *      *                | GMAC |                  *
> > + *      *                +--++--+  Realtek         *
> > + *      *                   ||     RTL90xx Series  *
> > + *      *                   ||                     *
> > + *      *     +-------------++----------------+    *
> > + *      *     |           | MAC |             |    *
> > + *      *     |           +-----+             |    *
> > + *      *     |                               |    *
> > + *      *     |     Ethernet Switch Core      |    *
> > + *      *     |                               |    *
> > + *      *     |   +-----+           +-----+   |    *
> > + *      *     |   | MAC |...........| MAC |   |    *
> > + *      *     +---+-----+-----------+-----+---+    *
> > + *      *         | PHY |...........| PHY |        *
> > + *      *         +--++-+           +--++-+        *
> > + *      *************||****************||***********
> > + *
> > + *  The block of the Realtek RTL90xx series is our entire chip architecture,
> > + *  the GMAC is connected to the switch core, and there is no PHY in between.
> > + *  In addition, this driver is mainly used to control GMAC, but does not
> > + *  control the switch core, so it is not the same as DSA.
> 
> Okay, but you seem to only register one netdev.
> 
> Which MAC is it for?

The GMAC one. This is going to be a DSA system, and this driver is for
the conduit MAC the CPU uses. At some point, i hope there is a DSA
driver added, or the existing realtek driver is extended to support
this switch.

       Andrew
 
