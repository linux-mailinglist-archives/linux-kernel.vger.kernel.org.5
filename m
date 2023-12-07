Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC548089B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442595AbjLGOAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjLGOA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:00:29 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CDC133;
        Thu,  7 Dec 2023 06:00:34 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1ca24776c3so416734066b.0;
        Thu, 07 Dec 2023 06:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701957633; x=1702562433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXGIepeuK98bX+uV4nm8inVKbX3KEEAy9u4QQp1AxGk=;
        b=lCt2r5X0mXArcV+GDNWYfUwnXTxexggpmME0xLra7SJMmKVs8lemHp6CGFcEolehEW
         VaNmGly3C9vdoP20KZ4izJgd7SSk49huGvN95+1yEfuqHUZ9z2ZsRNv16hOU/3g77D8X
         d5A8DyGyI2ExJF0DX5ABC64GWgYEOiX/jn91xKEGIh4cggpkr82LmjccMvSUt/EvULIY
         sf/bTkFkLkppB6C38i0tsV+bkmfcATPVnyVb9LV+u3IM1gbrPpRGOGVW+OnEOcxcpA59
         TnVcm/uULsnawr+jZYCBXn0te+kpapIhfqR6NIof3qagQJQ/kgHPGMptDEQF9L8FkN8g
         X8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957633; x=1702562433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXGIepeuK98bX+uV4nm8inVKbX3KEEAy9u4QQp1AxGk=;
        b=rjtN/CQrptKTQV+BXCaXiADVdbo3Wntn74I5c9UruIz+oHinnDKGgn6T5MDUNGGC40
         RsSldl2140Xz44wOjyk7UJWerQ2SnCAAggoza1IUN4bgFrEGbuCoZzJR7LgSyXymHFps
         eT1QRhZqHz3x2D+rfye239Ci8MY12idWEEAQGzmkbZtozJIrS6GOj4JGtGBb8MKFWd5f
         5UK8HFdinuagoEgxEXl/61gzlFKNBDynqMDrDxyUVLVY9+roHgyX/al8iZg/8nh1+qt4
         vcRmXpHfstJ0sSO0L4ly04BV7/JQ+N2cFHJVUIgUnEv/I2Wq2gB5RpqYqjr0b0s4nD/O
         0zVg==
X-Gm-Message-State: AOJu0YyV3lfCPbtmmDnsqU5gGREAbQ5zpf/1IfAtJGtlVEFyzMOIBqkv
        S4UHS3FVyYUehy+stXXzPDg=
X-Google-Smtp-Source: AGHT+IGLm1ugs54nqbnfjLwuyS3eJ2hV8SofIcgU+yLeZw6U+TvVYoMvUgp62rd0YWlZpZwovXlmxw==
X-Received: by 2002:a17:906:73d9:b0:a1c:cd3b:4c2f with SMTP id n25-20020a17090673d900b00a1ccd3b4c2fmr4375666ejl.34.1701957632972;
        Thu, 07 Dec 2023 06:00:32 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id lw26-20020a170906bcda00b00a1b6d503e7esm850811ejb.157.2023.12.07.06.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:00:32 -0800 (PST)
Date:   Thu, 7 Dec 2023 16:00:30 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Eric Dumazet <edumazet@google.com>,
        kernel@pengutronix.de, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: Fix PHY loopback
 configuration for KSZ8794 and KSZ8873
Message-ID: <20231207140030.ki625ety6cg3ujxn@skbuf>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <20231207002823.2qx24nxjhn6e43w4@skbuf>
 <20231207051502.GB1324895@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207051502.GB1324895@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 06:15:02AM +0100, Oleksij Rempel wrote:
> On Thu, Dec 07, 2023 at 02:28:23AM +0200, Vladimir Oltean wrote:
> > On Tue, Nov 21, 2023 at 04:24:26PM +0100, Oleksij Rempel wrote:
> > > Correct the PHY loopback bit handling in the ksz8_w_phy_bmcr and
> > > ksz8_r_phy_bmcr functions for KSZ8794 and KSZ8873 variants in the ksz8795
> > > driver. Previously, the code erroneously used Bit 7 of port register 0xD
> > > for both chip variants, which is actually for LED configuration. This
> > > update ensures the correct registers and bits are used for the PHY
> > > loopback feature:
> > > 
> > > - For KSZ8794: Use 0xF / Bit 7.
> > > - For KSZ8873: Use 0xD / Bit 0.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > 
> > How did you find, and how did you test this, and on which one of the switches?
> 
> I tested it by using "ethtool -t lanX" command on KSZ8873. Before this
> patch the link will stop to work _after_ end of the selftest. The
> selftest will fail too.
> 
> After this patch, the selftest is passed, except of the TCP test. And
> link is working _after_ the selftest,

So you are suggesting that this far-end loopback mode does work as
expected by the kernel.

But is that consistent with the description from the datasheet? It speaks
about an "originating PHY port", but maybe this is confusing, because
based on your test, even the CPU port could be originating the traffic
that gets looped back?

I see it says that far-end loopback goes through the switching fabric.
So the packet, on its return path from the loopback port, gets forwarded
by its MAC DA? That can't be, because the MAC DA lookup has already
determined the destination to be the loopback port (and no MAC SA<->DA
swapping should take place). Or it is forced by the switch to return
specifically to the originating port?

With a bridge between the 2 LAN ports, and lan1 put in loopback, what
happens if you send a broadcast packet towards lan1? Will you also see
it on lan2's link partner, or only on the CPU port?

It's not your fault, but this is all a bit confusing, and I'm not quite
able to match up the documentation with your results. I will trust the
experimental results, however.
