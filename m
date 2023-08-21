Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B475B782640
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjHUJ3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjHUJ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:29:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D41291;
        Mon, 21 Aug 2023 02:29:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA6F32F4;
        Mon, 21 Aug 2023 02:30:08 -0700 (PDT)
Received: from [10.57.3.137] (unknown [10.57.3.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07EC23F762;
        Mon, 21 Aug 2023 02:29:25 -0700 (PDT)
Message-ID: <2f1beb3e-c9df-46c5-fe5d-0d688a730521@arm.com>
Date:   Mon, 21 Aug 2023 10:29:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5] perf: arm_cspmu: Separate Arm and vendor module
Content-Language: en-GB
To:     Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Richard Wiley <rwiley@nvidia.com>,
        Eric Funsten <efunsten@nvidia.com>
References: <20230705104745.52255-1-bwicaksono@nvidia.com>
 <e98abbc3-dab6-414d-8ce7-8b9572be41a0@arm.com>
 <SJ0PR12MB5676F7D0749A35DCB185452EA018A@SJ0PR12MB5676.namprd12.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <SJ0PR12MB5676F7D0749A35DCB185452EA018A@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-19 21:11, Besar Wicaksono wrote:
[...]
>>> +void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match
>> *impl_match)
>>> +{
>>> +     struct device *dev;
>>> +     struct arm_cspmu_impl_match *match;
>>> +
>>> +     match = arm_cspmu_impl_match_get(impl_match->pmiidr_val);
>>> +
>>> +     WARN_ON(!match);

Nit: do "if (WARN_ON(!match)) return;" rather than indenting almost the 
whole function.

>>> +
>>> +     if (match) {
>>> +             /* Unbind the driver from all matching backend devices. */
>>> +dev_release:
>>> +             dev = driver_find_device(&arm_cspmu_driver.driver, NULL,
>>> +                     match, arm_cspmu_match_device);
>>> +             if (dev) {
>>> +                     device_release_driver(dev);
>>> +                     goto dev_release;
>>> +             }
>>
>> minor nit: We could simply do :
>>
>> static int arm_cspmu_release_driver(struct device *dev, void *data)
>> {
>>          struct arm_cspmu *cspmu =
>> platform_get_drvdata(to_platform_device(dev));
>>
>>          if (cspmu && cspmu->impl.match == match)
>>                  device_release_driver(dev);
>>          return 0;
>> }
>>
>>                  ret = driver_for_each_device(&driver, NULL, match,
>> arm_csmpu_release_driver);
>>
> 
> It doesn’t seem to work for me.
> Is it safe to release while iterating via driver_for_each_device ?

Looking at the klist code it doesn't *obviously* appear safe to modify 
the list during iteration, so probably best not to risk it anyway. 
However, please try to write this loop as an actual loop, e.g.:

	while ((dev = driver_find_device()))
		device_release_driver();

At first glance I thought there was a bug here that it's only processing 
a single device, then eventually I saw the goto and my thought changed 
to "Eww..."

Thanks,
Robin.
