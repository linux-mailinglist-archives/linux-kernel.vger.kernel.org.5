Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10467D2C13
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjJWH7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWH67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:58:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC1F5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:58:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1quppp-0004Ut-Kh; Mon, 23 Oct 2023 09:58:49 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1quppo-003ei6-D0; Mon, 23 Oct 2023 09:58:48 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1quppo-00FtCD-9u; Mon, 23 Oct 2023 09:58:48 +0200
Date:   Mon, 23 Oct 2023 09:58:48 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     olteanv@gmail.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
        conor+dt@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, edumazet@google.com,
        f.fainelli@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        woojung.huh@microchip.com
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Message-ID: <20231023075848.GA3786047@pengutronix.de>
References: <20231020143759.eknrcfbztrc543mm@skbuf>
 <20231023072700.17060-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023072700.17060-1-ante.knezic@helmholz.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 09:27:00AM +0200, Ante Knezic wrote:
> On Fri, 20 Oct 2023 17:37:59 +0300, Vladimir Oltean wrote:
> 
> > Sorry, I didn't realize on v3 that you didn't completely apply my
> > feedback on v2. Can "microchip,rmii-clk-internal" be a port device tree
> > property? You have indeed moved its parsing to port code, but it is
> > still located directly under the switch node in the device tree.
> > 
> > I'm thinking that if this property was also applicable to other switches
> > with multiple RMII ports, the setting would be per port rather than global.
> 
> As far as I am aware only the KSZ8863 and KSZ8873 have this property available,
> but the biggger issue might be in scaling this to port property as the register
> "Forward Invalid VID Frame and Host Mode" where the setting is applied is
> located under "Advanced Control Registers" section which is actually global at
> least looking from the switch point of view. Usually port properties are more
> applicable when registers in question are located under "Port Registers" section.
> This is somewhat similar to for example enabling the tail tag mode which is 
> again used only by the port 3 interface and is control from "Global Control 1"
> register.
> With this in mind - if you still believe we should move this to port dt 
> property, then should we forbid setting the property for any other port other 
> than port 3, and can/should this be enforced by the dt schema?
> 

If I see it correctly, KSZ9897R supports RMII on two ports (6 and 7)
with configurable clock direction. See page 124 "5.2.3.2 XMII Port Control 1
Register"
http://ww1.microchip.com/downloads/en/DeviceDoc/00002330B.pdf

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
