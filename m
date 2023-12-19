Return-Path: <linux-kernel+bounces-5557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B31818C32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824F8287D62
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6DA1DA54;
	Tue, 19 Dec 2023 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieGaMAQD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22D1F605;
	Tue, 19 Dec 2023 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a1915034144so552564266b.0;
        Tue, 19 Dec 2023 08:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703003287; x=1703608087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5A2uKEheZ7E6+Gx3ENGsEnMLTERDeCTHi0P6ZhpItmE=;
        b=ieGaMAQDJx1NeeP/jxXXEkzaOEHYlc1vM32nIjahFGl9iEsb4T2tJUXbo72MhCwROh
         gUa9eZeRzFIeZ1M7swzVKIWjasKw2rZofMZvD4arywStGuaDTcra5vNSmlsfmxEC2JgI
         hvVyAxUj9bo4G4mQlfDgvaxsetNw0NIhy1Hp+NSaFbsvm8lAiskUhcCKlzt/FK1WQdBv
         3thct9vpS5OWQ0ZveFu1LFBZMynp7Ljkn5BxP+6NGPsMfo7q+gaI8d8yFNuEXHQufV9L
         /8b5dzWnWWN3TAByJqmljt3hwhJJaJ32UXqlgxOML+VgxOOPAYmzQ8pbvvo9qfzou/qQ
         lnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703003287; x=1703608087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5A2uKEheZ7E6+Gx3ENGsEnMLTERDeCTHi0P6ZhpItmE=;
        b=j73uuqErGpUooxYn/bH+V/1LD4Fd4aiB1HAGe0Ge8OtD4Eyr1gS/C+fm/0TQycJrxS
         3JnUH71gMmJmBnp35t38gmh9GurfKtnlplswi18ALJk1wmmic8Z6R9qJqP8oeCsduFoC
         GJP1iSLJGRHVxdCW2ts+WgSRVcjmibpWwz72KBXC6G3gowYgr1UfQ5qddfptEMVdcj2g
         q4uB9TIoqDR4cr0Ish51tNUxWooROqfYGDMCUSfoGAFVU0cakr5ChUAH7eZtOnfIZEX1
         Ildkxf/4pIqJvp+WswOIyJSgFv4EXYYmfbytj/ddIRWiFE9OM+uQT3Hh3vvtymoF+hj7
         OLmw==
X-Gm-Message-State: AOJu0YwxLLxjlgXZ5Vw7qT4UKB0qepJma22ZkS1n7e4VA1kb+bjqOkCz
	s704nXUO6vZluqxpOf+ryvs=
X-Google-Smtp-Source: AGHT+IF8//j/NsDS1bDOy5SJbtYNxLhpqbC9NTYmHThfGbnA9oFEXqsg+VrfR1MhyrcvnvVmOT89Xw==
X-Received: by 2002:a17:906:b299:b0:a26:85bb:6355 with SMTP id q25-20020a170906b29900b00a2685bb6355mr425523ejz.77.1703003286811;
        Tue, 19 Dec 2023 08:28:06 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id l17-20020a170906a41100b00a236eb66b2fsm1333363ejz.82.2023.12.19.08.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:28:06 -0800 (PST)
Date: Tue, 19 Dec 2023 18:28:03 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	openbmc@lists.ozlabs.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/16] net: pcs: xpcs: Avoid creating dummy XPCS
 MDIO device
Message-ID: <20231219162803.kmb3jb6aevef3kj3@skbuf>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <20231205115234.7ntjvymurot5nnak@skbuf>
 <wnptneaxxe2tq2rf7ac6a72xtyluyggughvmtxbbg5qto64mpa@7gchl5e4qllu>
 <jlcyqvcw5hsjtmvf77sm7qni6tzihxudo6baoq7wi7zgqx3lvs@ykbsxgmjkvnf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jlcyqvcw5hsjtmvf77sm7qni6tzihxudo6baoq7wi7zgqx3lvs@ykbsxgmjkvnf>

