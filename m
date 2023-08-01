Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E4176B1DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjHAKcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjHAKcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:32:10 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1450B92;
        Tue,  1 Aug 2023 03:32:07 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C9FB6000B;
        Tue,  1 Aug 2023 10:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690885926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=crWIDh8u3C6yGMtEBsqKiRUmuQ9xvfip/08OZw3qp2U=;
        b=JxxdURr/SHVVPuDRogfmx5lRXOm41IU5riBIedWEmVuiVqPdUjUgVOzQRcA4n+Mqpm/GKZ
        GxbliO3UUvoreyeNdm3JK8O2QQpHimTInkkjgmimmlJ5XUlMcKE2QY7/fL046n/EPFesxk
        Kpe+Prgr/5Xj8CWh34jTJwxFnzFBu44/qi/zNcAmbKxZu2nWFo2xPnbTvu5AwwTRU6O5kB
        0TIZ5eSZQJiWTjXJfJyuPmvtn+0vzD9VjRdGVGbjfioxvgXogblhab9rMnoKZ0f2NI5/el
        ZJX7GFdpLoLgqvN1aIyOK7N0mehJJpv5Wh4/sjbs5BeuriC3SCdryRdKPIgyXA==
Date:   Tue, 1 Aug 2023 12:32:01 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
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
Subject: Re: [PATCH v2 20/28] net: wan: Add framer framework support
Message-ID: <20230801123201.25dee219@bootlin.com>
In-Reply-To: <84d6431f-bb55-4224-a4a5-45d7036f1e38@lunn.ch>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
        <20230726150225.483464-21-herve.codina@bootlin.com>
        <84d6431f-bb55-4224-a4a5-45d7036f1e38@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 11:56:12 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +int framer_pm_runtime_get(struct framer *framer)
> > +{
> > +	int ret;
> > +
> > +	if (!framer)
> > +		return 0;  
> 
> Can framer be a NULL pointer? This sort of test often covers up
> bugs. So either let it dereference the NULL pointer and opps, or
> return -EINVAL.
> 

Well, in the current usage, it cannot be a NULL pointer.
I will simply remove the check (every where it is present) and
dereference the pointer instead of returning -EINVAL.

Regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
