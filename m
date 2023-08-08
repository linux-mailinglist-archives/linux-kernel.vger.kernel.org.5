Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E41773CD3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjHHQJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjHHQIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8855769D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691509542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lr8QH1hJKMAeMGOo0M5b1qGrUuXmYrB7fQhjBLGi+k0=;
        b=hS8SmJzWdL1TtS4tCBU18Fi8JOWmwixfEOoH8fBeuCastwR9RwVUzpweEJ4CBzm3TjjGpV
        JgVoR6cARaf4puEcMTwdcNeeAsq/OsbJx1WzfXWgxvcgi3eVxBmMXSS92ytQmNEWrYc8DJ
        XhYcCiccot6kDlNNrJ49sCvIfF5Nvug=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-CxHyW0BJOBGYZvKLEVvoFQ-1; Tue, 08 Aug 2023 10:44:19 -0400
X-MC-Unique: CxHyW0BJOBGYZvKLEVvoFQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4100bd13cb7so19780961cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 07:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691505859; x=1692110659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr8QH1hJKMAeMGOo0M5b1qGrUuXmYrB7fQhjBLGi+k0=;
        b=CH0PrJTE5Gb4SbvITCMDwbC+6ANKKm8/0BdfAq1N+snTTdTL3u9ViQlZynhmuvdGxc
         88zveJlR4TiyT3ZyCCBi/wCPRx1hyNytS8RLqWL1LvClfklqMW7HWB4Ve9gkjQ0Gq48F
         cpCg2IPbBbwhjM5e52Da42UCMdFXDobGaTxxMwBYrKUgf7pCZa/pCwE3bxmIrPZOWx4d
         Fe6fsl9/thsHMk2lhwf48+txi1dT3fCOjcJJQtF8p8k3DwFJ5g/4je1l5ZF/WcONQGMX
         D1lo12B5WlhkjM72yiLRozqyn+gNdY7KNzfgC5Mmz9xbn7p/CkvPKdJBrUv3o9yt+I7n
         sO8A==
X-Gm-Message-State: AOJu0YyP9rMcm4OdHJnxpBlzgOXI2akSg86HgkxqG8G9HoKbXFiEJ0dW
        v/PIWNfifgToQTRGWZ8fxTF9IzhSiizt8yA+5IH7hs23gyYDfYMUBASzIebaKby4op45vdtgi2D
        186yNPkSJem48YT+3AlTj2WN8
X-Received: by 2002:ac8:5902:0:b0:40f:f44f:7f79 with SMTP id 2-20020ac85902000000b0040ff44f7f79mr2455qty.16.1691505859185;
        Tue, 08 Aug 2023 07:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4H/PhZU/WpPuHATF0/xjAxDvtaCGT5yE9Pf+IDINKw6+ypsWmrPVAHe6GEcDu06wD1x60qw==
X-Received: by 2002:ac8:5902:0:b0:40f:f44f:7f79 with SMTP id 2-20020ac85902000000b0040ff44f7f79mr2428qty.16.1691505858889;
        Tue, 08 Aug 2023 07:44:18 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id l5-20020ac84a85000000b0040fdf9a53e6sm3397095qtq.82.2023.08.08.07.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 07:44:18 -0700 (PDT)
Date:   Tue, 8 Aug 2023 09:44:16 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
Message-ID: <xfme5pgj4eqlgao3vmyg6vazaqk6qz2wq6kitgujtorouogjty@cklyof3xz2zm>
References: <20230807193102.6374-1-brgl@bgdev.pl>
 <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
 <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com>
 <ZNJChfKPkAuhzDCO@shell.armlinux.org.uk>
 <CAMRc=MczKgBFvuEanKu=mERYX-6qf7oUO2S4B53sPc+hrkYqxg@mail.gmail.com>
 <65b53003-23cf-40fa-b9d7-f0dbb45a4cb2@lunn.ch>
 <CAMRc=MecYHi=rPaT44kuX_XMog=uwB9imVZknSjnmTBW+fb5WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MecYHi=rPaT44kuX_XMog=uwB9imVZknSjnmTBW+fb5WQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 04:30:05PM +0200, Bartosz Golaszewski wrote:
> On Tue, Aug 8, 2023 at 4:25 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > On Tue, Aug 08, 2023 at 10:13:09AM +0200, Bartosz Golaszewski wrote:
> > > > > Ok so upon some further investigation, the actual culprit is in stmmac
> > > > > platform code - it always tries to register an MDIO bus - independent
> > > > > of whether there is an actual mdio child node - unless the MAC is
> > > > > marked explicitly as having a fixed-link.
> > > > >
> > > > > When I fixed that, MAC1's probe is correctly deferred until MAC0 has
> > > > > created the MDIO bus.
> > > > >
> > > > > Even so, isn't it useful to actually reference the shared MDIO bus in some way?
> > > > >
> > > > > If the schematics look something like this:
> > > > >
> > > > > --------           -------
> > > > > | MAC0 |--MDIO-----| PHY |
> > > > > -------- |     |   -------
> > > > >          |     |
> > > > > -------- |     |   -------
> > > > > | MAC1 |--     ----| PHY |
> > > > > --------           -------
> > > > >
> > > > > Then it would make sense to model it on the device tree?
> > > >
> > > > So I think what you're saying is that MAC0 and MAC1's have MDIO bus
> > > > masters, and the hardware designer decided to tie both together to
> > > > a single set of clock and data lines, which then go to two PHYs.
> > >
> > > The schematics I have are not very clear on that, but now that you
> > > mention this, it's most likely the case.
> >
> > I hope not. That would be very broken. As Russell pointed out, MDIO is
> > not multi-master. You need to check with the hardware designer if the
> > schematics are not clear.
> 
> Sorry, it was not very clear. It's the case that two MDIO masters
> share the MDC and data lines.

I'll make the water muddier (hopefully clearer?). I have access to the
board schematic (not SIP/SOM stuff though), but that should help here.

MAC0 owns its own MDIO bus (we'll call it MDIO0). It is pinmuxed to
gpio8/gpio9 for mdc/mdio. MAC1 owns its own bus (MDIO1) which is
pinmuxed to gpio21/22.

On MDIO0 there are two SGMII ethernet phys. One is connected to MAC0,
one is connected to MAC1.

MDIO1 is not connected to anything on the board. So there is only one
MDIO master, MAC0 on MDIO0, and it manages the ethernet phy for both
MAC0/MAC1.

Does that make sense? I don't think from a hardware design standpoint
this is violating anything, it isn't a multimaster setup on MDIO.

> 
> >
> > > Good point, but it's worse than that: when MAC0 is unbound, it will
> > > unregister the MDIO bus and destroy all PHY devices. These are not
> > > refcounted so they will literally go from under MAC1. Not sure how
> > > this can be dealt with?
> >
> > unbinding is not a normal operation. So i would just live with it, and
> > if root decides to shoot herself in the foot, that is her choice.
> >
> 
> I disagree. Unbinding is very much a normal operation. Less so for
> platform devices but still, it is there for a reason and should be
> expected to work correctly. Or at the very least not crash and burn
> the system.
> 
> On the other hand, I like your approach because I may get away without
> having to fix it. But if I were to fix it - I would reference the MDIO
> bus from the secondary mac by phandle and count its references before
> dropping it. :)
> 
> Bartosz
> 

