Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED34B77633D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjHIPBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjHIPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:01:49 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683402107;
        Wed,  9 Aug 2023 08:01:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08F12E0008;
        Wed,  9 Aug 2023 15:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691593306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0zvfLvyRJt7hOgvNIifYjQHxyaOMWD1ltEX2pdHMbc=;
        b=iXnta/0eS8D5cHJ76Q4dwhU+XK3qsGA5Twh8/3mjUO44s+pEvR/n0UP3phDRDaRzknJJqg
        U0Po6QG77G0tYGseNfrgZzZ+oWZIReHQUy/j7wwlAqPpgNMdWXCyXkv/pWCbZTB17U0vBq
        09x+R9HSs6PA9O+bm3Z01VLxBArlIT/tenAyyV94zuJu4ABgfwHf1jlpBmT9JL/aTrx54e
        xulDWbuzkyyvyvjDTlEeKHtRrqbNHF9NWfFODttuROxRsjNMQwXq4dUnuY5B9C5WUAcO8L
        rl4cb1owoaMRbW2+7s4uQte7dbC1HrDGo95q3ov+1CrqQAidzdIy5MawOqVkLw==
Date:   Wed, 9 Aug 2023 17:01:39 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
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
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 21/28] net: wan: Add framer framework support
Message-ID: <20230809170139.2402e4a2@bootlin.com>
In-Reply-To: <cc9417a3-ef86-bb46-9519-cf65b03b5f08@infradead.org>
References: <20230809132757.2470544-1-herve.codina@bootlin.com>
        <20230809132757.2470544-22-herve.codina@bootlin.com>
        <cc9417a3-ef86-bb46-9519-cf65b03b5f08@infradead.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Wed, 9 Aug 2023 07:24:32 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi,
> 
> On 8/9/23 06:27, Herve Codina wrote:
> > diff --git a/drivers/net/wan/framer/Kconfig b/drivers/net/wan/framer/Kconfig
> > new file mode 100644
> > index 000000000000..96ef1e7ba8eb
> > --- /dev/null
> > +++ b/drivers/net/wan/framer/Kconfig
> > @@ -0,0 +1,19 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# FRAMER
> > +#
> > +
> > +menu "Framer Subsystem"
> > +
> > +config GENERIC_FRAMER
> > +	bool "Framer Core"  
> 
> Just curious: any reason that this cannot be tristate (i.e., a loadable module)?
> Thanks.

For the same reasons as generic phy cannot be built as module
  b51fbf9fb0c3 phy-core: Don't allow building phy-core as a module

In the framer case, this allows to have the QMC HDLC driver built on systems
without any framers (no providers and no framer core framework).
Also the framer phandle is optional in the device tree QMC HDLC node.

Regards,
Hervé

> 
> > +	help
> > +	  Generic Framer support.
> > +
> > +	  This framework is designed to provide a generic interface for framer
> > +	  devices present in the kernel. This layer will have the generic
> > +	  API by which framer drivers can create framer using the framer
> > +	  framework and framer users can obtain reference to the framer.
> > +	  All the users of this framework should select this config.
> > +
> > +endmenu  
> 



-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
