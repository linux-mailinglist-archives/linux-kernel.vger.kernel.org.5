Return-Path: <linux-kernel+bounces-5984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BEE819281
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBB61F26112
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889173BB55;
	Tue, 19 Dec 2023 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihIuyzc+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B83B193;
	Tue, 19 Dec 2023 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e4b6b13d4so1237293e87.2;
        Tue, 19 Dec 2023 13:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703022497; x=1703627297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lprg6JFS3aa/Q9wpziRGhKZIoy46UrPyfAtrU4sp3T0=;
        b=ihIuyzc+zrB6dA110zm6E46pJWqW4JDz2Wk+YbSrf4K8MW3Gf8ZwgSqUqbfA13rUst
         u0CAeTD4FRENV+YP6ejACWjo4Tb6U8sVvtG4722sAP8BUZ8S6RyBK5rwBj9Ndjd7Ssyj
         s7+bUsOGNWq/3xA16CwIoWkjJcYRSUo30r2wPhXQjXipF7hk3O9U8HUuzaCkYHv/+F+2
         V5wfRAZRXOwqTktru75kplgI0hrTiD8zyvbnmX9LWih/CT2xpYIbNGaM8YJO7VxiM2SH
         GR6YTBvdVzetj0El60FT1un4ovv+ZKl1iPnTxOaT2XKLnaYLw0U7uskAMkXDRRg6D8T/
         hGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703022497; x=1703627297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lprg6JFS3aa/Q9wpziRGhKZIoy46UrPyfAtrU4sp3T0=;
        b=t3e9iH0kjGaxUglikGfe/I/s0B7v4S0o6+DucX9BUZuB4HAFtKy0Bz7unBZkmvZoqM
         V8qS6quY/zZmIkp0YMfhZAPyxK3AXLrp8xSMrclWSgFcgqG0rj/4C4OfSywwEsc6je4S
         soyFYhC5FPwLBe2+P5378jtTpd+PJQt8WCAaWfAlDCBVmZZob8r3mLAYqnNd9oqtxfWS
         xwGl2ytlcn9ptgfHW32M53bb2MEwrb3xpCRYOnXm6Sm/03IVjNBihB8V0kyM5RIbS86w
         15tguQWysQWEy6QQs430ncOiGsZ8ewIJhNerJFmIwtJLq+gwCC6Z68OigjThL6wf/5gm
         px1g==
X-Gm-Message-State: AOJu0Yxfw10vfghAaNdXnt2L0eJ36obJA9c1JNp4W0Yc3sYbFblZiN+8
	6AyjVN49Z/kZX8Iczt5+/Jg=
X-Google-Smtp-Source: AGHT+IEB+5cf7++qXG0g34O2AsAhdODA0sjPyL5qPtyv6kIILgJXYpXLUB7o3MU6cMihDa1zGaqQCw==
X-Received: by 2002:ac2:5928:0:b0:50e:4631:d57a with SMTP id v8-20020ac25928000000b0050e4631d57amr816260lfi.85.1703022496711;
        Tue, 19 Dec 2023 13:48:16 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id y7-20020a199147000000b0050e4c716d17sm176828lfj.231.2023.12.19.13.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 13:48:16 -0800 (PST)
Date: Wed, 20 Dec 2023 00:48:14 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/16] net: pcs: xpcs: Avoid creating dummy XPCS
 MDIO device
Message-ID: <2jlqxp3jyjautzpf2hn7jeys4omkcntcrx6prjyaativsuqam6@f4szkixopvek>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <20231205115234.7ntjvymurot5nnak@skbuf>
 <wnptneaxxe2tq2rf7ac6a72xtyluyggughvmtxbbg5qto64mpa@7gchl5e4qllu>
 <jlcyqvcw5hsjtmvf77sm7qni6tzihxudo6baoq7wi7zgqx3lvs@ykbsxgmjkvnf>
 <20231219162803.kmb3jb6aevef3kj3@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219162803.kmb3jb6aevef3kj3@skbuf>

On Tue, Dec 19, 2023 at 06:28:03PM +0200, Vladimir Oltean wrote:
> On Tue, Dec 19, 2023 at 06:48:09PM +0300, Serge Semin wrote:
> > > > Sorry, because the commit log lost me at the "context presentation" stage,
> > > > I failed to understand the "what"s and the "why"s.
> > > > 
> > > > Are you basically trying to add xpcs support on top of an mdio_device
> > > > where the mdio_device_create() call was made externally to the xpcs code,
> > > > through mdiobus_register_board_info() and mdiobus_setup_mdiodev_from_board_info()?
> > > 
> > > Basically yes, but there is more of it. The main idea is to convert
> > > the XPCS driver to using the already created non-PHY MDIO-devices
> > > instead of manually creating a 'dummy'/'redundant' one. From my point
> > > of view there are several reasons of doing so:
> > > 
> > > 1. mdiobus_register_board_info() provides a way to assign the device
> > > platform data to being registered afterwards device. Thus we can pass
> > > some custom data to the XPCS-device driver (whether it's just an
> > > xpcs_create_*() call or a fully functional MDIO-device driver
> > > registered by the mdio_driver_register() method). For instance it can
> > > be utilized to drop the fake PHYSIDs implementation from
> > > drivers/net/dsa/sja1105/sja1105_mdio.c .
> 
> Ok. Seeing an alternative to the NXP_SJA1110_XPCS_ID hack will be interesting.
> 
> FWIW, I'm looking at reworking the dsa_loop probing to use software nodes.
> Since dsa_loop is the only current user of mdiobus_register_board_info(),
> maybe that will lead to its deletion. It appears a matter of timing, but
> the mechanism looks promising.

I think I'll be able to fix my series within two weeks. Seeing it's
going to be merge window soon and Xmas/NY holidays then, the patchset
will be re-submitted afterwards.

