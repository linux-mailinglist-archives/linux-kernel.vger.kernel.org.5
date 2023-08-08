Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E628A774172
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjHHRUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjHHRUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:20:12 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19A21DD3A;
        Tue,  8 Aug 2023 09:08:07 -0700 (PDT)
Received: from relay5-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::225])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id E5694C6AB4;
        Tue,  8 Aug 2023 09:06:22 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 167A31C000E;
        Tue,  8 Aug 2023 09:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691485578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yV4jZ6QrskrDU/HVotl7NEUNo5CW4ftnk7BIqgEB1+w=;
        b=flZfpRXqaC4cOa0lUVXQGmj6OEssvWZubCe2w5MHqI8U2vWQwtOj0FQFAqgAJBxJ8I75XZ
        I0TZlmNSRmqSWR5xLTIKJ/1FDCZ4stZY0pIriPzLH17o1+eZR+fqsAFgkHhfKw1IeHA6F/
        BRImFTSpS5Rv0R1y0afDagZYKTek8UGg0TZs9w8hjDyqKGA3Umv42FjNTa+dNkNUSu3Gue
        Tx2D6FfesdOvac81rHxEHFQ6xKJfocvJHBN0OnBZAPqs83Owy9ptNTQG7K7UjxPB67/rcA
        8c/v/aUZh+TVfJDMed/1Ph30nJadiv+LXoAjitpDUEWw4zjs+hG26YAH/4HjPQ==
Date:   Tue, 8 Aug 2023 11:06:13 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
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
        Randy Dunlap <rdunlap@infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 26/28] ASoC: codecs: Add support for the framer codec
Message-ID: <20230808110613.07e222a3@bootlin.com>
In-Reply-To: <a1b5120b-feb0-5c87-0605-e1e170d9268d@csgroup.eu>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
        <20230726150225.483464-27-herve.codina@bootlin.com>
        <a1b5120b-feb0-5c87-0605-e1e170d9268d@csgroup.eu>
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

On Tue, 8 Aug 2023 08:26:16 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Le 26/07/2023 à 17:02, Herve Codina a écrit :
> > The framer codec interracts with a framer.
> > It allows to use some of the framer timeslots as audio channels to
> > transport audio data over the framer E1/T1/J1 lines.
> > It also reports line carrier detection events through the ALSA jack
> > detection feature.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> See below
> 
> > +static int framer_dai_hw_rule_channels_by_format(struct snd_soc_dai *dai,
> > +						 struct snd_pcm_hw_params *params,
> > +						 unsigned int nb_ts)
> > +{
> > +	struct snd_interval *c = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
> > +	snd_pcm_format_t format = params_format(params);
> > +	struct snd_interval ch = {0};
> > +
> > +	switch (snd_pcm_format_physical_width(format)) {
> > +	case 8:
> > +		ch.max = nb_ts;
> > +		break;
> > +	case 16:
> > +		ch.max = nb_ts / 2;
> > +		break;
> > +	case 32:
> > +		ch.max = nb_ts / 4;
> > +		break;
> > +	case 64:
> > +		ch.max = nb_ts / 8;
> > +		break;
> > +	default:
> > +		dev_err(dai->dev, "format physical width %u not supported\n",
> > +			snd_pcm_format_physical_width(format));
> > +		return -EINVAL;
> > +	}  
> 
> What about
> 
> 	width = snd_pcm_format_physical_width(format);
> 
> 	if (width == 8 || width == 16 || width == 32 || width == 64) {
> 		ch.max = nb_ts * 8 / width;
> 	} else {
> 		dev_err(dai->dev, "format physical width %u not supported\n", width);
> 		return -EINVAL;
> 	}
> 

Yes, indeed.
Will be changed in the next iteration.

Regards,
Hervé
