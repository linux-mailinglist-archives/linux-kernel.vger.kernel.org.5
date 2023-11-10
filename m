Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258087E7F93
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjKJR4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjKJRz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:28 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9772BE05;
        Fri, 10 Nov 2023 01:18:44 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BEDE2FF803;
        Fri, 10 Nov 2023 09:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699607923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlHs147ceVaFirZwP9qhanL87eStUsCEVWoYX0Pd7Pw=;
        b=WcN6uEqQTLiAg07Mww8Xh5wguLtukWcC1ATSbprEnegZPropbKOUss8DiJHoGmsJvQBpEI
        zyoZrTY/WSNPOwcVUyEApnCxqYU3O1WpHqBni9wTioYN8nNwT50hm6ooD0A/P0ZiuSz2zW
        +tUJlWFOymHBmdii+dH/kzSUpysOob9N6ugznEBd1m/GXe2TXP+QPtwlWWyPJtCrKR+qvL
        JeMA+j07lGMHEPap/tJo4LYlAt8zDwy/HK7eDPcr6GzATnFKEA5/5BMifUEOclER4I+2YJ
        iC/sI4oItUB8DxR9KMjus/qAjn/R8eCtHEE0czSfgbXJZB5ZqTBtHmH/rK6jAw==
Date:   Fri, 10 Nov 2023 10:18:41 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy
 support
Message-ID: <20231110101841.27aba547@fedora>
In-Reply-To: <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
        <20231108113445.24825-2-quic_luoj@quicinc.com>
        <20231108131250.66d1c236@fedora>
        <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
        <20231109101618.009efb45@fedora>
        <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2023 16:53:39 +0800
Jie Luo <quic_luoj@quicinc.com> wrote:

> On 11/9/2023 5:16 PM, Maxime Chevallier wrote:
> > Hello,
> >=20
> > On Thu, 9 Nov 2023 16:32:36 +0800
> > Jie Luo <quic_luoj@quicinc.com> wrote:
> >=20
> > [...]
> >  =20
> >>> What I understand from this is that this PHY can be used either as a
> >>> switch, in which case port 4 would be connected to the host interface
> >>> at up to 2.5G, or as a quad-phy, but since it uses QUSGMII the link
> >>> speed would be limited to 1G per-port, is that correct ? =20
> >>
> >> When the PHY works on the interface mode QUSGMII for quad-phy, all 4
> >> PHYs can support to the max link speed 2.5G, actually the PHY can
> >> support to max link speed 2.5G for all supported interface modes
> >> including qusgmii and sgmii. =20
> >=20
> > I'm a bit confused then, as the USGMII spec says that Quad USGMII really
> > is for quad 10/100/1000 speeds, using 10b/8b encoding.
> >=20
> > Aren't you using the USXGMII mode instead, which can convey 4 x 2.5Gbps
> >   with 66b/64b encoding ?
> >=20
> > Thanks,
> >=20
> > Maxime =20
>=20
> Hi Maxime,
> Yes, for quad PHY mode, it is using 66b/64 encoding.
>=20
> it seems that PHY_INTERFACE_MODE_USXGMII is for single port,
> so i take the interface name PHY_INTERFACE_MODE_QUSGMII for
> quad PHYs here.

I see, when I added the QUSGMII mode I wrongly stated that it came from
the USXGMII spec where it really comes from USGMII, my bad.

> can we apply PHY_INTERFACE_MODE_USXGMII to quad PHYs in this
> case(qca8084 quad PHY mode)?

=46rom what I can see, the USXGMII mode in the kernel is used as the
single-port 10G mode of usxgmii. You might need to create a new mode
for quad usxgmii at 10G, the spec calls it 10G-QXGMII I think, but as
the spec defines quite a lot of modes, should we define all of them or
rely on some other parameters to select the actual mode ?

Andrew, Heiner, Russell, what do you think ?

Maxime

> Thanks,
> Jie.

