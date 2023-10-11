Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF317C58C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346960AbjJKQDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjJKQDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:03:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D648C4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:03:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DDA214BF;
        Wed, 11 Oct 2023 09:03:54 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B514B3F7A6;
        Wed, 11 Oct 2023 09:03:11 -0700 (PDT)
Message-ID: <8fe4484c-57ed-477a-8ac1-e73b4a9cb3da@arm.com>
Date:   Wed, 11 Oct 2023 17:03:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drivers/perf: hisi:] drivers/perf: hisi: fix NULL pointer
 issue when uninstall hns3 pmu driver
Content-Language: en-GB
To:     Jijie Shao <shaojijie@huawei.com>,
        Yicong Yang <yangyicong@huawei.com>, will@kernel.org,
        jonathan.cameron@huawei.com, mark.rutland@arm.com,
        yangyicong@hisilicon.com
Cc:     chenhao418@huawei.com, shenjian15@huawei.com,
        wangjie125@huawei.com, liuyonglong@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231009105038.126040-1-shaojijie@huawei.com>
 <504cc838-d587-8bd0-601e-85f11b69c72b@huawei.com>
 <9579f762-24ce-0826-dc7b-2c79c969f192@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <9579f762-24ce-0826-dc7b-2c79c969f192@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2023 9:37 am, Jijie Shao wrote:
> 
> on 2023/10/10 17:32, Yicong Yang wrote:
>> Hi Jijie,
>>
>> On 2023/10/9 18:50, Jijie Shao wrote:
>>> From: Hao Chen <chenhao418@huawei.com>
>>>
>>> When uninstall hns3 pmu driver, it will call 
>>> cpuhp_state_remove_instance()
>>> and then callback function hns3_pmu_offline_cpu() is called, it may 
>>> cause
>>> NULL pointer call trace when other driver is installing or uninstalling
>>> concurrently.
>>>
>> More information about the calltrace you've met and how to reproduce 
>> this?
>> I'm not sure why other drivers are involved.
>>
>>> As John Garry's opinion, cpuhp_state_remove_instance() is used for 
>>> shared
>>> interrupt, and using cpuhp_state_remove_instance_nocalls() is fine 
>>> for PCIe
>>> or HNS3 pmu.
>>>
>> I'm a bit confused here. We need to update the using CPU and migrate 
>> the perf
>> context as well as the interrupt affinity in cpuhp::teardown() 
>> callback, so
>> it make sense to not call this on driver detachment. But I cannot figure
>> out why this is related to the shared interrupt, more details?
>>
> ok，I will send v2 to add more details.

This shouldn't have anything to do with concurrency or shared interrupts 
or anything else. It's simply that we should clearly not attempt to 
migrate a PMU context (via invoking the hotplug callbacks) *after* the 
relevant PMU has already been unregistered, since that's liable to lead 
to some kind of use-after-free, and at best it's just a pointless waste 
of time anyway - if we've got to the point of unbinding the driver (or 
failing to probe at all), there should definitely not be any active 
events or other PMU state that needs updating.

Thanks,
Robin.
