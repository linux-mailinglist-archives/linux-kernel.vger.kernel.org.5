Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D036C7F1910
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjKTQsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjKTQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:48:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F2393
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:48:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91183C433C7;
        Mon, 20 Nov 2023 16:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700498887;
        bh=ESh01jqSQWkTBYBeIvcosjdQy4FIhEmQsKnmw7vBqNw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fkyLtgYDEV2bf5laQJi0/RvJtLahfgLpzfonczwYtiUCKRzmqrG/k39dKN1XoF6sg
         Jc0PXqlhyKurmcq24L6vyVeoLsN9huxzhMQl+Zc1YeG7RbMhMzDTlt5NPof2kqVxHj
         keod2SkcB2wGqjre3HrbIJUkjBgoLc01pgh+dpEFg+V+AGK0ITO58tGLii9rPJvqAv
         eAEVJpvP668lMwaZiDRczWoa8tm+9fa1SsAsJVRQXoVD+8xnlNybSvj/83fc4Q7hCg
         PvGKf+gpB21QW70HQ1M0G5u3N9QokEAA15KNz/peCyxmn79Sh18Er6LMXJqWyE7h5A
         ID03DQ4dHFF0Q==
Date:   Mon, 20 Nov 2023 08:48:05 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
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
Subject: Re: [PATCH net-next v7 07/16] net_tstamp: Add TIMESTAMPING SOFTWARE
 and HARDWARE mask
Message-ID: <20231120084805.5f012a40@kernel.org>
In-Reply-To: <20231120100549.22c83bd0@kmaincent-XPS-13-7390>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
        <20231114-feature_ptp_netnext-v7-7-472e77951e40@bootlin.com>
        <20231118182247.638c0feb@kernel.org>
        <20231120100549.22c83bd0@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 10:05:49 +0100 K=C3=B6ry Maincent wrote:
> > Does this really need to be in uAPI? =20
>=20
> I have put it in the same place as SOF_TIMESTAMPING_* flags but indeed I =
am not
> sure ethtool would need it.
> I can move it to include/linux/net_tstamp.h and we will move back to uapi=
 if
> we see that it is necessary. What do you think?

include/linux/net_tstamp.h sounds better to me, Willem may disagree..
