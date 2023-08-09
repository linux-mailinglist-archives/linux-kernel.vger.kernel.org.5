Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7EE776265
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjHIOZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjHIOZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:25:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D654410F5;
        Wed,  9 Aug 2023 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=cOZqaDWc3HsuU0Akcti+SHi//L0WYRljfoUAHEI5Mb4=; b=Qx9jDdZ8kaM/1t4qA31vsj3BF8
        dJrmsjumeBsxCmbnQgrD4l+9TqTVj2NoRpg930BVIM4FPiFnDXrK3r0dE3c7aPB8z8i2YwInO7to9
        ZmY4RWGF/oukSyMfAB3BtIUJ5a59AUfejt8ckDyqzRpvMTkoqIEH7NE4zEEW7++7Cy/EMtLYo9Pc3
        4TUM8vxLJ1uHstQSOGAsS+ENaeA40kGzBDMDUeYTV9XnYR0ocbLYfozGNsP9hztOYLMxnVn/4L8Wh
        sQORp47ZvgqIrwz5RNsjIYIqnbmiaXa5J9wWUmy6+XkP4b/3HWQ5XJyCA1lPZE1KEy5BCuRV63jGu
        y4IOZS2w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTk72-0059dS-2X;
        Wed, 09 Aug 2023 14:24:36 +0000
Message-ID: <cc9417a3-ef86-bb46-9519-cf65b03b5f08@infradead.org>
Date:   Wed, 9 Aug 2023 07:24:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 21/28] net: wan: Add framer framework support
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
References: <20230809132757.2470544-1-herve.codina@bootlin.com>
 <20230809132757.2470544-22-herve.codina@bootlin.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230809132757.2470544-22-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/9/23 06:27, Herve Codina wrote:
> diff --git a/drivers/net/wan/framer/Kconfig b/drivers/net/wan/framer/Kconfig
> new file mode 100644
> index 000000000000..96ef1e7ba8eb
> --- /dev/null
> +++ b/drivers/net/wan/framer/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# FRAMER
> +#
> +
> +menu "Framer Subsystem"
> +
> +config GENERIC_FRAMER
> +	bool "Framer Core"

Just curious: any reason that this cannot be tristate (i.e., a loadable module)?
Thanks.

> +	help
> +	  Generic Framer support.
> +
> +	  This framework is designed to provide a generic interface for framer
> +	  devices present in the kernel. This layer will have the generic
> +	  API by which framer drivers can create framer using the framer
> +	  framework and framer users can obtain reference to the framer.
> +	  All the users of this framework should select this config.
> +
> +endmenu

-- 
~Randy
