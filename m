Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358FF7BF5E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442853AbjJJIaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442845AbjJJIaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:30:15 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804CFB7;
        Tue, 10 Oct 2023 01:30:03 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 182D9E0008;
        Tue, 10 Oct 2023 08:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696926600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NaOw8PSc0VULjmhxAa6nnKNT5QXhrjoUDdxFuVyTpCM=;
        b=d2/GYvHBSkcMRXi9pmcOlLcCOzYlqnrIh22gZ99/gFbL/M7ys56o4fhkMnDPId8GrsjWCC
        5ouyZmnYSGtztbw5b3KORr9N47KIDYuaBQUiGc3Xf/ZDdUH8+/jT/SFGq05ljDkT54hN13
        hx19s0wFiBqyB6uDlurPSlGYgMd3j25Og2nZrBv+EZ8JoEtmpYOsJTJFZCGD6qgRxTFCDK
        FZ/Gn35OaUtNi/MGYMXczmwjExd6qASdYRlrPa0Xtf0BY5UrQHKeqALrbgvp/3zYz4JUyV
        QEMOADOF32CCiQH10GW8t3f+hFHXxsyHOaUNrGK7QRLSZ6PLjrkZyGoU9RNvDQ==
Date:   Tue, 10 Oct 2023 10:29:45 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 26/30] net: wan: framer: Add support for the Lantiq
 PEF2256 framer
Message-ID: <20231010102945.39c27b1d@bootlin.com>
In-Reply-To: <20231006150252.6d45be95@kernel.org>
References: <20230928070652.330429-1-herve.codina@bootlin.com>
        <20230928070652.330429-27-herve.codina@bootlin.com>
        <20231006150252.6d45be95@kernel.org>
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

Hi Jakub,

On Fri, 6 Oct 2023 15:02:52 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 28 Sep 2023 09:06:44 +0200 Herve Codina wrote:
> > +	for (i = 0; i < count; i++) {
> > +		(audio_devs + i)->name = "framer-codec";
> > +		(audio_devs + i)->of_compatible = compatible;
> > +		(audio_devs + i)->id = i;  
> 
> Why not array notation?

Will be change in the next iteration.

> 
> > +	}
> > +
> > +	ret = mfd_add_devices(pef2256->dev, 0, audio_devs, count, NULL, 0, NULL);  
> 
> Should Lee be CCed for the MFD part?

Will be added to the CC list.

Best regards,
Hervé
