Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C7812ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444043AbjLNLk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444157AbjLNLk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:40:28 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB13118
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:39:53 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SrVk000M6zvS8x;
        Thu, 14 Dec 2023 19:39:03 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
        by mail.maildlp.com (Postfix) with ESMTPS id 028181800BB;
        Thu, 14 Dec 2023 19:39:52 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 19:39:51 +0800
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        <catalin.marinas@arm.com>, <sudeep.holla@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <dietmar.eggemann@arm.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <yangyicong@hisilicon.com>
Subject: Re: [PATCH v4 0/4] Support SMT control on arm64
To:     Will Deacon <will@kernel.org>
References: <20231121092602.47792-1-yangyicong@huawei.com>
 <20231211131612.GB25681@willie-the-truck>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <fe03425c-6b9a-f0eb-0e8d-e0f47404a7cb@huawei.com>
Date:   Thu, 14 Dec 2023 19:39:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20231211131612.GB25681@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2023/12/11 21:16, Will Deacon wrote:
> On Tue, Nov 21, 2023 at 05:25:58PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The core CPU control framework supports runtime SMT control which
>> is not yet supported on arm64. Besides the general vulnerabilities
>> concerns we want this runtime control on our arm64 server for:
>>
>> - better single CPU performance in some cases
>> - saving overall power consumption
>>
>> This patchset implements it in the following aspects:
>>
>> - implements the basic support in arch_topology driver
>> - support retrieve SMT thread number on OF based system
>> - support retrieve SMT thread number on ACPI based system
>> - select HOTPLUG_SMT for arm64
>>
>> Tests has been done on our real ACPI based arm64 server and on
>> ACPI/OF based QEMU VMs.
>>
>> The patchset is based on v6.7-rc1.
>>
>> Change since v3:
>> - Fix some build and kconfig error reported by kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/linux-arm-kernel/20231114040110.54590-1-yangyicong@huawei.com/
>>
>> Change since v2:
>> - Detect SMT thread number at topology build from ACPI/DT, avoid looping CPUs
>> - Split patches into ACPI/OF/arch_topology path and enable the kconfig for arm64
>> Link: https://lore.kernel.org/linux-arm-kernel/20231010115335.13862-1-yangyicong@huawei.com/
>>
>> Yicong Yang (4):
>>   arch_topology: Support basic SMT control for the driver
>>   arch_topology: Support SMT control for OF based system
> 
> Looking at the first two patches you have here, they are incredibly trivial
> and feel like they'd be better off implemented as the default behaviour in
> the core code so that architectures with additional constraints (e.g. x86)
> can override that.
> 

Loop Thomas and Peter in and expect some hint on the SMT HOTPLUG implementation.

Thanks for the comments. I'm a bit uncertain of some points.

Currently the framework requires the architeture provide 2 things to enable HOTPLUG_SMT:
1. In the init stage of the arch code, use cpu_smt_set_num_threads() to tell the framework
   SMT is supported or not and how many threads are within a core.
2. topology_is_primary_thread() to indicate one CPU can be offline or not, when disable SMT.

For the 2nd point, it's possible to provide a weak function in the framework if no special
requirement for the "primary" SMT thread, just make the 1st CPU in a physical core as the
primary thread like what implemented in this patchset for amr64. And let architectures like
x86/powerpc to provides override function for special purpose.

For the 1st point I'm not sure it could/should be done in the framework since we can got this
SMT information only in the init stage after we parsing the topology which is rather architecture
specific. On arm64 we may gain this after parsing the devicetree or ACPI and on x86 they gain
this by CPUID. It's hard to provide a default way for detecting this. So in this patchset the
SMT information is detected separately in the ACPI/OF topology parsing.

Thanks.

