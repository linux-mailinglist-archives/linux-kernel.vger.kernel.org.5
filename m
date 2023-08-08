Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAAF774BB9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjHHUyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjHHUyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:54:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1404496;
        Tue,  8 Aug 2023 13:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=6r7PjrCEgpz4xmTGBp613ajXrb6WdCBsEp8ol8rTeyU=; b=DTeAyRKxjPmMfRmmUDw04MzXeX
        2hi4FV7iMzb1Fw1Eks+IhfiZE12vobmr2ou/tFYQ7/oY9CBch9Uqg9f4v2sNoly6Oc/CuzPU9lx4S
        f3oaISx44KKsaaVcAZiW0X/T5Qei04PYDZ4xsDyweXA7E1UcnAcRIbhvV7bHLJ1NcikDiEqzkRN+0
        YkKzuxTziVuQGAYAETLX+Zx8JQ6MpLuqAtchJOgqgCBcNiRFewiIHuPnrqLLgsyt7NkpuhXpDdCnb
        MtPdHqEeGUW0PbUm1YlrknAToxir4b37G8t7Gwpny6cTiWYLzxh7Kjl21viTyUTd1F00ZaT856Jf7
        E8Ci4Ybw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTTVR-003Qxr-2s;
        Tue, 08 Aug 2023 20:40:41 +0000
Message-ID: <78b74902-f120-96e6-f1a1-6d424f3338e5@infradead.org>
Date:   Tue, 8 Aug 2023 13:40:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] input: keyboard: Add sprd-keypad driver
Content-Language: en-US
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Holland <samuel@sholland.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
References: <20230808072501.3393-1-Wenhua.Lin@unisoc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230808072501.3393-1-Wenhua.Lin@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/8/23 00:25, Wenhua Lin wrote:
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 1d0c5f4c0f99..f35d9bf05f72 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -809,4 +809,14 @@ config KEYBOARD_CYPRESS_SF
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cypress-sf.
>  
> +config KEYBOARD_SPRD
> +	tristate "Spreadtrum keyboard support"
> +	depends on ARCH_SPRD || COMPILE_TEST
> +	select INPUT_MATRIXKMAP
> +	help
> +	  Keypad controller is used to interface a SoC with a matrix-keypad device,

	                                         an SoC                     device.

> +	  The keypad controller supports multiple row and column lines.
> +	  Say Y if you want to use the SPRD keyboard.
> +	  Say M if you want to use the SPRD keyboard on SoC as module.
> +
>  endif

-- 
~Randy
