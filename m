Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3B67D8AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344889AbjJZV4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjJZV4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:56:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1F210D1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 14:56:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E31BC433C8;
        Thu, 26 Oct 2023 21:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698357406;
        bh=4p2Y8y/+j2W0nrEmfMNRT7ybpiEYGUJzt74xW+AVL0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PMT+wMfcQ99JqJdKasqGaK07OIoyHxfzjl4U1O3oMuz3I5r2u9uSuGg2dti7U73Jm
         E+gMzSK4H7AsAh4c8b4GXmd+jWQy7voHLAgm9H3Ns7mzOZJ2eHCCQXtJy8Bva6yu0w
         8tdroNth7cwhh0OtAuw85OBQ7gRxsISPJv9/7ul8oURh5aeHSyWMPq4BWzLv2p5fI8
         CaZcXmBQMwWl8UdFYbzY5hZcxVTISNMZ3GR3r0PD7TV/frzRatMr+lqC1RDAa6pqaT
         n11a6AyI41Y4qDWjF25cIT80kfNDJSI+qv42QIV5vE7qH8ZR99+vHVWzFKtxUR7c7x
         E/e13lClXgg7g==
Date:   Thu, 26 Oct 2023 14:56:44 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        Simon Horman <horms@kernel.org>,
        Justin Chen <justin.chen@broadcom.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Joe Damato <jdamato@fastly.com>, Jiri Pirko <jiri@resnulli.us>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 4/5] net: phy: broadcom: Add support for
 WAKE_FILTER
Message-ID: <20231026145644.58a8bd90@kernel.org>
In-Reply-To: <e6bd1a85-0bcf-457c-8fa8-33e68d818547@broadcom.com>
References: <20231025173300.1776832-1-florian.fainelli@broadcom.com>
        <20231025173300.1776832-5-florian.fainelli@broadcom.com>
        <CAMZ6RqJJXK5EyyOwXXbdA-bDTY=_JQ+xfKpoCHDJZqv+rNnASQ@mail.gmail.com>
        <CAMZ6Rq+iBazJ+fM5yd5Tfa8==DEGV93iD-XojU=f1m3ScSGEww@mail.gmail.com>
        <e6bd1a85-0bcf-457c-8fa8-33e68d818547@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 10:55:10 -0700 Florian Fainelli wrote:
> >> Also, did you run parse to check your endianness conversions?  
> 
> I did, though nothing came out with C=1 or C=2, I might have to check 
> that separately.

FWIW

drivers/net/phy/bcm-phy-lib.c:1128:42: warning: cast to restricted __be16
drivers/net/phy/bcm-phy-lib.c:1128:40: warning: incorrect type in assignment (different base types)
drivers/net/phy/bcm-phy-lib.c:1128:40:    expected restricted __be16 [usertype] h_proto
drivers/net/phy/bcm-phy-lib.c:1128:40:    got unsigned short [usertype]
drivers/net/phy/bcm-phy-lib.c:1188:17: warning: incorrect type in assignment (different base types)
drivers/net/phy/bcm-phy-lib.c:1188:17:    expected restricted __be16 [usertype] h_proto
drivers/net/phy/bcm-phy-lib.c:1188:17:    got unsigned short [usertype]
drivers/net/phy/bcm-phy-lib.c:1190:25: warning: incorrect type in assignment (different base types)
drivers/net/phy/bcm-phy-lib.c:1190:25:    expected restricted __be16 [usertype] h_proto
drivers/net/phy/bcm-phy-lib.c:1190:25:    got int
drivers/net/phy/bcm-phy-lib.c:1193:33: warning: incorrect type in argument 3 (different base types)
drivers/net/phy/bcm-phy-lib.c:1193:33:    expected unsigned short [usertype] val
drivers/net/phy/bcm-phy-lib.c:1193:33:    got restricted __be16 [usertype] h_proto
-- 
pw-bot: cr