On Tue, Dec 19, 2023 at 06:48:09PM +0300, Serge Semin wrote:
> > > Sorry, because the commit log lost me at the "context presentation" stage,
> > > I failed to understand the "what"s and the "why"s.
> > > 
> > > Are you basically trying to add xpcs support on top of an mdio_device
> > > where the mdio_device_create() call was made externally to the xpcs code,
> > > through mdiobus_register_board_info() and mdiobus_setup_mdiodev_from_board_info()?
> > 
> > Basically yes, but there is more of it. The main idea is to convert
> > the XPCS driver to using the already created non-PHY MDIO-devices
> > instead of manually creating a 'dummy'/'redundant' one. From my point
> > of view there are several reasons of doing so:
> > 
> > 1. mdiobus_register_board_info() provides a way to assign the device
> > platform data to being registered afterwards device. Thus we can pass
> > some custom data to the XPCS-device driver (whether it's just an
> > xpcs_create_*() call or a fully functional MDIO-device driver
> > registered by the mdio_driver_register() method). For instance it can
> > be utilized to drop the fake PHYSIDs implementation from
> > drivers/net/dsa/sja1105/sja1105_mdio.c .

Ok. Seeing an alternative to the NXP_SJA1110_XPCS_ID hack will be interesting.

FWIW, I'm looking at reworking the dsa_loop probing to use software nodes.
Since dsa_loop is the only current user of mdiobus_register_board_info(),
maybe that will lead to its deletion. It appears a matter of timing, but
the mechanism looks promising.

Maybe we can also use it somehow to add compatibility with existing
lynx-pcs device trees where there is no compatible string, so a struct
phy_device gets created. Device tree breakage was the fundamental reason
why Sean Anderson's patch set couldn't make forward progress.
https://patchwork.kernel.org/project/netdevbpf/cover/20221103210650.2325784-1-sean.anderson@seco.com/

> > 2. The MDIO-devices actually registered on the MDIO-bus will be
> > visible in sysfs with for instance useful IO statistics provided by
> > the MDIO-bus. Potentially (if it is required) at some point we'll be
> > able to convert the DW XPCS driver to being true MDIO-device driver
> > (bindable to the DW XPCS device) with less efforts.

Ok.

> > 3. Having an MDIO-device registered that way would make the DW XPCS
> > IO-device implementation unified after the fwnode-based XPCS
> > descriptor creation support is added in one of the subsequent patches.

Unified how? You mean that "XPCS will always operate as a driver bound
to an mdio_device"?

You're not planning to unify the mdio_device and MMIO register handling
by using regmap, right?

> > So based on the listed above I've got a question. Do you think all of
> > that is worth to be implemented? Andrew, Russell?
> > 
> > I am asking because the patchset advance depends on your answers. If
> > you do I'll need to fix the problem described in my first message,
> > implement some new mdiobus_register_board_info()-like but
> > MDIO-bus-specific interface function (so MDIO-device infos would be
> > attached to the allocated MDIO-bus and then used to register the
> > respective MDIO-devices on the MDIO-bus registration), then convert
> > the sja1105 and wangxun txgbe drivers to using it. If you don't I'll
> > get back the xpcs_create_mdiodev() implementation and just provide a
> > fwnode-based version of one.
> 
> Folks, this is the only issue left to settle so I could move on with
> the series fixing up. So the question is: taking my comment above into
> account is it worth to convert the xpcs_create_mdiodev() method to
> re-using the already registered MDIO-device instance instead of
> always creating a stub-like MDIO-device?

I can't exactly say "yes, this is worth it", because it also depends on
what the phylib/phylink maintainers say. So I haven't said anything.
But I also don't have any objection, as long as the conversion doesn't
break existing setups (in new ways; see the "unbind MDIO bus driver"
case which is already problematic).

