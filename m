Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8A478E72E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbjHaH3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjHaH3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:29:42 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F8401A3;
        Thu, 31 Aug 2023 00:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=571iF6/ERr6OK1Pg9hk3ChGUq70/StuYdmAQEv8xtgY=;
        b=Zmon+ep7z+miXx2UYeqbYw83cnXRJUQ6dM83QF0iQvWrQu9pPxlkCA8VaSH373
        CQg/iZTLqr6Limq6Xq+E8HPeddcYAVV2A3PkatmzUTZyKgz2yYCy9RP2FO96NEma
        03ntITlD+52DaANYS43Kju4ioh+bUTv4wYx9XAEjujibo=
Received: from [172.20.10.2] (unknown [39.144.138.235])
        by zwqz-smtp-mta-g3-2 (Coremail) with SMTP id _____wA3n0glQfBkyAYgAw--.15827S3;
        Thu, 31 Aug 2023 15:28:38 +0800 (CST)
Message-ID: <d3780074-a5af-92ef-9aa3-1b321a14233c@163.com>
Date:   Thu, 31 Aug 2023 15:28:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with other
 gpio pins
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingtong.wu@siemens.com,
        andy.shevchenko@gmail.com, simon.guinot@sequanux.org,
        "Schaffner, Tobias" <tobias.schaffner@siemens.com>,
        "Haeussler, Gerd" <gerd.haeussler.ext@siemens.com>
References: <20230529025011.2806-1-xingtong_wu@163.com>
 <20230529025011.2806-2-xingtong_wu@163.com>
 <CACRpkdaLyEmdhutqsMUoV3ObW8bFePtNGHFqr5qiKV3w0ripug@mail.gmail.com>
From:   "xingtong.wu" <xingtong_wu@163.com>
In-Reply-To: <CACRpkdaLyEmdhutqsMUoV3ObW8bFePtNGHFqr5qiKV3w0ripug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3n0glQfBkyAYgAw--.15827S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrW3GrykWFW5ZF43JF1DZFb_yoW8uF1Dpr
        WfCa1akr18J3yxAwn3Ka1fAFyfuw17A3y3Zas8Kw4UZF9rZF95WF4ayrWYv39rG3srJry5
        GF4Ig34Fv3Z8C3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UE-ewUUUUU=
X-Originating-IP: [39.144.138.235]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/xtbCfg7c0GDcPcItPgABst
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/29 21:02, Linus Walleij wrote:
> On Mon, May 29, 2023 at 4:55 AM <xingtong_wu@163.com> wrote:
> 
>> From: "xingtong.wu" <xingtong.wu@siemens.com>
>>
>> switch pin base from static to automatic allocation to
>> avoid conflicts and align with other gpio chip drivers
>>
>> Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> If this platform does not have a ton of userspace using the obsolete
> sysfs this should be fine to apply. I say let's apply and see what happens.
> 
> Yours,
> Linus Walleij

Hi

Seems the issue happened again, the module "gpio-f7188x" register
gpio_chip failed because of the base value conflict. I hope the patch
can be merged soon, I'm afraid that you forgot it...

The log is below:
[    6.872049] gpio-f7188x: Unsupported Fintek device 0x0303
[    6.872137] gpio-f7188x: Found nct6126d at 0x4e
[    6.899965] gpiochip_find_base: cannot find free range
[    6.899967] gpiochip_add_data_with_key: GPIOs 0..7 (gpio-f7188x-6) failed to register, -28
[    6.899970] gpio-f7188x gpio-f7188x: Failed to register gpiochip 6: -28
[    6.903329] simatic_ipc_batt simatic_ipc_batt: cannot find GPIO chip gpio-f7188x-6, deferring

There is a gpio_chip created by "pinctrl-tigerlake":
/sys/class/gpio/gpiochip49# ls -l
total 0
-r--r--r--. 1 root root 4096 Aug 31 06:40 base
lrwxrwxrwx. 1 root root    0 Aug 31 06:40 device -> ../../../INT34C6:00
-r--r--r--. 1 root root 4096 Aug 31 06:40 label
-r--r--r--. 1 root root 4096 Aug 31 06:40 ngpio
drwxr-xr-x. 2 root root    0 Aug 31 06:40 power
lrwxrwxrwx. 1 root root    0 Aug 31 06:38 subsystem -> ../../../../../class/gpio
-rw-r--r--. 1 root root 4096 Aug 31 06:38 uevent

The base value is 49, label = INT34C6:00, ngpio = 463

The issue arose by chance, because the driver "pinctrl-tigerlake" apply gpio_chip->base
randomly, this time it apply the base value 49, so it have conflict to here:
https://github.com/torvalds/linux/blob/master/drivers/gpio/gpio-f7188x.c#L283

But sometime it apply other base values, so the issue do not happen.

BRs,
Xing Tong Wu

