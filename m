Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC8B7F640C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjKWQiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:38:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B37DD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:38:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B668C433CC;
        Thu, 23 Nov 2023 16:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700757501;
        bh=tDedXJ4tnaGMs3ZTX/pYA5ErQwaoQ9VfB/MU8vDEhKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WsbgZ+8fTYYujkEj1M5p0m4erPLW64Ku483nH050cih4Iup/Le+FsNJuo8wxh39qj
         idzstqs32DolW3/mZzmDCIDKu21a/KkaNvSxzxk9KumL/2jHwtiJs5BuxsbI//gwxJ
         fT+09/3nDeb3YiNjHmLwJDzVzAUzGYuyVdHLw0v5E5L3AU/mAOFSUsuMS0xsF/zKQ9
         tzgoSXZVyVVLM6iPRiIPG2BH0qZNQSeHeLWUXPd/Fuc1Z02m92nbeDPwMMqCtMqXi4
         IO2PmgTCbs2ThLftcJjdJg7V5PhL9ypqCcygHhkl1UQU8L0qay4rp5VhY3PLkQp79r
         xJvnJ0BeW0rgQ==
Date:   Thu, 23 Nov 2023 16:38:16 +0000
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andy.shevchenko@gmail.com, kernel@sberdevices.ru,
        rockosov@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v4 06/11] leds: aw200xx: add delay after software reset
Message-ID: <20231123163816.GG1354538@google.com>
References: <20231121202835.28152-1-ddrokosov@salutedevices.com>
 <20231121202835.28152-7-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121202835.28152-7-ddrokosov@salutedevices.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023, Dmitry Rokosov wrote:

> From: George Stark <gnstark@salutedevices.com>
> 
> According to datasheets of aw200xx devices software reset takes at
> least 1ms so add delay after reset before issuing commands to device.

Are you able to use an auto-correct tool to sharpen the grammar a little?

> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/leds/leds-aw200xx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
> index 4bce5e7381c0..bb17e48b3e2a 100644
> --- a/drivers/leds/leds-aw200xx.c
> +++ b/drivers/leds/leds-aw200xx.c
> @@ -321,6 +321,9 @@ static int aw200xx_chip_reset(const struct aw200xx *const chip)
>  	if (ret)
>  		return ret;
>  
> +	/* according to datasheet software reset takes at least 1ms */

Please start sentences with an uppercase char.

"According to the datasheet, software resets take at least 1ms"
              ^                            ^     ^

> +	fsleep(1000);
> +
>  	regcache_mark_dirty(chip->regmap);
>  	return regmap_write(chip->regmap, AW200XX_REG_FCD, AW200XX_FCD_CLEAR);
>  }
> -- 
> 2.36.0
> 

-- 
Lee Jones [李琼斯]
