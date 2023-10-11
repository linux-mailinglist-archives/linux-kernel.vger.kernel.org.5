Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED94B7C4D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjJKIh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjJKIhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:37:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D642A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:37:52 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S55dt2kC0zLqJ0;
        Wed, 11 Oct 2023 16:33:54 +0800 (CST)
Received: from [192.168.98.200] (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 11 Oct 2023 16:37:49 +0800
Message-ID: <9579f762-24ce-0826-dc7b-2c79c969f192@huawei.com>
Date:   Wed, 11 Oct 2023 16:37:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <chenhao418@huawei.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH drivers/perf: hisi:] drivers/perf: hisi: fix NULL pointer
 issue when uninstall hns3 pmu driver
To:     Yicong Yang <yangyicong@huawei.com>, <will@kernel.org>,
        <jonathan.cameron@huawei.com>, <mark.rutland@arm.com>,
        <yangyicong@hisilicon.com>
References: <20231009105038.126040-1-shaojijie@huawei.com>
 <504cc838-d587-8bd0-601e-85f11b69c72b@huawei.com>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <504cc838-d587-8bd0-601e-85f11b69c72b@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/10/10 17:32, Yicong Yang wrote:
> Hi Jijie,
>
> On 2023/10/9 18:50, Jijie Shao wrote:
>> From: Hao Chen <chenhao418@huawei.com>
>>
>> When uninstall hns3 pmu driver, it will call cpuhp_state_remove_instance()
>> and then callback function hns3_pmu_offline_cpu() is called, it may cause
>> NULL pointer call trace when other driver is installing or uninstalling
>> concurrently.
>>
> More information about the calltrace you've met and how to reproduce this?
> I'm not sure why other drivers are involved.
>
>> As John Garry's opinion, cpuhp_state_remove_instance() is used for shared
>> interrupt, and using cpuhp_state_remove_instance_nocalls() is fine for PCIe
>> or HNS3 pmu.
>>
> I'm a bit confused here. We need to update the using CPU and migrate the perf
> context as well as the interrupt affinity in cpuhp::teardown() callback, so
> it make sense to not call this on driver detachment. But I cannot figure
> out why this is related to the shared interrupt, more details?
>
ok，I will send v2 to add more details.
Thanks

