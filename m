Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4D275EC1D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGXHAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGXHAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:00:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87E1B7;
        Mon, 24 Jul 2023 00:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690182013; x=1721718013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LNoTdkXoZT85Gpvee9QVvqttY1j+UwGAAbCzY5X4MB4=;
  b=rV8v90PmcsPYpgXcQmokLp+4FSs7hILtZkS9UFBHq7TRzxxVe4BDLFEF
   4w+aVosYfL/tOzZn9tpfXXlofJ+8v0/niXth291yQWBnpErMseiGztZEv
   M/KnUYWfaAn4C0UJ2tKEu50cfgx0KSSp3Xqx6zX4zBZ3MmaRGVpbh32jN
   DG6/pmP6NjoT+bR2y1t9YcLmqCO0BJE09hZacDUzYglERC1thzh3b8KC9
   3OXdRh6TSFG+jZtrjpRWzjc2AaYGaG7YG48mD+1s91GUrdjK+4DH0xwki
   mACQ0u1+rSvvhDtvkhey0lgMr6leEi+6AuF3BRPr2zP10zlxfE9Xk1GKw
   w==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="221811342"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2023 00:00:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 23 Jul 2023 23:59:58 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Sun, 23 Jul 2023 23:59:58 -0700
Date:   Mon, 24 Jul 2023 08:59:57 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Colin Foster <colin.foster@in-advantage.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [RFC RESEND v1 pinctrl-next 1/1] pinctrl: microchip-sgpio: add
 activity and blink functionality
Message-ID: <20230724065957.a72yejua7us5e2s3@soft-dev3-1>
References: <20230712022250.2319557-1-colin.foster@in-advantage.com>
 <20230712022250.2319557-2-colin.foster@in-advantage.com>
 <CACRpkdYXeGq2LnD+bpAXm82Aa-Czob8afQSfjfMFweBLhdr9uw@mail.gmail.com>
 <ZLmSvkizdykGGpv6@MSI.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLmSvkizdykGGpv6@MSI.localdomain>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/20/2023 14:02, Colin Foster wrote:

Hi,

> 
> On Thu, Jul 20, 2023 at 09:25:32PM +0200, Linus Walleij wrote:
> > On Wed, Jul 12, 2023 at 4:23 AM Colin Foster
> > <colin.foster@in-advantage.com> wrote:
> >
> > > Add additional functions - two blink and two activity, for each SGPIO
> > > output.
> > >
> > > Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> >
> > Could Lars or Horatiu review this patch? You guys know the driver
> > best.
> 
> Agreed. Please don't merge this without their approval and hopefully
> testing.
> 

I have tried to apply the patch to test it, but unfortunately it doesn't
apply.
I have looked through the changes and they seem OK.

> I did demote this patch I've been dragging around since 2021 to RFC
> status because I'm more interested in making sure it will fit in with
> the work on hardware-offloaded network activity LED work that's being
> done. I took Andrew's response to the cover letter as an suggestion to
> hold off for a little while longer. I can be patient.
> 
> Also, this RFC was two-fold. I don't want to duplicate efforts, and I
> know this pinctrl driver was written with this functionality in mind. If
> someone out there has a hankering to get those LEDs blinking and they
> don't want to wait around for me, feel free to use this as a starting
> point. I might not get around to the whole netdev trigger thing for
> quite some time!
> 
> 
> Colin Foster

-- 
/Horatiu
