Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70CA7FE96A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 07:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344658AbjK3G4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 01:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3G4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 01:56:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADB01AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 22:56:36 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sgn5s1kMszvRM8;
        Thu, 30 Nov 2023 14:56:01 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 14:56:33 +0800
CC:     <yangyicong@hisilicon.com>, <dietmar.eggemann@arm.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] Support SMT control on arm64
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>
References: <20231121092602.47792-1-yangyicong@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <5b4f8398-f508-86b1-b454-4a7c5a53496f@huawei.com>
Date:   Thu, 30 Nov 2023 14:56:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20231121092602.47792-1-yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep, Catalin, Will and ARM folks,

Any comments? Appreciate for any feedbacks.

Thanks.

On 2023/11/21 17:25, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The core CPU control framework supports runtime SMT control which
> is not yet supported on arm64. Besides the general vulnerabilities
> concerns we want this runtime control on our arm64 server for:
> 
> - better single CPU performance in some cases
> - saving overall power consumption
> 
> This patchset implements it in the following aspects:
> 
> - implements the basic support in arch_topology driver
> - support retrieve SMT thread number on OF based system
> - support retrieve SMT thread number on ACPI based system
> - select HOTPLUG_SMT for arm64
> 
> Tests has been done on our real ACPI based arm64 server and on
> ACPI/OF based QEMU VMs.
> 
> The patchset is based on v6.7-rc1.
> 
> Change since v3:
> - Fix some build and kconfig error reported by kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-arm-kernel/20231114040110.54590-1-yangyicong@huawei.com/
> 
> Change since v2:
> - Detect SMT thread number at topology build from ACPI/DT, avoid looping CPUs
> - Split patches into ACPI/OF/arch_topology path and enable the kconfig for arm64
> Link: https://lore.kernel.org/linux-arm-kernel/20231010115335.13862-1-yangyicong@huawei.com/
> 
> Yicong Yang (4):
>   arch_topology: Support basic SMT control for the driver
>   arch_topology: Support SMT control for OF based system
>   arm64: topology: Support SMT control on ACPI based system
>   arm64: Kconfig: Enable HOTPLUG_SMT
> 
>  arch/arm64/Kconfig            |  1 +
>  arch/arm64/kernel/topology.c  | 23 ++++++++++++++++++
>  drivers/base/arch_topology.c  | 45 +++++++++++++++++++++++++++++++++++
>  include/linux/arch_topology.h | 14 +++++++++++
>  4 files changed, 83 insertions(+)
> 
