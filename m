Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1FC75D718
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGUWBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGUWBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:01:46 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0980D268F;
        Fri, 21 Jul 2023 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=0IHuLhg4oPr4W/x3AXavhN58YJWV9ClI27tuE6B74Jo=; b=eS/5rJeEGoN6onyhqNoXA//TMM
        s74WNtnyglMd5tZc1pT/h2WDq+U+0kRGRea59vZgzw1xBOY3gbQziNilFp8kBylLWJvqPdFOiw5Va
        AfNbonCcw70iRZeYqdwnjElax1Kn6Plv4ohYT6LbwwTXAJR6jTwZ/JFul9ywl4rybRJQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qMyBs-001uLI-HI; Sat, 22 Jul 2023 00:01:36 +0200
Date:   Sat, 22 Jul 2023 00:01:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] dt-bindings: net: Add HPE GXP UMAC
Message-ID: <57d882ed-82e5-4584-8126-ca2007064126@lunn.ch>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
 <20230721212044.59666-4-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721212044.59666-4-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +examples:
> +  - |
> +    ethernet@4000 {
> +      compatible = "hpe,gxp-umac";
> +      reg = <0x4000 0x80>;
> +      interrupts = <22>;
> +      mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */

Do both ports get the sane MAC address? 

> +      ethernet-ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@0 {
> +          reg = <0>;
> +          phy-handle = <&eth_phy0>;
> +        };
> +
> +        port@1 {
> +          reg = <1>;
> +          phy-handle = <&eth_phy1>;
> +        };
> +      };
> +
> +      mdio {

This seems to be wrong. You have a standalone MDIO bus driver, not
part of the MAC address space?

	Andrew
