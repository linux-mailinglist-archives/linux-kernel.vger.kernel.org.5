Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941E4798A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244531AbjIHPqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbjIHPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:46:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346ED1FC4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:46:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085BBC433C9;
        Fri,  8 Sep 2023 15:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694187972;
        bh=VNbazyRE370gNZi/pHSUlpmXcMceT96Fm7hfdqN6qm0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W+NDGlJV7b50NBiPVfSJUusyYpzLVAcE2elkubEwzBbLd6BTsm4n2noLzVcIJDinM
         8N/F1KIUkj8eKSRy5mAXBRcBqE5Mrx1/IF65g+6x0vf8xUQI+VX2lSX1Syaiw0EKIE
         Ca+fUBcUOFFlwmmMk1BUy7B/LghUxcD9rum750l3LwylSlqzQkQaPv+EncszfZxLo1
         vfp12Bygewy/qQnhG8vMxwWEvRbmFoVvRpadgV9pu5RCl3yAFYuoMgNDbeSnziYQV2
         4ZjTUgjo6Gih931sjhnKHwtsu8r/CyUwlAJi99zK5p5HgzB4IEibQWI5AyEFFR3eY5
         CkfZjTt472MBg==
Date:   Fri, 8 Sep 2023 08:46:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 6/7] net: ethtool: add a netlink command to
 get PHY information
Message-ID: <20230908084606.5707e1b1@kernel.org>
In-Reply-To: <20230907092407.647139-7-maxime.chevallier@bootlin.com>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
        <20230907092407.647139-7-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Sep 2023 11:24:04 +0200 Maxime Chevallier wrote:
>  	ETHTOOL_MSG_PHY_LIST_GET,
> +	ETHTOOL_MSG_PHY_GET,

The distinction between LIST_GET and GET is a bit odd for netlink.
GET has a do and a dump. The dump is effectively LIST_GET.

The dump can accept filtering arguments, like ifindex, if you want 
to narrow down the results, that's perfectly fine (you may need to
give up some of the built-in ethtool scaffolding, but it shouldn't 
be all that bad).
