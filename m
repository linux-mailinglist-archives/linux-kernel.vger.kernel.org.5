Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8E877EA84
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346085AbjHPUNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346067AbjHPUNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:13:20 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83111BF3;
        Wed, 16 Aug 2023 13:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=xtF5JRp5Kq7TdFjwmV9grIL6CxjSQSZ/98DRooLufJM=; b=UDgeT26/ySvSaJnB/lLynndQ0X
        rEM1SQ02LLiSplkT2Cl7bFpmdwfNMXS0tXfo9Vf1no6sfEG15nJAFg6iEqNNbFmAPsyK7YxmDU3m3
        UpGhsnjlcx1Me/3e3nrVk26phAopFy1q4pbXJ3MHe5ddbUELtLGcnP1+Vm0KvRqcjNA4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qWMtC-004JN6-VE; Wed, 16 Aug 2023 22:13:10 +0200
Date:   Wed, 16 Aug 2023 22:13:10 +0200
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
Message-ID: <01cf4367-1c2d-4920-a387-3ba38b83dd66@lunn.ch>
References: <20230816180944.19262-1-fancer.lancer@gmail.com>
 <b5ae4bc5-20cb-470b-988c-86353592f1c9@lunn.ch>
 <ksgfr3o6nm4k5qhamsqhyardnpb5fm5xclhr4fwpgldhzjlax6@r5ry4ztkqx5c>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ksgfr3o6nm4k5qhamsqhyardnpb5fm5xclhr4fwpgldhzjlax6@r5ry4ztkqx5c>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > So i suggest you change phy_process_error() to remove the lock.
> 
> This doable.
> 
> > Maybe
> > add a test to ensure the lock is actually held, and do a phydev_err()
> > if not.
> 
> This can't be done since phy_state_machine() calls phy_error_precise()
> which calls phy_process_error() with no phy_device.lock held. Printing the
> error in that case would mean an error in the Networking PHY subsystem
> itself.
> 
> Do you suggest to take the lock before calling phy_error_precise() then?

Thanks for digging into the details.

phy_error_precise() is used in exactly one place. So i would actually
put the lock inside it. And maybe move the comment about not using the
function with the lock already held here :-)

	 Andrew
