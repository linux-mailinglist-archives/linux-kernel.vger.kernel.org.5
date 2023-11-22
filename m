Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7D67F480F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343993AbjKVNpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343568AbjKVNpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:45:04 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B2DD54;
        Wed, 22 Nov 2023 05:44:58 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A59D71BF206;
        Wed, 22 Nov 2023 13:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700660697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HYGwltdt7UObW6m6TQ25cKM4YubrRmxjcFZzyasRZoE=;
        b=Azq5OYesRze4Ajgq1X2y6Rlqfe3W2ZoOlUQoeG1wJLotR/9VVFNBphuxj42UDzVKdrXQjy
        9J56sFXmNMc9wrx+YEcpbHSJiQgwOUd8F4JQNU7O4bHRX+dVDUdasgfDd9O0H7T3M1b3Dn
        K1a5pXmttrk+jp6YLCwnw22xH011ECFtj7Ah0XLyEp0smrxan4YDdibKh58B9zfFOhGCXO
        mJAfGFHLGMD0V+oBvkyldD3GciM/GRX5qSWa+eoCX3B8ffXDl6QKceKhcXUbQ1DqzfyrED
        kt7Va5FGV08YXUCT1hF6KvShuTAQac8lU1ANUKXuTvN78G8FPCeCM3bZmnN5Ng==
Date:   Wed, 22 Nov 2023 14:44:53 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
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
Message-ID: <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
In-Reply-To: <20231121094354.635ee8cd@kernel.org>
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
        <20231121094354.635ee8cd@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 09:43:54 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 21 Nov 2023 18:31:14 +0100 K=C3=B6ry Maincent wrote:
> > - Expand struct hwtstamp_config with a phc_index member for the
> > SIOCG/SHWTSTAMP commands.
> >   To keep backward compatibility if phc_index is not set in the
> > hwtstamp_config data from userspace use the default hwtstamp (the defau=
lt
> > being selected as done in my patch series).
> >   Is this possible, would it breaks things? =20
>=20
> I'd skip this bit, and focus on the ETHTOOL_TSINFO. Keep the ioctl as
> "legacy" and do all the extensions in ethtool. TSINFO_GET can serve
> as GET, to avoid adding 3rd command for the same thing. TSINFO_SET
> would be new (as you indicate below).

You say this patch series should simply add TSINFO_SET command to set the
current phc_index?

It won't solve your requirement of having simultaneous hwtimestamp and
enabling/disabling them through rx_filter and tx_types.
You want to do this in another patch series alongside a new SIOCG/SHWTSTAMP=
_2
ABI?

> > - In netlink part, send one netlink tsinfo skb for each phc_index. =20
>=20
> phc_index and netdev combination. A DO command can only generate one
> answer (or rather, it should generate only one answer, there are few
> hard rules in netlink). So we need to move that functionality to DUMP.
> We can filter the DUMP based on user-provided ifindex and/or phc_index.

Currently, the dumpit function is assigned to ethnl_default_dumpit. Wouldn't
the behavior change of the dumpit callback break the ABI?


> > Could be done in a later patch series:
> > - Expand netlink TSINFO with ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER_QUALIFIE=
R.
> >   Describing this struct:
> > enum ethtool_hwstamp_provider_qualifier {
> >  	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_PRECISE,
> >  	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_APPROX,
> > };=20
> >=20
> >   Set the desired qualifier through TSINFO_SET or through SIOCSHWTSTAMP=
 by
> >   expanding again the struct hwtstamp_config.

Just wondering to have a insight of future support, in the case of several
provider qualifier and the SIOCG/SHWTSTAMP_2 layout containing the phc_inde=
x.
Will we be able to talk to the two providers qualifiers simultaneously or i=
s it
not possible. To know if the SIOCG/SHWTSTAMP_2 layout would contain the
description of the qualifier provider.
If I understand well your mail in the thread it will be the case right?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
