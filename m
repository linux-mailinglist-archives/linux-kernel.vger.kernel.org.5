Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC39780FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378474AbjHRQLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378477AbjHRQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:10:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4C030F3;
        Fri, 18 Aug 2023 09:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4A76611F4;
        Fri, 18 Aug 2023 16:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65662C433C8;
        Fri, 18 Aug 2023 16:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692375044;
        bh=92lIiukMG0yN5rbB/xvTrlXq9iNH0UDN9N143jJIljE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MM/dOXny8x+CcyEOHoaUyqAWJHhSHPgVPNcBHV0Sa1UKC5pu56hQIhFFaKcV+Vnry
         JaF6edNIABJnMqgXamZus4htecG7AquOcHbsJv4n5Pb+ZCedVtNLjLCpJpCMPK/cl8
         ZozLtH6AjgCwi5O8drHX/gEyTB0YlezmY4jOM9w3V63hSIkJcNXag2Yy6jmWPHcPLL
         IwydNDNG79mcxxgtfefHrz/Ie3X3zWH5SeTqZP5s+gDhlH1izhuptFFF8pV/4hqvK0
         fW4KPzaR86cAdAdFb+OkXyyeT96yqlPShaafpY/uRp85K5BwSiNfCKOM5/87vKvbuo
         4wCpVipsFTKow==
Date:   Fri, 18 Aug 2023 17:10:38 +0100
From:   Lee Jones <lee@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        peng.fan@oss.nxp.com, rafael.j.wysocki@intel.com,
        Jerome Neanne <jneanne@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH v2 4/6] mfd: tps65219: Specify restart mode
Message-ID: <20230818161038.GB986605@google.com>
References: <20230809-pca9450-reboot-v2-0-b98b4f8139d5@skidata.com>
 <20230809-pca9450-reboot-v2-4-b98b4f8139d5@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809-pca9450-reboot-v2-4-b98b4f8139d5@skidata.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023, Benjamin Bara wrote:

> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> The current restart handler registration does not specify whether the
> restart is a cold or a warm one. Instead, cold ones are typically
> registered with a HIGH prio. Now, as do_kernel_restart() knows about the
> type, the priorization is implicitly done (cold restarts are executed
> first) and the reboot_mode kernel parameter (which is currently mostly
> ignored) can be respected.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
> v2:
> - improve commit message
> ---
>  drivers/mfd/tps65219.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
> index 0e0c42e4fdfc..85752b93256e 100644
> --- a/drivers/mfd/tps65219.c
> +++ b/drivers/mfd/tps65219.c
> @@ -278,12 +278,21 @@ static int tps65219_probe(struct i2c_client *client)
>  		}
>  	}
>  
> -	ret = devm_register_restart_handler(tps->dev,
> -					    tps65219_restart_handler,
> -					    tps);
> +	ret = devm_register_cold_restart_handler(tps->dev,
> +						 tps65219_restart_handler,
> +						 tps);
>  
>  	if (ret) {
> -		dev_err(tps->dev, "cannot register restart handler, %d\n", ret);
> +		dev_err(tps->dev, "cannot register cold restart handler, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_register_warm_restart_handler(tps->dev,
> +						 tps65219_restart_handler,
> +						 tps);
> +

Sorry, why do we have to now register 2 restart handlers?

Seems like a regression?

> +	if (ret) {
> +		dev_err(tps->dev, "cannot register warm restart handler, %d\n", ret);
>  		return ret;
>  	}
>  
> 
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