Note in my case mdiobus_register_board_info() isn't that well
suitable. As I explained a bit earlier in this thread,
mdiobus_register_board_info() isn't working for the hot-pluggable
devices and for the case when MAC/MDIO-bus drivers unbinding is
possible. What could be better is to have a method like this:

mdiobus_register_bus_info(struct mii_bus *bus, struct mdio_board_info *info, unsigned int n)
{
	// Add devs-info's into the internal mii_bus-instance list
	// for each of which the MDIO-devices will be then created and
	// registered by means of the method
	// mdiobus_setup_mdiodev_from_board_info() called in
	// __mdiobus_register().
}

Which could be called for the just allocated and not yet registered
MDIO-bus descriptor in order to prescribe the non-PHY devices on the
bus.

Alternatively, what might be even more preferable and easier to
implement I could:
1. Globalise and export mdiobus_create_device().
2. Make sure all non-PHY MDIO-devices are masked in mii_bus instance.
3. Register MDIO-bus.
4. Call mdiobus_create_device() for each XPCS device.
5. Then call xpcs_create_mdiodev() for each registered device.

> 
> Maybe we can also use it somehow to add compatibility with existing
> lynx-pcs device trees where there is no compatible string, so a struct
> phy_device gets created. Device tree breakage was the fundamental reason
> why Sean Anderson's patch set couldn't make forward progress.
> https://patchwork.kernel.org/project/netdevbpf/cover/20221103210650.2325784-1-sean.anderson@seco.com/

In case of DW XPCS the solutions described in my comment above are
only required for the runtime-registered non-OF MDIO-buses. DW XPCS
DT-based devices are unsupported by the current STMMAC driver (adding
that support is the main goal of this patchset). So my case is
simpler.

But regarding your proposal, I guess the first version of the
solutions described in my comment above could be suitable for you if
the _of_mdiobus_register() method is somehow fixed to considering the
DT-nodes with no compatible strings as non-PHY MDIO-devices. For
instance the _of_mdiobus_register() function can work that way if it
detects some pre-registered mdio_board_info data in the being
registered mii_bus instance. Alternatively you could introduce an
additional mii_bus structure field which would indicate such non-PHY
MDIO-devices.

Note in order to make things backward compatible you would need to
tweak the drivers/net/ethernet/freescale/xgmac_mdio.c driver so one
would detect the platforms (for instance, based on the platform
compatible string) on which the Lynx PCSs are specified with no
compatible strings and activate the mechanism above. Then you can
freely convert the currently available Lynx PCS dts nodes to having
the compatible strings. The kernel will be still backwards compatible
for old dtbs and will contain the Lynx PCS DT-nodes identified by the
proper compatible strings.

> 
> > > 2. The MDIO-devices actually registered on the MDIO-bus will be
> > > visible in sysfs with for instance useful IO statistics provided by
> > > the MDIO-bus. Potentially (if it is required) at some point we'll be
> > > able to convert the DW XPCS driver to being true MDIO-device driver
> > > (bindable to the DW XPCS device) with less efforts.
> 
> Ok.
> 
> > > 3. Having an MDIO-device registered that way would make the DW XPCS
> > > IO-device implementation unified after the fwnode-based XPCS
> > > descriptor creation support is added in one of the subsequent patches.
> 

> Unified how? You mean that "XPCS will always operate as a driver bound
> to an mdio_device"?

No. I meant that mdio_device would be registered as a normal device on
the MDIO-bus in both fwnode-based and runtime-based cases. No driver
will be bound to those devices, but some platform-data could be
specified and handled identically in both cases. Eventually when the
net core is ready for it, the DW XPCS driver could be easily converted
to being normal MDIO-device driver and bound to the XPCS devices
registered on a MDIO-bus.

> 
> You're not planning to unify the mdio_device and MMIO register handling
> by using regmap, right?

No. It will be too tiresome especially seeing the current
devm_mdio_regmap() implementation doesn't support C45 IO ops and using
regmaps would cause having redundant abstraction layers. I see no much
benefits in that at the moment. In more details I explained it here:
https://lore.kernel.org/netdev/cv6oo27tqbfst3jrgtkg7bcxmeshadtzoomn2xgnzh2arz4nwy@wq5k7oygto6n/

> 
> > > So based on the listed above I've got a question. Do you think all of
> > > that is worth to be implemented? Andrew, Russell?
> > > 
> > > I am asking because the patchset advance depends on your answers. If
> > > you do I'll need to fix the problem described in my first message,
> > > implement some new mdiobus_register_board_info()-like but
> > > MDIO-bus-specific interface function (so MDIO-device infos would be
> > > attached to the allocated MDIO-bus and then used to register the
> > > respective MDIO-devices on the MDIO-bus registration), then convert
> > > the sja1105 and wangxun txgbe drivers to using it. If you don't I'll
> > > get back the xpcs_create_mdiodev() implementation and just provide a
> > > fwnode-based version of one.
> > 
> > Folks, this is the only issue left to settle so I could move on with
> > the series fixing up. So the question is: taking my comment above into
> > account is it worth to convert the xpcs_create_mdiodev() method to
> > re-using the already registered MDIO-device instance instead of
> > always creating a stub-like MDIO-device?
> 

> I can't exactly say "yes, this is worth it", because it also depends on
> what the phylib/phylink maintainers say. So I haven't said anything.
> But I also don't have any objection, as long as the conversion doesn't
> break existing setups (in new ways; see the "unbind MDIO bus driver"
> case which is already problematic).

Ok. Thanks. There won't be MDIO-device driver binding. I get to decide
later what solution described in my first comment to implement (unless
you insist on some of them particularly or suggest an alternative).

-Serge(y)


