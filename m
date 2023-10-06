Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B7E7BC208
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjJFWIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjJFWIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:08:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42D4DB;
        Fri,  6 Oct 2023 15:08:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CD3C433C7;
        Fri,  6 Oct 2023 22:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696630092;
        bh=S/N63H4X+QPAGfS1YS/mBfx58DuAbwAsy+1fq8W1EuY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lqqUlsyH7HQbKjX6+5MZaW5p3Joc5/jp6VffbnbSi4frEd/pPhmgULRdlX5REnhpP
         BK2xli8u32zh+fkxpuHUOLaTi6MD1PXmD4uaT4ger+hlNVtAIdfLCOrFRtKzFzQdQz
         2sQXEvvtRBzYF6TTKxDU1a+OboOZzIkfFfzieoDXlciUuulj9kl61ww0wJPKsFKgrl
         bG0J56gOoLjF3VNIh6eD3ijl/+KNdaIHPaK1qZBx8m+Qm/Nj6jA1it1GsSd/KDmDTO
         8t97yI7Q9ito8x5R+7R8OzvwKOZlUfEqCdWiEARsL6pB/CF8A3b9DgN6yKbMV0niw2
         jzXwcskBcwReg==
Date:   Fri, 6 Oct 2023 15:08:10 -0700
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
Subject: Re: [PATCH v7 24/30] net: wan: Add framer framework support
Message-ID: <20231006150810.09e2c1a9@kernel.org>
In-Reply-To: <20230928070652.330429-25-herve.codina@bootlin.com>
References: <20230928070652.330429-1-herve.codina@bootlin.com>
        <20230928070652.330429-25-herve.codina@bootlin.com>
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

On Thu, 28 Sep 2023 09:06:42 +0200 Herve Codina wrote:
> +menu "Framer Subsystem"
> +
> +config GENERIC_FRAMER
> +	bool "Framer Core"
> +	help
> +	  Generic Framer support.
> +	  A framer is a component in charge of an E1/T1 line interface.
> +	  Connected usually to a TDM bus, it converts TDM frames to/from E1/T1
> +	  frames. It also provides information related to the E1/T1 line.
> +	  Used with HDLC, the network can be reached through the E1/T1 line.
> +
> +	  This framework is designed to provide a generic interface for framer
> +	  devices present in the kernel. This layer will have the generic
> +	  API by which framer drivers can create framer using the framer
> +	  framework and framer users can obtain reference to the framer.
> +	  All the users of this framework should select this config.

maybe make the menu a menuconfig with info about framers but hide 
the GENERIC_FRAMER symbol? The driver 'select' it anyway, what's
the point of prompting the user..

> +	if (WARN_ON(!dev))
> +		return ERR_PTR(-EINVAL);

no defensive programming, let the kernel crash

> +	ret = framer_pm_runtime_get_sync(framer);
> +	if (ret < 0 && ret != -EOPNOTSUPP)
> +		goto err_pm_sync;
> +
> +	ret = 0; /* Override possible ret == -EOPNOTSUPP */

This looks pointless given that ret is either overwritten or not used
later on

> +	mutex_lock(&framer->mutex);
> +	if (framer->power_count == 0 && framer->ops->power_on) {
> +		ret = framer->ops->power_on(framer);
> +		if (ret < 0) {
> +			dev_err(&framer->dev, "framer poweron failed --> %d\n", ret);
> +			goto err_pwr_on;
> +		}
> +	}
> +	++framer->power_count;
> +	mutex_unlock(&framer->mutex);
> +	return 0;
