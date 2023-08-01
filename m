Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA7F76B1EF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjHAKen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjHAKei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:34:38 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A073A1;
        Tue,  1 Aug 2023 03:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=F1Sz0ae4nr5z1N2NijC/jAEv5RJWJxIOfwa338xwclg=; b=Us+lwVnb/LgpA8dbty/0XeNHRu
        /ZsdCPMPAMMyQgY18YVJaUmBz7DBcJxUJTvhONLvkm4MAPTiIViAvrWQtQqe2/PYnchcoYAwcun13
        e0pxg36/GxLW7aMHGLvodGw2bLi+2F8kz/OozrgCcY7CG2e1Uag0KBAexqau2le6y10s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qQmhr-002nBv-2P; Tue, 01 Aug 2023 12:34:23 +0200
Date:   Tue, 1 Aug 2023 12:34:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 00/28] Add support for QMC HDLC, framer infrastruture
 and PEF2256 framer
Message-ID: <4eef1cf6-ace4-417f-a0ba-ec13331c8eaf@lunn.ch>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726150225.483464-1-herve.codina@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The generic framer has:
>  - 2 consumers (QMC HDLC drv and codec)
>  - 1 provider (PEF2256)
> 
> So, the design is the following:
>                         +------------------+           +---------+
>                         | QMC              | <- TDM -> | PEF2256 | <-> E1
>      +---------+        |  +-------------+ |           |         |
>      | CPU DAI | <-data--> | QMC channel | |           |         |
>      +---------+        |  +-------------+ |           |         |
> +--------------+        |  +-------------+ |           |         |
> | QMC HDLC drv | <-data--> | QMC channel | |           |         |
> +--------------+        |  +-------------+ |           |         |
>      ^                  +------------------+           |         |
>      |   +--------+     +-------------+                |         |
>      +-> | framer | <-> | PEF2256 drv | <- local bus ->|         |
>          |        |     |             |                +---------+
>      +-> |        |     |             |
>      |   +--------+     |  +-------+  |
>      +-------------------> | codec |  |
>                         |  +-------+  |
>                         +-------------+

Thanks for adding the framer framework. I did not look into all the
details, but the basic design looks good.

	 Andrew
