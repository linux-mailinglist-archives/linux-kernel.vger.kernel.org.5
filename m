Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558F476B1D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjHAKaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjHAKam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:30:42 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602E492;
        Tue,  1 Aug 2023 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=KeOeZN8j1Kv4rdUg/08Xyr1q7VbFfZ43LqMnjplQud8=; b=eiy6XJ1+OayMv3ZjecdJgWMT9C
        Uv5GOK/vQES7nI9CpL7KwfXjXVd5FKQnbNysWgmJl1slR3hFYDF+ttduAxM75xNKTR3wYVnCt6KOh
        oJmD9ziJMqaYZvpmHWHL2O+EqtZWvujJfqSoTNm77Ddkj4YFYzYuus4k8aBdjREqinVo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qQme2-002n9O-R9; Tue, 01 Aug 2023 12:30:26 +0200
Date:   Tue, 1 Aug 2023 12:30:26 +0200
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
Subject: Re: [PATCH v2 26/28] ASoC: codecs: Add support for the framer codec
Message-ID: <2e253048-a36e-4fee-b2f4-22f19230cf54@lunn.ch>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
 <20230726150225.483464-27-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726150225.483464-27-herve.codina@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 05:02:22PM +0200, Herve Codina wrote:
> The framer codec interracts with a framer.
> It allows to use some of the framer timeslots as audio channels to
> transport audio data over the framer E1/T1/J1 lines.
> It also reports line carrier detection events through the ALSA jack
> detection feature.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  sound/soc/codecs/Kconfig        |  15 ++
>  sound/soc/codecs/Makefile       |   2 +
>  sound/soc/codecs/framer-codec.c | 423 ++++++++++++++++++++++++++++++++
>  3 files changed, 440 insertions(+)
>  create mode 100644 sound/soc/codecs/framer-codec.c
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index f99203ef9b03..a86cdac39b72 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -110,6 +110,7 @@ config SND_SOC_ALL_CODECS
>  	imply SND_SOC_ES8328_I2C
>  	imply SND_SOC_ES7134
>  	imply SND_SOC_ES7241
> +	imply SND_SOC_FRAMER
>  	imply SND_SOC_GTM601
>  	imply SND_SOC_HDAC_HDMI
>  	imply SND_SOC_HDAC_HDA
> @@ -1043,6 +1044,20 @@ config SND_SOC_ES8328_SPI
>  	depends on SPI_MASTER
>  	select SND_SOC_ES8328
>  
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
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called snd-soc-framer.
> +
> +
>  config SND_SOC_GTM601
>  	tristate 'GTM601 UMTS modem audio codec'
>  
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 32dcc6de58bd..54667274a0f6 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -116,6 +116,7 @@ snd-soc-es8326-objs := es8326.o
>  snd-soc-es8328-objs := es8328.o
>  snd-soc-es8328-i2c-objs := es8328-i2c.o
>  snd-soc-es8328-spi-objs := es8328-spi.o
> +snd-soc-framer-objs := framer-codec.o
>  snd-soc-gtm601-objs := gtm601.o
>  snd-soc-hdac-hdmi-objs := hdac_hdmi.o
>  snd-soc-hdac-hda-objs := hdac_hda.o
> @@ -499,6 +500,7 @@ obj-$(CONFIG_SND_SOC_ES8326)    += snd-soc-es8326.o
>  obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
>  obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
>  obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
> +obj-$(CONFIG_SND_SOC_FRAMER)	+= snd-soc-framer.o
>  obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
>  obj-$(CONFIG_SND_SOC_HDAC_HDMI) += snd-soc-hdac-hdmi.o
>  obj-$(CONFIG_SND_SOC_HDAC_HDA) += snd-soc-hdac-hda.o
> diff --git a/sound/soc/codecs/framer-codec.c b/sound/soc/codecs/framer-codec.c
> new file mode 100644
> index 000000000000..52b4546a61ee
> --- /dev/null
> +++ b/sound/soc/codecs/framer-codec.c
> @@ -0,0 +1,423 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Framer ALSA SoC driver
> +//
> +// Copyright 2023 CS GROUP France
> +//
> +// Author: Herve Codina <herve.codina@bootlin.com>
> +
> +#include <linux/clk.h>
> +#include <linux/framer/framer.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <sound/jack.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/tlv.h>
> +
> +#define FRAMER_NB_CHANNEL	32
> +#define FRAMER_JACK_MASK (SND_JACK_LINEIN | SND_JACK_LINEOUT)
> +
> +struct framer_codec {
> +	struct framer *framer;
> +	struct device *dev;
> +	struct snd_soc_jack jack;
> +	struct notifier_block nb;
> +	struct work_struct carrier_work;
> +	int max_chan_playback;
> +	int max_chan_capture;
> +};
> +
> +static int framer_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
> +				   unsigned int rx_mask, int slots, int width)
> +{
> +	struct framer_codec *framer = snd_soc_component_get_drvdata(dai->component);
> +
> +	switch (width) {
> +	case 0:
> +		/* Not set -> default 8 */
> +	case 8:
> +		break;
> +	default:
> +		dev_err(dai->dev, "tdm slot width %d not supported\n", width);
> +		return -EINVAL;
> +	}
> +
> +	framer->max_chan_playback = hweight32(tx_mask);
> +	if (framer->max_chan_playback > FRAMER_NB_CHANNEL) {
> +		dev_err(dai->dev, "too much tx slots defined (mask = 0x%x) support max %d\n",

"many", not "much".

Also, "supported".

      Andrew
