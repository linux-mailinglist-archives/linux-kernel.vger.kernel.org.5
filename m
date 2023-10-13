Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81067C8B40
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjJMQcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjJMQbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:31:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FC5138
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:30:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB43FC433C7;
        Fri, 13 Oct 2023 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697214659;
        bh=UhsiyLWpL6PODRiDXR4L4zDoj2dJa8jOUZmaiu9xQhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A4On1qqi9cYF0h0xfOzqALiK7J8ty6wIJR7FhK0Mbn8GtYEwXnZB1WyTNgSI/goeM
         tAl5egrMh/qfmDRZD7ef+6TKTH9ODYM3/F97YXDBIqJZCLKwP5UPiAfBcHK3MNAQZS
         WmSYHua4BjFOOkYc9uKg6a+TfN06hU4HAIqqpjxsisp2u9Sk/QVGU7eEa7UrSH5VbD
         s7sRuR/Iz1hj1URMAVIjojCtHG3emblLfBvpmPRjCKdEhzrLDd0n290Uqe6dPKg1ce
         umrTGrZyjDNHtj0DL6D7TmGZuV3z0gm0jeJuI/Rc50P+syD80ZwiR9zMKXzwH9oKn/
         eE1WgQXlD96EA==
Date:   Fri, 13 Oct 2023 09:30:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231013093056.4f915df1@kernel.org>
In-Reply-To: <20231013161446.st7tlemyaj3ggkgk@skbuf>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
        <20231009155138.86458-9-kory.maincent@bootlin.com>
        <2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
        <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
        <20231013090020.34e9f125@kernel.org>
        <20231013161446.st7tlemyaj3ggkgk@skbuf>
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

On Fri, 13 Oct 2023 19:14:46 +0300 Vladimir Oltean wrote:
> > What is "PRECISION"? DMA is a separate block like MAC and PHY.  
> 
> If DMA is a separate block like MAC and PHY, can it have its own PHC
> device, and the ethtool UAPI only lists the timestamping-capable PHCs
> for one NIC, and is able to select between them? 

Possibly, I guess. There are some devices which use generic (i.e.
modeled by Linux as separate struct device) DMA controllers to read 
out packets from "MAC" FIFOs. In practice I'm not sure if any of those
DMA controllers has time stamping capabilities.

> Translation between the UAPI-visible PHC index and MAC, DMA, phylib
> PHY, other PHY etc can then be done by the kernel as needed.

Translation by the kernel at which point?

IMHO it'd indeed be clearer for the user to have an ability to read 
the PHC for SOF_..._DMA via ETHTOOL_MSG_TS_LIST_GET_REPLY as a separate
entry, rather than e.g. assume that DMA uses the same PHC as MAC.
