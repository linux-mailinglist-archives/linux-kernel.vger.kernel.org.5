Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB75B7D1A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 03:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjJUBrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 21:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUBrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 21:47:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FFBD6C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 18:47:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE7EC433C7;
        Sat, 21 Oct 2023 01:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697852836;
        bh=aClrMzzQ6vcC0uIRuh6OiAn7D8pu4quUTjxdrHylDGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZnO42zON+eFtPVfDaAJLTbzxaoEkp0d+xqHseMQ1lAYfbybAfI+CVbPc7MhEd9B3R
         Vl+rvcwkJNWxAjxN8Qav8+st6JplEYZirV0pxrxBChr8Vi26GXUd1BWaUAchOTje4A
         aE1k/tlWvSsyvSTAHvKuLIbT9OUjdB4DFqEP5Z7cvCOj+S6aYhhMXcZZSwVMh+EEl/
         yeQlTPsK+sNRJWlLcqjC1A6HDCKOt65bpVk3RnUQKzebsUHqlWp8ZCiRiyvNpwo/Xx
         bH6+mG05LXn3x4lNDNk2VpiNRNPpjWdTkrJIVdR7ppSZxUrr2NbxvDrkSzMLi4N6gG
         WFRYEaa2TMMyQ==
Date:   Fri, 20 Oct 2023 18:47:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
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
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v6 12/16] net: Replace hwtstamp_source by
 timestamping layer
Message-ID: <20231020184714.3b3816fd@kernel.org>
In-Reply-To: <20231019-feature_ptp_netnext-v6-12-71affc27b0e5@bootlin.com>
References: <20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com>
        <20231019-feature_ptp_netnext-v6-12-71affc27b0e5@bootlin.com>
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

On Thu, 19 Oct 2023 16:29:27 +0200 Kory Maincent wrote:
> Replace hwtstamp_source which is only used by the kernel_hwtstamp_config
> structure by the more widely use timestamp_layer structure. This is done
> to prepare the support of selectable timestamping source.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Temporarily breaks the build :(

net/core/dev_ioctl.c:335:44: error: use of undeclared identifier 'NET_TIMESTAMPING'; did you mean 'NO_TIMESTAMPING'?
        cfg->source = phy_ts ? PHY_TIMESTAMPING : NET_TIMESTAMPING;
                                                  ^~~~~~~~~~~~~~~~
                                                  NO_TIMESTAMPING
include/uapi/linux/net_tstamp.h:18:2: note: 'NO_TIMESTAMPING' declared here
        NO_TIMESTAMPING,
        ^
-- 
pw-bot: cr
