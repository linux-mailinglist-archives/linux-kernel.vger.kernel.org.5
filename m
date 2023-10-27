Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE307DA3ED
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 01:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346684AbjJ0XD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 19:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0XD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 19:03:57 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5208EE5;
        Fri, 27 Oct 2023 16:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=xRiJUuGtHW8iQQcWj1oKNcb7oucnpbSMai50FKnBweM=; b=M7hoPYjMTY6dR1wilNag4sc1b6
        OLHFdmdwyCFcNsBJRwhRzeV4MzMG0TWm1ytdW7oR6qrYdT+tu1jMYTrFExoSMZFzFhQeVTmUHBk5S
        +lxh4g+segET8/HtuzR81aVd751X1jAX9EcTxfBn3bCiuBqL2EeQmVjuQ66BS8k/siJU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qwVrn-000Ned-27; Sat, 28 Oct 2023 01:03:47 +0200
Date:   Sat, 28 Oct 2023 01:03:47 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
Message-ID: <3ffe7ea1-4dfb-4db8-a2ce-67733a190138@lunn.ch>
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
 <95f324af-88de-4692-966f-588287305e09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f324af-88de-4692-966f-588287305e09@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 02:23:13PM -0700, Florian Fainelli wrote:
> You would want your subject to be:
> 
> net: dsa: tag_rtl4_a: Bump min packet size
> 
> On 10/27/23 13:21, Linus Walleij wrote:
> > It was reported that the "LuCI" web UI was not working properly
> > with a device using the RTL8366RB switch. Disabling the egress
> > port tagging code made the switch work again, but this is not
> > a good solution as we want to be able to direct traffic to a
> > certain port.
> > 
> > It turns out that sometimes, but not always, small packets are
> > dropped by the switch for no reason.
> 
> And we are positive that the Ethernet MAC is also properly padding frames
> before having them ingress the switch?

It might be interesting to run a script which systematically does a
ping, or similar, for all frame sizes.

> > If we pad the ethernet frames to a minimum of ETH_FRAME_LEN + FCS
> > (1518 bytes) everything starts working fine.
> 
> That is quite unprecedented, either the switch is very bogus or there is
> something else we do not fully understand...

It would also be interesting to know if the frames on the wire have
the padding removed when needed. Its not going to be good for
performance if a TCP ACK is 1500bytes in size, rather than the usual
~64.

Have problems also been noticed with traffic going from user port to
user port?

	Andrew
