Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23367FF85C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346413AbjK3RfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346136AbjK3RfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:35:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE9810D1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:35:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65B5C433C8;
        Thu, 30 Nov 2023 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701365719;
        bh=8tB+d3+DCHPtwWHOb3AAbeDRc2KBSaXv3m0Macm8Qh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YM+oXZR12HQ5LY5CCuIiplh3+5Mv37hmnRcJWaur+3vbaiTwqtyaeEUFiOXMawL0m
         5dBlsmcVPt3+fZHE2Jr8/cAEobFZxP7z85UaMo+SvwPnf3W0Pn7SfUYLD5yTaV0dov
         hQVSui3wQfuWv9PHPxa2H3Js4WpDsnQnH7acW1UhC4QwQNzIg2qFotSgANuMRY7DUt
         9tTNjQkTuZ4d6HMt3rCEGMFyQXxHb+9GNPTYgw2JRqa72OJplwMFxBYaUtvIXmJJSQ
         8Ro8oa+J+PsuDpkE4ilkXCaMZXvZ5+yI4GGZSDxM3H260gjuq64M/CaE8gnwKUOYP1
         Ist+fnuVzc5ng==
Date:   Thu, 30 Nov 2023 17:35:12 +0000
From:   Simon Horman <horms@kernel.org>
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, p.zabel@pengutronix.de,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        wsa+renesas@sang-engineering.com, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 13/13] net: ravb: Add runtime PM support
Message-ID: <20231130173512.GI32077@kernel.org>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120084606.4083194-14-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120084606.4083194-14-claudiu.beznea.uj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:46:06AM +0200, Claudiu wrote:

...

>  		}
>  	}
>  
> +	error = ravb_pm_runtime_get(priv);
> +	if (error < 0)
> +		return error;

Hi Claudiu,

the error handling doesn't seem right here.
I think you need:

		goto out_free_irq_mgmta;

> +
>  	/* Device init */
>  	error = ravb_dmac_init(ndev);
>  	if (error)
> -		goto out_free_irq_mgmta;
> +		goto pm_runtime_put;
>  	ravb_emac_init(ndev);
>  
>  	/* Initialise PTP Clock driver */
> @@ -1820,7 +1862,8 @@ static int ravb_open(struct net_device *ndev)
>  	if (info->gptp)
>  		ravb_ptp_stop(ndev);
>  	ravb_stop_dma(ndev);
> -out_free_irq_mgmta:
> +pm_runtime_put:
> +	ravb_pm_runtime_put(priv);

And the out_free_irq_mgmta label should go here.

Flagged by Smatch.

>  	if (!info->multi_irqs)
>  		goto out_free_irq;
>  	if (info->err_mgmt_irqs)

...
