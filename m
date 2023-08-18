Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119E5780B51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376480AbjHRLnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376446AbjHRLmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:42:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C71F42112
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 04:42:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08DA1D75;
        Fri, 18 Aug 2023 04:43:11 -0700 (PDT)
Received: from [10.57.4.78] (unknown [10.57.4.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BFEE3F762;
        Fri, 18 Aug 2023 04:42:29 -0700 (PDT)
Message-ID: <ca37adae-5e06-3003-c5b5-3146001d7d37@arm.com>
Date:   Fri, 18 Aug 2023 12:42:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] coresight: Fix memory leak in acpi_buffer->pointer
To:     James Clark <james.clark@arm.com>,
        Junhao He <hejunhao3@huawei.com>, mike.leach@linaro.org,
        leo.yan@linaro.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, yangyicong@huawei.com,
        prime.zeng@hisilicon.com
References: <20230817085937.55590-1-hejunhao3@huawei.com>
 <20230817085937.55590-2-hejunhao3@huawei.com>
 <1d38e877-35ed-5f70-e51f-ea875deab903@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1d38e877-35ed-5f70-e51f-ea875deab903@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 15:03, James Clark wrote:
> 
> 
> On 17/08/2023 09:59, Junhao He wrote:
>> There are memory leaks reported by kmemleak:
>> ...
>> unreferenced object 0xffff00213c141000 (size 1024):
>>    comm "systemd-udevd", pid 2123, jiffies 4294909467 (age 6062.160s)
>>    hex dump (first 32 bytes):
>>      04 00 00 00 02 00 00 00 18 10 14 3c 21 00 ff ff  ...........<!...
>>      00 00 00 00 00 00 00 00 03 00 00 00 10 00 00 00  ................
>>    backtrace:
>>      [<000000004b7c9001>] __kmem_cache_alloc_node+0x2f8/0x348
>>      [<00000000b0fc7ceb>] __kmalloc+0x58/0x108
>>      [<0000000064ff4695>] acpi_os_allocate+0x2c/0x68
>>      [<000000007d57d116>] acpi_ut_initialize_buffer+0x54/0xe0
>>      [<0000000024583908>] acpi_evaluate_object+0x388/0x438
>>      [<0000000017b2e72b>] acpi_evaluate_object_typed+0xe8/0x240
>>      [<000000005df0eac2>] coresight_get_platform_data+0x1b4/0x988 [coresight]
>> ...
>>
>> The ACPI buffer memory (buf.pointer) should be freed. But the buffer
>> is also used after returning from acpi_get_dsd_graph().
>> Move the temporary variables buf to acpi_coresight_parse_graph(),
>> and free it before the function return to prevent memory leak.
>>
>> Fixes: 76ffa5ab5b79 ("coresight: Support for ACPI bindings")
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> 
> I confirmed that the error gone. Thanks for the fix.
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Queued:

https://git.kernel.org/coresight/c/1a9e02673e25

Thanks!

Suzuki

