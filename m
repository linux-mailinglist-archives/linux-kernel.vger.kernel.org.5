Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570CD7CA507
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjJPKPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjJPKPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:15:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5943B83;
        Mon, 16 Oct 2023 03:15:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso7686359a12.1;
        Mon, 16 Oct 2023 03:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697451314; x=1698056114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3CDALhGm3i1PJ9jhn5rXgWop6RzlcpY4kUfxNWLFsNk=;
        b=aDt6GKHywlXN2KE7hm82hQtYBGfiWzM/osYAmiMWjDL74HMSd8RuHzjyl6uAhCvGzr
         SeN7z/VnycG311EpuCDz7yNM9rkVZKxkmbYfP11PgP2x0sRt9RK6/aA5NTsCz3VpkXAp
         NB71O7wed/Z9IYd2U6DoGe81Y9ZqoaSVTC6zkXxpxrw9XLPQdxL/Q/l8m/mZ1tYamY0V
         QVu0w5AcGHinasXPmZU1MK6V30n8ljFm6FL/IvKbWJn6ViyQ4fsndAwpWcKbx50/cNZ3
         f8/RTdF4tzQUjSCrh6kDtHg28KHqOXQ0ihhJdlesOrtlQ5qkSxQAIaga55x6fDlugZHT
         lPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697451314; x=1698056114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CDALhGm3i1PJ9jhn5rXgWop6RzlcpY4kUfxNWLFsNk=;
        b=jgffc5uv+gOJ3Lh3Sx8O0BbJ568fix2i+Fcgd/mSIFPgy1jzwZRgrwvxC2aD1+Bl/n
         1GGr2y4ETSTAbzKps2GMGOl1d/LrVMDfS9djpkEeXHoku/Kmx2BWoyUIbprPBYPBJBCP
         SBoMS5ZSQVpNAU0QGOMzlzbsa0/oeL1dRqfbSeiwivT1w29tVziz7it/4mMxeAofXIkv
         eTsZfpQh1FvFRggbOO1nxcdDItoOUAMxTGfbH8djkGUaeVForN29c/xcnuuRMAO19GvX
         C75lQInV7yXJH5JIPBDFK8fC+AHA7aH93opvPNXWhrXQMmmOq+gtz69KZ33PBdt2hyyK
         u+jA==
X-Gm-Message-State: AOJu0YzQqn2CGwHeXz88MvXpTc7EazXUygyJ7BoSL2BE1cLaFJm88OmJ
        p9sOG44HmdthVW2wdzFEvXs=
X-Google-Smtp-Source: AGHT+IHYffULIbOSq3oeOrU7yb3oXde224tzUH7bZhxUeNpn7T3vYYIZUt6iDSEo+5J8aIMYN0qgBw==
X-Received: by 2002:a17:907:1c26:b0:9bf:5df1:38cc with SMTP id nc38-20020a1709071c2600b009bf5df138ccmr4432885ejc.4.1697451313430;
        Mon, 16 Oct 2023 03:15:13 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id jx17-20020a170907761100b009ad875d12d7sm3744594ejc.210.2023.10.16.03.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:15:13 -0700 (PDT)
Date:   Mon, 16 Oct 2023 13:15:10 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/7] net: dsa: microchip: Set unique MAC at
 startup for WoL support
Message-ID: <20231016101510.a6t3nbcelcnsdf53@skbuf>
References: <20231013122405.3745475-1-o.rempel@pengutronix.de>
 <20231013122405.3745475-3-o.rempel@pengutronix.de>
 <20231013123249.bhigwsezy6afb5qt@skbuf>
 <188688f2-1028-41ee-ba0a-c52456f63111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <188688f2-1028-41ee-ba0a-c52456f63111@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 02:18:43PM -0700, Florian Fainelli wrote:
> 
> 
> On 10/13/2023 5:32 AM, Vladimir Oltean wrote:
> > On Fri, Oct 13, 2023 at 02:24:00PM +0200, Oleksij Rempel wrote:
> > > Set a unique global MAC address for each switch on the network at system
> > > startup by syncing the switch's global MAC address with the Ethernet
> > > address of the DSA master interface. This is crucial for supporting
> > > Wake-on-LAN (WoL) functionality, as it requires a unique address for
> > > each switch.
> > > 
> > > Although the operation is performed only at system start and won't sync
> > > if the master Ethernet address changes dynamically, it lays the
> > > groundwork for WoL support by ensuring a unique MAC address for each
> > > switch.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > 
> > Why not take the MAC address of the user port at ksz9477_set_wol() time,
> > and use the existing ksz_switch_macaddr_get() API that was just added so
> > that this use case could work?
> 
> Agreed we do that in a number of Ethernet MAC and PHY drivers FWIW
> (net_device::dev_addr).
> -- 
> Florian

To be clear (to Oleksij), the request is for WoL to use the same runtime
management of the global MAC address (ksz_switch_macaddr_get) as HSR,
and also extend ksz_port_set_mac_address() to deny address changes to a
port with WoL active. Thus, multiple user ports could have WoL enabled
as long as they share the same MAC address. MAC address changes are also
possible while WoL is not enabled. I guess wol->supported should only
get set on those user ports which have the same MAC address as the
global MAC address (if a global MAC address is configured), or on all
user ports (if there is none).
