Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D436B77F3F9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349109AbjHQJ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbjHQJ7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:59:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0384C2D61
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:59:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC276D75;
        Thu, 17 Aug 2023 03:00:10 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 735793F64C;
        Thu, 17 Aug 2023 02:59:28 -0700 (PDT)
Message-ID: <777eda70-d8e6-9f46-52dd-80beed3f0c18@arm.com>
Date:   Thu, 17 Aug 2023 10:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] coresight: trbe: Fix TRBE potential sleep in
 atomic context
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, hejunhao3@huawei.com
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jonathan.cameron@huawei.com,
        mike.leach@linaro.org, linuxarm@huawei.com, yangyicong@huawei.com,
        prime.zeng@hisilicon.com
References: <20230814093813.19152-1-hejunhao3@huawei.com>
 <20230816141008.535450-1-suzuki.poulose@arm.com>
 <80ef7a87-6adf-27bc-43ae-05ae5680e418@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <80ef7a87-6adf-27bc-43ae-05ae5680e418@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 08:13, Anshuman Khandual wrote:
> Hello Junhao,
> 
> On 8/16/23 19:40, Suzuki K Poulose wrote:
>> From: Junhao He <hejunhao3@huawei.com>
>>
>> smp_call_function_single() will allocate an IPI interrupt vector to
>> the target processor and send a function call request to the interrupt
>> vector. After the target processor receives the IPI interrupt, it will
>> execute arm_trbe_remove_coresight_cpu() call request in the interrupt
>> handler.
>>
>> According to the device_unregister() stack information, if other process
>> is useing the device, the down_write() may sleep, and trigger deadlocks
>> or unexpected errors.
>>
>>    arm_trbe_remove_coresight_cpu
>>      coresight_unregister
>>        device_unregister
>>          device_del
>>            kobject_del
>>              __kobject_del
>>                sysfs_remove_dir
>>                  kernfs_remove
>>                    down_write ---------> it may sleep
> 
> But how did you really detect this problem ? Does this show up as an warning when
> you enable lockdep debug ? OR it really happened during a real workload execution
> followed by TRBE module unload. Although the problem seems plausible (which needs
> fixing), just wondering how did we trigger this.

I was able to trigger this with just :

modprobe coresight-trbe; modprobe -r coresight-trbe;

With all the bells and whistles enabled in the kernel.

Suzuki
