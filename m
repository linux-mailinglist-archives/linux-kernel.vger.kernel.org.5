Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7297F3528
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjKURoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjKURoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:44:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFF2112
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:43:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5D5C433C8;
        Tue, 21 Nov 2023 17:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700588636;
        bh=gnUMTK1bw92CwGDuRlTgAm7doJIPoMNyCa9J3hZFk0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FqJwICL1kBDQbIlpNtsh2Lh4TokSiyA5IgHA48yDVQ5hkl4QG4EHxS0/3CnDESTZo
         eKUruDuuPsWMn7lBqgiR8ymZBEUyHfs4uhGLeovjKR12R/orFIU379hlSmce0jB1So
         owbsZstA5xYQu26HlHm1dSmGs7dNcYNbFvN8EZ12wuZ2JzI5YsNiMW96M84PZP7RVH
         d1YeJkqalRcdS4LfnzOUF2kPaE/9uP4bW7jDl6tkiOyZcLf+3DTvZDkViceFDI7+wC
         y6/TVZ9BmwA/mKO4zs17YfNmLBMDu0K7OLddMQZOvsj/izW2477J0qV+Ttlo2XsKnD
         hf66KY4LtQUhQ==
Date:   Tue, 21 Nov 2023 09:43:54 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
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
Message-ID: <20231121094354.635ee8cd@kernel.org>
In-Reply-To: <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
References: <20231120105255.cgbart5amkg4efaz@skbuf>
        <20231120121440.3274d44c@kmaincent-XPS-13-7390>
        <20231120120601.ondrhbkqpnaozl2q@skbuf>
        <20231120144929.3375317e@kmaincent-XPS-13-7390>
        <20231120142316.d2emoaqeej2pg4s3@skbuf>
        <20231120093723.4d88fb2a@kernel.org>
        <20231120190023.ymog4yb2hcydhmua@skbuf>
        <20231120115839.74ee5492@kernel.org>
        <20231120211759.j5uvijsrgt2jqtwx@skbuf>
        <20231120133737.70dde657@kernel.org>
        <20231120220549.cvsz2ni3wj7mcukh@skbuf>
        <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
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

On Tue, 21 Nov 2023 18:31:14 +0100 K=C3=B6ry Maincent wrote:
> - Expand struct hwtstamp_config with a phc_index member for the SIOCG/SHW=
TSTAMP
>   commands.
>   To keep backward compatibility if phc_index is not set in the hwtstamp_=
config
>   data from userspace use the default hwtstamp (the default being selecte=
d as
>   done in my patch series).
>   Is this possible, would it breaks things?

I'd skip this bit, and focus on the ETHTOOL_TSINFO. Keep the ioctl as
"legacy" and do all the extensions in ethtool. TSINFO_GET can serve
as GET, to avoid adding 3rd command for the same thing. TSINFO_SET
would be new (as you indicate below).

> - In netlink part, send one netlink tsinfo skb for each phc_index.

phc_index and netdev combination. A DO command can only generate one
answer (or rather, it should generate only one answer, there are few
hard rules in netlink). So we need to move that functionality to DUMP.
We can filter the DUMP based on user-provided ifindex and/or phc_index.

> Could be done in a later patch series:
> - Expand netlink TSINFO with ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER_QUALIFIER.
>   Describing this struct:
> enum ethtool_hwstamp_provider_qualifier {
>  	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_PRECISE,
>  	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_APPROX,
> };=20
>=20
>   Set the desired qualifier through TSINFO_SET or through SIOCSHWTSTAMP by
>   expanding again the struct hwtstamp_config.
>=20
> Do you think this is feasible?
