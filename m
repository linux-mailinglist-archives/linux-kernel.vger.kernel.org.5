Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AB37F6336
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346155AbjKWPmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjKWPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:42:32 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C20ED54;
        Thu, 23 Nov 2023 07:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1700754158; x=1732290158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=guZurlbG4ZmKDrecv6uyaxAN6HLRHdL0ODaQdkQw54g=;
  b=H6Az/NWgeG9eEcWG9PjQARMHbBVT8oufcy908lUrV8+TvrkYDRNpeLQt
   vskWTViDtcwUoBZXO6d/v9VhDgJ5yvI/fG1etuhZsBHR87pFP8ik8blyB
   Vd8DOAT0N7MpcaJ3Ore71gpsJktwD045kMHOBkrc30PteuQjTagQk9bQd
   d2jTpdwkAPYkyyhEbwMLTV7Cw65VYSfsiNC14Q1Q9rtjtY3yUUaYMLETk
   J4W9PKjyZUD3ov8+KsBFvAo8BnYz/uh50PtADUeBn+kGFoedBpsdm17/r
   HVCxGmSeX9Yn+rlu3kfipVzqmvl3qfSv/8/mb5d+b5eg9fVp9UK+S3mN2
   Q==;
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="34146565"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Nov 2023 16:42:36 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id F3ED2280075;
        Thu, 23 Nov 2023 16:42:35 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     netdev@vger.kernel.org, Heiko Schocher <heiko.schocher@gmail.com>,
        hs@denx.de
Cc:     Clark Wang <xiaoning.wang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed yet
Date:   Thu, 23 Nov 2023 16:42:35 +0100
Message-ID: <2305704.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <1af63dea-e333-cef7-2bc6-bbf4eb8c3881@denx.de>
References: <20231123132744.62519-1-hs@denx.de> <5992842.lOV4Wx5bFT@steina-w> <1af63dea-e333-cef7-2bc6-bbf4eb8c3881@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

Am Donnerstag, 23. November 2023, 16:26:18 CET schrieb Heiko Schocher:
> Hello Alexander,
>=20
> On 23.11.23 16:11, Alexander Stein wrote:
> > Hello Heiko,
> >=20
> > Am Donnerstag, 23. November 2023, 14:27:43 CET schrieb Heiko Schocher:
> >> it is possible that fec1 is probed before fec0. On SoCs
> >> with FEC_QUIRK_SINGLE_MDIO set (which means fec1 uses mii
> >> from fec0) init of mii fails for fec1 when fec0 is not yet
> >> probed, as fec0 setups mii bus. In this case fec_enet_mii_init
> >> for fec1 returns with -ENODEV, and so fec1 never comes up.
> >>=20
> >> Return here with -EPROBE_DEFER so interface gets later
> >> probed again.
> >>=20
> >> Found this on imx8qxp based board, using 2 ethernet interfaces,
> >> and from time to time, fec1 interface came not up.
> >=20
> > But FEC_QUIRK_SINGLE_MDIO is only set for imx28. How is this related to
> > imx8qxp?
>=20
> Ah, yes ... customer uses NXP based kernel there is:
>=20
>         /* board only enable one mii bus in default */
>         if (!of_get_property(np, "fsl,mii-exclusive", NULL))
>                 fep->quirks |=3D FEC_QUIRK_SINGLE_MDIO;
>=20
> which is missing in mainline... nevertheless patch fixes a problem
> with boards having quirk FEC_QUIRK_SINGLE_MDIO set.

But this seems wrong. Apparently fec driver fails if MDIO bus is not (yet)=
=20
available. But 'fsl,mii-exclusive' + FEC_QUIRK_SINGLE_MDIO assumes both=20
interfaces use fec, no? Will this work e.g. on imx8mp if the FEC PHY is=20
attached to STMMAC (EQOS) PHY?

> > Will this also help for imx6ul when fec1 is almost always probed before
> > fec0 due to order of DT nodes?
>=20
> Yep, I think so...  do you have the chance to test such a setup?

I have a board for that. But I'm not able to test at the moment.

Best regards,
Alexander

> bye,
> Heiko
>=20
> > Best regards,
> > Alexander
> >=20
> >> Signed-off-by: Heiko Schocher <hs@denx.de>
> >> ---
> >>=20
> >>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>=20
> >> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> >> b/drivers/net/ethernet/freescale/fec_main.c index
> >> c3b7694a7485..d956f95e7a65 100644
> >> --- a/drivers/net/ethernet/freescale/fec_main.c
> >> +++ b/drivers/net/ethernet/freescale/fec_main.c
> >> @@ -2445,7 +2445,7 @@ static int fec_enet_mii_init(struct platform_dev=
ice
> >> *pdev) mii_cnt++;
> >>=20
> >>  			return 0;
> >>  	=09
> >>  		}
> >>=20
> >> -		return -ENOENT;
> >> +		return -EPROBE_DEFER;
> >>=20
> >>  	}
> >>  =09
> >>  	bus_freq =3D 2500000; /* 2.5MHz by default */


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


