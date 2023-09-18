Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D757A5081
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjIRRHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjIRRHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:07:43 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B493;
        Mon, 18 Sep 2023 10:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=dauQr5A1qgLA9BmzHiEleNb3IjNWdzZ7y7a1hCEGPGY=; b=x0mHl8qtGRdY+kCyZqq3C5c5OF
        C6aejezm9Q3BOHyHm7/OzU+eGIkWqNgFNkm046pxYqXYH5sqZW7IznKwWA5lrWDbZRyxFi/WWaaTf
        nq7Lsdc31FAWQ1kRs2OyhRB653+zyp/v3YqvYtkkisXynTTr1JUVmaH/Tm+uT0Jbyduw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qiH9V-006oJU-7v; Mon, 18 Sep 2023 18:31:13 +0200
Date:   Mon, 18 Sep 2023 18:31:13 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jay Monkman <jtm@lopingdog.com>
Cc:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Arndt Schuebel <Arndt.Schuebel@onsemi.com>
Subject: Re: [PATCH 1/4] dt-bindings: net: Add bindings for onsemi NCN26000
 PHY
Message-ID: <a467d803-3c71-4008-8d6e-7bb03128ea44@lunn.ch>
References: <ZQf1LMnICzEnt9XK@lopingdog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQf1LMnICzEnt9XK@lopingdog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +properties:
> +  description: |
> +    Sets the transmitter amplitude gain. If not specified,
> +    gain is set to 1.0V (1v0)
> +  tx-gain:
> +    enum:
> +      - 1v1
> +      - 1v0
> +      - 0v9
> +      - 0v8

How is a gain in volts? Isn't gain just a multiplier, so it unitless?

> +  tx-slew:
> +    description: |
> +      Sets the slew rate of the TX line driver output. Defaults
> +      to slow if not set.
> +    enum:
> +      - fast
> +      - slow

How does this map to a standard? I would expect the standard to
specify the slew. So why is this needed?

> +  dig-slew:
> +    description: |
> +      Sets the slew rate of the digital output pins. Defaults
> +      to slow if not set.

By Digital output pins, do you them the GPO pins you are adding a GPIO
driver for?

> +  cmc-comp:
> +    description: |
> +      Sets the common mode choke resistance (CMC compensation).
> +      Defaults to 0-0.5 ohm (0p25) if not set.
> +    enum:
> +      - 0p25
> +      - 1p38
> +      - 3p00
> +      - 3p37

What is the mapping between 0-0.5 ohm and 0p25? Can we just use ohms
here?

> +  plca-precedence:
> +    description: |
> +      Enables PLCA precedence mode. Defaults to off if not
> +      set.
> +    type: boolean

What is PLCA precedence? Should this be an ethtool parameter, along
side all the other PLCA controls?

> +  eni-mode:
> +    description: |
> +      Enables Enhanced Noise Immunity mode. Defaults to off if
> +      not set.
> +    enum:
> +      - force-on
> +      - force-off
> +      - auto

phy tunable?

> +
> +  tx-pkt-loop:
> +    description: |
> +      Enables packet loopback mode. Defaults to off is not set.
> +    type: boolean

How does this differ from struct phy_driver::set_loopback()?

> +  unjab-tmr-disable:
> +    description: |
> +      Disables the Unjab Timer. When disabled, device transmission
> +      will be stopped due to a jabber error and only restarted on
> +      device reset. If not set, this defaults to enabled.
> +    type: boolean
> +
> +  col-disable:
> +    description: |
> +      Disables collision masking. Defaults to enabled if not set.
> +    type: boolean

I could be wrong, but this feels like an SDK dump of all the features
the device has, but nobody will ever user in reality. We need some
justification why all these properties are really needed, and ideally
a .dts file for a board actually using them. If there is no user, i
suggest waiting until somebody really does need them.

	Andrew
