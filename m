Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60597CB813
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjJQBmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQBmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:42:54 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E7D9B;
        Mon, 16 Oct 2023 18:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=8naKVPna3lePN+LMkirFgKXoaty1PHNEIEp1SVSQuig=; b=TFm1iVUdFPIniQNrmzNuXCwEmc
        jgUnTn5N4oaH2QxxuSOoB9OabvaYfs6b0v+XOQVSSjM0GdkV8y9+SMIjSbperrCCdjC+wJQ1gWKcK
        z/ehs2M6rM4YHeaSjcvFrqHq7HdT9RGzKU8/TAUWzJDW31WBJOhqic/d4A6AnWWKySrE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qsZ6Z-002QCm-3D; Tue, 17 Oct 2023 03:42:43 +0200
Date:   Tue, 17 Oct 2023 03:42:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/9] net: dsa: microchip: ksz9477: Add Wake
 on Magic Packet support
Message-ID: <e1d812ec-98d1-491a-aa03-ca3d39292c25@lunn.ch>
References: <20231016141256.2011861-1-o.rempel@pengutronix.de>
 <20231016141256.2011861-6-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016141256.2011861-6-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	wol->supported = WAKE_PHY;
> +	wol->supported = WAKE_PHY | WAKE_MAGIC;

It is clearly racy, but maybe try a ksz_switch_macaddr_get() and only
if it is successful add WAKE_MAGIC. Then do a
ksz_switch_macaddr_put(). Given the limitations of the hardware, it
might help the user understand what the hardware can do.

But this is not a must.

    Andrew
