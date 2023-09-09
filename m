Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208DA7998A9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 15:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbjIINeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 09:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjIINeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 09:34:02 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4901A12B;
        Sat,  9 Sep 2023 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=HLK9WSdvnIOm43j0Wk61tr1UBJcZPuI7msFKk865x3I=; b=xI
        6HeIEcC3jghYxgGvxB6sryYMu4YuUAjB+2aQKD+nvfLkOswmx3jiK7T+DaQ/3y23knOIo9dtk7uyn
        2OyqfSX7sqz6Q4/Ij/V59Fw2adbEznZdjoztrSnhBPvABn++MsbdSY5ODLfjaPlv3FvQa7HZvfLS2
        WFrtr9wMXFajq/c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qey5k-0063t4-7T; Sat, 09 Sep 2023 15:33:40 +0200
Date:   Sat, 9 Sep 2023 15:33:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Message-ID: <74a6cd9c-fb30-46eb-a50f-861d9ff5bf37@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 07:59:14PM +0530, Parthiban Veerasooran wrote:
> Implement register read/write interface according to the control
> communication specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
> Interface document. Control transactions consist of one or more control
> commands. Control commands are used by the SPI host to read and write
> registers within the MAC-PHY. Each control commands are composed of a
> 32-bit control command header followed by register data.
> 
> Control write commands can write either a single register or multiple
> consecutive registers. When multiple consecutive registers are written,
> the address is automatically post-incremented by the MAC-PHY. The write
> command and data is also echoed from the MAC-PHY back to the SPI host to
> enable the SPI host to identify which register write failed in the case
> of any bus errors.
> 
> Control read commands can read either a single register or multiple
> consecutive registers. When multiple consecutive registers are read, the
> address is automatically post-incremented by the MAC-PHY.
> 
> The register data being read or written can be protected against simple
> bit errors. When enabled by setting the Protection Enable (PROTE) bit in
> the CONFIG0 register, protection is accomplished by duplication of each
> 32-bit word containing register data with its ones’ complement. Errors
> are detected at the receiver by performing a simple exclusive-OR (XOR) of
> each received 32-bit word containing register data with its received
> complement and detecting if there are any zeros in the result.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  Documentation/networking/oa-tc6-framework.rst | 231 ++++++++++++++++++
>  MAINTAINERS                                   |   8 +
>  drivers/net/ethernet/oa_tc6.c                 | 222 +++++++++++++++++
>  include/linux/oa_tc6.h                        |  31 +++

I'm surprised there is no kconfig and Makefile changes here. I would
expect this is compiled as a module, which the vendor code can then
make use of. 

     Andrew
