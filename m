Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7013D761EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGYQlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGYQlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:41:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E698310F7;
        Tue, 25 Jul 2023 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=VOpi6FeyBBxDJ9AWuyvGv6z4rjqWqlFn0g7noxTOdPg=; b=OE0Yv0C1dfCRicRWSmNMM59Dgv
        MSlzOqH2FV32nJBQJYdaqktbAXnisAv4pM7CWD5mP9T7qa9mLIz8K9Ttq4APloaqzMCPgRMRhlsS/
        muNPAvD9OZaUubBkxJZvQp1mw6eIdlwtFYM3JoCaGNhX/kBG+VrMhTclgrlCHqbDInmNRjBuZE1rJ
        miJiFycFAZZ8O+qr9Lk/9p72vtqzNt4lDguzRfxt3Kx5aWulYjUwyyPDyD+I+qFRnn/HclzHEHzUA
        UtHYz2xsCpPl/gEJBy/hGRuLEzy4irKjnW8K0JJrZkxj8GlXfp8f9fi4l2nTMdRRrYaQTpTls0+vh
        uXR7iMsA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOL64-0083WK-1X;
        Tue, 25 Jul 2023 16:41:16 +0000
Message-ID: <ce045e96-e9b6-ae66-dd54-67a958ca1774@infradead.org>
Date:   Tue, 25 Jul 2023 09:41:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 24/26] ASoC: codecs: Add support for the framer codec
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
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
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230725092417.43706-1-herve.codina@bootlin.com>
 <20230725092417.43706-25-herve.codina@bootlin.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230725092417.43706-25-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/23 02:24, Herve Codina wrote:
> +config SND_SOC_FRAMER
> +	tristate "Framer codec"
> +	depends on GENERIC_FRAMER
> +	help
> +	  Enable support for the framer codec.
> +	  The framer codec uses the generic framer infrastructure to transport
> +	  some audio data over an analog E1/T1/J1 line.
> +	  This codec allows to use some of the time slots available on the TDM
> +	  bus on with the framer is connected to transport the audio data.

	      on which

> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called snd-soc-framer.

-- 
~Randy
