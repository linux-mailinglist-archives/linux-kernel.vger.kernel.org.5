Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77947E0272
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346170AbjKCL7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjKCL7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:59:36 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D946D44;
        Fri,  3 Nov 2023 04:59:30 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 0A2364013B;
        Fri,  3 Nov 2023 16:59:25 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1699012767; bh=uMjAgjVBxkvh0peanEjS5u9IYU4ZbctslGY3EYuqRo0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vf9hK65dE0vtxY6qaMfpoQQ06se3aL/x+GhvDjf6fXOAqugyUefgSZSv59YN6VU57
         0k+cipJCbKJrO47iAKm7GGsGrdfhuIA3bLJLUf9ozC5aYl2wH6f+zPF9lr6qp8Cc96
         aPsHl8rTJPGzfteeUDpLN0adv9zP7AVTzKDKQsjWc6r5yMAdW6h4MZquNctdcIDphv
         s9GZxRoImuSa5vT5uZZ8hkPjRc063aYJEax/jUNjAVMoWiWIoznrBDHWUfnXBxstDd
         guDhoiIYlegu4URg9+4Ud2pX3513G239fE2WunKu64BUownCgCUelR4yaMbKoshl+g
         n8lzqcpIayfbw==
MIME-Version: 1.0
Date:   Fri, 03 Nov 2023 16:59:24 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Dang Huynh <danct12@riseup.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: aw2013: Select REGMAP_I2C
In-Reply-To: <20231103114203.1108922-1-danct12@riseup.net>
References: <20231103114203.1108922-1-danct12@riseup.net>
Message-ID: <89a873f8f9156221faee9fa3ecb3e3e5@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dang Huynh писал(а) 03.11.2023 16:42:
> The AW2013 driver uses devm_regmap_init_i2c, so REGMAP_I2C needs to
> be selected.
> 
> Otherwise build process may fail with:
> ld: drivers/leds/leds-aw2013.o: in function `aw2013_probe':
> leds-aw2013.c:345: undefined reference to `__devm_regmap_init_i2c'
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>

Oh, thanks for noticing that!

Acked-by: Nikita Travkin <nikita@trvn.ru>

Btw for fixes like this it's customary to add a Fixes tag
to let stable team know they might want to backport it:

Fixes: 59ea3c9faf32 ("leds: add aw2013 driver")

> ---
>  drivers/leds/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index b92208eccdea..3132439f99e0 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -110,6 +110,7 @@ config LEDS_AW200XX
>  config LEDS_AW2013
>  	tristate "LED support for Awinic AW2013"
>  	depends on LEDS_CLASS && I2C && OF
> +	select REGMAP_I2C
>  	help
>  	  This option enables support for the AW2013 3-channel
>  	  LED driver.
