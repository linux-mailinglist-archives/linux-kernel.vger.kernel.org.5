Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C567DB18A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjJ2Xp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2Xp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:45:26 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DA49E;
        Sun, 29 Oct 2023 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=KaJzOtJRW4EWZHUOSEMMSs8gJwo3z32RgK/AsKPmB5E=; b=TcT1Rc44sOhOTrfiX4DFzUB0QX
        kiIDhy4VFO7soYj7F2TiwyIJ6KU4+HZboUkTX91Tjan6hFN5K6nsDjIZw+BgsMrbZC0+xayzBzbW9
        F/+6SBRckibKw6CF21tMyWjzUjksQgsikBGsO+MgImr3DT1aPvZuY6ZxdTZ60sitTiSM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qxEly-000TGF-Dp; Mon, 30 Oct 2023 00:00:46 +0100
Date:   Mon, 30 Oct 2023 00:00:46 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Mauri Sandberg <sandberg@mailfence.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
Message-ID: <54f8d583-e900-4ce8-87d1-a18556698f10@lunn.ch>
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
 <20231028220402.gdsynephzfkpvk4m@skbuf>
 <CACRpkdbq03ZXcB-TaBp5Udo3M47rb-o+LfkEkC-gA1+=x1Zd-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbq03ZXcB-TaBp5Udo3M47rb-o+LfkEkC-gA1+=x1Zd-g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 1496 is suspiciously much 1500 - DSA tag size. However the
> MTU of the parent ethernet is bumped nicely to 1504 and the
> device MTU is set up to accomodate it as well.
> 
> Modifying the patch to just pad out packets >= 1496 bytes
> solves the problem in a better way, but maybe that is not the
> last thing we try here...

Have you tried playing with RTL8366RB_SGCR in rtl8366rb_change_mtu()?

I had an annoying bug in the mv88e6xxx driver where the MTU
configuration register was up to, but not including... So i had to
change a <= to <.

	Andrew
