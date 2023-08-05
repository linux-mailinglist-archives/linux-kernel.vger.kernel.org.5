Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D77E770E27
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 08:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjHEGnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 02:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHEGnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 02:43:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE00D1BE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 23:42:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F14860A1A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 06:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E345C433C7;
        Sat,  5 Aug 2023 06:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691217771;
        bh=cYmaEUvHLY/7RQQcRtIEJ4CworRRdzVY9ztwu+GARH4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P3YiI+2VwFeV1qw+P1mlHUC5WUVuuXuN0Nd+D35Z9EqMTRX0CBUIFghsM7m7qgFth
         OcKUjhAG5++HF+I1PyNGIsZygmw+zQiVjbJFfi/21Jcp3sRBEapuOMxH/lGpJYmLWF
         /ZjfjjGp/yI8uylSOvSmTr0dWVQe2cJY8Q+CgwGRWg3Cvidm/JzFdJO0Ru077MsB0Q
         I91WwAVuQ2xSDJ9KEV3KGRacugPsWESA3Cd6dubaNSrKXeOY28CqRAgpAUtXGL3QfX
         gE+6sBrVazpOQ71het3tITxMzYfXZm+gHUowKQdIYl0ejpIgdItYKjZylOqZj8H+mw
         R4ct5jWnujaOQ==
Message-ID: <9d5fc0d5-9ee9-3268-2b6a-22e870047d2b@kernel.org>
Date:   Sat, 5 Aug 2023 15:42:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] extcon: cht_wc: add POWER_SUPPLY dependency
To:     Arnd Bergmann <arnd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
References: <20230804132853.2300155-1-arnd@kernel.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20230804132853.2300155-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 8. 4. 22:28, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver fails to link when CONFIG_POWER_SUPPLY is disabled:
> 
> x86_64-linux-ld: vmlinux.o: in function `cht_wc_extcon_psy_get_prop':
> extcon-intel-cht-wc.c:(.text+0x15ccda7): undefined reference to `power_supply_get_drvdata'
> x86_64-linux-ld: vmlinux.o: in function `cht_wc_extcon_pwrsrc_event':
> extcon-intel-cht-wc.c:(.text+0x15cd3e9): undefined reference to `power_supply_changed'
> x86_64-linux-ld: vmlinux.o: in function `cht_wc_extcon_probe':
> extcon-intel-cht-wc.c:(.text+0x15cd596): undefined reference to `devm_power_supply_register'
> 
> It should be possible to change the driver to not require this at
> compile time and still provide other functions, but adding a hard
> Kconfig dependency does not seem to have any practical downsides
> and is simpler since the option is normally enabled anyway.
> 
> Fixes: 66e31186cd2aa ("extcon: intel-cht-wc: Add support for registering a power_supply class-device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/extcon/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 0ef1971d22bb0..8de9023c2a387 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -62,6 +62,7 @@ config EXTCON_INTEL_CHT_WC
>  	tristate "Intel Cherrytrail Whiskey Cove PMIC extcon driver"
>  	depends on INTEL_SOC_PMIC_CHTWC
>  	depends on USB_SUPPORT
> +	depends on POWER_SUPPLY
>  	select USB_ROLE_SWITCH
>  	help
>  	  Say Y here to enable extcon support for charger detection / control

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

