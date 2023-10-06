Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5667BC1F5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjJFWC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjJFWCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:02:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CAEBE;
        Fri,  6 Oct 2023 15:02:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C4CC433C7;
        Fri,  6 Oct 2023 22:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696629774;
        bh=5qNpTHdPbPHNPOq+CPvh8QULUoFCrWL4op5DAxKIpGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mr5hNZS7cPEC9fZ9Pm1otMuyEoQtn5x0MebbmvDKT1ysxZd56Xx+tCIEM8QZkQ0Rx
         2HUNxrgaPRHz8QjWANUbD1mH6curuCdl6HomjYf2KnrCtmGyAAnY5ufgjcVH8v/6jb
         QG2jDbcpxxyNYg4G8snQQRAUJZiH1mXGOYt8SQQGeANRY51XoIQTOlWK6yuYXJMFzl
         JuNX4YzwFq+kxxRqEiTycDfkPmkv5j5xhBajGBUP1pMm0yb+NbugndmWBLihXxE3sN
         +UAuDIx49s6xJ7b8nNHq77RCfPL2Bx0miv1JSuqRDSCA4eQG0Z9vQ8/jx1890NcVXF
         fyDg6rJJsfGGg==
Date:   Fri, 6 Oct 2023 15:02:52 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
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
Message-ID: <20231006150252.6d45be95@kernel.org>
In-Reply-To: <20230928070652.330429-27-herve.codina@bootlin.com>
References: <20230928070652.330429-1-herve.codina@bootlin.com>
        <20230928070652.330429-27-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 09:06:44 +0200 Herve Codina wrote:
> +	for (i = 0; i < count; i++) {
> +		(audio_devs + i)->name = "framer-codec";
> +		(audio_devs + i)->of_compatible = compatible;
> +		(audio_devs + i)->id = i;

Why not array notation?

> +	}
> +
> +	ret = mfd_add_devices(pef2256->dev, 0, audio_devs, count, NULL, 0, NULL);

Should Lee be CCed for the MFD part?
