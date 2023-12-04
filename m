Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41B1803445
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjLDNRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDNRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:17:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 308AE95;
        Mon,  4 Dec 2023 05:17:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BED3152B;
        Mon,  4 Dec 2023 05:17:59 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C4E13F5A1;
        Mon,  4 Dec 2023 05:17:10 -0800 (PST)
Message-ID: <7825dcd4-94e1-7a5f-b388-90e748dfc47f@arm.com>
Date:   Mon, 4 Dec 2023 13:17:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 6/7] coresight: stm: Move ACPI support from AMBA driver
 to platform driver
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Sudeep Holla <Sudeep.Holla@arm.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20231201062053.1268492-1-anshuman.khandual@arm.com>
 <20231201062053.1268492-7-anshuman.khandual@arm.com>
 <0adc3a16-0fc4-2a25-cd48-4667881b9490@arm.com>
 <e53cec31-9452-4c2a-a3a1-b6ef33be8e22@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <e53cec31-9452-4c2a-a3a1-b6ef33be8e22@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2023 11:50, Anshuman Khandual wrote:
> 
> 
> On 12/4/23 15:53, James Clark wrote:
>>
>>
>> On 01/12/2023 06:20, Anshuman Khandual wrote:
>>> Add support for the stm devices in the platform driver, which can then be
>>> used on ACPI based platforms. This change would now allow runtime power
>>> management for ACPI based systems. The driver would try to enable the APB
>>> clock if available.
>>>
>>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: James Clark <james.clark@arm.com>
>>> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>> Cc: linux-acpi@vger.kernel.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: coresight@lists.linaro.org
>>> Cc: linux-stm32@st-md-mailman.stormreply.com
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>> [...]
>>>  
>>> -module_amba_driver(stm_driver);
>>> +static int stm_platform_probe(struct platform_device *pdev)
>>> +{
>>> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	int ret = 0;
>>> +
>>> +	pm_runtime_get_noresume(&pdev->dev);
>>> +	pm_runtime_set_active(&pdev->dev);
>>> +	pm_runtime_enable(&pdev->dev);
>>> +
>>> +	ret = __stm_probe(&pdev->dev, res, NULL);
>>
>> Very minor nit, but this used to print this:
>>
>>   coresight stm0: STM500 initialized
>>
>> And now it prints this:
>>
>>   coresight stm0: (null) initialized
>>
>> (null) kind of makes it look a little bit like something has gone wrong.
>> Maybe we could just put "initialised" if you don't have a string from ACPI?
> 
> __stm_probe() gets called from both AMBA and platform driver paths. Even though
> a NULL check inside dev_info(..."%s initialized\n",...) could be added, but how
> to differentiate it from a scenario when coresight_get_uci_data() returns NULL ?

Sudeep's suggestion seems ok, just add a hard coded string instead of
the NULL. And keep the coresight_get_uci_data() the same.
