Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1A776B220
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjHAKpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjHAKp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:45:27 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15A7F1;
        Tue,  1 Aug 2023 03:45:23 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 779BD20005;
        Tue,  1 Aug 2023 10:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690886722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZU6BOq2ROWRKKk0qgc0ZNhhDzXJUcmNvZZuf7GrZzjo=;
        b=Oc6zt7+77zObe/f5CmDZ0M8Jgr8PHns5FKzn7jXnxNkGsS0tyLuEFojbJ3/S4jVcncnwQ+
        +3rB0rL37KYriDQYcsbkjQ5hLwCekAnFOcoOb+blf6WeIcv/rf8dAW3VOUVo42pi733dbR
        XTnnmJClvcpQhEraY3Tr2pnqwSWiQtyKeqZB/gZ5AD3NwfW2dfvnoGkvdcw+U9b3vOjWlm
        +jUiku88t+6hEIP3nWtNEIA7dlNnbwYJwe41xd65oL8dJIH442XllAbkqGqP5oBAlSmhq/
        bHRG5FSvDxxcqa5KwbMkOtT7Owd3+1XOrh4Rneg3dl6hIXg6s6SSWxwmAgnjvg==
Date:   Tue, 1 Aug 2023 12:45:17 +0200
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
Subject: Re: [PATCH v2 26/28] ASoC: codecs: Add support for the framer codec
Message-ID: <20230801124517.6b6009f5@bootlin.com>
In-Reply-To: <2e253048-a36e-4fee-b2f4-22f19230cf54@lunn.ch>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
        <20230726150225.483464-27-herve.codina@bootlin.com>
        <2e253048-a36e-4fee-b2f4-22f19230cf54@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 12:30:26 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Jul 26, 2023 at 05:02:22PM +0200, Herve Codina wrote:
> > The framer codec interracts with a framer.
> > It allows to use some of the framer timeslots as audio channels to
> > transport audio data over the framer E1/T1/J1 lines.
> > It also reports line carrier detection events through the ALSA jack
> > detection feature.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  sound/soc/codecs/Kconfig        |  15 ++
> >  sound/soc/codecs/Makefile       |   2 +
> >  sound/soc/codecs/framer-codec.c | 423 ++++++++++++++++++++++++++++++++
> >  3 files changed, 440 insertions(+)
> >  create mode 100644 sound/soc/codecs/framer-codec.c
> > 
> > diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> > index f99203ef9b03..a86cdac39b72 100644
> > --- a/sound/soc/codecs/Kconfig
> > +++ b/sound/soc/codecs/Kconfig
> > @@ -110,6 +110,7 @@ config SND_SOC_ALL_CODECS
> >  	imply SND_SOC_ES8328_I2C
> >  	imply SND_SOC_ES7134
> >  	imply SND_SOC_ES7241
> > +	imply SND_SOC_FRAMER
> >  	imply SND_SOC_GTM601
> >  	imply SND_SOC_HDAC_HDMI
> >  	imply SND_SOC_HDAC_HDA
> > @@ -1043,6 +1044,20 @@ config SND_SOC_ES8328_SPI
> >  	depends on SPI_MASTER
> >  	select SND_SOC_ES8328
> >  
> > +config SND_SOC_FRAMER
> > +	tristate "Framer codec"
> > +	depends on GENERIC_FRAMER
> > +	help
> > +	  Enable support for the framer codec.
> > +	  The framer codec uses the generic framer infrastructure to transport
> > +	  some audio data over an analog E1/T1/J1 line.
> > +	  This codec allows to use some of the time slots available on the TDM
> > +	  bus on which the framer is connected to transport the audio data.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called snd-soc-framer.
> > +
> > +
> >  config SND_SOC_GTM601
> >  	tristate 'GTM601 UMTS modem audio codec'
> >  
> > diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> > index 32dcc6de58bd..54667274a0f6 100644
> > --- a/sound/soc/codecs/Makefile
> > +++ b/sound/soc/codecs/Makefile
> > @@ -116,6 +116,7 @@ snd-soc-es8326-objs := es8326.o
> >  snd-soc-es8328-objs := es8328.o
> >  snd-soc-es8328-i2c-objs := es8328-i2c.o
> >  snd-soc-es8328-spi-objs := es8328-spi.o
> > +snd-soc-framer-objs := framer-codec.o
> >  snd-soc-gtm601-objs := gtm601.o
> >  snd-soc-hdac-hdmi-objs := hdac_hdmi.o
> >  snd-soc-hdac-hda-objs := hdac_hda.o
> > @@ -499,6 +500,7 @@ obj-$(CONFIG_SND_SOC_ES8326)    += snd-soc-es8326.o
> >  obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
> >  obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
> >  obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
> > +obj-$(CONFIG_SND_SOC_FRAMER)	+= snd-soc-framer.o
> >  obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
> >  obj-$(CONFIG_SND_SOC_HDAC_HDMI) += snd-soc-hdac-hdmi.o
> >  obj-$(CONFIG_SND_SOC_HDAC_HDA) += snd-soc-hdac-hda.o
> > diff --git a/sound/soc/codecs/framer-codec.c b/sound/soc/codecs/framer-codec.c
> > new file mode 100644
> > index 000000000000..52b4546a61ee
> > --- /dev/null
> > +++ b/sound/soc/codecs/framer-codec.c
> > @@ -0,0 +1,423 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Framer ALSA SoC driver
> > +//
> > +// Copyright 2023 CS GROUP France
> > +//
> > +// Author: Herve Codina <herve.codina@bootlin.com>
> > +
> > +#include <linux/clk.h>
> > +#include <linux/framer/framer.h>
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <sound/jack.h>
> > +#include <sound/pcm_params.h>
> > +#include <sound/soc.h>
> > +#include <sound/tlv.h>
> > +
> > +#define FRAMER_NB_CHANNEL	32
> > +#define FRAMER_JACK_MASK (SND_JACK_LINEIN | SND_JACK_LINEOUT)
> > +
> > +struct framer_codec {
> > +	struct framer *framer;
> > +	struct device *dev;
> > +	struct snd_soc_jack jack;
> > +	struct notifier_block nb;
> > +	struct work_struct carrier_work;
> > +	int max_chan_playback;
> > +	int max_chan_capture;
> > +};
> > +
> > +static int framer_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
> > +				   unsigned int rx_mask, int slots, int width)
> > +{
> > +	struct framer_codec *framer = snd_soc_component_get_drvdata(dai->component);
> > +
> > +	switch (width) {
> > +	case 0:
> > +		/* Not set -> default 8 */
> > +	case 8:
> > +		break;
> > +	default:
> > +		dev_err(dai->dev, "tdm slot width %d not supported\n", width);
> > +		return -EINVAL;
> > +	}
> > +
> > +	framer->max_chan_playback = hweight32(tx_mask);
> > +	if (framer->max_chan_playback > FRAMER_NB_CHANNEL) {
> > +		dev_err(dai->dev, "too much tx slots defined (mask = 0x%x) support max %d\n",  
> 
> "many", not "much".
> 
> Also, "supported".

Yes, will be fixed.

Regards,
Hervé
