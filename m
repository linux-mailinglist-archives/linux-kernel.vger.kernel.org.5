Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A9078B700
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjH1SGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjH1SFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:05:38 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C20712E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:05:32 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id agcCqXEzZntruagcCqJS8z; Mon, 28 Aug 2023 20:05:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693245930;
        bh=EgTv0o9qx0jkMzkG5lUqiunPw6gvd9DvsVLEZtgaZSA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QzRv5zTmweEudWySzkqPqvc8ftnRht6EWRTrZsJrtsinwjzWcSqobjJFWJlT645LW
         CnhhGsIuqovCTsLcv2kCJ32oiouueRdPcZ094c6xLFzAEhjHYGrvs8wABlcdXzSInK
         aj7VtcfRxMXF+qBfnS37H+NG15vGev9Bzuoa3+AYiC96GIPjlHIuXNGRGxGwB14R9n
         8ooemhSIIaGcJCuUdw0K1IXBlxQ/ld7u+JqAksHJTIiOGqcWfJJx7Defhx5qudrdHL
         Lw/btfk6A+fLz7/znD7moiMflLDH/DK/yojXQBwLXNeLTPF3CrIbgqw8kfaa7C1Rna
         ZCLoPQ0spIkVQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Aug 2023 20:05:29 +0200
X-ME-IP: 86.243.2.178
Message-ID: <38d40c73-7821-1e19-7acf-49b7a9992fb4@wanadoo.fr>
Date:   Mon, 28 Aug 2023 20:05:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3] watchdog: of_xilinx_wdt: Remove unnecessary clock
 disable call in the remove path
Content-Language: fr, en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        shubhrajyoti.datta@amd.com, michal.simek@amd.com,
        wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@amd.com, neelisrinivas18@gmail.com
References: <20230828095006.3602426-1-srinivas.neeli@amd.com>
 <615a0579-b36e-8303-1050-5b39466921b9@roeck-us.net>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <615a0579-b36e-8303-1050-5b39466921b9@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 28/08/2023 à 12:08, Guenter Roeck a écrit :
> On 8/28/23 02:50, Srinivas Neeli wrote:
>> There is a mismatch in axi clock enable and disable calls.
>> The axi clock is enabled and disabled by the probe function,
>> then it is again disabled in the remove path.
>> So observed the call trace while removing the module.
>> Use the clk_enable() and devm_clk_get_prepared() functions
>> instead of devm_clk_get_enable() to avoid an extra clock disable
>> call from the remove path.
>>
>>   Call trace:
>>    clk_core_disable+0xb0/0xc0
>>    clk_disable+0x30/0x4c
>>    clk_disable_unprepare+0x18/0x30
>>    devm_clk_release+0x24/0x40
>>    devres_release_all+0xc8/0x190
>>    device_unbind_cleanup+0x18/0x6c
>>    device_release_driver_internal+0x20c/0x250
>>    device_release_driver+0x18/0x24
>>    bus_remove_device+0x124/0x130
>>    device_del+0x174/0x440
>>
>> Fixes: 4de0224c6fbe ("watchdog: of_xilinx_wdt: Use 
>> devm_clk_get_enabled() helper")
>> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>

Hi, I'm not sure the Fixes tag is correct.

This issue was there before it.
Commit 4de0224c6fbe is just a clean-up and shouldn't change the behavior 
of the code.

I think that the issue was introduced in 2017 in b6bc41645547. (should 
the bellow patch be backported in older stable kernels)

CJ


>> ---
>> Changes in V3:
>> -> Added "clk_disable() in xwdt_selftest() error path.
>> Changes in V2:
>> -> Fixed typo in "To" list(linux@roeck-us.net).
>> ---
>>   drivers/watchdog/of_xilinx_wdt.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/watchdog/of_xilinx_wdt.c 
>> b/drivers/watchdog/of_xilinx_wdt.c
>> index 05657dc1d36a..352853e6fe71 100644
>> --- a/drivers/watchdog/of_xilinx_wdt.c
>> +++ b/drivers/watchdog/of_xilinx_wdt.c
>> @@ -187,7 +187,7 @@ static int xwdt_probe(struct platform_device *pdev)
>>         watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
>>   -    xdev->clk = devm_clk_get_enabled(dev, NULL);
>> +    xdev->clk = devm_clk_get_prepared(dev, NULL);
>>       if (IS_ERR(xdev->clk)) {
>>           if (PTR_ERR(xdev->clk) != -ENOENT)
>>               return PTR_ERR(xdev->clk);
>> @@ -218,18 +218,25 @@ static int xwdt_probe(struct platform_device 
>> *pdev)
>>       spin_lock_init(&xdev->spinlock);
>>       watchdog_set_drvdata(xilinx_wdt_wdd, xdev);
>>   +    rc = clk_enable(xdev->clk);
>> +    if (rc) {
>> +        dev_err(dev, "unable to enable clock\n");
>> +        return rc;
>> +    }
>> +
>>       rc = xwdt_selftest(xdev);
>>       if (rc == XWT_TIMER_FAILED) {
>>           dev_err(dev, "SelfTest routine error\n");
>> +        clk_disable(xdev->clk);
>>           return rc;
>>       }
>>   +    clk_disable(xdev->clk);
>> +
>>       rc = devm_watchdog_register_device(dev, xilinx_wdt_wdd);
>>       if (rc)
>>           return rc;
>>   -    clk_disable(xdev->clk);
>> -
>>       dev_info(dev, "Xilinx Watchdog Timer with timeout %ds\n",
>>            xilinx_wdt_wdd->timeout);
>
