Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149727A3109
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 17:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjIPPKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 11:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjIPPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 11:10:19 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473BFCCF
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 08:10:13 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id hWvyqftxFNtVWhWvyqismR; Sat, 16 Sep 2023 17:10:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694877011;
        bh=6jwMYAEqJdvc3UEqksxRjN6+6v4fxqBOxhEdpC1aB2w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=t+BvTvMHqfmRNlhzui1OBOyxk0/k/0D0FuMcSRbEktFCHLq3BjnLA9OHemlXwRp+L
         pNwL1IErYVUnSiKUooWgiaNj6NA/FFAm+RbXw00LXjw6Y0uWPsEkgK/Afm112TDt2b
         5O7n3sa2GciUP19MoU7H7wAEigTqF/CuipLPOo+UgS50W0CeNoAAv1TcX2fkJl4Oqn
         sIed5WdUUkfOfn2qz2CQvrDhA8hDmlS69/STHV13lUy4k9N9KlXCuqTot4h6GRnAlI
         OY7P+4JRnd7RGqqlw0JHBZkLy9PdEj3NHqHRO7u8INHMEDI2UWXnxyXOchq8zN22DY
         S4hM6HcFw3UMA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 Sep 2023 17:10:11 +0200
X-ME-IP: 86.243.2.178
Message-ID: <4f629125-2b62-1284-3311-d95639044764@wanadoo.fr>
Date:   Sat, 16 Sep 2023 17:10:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] gpio: tb10x: Fix an error handling path in
 tb10x_gpio_probe()
Content-Language: fr, en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linus.walleij@linaro.org, andy@kernel.org, galak@codeaurora.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <ceeda269bceee1c805f148bcbc628abc9d42601a.1693721348.git.christophe.jaillet@wanadoo.fr>
 <CAMRc=Meq+1z50=tXXt3MFAexRCmfSQ5rs6hT7311KRGO=q2RHQ@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAMRc=Meq+1z50=tXXt3MFAexRCmfSQ5rs6hT7311KRGO=q2RHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/09/2023 à 19:02, Bartosz Golaszewski a écrit :
> On Sun, Sep 3, 2023 at 8:13 AM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> If an error occurs after a successful irq_domain_add_linear() call, it
>> should be undone by a corresponding irq_domain_remove(), as already done
>> in the remove function.
>>
>> Fixes: c6ce2b6bffe5 ("gpio: add TB10x GPIO driver")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/gpio/gpio-tb10x.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
>> index 78f8790168ae..f96d260a4a19 100644
>> --- a/drivers/gpio/gpio-tb10x.c
>> +++ b/drivers/gpio/gpio-tb10x.c
>> @@ -195,7 +195,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
>>                                  handle_edge_irq, IRQ_NOREQUEST, IRQ_NOPROBE,
>>                                  IRQ_GC_INIT_MASK_CACHE);
>>                  if (ret)
>> -                       return ret;
>> +                       goto err_remove_domain;
>>
>>                  gc = tb10x_gpio->domain->gc->gc[0];
>>                  gc->reg_base                         = tb10x_gpio->base;
>> @@ -209,6 +209,10 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
>>          }
>>
>>          return 0;
>> +
>> +err_remove_domain:
>> +       irq_domain_remove(tb10x_gpio->domain);
>> +       return ret;
>>   }
>>
>>   static int tb10x_gpio_remove(struct platform_device *pdev)
>> --
>> 2.34.1
>>
> 
> That's not enough, you also need to dispose of all remaining mappings.
> Please see drivers/gpio/gpiolib.c and how it handles the gpio_irq_chip
> domain.

Hi,

you'll have to give me more explanation because I've not been able to 
find anything useful to me.

CJ

> 
> Bartosz
> 

