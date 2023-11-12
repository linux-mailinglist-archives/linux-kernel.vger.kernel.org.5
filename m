Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD9D7E8F78
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 11:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjKLKQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 05:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLKQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 05:16:10 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F8E2D57
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 02:16:05 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 47DD1120005;
        Sun, 12 Nov 2023 13:16:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 47DD1120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1699784162;
        bh=QkAL75FeAUEzLTDdv3OVdvwrABVU5Bl7zMHv1p+MboI=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=RyWW0/UunW5czFJ/lL0WsWtvLt/aHe5bUK2kg0FgDmANfZhfgsB4rI7cPMKU5jIge
         QumpByB9u3OZJNKAqdIBO6AHjR6hPZ3NdPPmsOwGRKZO2aTm15R5WLPPLoeBabd8Wq
         eBtUd5RJRSI6l9sS3E6wMT7Xts10w6DdL6c2M+os8b0qKqBgPWr0+tpx2A6xG+sOnL
         XKQMx9qpki6X6G9VAKkjAlqoED0MyfNVXEyBrRqbGXbWJF4xUFp/wHAnky10s2ieTx
         W4RF4lhO/yL/EzuM16e72QS98n8wLuiSmmYJhdnKQXBFehpnVilIHfmMIMCz/wjsBr
         K197cFhoblTmQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Sun, 12 Nov 2023 13:16:02 +0300 (MSK)
Received: from [192.168.0.106] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sun, 12 Nov 2023 13:16:01 +0300
Message-ID: <2d3a1d7c-7bf2-f8af-6019-85f07fee491e@salutedevices.com>
Date:   Sun, 12 Nov 2023 13:08:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: meson: initialize clock register
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20231109054037.3864802-1-avkrasnov@salutedevices.com>
Content-Language: en-US
From:   Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20231109054037.3864802-1-avkrasnov@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181295 [Nov 10 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/12 05:48:00 #22442901
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.11.2023 08:40, Arseniy Krasnov wrote:
> Clock register must be also initialized during controller probing. If
> this is not performed (for example by bootloader before) - controller
> will not work.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index 0d4d358152d7..4e7fa943928c 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -91,6 +91,8 @@
>  
>  /* eMMC clock register, misc control */
>  #define CLK_SELECT_NAND		BIT(31)
> +#define CLK_ALWAYS_ON_NAND      BIT(24)
> +#define CLK_ENABLE_VALUE        0x245
                                   ^^^^^^

Hi,

@Liang, it will be great, if You'll give some details about this magic value. I get it
from vendor's driver and it makes NAND controller alive, but I don't have any docs.

Thanks, Arseniy

>  
>  #define NFC_CLK_CYCLE		6
>  
> @@ -1152,7 +1154,7 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
>  		return PTR_ERR(nfc->nand_clk);
>  
>  	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
> -	writel(CLK_SELECT_NAND | readl(nfc->reg_clk),
> +	writel(CLK_ALWAYS_ON_NAND | CLK_SELECT_NAND | CLK_ENABLE_VALUE,
>  	       nfc->reg_clk);
>  
>  	ret = clk_prepare_enable(nfc->core_clk);
