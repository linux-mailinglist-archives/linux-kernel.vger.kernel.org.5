Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564307FC53D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345747AbjK1UXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjK1UXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:23:45 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AFD19AB;
        Tue, 28 Nov 2023 12:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=OZx/da2wVl9ApR87F5Ow4/cPqWOdBxBeVYndGfDi8EA=; b=er
        FzEYNorKXpOTjfwSwBGe6lvaCpgtLUR/uznDjygjZT8iETer0Jbz9WWq2OEB///M1n7pIq3jspbpL
        fqCe8TNdoPZQFol9eGB83ybH7BiEvWJcBqDjfn+a83qiUDY4Q0/Cs2aZEYfpGR4h82GILS4pe7fIu
        aZq6kbsLBg9hpCY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r84cQ-001UQC-8r; Tue, 28 Nov 2023 21:23:42 +0100
Date:   Tue, 28 Nov 2023 21:23:42 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH net-next] net: phy: adin: allow control of Fast Link Down
Message-ID: <b16f4344-815c-429f-b3b5-58715b32e1db@lunn.ch>
References: <20231127-adin-fld-v1-1-797f6423fd48@axis.com>
 <452f1e1c-1afd-4a36-bf60-11b7de291d2f@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <452f1e1c-1afd-4a36-bf60-11b7de291d2f@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 09:18:00PM +0100, Andrew Lunn wrote:
> On Mon, Nov 27, 2023 at 04:31:39PM +0100, Vincent Whitchurch wrote:
> > Add support to allow Fast Link Down (aka "Enhanced link detection") to
> > be controlled via the ETHTOOL_PHY_FAST_LINK_DOWN tunable.  These PHYs
> > have this feature enabled by default.
> > 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> Is there anything in the datasheet about how fast it is? It would be
> nice to return the number of milliseconds, if its known.

Datasheet says:

 If enhanced link detection is enabled (it is enabled by default), the
 ADIN1300 typically reacts to a break in the cable within 10 μs and
 indicates link down via the LINK_ST pin. If enhanced link detection
 is not enabled, the ADIN1300 follows the IEEE standard, and in
 100BASE-TX, it can take more than either 350 ms or 750 ms in
 1000BASE-T, depending if the PHY is 1000BASE-T master or 1000BASE-T
 slave.

10uS is closer to 0ms and 1ms, so ETHTOOL_PHY_FAST_LINK_DOWN_ON == 0
is right.

   Andrew
