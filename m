Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE28F7DC1EA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjJ3Vbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjJ3Vbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:31:51 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9EE1;
        Mon, 30 Oct 2023 14:31:49 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b40d5ea323so3087114b6e.0;
        Mon, 30 Oct 2023 14:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698701508; x=1699306308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuBaURUuWJkEQpbZhWeSxspKPPb+Lr69ekE2ADTt8Wc=;
        b=ctMEZumrolkdnjByFGUWOWQUVnxi61WDindnpVDBDNpzKALR2zuRQXMFQv3Jd5iooU
         x51LimDOvJH9znKkaZBhlkoRhXWRNxjsMq/XXpLbkWnxQLvwxODQNvNc0TaibUEYD6lA
         R6CvOWkxJV00ZYY8USh6XMIS+KnNY1HFJI0E+3j1TQ1J6h8Bmo/YDvAf1mzP8Pmr4HkX
         hmBE/1R/U3ZVuG6TFwInTBUqd0YBqkwIXfN8r3aee0MO8VZK6u6BpfiwS+3tMrsw0MPl
         qoPctdqhQQJKi9h4NHptdoJZv7POl3t7K9Q4APAXB42kYVEoNgDSjMEKA0jHBrXFnrGg
         JfeA==
X-Gm-Message-State: AOJu0YyAIfB3gcDoPI56bcesX54lm/i11vsNoxr0EJnYzGiVMr9pB7Oo
        XqqBGB66HsM4a05SG4tpDg==
X-Google-Smtp-Source: AGHT+IGKuby//PdBhTBpw28HsYfEui30ghahooRRo1gU9DZgJ7OM+SQsCkxRsIdIYwyzeeSbhBnk8w==
X-Received: by 2002:a05:6808:1789:b0:3ae:554b:9c97 with SMTP id bg9-20020a056808178900b003ae554b9c97mr14084990oib.37.1698701508322;
        Mon, 30 Oct 2023 14:31:48 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e22-20020a05680809b600b003afc33bf048sm1518710oig.2.2023.10.30.14.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:31:47 -0700 (PDT)
Received: (nullmailer pid 2495794 invoked by uid 1000);
        Mon, 30 Oct 2023 21:31:46 -0000
Date:   Mon, 30 Oct 2023 16:31:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>,
        Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
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
Subject: Re: [PATCH v8 00/30] Add support for QMC HDLC, framer infrastructure
 and PEF2256 framer
Message-ID: <20231030213146.GA2490536-robh@kernel.org>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
 <20231013164647.7855f09a@kernel.org>
 <20231025170051.27dc83ea@bootlin.com>
 <20231025123215.5caca7d4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025123215.5caca7d4@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 12:32:15PM -0700, Jakub Kicinski wrote:
> On Wed, 25 Oct 2023 17:00:51 +0200 Herve Codina wrote:
> > > Which way will those patches go? Via some FSL SoC tree?  
> > 
> > This series seems mature now.
> > What is the plan next in order to have it applied ?
> > 
> > Don't hesitate to tell me if you prefer split series.
> 
> FWIW we are happy to take the drivers/net/ parts if there is no hard
> dependency. But there's no point taking that unless the SoC bits
> also go in for 6.7.
> 
> Li Yang, what are your expectations WRT merging this series?

I think it is too late for SoC stuff for 6.7. 

I picked up binding patches 6, 7, and 8 because 6 and 7 are the same as 
an additionalProperties fix I have in my tree. As 8 depends on them, I 
just picked it up too.

Rob
