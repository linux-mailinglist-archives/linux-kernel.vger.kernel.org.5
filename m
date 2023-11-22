Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D367F3E87
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjKVHCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKVHCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:02:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2D97110;
        Tue, 21 Nov 2023 23:02:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34E521595;
        Tue, 21 Nov 2023 23:03:27 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6C223F73F;
        Tue, 21 Nov 2023 23:02:36 -0800 (PST)
Message-ID: <268e1605-fe3f-4aa0-92e3-36ddfc8aacb3@arm.com>
Date:   Wed, 22 Nov 2023 12:32:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] coresight: tpiu: Move ACPI support from AMBA driver
 to platform driver
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20231027072943.3418997-1-anshuman.khandual@arm.com>
 <20231027072943.3418997-5-anshuman.khandual@arm.com>
 <92d6a66d-3270-3378-2ab9-9214c004d5c7@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <92d6a66d-3270-3378-2ab9-9214c004d5c7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/23 19:23, James Clark wrote:
> 
> 
> On 27/10/2023 08:29, Anshuman Khandual wrote:
>> Add support for the tpiu device in the platform driver, which can then be
>> used on ACPI based platforms. This change would now allow runtime power
>> management for ACPI based systems. The driver would try to enable the APB
>> clock if available.
>>
> [...]
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id tpiu_acpi_ids[] = {
>> +	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, tpiu_acpi_ids);
>> +#endif
>> +
>> +static struct platform_driver tpiu_platform_driver = {
>> +	.probe	= tpiu_platform_probe,
>> +	.remove	= tpiu_platform_remove,
>> +	.driver = {
>> +		.name			= "coresight-tpiu-platform",
>> +		.acpi_match_table	= ACPI_PTR(tpiu_acpi_ids),
>> +		.suppress_bind_attrs	= true,
>> +		.pm			= &tpiu_dev_pm_ops,
>> +	},
>> +};
>> +module_platform_driver(tpiu_platform_driver);
>> +
> 
> Is there a special build config where this works? I get an error here

I have been testing this with a config known to work on RB5 board.

> because module_platform_driver() redefines things that are in
> module_amba_driver() which is defined above:
> 
>   module_amba_driver(tpiu_driver);
> 
> This isn't a W=1 build or anything, just a normal one. And it applies to
> most of the patches in this set.

You are right, I am able to recreate this problem with defconfig on
6.7-rc2 as well. The problem here seems to be caused by having both
module_amba_driver() and module_platform_driver() in the same file.

#define module_amba_driver(__amba_drv) \
        module_driver(__amba_drv, amba_driver_register, amba_driver_unregister)

#define module_platform_driver(__platform_driver) \
        module_driver(__platform_driver, platform_driver_register, \
                        platform_driver_unregister)

Although, AFAICT, have not seen these before - even on the defconfig.
Just to work around this problem, there can be a common module_init()
/module_exit() to register/unregister both AMBA and platform drivers,
similar to etm4x_init()/etm4x_exit() setup in coresight-etm4x-core.c.
