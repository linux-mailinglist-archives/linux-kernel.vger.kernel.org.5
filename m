Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA4E7D705A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbjJYPBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344433AbjJYPBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:01:06 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57711A2;
        Wed, 25 Oct 2023 08:00:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8F43C000F;
        Wed, 25 Oct 2023 15:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698246054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yH7ih/sENBHheaY4sC23vjZWR5QPhO2FB5uDgGmBUEE=;
        b=Q3kFInjh7UIlv2i9yjPV+QU4V85L5o5uVFoPjbdjL//6+E7uHPH6qKo6VtFDApky9mvBZR
        DLu9NkXUD5OxfTo6itNQvOGypacNFCTLN9WVTaPz0FqcOhRwPMyGfxtOcSfDuL7/skp8vX
        Xi0TkyJYpNrsUrKOLGJVtQuYOi+gWoYdjSS/UVjEa2e22L9HGWc4DrymLHD7I/JWSwkFqm
        89zhexE6c2ltXbqig51XVG6K1DOiQZZDzAVHFzwstX5/KXfaw66BE90pcuR8wCZ76roTNp
        RW+shC4dBtvTe/L6r6lvIDt4EzZod8+c2krxeBAs7QIBUwZpDZyN+x2UlhjNHw==
Date:   Wed, 25 Oct 2023 17:00:51 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
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
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 00/30] Add support for QMC HDLC, framer
 infrastructure and PEF2256 framer
Message-ID: <20231025170051.27dc83ea@bootlin.com>
In-Reply-To: <20231013164647.7855f09a@kernel.org>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
        <20231013164647.7855f09a@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All, Maintainers

On Fri, 13 Oct 2023 16:46:47 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 11 Oct 2023 08:14:04 +0200 Herve Codina wrote:
> > Compare to the previous iteration
> >   https://lore.kernel.org/linux-kernel/20230928070652.330429-1-herve.codina@bootlin.com/
> > This v8 series:
> >  - Fixes a race condition
> >  - Uses menuconfig instead of menu and hides CONFIG_GENERIC_FRAMER
> >  - Performs minor changes  
> 
> Which way will those patches go? Via some FSL SoC tree?

This series seems mature now.
What is the plan next in order to have it applied ?

Don't hesitate to tell me if you prefer split series.

Best regards,
Hervé
