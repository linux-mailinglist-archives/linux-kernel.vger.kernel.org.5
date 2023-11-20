Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D3C7F1FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjKTVxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKTVxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:53:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A683A4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 13:53:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5678CC433C7;
        Mon, 20 Nov 2023 21:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700517184;
        bh=9RqEIpuLdVNZNHQa0nNGH5rDz3KYaKakSinhvKWkJiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IKQEZKtOaFgUogApHmwRGDszSun7xUOeNSfn9fJzwqll2hlDNa0mqCGtvvZ6N55a4
         FtMIf3tRuFWftWjW7Q1vQ7Q1HV0tLtQ4Ccwwg9f2hqF/2X+Ajme4IBwpt5jQk4ulc0
         bu+c0DNJSG/Wfimighx0qGswrZj20WgoG78T9ez7dHeTUgduG8T2KUdjJC781F0haC
         7UvUaO8WbuWMFVkuMasQqMRbHPaIHujWpWMlfzwwVEvIori6rLke1vtrlVwVaFlWz5
         iNkAW6me4t7ccEWSvWUY6p7UcSpn0+Ogh1nmMQabFF3Qey6+VtXzr0eMJwMROsQ1QW
         FoerVtRfC1duA==
Date:   Mon, 20 Nov 2023 13:53:03 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: correctly check soft_reset ret ONLY
 if defined for PHY
Message-ID: <20231120135303.0e64bc81@kernel.org>
In-Reply-To: <655bb7e5.5d0a0220.59243.9a2c@mx.google.com>
References: <20231120131540.9442-1-ansuelsmth@gmail.com>
        <20231120094234.1aae153e@kernel.org>
        <655bb7e5.5d0a0220.59243.9a2c@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 17:50:53 +0100 Christian Marangi wrote:
> On Mon, Nov 20, 2023 at 09:42:34AM -0800, Jakub Kicinski wrote:
> > On Mon, 20 Nov 2023 14:15:40 +0100 Christian Marangi wrote:  
> > > Luckly nothing was ever added before the soft_reset call so the ret
> > > check (in the case where a PHY didn't had soft_reset defined) although
> > > wrong, never caused problems as ret was init 0 at the start of
> > > phy_init_hw.  
> > 
> > not currently a bug => no Fixes tag, please  
> 
> I know it's not a bug but still the referenced commit was wrong. Can I
> at least use Ref to reference it?

Not sure what you mean by "Ref"

> Due to the changes done to this function, it's hard to catch where the
> problem arised with a git blame.

Right, and you already quote the commit in the body. No objections to
repeating that if you want, maybe:

Introduced by commit 6e2d85ec0559 ("net: phy: Stop with excessive soft
reset").

but as a part of the "body" of the commit message, not tags.
