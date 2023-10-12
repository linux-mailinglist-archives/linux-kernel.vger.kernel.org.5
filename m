Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7B17C6E58
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378247AbjJLMjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377488AbjJLMiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:38:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FBFC4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:38:49 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S5pxM684rz1kv48;
        Thu, 12 Oct 2023 20:34:47 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 12 Oct 2023 20:38:46 +0800
CC:     <chenhao418@huawei.com>, <shenjian15@huawei.com>,
        <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH drivers/perf: hisi:] drivers/perf: hisi: fix NULL pointer
 issue when uninstall hns3 pmu driver
To:     Robin Murphy <robin.murphy@arm.com>,
        Jijie Shao <shaojijie@huawei.com>, <will@kernel.org>,
        <jonathan.cameron@huawei.com>, <mark.rutland@arm.com>,
        <yangyicong@hisilicon.com>
References: <20231009105038.126040-1-shaojijie@huawei.com>
 <504cc838-d587-8bd0-601e-85f11b69c72b@huawei.com>
 <9579f762-24ce-0826-dc7b-2c79c969f192@huawei.com>
 <8fe4484c-57ed-477a-8ac1-e73b4a9cb3da@arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <dadf1e3b-7fa5-a218-4695-f617f639d878@huawei.com>
Date:   Thu, 12 Oct 2023 20:38:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <8fe4484c-57ed-477a-8ac1-e73b4a9cb3da@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2023/10/12 0:03, Robin Murphy wrote:
> On 11/10/2023 9:37 am, Jijie Shao wrote:
>>
>> on 2023/10/10 17:32, Yicong Yang wrote:
>>> Hi Jijie,
>>>
>>> On 2023/10/9 18:50, Jijie Shao wrote:
>>>> From: Hao Chen <chenhao418@huawei.com>
>>>>
>>>> When uninstall hns3 pmu driver, it will call cpuhp_state_remove_instance()
>>>> and then callback function hns3_pmu_offline_cpu() is called, it may cause
>>>> NULL pointer call trace when other driver is installing or uninstalling
>>>> concurrently.
>>>>
>>> More information about the calltrace you've met and how to reproduce this?
>>> I'm not sure why other drivers are involved.
>>>
>>>> As John Garry's opinion, cpuhp_state_remove_instance() is used for shared
>>>> interrupt, and using cpuhp_state_remove_instance_nocalls() is fine for PCIe
>>>> or HNS3 pmu.
>>>>
>>> I'm a bit confused here. We need to update the using CPU and migrate the perf
>>> context as well as the interrupt affinity in cpuhp::teardown() callback, so
>>> it make sense to not call this on driver detachment. But I cannot figure
>>> out why this is related to the shared interrupt, more details?
>>>
>> ok，I will send v2 to add more details.
> 
> This shouldn't have anything to do with concurrency or shared interrupts or anything else. It's simply that we should clearly not attempt to migrate a PMU context (via invoking the hotplug callbacks) *after* the relevant PMU has already been unregistered, since that's liable to lead to some kind of use-after-free, and at best it's just a pointless waste of time anyway - if we've got to the point of unbinding the driver (or failing to probe at all), there should definitely not be any active events or other PMU state that needs updating.
> 

Thanks for the clarification. I think this is the root reason
of the problem met on the hns3 pmu.

Thanks.
