Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3767752E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjHIGbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjHIGbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:31:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ACB10DC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:31:12 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLKsy1hLWzmV69;
        Wed,  9 Aug 2023 14:29:58 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 14:31:09 +0800
CC:     <yangyicong@hisilicon.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH] perf/smmuv3: Add platform id table for module auto
 loading
To:     Barry Song <21cnbao@gmail.com>, Liang Li <liliang6@email.cn>
References: <20230807122233.28563-1-yangyicong@huawei.com>
 <ZNL9s92HjLy+MZTw@localhost>
 <CAGsJ_4z5kYWOa2L+BHypM4S6W_UhUfUe3wo2rwiy0u7Hf1Q5pw@mail.gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <23fe3d9a-cb4d-3479-0581-eefec193bc72@huawei.com>
Date:   Wed, 9 Aug 2023 14:31:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAGsJ_4z5kYWOa2L+BHypM4S6W_UhUfUe3wo2rwiy0u7Hf1Q5pw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry, Liang,

On 2023/8/9 13:47, Barry Song wrote:
> On Wed, Aug 9, 2023 at 1:01 PM Liang Li <liliang6@email.cn> wrote:
>>
>> On 2023-08-07 20:22, Yicong Yang <yangyicong@huawei.com> wrote:
>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>
>>> On ACPI based system the device is probed by the name directly. If the
>>> driver is configured as module it can only be loaded manually. Add the
>>> platform id table as well as the module alias then the driver will be
>>> loaded automatically by the udev or others once the device added.
>>>
>>
>> Please consider revise the long log to clearly express the purpose of the
>> changes in this patch:
>>
>> - What's the exact issue the patch is addressing
>> - Why the changes in this patch can fix the issue or make something working
>> - Consider impact of the changes introduced by this patch
>>
>> These info may help reviewers and maintainers .. and yourself on code merge.
> 
> years ago, i found a good doc regarding this,
> https://wiki.archlinux.org/title/Modalias
> 
> guess it is because /lib/modules/$(uname -r)/modules.alias fails to contain smmu
> driver without the MODULE_DEVICE_TABLE, isn't it, yicong？

Yes I think it's the reason. I didn't find summary in kernel docs for the modalias
as well as the uevent mechanism. Arch wiki has a well illustration for the modalias
and suse[1] describes how this is used by the udev for module auto loading.

For my case I'm using a ACPI based arm64 server and after booting the arm_smmuv3_pmu.ko
is not auto loaded by the udevd since we aren't providing this information. In order
to support this we need to provide this MODULE_DEVICE_TABLE() when the smmu pmu added
as a platform device, then the userspace udev can know which module to load after the
device is added.

[1] https://documentation.suse.com/sles/15-SP1/html/SLES-all/cha-udev.html#sec-udev-drivers

Thanks.
