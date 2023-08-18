Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CE47815BE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 01:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242408AbjHRXSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 19:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242393AbjHRXSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 19:18:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E117B4205;
        Fri, 18 Aug 2023 16:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=LRQRZPdrv4QI8bQQoUTKBOoMNyJa1LbrbkfjcCc8uZw=; b=vkl51uAgZ2coNgQgP/P4b8/ozl
        CFZbSnec4ohA+rkE1H92ceFU7AiniNCuavWVyoH+RyBPtjuVUujA6tVAn0aKhzlJk5cRfdds56VFv
        yyMQXQO0bhc7s3zU31cE4b8FwZSyl2wQSdKL0PeJhOs/X4xKGhiQcWiWslcEMhB89CeaPQ0bF6qIx
        NOpTOoT34ekpDhGPB/jkuU5NCH9HH0vAdwT13mclegA8ucop3r+npiuv4n5YQ7mb53OC6ld6DFrZ0
        a0d8CX0NKx6XMbylqHUv7n+TK5Df613wD3hawMRTVHw7ALG868QMRyGCCLxRXRAtPH8xLhJ2pZUBC
        ef7BHUKA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qX8jS-00A9bg-1P;
        Fri, 18 Aug 2023 23:18:18 +0000
Message-ID: <e1ca6c2f-92e4-6dad-79ec-71cf66e9a385@infradead.org>
Date:   Fri, 18 Aug 2023 16:18:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 27/28] ASoC: codecs: Add support for the framer codec
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
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
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
 <cb734efe2eeb89cb1afbf01d3625181537e2850f.1692376361.git.christophe.leroy@csgroup.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cb734efe2eeb89cb1afbf01d3625181537e2850f.1692376361.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/18/23 09:39, Christophe Leroy wrote:
> +config SND_SOC_FRAMER
> +	tristate "Framer codec"
> +	depends on GENERIC_FRAMER
> +	help
> +	  Enable support for the framer codec.
> +	  The framer codec uses the generic framer infrastructure to transport
> +	  some audio data over an analog E1/T1/J1 line.
> +	  This codec allows to use some of the time slots available on the TDM
> +	  bus on which the framer is connected to transport the audio data.
> +

Just curious: what controls the slot allocations/usages?
Is that done in userspace?

> +	  To compile this driver as a module, choose M here: the module
> +	  will be called snd-soc-framer.

thanks.
-- 
~Randy
