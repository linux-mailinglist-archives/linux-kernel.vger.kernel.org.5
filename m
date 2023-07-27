Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A45765E44
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjG0VcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjG0VcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:32:05 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB5D113;
        Thu, 27 Jul 2023 14:32:03 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B14E81BF205;
        Thu, 27 Jul 2023 21:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690493521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVzGt1hU6/zJ2p8ESrItLga9WOYSY12aapmt+gJTTm0=;
        b=KuzkthgvdjwJnivEU/aryJfGIVIwS2Jo2FGYznAjBe2XO2ObIJRvGb4lZ+5IDN1HoNpZYG
        4od2IsUmCvD1rkxDQUX70EEy/OerDBhxZu3PYbTnWRsnA+Uh3PCr6Soiqs7oTND51Z5H12
        vPxGYo5bgxbp54fa9pK//rRC9ZjhXRAtXs5LXD+g2zg8loPvxEOC0OU9LKtcey5kXGqFUV
        3owWu3CEW9oVKY03yZ19bLiumKfiItmQPfrW7xy4+Zjs6amZuo4MDBNNBF0yaCOsre4eZ+
        CZksNyGouFQz3JfaVim3BzM6WwJl4QqifmvRDrXEUYS0+aUG+hl2XEUkrWRj6g==
Date:   Thu, 27 Jul 2023 23:31:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] rtc: Explicitly include correct DT includes
Message-ID: <169049349537.641428.12895115995770744599.b4-ty@bootlin.com>
References: <20230724205456.767430-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724205456.767430-1-robh@kernel.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Jul 2023 14:54:54 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied, thanks!

[1/1] rtc: Explicitly include correct DT includes
      commit: 48144c2890503b919bc8ee128b63e37008d69250

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
