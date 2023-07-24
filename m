Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C85F75FF8A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGXTH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXTH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:07:26 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CE310E6;
        Mon, 24 Jul 2023 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=3Y4KGijrW9/aA84MSUFMPg+s6Z5g39h7S176iSgpcrM=; b=KIj2NFNg0/uDphKE+pfbXLaWeB
        e0aQHJtXKY5OAlsIR6W19BDkz8gHEGUb/GJnIqIu81eqqVoxzsKB8jK0xH0SWZ56xbUdGYAipDO4P
        5oWHE9VKbwanr19H06eomPMO7xVkEP29LQ20pjMRYajjir5QcZ0YM5LEjU8povDHqpgA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qO0O3-002AYP-D9; Mon, 24 Jul 2023 20:34:27 +0200
Date:   Mon, 24 Jul 2023 20:34:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: enable automedia on 6190x
 and 6390x devices
Message-ID: <d3f45312-882d-4667-89da-c562e0828589@lunn.ch>
References: <20230724101829.9431-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724101829.9431-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 12:18:29PM +0200, Ante Knezic wrote:
> Marvell 6190x and 6390x devices support using unusued lanes of
> ports 9 and 10 as automedia PHY/SERDES ports. In order to be
> able to use them as automedia ports, serdes lanes must be
> properly initialized so we allow setting the desired cmode to
> be later used by the phylink_pcs infrastructure.

By auto-media, you mean both a copper PHY and an SFP? And whichever
gets link first wins the MAC?

auto-media has been discussed a few times, and rejected, since Linux
has no concept of multiple 'phy like devices' connected to one MAC.

How are you representing this in DT? I assume you have both an SFP
socket, and a phy-handle pointing to a PHY? phylink will not drive
both at the same time. So you cannot have them admin up at the same
time? How do you get the SFP out of TX disable, when phylink sees a
PHY? What does ethtool return? What the PHY is advertising as its link
modes? Or nothing since an SFP does not advertise speeds?

       Andrew
