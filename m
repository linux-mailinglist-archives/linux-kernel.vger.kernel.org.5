Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691D87EFE34
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 08:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjKRHAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 02:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjKRHAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 02:00:46 -0500
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A993D7A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 23:00:41 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 4FJcrhCyonYhw4FJdrn5OM; Sat, 18 Nov 2023 08:00:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1700290838;
        bh=ImfOXGXy4cC/EU6Ogokf0M7lLV+mAmE9eifGpialzMY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=b4WS4N4xMKW5QDWhALBbAWJK2NO1GAoPH9IbyTN60cNre0mnNzIhRXiqZ78AlKOfo
         AIuQvUR+JuUI9rucUY/EK/zYlmhHTHH/ELLGTlC1Jy2xNTIDXiGYxve2FKumxmrGyX
         5JfTcFGsPW4bsTcuuXe+n1Gx4vknfP3MWTzjKQWGb77hrKETcLHxiOXW4IpefdSYs/
         ttmRjhUnBgfx9N6TvGfJHCIbERdLbe5664ZsVIkNwtHC47R+hs6WPxgfCU4V+UY/ea
         NO+VQr2VLIkWicewXCpwB14gJgzgYPcgB/sc6elHnohZtm2mz1so0mOPEAMOfc3tUW
         e6oiEKtfXpEAQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 Nov 2023 08:00:38 +0100
X-ME-IP: 86.243.2.178
Message-ID: <2e919694-e124-4864-aa02-01d47495032b@wanadoo.fr>
Date:   Sat, 18 Nov 2023 08:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: scmi: process the result of
 devm_of_clk_add_hw_provider()
To:     =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGA0LAg0JTRjtC/0LjQvdCw?= 
        <adiupina@astralinux.ru>, Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20231117074911.14427-1-adiupina@astralinux.ru>
 <fe85f03b-1c2a-3a99-c62b-abdf7e1eccb4@astralinux.ru>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <fe85f03b-1c2a-3a99-c62b-abdf7e1eccb4@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/11/2023 à 12:14, Александра Дюпина a écrit :
> I'm sorry, I forgot to add "return ret;" after
> calling the dev_err() function. Before I post
> the second version of the patch, please let me
> know what you think about this fix, keeping in
> mind what I wanted to add "return ret;"

This is a probe function.
So, maybe using dev_err_probe() would be slightly nicer?

If yes, the dev_err() that is already there could be updated as well in 
an other patch.

CJ

> 
> 17.11.2023 10:49, Alexandra Diupina пишет:
>> devm_of_clk_add_hw_provider() may return an errno, so
>> add a return value check
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 8410e7f3b31e ("cpufreq: scmi: Fix OPP addition failure with a 
>> dummy clock provider")
>> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
>> ---
>>   drivers/cpufreq/scmi-cpufreq.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c 
>> b/drivers/cpufreq/scmi-cpufreq.c
>> index c8a7ccc42c16..4037945663bf 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -334,8 +334,13 @@ static int scmi_cpufreq_probe(struct scmi_device 
>> *sdev)
>>   #ifdef CONFIG_COMMON_CLK
>>       /* dummy clock provider as needed by OPP if clocks property is 
>> used */
>> -    if (of_property_present(dev->of_node, "#clock-cells"))
>> -        devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
>> +    if (of_property_present(dev->of_node, "#clock-cells")) {
>> +        ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, 
>> NULL);
>> +        if (ret) {
>> +            dev_err(dev, "%s: registering clock provider failed, err: 
>> %d\n",
>> +                __func__, ret);
>> +        }
>> +    }
>>   #endif
>>       ret = cpufreq_register_driver(&scmi_cpufreq_driver);
> 
> 
> Regards,
> 
> Alexandra Diupina
> 

