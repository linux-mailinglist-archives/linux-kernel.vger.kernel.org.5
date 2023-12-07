Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24219807D28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441923AbjLGA2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441896AbjLGA2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:28:22 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB89D68;
        Wed,  6 Dec 2023 16:28:27 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54cdef4c913so3065050a12.1;
        Wed, 06 Dec 2023 16:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701908906; x=1702513706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=js3vvEMH89qmox90J/KM0UnK1/RXnwyqtGHvEr0H27c=;
        b=NZJGnH31Ve8w/7MXJCoAsJz8gqvgt9ejM/vpFGNMdQv+33Da+cEOgkeL3BuB77Jsy+
         Mi3hgKk9bFkjQvo7ywDX9KVaisTO4rQUoQSXn6y9VrIhyIF/KXrO78HcDKRLw+hMERjD
         wLAElJV2ZDM7NlvDLrNwRxkiOuKqalAj/z+iIlLPYi4rp4l0A7WOQhvAzgsKAFvDRdVg
         8McXQw+3ia79lnMlSUgKgE2JgKk/oFJ/aL7URTQyVU3qv4g4IZGRaMuoWT4tHCRdD1hk
         EFwrx4Eg9K+4ECNROoxyMvC5AhS/V9IfRz6ZD+juIpOq+KWlSuSWh+uq0KgSya5q446c
         kJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701908906; x=1702513706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=js3vvEMH89qmox90J/KM0UnK1/RXnwyqtGHvEr0H27c=;
        b=LZbvFvybzq2QyZb1LFx3bIEXKZ/Mpi0zg+8lij3bj4kPZFvFRrPu3VOqqBjAuqCQRn
         PnFXZPfDO9iYOc/cE4auG/fBLprMs0qIRiEET7S/StTvzKswQHndnZzdv9eQBQ/CHnxz
         2UvCoFGea8pVFU7O8xoSOYnQe3XJdpTW2mnsZAqTN6b7FRcUJS1FI6dLKCMxdgC2qRDp
         c7YRaddtBmuMW44Egwf/oRrelrJ9wU7o/B0GTfCHBcbbIsNDl9pCkrkHTAuxcxRNPfuX
         ZPTk7OfkSK9RTli2IzHQBFvIH6x1djRK94pbr2XqHBRqf76b8iF3XNOayNR2KogcYjx5
         vz+g==
X-Gm-Message-State: AOJu0YzeuFx9W6LCswwB84CeALvZicxh0qeyDwNMj6cgwOrJ7SehpS0i
        +6ThWTMEBDBi7QUD7rSSKAo=
X-Google-Smtp-Source: AGHT+IGNrT7hViTJQsGamQ4k6tqu+2atpHkoEskaMm1SjUu6xtabZMmDurcam3BxY8sx0Tfbz78Ykg==
X-Received: by 2002:a17:906:f951:b0:a01:ae9a:c1d3 with SMTP id ld17-20020a170906f95100b00a01ae9ac1d3mr3266896ejb.11.1701908905883;
        Wed, 06 Dec 2023 16:28:25 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id f21-20020a170906c09500b00a1cd30d06d1sm86543ejz.14.2023.12.06.16.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:28:25 -0800 (PST)
Date:   Thu, 7 Dec 2023 02:28:23 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: Fix PHY loopback
 configuration for KSZ8794 and KSZ8873
Message-ID: <20231207002823.2qx24nxjhn6e43w4@skbuf>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 04:24:26PM +0100, Oleksij Rempel wrote:
> Correct the PHY loopback bit handling in the ksz8_w_phy_bmcr and
> ksz8_r_phy_bmcr functions for KSZ8794 and KSZ8873 variants in the ksz8795
> driver. Previously, the code erroneously used Bit 7 of port register 0xD
> for both chip variants, which is actually for LED configuration. This
> update ensures the correct registers and bits are used for the PHY
> loopback feature:
> 
> - For KSZ8794: Use 0xF / Bit 7.
> - For KSZ8873: Use 0xD / Bit 0.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

How did you find, and how did you test this, and on which one of the switches?

Opening the KSZ8873 datasheet, I am confused about their description of
the "far-end loopback". They make it sound as if this loops the packets
_received_ from the media side of PHY port A back to the transmit side
of PHY port A. But the route that these packets take is through the MAC
of PHY port A, then the switching fabric, then PHY port B which reflects
them back to PHY port A, where they finally egress.

Actually, they even go as far as saying that if you set the loopback bit
of port 1, the packets that will be looped back will be from port 2's
RXP/RXM to TXP/TXM pins, and viceversa.

If true, I believe this isn't the behavior expected by phy_loopback(),
where the TX signals from the media side of the PHY are looped back into
the RX side.
