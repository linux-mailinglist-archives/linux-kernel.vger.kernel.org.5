Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6527E5AE2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjKHQNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKHQNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:13:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AF819A5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=xxFBuI9UgLqm+jZa/QCBq+IBtHSiUW/6zK0A02eXdy0=; b=CG6GBx866ahdE8OH0Kss4OPcsI
        RjxksZaTQATcIh3V7wroCVchAFAQHxVF7eZCnLkZLRT1954LHYFdoTgMYDOTcIU1PfvSKwsmffTXz
        dqYMW+ZwYEWA/G6gzoZVhfEnVdUnZnrtNFDhyMnGbU7OS+j+2e4T273MI/Qkopv9XodEmH6v2QDWz
        dsa1pFn/DhM+mEE3XG7RzNuDHhxpkeqw455Y2oj1fzK46dnGa30Bfc119PrI1GjnILWp/njqXwbw0
        2+ilEyjN2vHm0EvILYU8IsSlzoHUKwpAfVgJNkuM1AZ6oCgbuUl1c/FNrebCxlxj5mKqgIo38TCc5
        S2iT3p1Q==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0lAp-004Goa-2K;
        Wed, 08 Nov 2023 16:12:59 +0000
Message-ID: <d242c2e8-85a8-43b7-8438-d83f1b90c8b2@infradead.org>
Date:   Wed, 8 Nov 2023 08:12:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: beagleplay: select CONFIG_CRC_CCITT
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ayush Singh <ayushdevel1325@gmail.com>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20231108153429.1072732-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231108153429.1072732-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/23 07:34, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without the CRC_CCITT code, the new greybus driver fails to link:
> 
> aarch64-linux-ld: drivers/greybus/gb-beagleplay.o: in function `hdlc_append_tx_u8':
> gb-beagleplay.c:(.text+0x158): undefined reference to `crc_ccitt'
> aarch64-linux-ld: drivers/greybus/gb-beagleplay.o: in function `gb_tty_receive':
> gb-beagleplay.c:(.text+0x5c4): undefined reference to `crc_ccitt'
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/greybus/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
> index 033d31dbf3b8..ab81ceceb337 100644
> --- a/drivers/greybus/Kconfig
> +++ b/drivers/greybus/Kconfig
> @@ -20,6 +20,7 @@ if GREYBUS
>  config GREYBUS_BEAGLEPLAY
>  	tristate "Greybus BeaglePlay driver"
>  	depends on SERIAL_DEV_BUS
> +	select CRC_CCITT
>  	help
>  	  Select this option if you have a BeaglePlay where CC1352
>  	  co-processor acts as Greybus SVC.

Yes, same as my patch:
https://lore.kernel.org/lkml/20231031040909.21201-1-rdunlap@infradead.org/

I expect that Greg just hasn't gotten around to applying new patches/fixes yet.

-- 
~Randy
