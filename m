Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D22754A0F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjGOQNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGOQNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C0B10E9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689437537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dF7OtGXMRje1f7jke9Bs430OqzMpDW752u+Jth/n5k0=;
        b=Ff2hFNfBeB9d3mdbB1FwC/CZ/bceqnlLGmuiTOjZIbG37ZvjxYzTI4gsxTo+Ib9F8yilyx
        w0BUWtsKmbyMO1IFiKp117jc7QySbmubpTy0PT25bE/T2LL5Dzb/dhk8Lv9Y98ybTd/hmB
        8z7UnIPBfOn3+OnFsXmHCijmdXuM5fM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-knj39gZ2Ok-A6Racr_0rUA-1; Sat, 15 Jul 2023 12:12:15 -0400
X-MC-Unique: knj39gZ2Ok-A6Racr_0rUA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbdde92299so15532875e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 09:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689437534; x=1692029534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF7OtGXMRje1f7jke9Bs430OqzMpDW752u+Jth/n5k0=;
        b=iXNRIs6u/jd9yA5d7b2kHmcxQTVQp68ebt3s25C5iNo/hVyxkMuU5CQgoCxnuSBpMQ
         ijO0vHY5mmxVq4bertyIbsIYRFJ7a7pE3FsSm8IoNg+HKJTZFnVrSdm6zUu978B0FeXX
         xTZvOpAnzMsv3pgTUySNoCa8CX3R8A+ZxURt0MUDHH2CTDDu2yql6KygWtfVWoilsSvB
         UWmsvneIEcoIsGrkkCRcgAEJfQxCQqhr4A9su0ASNyV9RLl6DawMFLLcdcuFktnUIbtc
         xY8fEATPdfhC9MglmXK2+utk9siVPtiLGizNG5Zb6Z2cxhHKtVuiojud3unpJw9eQNWe
         PaWw==
X-Gm-Message-State: ABy/qLbXapnJBYsZid/B26zToZEWMiUdy91sXT+uGpRsKikZoeAViMSk
        dYNqsSJzMSrXx07QBhIARIQjA30G9LHT5QqiUoOF2sm/j1+oJquPjRXUOM6qLriHNZMsASpxQlN
        T0qorRDOQ3PHXgEnPG902joOz
X-Received: by 2002:a7b:cd96:0:b0:3fc:10:b25b with SMTP id y22-20020a7bcd96000000b003fc0010b25bmr6623437wmj.21.1689437534442;
        Sat, 15 Jul 2023 09:12:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFpxpfSQFWVxs5xId56kuqovmHBkCRVcENJq+und24xVDDj0feG9wpZsKiSMo/jJvMcazXpMg==
X-Received: by 2002:a7b:cd96:0:b0:3fc:10:b25b with SMTP id y22-20020a7bcd96000000b003fc0010b25bmr6623408wmj.21.1689437534192;
        Sat, 15 Jul 2023 09:12:14 -0700 (PDT)
Received: from localhost (net-130-25-106-149.cust.vodafonedsl.it. [130.25.106.149])
        by smtp.gmail.com with ESMTPSA id y17-20020a1c4b11000000b003fb739d27aesm3922717wma.35.2023.07.15.09.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 09:12:13 -0700 (PDT)
Date:   Sat, 15 Jul 2023 18:12:11 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Ungerer <gerg@kernel.org>
Subject: Re: [PATCH v2 net-next 3/9] net: ethernet: mtk_eth_soc: add
 MTK_NETSYS_V1 capability bit
Message-ID: <ZLLFWyr5LbeB/Px1@lore-desk>
References: <cover.1689012506.git.daniel@makrotopia.org>
 <a2022fd2db0f7ed54ab07bb93b04aa9fc59033b5.1689012506.git.daniel@makrotopia.org>
 <ZK+ibBKWFRniQ8rK@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yB+7pERcjQZkUudn"
Content-Disposition: inline
In-Reply-To: <ZK+ibBKWFRniQ8rK@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yB+7pERcjQZkUudn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jul 13, 2023 at 03:18:23AM +0100, Daniel Golle wrote:
> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> >=20
> > Introduce MTK_NETSYS_V1 bit in the device capabilities for
> > MT7621/MT7622/MT7623/MT7628/MT7629 SoCs.
> > Use !MTK_NETSYS_V1 instead of MTK_NETSYS_V2 in the driver codebase.
> > This is a preliminary patch to introduce support for MT7988 SoC.
>=20
> Rather than using capability bits for versions, would it make more
> sense to use an integer for this, so you can do:
>=20
> 	if (eth->soc->netsys_version >=3D 2) {
> 		version 2 and later stuff
> 	} else {
> 		previous version stuff
> 	}
>=20
> ?
>=20
> I'm just thinking ahead to when we end up with stuff that v1 and v2
> need but v3 and later don't.

ack, I will fix it.

Regards,
Lorenzo

>=20
> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>=20

--yB+7pERcjQZkUudn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZLLFWwAKCRA6cBh0uS2t
rBvlAQDy03bEQ4loaAkQrbJsOLuS7fpBgSkRYBHq+v1STiH+dwEAhaatBwH6Dv5n
6nKwAO3GR06rfY1eFCm7uJkttIs/XwM=
=TLpK
-----END PGP SIGNATURE-----

--yB+7pERcjQZkUudn--

