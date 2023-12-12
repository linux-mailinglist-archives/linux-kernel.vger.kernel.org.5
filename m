Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C5280F9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377666AbjLLVuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377532AbjLLVuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:50:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC9BD3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:50:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FF1C433C7;
        Tue, 12 Dec 2023 21:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702417805;
        bh=6ogrBXo4J5g4zBXsQOlW0y4FIDZEwSmJ8vaSdXm00eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rzsvwnlo32fqTtf3/7LvOn0kX55GFA+RKbr8qR84zmtyBxBr8Z27rXb4U/6Pub9MR
         SZPALCeQvn2083UU6DzF9G7YUneqS+diLCLU8LotEsI+v9qPOxZhj11odGxvk5n6Iu
         yYJwm5kUuY6Vy6D9LYgAhKLUqWGU9OnXxgbB18lXh+hcvu9SPljiZMuBhOwujYPV8b
         x5LlP7Gs6hZTDH8OmivofNGvAtf7K8ZIEwfbXCbp83wdffTbNJmxqjofNZEOFXBNyK
         0sZ4swf7yt8LFaX5CAqYXb07ZoIeMFPXObopMU3OU3jhLSRBwnsDhIjjrrajdlI1xP
         MnbKaOMp5BiWw==
Date:   Tue, 12 Dec 2023 14:50:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] power: reset: at91: mark at91_wakeup_status non-__init
Message-ID: <20231212215002.GA3300655@dev-arch.thelio-3990X>
References: <20231212214658.213510-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212214658.213510-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:46:49PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Two copies of the at91_wakeup_status() function are called by the
> respective probe() callbacks and are marked __init, but the probe
> functions are no longer annotated that way. This works with gcc because
> the functions always get inlined, but clang keeps them separate, which
> can lead to executing freed memory:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: at91_poweroff_probe+0x80 (section: .text) -> at91_wakeup_status (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: at91_shdwc_probe+0xcc (section: .text) -> at91_wakeup_status (section: .init.text)
> 
> Drop the incorrect annotation on these.
> 
> Fixes: 099806de68b7 ("power: reset: at91-poweroff: Stop using module_platform_driver_probe()")
> Fixes: dde74a5de817 ("power: reset: at91-sama5d2_shdwc: Stop using module_platform_driver_probe()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, I sent the same change three weeks ago at this point:

https://lore.kernel.org/20231120-fix-at91-modpost-warnings-v1-1-813671933863@kernel.org/

Your commit message is a little better than mine and I don't really care
which one goes in but it would be good if this could get cleared up
soon...

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/power/reset/at91-poweroff.c      | 2 +-
>  drivers/power/reset/at91-sama5d2_shdwc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
> index 126e774e210c..93eece027865 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -57,7 +57,7 @@ static struct shdwc {
>  	void __iomem *mpddrc_base;
>  } at91_shdwc;
>  
> -static void __init at91_wakeup_status(struct platform_device *pdev)
> +static void at91_wakeup_status(struct platform_device *pdev)
>  {
>  	const char *reason;
>  	u32 reg = readl(at91_shdwc.shdwc_base + AT91_SHDW_SR);
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index af95c7b39cb3..959ce0dbe91d 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -107,7 +107,7 @@ static const unsigned long long sdwc_dbc_period[] = {
>  	0, 3, 32, 512, 4096, 32768,
>  };
>  
> -static void __init at91_wakeup_status(struct platform_device *pdev)
> +static void at91_wakeup_status(struct platform_device *pdev)
>  {
>  	struct shdwc *shdw = platform_get_drvdata(pdev);
>  	const struct reg_config *rcfg = shdw->rcfg;
> -- 
> 2.39.2
> 
> 
