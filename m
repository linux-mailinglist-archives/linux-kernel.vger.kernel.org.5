Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AAE7F4983
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjKVO5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjKVO5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:57:18 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E736B92;
        Wed, 22 Nov 2023 06:57:13 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CD9560002;
        Wed, 22 Nov 2023 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700665032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEmwuFGNOf1bLX/AP2CQhltFnx9imN/bGp+B001wyFc=;
        b=ElUVf52+FchZK9prPh2LVDQqZW0Ix2vq0JlPDM4xdIBS3a1EDetBne4DdPi/RKcwRE07or
        C9YF0b50dr9OEphHo+C+IXAyMas6tlttgDBCy6ISi4afmig70QBAhuF0eU4CdfZmioEXt7
        JHWkE+xbi+C88fj9hqdXM0UNFBM1+se39k19ivP+skbjYJnmGuC5P1DtXHPmC1P5tAQuBb
        xrzB4YpByNNqtpr189vM5jvTSn8yP2gUxeFDA0cErXvhIm/b3wPkB+ton6e9TvoLaWDWcI
        Epxw2kliGN2Xt78nFdhbP8Ca67rIYUmRC03pitURVM6HGj0h35VouZkhBDEQuA==
Date:   Wed, 22 Nov 2023 15:57:09 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <20231122155709.70f0d70a@kmaincent-XPS-13-7390>
In-Reply-To: <20231122140850.li2mvf6tpo3f2fhh@skbuf>
References: <20231120142316.d2emoaqeej2pg4s3@skbuf>
 <20231120093723.4d88fb2a@kernel.org>
 <20231120190023.ymog4yb2hcydhmua@skbuf>
 <20231120115839.74ee5492@kernel.org>
 <20231120211759.j5uvijsrgt2jqtwx@skbuf>
 <20231120133737.70dde657@kernel.org>
 <20231120220549.cvsz2ni3wj7mcukh@skbuf>
 <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
 <20231121094354.635ee8cd@kernel.org>
 <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
 <20231122140850.li2mvf6tpo3f2fhh@skbuf>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 16:08:50 +0200
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> On Wed, Nov 22, 2023 at 02:44:53PM +0100, K=C3=B6ry Maincent wrote:
> > On Tue, 21 Nov 2023 09:43:54 -0800
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >  =20
> > > On Tue, 21 Nov 2023 18:31:14 +0100 K=C3=B6ry Maincent wrote: =20
> > > > - Expand struct hwtstamp_config with a phc_index member for the
> > > > SIOCG/SHWTSTAMP commands.
> > > >   To keep backward compatibility if phc_index is not set in the
> > > > hwtstamp_config data from userspace use the default hwtstamp (the
> > > > default being selected as done in my patch series).
> > > >   Is this possible, would it breaks things?   =20
> > >=20
> > > I'd skip this bit, and focus on the ETHTOOL_TSINFO. Keep the ioctl as
> > > "legacy" and do all the extensions in ethtool. TSINFO_GET can serve
> > > as GET, to avoid adding 3rd command for the same thing. TSINFO_SET
> > > would be new (as you indicate below). =20
> >=20
> > You say this patch series should simply add TSINFO_SET command to set t=
he
> > current phc_index?
> >=20
> > It won't solve your requirement of having simultaneous hwtimestamp and
> > enabling/disabling them through rx_filter and tx_types.
> > You want to do this in another patch series alongside a new
> > SIOCG/SHWTSTAMP_2 ABI?
> >  =20
> > > > - In netlink part, send one netlink tsinfo skb for each phc_index. =
  =20
> > >=20
> > > phc_index and netdev combination. A DO command can only generate one
> > > answer (or rather, it should generate only one answer, there are few
> > > hard rules in netlink). So we need to move that functionality to DUMP.
> > > We can filter the DUMP based on user-provided ifindex and/or phc_inde=
x. =20
> >=20
> > Currently, the dumpit function is assigned to ethnl_default_dumpit. Wou=
ldn't
> > the behavior change of the dumpit callback break the ABI?
> >=20
> >  =20
> > > > Could be done in a later patch series:
> > > > - Expand netlink TSINFO with
> > > > ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER_QUALIFIER. Describing this struct:
> > > > enum ethtool_hwstamp_provider_qualifier {
> > > >  	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_PRECISE,
> > > >  	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_APPROX,
> > > > };=20
> > > >=20
> > > >   Set the desired qualifier through TSINFO_SET or through SIOCSHWTS=
TAMP
> > > > by expanding again the struct hwtstamp_config. =20
> >=20
> > Just wondering to have a insight of future support, in the case of seve=
ral
> > provider qualifier and the SIOCG/SHWTSTAMP_2 layout containing the
> > phc_index. Will we be able to talk to the two providers qualifiers
> > simultaneously or is it not possible. To know if the SIOCG/SHWTSTAMP_2
> > layout would contain the description of the qualifier provider.
> > If I understand well your mail in the thread it will be the case right?

> My understanding of Jakub's email was that he wants to see the functional=
ity
> offered by SIOCGHWTSTAMP and SIOCSHWTSTAMP converted to netlink. I don't
> think that ethtool is the correct netlink family for that, given that
> these aren't ethtool ioctls to begin with. Maybe the new netdev netlink
> family. The conversion in its basic form would offer exactly the same
> functionality. The extended netlink messages would have extra attributes
> to identify the targeted hwtstamp provider. In the lack of those
> attributes, the default hwtstamp provider is targeted. The definition of
> the default hwtstamp provider should be as per your current patch set
> (netdev, with a whitelist for current phylib PHYs).
>=20
> The _listing_ of hwtstamp providers is what could be done through ethtool
> netlink, similar but not identical to the way in which you are proposing
> today (you are presenting blanket "layers" which correspond to netdev and
> phylib, rather than individual providers).
>=20
> The concept of an "active phc_index" would not explicitly exist in the
> UAPI. Thus I'm not sure what's with this TSINFO_SET being floated around.
> The only thing would exist is a configurable rx_filter and tx_type per
> hwtstamp provider (aka "{phc_index, qualifier}"). User space will have
> to learn to select the hwtstamp provider it wants to configure through
> netlink, and use for its class of traffic.
>=20
> This is why I mentioned by ndo_hwtstamp_set() conversion, because
> suddenly it is a prerequisite for any further progress to be done.
> You can't convert SIOCSHWTSTAMP to netlink if there are some driver
> implementations which still use ndo_eth_ioctl(). They need to be
> UAPI-agnostic.
>=20
> I'm not sure what's with Richard's mention of the "_2" variants of the
> ioctls. Probably a low-effort suggestion which was a bit out of context.
> His main point, that you cannot extend struct hwtstamp_config as that
> has a fixed binary format, is perfectly valid though. This is why
> netlink is preferable, because if done correctly (meaning not with
> NLA_BINARY attributes), then it is much more extensible because all
> attributes are TLVs. Use NLA_BINARY, and you will run into the exact
> extensibility issues that the ioctl interface has.

I appreciate the clarification, it now makes more sense to me.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
