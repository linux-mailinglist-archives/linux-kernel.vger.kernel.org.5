Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1D575697B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjGQQpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjGQQpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:45:44 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B8010D5;
        Mon, 17 Jul 2023 09:45:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 31CA4E0002;
        Mon, 17 Jul 2023 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689612341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9R0G8NSJjToV+64LK3uPlbmnb/IZocOABxVYbM+R0so=;
        b=NXv9FuO8QVkPCzHzbbUxvL19fGDuldDfOCcp/EqbAJTxd30SmGFTIvIQ0dqgAzfIRmJCkg
        q4QPbsI98ghOtTP8Kupk7Y2inf7DpQ/V/Fn1iK/xpBcP3ndf2oLwRusdwXsgYCXCs67aXF
        ZmaUGX70t+sqj0GZcsDCmRbTtwKCYLl9vDC1eYkhpRNb31Q+xQVFtaNpkJbWf7XpgRGUnA
        8WRQG+FhESla5CuKYnqkq9S/Tfq6ObxwnSqKXYIsY2L6WKjHXUH292qm/9prS9LjU7qPLG
        dLAYcj8C8TByxpNOh7ig1piUxMpwiOjWAl481B8EwgtoSbuoq7laHGBRnj8Dpg==
Date:   Mon, 17 Jul 2023 18:45:37 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Message-ID: <20230717184537.6d6ed607@booty>
In-Reply-To: <ZKaWL3+ClI7iNr/4@francesco-nb.int.toradex.com>
References: <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
        <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
        <PA4PR04MB96403377F5E37C12AD8C25B389729@PA4PR04MB9640.eurprd04.prod.outlook.com>
        <20230505120618.2f4cf22c@booty>
        <ZFThyn/D/dDK9nk3@francesco-nb.int.toradex.com>
        <PA4PR04MB96405EE2468555EA900B340189739@PA4PR04MB9640.eurprd04.prod.outlook.com>
        <ZFjaNzY32x8o2XG7@francesco-nb.int.toradex.com>
        <20230508151756.785ec07e@booty>
        <20230529121825.71e9b6d6@booty>
        <PA4PR04MB96405138465D215C34285F02894B9@PA4PR04MB9640.eurprd04.prod.outlook.com>
        <ZKaWL3+ClI7iNr/4@francesco-nb.int.toradex.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ciao Francesco,

On Thu, 6 Jul 2023 12:23:43 +0200
Francesco Dolcini <francesco@dolcini.it> wrote:

> Hello Luca,
> 
> On Tue, May 30, 2023 at 11:22:51AM +0000, Jun Li wrote:
> > Yes, your understanding is correct, talked with Xu(in CC), he will take this
> > soon.  
> 
> A series was posted
> https://lore.kernel.org/all/20230627110353.1879477-1-xu.yang_2@nxp.com/,
> I had no time to try or look at it yet.

Thanks for keeping me up to date on this topic, which is still totally
relevant to me.

I looked at the series, but it does not seem to be addressing the
problem with USB host not detecting new devices when VBUS is not
directly connected, e.g. in the Colibri imx6ull SoM.

Xu, do you confirm the series at the link is _not_ solving the problem
being discussed here?

Best regards,

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
