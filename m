Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28CD7F6265
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346005AbjKWPLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjKWPLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:11:39 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4328ED41;
        Thu, 23 Nov 2023 07:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1700752303; x=1732288303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vCSREdmF12ciPak77XKfEYKvFPyB+qsBWRT/VsT3I0Q=;
  b=ldaRZ7HMIdDD20NNTPBtwZjx1uGRuPwaVblZqBnYA4pT8cEI6hj4R9Db
   VyfDkO252wG+gppwYM0X7gBTG41w8Uu4kPdpKAg4EwwKjX3Fnj74v4ts0
   c0caHSWmnPXIsqlxEHd2Zl30K/aoJ9T9YNG3oG9hKKmygOEpnH1XWluQr
   UsoToHGwSFjrDVu/l0Ttp3KqDgL94JJwf80BigM2WXmdzIvfCZxiWMXdy
   qjMyU9w1bbEwFt9DkIa+TxoXJeupKWLK7cAdbpGy9v5L5sP6RpwyO33gd
   QQ8LmHmIzw/NQJYOCw3MP1RwCHlzfmci8g3SmQf+d6p+01QPjes2Zo32y
   w==;
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="34146043"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Nov 2023 16:11:41 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 119CF280075;
        Thu, 23 Nov 2023 16:11:41 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     netdev@vger.kernel.org, Heiko Schocher <heiko.schocher@gmail.com>
Cc:     Heiko Schocher <hs@denx.de>, Clark Wang <xiaoning.wang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed yet
Date:   Thu, 23 Nov 2023 16:11:40 +0100
Message-ID: <5992842.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231123132744.62519-1-hs@denx.de>
References: <20231123132744.62519-1-hs@denx.de>
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

Am Donnerstag, 23. November 2023, 14:27:43 CET schrieb Heiko Schocher:
> it is possible that fec1 is probed before fec0. On SoCs
> with FEC_QUIRK_SINGLE_MDIO set (which means fec1 uses mii
> from fec0) init of mii fails for fec1 when fec0 is not yet
> probed, as fec0 setups mii bus. In this case fec_enet_mii_init
> for fec1 returns with -ENODEV, and so fec1 never comes up.
>=20
> Return here with -EPROBE_DEFER so interface gets later
> probed again.
>=20
> Found this on imx8qxp based board, using 2 ethernet interfaces,
> and from time to time, fec1 interface came not up.

But FEC_QUIRK_SINGLE_MDIO is only set for imx28. How is this related to=20
imx8qxp?
Will this also help for imx6ul when fec1 is almost always probed before fec=
0=20
due to order of DT nodes?

Best regards,
Alexander

> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
>=20
>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c index
> c3b7694a7485..d956f95e7a65 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -2445,7 +2445,7 @@ static int fec_enet_mii_init(struct platform_device
> *pdev) mii_cnt++;
>  			return 0;
>  		}
> -		return -ENOENT;
> +		return -EPROBE_DEFER;
>  	}
>=20
>  	bus_freq =3D 2500000; /* 2.5MHz by default */


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


