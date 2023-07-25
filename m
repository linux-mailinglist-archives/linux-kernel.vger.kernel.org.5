Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA44E762443
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGYVWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGYVWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:22:15 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D7FE42;
        Tue, 25 Jul 2023 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=d+iOgrhKkE2nmyxe64NIWGgf31a1pDme4fwS+q0AB20=; b=cIRvXlLLofVylBOd/yRFZGsSxi
        EuuZu9ytZ7cHMa4K67KIyAVVzicrz5nJGG9OZOWS0u8aSl+kG4vNrJKDtw2O1waoEkx3SUIiTbwST
        27+lxVndvakFjtj1vKjmBpsCs3d+BSuXX3becPiZ7Dztp2tNvYXiyt4KQCux8p0G/mI4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qOPTq-002J6D-9a; Tue, 25 Jul 2023 23:22:06 +0200
Date:   Tue, 25 Jul 2023 23:22:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     davem@davemloft.net, edumazet@google.com, f.fainelli@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: enable automedia on 6190x
 and 6390x devices
Message-ID: <e408ed0a-94fc-438f-b279-79f9253531d5@lunn.ch>
References: <d3f45312-882d-4667-89da-c562e0828589@lunn.ch>
 <20230725095712.24771-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725095712.24771-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:57:12AM +0200, Ante Knezic wrote:
> On Mon, 24 Jul 2023 20:34:27 +0200 Anrew Lunn wrote:
> >By auto-media, you mean both a copper PHY and an SFP? And whichever
> >gets link first wins the MAC?
> >
> 
> Yes, that is correct.
> 
> On Mon, 24 Jul 2023 20:34:27 +0200 Anrew Lunn wrote:
> >auto-media has been discussed a few times, and rejected, since Linux
> >has no concept of multiple 'phy like devices' connected to one MAC.
> >
> >How are you representing this in DT? I assume you have both an SFP
> >socket, and a phy-handle pointing to a PHY? phylink will not drive
> >both at the same time. So you cannot have them admin up at the same
> >time? How do you get the SFP out of TX disable, when phylink sees a
> >PHY? What does ethtool return? What the PHY is advertising as its link
> >modes? Or nothing since an SFP does not advertise speeds?
> 
> Patch simply covers the automedia aspect of the device while the
> exact mode is specified by the DT.

So i would not call this automedia. You are not supporting both copper
and SFP at the same time, and you are not supporting first win. You
are just allowing the lower ports to use the SERDES interfaces for
SFPs.

> So for example if you would like
> to connect an SFP to port 3 of the device you would create a "regular"
> sfp node just like for ports 9/10 along the lines of:
>                         port@3 {
>                                 reg = <3>;
>                                 label = "SFP";
>                                 phy-mode = "1000base-x";
>                                 managed = "in-band-status";
>                                 sfp = <&sfp1>;
>                         };
> 
> >From then on, phylink will handle the sfp just as if it was connected
> to ports 9/10 - the ethtool reports advertised and supported link mode
> as 1000baseX, "Port" is "FIBRE", etc.
> 
> Patch looks for "1000base-x" phy-mode in the dt node so in case it
> is not found the device can be linked only against a copper PHY.

So this used to work. It got broken at some point, and i have a much
simpler patch in one of the branches:

https://github.com/lunn/linux/commit/74e2c2a9a56fd4e2baeee4d5fbe897c21f394ede

Please try this and see if it works for you.

       Andrew
