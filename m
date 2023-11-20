Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2197F1A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjKTRhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbjKTRh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:37:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD27D72
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:37:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03177C433C7;
        Mon, 20 Nov 2023 17:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700501845;
        bh=XvOTh/srznUoYLM2WTLAm4UhF2NlkB1XPEDQdf6C4e4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cWYJ+uOejmw8gg1t2I8ApTuyaqhsivYgHsBvw6o3HRH46GT6iidi3lTR67y12NTZ3
         iHXYozPX0WYk8oyXSHgElpYNjrslFH7odgRpXZkfOrXlzsfiVtjCjpQDIt47hnSCuF
         wPL9LrGmx5d751IlqTe3/jtJ5Nw33Vqfo0V5LiCunVh+ghg2rvkYLB3/3ujG82R938
         CrHaXX7cIsYxXt+9wxFnzGrB9WS56eFVhC3vxf861CgZQJG/HbGwWZwL2o7tWiY1aI
         qHlyvxFPSViN4/xZCXrsbx/2GcNJpZaeM8yMX+VfO+kCYKc/LIZYDIB1qqTbkjN26l
         6146cd+NGxtxA==
Date:   Mon, 20 Nov 2023 09:37:23 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231120093723.4d88fb2a@kernel.org>
In-Reply-To: <20231120142316.d2emoaqeej2pg4s3@skbuf>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
        <20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
        <20231118183433.30ca1d1a@kernel.org>
        <20231120104439.15bfdd09@kmaincent-XPS-13-7390>
        <20231120105255.cgbart5amkg4efaz@skbuf>
        <20231120121440.3274d44c@kmaincent-XPS-13-7390>
        <20231120120601.ondrhbkqpnaozl2q@skbuf>
        <20231120144929.3375317e@kmaincent-XPS-13-7390>
        <20231120142316.d2emoaqeej2pg4s3@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 16:23:16 +0200 Vladimir Oltean wrote:
> In previous email discussions, I was proposing to Jakub and you "what if
> we didn't let user space select a specific layer like PHY_TIMESTAMPING
> or MAC_TIMESTAMPING at all, but just select a specific phc_index as the
> provider of hardware timestamps"?

What about my use case of having a NIC which can stamp at a low rate
at the PHY (for PTP) and high rate at the DMA block (for congestion
control)? Both stamp points have the same PHC index.
